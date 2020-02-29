

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
symptoms(diabetes):- diabetes, !.
symptoms(obesity):- obesity, !.
symptoms(diarrhoea):- diarrhoea, !.
symptoms(imbalance_blood_pressure):- imbalance_blood_pressure, !.
symptoms(depression):- depression, !.
symptoms(breastCancer):- breastCancer, !.
symptoms(heartDisease):- heartDisease, !.
symptoms(unknown).

/* Diseases Identification rules*/
diarrhoea :- stomachache,
    fever,
    nausea,
    vomiting,
    verify(cramping),
    verify(loose_stool).

malaria:- body_musclePain,
    highFever,
    vomiting,
    severeHeadache,
    verify(sweating).

hIV_AIDS:- muslJointPain,
    fever,
    headache,
    diarrhoea,
    fatigue,
    verify(sore_throat),
    verify(swollen_lymph_glands),
    verify(weight_loss),
    verify(oral_yeast_infection).

typhoid:- typhoidFever,
    headache,
    musclePain,
    diarrhoea,
    weekness_fatigue,
    verify(dry_cough).

diabetes:- verify(frequent_urination),
    verify(hunger),
    verify(thirsty_than_usual),
    blurredVision,
    verify(skin_itching).

obesity:- verify(high_BMI),
    verify(extra_fat_around_areas_such_as_arms_waist_calves_thighs),
    breathlessness,
    verify(snoring).

imbalance_blood_pressure:- severeHeadache,
    blurredVision,
    chestPain,
    breathlessness,
    nausea,
    vomiting,
    verify(dizzyness).

depression:- verify(selfloathing),
    verify(angry_and_sullen),
    verify(anxiety),
    verify(lack_of_interest),
    verify(laziness),
    verify(change_in_sleeping_Habits).

breastCancer:- verify(gender_female),
    verify(breast_or_nipple_pain),
    verify(formation_of_lumps_near_nipple_area_or_underarms),
    verify(swelling_in_the_armpit),
    verify(change_the_overall_size_or_texture_of_the_nipple),
    verify(nipple_discharge).

heartDisease:- breathlessness,
    weekness_fatigue,
    verify(fast_heartbeat),
    verify(heartburn),
    verify(pressure_or_heaviness_in_chest_and_arm).




/* classification rules */
fever :- verify(has_fever).
highFever :- fever,
    verify(bodyTemp_102_or_more).
typhoidFever:- highFever,
    verify(started_slowly_then_inceresed_severely).

vomiting:- verify(vomiting).
nausea:- verify(nausea).

fatigue:verify(fatigue).
weekness_fatigue:- fatigue,
    verify(weekness).

pain :- verify(has_pain).
stomachache:- pain, verify(stomach_pain).
bodyPain:- pain,
    verify(body_pain).
musclePain:- pain,
    verify(muscle_pain).
jointPain:- pain,
    verify(joint_pain).
chestPain:-pain,
    verify(chest_pain).
body_musclePain:-bodyPain,muscle_pain.
muslJointPain :- musclePain,jointPain.
headache :- verify(headache).
severeHeadache:- headache,
    verify(severe_Headache).

blurredVision:- verify(blurred_vision).
breathlessness:-verify(breathlessness).


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