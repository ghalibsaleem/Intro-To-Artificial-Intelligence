;; This is a disease prediction system. It will ask for basic symptom like do you have pain? and where is the pain? etc.
;; and with the help of these symptoms it will predict the disease. We can expand the knowledge of this program
;; so that it can predict more disease. We can also add prescription according to the disease or doctor recommendation
;; like you need general physician or orthopedics etc.

;; ************* To start your diagnosis run command "diagnose.". **********

;; Created by:-
;;     1) Ghalib Saleem : U03151409
;;     2) Divyanshu Gupta : U21369422


;;****************
;;* DEFFUNCTIONS *
;;****************

(deffunction ask-question (?question $?allowed-values)
   (printout t ?question)
   (bind ?answer (read))
   (if (lexemep ?answer) 
       then (bind ?answer (lowcase ?answer)))
   (while (not (member ?answer ?allowed-values)) do
      (printout t ?question)
      (bind ?answer (read))
      (if (lexemep ?answer) 
          then (bind ?answer (lowcase ?answer))))
   ?answer)

(deffunction yes-or-no-p (?question)
   (bind ?response (ask-question ?question yes no y n))
   (if (or (eq ?response yes) (eq ?response y))
       then yes 
       else no))



;;****************
;;* DEFFUNCTIONS *
;;****************

(defclass PERSON (is-a USER)
    (role concrete)
    (slot gender)
    (slot age))

(defclass PAIN (is-a USER)
    (slot ispain)
    (slot location))

(defclass FEVER (is-a USER)
    (slot isfever)
    (slot ishighfever)
    (slot istyphiodfever))

(defclass HEADACHE (is-a USER)
    (slot isheadache)
    (slot severity))

(defclass MISC (is-a USER)
    (slot isvomiting)
    (slot isfatigue)
    (slot isweekness)
    (slot isnausea)
    (slot isdizziness)
    (slot isbreathlessness)
    (slot isblurred_vision))

(defclass SYMPTOMS (is-a PAIN FEVER HEADACHE USER)
    (role concrete))

(defclass DISEASE (is-a SYMPTOMS)
	(role concrete)
	(slot dname)
    (slot pdoctor))

(defclass INTERMEDIATE-DISEASE (is-a USER)
    (role concrete)
	(slot dname))

;;;;;;;;;
;;Rules
;;;;;;;;;
(defrule person-check "Person Data"
    ;(declare (salience 51))
    ?ins <- (object (is-a PERSON))
	=>
	(send ?ins put-gender (ask-question "What is you gender? (male female)? " male female))
    (send ?ins put-age (ask-question "What is your age group? (child adult)? " child adult)))

(defrule maleria "Maleria"
     ;(declare (salience 52))
     ?ins <- (object (is-a DISEASE) (ishighfever ?hf) (location ?loc) (severity ?sev))
     ?miscins <- (object (is-a MISC) (isvomiting ?isvom) (isfatigue ?isfatig))
     (test (eq ?loc body-muscle))
     (test (eq ?hf yes))
     (test (eq ?sev yes))
     (test (eq ?isvom yes))
     (test (eq ?isfatig yes))
     (chills yes)
     =>
     (send ?ins put-dname "Maleria"))


(defrule intdiarrhoea "Intermediate Diarrhoea"
     ;(declare (salience 52))
     ?ins <- (object (is-a DISEASE) (isfever ?hf) (location ?loc))
     ?miscins <- (object (is-a MISC) (isvomiting ?isvom) (isnausea ?isnausea) (isfatigue ?isfatig))
     ?tempdis <- (object (is-a INTERMEDIATE-DISEASE) (dname ?disname))
     (test (eq ?loc stomach))
     (test (eq ?hf yes))
     (test (eq ?isvom yes))
     (test (eq ?isnausea yes))
     (loose-stool yes)
     (bowel-movement yes)
     (abdominal-cramping yes)
     =>
     (send ?tempdis put-dname "Diarrhoea"))

(defrule hiv-aids "HIV AIDS"
     ;(declare (salience 52))
     ?ins <- (object (is-a DISEASE) (isfever ?hf) (location ?loc) (isheadache ?sev))
     ?miscins <- (object (is-a MISC) (isfatigue ?isfatig))
     ?tempdis <- (object (is-a INTERMEDIATE-DISEASE) (dname ?disname))
     (test (eq ?loc muscle-joint))
     (test (eq ?hf yes))
     (test (eq ?sev yes))
     (test (eq ?disname diarrhoea))
     (test (eq ?isfatig yes))
     (sore-throat yes)
     (swollen-lymph-glands yes)
     (weight-loss yes)
     =>
     (send ?ins put-dname "HIV AIDS"))


(defrule typhoid "Typhoid"
     ;(declare (salience 52))
     ?ins <- (object (is-a DISEASE) (istyphiodfever ?hf) (location ?loc) (isheadache ?sev))
     ?miscins <- (object (is-a MISC) (isfatigue ?isfatig) (isweekness ?isweek))
     ?tempdis <- (object (is-a INTERMEDIATE-DISEASE) (dname ?disname))
     (test (eq ?loc muscle))
     (test (eq ?hf yes))
     (test (eq ?sev yes))
     (test (eq ?disname diarrhoea))
     (test (eq ?isfatig yes))
     (test (eq ?isweek yes))
     (dry-cough yes)
     (sweating yes)
     =>
     (send ?ins put-dname "Typhoid"))


(defrule cholera "Cholera"
     ;(declare (salience 52))
     ?ins <- (object (is-a DISEASE))
     (object (is-a INTERMEDIATE-DISEASE) (dname ?disname))
     (test (eq ?disname diarrhoea))
     (dehydration yes)
     =>
     (send ?ins put-dname "Cholera"))

(defrule diarrhoea "Diarrhoea"
     ;(declare (salience 52))
     ?ins <- (object (is-a DISEASE))
     (object (is-a INTERMEDIATE-DISEASE) (dname ?disname))
     (test (eq ?disname diarrhoea))
     =>
     (send ?ins put-dname "Diarrhoea"))

(defrule viral-fever "Viral Fever"
     ;(declare (salience 52))
     ?ins <- (object (is-a DISEASE) (isfever ?fev) (location ?loc))
     (test (eq ?fev yes))
     (test (eq ?loc body-muscle))
     =>
     (send ?ins put-dname "Viral Fever"))

(defrule arthritis "Arthritis"
     ;(declare (salience 52))
     ?ins <- (object (is-a DISEASE) (location ?loc))
     (test (eq ?loc joint))
     (joint-stiffness yes)
     (joint-swelling yes)
     (low-range-ofmotion yes)
     =>
     (send ?ins put-dname "Arthritis"))

(defrule diabetes "Diabetes"
     ;(declare (salience 52))
     ?ins <- (object (is-a DISEASE))
     ?miscins <- (object (is-a MISC) (isblurred_vision ?isblurr))
     (test (eq ?isblurr yes))
     (frequent-urination yes)
     (hunger yes)
     (thirsty-than-usual yes)
     (skin-itching yes)
     =>
     (send ?ins put-dname "Diabetes"))

(defrule imbalance-blood-pressure "Imbalance Blood Pressure"
     ;(declare (salience 52))
     ?ins <- (object (is-a DISEASE) (location ?loc) (severity ?sev))
     ?miscins <- (object (is-a MISC) (isvomiting ?isvom) (isnausea ?isnausea) (isblurred_vision ?isblurr) (isbreathlessness ?isbreath) (isdizziness ?isdizz))
     (test (eq ?loc chest))
     (test (eq ?sev yes))
     (test (eq ?isvom yes))
     (test (eq ?isnausea yes))
     (test (eq ?isblurr yes))
     (test (eq ?isbreath yes))
     (test (eq ?isdizz yes))
     =>
     (send ?ins put-dname "Imbalance Blood Pressure"))

(defrule heart-disease "Heart Disease"
     ;(declare (salience 52))
     ?ins <- (object (is-a DISEASE))
     ?miscins <- (object (is-a MISC) (isweekness ?isweek) (isfatigue ?isfatig) (isbreathlessness ?isbreath))
     (test (eq ?isweek yes))
     (test (eq ?isbreath yes))
     (test (eq ?isfatig yes))
     (heart-burn yes)
     (fast-heart-beat yes)
     =>
     (send ?ins put-dname "Heart Disease"))

(defrule unknown "Unknown Disease"
     (declare (salience -60))
     ?ins <- (object (is-a DISEASE))
     =>
     (send ?ins put-dname "Unknown"))

(defrule fever-check "Check Fever"
    ?ins <- (object (is-a FEVER))
	=>
	(send ?ins put-isfever (yes-or-no-p "Do you have a fever (yes no)? ")))

(defrule set-fever "Set Fever"
    ;(declare (salience 49))
    ?ins <- (object (is-a FEVER) (isfever yes))
	=>
	(send ?ins put-ishighfever (yes-or-no-p "Does Body temp 102 or more (yes no)? ")))
    

(defrule typhiod-fever "Typhiod Fever"
    ;(declare (salience 49))
    ?ins <- (object (is-a FEVER) (ishighfever yes))
	=>
    (send ?ins put-istyphiodfever (yes-or-no-p "Does fever started slowly then increased severely (yes no)? ")))

(defrule pain-check "Check Pain"
    ;(declare (salience 48))
    ?ins <- (object (is-a PAIN))
	=>
	(send ?ins put-ispain (yes-or-no-p "Do you have a Pain (yes no)? ")))

(defrule pain-location "Set Pain Location"
    ;(declare (salience 47))
    ?ins <- (object (is-a PAIN) (ispain yes))
	=>
	(send ?ins put-location (ask-question "Where do you have a Pain (stomach body muscle joint chest body-muscle muscle-joint)? " stomach body muscle joint chest body-muscle muscle-joint)))

(defrule headache-check "Headache Check"
    ;(declare (salience 46))
    ?ins <- (object (is-a HEADACHE))
	=>
	(send ?ins put-isheadache (yes-or-no-p "Do you have a Headache (yes no)? ")))

(defrule set-severity "Set Headache Severety"
    ?ins <- (object (is-a HEADACHE))
	=>
	(send ?ins put-severity (yes-or-no-p "Is severe Headache (yes no)? ")))

(defrule check-vommiting "Check Vomitting"
    ?ins <- (object (is-a MISC))
	=>
	(send ?ins put-isvomiting (yes-or-no-p "Do you have vommiting problem (yes no)? "))
    (send ?ins put-isnausea (yes-or-no-p "Do you have Nausea problem (yes no)? ")))

(defrule check-weekness "Check weekness"
    ?ins <- (object (is-a MISC))
	=>
    (send ?ins put-isfatigue (yes-or-no-p "Do you have fatigue problem (yes no)? "))
    (send ?ins put-isweekness (yes-or-no-p "Do you have weekness problem (yes no)? "))
    (send ?ins put-isdizziness (yes-or-no-p "Do you have dizziness problem (yes no)? ")))

(defrule check-chills ""
    (not (chills ?))
    =>
    (assert (chills
              (yes-or-no-p "Do you have chills symptom (yes/no)? "))))

(defrule check-sore-throat ""
    (not (sore-throat ?))
    =>
    (assert (sore-throat
              (yes-or-no-p "Do you have Sore throat symptom (yes/no)? "))))

(defrule check-swollen-lymph-glands ""
    (not (swollen-lymph-glands ?))
    =>
    (assert (swollen-lymph-glands
              (yes-or-no-p "Do you have swollen lymph glands symptom (yes/no)? "))))

(defrule check-weight-loss ""
    (not (weight-loss ?))
    =>
    (assert (weight-loss
              (yes-or-no-p "Do you have weight loss symptom (yes/no)? "))))

(defrule check-dry-cough ""
    (not (dry-cough ?))
    =>
    (assert (dry-cough
              (yes-or-no-p "Do you have dry cough symptom (yes/no)? "))))

(defrule check-sweating ""
    (not (sweating ?))
    =>
    (assert (sweating
              (yes-or-no-p "Do you have sweating symptom (yes/no)? "))))

(defrule check-dehydration ""
    (not (dehydration ?))
    =>
    (assert (dehydration
              (yes-or-no-p "Do you have dehydration symptom (yes/no)? "))))


(defrule check-joint-stiffness ""
    (not (joint-stiffness ?))
    =>
    (assert (joint-stiffness
              (yes-or-no-p "Do you have joint stiffness symptom (yes/no)? "))))

(defrule check-joint-swelling ""
    (not (joint-swelling ?))
    =>
    (assert (joint-swelling
              (yes-or-no-p "Do you have joint-swelling symptom (yes/no)? "))))

(defrule check-low-range-ofmotion ""
    (not (low-range-ofmotion ?))
    =>
    (assert (low-range-ofmotion
              (yes-or-no-p "Do you have low range of motion symptom (yes/no)? "))))

(defrule check-frequent-urination ""
    (not (frequent-urination ?))
    =>
    (assert (frequent-urination
              (yes-or-no-p "Do you have frequent-urination symptom (yes/no)? "))))

(defrule check-hunger ""
    (not (hunger ?))
    =>
    (assert (hunger
              (yes-or-no-p "Do you have hunger symptom (yes/no)? "))))

(defrule check-thirsty-than-usual ""
    (not (thirsty-than-usual ?))
    =>
    (assert (thirsty-than-usual
              (yes-or-no-p "Do you have thirsty-than-usual symptom (yes/no)? "))))

(defrule check-skin-itching ""
    (not (skin-itching ?))
    =>
    (assert (skin-itching
              (yes-or-no-p "Do you have skin-itching symptom (yes/no)? "))))

(defrule check-heart-burn ""
    (not (heart-burn ?))
    =>
    (assert (heart-burn
              (yes-or-no-p "Do you have heart-burn symptom (yes/no)? "))))

(defrule check-fast-heart-beat ""
    (not (fast-heart-beat ?))
    =>
    (assert (fast-heart-beat
              (yes-or-no-p "Do you have fast heart beat symptom (yes/no)? "))))

(defrule check-loose-stool ""
    (not (loose-stool ?))
    =>
    (assert (loose-stool
              (yes-or-no-p "Do you have loose-stool symptom (yes/no)? "))))

(defrule check-bowel-movement ""
    (not (bowel-movement ?))
    =>
    (assert (bowel-movement
              (yes-or-no-p "Do you have urgent need to bowel-movement symptom (yes/no)? "))))

(defrule check-abdominal-cramping ""
    (not (abdominal-cramping ?))
    =>
    (assert (abdominal-cramping
              (yes-or-no-p "Do you have abdominal cramping symptom (yes/no)? "))))



;;*******************
;;Instance Creation
;;*******************
(definstances DISEASE-INSTANCES
    (disease of DISEASE))

(definstances MISC-INSTANCES
    (misc of MISC))

(definstances PERSON-INSTANCES
    (person of PERSON))

(definstances INTERMEDIATE-DISEASE-INSTANCES
    (intdisease of INTERMEDIATE-DISEASE))

;;**********************
;;Program begins
;;**********************
(defrule prog-begin "Program Begin"
    (declare (salience 60))
    (object (is-a DISEASE) (dname ?dis_name))
    (test (neq ?dis_name nil))
	=>
	(printout t "The predicted Disease is : " ?dis_name crlf))



;;**********************
;;working on doctor
;;**********************
(defrule set-pediatrician "set prescribed doctor to Pediatrician"
    (declare (salience 60))
    ?ins <- (object (is-a DISEASE) (dname ?dis_name))
    (object (is-a PERSON) (age ?age))
    (test (neq ?dis_name nil))
    (test (eq ?age child))
	=>
	(send ?ins put-pdoctor "Pediatrician"))

(defrule set-cardiologist "set prescribed doctor to Cardiologist"
    (declare (salience 60))
    ?ins <- (object (is-a DISEASE) (dname ?dis_name))
    (object (is-a PERSON) (age ?age))
    (test (neq ?dis_name nil))
    (test (eq ?age adult))
    (test (or (eq ?dis_name "Heart Disease") (eq ?dis_name "Imbalance Blood Pressure")))
	=>
	(send ?ins put-pdoctor "Cardiologist"))

(defrule set-Infectious "set prescribed doctor to Infectious disease doctors"
    (declare (salience 60))
    ?ins <- (object (is-a DISEASE) (dname ?dis_name))
    (object (is-a PERSON) (age ?age))
    (test (neq ?dis_name nil))
    (test (eq ?age adult))
    (test (eq ?dis_name "HIV AIDS"))
	=>
	(send ?ins put-pdoctor "Infectious disease doctors"))

(defrule set-endocrinologists "set prescribed doctor to Endocrinologists"
    (declare (salience 60))
    ?ins <- (object (is-a DISEASE) (dname ?dis_name))
    (object (is-a PERSON) (age ?age))
    (test (neq ?dis_name nil))
    (test (eq ?age adult))
    (test (eq ?dis_name "Diabetes"))
	=>
	(send ?ins put-pdoctor "Endocrinologists or Nephrologists"))

(defrule set-orthopedic "set prescribed doctor to Orthopedic"
    (declare (salience 60))
    ?ins <- (object (is-a DISEASE) (dname ?dis_name))
    (object (is-a PERSON) (age ?age))
    (test (neq ?dis_name nil))
    (test (eq ?age adult))
    (test (eq ?dis_name "Arthritis"))
	=>
	(send ?ins put-pdoctor "Orthopedic"))

(defrule set-physician "set prescribed doctor to physician"
    (declare (salience 60))
    ?ins <- (object (is-a DISEASE) (dname ?dis_name))
    (object (is-a PERSON) (age ?age))
    (test (neq ?dis_name nil))
    (test (eq ?age adult))
	=>
	(send ?ins put-pdoctor "General Physician"))


;;**********************
;;Program End
;;**********************
(defrule prescribed-doc "Prescribed Doctor"
    (declare (salience 60))
    (object (is-a DISEASE) (pdoctor ?pdoctor))
    (test (neq ?pdoctor nil))
    =>
    (printout t "The prescribed doctor: " ?pdoctor crlf)
    (halt))