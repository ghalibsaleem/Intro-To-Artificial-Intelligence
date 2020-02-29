

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
symptoms(diarrhoea):- diarrhoea, !.
symptoms(diabetes):- diabetes, !.
symptoms(dehydration):- dehydration, !.
symptoms(imbalance_blood_pressure):- imbalance_blood_pressure, !.
symptoms(depression):- depression, !.
symptoms(breastCancer):- breastCancer, !.
symptoms(heartDisease):- heartDisease, !.
symptoms(unknown).

/* Diseases Identification rules*/
diarrhoea :- 
    stomach_ache,
    fever,
    nausea,
    vomiting,
    verify(abdominal_cramping),
    verify(urgent_need_to_have_a_bowel_movement),
    verify(loose_stool).

dehydration :-
    fatigue,
    verify(extreme_thirst),
    verify(less_frequent_urination),
    verify(dark_colored_urine),
    dizziness.

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
    verify(sore_throat),
    verify(swollen_lymph_glands),
    verify(weight_loss),
    verify(oral_yeast_infection).

typhoid:- 
    typhoid_fever,
    headache,
    muscle_pain,
    diarrhoea,
    weakness_fatigue,
    verify(dry_cough),
    verify(sweating).

diabetes:- verify(frequent_urination),
    verify(hunger),
    verify(thirsty_than_usual),
    blurred_vision,
    verify(skin_itching).

imbalance_blood_pressure:- severeHeadache,
    blurred_vision,
    chestPain,
    breathlessness,
    nausea,
    vomiting,
    dizzyness.

depression:- 
    verify(selfloathing),
    verify(angry_and_sullen),
    verify(anxiety),
    verify(lack_of_interest),
    verify(laziness),
    verify(change_in_sleeping_Habits).

heartDisease:- 
    breathlessness,
    weekness_fatigue,
    verify(fast_heartbeat),
    verify(heartburn),
    verify(pressure_or_heaviness_in_chest_and_arm).


/* classification rules */
fever :-
    verify(has_fever).

high_fever :-
    fever,
    verify(body_temp_102_or_more).

typhoid_fever:-
    high_fever,
    verify(fever_started_slowly_then_increased_severely).

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
    verify(have_pain).

stomach_ache :-
    pain,
    verify(stomach_pain).

body_pain :-
    pain,
    verify(body_pain).

muscle_pain :-
    pain,
    verify(muscle_pain).

joint_pain :-
    pain,
    verify(joint_pain).

chest_pain :-
    pain,
    verify(chest_pain).

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
    verify(severe_headache).

blurred_vision :-
    verify(blurred_vision).

breathlessness :-
    verify(breathlessness).

dizzyness:-
    verify(dizziness).

obesity :-
    breathlessness,
    verify(high_bmi),
    verify(extra_fat_around_areas_such_as_arms_waist_calves_thighs),
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