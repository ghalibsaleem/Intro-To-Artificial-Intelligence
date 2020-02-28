

diagnose:- symptoms(Disease),
    write("There might be a possibility that you are suffering from: "),
    write(Disease),
    nl,
    write("Note: It is advidsed to consult with a doctor for further dignosis and prescription."),
    nl,
    undo.

/* Diseases to be tested*/
symptoms(diarrhoea):- diarrhoea, !.
symptoms(malaria):- malaria, !.
/*symptoms(hIV_AIDS):- hIV_AIDS, !.
symptoms(typhoid):- typhoid, !.
symptoms(diabetes):- diabetes, !.
symptoms(obesity):- obesity, !.
symptoms(depression):- depression, !.
symptoms(breastCancer):- breastCancer, !.
symptoms(heartDisease):- heartDisease, !.*/
symptoms(unknown).

/* Diseases Identification rules*/
diarrhoea :- stomachache,
    fever,
    nausea,
    vomiting,
    verify(cramping),
    verify(loose_stool).

malaria:- bodyPain,
    highFever,
    vomiting,
    severeHeadache,
    verify(sweating).


/* classification rules */
pain :- verify(has_pain).
stomachache:- pain, verify(stomach_pain).
fever :- verify(has_fever).
vomiting:- verify(vomiting).
nausea:- verify(nausea).
highFever :- fever,
    verify(bodyTemp_100_or_more).
bodyPain:- pain,
    verify(muscle_and_body_pain).
headache :- verify(headache).
severeHeadache:- headache,
    verify(severe_Headache).



askSymptoms(Symp):-
    write("Do you have this symptom: "),
    write(Symp),
    write("?"),
    read(Response),
    nl,
     ( (Response == yes ; Response == y)
        ->
        assert(yes(Symp)) ;
        assert(no(Symp)), fail).


:- dynamic yes/1,no/1.
verify(Rule):-(yes(Rule)->true;(no(Rule)->fail;askSymptoms(Rule))).


undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail.
undo.