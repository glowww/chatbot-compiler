#ifndef tokens_h
#define tokens_h
/* tokens.h -- List of labelled tokens and stuff
 *
 * Generated from: program.g
 *
 * Terence Parr, Will Cohen, and Hank Dietz: 1989-2001
 * Purdue University Electrical Engineering
 * ANTLR Version 1.33MR33
 */
#define zzEOF_TOKEN 1
#define CONVERSATION 2
#define QUESTION 3
#define ANSWERS 4
#define THEN 5
#define OR 6
#define INTERACTION 7
#define CHATBOT 8
#define END 9
#define ID 10
#define NUM 11
#define QUESTIONMARK 12
#define SEMICOLON 13
#define HASHTAG 14
#define TWODOTS 15
#define ARROW 16
#define COMMA 17
#define PC 18
#define PO 19
#define CC 20
#define CO 21
#define SPACE 22

#ifdef __USE_PROTOS
void chatbot(AST**_root);
#else
extern void chatbot();
#endif

#ifdef __USE_PROTOS
void conversations(AST**_root);
#else
extern void conversations();
#endif

#ifdef __USE_PROTOS
void type(AST**_root);
#else
extern void type();
#endif

#ifdef __USE_PROTOS
void questions(AST**_root);
#else
extern void questions();
#endif

#ifdef __USE_PROTOS
void answers(AST**_root);
#else
extern void answers();
#endif

#ifdef __USE_PROTOS
void answer_list(AST**_root);
#else
extern void answer_list();
#endif

#ifdef __USE_PROTOS
void answer(AST**_root);
#else
extern void answer();
#endif

#ifdef __USE_PROTOS
void answer_vec(AST**_root);
#else
extern void answer_vec();
#endif

#ifdef __USE_PROTOS
void answer_in_vec(AST**_root);
#else
extern void answer_in_vec();
#endif

#ifdef __USE_PROTOS
void words(AST**_root);
#else
extern void words();
#endif

#ifdef __USE_PROTOS
void references(AST**_root);
#else
extern void references();
#endif

#ifdef __USE_PROTOS
void reference(AST**_root);
#else
extern void reference();
#endif

#ifdef __USE_PROTOS
void ref(AST**_root);
#else
extern void ref();
#endif

#ifdef __USE_PROTOS
void chats(AST**_root);
#else
extern void chats();
#endif

#ifdef __USE_PROTOS
void chat(AST**_root);
#else
extern void chat();
#endif

#ifdef __USE_PROTOS
void chat_def(AST**_root);
#else
extern void chat_def();
#endif

#ifdef __USE_PROTOS
void par_or_statement(AST**_root);
#else
extern void par_or_statement();
#endif

#ifdef __USE_PROTOS
void simple_or_statement(AST**_root);
#else
extern void simple_or_statement();
#endif

#ifdef __USE_PROTOS
void then_statement(AST**_root);
#else
extern void then_statement();
#endif

#ifdef __USE_PROTOS
void startchat(AST**_root);
#else
extern void startchat();
#endif

#ifdef __USE_PROTOS
void interaction(AST**_root);
#else
extern void interaction();
#endif

#ifdef __USE_PROTOS
void bot(AST**_root);
#else
extern void bot();
#endif

#endif
extern SetWordType zzerr1[];
extern SetWordType zzerr2[];
extern SetWordType setwd1[];
extern SetWordType zzerr3[];
extern SetWordType setwd2[];
extern SetWordType zzerr4[];
extern SetWordType zzerr5[];
extern SetWordType zzerr6[];
extern SetWordType zzerr7[];
extern SetWordType setwd3[];
extern SetWordType setwd4[];
