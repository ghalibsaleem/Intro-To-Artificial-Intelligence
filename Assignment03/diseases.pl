/*
This is a common disease prediction system. It will ask for basic symptom like do you have pain? and where?
and with the help of these symptoms it will predict the disease. We can expand the knowledge of this program
so that it can predict more disease. We can also add prescription according to the disease or doctor recomendation
like you need general physician or orthopedics etc.

*************To start your diagnosis run command "diagnose.".**********

Created by:-
    1) Ghalib Saleem : U03151409
    2) Divyanshu Gupta : U21369422
*/

diagnose:- symptoms(Disease),
    write("There might be a possibility that you are suffering from: "),
    write(Disease),
    nl,
    write("Note: It is advidsed to consult with a doctor for further dignosis and prescription."),
    nl,
    undo.

/* Diseases to be tested*/
symptoms(malaria):- malaria, !.
symptoms(hIV_AIDS):- hIV_AIDS, !.
symptoms(typhoid):- typhoid, !.
symptoms(cholera):- cholera, !.
symptoms(diarrhoea):- diarrhoea, !.
symptoms(arthritis):- arthritis, !.
symptoms(diabetes):- diabetes, !.
symptoms(dehydration):- dehydration, !.
symptoms(imbalance_blood_pressure):- imbalance_blood_pressure, !.
symptoms(depression):- depression, !.
symptoms(breastCancer):- breastCancer, !.
symptoms(heartDisease):- heartDisease, !.
symptoms(unknown).

/* Diseases Identification rules*/
malaria:- 
    body_muscle_pain,
    high_fever,
    vomiting,
    fatigue,
    severe_headache,
    verify(chills).

hIV_AIDS:- 
    muscle_joint_pain,
    fever,
    headache,
    diarrhoea,
    fatigue,
    verify("Sore throat"),
    verify("Swollen lymph glands"),
    verify("Weight loss"),
    verify("Oral yeast infection").

typhoid:-
    muscle_pain,
    typhoid_fever,
    headache,
    diarrhoea,
    weakness_fatigue,
    verify("Dry cough"),
    verify(sweating).

cholera:-
    diarrhoea,
    dehydration.

diarrhoea :- 
    stomach_ache,
    fever,
    nausea,
    vomiting,
    verify("Abdominal cramping"),
    verify("Urgent need to have a bowel movement"),
    verify("Loose stool").

arthritis:-
    joint_pain,
    verify("Joint Stiffness"),
    verify("Joint Swelling"),
    verify("Decreased range of motion").

diabetes:- verify("Frequent urination"),
    verify(hunger),
    verify("Thirsty than usual"),
    blurred_vision,
    verify("Skin itching").

dehydration :-
    fatigue,
    verify("Extreme thirst"),
    verify("Less frequent_urination"),
    verify("dark colored urine"),
    dizziness.

imbalance_blood_pressure:- severeHeadache,
    blurred_vision,
    chestPain,
    breathlessness,
    nausea,
    vomiting,
    dizzyness.

depression:- 
    verify(selfloathing),
    verify("Angry and sullen"),
    verify(anxiety),
    verify("Lack of interest"),
    verify(laziness),
    verify("Change in sleeping Habits").

heartDisease:- 
    breathlessness,
    weekness_fatigue,
    verify("Fast heartbeat"),
    verify(heartburn),
    verify("Pressure or heaviness in chest and arm").


/* classification rules */
fever :-
    verify("Has fever").

high_fever :-
    fever,
    verify("Body temp 102 or more").

typhoid_fever:-
    high_fever,
    verify("Fever started slowly then increased severely").

vomiting :-
    verify(vomiting).

nausea :-
    verify(nausea).

fatigue :-
    verify(fatigue).

weakness_fatigue :-
    fatigue,
    verify(weakness).

pain :-
    verify("Have pain").

stomach_ache :-
    pain,
    verify("Stomach pain").

body_pain :-
    pain,
    verify("Body pain").

muscle_pain :-
    pain,
    verify("Muscle pain").

joint_pain :-
    pain,
    verify("Joint pain").

chest_pain :-
    pain,
    verify("Chest pain").

body_muscle_pain :-
    body_pain,
    muscle_pain.

muscle_joint_pain :-
    muscle_pain,
    joint_pain.

headache :-
    verify(headache).

severe_headache :-
    headache,
    verify("Severe headache").

blurred_vision :-
    verify("Blurred vision").

breathlessness :-
    verify(breathlessness).

dizzyness:-
    verify(dizziness).

obesity :-
    breathlessness,
    verify("High BMI"),
    verify("Extra fat around areas such as arms, waist, calves and thighs"),
    verify(snoring).


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

verify(Rule):-(
    yes(Rule)->true;
    (no(Rule)->fail;
    askSymptoms(Rule))).


undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail.
undo.