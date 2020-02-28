

diagnose:- symptoms(Disease),
    write("There might be a possibility that you are suffering from: "),
    write(Disease),
    nl,
    write("Note: It is advidsed to consult with a doctor for further dignosis and prescription."),
    nl,
    undo.

symptoms(pain):- pain, !.
symptoms(unknown).

pain :- verify(has_pain).


askSymptoms(Symp):-
    write("Do you have this symptom: "),
    write(Symp),
    write("?"),
    read(Response),
    nl,
     ( (Response == yes ; Response == y)
        ->
        assert(yes(Question)) ;
        assert(no(Question)), fail).


:- dynamic yes/1,no/1.
verify(Rule):-(yes(Rule)->true;(no(Rule)->fail;askSymptoms(Rule))).


undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail.
undo.