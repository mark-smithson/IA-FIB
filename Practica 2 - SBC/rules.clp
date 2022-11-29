;
; (load ontologia_prac.clp)
;
;

;Funcio que implenta la pregunta per llegir un double
(deffunction ask-double (?question)
	(printout t ?question)
	(bind ?answer (read))
	(while (lexemep ?answer) do
		(printout t ?question)
		(bind ?answer (read))
		)
	(float ?answer)
)

;Funcio que implenta la pregunta per llegir un int
(deffunction ask-int (?question)
	(printout t ?question)
	(bind ?answer (read))
	(while (lexemep ?answer) do
		(printout t ?question)
		(bind ?answer (read))
		)
	(integer ?answer))


;Funcio que implenta la pregunta per llegir un string
(deffunction stringg-question (?question)
	(format t "%s" ?question)
	(bind ?answer (read))
	?answer
)
;Funcio que implenta la pregunta de tipus si o no (booleana)
;(deffunction yes-or-no-p (?question)
 ;  (bind ?response (ask-question ?question si no s n))
  ; (if (or (eq ?response si) (eq ?response s))
   ;    then TRUE
    ;   else FALSE)
;)

(defmodule MAIN (export ?ALL))

;Aquí podríamos dar la bienvenida
(defrule initial  
    (initial-fact) 
    =>
    (printout t "----Hola----" crlf)
    (printout t crlf)
    (assert(newPersona))
    (focus PREGUNTES)
)

(defmodule PREGUNTES (export ?ALL) (import MAIN ?ALL))


(defrule PREGUNTES::askName
	(newPersona)
    ?x <- (object(is-a Persona))
	=>
	(bind ?name (stringg-question "Como te llamas? "))
    (send ?x put-nombre ?name)
)

(defrule PREGUNTES::askAge
	(newPersona)
    ?x <- (object(is-a Persona))
	=>
	(bind ?age (ask-int "Cuantos años tienes? "))
    (send ?x put-edad ?age)
)

(defrule PREGUNTES::askHeight
	(newPersona)
    ?x <- (object(is-a Persona))
	=>
	(bind ?height (ask-int "Cuanto mides? "))
    (send ?x put-altura ?height)
)

(defrule PREGUNTES::askWeight
	(newPersona)
    ?x <- (object(is-a Persona))
	=>
	(bind ?weight (ask-double "Cuanto pesas? "))
    (send ?x put-peso ?weight)
)

(defrule PREGUNTES::askGender
	(newPersona)
    ?x <- (object(is-a Persona))
	=>
	(bind ?gender (stringg-question "Sexo: Mujer(F) o Hombre(M)"))
    (send ?x put-sexo ?gender)
)

;(defrule PREGUNTES::askRedMob
;	(newPersona)
 ;   ?x <- (object(is-a Persona))
;	=>
;	(bind ?redMob (yes-or-no-p "Eres una persona con movilidad reducida? si o no"))
 ;   (send ?x put-mobilidad_reducida ?redMob)

;)