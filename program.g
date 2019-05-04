#header
<<
#include <string>
#include <vector>
#include <iostream>
using namespace std;

// struct to store information about tokens
typedef struct {
  string kind;
  string text;
} Attrib;

// function to fill token information (predeclaration)
void zzcr_attr(Attrib *attr, int type, char *text);

// fields for AST nodes
#define AST_FIELDS string kind; string text;
#include "ast.h"

// macro to create a new AST node (and function predeclaration)
#define zzcr_ast(as,attr,ttype,textt) as=createASTnode(attr,ttype,textt)
AST* createASTnode(Attrib* attr, int ttype, char *textt);
>>

<<
#include <cstdlib>
#include <cmath>
// function to fill token information
void zzcr_attr(Attrib *attr, int type, char *text) {
  attr->kind = text;
  attr->text = "";
}

// function to create a new AST node
AST* createASTnode(Attrib* attr, int type, char* text) {
  AST* as = new AST;
  as->kind = attr->kind; 
  as->text = attr->text;
  as->right = NULL; 
  as->down = NULL;
  return as;
}

AST* createASTlist(AST *n){
  AST *as = new AST;
  as->kind = "list";
  as->right = NULL;
  as->down = n;
  return as;
}

/// get nth child of a tree. Count starts at 0.
/// if no such child, returns NULL
AST* child(AST *a, int n){
  AST *c = a->down;
  for(int i = 0; c != NULL && i < n; i++){
    c = c->right;
  }
  return c;
}

/// print AST, recursively, with indentation
void ASTPrintIndent(AST *a,string s)
{
  if (a==NULL) return;

  cout<<a->kind;
  if (a->text!="") cout<<"("<<a->text<<")";
  cout<<endl;

  AST *i = a->down;
  while (i!=NULL && i->right!=NULL) {
    cout<<s+"  \\__";
    ASTPrintIndent(i,s+"  |"+string(i->kind.size()+i->text.size(),' '));
    i=i->right;
  }
  
  if (i!=NULL) {
      cout<<s+"  \\__";
      ASTPrintIndent(i,s+"   "+string(i->kind.size()+i->text.size(),' '));
      i=i->right;
  }
}

/// print AST 
void ASTPrint(AST *a)
{
  while (a!=NULL) {
    cout<<" ";
    ASTPrintIndent(a,"");
    a=a->right;
  }
}

AST* getChildByName(AST *a, const string &name){
  AST *c = a->down;
  int i = 0;
  c = child(a,i);

  while(c != NULL){
    if(c->kind == name) return c;
    i++;
    c = child(a,i);
  }
  return c;
}

void printQuestion(AST *a, const string &botname, const string &username){
  string question = "";
  AST *b = a->down;
  int i = 0;
  AST *c = child(b,i);

  while(c != NULL){
    question += " " + c->kind;
    i++;
    c = child(b,i);
  }
  question += " ?";

  cout << botname << " > " << username << ", " << question << endl;
}

void printAnswers(AST *a){
  AST *answerList = a->down;
  int i = 0;
  AST *answerRow = child(answerList,i);

  while(answerRow != NULL){
    AST *answerWords = answerRow->down;
    cout << i+1 << ":";

    int j = 0;
    AST *word = child(answerWords,j);
    string answer = "";
    while(word != NULL){
      answer += " " + word->kind;

      j++;
      word = child(answerWords, j);
    }
    cout << answer << endl;;

    i++;
    answerRow = child(answerList,i);
  }
}

void printConversation(AST *conversations, const string &convname, const string &botname, const string &username){
  AST *conv = getChildByName(conversations, convname)->down;

  string questionID = child(conv, 0)->kind;
  AST *question = getChildByName(conversations, questionID);
  printQuestion(question, botname, username);

  string answerID = child(conv, 1)->kind;
  AST *answers = getChildByName(conversations, answerID);
  printAnswers(answers);

  cout << username << " > ";
  string actuallyIdontCare;
  getline(cin, actuallyIdontCare);
}

int numberOfChilds(AST *a){
  int count = 0; 
  AST *c = a->down;
  while(c != NULL){
    c = c->right;
    count++;
  }
  return count;
}

void generateConversations(vector<string> &convVec, AST *a){
  if(a->kind == "THEN"){
    generateConversations(convVec, child(a, 0));
    generateConversations(convVec, child(a, 1));
  } 
  else if (a->kind == "OR") {
    int randomChild = rand() % numberOfChilds(a);
    generateConversations(convVec, child(a, randomChild));
  }
  else {
    convVec.push_back(a->kind);
  }
}

void start(AST *a){
  if(a != NULL){
    AST *conversations = child(a,0);
    AST *chats = child(a,1);
    AST *startchat = child(a,2);

    int seed = atoi((child(startchat,0)->kind).c_str());
    srand(seed);

    int i = 1;
    AST *bot = child(startchat,i);
    while(bot != NULL){
      string botname = bot->kind;
      cout << botname << " > " << "WHAT IS YOUR NAME ?" << endl;

      string username;
      getline(cin, username);

      AST *chat = getChildByName(chats, botname)->down;

      vector<string> convVec;
      generateConversations(convVec, chat);

      for(int j = 0; j < convVec.size(); j++){
        printConversation(conversations, convVec[j], botname, username);
      }

      cout << botname << " > THANKS FOR THE CHAT " << username << "!" << endl;
      
      i++;
      bot = child(startchat,i);
    }
  }
}

int main() {
  AST *root = NULL;
  ANTLR(chatbot(&root), stdin);
  ASTPrint(root);
  start(root);
}
>>

#lexclass START

#token CONVERSATION "CONVERSATION"
#token QUESTION "QUESTION"
#token ANSWERS "ANSWERS"

#token THEN "THEN"
#token OR "OR"

#token INTERACTION "INTERACTION"
#token CHATBOT "CHATBOT"
#token END "END"

#token ID "[A-Za-z][A-Za-z0-9]*"
#token NUM "[0-9]+"

#token QUESTIONMARK "\?"
#token SEMICOLON "\;"
#token HASHTAG "\#"
#token TWODOTS "\:"
#token ARROW "\->"
#token COMMA "\,"

#token PC "\("
#token PO "\)"
#token CC "\["
#token CO "\]"

#token SPACE "[\ \n]" << zzskip();>>


chatbot: conversations chats startchat <<#0=createASTlist(_sibling);>>;

// CONVERSATIONS
conversations: (type)* <<#0=createASTlist(_sibling);>>;
type: ID^ TWODOTS! (questions |  answers | references);

questions: QUESTION! words QUESTIONMARK!;

answers: ANSWERS! (answer_list | answer_vec);
answer_list: (answer)* <<#0=createASTlist(_sibling);>>;
answer: NUM^ TWODOTS! words SEMICOLON!;

answer_vec: CC! (answer_in_vec)* CO! <<#0=createASTlist(_sibling);>>;
answer_in_vec: PC! NUM^ COMMA! words PO! (COMMA! | );

words: (ID)* <<#0=createASTlist(_sibling);>>;

references: CONVERSATION! reference;
reference: ref ARROW^ ref;
ref: HASHTAG! ID; 


// CHATS
chats: (chat)* <<#0=createASTlist(_sibling);>>;
chat: CHATBOT! ID^ TWODOTS! chat_def;

chat_def: (par_or_statement | simple_or_statement)*; 
par_or_statement: PC! simple_or_statement PO!;
simple_or_statement: then_statement (OR^|) (then_statement (OR! |))*;
then_statement: ref ((THEN^ (ref | par_or_statement))|);


// STARTCHAT
startchat: interaction (bot)* END!<<#0=createASTlist(_sibling);>>;
interaction: INTERACTION! NUM;
bot: ID;


/*
chat_def: or_statement THEN^ or_statement;       //(((OR^ THEN)(OR! then)*)|);
or_statement: simple_or_statement | par_or_statement;
simple_or_statement: HASHTAG! ID (OR^|) ( HASHTAG! ID (OR! |))*;
par_or_statement: PC! simple_or_statement PO!;
*/