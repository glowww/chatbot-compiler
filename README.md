# chatbot-compiler
Compiler for a simple Chatbot Language

This language allows to define questions, answers and conversations. A Chatbot is a set of structured conversations.

Example
-------

```
Q1: QUESTION
HOW MANY CARS YOU HAVE ?
PC: QUESTION
WHICH COLOR IS YOUR FAVOURITE ?
RC: ANSWERS 
1: RED;
2: BLACK;
3: WHITE;
4: BLUE;
Q3: QUESTION
WHAT IS YOUR FAVOURITE SOCCER TEAM ?
C1: CONVERSATION
#PC -> #RC
A2: ANSWERS
[(1, ONE),(2,TWO),(3, MORE THAN TWO)] 
C2: CONVERSATION
#Q1 -> #A2
TT: CONVERSATION
#Q3 -> #A3
A3: ANSWERS
1: FC BARCELONA;
2: GIRONA FC;
3: ATHLETIC BILBAO;
p22: QUESTION
WHAT IS YOUR FAVOURITE SUBJECT ?
Rr23: ANSWERS
[(1,A),(2,G),(3,IA),(4,LI),(5,LP),(6,TC)]
CH22: CONVERSATION
#p22 -> #Rr23
CHATBOT GENERAL:
#C2 THEN (#C1 OR #TT OR #CH22)
CHATBOT PART:
#C2 THEN #C1 OR #TT
INTERACTION 33 
GENERAL
PART
END

```

Usage
-------

```
antlr -gt program.g
dlg -ci parser.dlg scan.c
g++ -o program program.c scan.c err.c
```