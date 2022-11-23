https://powcoder.com
代写代考加微信 powcoder
Assignment Project Exam Help
Add WeChat powcoder
:- use_module(library(readutil)).



/*  As a Hokie, I, <YOUR NAME GOES HERE> ,  will conduct myself with honor and integrity at all times.  
I will not lie, cheat, or steal, nor will I accept the actions of those who do.”
*/

/*
Grammer parser and diagrammer

<sentence>    -->  <subject> <verb_phrase> <object>
<subject>     -->  <noun_phrase>
<verb_phrase> -->  <verb> | <verb> <adv>
<object>      -->  <noun_phrase>
<verb>        -->  definied in the Verbs list loaded via the definitions.pl
<adv>         -->  defined in the Adverbs list loaded via the definitions.pl
<noun_phrase> -->  [<adj_phrase>] <noun> [<prep_phrase>]
<noun>        -->  defined in the Nouns list loaded via the definitions.pl
<adj_phrase>  -->  <adj> | <adj> <adj_phrase>
<adj>         -->  defined in the Adjectives list loaded via the definitions.pl
<prep_phrase> -->  <prep> <noun_phrase>
<prep>        -->  defined in the Prepostions list loaded via the definitions.pl

*/
/* ==========================================================================================================================
Words we know are loaded using the consult.  definition.pl is the file that is loaded in the consult.
*========================================================================================================================== */

make_go_now() :- consult(definitions), read_sentence(S).

/* ==========================================================================================================================
Reading Sentences from file
*========================================================================================================================== */
read_sentence(Sentence) :- 
    read_file_to_string("input.txt", Sentence1, []),
    split_string(Sentence1," \n","\n",Sentence2),
    convert_strings_to_atoms(Sentence2,[],Sentence),
    parser(Sentence).

/* ==========================================================================================================================
Converting strings we read into atoms
*========================================================================================================================== */
convert_strings_to_atoms([],Sentence,Sentence).
convert_strings_to_atoms([Head|Tail],Builder,Sentence) :- 
    string_to_atom(Head,Atom), 
    append(Builder,[Atom],New_Builder),
    convert_strings_to_atoms(Tail,New_Builder,Sentence).

/* ==========================================================================================================================
Parsing Sentence to make diagram
*========================================================================================================================== */

parser(Sentence) :- 
    verbs(Verbs), 
    nouns(Nouns), 
    prepositions(Prepositions),
    adjectives(Adjectives),
    adverbs(Adverbs), 
    tell("output.txt",Stream),
    parse_sentence(Stream,Sentence,Diagram,[],Nouns,Verbs,Prepositions,Adjectives,Adverbs, subject),
    close(Stream),!.

/* ==========================================================================================================================
Opening file for writing
*========================================================================================================================== */
tell(File,Stream) :- open(File,write, Stream).


/* ==========================================================================================================================
Printing list either console or given stream --
*========================================================================================================================== */
print_list([]).
print_list([Head|Tail]) :- write(" "),write(Head), write(" "), print_list(Tail).

print_list([],Stream):- nl(Stream).
print_list([Head|Tail],Stream) :- write(Stream," "),write(Stream,Head), write(Stream," "), print_list(Tail,Stream).

print_list_tail([]).
print_list_tail([Head|Tail]) :- print_list(Tail).

print_list_tail([], Stream):- nl(Stream).
print_list_tail([Head|Tail], Stream) :- write(Stream," "), print_list(Tail, Stream).

/* ==========================================================================================================================
parse_sentenc currently contains a placeholder that writes the sentence after 
removing the first word in the output.txt file.
You can modify any rule in this file as far as make_go_now() initiates the resolution process.
*========================================================================================================================== */
parse_sentence(Stream,Sentence,Diagram,[],Nouns,Verbs,Prepositions,Adjectives,Adverbs, subject) :-
    print_list_tail(Sentence, Stream).