# chatbot-compiler
Compiler for a simple Chatbot Language

This language allows to define questions, answers and conversations. A Chatbot is a set of structured conversations.

How to compile
-------

```
antlr -gt program.g
dlg -ci parser.dlg scan.c
g++ -o program program.c scan.c err.c
```

Example
-------
Input
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
Output
```
 list
  \__list
  |      \__Q1
  |      |    \__list
  |      |           \__HOW
  |      |           \__MANY
  |      |           \__CARS
  |      |           \__YOU
  |      |           \__HAVE
  |      \__PC
  |      |    \__list
  |      |           \__WHICH
  |      |           \__COLOR
  |      |           \__IS
  |      |           \__YOUR
  |      |           \__FAVOURITE
  |      \__RC
  |      |    \__list
  |      |           \__1
  |      |           |   \__list
  |      |           |          \__RED
  |      |           \__2
  |      |           |   \__list
  |      |           |          \__BLACK
  |      |           \__3
  |      |           |   \__list
  |      |           |          \__WHITE
  |      |           \__4
  |      |               \__list
  |      |                      \__BLUE
  |      \__Q3
  |      |    \__list
  |      |           \__WHAT
  |      |           \__IS
  |      |           \__YOUR
  |      |           \__FAVOURITE
  |      |           \__SOCCER
  |      |           \__TEAM
  |      \__C1
  |      |    \__->
  |      |         \__PC
  |      |         \__RC
  |      \__A2
  |      |    \__list
  |      |           \__1
  |      |           |   \__list
  |      |           |          \__ONE
  |      |           \__2
  |      |           |   \__list
  |      |           |          \__TWO
  |      |           \__3
  |      |               \__list
  |      |                      \__MORE
  |      |                      \__THAN
  |      |                      \__TWO
  |      \__C2
  |      |    \__->
  |      |         \__Q1
  |      |         \__A2
  |      \__TT
  |      |    \__->
  |      |         \__Q3
  |      |         \__A3
  |      \__A3
  |      |    \__list
  |      |           \__1
  |      |           |   \__list
  |      |           |          \__FC
  |      |           |          \__BARCELONA
  |      |           \__2
  |      |           |   \__list
  |      |           |          \__GIRONA
  |      |           |          \__FC
  |      |           \__3
  |      |               \__list
  |      |                      \__ATHLETIC
  |      |                      \__BILBAO
  |      \__p22
  |      |     \__list
  |      |            \__WHAT
  |      |            \__IS
  |      |            \__YOUR
  |      |            \__FAVOURITE
  |      |            \__SUBJECT
  |      \__Rr23
  |      |      \__list
  |      |             \__1
  |      |             |   \__list
  |      |             |          \__A
  |      |             \__2
  |      |             |   \__list
  |      |             |          \__G
  |      |             \__3
  |      |             |   \__list
  |      |             |          \__IA
  |      |             \__4
  |      |             |   \__list
  |      |             |          \__LI
  |      |             \__5
  |      |             |   \__list
  |      |             |          \__LP
  |      |             \__6
  |      |                 \__list
  |      |                        \__TC
  |      \__CH22
  |             \__->
  |                  \__p22
  |                  \__Rr23
  \__list
  |      \__GENERAL
  |      |         \__THEN
  |      |                \__C2
  |      |                \__OR
  |      |                     \__C1
  |      |                     \__TT
  |      |                     \__CH22
  |      \__PART
  |             \__OR
  |                  \__THEN
  |                  |      \__C2
  |                  |      \__C1
  |                  \__TT
  \__list
         \__33
         \__GENERAL
         \__PART

```
