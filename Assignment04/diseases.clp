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
