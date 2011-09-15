#include "my-types.h"
#include "my-ctype.h"
#include "my-string.h"
#include "my-stdlib.h"
#include <string.h>
#include <limits.h>

#include "ansistuff.h"
#include "bf_register.h"
#include "functions.h"
#include "structures.h"
#include "utils.h"
#include "storage.h"
#include "streams.h"
#include "server.h"
#include "db.h"
#include "log.h"

/* Builtin function notify_ansi(OBJ conn, STR ansi-str [, ANY add-eol [, ANY no-flush]])
   parses ansi-str, replacing the codes bij ansi-escape-sequences,
   and notifies it.
   add-eol:  <0: don't add eol, 0: let parser decide, >0: add eol
   
   Builtin function parse_ansi(STR ansi-str, ANY clean)
   returns the binary encoded string the parser returns
   if (clean), returns the string with codes removed
   
   Builtin function load_ansi_options()
   Loads the options set on $server_options.ansi_options.server_options
*/

const char 
*get_ansi_string_option(const char *option, const char *defallt, const char *validchars, int *succes) 
{
	Var r;
	const char *c;
	int l;
	
	if (get_server_option(ansiobj, option, &r) && 
		r.type == TYPE_STR && *r.v.str)
		if ((c=binary_to_raw_bytes(r.v.str, &l)) && strlen(c)==l)
			if (!(validchars && *validchars) || ((*validchars=='!' && validchars[1]) ? strcspn(c, validchars+1) :  strspn(c, validchars)) == strlen(c)) {
				/* The prop exists, has a non-empty binary-encoded 
				 * string value, and doesn't contain null chars after
				 * decoding, nor 'invalid' chars */
				*succes=1; 
				return c;
			};
			 
	*succes=0;
	oklog("    (nonexistent or invalid %s, using default)\n",option);		 
	return defallt;
}

/* Hmm... should we set the options to default if not correctly set in-db,
 * or leave them unchanged?? */
 
void
load_ansi_default_options(void) {
	Var r,s;
	int len;
	keycodepair *kcp=0;
	keyasciipair *kap=0;
		
	oklog("    Loading ansi_default_options:\n");
	oklog("      Loading style substitutions:\n");
	if (get_server_option(ansiobj, "ansi_styles", &r) && r.type == TYPE_LIST) {
		int i=1, l=0;
		
		kcp=mymalloc((len=r.v.list[0].v.num)*sizeof(keycodepair), M_STRING_PTRS);
		
		for (; i<=len; i++) 
			if ((s=r.v.list[i]).type == TYPE_LIST && s.v.list[0].v.num > 1 &&
				s.v.list[1].type == TYPE_STR && *(s.v.list[1].v.str) &&
				s.v.list[2].type == TYPE_STR && *(s.v.list[2].v.str)  &&
				strlen(s.v.list[1].v.str)==strcspn(s.v.list[1].v.str,
				  "`~!@#$%^&*()=+[]\\{}|;:'\",.<>/?") && strlen(s.v.list[2].v.str)==
				  strspn(s.v.list[2].v.str,"0123456789")) {
				kcp[l].keyw = str_dup(s.v.list[1].v.str);
				kcp[l].code = str_dup(s.v.list[2].v.str);
				oklog("        %d: \"%s\" -> \"%s\"\n",l+1,kcp[l].keyw,kcp[l].code);
				l++; 
			}
		kcp = myrealloc(kcp, (len=l)*sizeof(keycodepair), M_STRING_PTRS);	
	} else {
		int i=0;
		
		kcp = mymalloc((len = sizeof(ansi_default_styles)/sizeof(keycodepair))
			*sizeof(keycodepair), M_STRING_PTRS);
		oklog("        (Using default values)\n");
		for (; i<len; i++) {
			kcp[i].keyw = str_dup(ansi_default_styles[i].keyw);
			kcp[i].code = str_dup(ansi_default_styles[i].code);
			oklog("        %d: \"%s\" -> \"%s\"\n",i+1,kcp[i].keyw,kcp[i].code);
		}
	}
	oklog("      Done loading style substitutions\n");
	if (ansi_style_subs) {
		int i=0;
		for (; i<ansi_code_style_keyws; i++) {
			free_str(ansi_style_subs[i].keyw);
			free_str(ansi_style_subs[i].code);
		}
		myfree(ansi_style_subs, M_STRING_PTRS);
	}
	ansi_code_style_keyws=len;
	ansi_style_subs=kcp;
	
	oklog("      Loading ascii substitutions:\n");
	if (get_server_option(ansiobj, "ansi_asciis", &r) && r.type == TYPE_LIST) {
		int i=1, l=0;
		
		kap=mymalloc((len=r.v.list[0].v.num)*sizeof(keyasciipair), M_STRING_PTRS);
		
		for (; i<=len; i++) 
			if ((s=r.v.list[i]).type == TYPE_LIST && s.v.list[0].v.num > 1 &&
				s.v.list[1].type == TYPE_STR && *(s.v.list[1].v.str) &&
				s.v.list[2].type == TYPE_INT && s.v.list[2].v.num > 0 &&
				s.v.list[2].v.num < 255 &&
				strlen(s.v.list[1].v.str)==strcspn(s.v.list[1].v.str,
				"`~!@#$%^&*()=+[]\\{}|;:'\",./<>?")) {
				kap[l].keyw = str_dup(r.v.list[i].v.list[1].v.str);
				kap[l].code = (char) r.v.list[i].v.list[2].v.num;
				oklog("        %d: \"%s\" -> %d\n",l+1,kap[l].keyw,(int) kap[l].code);
				l++; 
			}
		kap = myrealloc(kap, (len=l)*sizeof(keyasciipair), M_STRING_PTRS);	
	} else {
		int i=0;
		
		kap=mymalloc((len = sizeof(ansi_default_asciis)/sizeof(keyasciipair))*sizeof(keyasciipair), M_STRING_PTRS);
		oklog("        (Using default values)\n");
		for (; i<len; i++) {
			kap[i].keyw = str_dup(ansi_default_asciis[i].keyw);
			kap[i].code = ansi_default_asciis[i].code;
			oklog("        %d: \"%s\" -> %d\n",i+1,kap[i].keyw,kap[i].code);
		}
	}
	oklog("      Done loading ascii substitutions\n");
	if (ansi_ascii_subs) {
		int i=0;
		for (; i<ansi_code_ascii_keyws; i++) {
			free_str(ansi_ascii_subs[i].keyw);
		}
		myfree(ansi_ascii_subs, M_STRING_PTRS);
	}
	ansi_code_ascii_keyws=len;
	ansi_ascii_subs=kap;
	
	oklog("    Done loading ansi_default_options\n");
}

void
load_ansi_literal_options(void) {
	Var r;
	
	oklog("    Loading ansi_literal_options:\n");
	ansi_allow_literal = (get_server_option(ansiobj, "ansi_allow_literal", &r) ?
		is_true(r) : ANSI_ALLOW_LITERAL);
	oklog("      ansi_allow_literal: %d\n", ansi_allow_literal);
	oklog("    Done loading ansi_literal_options\n");
	
}

void
load_ansi_ascii_options(void) {
	Var r;
	
	oklog("    Loading ansi_ascii_options:\n");
	ansi_allow_ascii = (get_server_option(ansiobj, "ansi_allow_ascii", &r) ?
		is_true(r) : ANSI_ALLOW_ASCII);
	oklog("      ansi_allow_ascii: %d\n", ansi_allow_ascii);
	oklog("    Done loading ansi_ascii_options\n");
}

void
load_ansi_style_options(void) {
}
		 
void 
load_ansi_options(void) {
	/* Load ansi options */
	const char *tempstart, *tempstartq, *temp;
	Var r;
	int succes, i;
	
	if (get_server_option(SYSTEM_OBJECT, "ansi_options", &r) && 
		r.type == TYPE_OBJ && valid(r.v.obj)) 
		/* $server_options.ansi_options is an existing object 
		 * $server_options.ansi_options.server_options should 
		 * point to $server_options.ansi_options self */
		ansiobj = r.v.obj;
	else
		ansiobj = SYSTEM_OBJECT; /* setting it to NOTHING would be more efficient */
		
			
	oklog("Loading ansi-options on object #%d:\n",ansiobj);
	
	tempstart = get_ansi_string_option("ansi_code_start", ANSI_CODE_START,ANSI_CODE_START_ALLCHARS,&succes);
	tempstartq = get_ansi_string_option("ansi_code_start_q", ANSI_CODE_START_Q,ANSI_CODE_START_ALLCHARS,&succes);
	if (ansi_code_start) free_str(ansi_code_start);
	if (ansi_code_start_q) free_str(ansi_code_start_q);
	if (strstr(tempstartq, tempstart)) {
		ansi_code_start = str_dup(tempstart);
		ansi_code_start_q = str_dup(tempstartq);
	} else {
		oklog("    invalid combination of code start and quote:\n");
		oklog("       start: \"%s\"   quote: \"%s\"\n",tempstart, tempstartq);
		oklog("    using default values:\n");
		ansi_code_start = str_dup(ANSI_CODE_START);
		ansi_code_start_q = str_dup(ANSI_CODE_START_Q);
	}	
	ansi_code_start_l = strlen(ansi_code_start);
	ansi_code_start_q_l = strlen(ansi_code_start_q);
	oklog("    ansi_code_start: \"%s\"\n",ansi_code_start);
	oklog("    ansi_code_start_q: \"%s\"\n",ansi_code_start_q);
	
	temp = get_ansi_string_option("ansi_code_end",ANSI_CODE_END,ANSI_CODE_END_ALLCHARS,&succes);
	if (ansi_code_end) free_str(ansi_code_end);
	ansi_code_end = str_dup(temp);
	ansi_code_end_l = strlen(ansi_code_end);
	oklog("    ansi_code_end: \"%s\"\n",ansi_code_end);
	
	temp = get_ansi_string_option("ansi_code_sep", ANSI_CODE_SEP,ANSI_CODE_SEP_ALLCHARS,&succes);
	if (ansi_code_sep) free_str(ansi_code_sep);
	ansi_code_sep = str_dup(temp);
	oklog("    ansi_code_sep: \"%s\"\n", ansi_code_sep);

	for (i=0;i<=ANSI_CODE_PARSE_KEYS;i++) 
		(*(ansi_option_functions[i]))();
			
	oklog("Done loading ansi-options\n");	
	ansi_options_loaded = 1;
	
}	
		
char ansi_parse_as_char(char *code) {
	int n;
	char *end=0;
	if (!code || !*code)
		return 0;
	n=strtol(code,&end,0);
	if (*end)
		return 0;
	if (n<0 || n>255)
		return 0;
	return (char) n;
}

void ansi_parse_literal(Stream *s, char *codes) {
	if (!ansi_allow_literal)
		return;
	if (!codes || !*codes) 
		return;
	stream_add_string(s, ANSI_CODE_PREFIX);
	stream_add_string(s, codes);
	stream_add_string(s, ANSI_CODE_SUFFIX);
}

void ansi_parse_default(Stream *s, char *codes) {
	/* Try to parse it as style or ascii */
	char *cur=0, *ctemp=codes;
	int soa=0, numcodes=0;
	
	if (!codes || !*codes)
		return;
			
	while ((cur=strtok(ctemp, ansi_code_sep))) {
			int i=0;
			ctemp=NULL;
			for (;soa>=0 && i<ansi_code_style_keyws;i++) 
				if (!strcasecmp(cur, ansi_style_subs[i].keyw)) {
					soa=1;
					if (!numcodes)  stream_add_string(s, ANSI_CODE_PREFIX);
					if (numcodes++) stream_add_string(s, ANSI_CODE_STYLE_SEP);
					stream_add_string(s, ansi_style_subs[i].code);
					break;
				}
			for (i=0;soa<=0 && i<ansi_code_ascii_keyws;i++)
				if (!strcasecmp(cur, ansi_ascii_subs[i].keyw)) {
					soa=-1;
					stream_add_char(s, ansi_ascii_subs[i].code);
					break;
				}						
	}
	if (soa>0 && numcodes) {
		stream_add_string(s, ANSI_CODE_STYLE_SUFFIX);
		stream_add_string(s, ANSI_CODE_SUFFIX);
	}
}


void ansi_parse_styles(Stream *s, char *codes) {
	char *cur=0, *ctemp=codes;
	int numcodes=0;
	
	if (!codes || !*codes)
		return;

	while ((cur=strtok(ctemp, ansi_code_sep))) {
			int i=0;
			ctemp=NULL;
			for (;i<ansi_code_style_keyws;i++) 
				if (!strcasecmp(cur, ansi_style_subs[i].keyw)) {
					if (!numcodes) stream_add_string(s, ANSI_CODE_PREFIX);
					if (numcodes++) stream_add_string(s, ANSI_CODE_STYLE_SEP);
					stream_add_string(s, ansi_style_subs[i].code);
					break;
				}		
	}
	if (numcodes) {
		stream_add_string(s, ANSI_CODE_STYLE_SUFFIX);
		stream_add_string(s, ANSI_CODE_SUFFIX);
	}
}

	
	
void ansi_parse_ascii(Stream *s, char *codes) {
	char *cur=0,*ctemp=codes;
	
	if (!codes && !*codes)
		return;

	while ((cur=strtok(ctemp, ansi_code_sep))) {
			int i=0, f=0;
			ctemp=NULL;
			for (;i<ansi_code_ascii_keyws;i++) 
				if ((f=!strcasecmp(cur, ansi_ascii_subs[i].keyw))) {
					stream_add_char(s, ansi_ascii_subs[i].code);
					break;
				}		
			if (!f && ansi_allow_ascii) {
				/* Try to parse it as a (hexadecimal?) number */
				char c = ansi_parse_as_char(cur);
				if (c)
					/* Allowing '\0' chars might break parts of the code? */
					stream_add_char(s, c);
			}
	}

}		
		 
const char *
parse_ansi_string(const char *unparsed, int *length, int *add_eol, int clean)
{
	static Stream *s = 0;
	const char *cur = unparsed, *t=0;
	char *cs=0, *cqs=0, *ce=0;
	int just_codes=(int) *unparsed;
	
	if (!ansi_options_loaded) {
		oklog("ansi options were not loaded. Loading now...\n");
		load_ansi_options();
		if (!ansi_options_loaded)
			return 0;
	}
			
	if (!s)
		s = new_stream(100);
	else
		reset_stream(s);
		
	while (*cur) {
		if (!(cs=strstr(cur, ansi_code_start))) {
			/* no further ansi codes in string */
			stream_add_string(s, cur);
			just_codes=0;
			break;
		} else if (!(ce=strstr(cs+ansi_code_start_l, ansi_code_end))) {
			/* if there's no end, there are no codes */
			stream_add_string(s,cur);
			just_codes=0;
			break;
		} else if ((cqs=strstr(cur, ansi_code_start_q))  && cqs <= cs) {
			/* cs/cqs is a quoted ansi code start
			  A stream_add_nstring would come in handy... */
			for (t=cur; t<cqs; t++) 
				stream_add_char(s,*t);
			stream_add_string(s, ansi_code_start);
			cur=cqs+ansi_code_start_q_l;
			just_codes=0;
		} else if (cs+ansi_code_start_l == ce) {
			/* No codes? */
			for (t=cur; t<cs; t++)
				stream_add_char(s, *t);
			cur=ce+ansi_code_end_l;
			just_codes=just_codes && cur>=cs;
		} else if (clean) {
			/* Don't parse, just remove the codes */
			for (t=cur; t<cs; t++)
				stream_add_char(s, *t);
			cur = ce+ansi_code_end_l;
		} else {
			/* So, the part cs+START_L..ce contains ansi-codes */
			int l=ce-(cs+ansi_code_start_l);
			char *curcode=0, *orgcode=0, *restcode=0, *start=0;
			
			/* Copy all previous chars to stream */
			for (t=cur; t<cs; t++)
				stream_add_char(s, *t);
			just_codes=just_codes && cur>=cs;
			cur=ce+ansi_code_end_l;
			
			/* copy codes part into a new string */
			restcode = orgcode = mymalloc(l+1, M_STRING);
			strncpy(orgcode, start = cs+ansi_code_start_l, l);
			orgcode[l]='\0';
			
			
			/* Get the first part */
			if (!(curcode=strtok(restcode,ansi_code_sep))) {
				/* Codes part existed only of separators.. done */
			} else {
				int i, f=0;
				for (i=1; i<= ANSI_CODE_PARSE_KEYS; i++) 
					if ((f=!strcasecmp(curcode, ansi_parse_keywords[i]))) {
						restcode=(char *) ((curcode+strlen(curcode)==orgcode+l) ? orgcode+l : curcode+strlen(curcode)+1); 
						(*(ansi_parse_functions[i]))(s, restcode);
						break;
					}
				
				if (!f) {
					strncpy(orgcode, start, l);
					orgcode[l]='\0';
					restcode=orgcode;
					(*(ansi_parse_functions[0]))(s, restcode);
				}
			} 			

			myfree(orgcode, M_STRING);
		}
	}

	if (*add_eol<0 || clean) {
		/* Never add newline */
	} else if (*add_eol == 0) {
		/* Add newline if it seems useful */
		if (!just_codes)
			stream_add_string(s, ANSI_EOL);
	} else if (*add_eol > 0) {
		/* Always add newline */
		stream_add_string(s, ANSI_EOL);
	}
	*length=stream_length(s);
	*add_eol=!just_codes;
	return reset_stream(s);
}

static package
bf_parse_ansi(Var arglist, Byte next, void *vdata, Objid progr)
{
	const char *line=arglist.v.list[1].v.str, *parsed;
	int clean = (arglist.v.list[0].v.num > 1 ? 
					is_true(arglist.v.list[2]) : 0);
	int add_eol=0, length;
	Var r;
	
	parsed = parse_ansi_string(line, &length, &add_eol, clean);
	
	free_var(arglist);
	
	if (!parsed) 
		return make_error_pack(E_INVARG);
	
	r.type = TYPE_STR;
	r.v.str = str_dup(raw_bytes_to_binary(parsed, length));
	return make_var_pack(r);
}
	
static package
bf_load_ansi_options(Var arglist, Byte next, void *vdata, Objid progr)
{
	Var r;
	
	free_var(arglist);
	
	if (!is_wizard(progr))
		return make_error_pack(E_PERM);
		
	load_ansi_options();
	
	r.type = TYPE_INT;
	r.v.num = 0;
	return make_var_pack(r);
}		

void
register_ansistuff(void) {

/*  register_function("notify_ansi", 2, 4, bf_notify_ansi, TYPE_OBJ, TYPE_STR, TYPE_INT, TYPE_ANY); */
    register_function("parse_ansi", 1, 2, bf_parse_ansi, TYPE_STR, TYPE_ANY);
    register_function("load_ansi_options", 0, 0, bf_load_ansi_options);
}
 
char rcsid_extension_ansistuff[] = "$Id: extension-ansistuff.c,v 1.1 1998/06/16 21:54:47 tijmen Exp $";
