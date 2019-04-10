:- module(swish_app,
	  [
	  ]).
:- use_module(library(pldoc), []).

:- dynamic counter/1.

% Your program goes here
has(hockey, puck). has(hockey, stick). has(hockey, team). has(hockey, ice). has(hockey, rink).
has(hockey, skate). has(hockey, goal). has(hockey, winter). has(hockey, violent). has(hockey, referee).
has(soccer, ball). has(soccer, field). has(soccer, goal). has(soccer, team). has(soccer, referee).
has(soccer, outdoor). has(soccer, summer). has(soccer, eleven). has(soccer, cleats). has(soccer, indoor).
has(volleyball, summer). has(volleyball, ball). has(volleyball, indoor). has(volleyball, outdoor). has(volleyball, team).
has(volleyball, two). has(volleyball, six). has(volleyball, point). has(volleyball, net). has(volleyball, referee).
has(track400, individual). has(track400, team). has(track400, race). has(track400, stadium). has(track400, long).
has(track400, spikes). has(track400, sprint). has(track400, hard). has(track400, painful).
has(swimmingbutterfly, painfull). has(swimmingbutterfly, race). has(swimmingbutterfly, short). has(swimmingbutterfly, 50). has(swimmingbutterfly, 100).
has(swimmingbutterfly, pool). has(swimmingbutterfly, individual). has(swimmingbutterfly, team). has(swimmingbutterfly, water). has(swimingbuterfly, phelps).
has(track100, individual). has(track100, team). has(track100, race). has(track100, stadium). has(track100, short).
has(track100, spikes). has(track100, sprint). has(track100, fast). has(track100, bolt).
has(marathon, 42). has(marathon, route). has(marathon, kipchoge). has(marathon, long). has(marathon, endurance).
has(marathon, individual). has(marathon, race). has(marathon, running). has(marathon, berlin).
has(rowing, water). has(rowing, team). has(rowing, 2). has(rowing, 8). has(rowing, individual). has(rowing, lake).
has(rowing, cox). has(rowing, hard). has(rowing, race). has(rowing, oars). has(rowing, boat). has(rowing, 4).
has(boxing, violent). has(boxing, ring). has(boxing, individual). has(boxing, referee). has(boxing, gloves).
has(boxing, combat). has(boxing, hit). has(boxing, round). has(boxing, ali). has(boxing, ancient).
has(karate, violent). has(karate, mat). has(karate, individual). has(karate, referee). has(boxing, japanese).
has(karate, combat). has(karate, hit). has(karate, martialart). has(karate, grapling). has(karate, ancient).


is(over).


sports([hockey,soccer,track400,swimmingbutterfly,volleyball,boxing,track100,karate,rowing,marathon]).
start(0) :-	
    		print("We are going to play the 10 questions games."), nl,
			print("I will think of an olympic sports, you will have to guess it."), nl,
			print("You can ask me up to 10 questions but you can guess whenever you are ready."), nl,
    		print("Today the theme is Olympic Sports!"),
    		print("Do you want to start playing the game (y/n)"), nl,
    	    restartcounter,
    		sports(This),
			start(1,This).

startingphrase(["Okay, let me think of a sport... ohh I got one. Let's start! ",
                 "I have one, you will never guess! ", "Lets see if you can guess what I am thinking of. "]).

wronginputyn(["This makes no sense! Please let me know if you want to play (y/n) ", "You have to write a valid input! (y/n)",
           "Hey focus here! (y/n)"]).

start(1,List) :- read(X),
    		(X=y -> startingphrase(Startingphrase), random_member(Start, Startingphrase),
            write(Start), nl,
			random_member(Mystery,List), delete(List,Mystery, R), questions(Mystery,R)
			;
    		(X=n -> write("Okay! I'll see you some other time!"), terminate(0);
			wronginputyn(Wronginputyn), random_member(In, Wronginputyn),
            write(In), nl, start(1,List))
            ).
    		

%promptquestion(["That is your ~w question. ", "What is your ~w question? ", ""])

yeslist(["Yes it does! ", "Yes! you are good.", "The answer is yes. "]).
nolist(["No it does Not ", "The answer is no. ", "I would like to say yes but NO!"]). 

questions(MySport,List) :- 
    				  what_string(C),
    				  format("What is your ~w question? ", [C]), nl,
					  read(X),
					  (has(MySport,X) -> yeslist(Yeslist), random_member(Yes, Yeslist),
                      write(Yes), nl, continue(0, MySport, List);     
                      nolist(Nolist), random_member(No, Nolist),
                      write(No), nl, continue(0,MySport,List)).
				  
guessorq(["Do you want to ask another question or guess the sport? (q/g) ", "Are you ready to guess?  (q/g)", "What is your next move (q/g)"]).    

continueq(["Okay! ", "Allright!", "Go ahead! "]).
continueg(["Let me ear it! ", "Allright what do you think it is? ", "Hmmmm I would not be so sure of myself but okay! "]).
wronginputqg(["This makes no sense! Please make sure to enter a valid value. (q/g)", "Please enter a valid input! (q/g) ", "hmmm are you asleep? (q/g)"]).

continue(0, MySport, List) :-  ( counter(B), B = 10 ->  write("That was your last question, you now have to guess "), nl, guess(MySport,List);
                               guessorq(Guessorq), random_member(GoQ, Guessorq),
                               write(GoQ), nl,
                               read(Y), (Y = q -> 
                                       continueq(Continueq), random_member(Cq, Continueq),
                                           write(Cq), nl, incrcounter, questions(MySport,List);
 										   (Y=g -> continueg(Conginueg), random_member(Cg, Conginueg),
                                           write(Cg), nl, guess(MySport,List);
                                           wronginputqg(Wronginputqg), random_member(Wrong, Wronginputqg),
                                           write(Wrong), nl,
                                            continue(0,MySport,List)))). 



guess(MySport,List) :- read(X),
            	  (MySport = X -> format("Congrats you got it! I was thinking of
                   ~w. ",[MySport]), nl,
                   play_again(0,List); 
                   write("No that is not the olympic sport I was thinking of. "), nl,
                   format("I was thinking of  ~w ", [MySport]),
                   nl,
    			    play_again(0,List)).
                  
play_again(0,List) :- write("Do you want to play again? (y/n)"), nl,
                      restartcounter, start(1, List).
                       
                               

terminate(0) :- abort.

what_string('first') :- counter(B), B = 1.
what_string('second') :- counter(B), B = 2.
what_string('third') :- counter(B), B = 3.
what_string('fourth') :- counter(B), B = 4.
what_string('fifth') :- counter(B), B = 5.
what_string('sixth') :- counter(B), B = 6.
what_string('seventh') :- counter(B), B = 7.
what_string('eight') :- counter(B), B = 8.
what_string('ninth') :- counter(B), B = 9.
what_string('last') :- counter(B), B = 10.w


restartcounter :- retractall(counter(_)),
    			  assertz(counter(1)).

incrcounter :-
    counter(V0),
    retractall(counter(_)),
    succ(V0, V),
    assertz(counter(V)).


