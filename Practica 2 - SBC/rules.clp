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
   ?answer
)

;Funcio que implenta la pregunta de tipus si o no (booleana)
(deffunction yes-or-no-p (?question)
   (bind ?response (ask-question ?question si no s n))
   (if (or (eq ?response si) (eq ?response s))
       then TRUE
       else FALSE)
)


(deffunction assignExercise (?ejercicio ?sesion ?calentamientorec)
	;2 ej principal 1 calentamiento y rec
	
	(switch ?calentamientorec 
		(case 1 then 
		(bind ?ejsSes (send ?sesion get-Calentamiento))
		(bind ?ejsSesR (send ?sesion get-Estiramientos))
		(bind ?ejsSes (insert$ ?ejsSes (+(length$ ?ejsSes)1)?ejercicio))
		(bind ?ejsSesR (insert$ ?ejsSesR (+(length$ ?ejsSesR)1)?ejercicio))
		(send ?sesion put-Calentamiento ?ejsSes)
		(send ?sesion put-Estiramientos ?ejsSesR)
		)
		(case 2 then
		(bind ?ejsSes (send ?sesion get-EjPrincipal))
		(bind ?ejsSes (insert$ ?ejsSes (+(length$ ?ejsSes)1)?ejercicio))
		(send ?sesion put-EjPrincipal ?ejsSes)
		)
	)
)

(deffunction duracionSesion (?sesion)
	(bind ?count 0)
	(bind ?calentamientos (send ?sesion get-Calentamiento))
	(bind ?principales (send ?sesion get-EjPrincipal))
	(bind ?estiramientos (send ?sesion get-Estiramientos))

	(foreach ?calentamiento ?calentamientos do
		(bind ?count (+ ?count (send ?calentamiento get-duracionEj)))
	)

	; Sum time principales
	(foreach ?principal ?principales do
		(bind ?count (+ ?count (send ?principal get-duracionEj)))
	)

	; Sum time recuperaciones
	(foreach ?estiramiento ?estiramientos do
		(bind ?count (+ ?count (send ?estiramiento get-duracionEj)))
	)

	; Return
	(return ?count)
)


(deffunction duracionOK (?sesion ?ejercicio ?persona)

	(bind ?frec (send ?ejercicio get-frecuencia))
	(if (> ?frec 0) then 
		(bind ?intPersona (send ?persona get-preferencia_intensidad))


		(if (or (eq ?intPersona 1) (eq ?intPersona 2)) then
			(bind ?maxDuracion 30)
		)

		(if (or (eq ?intPersona 3) (eq ?intPersona 4)) then
			(bind ?maxDuracion 45)
		)

		(if (or (eq ?intPersona 5) (eq ?intPersona 6) (eq ?intPersona 7)) then
			(bind ?maxDuracion 60)
		)

		(if (or (eq ?intPersona 8) (eq ?intPersona 9) (eq ?intPersona 10)) then
			(bind ?maxDuracion 90)
		)

		(bind ?duracionS (duracionSesion ?sesion) )

		(if (> (+ ?duracionS (send ?ejercicio get-duracionEj)) ?maxDuracion) 
			then (return FALSE)
			else (return TRUE)
		)
	else (return FALSE)
	)
)

(deffunction ActBaja (?cfisica)
	(bind ?cbaja (send ?cfisica get-Cbaja))
	(bind ?cbaja (+ ?cbaja 1))
	(send ?cfisica put-Cbaja ?cbaja)
	;(printout t crlf "baja ara és: " ?cbaja crlf)
)

(deffunction ActAlta (?cfisica)
	(bind ?calta (send ?cfisica get-Calta))
	(bind ?calta (+ ?calta 1))
	(send ?cfisica put-Calta ?calta)
	;(printout t crlf "alta ara és: " ?calta crlf)
)

(deffunction calcIMC (?x ?c)
	;;Calcular bmi index: (kg / m^2)
	(bind ?pes (send ?x get-peso))
	(bind ?altura (/ (send ?x get-altura) 100)) ;passat a metres
	(bind ?altura2 (* ?altura ?altura) )
	(bind ?bmiPersona (/ ?pes ?altura2))
	(send ?x put-imc ?bmiPersona)
	(if (or (< ?bmiPersona 18.5) (> ?bmiPersona 24)) then (ActBaja ?c)
	 else (ActAlta ?c))
)

(defmodule MAIN (export ?ALL))

;Aquí podríamos dar la bienvenida
(defrule initial
    (initial-fact)
    =>
    (printout t "----Hola----" crlf)
    (printout t crlf)
    (assert(newPersona))
	;(make-instance p of Persona)
    (focus PREGUNTES)
)


(defmodule PREGUNTES (export ?ALL) (import MAIN ?ALL))


(defrule PREGUNTES::askName
	(newPersona)
	=>
	(bind ?name (stringg-question "Como te llamas? "))
	(bind ?x (make-instance ?name of Persona))
	(send ?x put-nombre ?name)
)

(defrule PREGUNTES::askAge
	(newPersona)
    ?x <- (object(is-a Persona))
	=>
	(bind ?age (ask-int "Cuantos años tienes? "))
	(if (< ?age 65) then (printout t crlf "Lo sentimos, no cumples con los requisitos de edad" crlf)(exit))
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
	(bind ?gender (stringg-question "Sexo: Mujer(F) o Hombre(M) "))
    (send ?x put-sexo ?gender)
)

(defrule PREGUNTES::askIntensity
	(newPersona)
    ?x <- (object(is-a Persona))
	=>
	(bind ?intensity (ask-int "Que intensidad prefieres para tu plan del 1 al 10? "))
	(if (or (> ?intensity 10) (< ?intensity 1) ) then (printout t crlf "Lo sentimos, el número introducido no está entra 1 y 10" crlf)(exit))

    (send ?x put-preferencia_intensidad ?intensity)
)

(defrule PREGUNTES::askAvailability
	(newPersona)
    ?x <- (object(is-a Persona))
	=>
	(bind ?availability (ask-int "Que disponibilidad tienes? (3-7) "))
	(if (or (> ?availability 7) (< ?availability 3) ) then (printout t crlf "Lo sentimos, no cumples con los requisitos de disponibilidad" crlf)(exit))
    (send ?x put-disponibilidad ?availability)
	(bind ?count 1)
	(while (<= ?count ?availability) do
		(switch ?count
			(case 1 then
				(make-instance [Dia_1] of Sesion (dia (str-cat "Dia " ?count) ))
			)
			(case 2 then
				(make-instance [Dia_2] of Sesion (dia (str-cat "Dia " ?count) ))
			)
			(case 3 then
				(make-instance [Dia_3] of Sesion (dia (str-cat "Dia " ?count) ))
			)
			(case 4 then
				(make-instance [Dia_4] of Sesion (dia (str-cat "Dia " ?count) ))
			)
			(case 5 then
				(make-instance [Dia_5] of Sesion (dia (str-cat "Dia " ?count) ))
			)
			(case 6 then
				(make-instance [Dia_6] of Sesion (dia (str-cat "Dia " ?count) ))
			)
			(case 7 then
				(make-instance [Dia_7] of Sesion (dia (str-cat "Dia " ?count) ))
			)

		)	
		(bind ?count (+ ?count 1))
	)	

)


(defrule PREGUNTES::askRedMob
	(newPersona)
    ?x <- (object(is-a Persona))
	=>
	(bind ?redMob (yes-or-no-p "Eres una persona con movilidad reducida? si o no "))
    (send ?x put-mobilidad_reducida ?redMob)
	(if (eq ?redMob FALSE) then (assert (RedMobOK)))
)

;;	Preguntes sobre la condició física ;;

(defrule PREGUNTES::askStairs
	(newPersona)
    ?x <- (object(is-a Persona))
	=>
	(bind ?stairs (yes-or-no-p "Te ahogas al subir las escaleras? si o no "))
    (bind ?c (make-instance of CondicionFisica))
	(send ?c put-ahoga_subir_escalera ?stairs)
	(if (eq ?stairs FALSE) then
		(assert (StairsOK))
		(ActAlta ?c)
	else (ActBaja ?c)
	)
)

(defrule PREGUNTES::askAlcohol
	(newPersona)
    ?x <- (object(is-a Persona))
	?c <- (object(is-a CondicionFisica))
	=>
	(bind ?alch (yes-or-no-p "Sueles beber alcohol con frecuencia? si o no "))
	(send ?c put-bebe_alcohol ?alch)
	(if (eq ?alch FALSE) then
		(assert (AlcoholOK))
		(ActAlta ?c)
	else (ActBaja ?c)
	)
)

(defrule PREGUNTES::askF
	(newPersona)
    ?x <- (object(is-a Persona))
	?c <- (object(is-a CondicionFisica))
	=>
	(bind ?caidas (yes-or-no-p "Tienes caídas frecuentes? si o no "))
	(send ?c put-caidas_frecuentemente ?caidas)
	(if (eq ?caidas FALSE) then
		(assert (CaidasOK))
		(ActAlta ?c)
	else (ActBaja ?c)
	)
)

(defrule PREGUNTES::askTired
	(newPersona)
    ?x <- (object(is-a Persona))
	?c <- (object(is-a CondicionFisica))
	=>
	(bind ?cansancio (yes-or-no-p "Te sueles cansar rápidamente? si o no "))
	(send ?c put-cansancio_rapido ?cansancio)
	(if (eq ?cansancio FALSE) then
		(assert (CansancioOK))
		(ActAlta ?c)
	else (ActBaja ?c)
	)
)

(defrule PREGUNTES::askJunkFood
	(newPersona)
    ?x <- (object(is-a Persona))
	?c <- (object(is-a CondicionFisica))
	=>
	(bind ?cbasura (yes-or-no-p "Sueles comer comida basura con frecuencia? si o no "))
	(send ?c put-comida_basura ?cbasura)
	(if (eq ?cbasura FALSE) then
		(assert (CBasuraOK))
		(ActAlta ?c)
	else (ActBaja ?c)
	)
)

(defrule PREGUNTES::askShopping
	(newPersona)
    ?x <- (object(is-a Persona))
	?c <- (object(is-a CondicionFisica))
	=>
	(bind ?compra (yes-or-no-p "Sueles ir a comprar con frecuencia? si o no "))
	(send ?c put-compra_con_frecuencia ?compra)
	(if (eq ?compra TRUE) then
		(assert (ComprasOK))
		(ActAlta ?c)
	else (ActBaja ?c)
	)
)

(defrule PREGUNTES::askRunning
	(newPersona)
    ?x <- (object(is-a Persona))
	?c <- (object(is-a CondicionFisica))
	=>
	(bind ?corre (yes-or-no-p "Sueles ir a correr con frecuencia? si o no "))
	(send ?c put-corre_con_frecuencia ?corre)
	(if (eq ?corre TRUE) then
		(assert (RunningOK))
		(ActAlta ?c)
	else (ActBaja ?c)
	
	)
)

(defrule PREGUNTES::askSports
	(newPersona)
    ?x <- (object(is-a Persona))
	?c <- (object(is-a CondicionFisica))
	=>
	(bind ?deporte (yes-or-no-p "Sueles practicar algún deporte con frecuencia? si o no "))
	(send ?c put-deporte_con_frecuencia ?deporte)
	(if (eq ?deporte TRUE) then
		(assert (DeporteOK))
		(ActAlta ?c)
	else (ActBaja ?c)
	)
)

(defrule PREGUNTES::askDiet
	(newPersona)
    ?x <- (object(is-a Persona))
	?c <- (object(is-a CondicionFisica))
	=>
	(bind ?dieta (yes-or-no-p "Tienes una dieta variada? si o no "))
	(send ?c put-dieta_variada ?dieta)
	(if (eq ?dieta TRUE) then
		(assert (DietaOK))
		(ActAlta ?c)
	else (ActBaja ?c)
	
	)
)

(defrule PREGUNTES::askSleep
	(newPersona)
    ?x <- (object(is-a Persona))
	?c <- (object(is-a CondicionFisica))
	=>
	(bind ?duerme (yes-or-no-p "Sueles dormir bien? si o no "))
	(send ?c put-duerme_bien ?duerme)
	(if (eq ?duerme TRUE) then 
		(assert (DuermeOK))
		(ActAlta ?c)
	else (ActBaja ?c)
	)
)

(defrule PREGUNTES::askSmoking
	(newPersona)
    ?x <- (object(is-a Persona))
	?c <- (object(is-a CondicionFisica))
	=>
	(bind ?fuma (yes-or-no-p "Fumas? si o no "))
	(send ?c put-fuma ?fuma)
	(if (eq ?fuma FALSE) then
		(assert (FumaOK))
		(ActAlta ?c)
	else (ActBaja ?c)
	)
)

(defrule PREGUNTES::askOperations
	(newPersona)
    ?x <- (object(is-a Persona))
	?c <- (object(is-a CondicionFisica))
	=>
	(bind ?operaciones (yes-or-no-p "Has tenido alguna operación reciente? si o no "))
	(if (eq ?operaciones TRUE) then
		(bind ?operS (yes-or-no-p "Es en el tronco superior si o no "))
		(send ?c put-operaciones_recientes_superior ?operS)
		(if (eq ?operS FALSE) then (assert (OperacionesSuperiorOK)))
		(bind ?operI (yes-or-no-p "Es en el tronco inferior si o no "))
		(send ?c put-operaciones_recientes_inferior ?operI)
		(if (eq ?operI FALSE) then (assert (OperacionesInferiorOK)))
		(ActBaja ?c)
	)
	(if (neq ?operaciones TRUE) then
	(assert (OperacionesSuperiorOK))
	(assert (OperacionesInferiorOK))
	(ActAlta ?c)
	)

)

(defrule PREGUNTES::askWalking
	(newPersona)
    ?x <- (object(is-a Persona))
	?c <- (object(is-a CondicionFisica))
	=>
	(bind ?pasea (yes-or-no-p "Sueles salir a pasear con frecuencia? si o no "))
	(send ?c put-pasea_con_frecuencia ?pasea)
	(if (eq ?pasea TRUE) then
		(assert (PaseaOK))
		(ActAlta ?c)
	else (ActBaja ?c)
	)
)

(defrule PREGUNTES::askMusclePull
	(newPersona)
    ?x <- (object(is-a Persona))
	?c <- (object(is-a CondicionFisica))
	=>
	(bind ?tirones (yes-or-no-p "Sueles tener tirones con frecuencia? si o no "))
	(send ?c put-tirones_frecuentemente ?tirones)
	(if (eq ?tirones FALSE) then 
		(assert (TironesOK))
		(ActAlta ?c)
	else (ActBaja ?c)
	)
)

(defrule PREGUNTES::askPain
	(newPersona)
    ?x <- (object(is-a Persona))
	?c <- (object(is-a CondicionFisica))
	=>
	(bind ?dolorart (yes-or-no-p "Te duelen las articulaciones con frecuencia? si o no "))
	(if (eq ?dolorart TRUE) then
		(bind ?dolorartS (yes-or-no-p "Suele ser en las articulaciones superiores si o no "))
		(send ?c put-dolor_articulaciones_tronco_superior ?dolorartS)
		(if (eq ?dolorartS FALSE) then (assert (TroncoSuperiorOK)))
		(bind ?dolorartI (yes-or-no-p "Suele ser en las articulaciones inferiores si o no "))
		(send ?c put-dolor_articulaciones_tronco_inferior ?dolorartI)
		(if (eq ?dolorartI FALSE) then (assert (TroncoInferiorOK)))
		(ActBaja ?c)
	)
	(if (neq ?dolorart TRUE) then
	 (assert (TroncoSuperiorOK))
	 (assert (TroncoInferiorOK))
	 (ActAlta ?c)
	)
	(calcIMC ?x ?c)
)

;;PREGUNTES SOBRE POSSIBLES ENFERMETATS;;

(defrule PREGUNTES::askArtrosis 
	(newPersona)
    ?x <- (object(is-a Persona))
	?Eartrosis <- (object(is-a artrosis))
	=>
	(bind ?artrosiis (yes-or-no-p "Padeces de artrosis? si o no "))
	
	(if (eq ?artrosiis TRUE) then
		(slot-insert$ ?x padece_de 1 ?Eartrosis)
		(assert(artrosis))
	)

)

(defrule PREGUNTES::askArtritis
	(newPersona)
    ?x <- (object(is-a Persona))
	?Eartritis <- (object(is-a artritis))
	=>
	(bind ?artritis (yes-or-no-p "Padeces de artritis? si o no "))
	(if (eq ?artritis TRUE) then
		(slot-insert$ ?x padece_de 1 ?Eartritis)
		(assert(artritis))
	)
)


(defrule PREGUNTES::askDepression
	(newPersona)
    ?x <- (object(is-a Persona))
	?EDepresion <- (object(is-a depresion))
	=>
	(bind ?depresion (yes-or-no-p "Padeces de depresión? si o no "))
	(if (eq ?depresion TRUE) then
		(slot-insert$ ?x padece_de 1 ?EDepresion)
		(assert(depresion))
	)
)

(defrule PREGUNTES::askDiabetes ;tipos de diabates???
	(newPersona)
    ?x <- (object(is-a Persona))
	?EDiabetes <- (object(is-a diabetes))
	=>
	(bind ?diabetes (yes-or-no-p "Padeces de diabetes? si o no "))
	(if (eq ?diabetes TRUE) then
		(slot-insert$ ?x padece_de 1 ?EDiabetes)
		(assert(diabetes))
	)
)

(defrule PREGUNTES::askCor
	(newPersona)
    ?x <- (object(is-a Persona))
	?Ecoronarias <- (object(is-a enfermedades_cardiovasculares))
	=>
	(bind ?coronarias (yes-or-no-p "Padeces de alguna enfermedad coronaria? si o no "))
	(if (eq ?coronarias TRUE) then
		(slot-insert$ ?x padece_de 1 ?Ecoronarias)
		(assert(coronarias))
	)
)

(defrule PREGUNTES::askCardiovascular
	(newPersona)
    ?x <- (object(is-a Persona))
	?Ecardiovascular <- (object(is-a enfermedades_cardiovasculares))
	=>
	(bind ?cardiovascular (yes-or-no-p "Padeces de alguna enfermedad cardiovascular? si o no "))
	(if (eq ?cardiovascular TRUE) then
		(slot-insert$ ?x padece_de 1 ?Ecardiovascular)
		(assert(cardiovascular))
	)
)

(defrule PREGUNTES::askBalance
	(newPersona)
    ?x <- (object(is-a Persona))
	?Eequilibrio <- (object(is-a falta_equilibrio))
	=>
	(bind ?faltae (yes-or-no-p "Sientes una considerable falta de equilibrio? si o no "))
	(if (eq ?faltae TRUE) then
		(slot-insert$ ?x padece_de 1 ?Eequilibrio)
		(assert(Faltaequilibrio))
	)
)

(defrule PREGUNTES::askFibromialgia
	(newPersona)
    ?x <- (object(is-a Persona))
	?EFibromialgia <- (object(is-a fibromialgia))
	=>
	(bind ?fibro (yes-or-no-p "Padeces de fibromialgia? si o no "))
	(if (eq ?fibro TRUE) then
		(slot-insert$ ?x padece_de 1 ?EFibromialgia)
		(assert(fibromialgia))
	)
)

(defrule PREGUNTES::askBloodPressure
	(newPersona)
    ?x <- (object(is-a Persona))
	?Ehipertension <- (object(is-a hipertension))
	=>
	(bind ?hipertension (yes-or-no-p "Padeces de hipertensión? si o no "))
	(if (eq ?hipertension TRUE) then
		(slot-insert$ ?x padece_de 1 ?Ehipertension)
		(assert(hipertension))
	)
)


(defrule PREGUNTES::askObesidad 
	(newPersona)
    ?x <- (object(is-a Persona))
	?Eobesidad <- (object(is-a obesidad))
	=>
	(bind ?obesidad (yes-or-no-p "Padeces de obesidad? si o no "))
	(if (eq ?obesidad TRUE) then
		(slot-insert$ ?x padece_de 1 ?Eobesidad)
		(assert(obesidad))
	)
)

(defrule PREGUNTES::askOsteoporosis
	(newPersona)
    ?x <- (object(is-a Persona))
	?Eosteoporosis <- (object(is-a osteoporosis))
	=>
	(bind ?osteo (yes-or-no-p "Padeces de osteoporosis? si o no "))
	(if (eq ?osteo TRUE) then
		(slot-insert$ ?x padece_de 1 ?Eosteoporosis) ;esto no hace nada??
		(assert(osteoporosis))
	)
)

(defrule PREGUNTES::askParkinson
	(newPersona)
    ?x <- (object(is-a Persona))
	?Eparkinson <- (object(is-a parkinson))
	=>
	(bind ?parkinson (yes-or-no-p "Padeces de parkinson? si o no "))
	(if (eq ?parkinson TRUE) then
		(slot-insert$ ?x padece_de 1 ?Eparkinson)
		(assert(parkinson))
	)
	
)

(defrule noMoreQuest 
	(newPersona)
	=>
	(bind ?planPrueba (make-instance planPrueba of Plan
		(compuesto_por (find-all-instances ((?s Sesion))(neq ?s [nil])))
	))
	(assert(planprueba ?planPrueba))
	(focus CONDFIS)
)


(defmodule CONDFIS (import MAIN ?ALL)(import PREGUNTES ?ALL)(export ?ALL))

(defrule decideCondicionFisica
	(newPersona)
	?x<-(object(is-a Persona))
	?c<- (object(is-a CondicionFisica))
	=>
	(bind ?totalBaja (send ?c get-Cbaja))
	(bind ?totalAlta (send ?c get-Calta))
	(bind ?res (- ?totalBaja ?totalAlta))
	(bind ?res (abs ?res))
	(if (< ?res 4) then (send ?c put-CondFisica 5 )
	else 
		(if (> ?totalAlta ?totalBaja) then (send ?c put-CondFisica 8)
		else (send ?c put-CondFisica 2)
		)
	)	
)

(defrule ponderacionCondFisica 
	(newPersona)
	?x<- (object(is-a Persona))
	?c<- (object(is-a CondicionFisica))
	=>
	(bind ?int (* (send ?x get-preferencia_intensidad) 30))
	(bind ?cf (* (send ?c get-CondFisica) 70))
	(bind ?suma (/(+ ?int ?cf)100) )
	(send ?x put-preferencia_intensidad (integer ?suma))
	(focus FILTRE_1)
)

(defmodule FILTRE_1 (import MAIN ?ALL) (import PREGUNTES ?ALL)(import CONDFIS ?ALL)(export ?ALL))

;Per cada exercici escull si poden formar part del plan de newPersona o no

;Exercicis aeròbics
(defrule ejBaile
	(newPersona)
	(RedMobOK)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(or (depresion)(diabetes)(enfermedades_coronarias)(hipertension)(obesidad))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Bailar") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
	(bind ?intA (send ?x get-preferencia_intensidad))
	(if (< ?intA 5) 
		then (send ?exe put-duracionEj 10)
		else (send ?exe put-duracionEj 20)
	)
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejBici
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (depresion)(diabetes)(coronarias)(cardiovascular)(hipertension)(obesidad)(artritis)(fibromialgia))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Bici") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
	(bind ?intA (send ?x get-preferencia_intensidad))
	(if (< ?intA 5) 
		then (send ?exe put-duracionEj 10)
		else (send ?exe put-duracionEj 20)
	)
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejBiciSuperior
	(newPersona)
	(TroncoSuperiorOK)
	(OperacionesSuperiorOK)
	(or (depresion)(diabetes)(coronarias)(cardiovascular)(hipertension)(obesidad)(artritis)(fibromialgia))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Bici de tren superior") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
	(bind ?intA (send ?x get-preferencia_intensidad))
	(if (< ?intA 5) 
		then (send ?exe put-duracionEj 10)
		else (send ?exe put-duracionEj 20)
	)
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejCaminar
	(newPersona)
	(TroncoInferiorOK)
	(RedMobOK)
	(OperacionesInferiorOK)
	(or (depresion)(diabetes)(coronarias)(cardiovascular)(hipertension)(obesidad)(artritis)(fibromialgia)(osteoporosis)(artrosis))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Caminar") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
	(bind ?intA (send ?x get-preferencia_intensidad))
	(if (< ?intA 5) 
		then (send ?exe put-duracionEj 10)
		else (send ?exe put-duracionEj 20)
	)
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejCorrer
	(newPersona)
	(TroncoInferiorOK)
	(RedMobOK)
	(OperacionesInferiorOK)
	(or (depresion)(diabetes)(coronarias)(hipertension)(obesidad))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Correr") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
	(bind ?intA (send ?x get-preferencia_intensidad))
	(if (< ?intA 5) 
		then (send ?exe put-duracionEj 10)
		else (send ?exe put-duracionEj 20)
	)

	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)

	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejNadar
	(newPersona)
	(TroncoSuperiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(OperacionesInferiorOK)
	(OperacionesSuperiorOK)
	(or (depresion)(diabetes)(hipertension)(obesidad)(artritis)(fibromialgia))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Nadar") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
	(bind ?intA (send ?x get-preferencia_intensidad))
	(if (< ?intA 5) 
		then (send ?exe put-duracionEj 10)
		else (send ?exe put-duracionEj 20)
	)

	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

;Exercicis D'EQUILIBRI

(defrule ejAndarPuntillas
	(newPersona)
	(TroncoInferiorOK)
	(OperacionesInferiorOK)
	(RedMobOK)
	(or (diabetes)(hipertension)(obesidad)(osteoporosis)(fibromialgia)(Faltaequilibrio))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Andar de puntillas") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
	(bind ?intA (send ?x get-preferencia_intensidad))
	(if (< ?intA 5) 
		then (send ?exe put-duracionEj 2)
		else (send ?exe put-duracionEj 5)
	)
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejFlexionDeCadera
	(newPersona)
	(TroncoInferiorOK)
	(TroncoSuperiorOK)
	(OperacionesSuperiorOK)
	(OperacionesInferiorOK)
	(RedMobOK)
	(or (diabetes)(hipertension)(obesidad)(fibromialgia)(Faltaequilibrio))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Flexión de cadera") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
	(bind ?intA (send ?x get-preferencia_intensidad))
	(if (< ?intA 5) 
		then (send ?exe put-duracionEj 2)
		else (send ?exe put-duracionEj 4)
	)
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejExtensionDeCadera
	(newPersona)
	(TroncoInferiorOK)
	(TroncoSuperiorOK)
	(OperacionesSuperiorOK)
	(OperacionesInferiorOK)
	(RedMobOK)
	(or (diabetes)(hipertension)(obesidad)(fibromialgia)(Faltaequilibrio))
	?p<-(planprueba ?planPrueba)
	?x<- (object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Extensión de cadera") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
	(bind ?intA (send ?x get-preferencia_intensidad))
	(if (< ?intA 5) 
		then (send ?exe put-duracionEj 2)
		else (send ?exe put-duracionEj 4)
	)
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejLevLateralPierna
	(newPersona)
	(TroncoInferiorOK)
	(OperacionesInferiorOK)
	(RedMobOK)
	(or (diabetes)(hipertension)(obesidad)(fibromialgia)(osteoporosis)(Faltaequilibrio))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj  "Levantamiento lateral pierna") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
	(bind ?intA (send ?x get-preferencia_intensidad))
	(if (< ?intA 5) 
		then (send ?exe put-duracionEj 2)
		else (send ?exe put-duracionEj 4)
	)
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejTaiChi
	(newPersona)
	(or (diabetes)(hipertension)(obesidad)(fibromialgia)(osteoporosis)(parkinson)(depresion)(Faltaequilibrio))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj  "Tai chi") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
	(bind ?intA (send ?x get-preferencia_intensidad))
	(if (< ?intA 5) 
		then (send ?exe put-duracionEj 10)
		else (send ?exe put-duracionEj 20)
	)
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

;Exercicis FLEXIBILITAT

(defrule ejEstCuadriceps
	(newPersona)
	(RedMobOK)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(or (artritis)(artrosis)(cardiovasculares)(coronarias)(fibromialgia)(osteoporosis)(obesidad))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj  "Estiramientos de cuádriceps") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
	(bind ?intA (send ?x get-preferencia_intensidad))
	(if (< ?intA 5) 
		then (send ?exe put-duracionEj 2)
		else (send ?exe put-duracionEj 4)
	)
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejEstMuneca
	(newPersona)
	(OperacionesSuperiorOK)
	(TroncoSuperiorOK)
	(or (artritis)(artrosis)(cardiovasculares)(coronarias)(fibromialgia)(osteoporosis)(obesidad))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj  "Estiramientos de muñeca") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
	(bind ?intA (send ?x get-preferencia_intensidad))
	(if (< ?intA 5) 
		then (send ?exe put-duracionEj 2)
		else (send ?exe put-duracionEj 4)
	)
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejEstPantorrillas
	(newPersona)
	(RedMobOK)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(or (artritis)(artrosis)(cardiovasculares)(coronarias)(fibromialgia)(osteoporosis)(obesidad))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj  "Estiramientos de pantorrillas") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
	(bind ?intA (send ?x get-preferencia_intensidad))
	(if (< ?intA 5) 
		then (send ?exe put-duracionEj 2)
		else (send ?exe put-duracionEj 4)
	)
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejTendonesMuslo
	(newPersona)
	(RedMobOK)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(or (artritis)(artrosis)(cardiovasculares)(coronarias)(fibromialgia)(osteoporosis)(obesidad))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj  "Estiramientos de tendones muslo") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
	(bind ?intA (send ?x get-preferencia_intensidad))
	(if (< ?intA 5) 
		then (send ?exe put-duracionEj 2)
		else (send ?exe put-duracionEj 4)
	)
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejTobillos
	(newPersona)
	(RedMobOK)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(or (artritis)(artrosis)(cardiovasculares)(coronarias)(fibromialgia)(osteoporosis)(obesidad))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj  "Estiramientos de tobillos") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
	(bind ?intA (send ?x get-preferencia_intensidad))
	(if (< ?intA 5) 
		then (send ?exe put-duracionEj 2)
		else (send ?exe put-duracionEj 4)
	)
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejEstTriceps
	(newPersona)
	(OperacionesSuperiorOK)
	(TroncoSuperiorOK)
	(or (artritis)(artrosis)(cardiovasculares)(coronarias)(fibromialgia)(osteoporosis)(obesidad))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj  "Estiramientos de tríceps") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
	(bind ?intA (send ?x get-preferencia_intensidad))
	(if (< ?intA 5) 
		then (send ?exe put-duracionEj 2)
		else (send ?exe put-duracionEj 4)
	)
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejRotCader
	(newPersona)
	(RedMobOK)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(or (artritis)(artrosis)(cardiovasculares)(coronarias)(fibromialgia)(osteoporosis)(obesidad))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj  "Rotación de cadera") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
	(bind ?intA (send ?x get-preferencia_intensidad))
	(if (< ?intA 5) 
		then (send ?exe put-duracionEj 2)
		else (send ?exe put-duracionEj 4)
	)
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejRotHombros
	(newPersona)
	(OperacionesSuperiorOK)
	(TroncoSuperiorOK)
	(or (artritis)(artrosis)(cardiovasculares)(coronarias)(fibromialgia)(osteoporosis)(obesidad))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj  "Rotación de hombros") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
	(bind ?intA (send ?x get-preferencia_intensidad))
	(if (< ?intA 5) 
		then (send ?exe put-duracionEj 2)
		else (send ?exe put-duracionEj 4)
	)
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

;Exercicis MUSCULACIÓ

(defrule ejCurlBiceps
	(newPersona)
	(OperacionesSuperiorOK)
	(TroncoSuperiorOK)
	(or (cardiovasculares)(coronarias)(hipertension)(obesidad))
	?p<-(planprueba ?planPrueba)
    ?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Curl bíceps") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
    (bind ?intA (send ?x get-preferencia_intensidad))
    (if (< ?intA 5)
        then 
			(send ?exe put-series 2 )
			(send ?exe put-repeticiones 8)
			(send ?exe put-duracionEj 3)
		
        else (send ?exe put-series 3) 
			 (send ?exe put-repeticiones 8)
		  	 (send ?exe put-duracionEj 5.5)
		
    )
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejElevacionPiernasLados
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (cardiovasculares)(coronarias)(hipertension)(obesidad))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Elevación de piernas a lados") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
    (bind ?intA (send ?x get-preferencia_intensidad))
    (if (< ?intA 5)
        then 
			 (send ?exe put-series 2) 
		     (send ?exe put-repeticiones 9)
			 (send ?exe put-duracionEj 4)
		
        else (send ?exe put-series 3) 
		     (send ?exe put-repeticiones 12)
			 (send ?exe put-duracionEj 7)
		
    )
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejExtensionRodilla
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (cardiovasculares)(coronarias)(hipertension)(obesidad))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Extensión de rodilla") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
    (bind ?intA (send ?x get-preferencia_intensidad))
    (if (< ?intA 5)
        then (send ?exe put-series 2)
		     (send ?exe put-repeticiones 9)
			 (send ?exe put-duracionEj 4)
		
        else (send ?exe put-series 3)
		     (send ?exe put-repeticiones 12)
			 (send ?exe put-duracionEj 7)
		
    )
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejExtensionTriceps
	(newPersona)
	(OperacionesSuperiorOK)
	(TroncoSuperiorOK)
	(or (cardiovasculares)(coronarias)(hipertension)(obesidad))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Extensión de tríceps") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
    (bind ?intA (send ?x get-preferencia_intensidad))
    (if (< ?intA 5)
        then (send ?exe put-series 2)
		     (send ?exe put-repeticiones 5)
			  (send ?exe put-duracionEj 3)
		
        else (send ?exe put-series 3)
		     (send ?exe put-repeticiones 8)
			 (send ?exe put-duracionEj 5.5)
		
    )
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejFlexionHombros
	(newPersona)
	(OperacionesSuperiorOK)
	(TroncoSuperiorOK)
	(or (cardiovasculares)(coronarias)(hipertension)(obesidad))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Flexión de hombros") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
    (bind ?intA (send ?x get-preferencia_intensidad))
    (if (< ?intA 5)
        then (send ?exe put-series 2)
		     (send ?exe put-repeticiones 5)
			 (send ?exe put-duracionEj 3)
		
        else (send ?exe put-series 3)
		     (send ?exe put-repeticiones 8)
			 (send ?exe put-duracionEj 5.5)
		
    )
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejFlexionPlantar
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (cardiovasculares)(coronarias)(hipertension)(obesidad))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Flexión plantar") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
    (bind ?intA (send ?x get-preferencia_intensidad))
    (if (< ?intA 5)
        then (send ?exe put-series 2)
		     (send ?exe put-repeticiones 12)
			 (send ?exe put-duracionEj 2.5)
		
        else (send ?exe put-series 3) 
		     (send ?exe put-repeticiones 15)
			 (send ?exe put-duracionEj 5)
		
    )
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejLevantarBrazos
	(newPersona)
	(OperacionesSuperiorOK)
	(TroncoSuperiorOK)
	(or (cardiovasculares)(coronarias)(hipertension)(obesidad))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Levantar brazos") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
    (bind ?intA (send ?x get-preferencia_intensidad))
    (if (< ?intA 5)
        then (send ?exe put-series 2)
		    (send ?exe put-repeticiones 12)
			(send ?exe put-duracionEj 2.5)
			
        else (send ?exe put-series 3)
		    (send ?exe put-repeticiones 15)
			(send ?exe put-duracionEj 5)
			
    )
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejLevantarseSilla
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (cardiovasculares)(coronarias)(hipertension)(obesidad))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Levantarse de la silla") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
    (bind ?intA (send ?x get-preferencia_intensidad))
    (if (< ?intA 5)
        then (send ?exe put-series 2) 
		     (send ?exe put-repeticiones 9)
		     (send ?exe put-duracionEj 4)
			
        else (send ?exe put-series 3) 
		     (send ?exe put-repeticiones 12)
		 	 (send ?exe put-duracionEj 7)
			
    )
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

;Exercicis CALENTAMENT

(defrule ejCBiceps
	(newPersona)
	(OperacionesSuperiorOK)
	(TroncoSuperiorOK)
	(or (artritis)(artrosis)(depresion)(diabetes)(cardiovasculares)(coronarias)(Faltaequilibrio)(hipertension)(obesidad)(osteoporosis)(parkinson))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Extensión de bíceps") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
	(bind ?intA (send ?x get-preferencia_intensidad))
    (if (< ?intA 5)
        then (send ?exe put-duracionEj 1)
        else (send ?exe put-duracionEj 1)
    )
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejCTriceps
	(newPersona)
	(OperacionesSuperiorOK)
	(TroncoSuperiorOK)
	(or (artritis)(artrosis)(depresion)(diabetes)(cardiovasculares)(coronarias)(Faltaequilibrio)(hipertension)(obesidad)(osteoporosis)(parkinson))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Extensión de tríceps") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
    (bind ?intA (send ?x get-preferencia_intensidad))
    (if (< ?intA 5)
        then (send ?exe put-duracionEj 1)
        else (send ?exe put-duracionEj 1)
    )
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejCSpinning
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (artritis)(artrosis)(depresion)(diabetes)(cardiovasculares)(coronarias)(Faltaequilibrio)(hipertension)(obesidad)(osteoporosis)(parkinson))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Spinning calmado") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
    (bind ?intA (send ?x get-preferencia_intensidad))
    (if (< ?intA 5)
        then (send ?exe put-duracionEj 2)
        else (send ?exe put-duracionEj 3)
    )
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejCEspalda
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (artritis)(artrosis)(depresion)(diabetes)(cardiovasculares)(coronarias)(Faltaequilibrio)(hipertension)(obesidad)(osteoporosis)(parkinson))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Extensión de espalda") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
    (bind ?intA (send ?x get-preferencia_intensidad))
    (if (< ?intA 5)
        then (send ?exe put-duracionEj 2)
        else (send ?exe put-duracionEj 3)
    )
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejCTobillo
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (artritis)(artrosis)(depresion)(diabetes)(cardiovasculares)(coronarias)(Faltaequilibrio)(hipertension)(obesidad)(osteoporosis)(parkinson))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Rotaciones de tobillo") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
    (bind ?intA (send ?x get-preferencia_intensidad))
    (if (< ?intA 5)
        then (send ?exe put-duracionEj 0.5)
        else (send ?exe put-duracionEj 1.5)
    )
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejCQuadriceps
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (artritis)(artrosis)(depresion)(diabetes)(cardiovasculares)(coronarias)(Faltaequilibrio)(hipertension)(obesidad)(osteoporosis)(parkinson))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Extensión de quádriceps") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
    (bind ?intA (send ?x get-preferencia_intensidad))
    (if (< ?intA 5)
        then (send ?exe put-duracionEj 2)
        else (send ?exe put-duracionEj 3)
    )
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

(defrule ejCCadera
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (artritis)(artrosis)(depresion)(diabetes)(cardiovasculares)(coronarias)(Faltaequilibrio)(hipertension)(obesidad)(osteoporosis)(parkinson))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Rotaciones de cadera") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
    (bind ?intA (send ?x get-preferencia_intensidad))
    (if (< ?intA 5)
        then (send ?exe put-duracionEj 2)
        else (send ?exe put-duracionEj 3)
    )
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)
;
(defrule ejCGemelo
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (artritis)(artrosis)(depresion)(diabetes)(cardiovasculares)(coronarias)(Faltaequilibrio)(hipertension)(obesidad)(osteoporosis)(parkinson))
	?p<-(planprueba ?planPrueba)
	?x<-(object(is-a Persona))
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Extensión de gemelo") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
    (bind ?intA (send ?x get-preferencia_intensidad))
    (if (< ?intA 5)
        then (send ?exe put-duracionEj 2)
        else (send ?exe put-duracionEj 3)
    )
	(bind ?dis (send ?x get-disponibilidad))
	(if (< ?dis 5) 
		then (send ?exe put-frecuencia 1)
		else (send ?exe put-frecuencia 3)
	)
)

;faltan estiramientos


(defrule noMoreFilters
	(newPersona)
	=>
	(focus ASSIGNACIO)
)

(defmodule ASSIGNACIO (import MAIN ?ALL) (import PREGUNTES ?ALL)(import FILTRE_1 ?ALL)(export ?ALL))

(defrule assignEnfermedad
	(declare (salience 0))
	(newPersona)
	;?dt<- (dispt (d ?d))
	?ej <- (object
		(is-a ?class&: (subclassp ?class Ejercicio))
		(parte_de ?planPrueba&:(neq ?planPrueba [nil]))
	)
	?ses<- (object (is-a Sesion))
	?x <- (object (is-a Persona))
	;?disponibilidad <- (Disp ?i&:(> ?i 0))
	(not (done ?ej ?ses))
	=>
			
			;(printout t crlf ?d crlf)
			(if (duracionOK ?ses ?ej ?x) then
				(assert (done ?ej ?ses))
				;llamar función assign
				(if (eq (class ?ej) Ejs_Calentamiento) then (assignExercise ?ej ?ses 1 ))
				(if (neq (class ?ej) Ejs_Calentamiento) then (assignExercise ?ej ?ses 2))
				(bind ?frec (send ?ej get-frecuencia))
				(bind ?f (- ?frec 1))
				(send ?ej put-frecuencia ?f)
			)
			
)

(defrule noMoreAssignacions
	(newPersona)
	=>
	(focus RESPOSTA)
)


(defmodule RESPOSTA (import MAIN ?ALL) (import PREGUNTES ?ALL)(import FILTRE_1 ?ALL)(import ASSIGNACIO ?ALL)(export ?ALL))

(defrule printPlanilla
	(newPersona)
	?x<-(object(is-a Persona))
	?c<-(object(is-a CondicionFisica))
	=>
	(bind ?exercicis (find-all-instances ((?e Ejercicio))
		(neq (send ?e get-parte_de)[nil])
	))

	(bind ?dias (find-all-instances ((?d Sesion))
		(neq ?d [nil])
	))

	(printout t crlf)

	(bind ?bmiPersona (send ?x get-imc))	
	(if (< ?bmiPersona 18.5) then (bind ?resBMI " por debajo de lo saludable"))
	(if (and (> ?bmiPersona 18.4) (< ?bmiPersona 25)) then (bind ?resBMI " saludable"))
	(if (and (> ?bmiPersona 24)(< ?bmiPersona 30)) then (bind ?resBMI " sobrepeso"))
	(if (> ?bmiPersona 30) then (bind ?resBMI " obesidad"))

	(bind ?cf (send ?c get-CondFisica))
	(if (eq ?cf 2) then (bind ?writeCf "Baja")
	else 
		(if (eq ?cf 5) then (bind ?writeCf "Media"))
		else (bind ?writeCf "Alta")
	)


	(printout t "Hola " (send ?x get-nombre) ", con tus respuestas hemos hecho el siguiente análisis:" crlf)
	(printout t crlf)

	(printout t "---------------------------------------------------------------------------------------------------" crlf)
	(printout t "|	Nombre: " (send ?x get-nombre) "															|" crlf)
	(printout t "|	Índice de Masa Corporal (IMC): " ?bmiPersona " ---> " ?resBMI "								|" crlf)
	(printout t "|	Condición física: " ?writeCf "																|" crlf)
	(printout t "---------------------------------------------------------------------------------------------------" crlf)

	(printout t crlf)
	(printout t "Con este análisis, tu disponibilidad y preferencia de intensidad hemos creado el siguiente plan de entrenamiento para ti: " crlf)
	(printout t crlf)



	(foreach ?sesion ?dias do
		
		(printout t crlf (upcase (send ?sesion get-dia)))
		(printout t crlf)

		(bind ?calentamientos (send ?sesion get-Calentamiento))
		(bind ?principales (send ?sesion get-EjPrincipal))
		(bind ?estiramientos (send ?sesion get-Estiramientos))
		
		(printout t crlf)
		(printout t "  " "Calentamiento:" crlf)
		(printout t crlf)
		(foreach ?calentamiento ?calentamientos do
			(printout t "    " (send ?calentamiento get-nombreEj))
			(printout t "    " (send ?calentamiento get-duracionEj))
			(printout t " min")
			(printout t crlf)
		)

		(printout t crlf)
		(printout t "  " "Ejercio :" crlf)
		(printout t crlf)
		(foreach ?ej ?principales do
			(if (eq (class ?ej) Musculacion) then 
				(printout t "    " (send ?ej get-nombreEj))
				(printout t "    " (send ?ej get-series))
				(printout t " series")
				(printout t "    " (send ?ej get-repeticiones))
				(printout t " repeticiones")
				(printout t crlf)
			else 
				(printout t "    " (send ?ej get-nombreEj))
				(printout t "    " (send ?ej get-duracionEj))
				(printout t " min")
				(printout t crlf)
			)
		)

		(printout t crlf)
		(printout t "  " "Estiramientos:" crlf)
		(printout t crlf)
		(foreach ?estiramiento ?estiramientos do
			(printout t "    " (send ?estiramiento get-nombreEj))
			(printout t "    " (send ?estiramiento get-duracionEj))
			(printout t " min")
			(printout t crlf)
		)

	)

	(printout t crlf "FIN" crlf crlf)
	;(exit)
)