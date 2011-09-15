#include "config.h"
#include "streams.h"
#include "structures.h"

#define ANSI_ALLOW_LITERAL	0
#define ANSI_ALLOW_ASCII	0

#define ANSI_EOL		"\r\n"

#define ANSI_CODE_START		"%["
#define ANSI_CODE_START_Q	"%[["
#define ANSI_CODE_END		"]"

#define ANSI_CODE_PREFIX	"\e["
#define ANSI_CODE_SUFFIX	""

#define ANSI_CODE_SEP		";,:. \t"

#define ANSI_CODE_PARSE_KEYS	3
#define ANSI_KEYW_LITERAL	"literal"
#define ANSI_KEYW_STYLE		"style"
#define ANSI_KEYW_ASCII		"ascii"

#define ANSI_CODE_STYLE_SUFFIX	"m"
#define ANSI_CODE_STYLE_SEP	";"

#define ANSI_CODE_START_ALLCHARS "%.&^$#@![({<"
#define ANSI_CODE_END_ALLCHARS   "%]}>)"
#define ANSI_CODE_SEP_ALLCHARS   ";:,. \t/&"

typedef struct keycodepair keycodepair;
struct keycodepair {
	const char *keyw;
	const char *code;
};

typedef struct keyasciipair keyasciipair;
struct keyasciipair {
	const char *keyw;
	char code;
};

/* #define ANSI_CODE_STYLE_KEYWS 46  sizeof(ansi_default_styles)/sizeof(keycodepair) */

static const keycodepair ansi_default_styles[] = {
	/* Styles */
	{"off", "0"}, {"bold", "1"}, {"underscore", "4"}, {"blink", "5"},
	{"reverse", "7"}, {"concealed","8"}, {"bg_bold", "9"}, {"normal", "0"}, 
	/* Foreground colors */
	{"fg_black", "30"}, {"fg_red", "31"}, {"fg_green", "32"}, {"fg_yellow","33"},
	{"fg_blue","34"}, {"fg_magenta", "35"},	{"fg_cyan", "36"}, {"fg_white", "37"},
	/* Background colors */
	{"bg_black", "40"}, {"bg_red", "41"}, {"bg_green", "42"}, {"bg_yellow","43"},
	{"bg_blue","44"}, {"bg_magenta", "45"},	{"bg_cyan", "46"}, {"bg_white", "47"},
	/* Specials */
	{"detail", "1;34"}, {"exit", "1;31"}, {"verb", "1;33"}, {"nowrap", "50"}
};


/* #define ANSI_CODE_ASCII_KEYWS 3  sizeof(ansi_default_asciis)/sizeof(keyasciipair) */
static const keyasciipair ansi_default_asciis[] = {
	{"BELL", 7}, {"BEEP", 7}, {"LF", 10}, {"CR", 13}
};


static const char *ansi_parse_keywords[] = {
	"", "literal", "ascii", "style"
};
	
typedef void (*ansi_parse_func) (Stream *, char *);

void ansi_parse_literal(Stream *s, char *codes);
void ansi_parse_ascii(Stream *s, char *codes);
void ansi_parse_styles(Stream *s, char *codes);
void ansi_parse_default(Stream *s, char *codes);

static const ansi_parse_func ansi_parse_functions[] = {
	ansi_parse_default,
	ansi_parse_literal,	ansi_parse_ascii, ansi_parse_styles
};

typedef void (*ansi_option_func) (void);

void load_ansi_default_options(void);
void load_ansi_literal_options(void);
void load_ansi_ascii_options(void);
void load_ansi_style_options(void);

static const ansi_option_func ansi_option_functions[] = {
	load_ansi_default_options, load_ansi_literal_options,
	load_ansi_ascii_options, load_ansi_style_options
};


static Objid ansiobj = NOTHING;
static int ansi_options_loaded = 0;
static int ansi_allow_ascii = ANSI_ALLOW_ASCII;
static int ansi_allow_literal= ANSI_ALLOW_LITERAL;
static const char *ansi_code_start;
static int ansi_code_start_l = 0;
static const char *ansi_code_end = 0;
static int ansi_code_end_l = 0;
static const char *ansi_code_start_q = 0;
static int ansi_code_start_q_l = 0;
static const char *ansi_code_sep = 0;
static int ansi_code_style_keyws = 0;
static int ansi_code_ascii_keyws = 0;
static keycodepair *ansi_style_subs = 0;
static keyasciipair *ansi_ascii_subs = 0;

extern const char *parse_ansi_string(const char *unparsed, int *length, int *add_eol, int clean);
