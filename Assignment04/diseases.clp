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
	(slot dname))


;Rules

(defrule person-check "Person Data"
    (declare (salience 51))
    ?ins <- (object (is-a PERSON))
	=>
	(send ?ins put-gender (ask-question "What is you gender? (male female)? " male female)))

(defrule maleria "Maleria"
     ;(declare (salience 52))
     ?ins <- (object (is-a DISEASE) (ishighfever ?hf) (location ?loc) (severity ?sev))
     ?miscins <- (object (is-a MISC) (isvomiting ?isvom) (isfatigue ?isfatig))
     (test (eq ?loc body-muscle))
     (test (eq ?hf yes))
     (test (eq ?sev yes))
     (test (eq ?isvom yes))
     (test (eq ?isfatig yes))
     =>
     (send ?ins put-dname "Maleria"))

(defrule fever-check "Check Fever"
    ;(declare (salience 50))
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



(definstances DISEASE-INSTANCES
    (disease of DISEASE))

(definstances MISC-INSTANCES
    (misc of MISC))

(definstances PERSON-INSTANCES
    (person of PERSON))

(defrule prog-begin "Program Begin"
    (declare (salience 60))
    (object (is-a DISEASE) (dname ?dis_name))
    (test (neq ?dis_name nil))
	=>
	(printout t ?dis_name " is the disease" crlf)
   (halt))
