Some notes on using mwSynGen to create a highlighter for mwEdit
===============================================================

This is not a replacement for a mwSynGen documentation, just a short attempt to
help you get started with developing a new highlighter for mwEdit.

mwSynGen uses MSG files to create highlighters.  The MSG files in the Grammars
directory may however create highlighters that do *not* compile without changes
to the created sourcecode.  If your highlighter has to support ranges it will 
be necessary to make modifications before you can compile the code.  
"Ranges" can be used to implement things like multiline comments or embedded 
snippets of text that has different highlighting rules (for example embedded 
assembler source in a C or Pascal source file).

We will create a small highlighter that shows the basics, then we will add a
multiline comment to illustrate the use of ranges and the necessary changes to
the source after mwSynGen has done its magic.

--------------------------------------------------------------------------------

First of all:  Don't use mwSynGen if the language has no keywords to recognize.
A big part of the code mwSynGen creates deals with the fast recognition of
keywords among the identifier strings.  If this is not the case you should use
mwGeneralSyn as the starting point of your highlighter, and just edit the source
code of this generic highlighter.  You would have to make major modifications to
a mwSynGen generated source file to get it to compile with Delphi (or at least
to remove all obsolete methods) when there are no keyword and identifier token
kinds.

--------------------------------------------------------------------------------

STEP 1:
The highlighter should recognize the keyword "mwEdit" without case sensitivity.
Keywords should use a bold font.  The other identifiers should use a blue font.
"//" should start a comment that ends at the end of the line.  Comments should
use an italic font.
#0 is the end of text.  This has to be in every highlighter.  Everything in the
range #1..#32 is considered a whitespace.

The MSG file can be found in Sample1.msg.  mwSynGen creates a Sample1.pas file
that compiles OK.  There are however things to be done:  Adding of default
token attributes (font colors and styles).  Adding a file header ;-)
All manual changes are lost when mwSynGen creates a new version of the source,
so it is better to leave this until the basic work on the highlighter is done.

--------------------------------------------------------------------------------

STEP2:
The following additions and changes are to be made:
The highlighter should recognize the keywords "mwEdit" and "mwEDIT", but now
case sensitive.
Everything inside of double quotes is considered to be a string or char.
The char " itself can be embedded in a string by inserting "" in this string.
Strings should use a green font.
Everything between "/*" and "*/" is a comment, which can end on a different
line, so a range for comments has to be used.

The updated MSG file is Sample2.msg.  The resulting Pascal source file does not
compile however, because the CommentProc procedure is missing.  The code is in
another method of the highlighter, because when we are inside of a multi line
comment we will have to execute the same code from the start of the line.
Common code should go into procedures, but unfortunately mwSynGen does not
support this (yet).

--------------------------------------------------------------------------------

STEP3:
Sample3.pas is the updated Sample2.pas after all necessary changes are made.
Changes are commented with "// manual change" so it should be easy to find them.

For more information on the matter see the source code of the 20+ highlighters
in the package ;-)

---
Michael Hieke, 1999-12-03
