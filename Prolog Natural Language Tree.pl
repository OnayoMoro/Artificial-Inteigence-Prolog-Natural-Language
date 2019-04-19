/*Vocabulary*/
det(a).
det(an).
noun(boy).
noun(father).
noun(grandfather).
noun(person).
noun(student).
noun(petrolhead).
noun(book).
noun(car).
noun(horses).
noun(walk).
noun(chat).
noun(guitar).
verb(loves).
verb(likes).
prep(whatever).
adj(old).
adj(good).
adj(long).
adj(sprightly).
adj(social).
adj(young).
adj(racing).
adj(avid).
adj(teenage).

/*Recommend Verb, Noun Recomendation*/

recommend(likes,book,'He joins the book club').
recommend(loves,horses,'They join a riding club').
recommend(loves,walk,'He joins a rambling club').
recommend(likes,chat,'They join a social club').
recommend(likes,guitar,'They should join a band').
recommend(loves,car,'They should see the races').

/*Agent*/

agent:-
      perceive(Percepts),
      action(Percepts).


perceive(Percepts):-
      nl,
      write('who should i recommended a present for? '),
      read(Input),
      go(Input,Percepts).

      go(List,Output):-
      sentence(List,Output),
      parselocation(Output).

/*Parse Tree*/

parselocation(A):-
      A=sentence(X,Y),
      nl,
      write('Sentence'),
      nl,

      tab(10),
      write('Noun phrase'),
      nl,
      parselocation(X),
      tab(10),
      write('Verb phrase'),
      nl,
      parselocation(Y).

parselocation(np(A)):-
       A=np(X,Y),
       nl,
       tab(20),
       write(X),
       nl,
       parselocation(Y).

parselocation(vp(A)):-
    A=vp(X,Y),
    tab(20),
    write(X),
    nl,
    parselocation(Y).


parselocation(A):-
      A=np2(X,Y),
      tab(30),
      write(X),
      nl,
      parselocation(Y).

parselocation(A):-
       A=pp(X,Y),
       tab(30),
       write(X),
       nl,
       parselocation(Y).

parselocation(A):-
       A=vp(X,Y),
       tab(40),
       write(X),
       nl,
       parselocation(Y).

parselocation(A):-
      A=np2(X),
      tab(40),
      write(X),
      nl.


parselocation(A):-
       A=np(X,Y),
       tab(30),
       write(X),
       nl,
       parselocation(Y).



/*Sentence to Noun and Verb Phrase*/

sentence(Sentence,sentence(np(Noun_Phrase),vp(Verb_Phrase))):-
      np(Sentence,Noun_Phrase,Rem),
      vp(Rem,Verb_Phrase).

/*Noun pharse to Det Noun parse 2 */

np([X|T],np(det(X),NP2),Rem):-
	det(X),
	np2(T,NP2,Rem).

/*Noun Pharse to Noun Parse 2*/

np(Sentence,Parse,Rem):-
np2(Sentence,Parse,Rem).

/*Noun Pharse to Prep Pharse*/

np(Sentence,np(NP,PP),Rem):-
	np(Sentence,NP,Rem1),
	pp(Rem1,PP,Rem).

/*Noun Phase 2 to Noun*/

np2([H|T],np2(noun(H)),T):-
      noun(H).

/*Noun Phase 2 to Adjective and Noun Pharse 2*/

np2([H|T],np2(adj(H),Rest),Rem):-
      adj(H),
      np2(T,Rest,Rem).

/*Prep Pharse to Prep Noun Pharse*/

pp([H|T],pp(prep(H),Parse),Rem):-
      prep(H),
      np(T,Parse,Rem).


/*Verb Pharse to Verb */

vp([H|[]],verb(H)):-
          verb(H).

/*Verb Pharse to Verb and Prep Pharse*/

vp([H|Rest],vp(verb(H),Restparsed)):-
        verb(H),
        pp(Rest,Restparsed,_).

/*Verb Pharse to Verb and Noun Pharse*/

vp([H|Rest],vp(verb(H),Restparsed)):-
      verb(H),
      np(Rest,Restparsed,_).

/*Recommend*/

/*Recommend Verb, det, adj, Noun */

action(sentence(np(np(det(A),np2(adj(B),np2(noun(C))))),vp(vp(verb(Verb),np(det(D),np2(adj(E),np2(noun(Noun)))))))):-
      recommend(Verb,Noun,O),
      nl,write(O),
      nl,
      write(' Sentence'),
      nl,
      tab(1),write('|'),
      nl,
      tab(1),write('|-'),write('['),write(A),write(','),write(B),write(','),write(C),write(','),write(Verb),write(','),write(D),write(','),write(E),write(','),write(Noun),write(']'),
      nl,
      tab(1),write('|'),
      nl,
      tab(1),write('|'),write(' Produces the recommendation that'),
      nl,
      tab(1),write('|'),
      nl,
      tab(1),write('|-'),
      write(O),nl.

/*Recommed Verb, Noun */

action(sentence(np(np(det(A),np2(adj(B),np2(noun(C))))),vp(vp(verb(Verb),np2(noun(Noun)))))):-
      recommend(Verb,Noun,O),
      nl,
      write(' Sentence'),
      nl,
      tab(1),write('|'),
      nl,
      tab(1),write('|-'),write('['),write(A),write(','),write(B),write(','),write(C),write(','),write(Verb),write(','),write(Noun),write(']'),
      nl,
      tab(1),write('|'),
      nl,
      tab(1),write('|'),write(' Produces the recommendation that'),
      nl,
      tab(1),write('|'),
      nl,
      tab(1),write('|-'),
      write(O).


/*Recommend Verb, det, Noun */

action(sentence(np(np(det(A),np2(adj(B),np2(noun(C))))),vp(vp(verb(Verb),np(det(D),np2(noun(Noun))))))):-
      recommend(Verb,Noun,O),
      nl,
      write(' Sentence'),
      nl,
      tab(1),write('|'),
      nl,
      tab(1),write('|-'),write('['),write(A),write(','),write(B),write(','),write(C),write(','),write(Verb),write(','),write(D),write(','),write(Noun),write(']'),
      nl,
      tab(1),write('|'),
      nl,
      tab(1),write('|'),write(' Produces the recommendation that'),
      nl,
      tab(1),write('|'),
      nl,
      tab(1),write('|-'),
      write(O).


