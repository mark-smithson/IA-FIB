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
    ?x <- (object(is-a Persona))
	=>
	(bind ?name (stringg-question "Como te llamas? "))
	(send ?x put-nombre)
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
	(bind ?gender (stringg-question "Sexo: Mujer(F) o Hombre(M) "))
    (send ?x put-sexo ?gender)
)

(defrule PREGUNTES::askIntensity
	(newPersona)
    ?x <- (object(is-a Persona))
	=>
	(bind ?intensity (ask-int "Que intensidad prefieres para tu plan del 1 al 10? "))
    (send ?x put-preferencia_intensidad ?intensity)
)


(defrule PREGUNTES::askRedMob
	(newPersona)
    ?x <- (object(is-a Persona))
	=>
	(bind ?redMob (yes-or-no-p "Eres una persona con movilidad reducida? si o no "))
    (send ?x put-mobilidad_reducida ?redMob)

)

;;	Preguntes sobre la condició física ;;

(defrule PREGUNTES::askStairs
	(newPersona)
    ?x <- (object(is-a Persona))
	?ahogEsc <- (object(is-a CondicionFisica))
	=>
	(bind ?stairs (yes-or-no-p "Te ahogas al subir las escaleras? si o no "))
    ;Falta hecho? slot??
	(send ?ahogEsc put-ahoga_subir_escalera ?stairs)
)

(defrule PREGUNTES::askAlcohol
	(newPersona)
    ?x <- (object(is-a Persona))
	?bebAlc <- (object(is-a CondicionFisica))
	=>
	(bind ?alch (yes-or-no-p "Sueles beber alcohol con frecuencia? si o no "))
    ;Falta hecho? slot??
	(send ?bebAlc put-bebe_alcohol ?alch)
)

(defrule PREGUNTES::askF
	(newPersona)
    ?x <- (object(is-a Persona))
	?caidasF <- (object(is-a CondicionFisica))
	=>
	(bind ?caidas (yes-or-no-p "Tienes caídas frecuentes? si o no "))
    ;Falta hecho? slot??
	(send ?caidasF put-caidas_frecuentemente ?caidas)
)

(defrule PREGUNTES::askTired
	(newPersona)
    ?x <- (object(is-a Persona))
	?cansancioR <- (object(is-a CondicionFisica))
	=>
	(bind ?cansancio (yes-or-no-p "Te sueles cansar rápidamente? si o no "))
    ;Falta hecho? slot??
	(send ?cansancioR put-cansancio_rapido ?cansancio)
)

(defrule PREGUNTES::askJunkFood
	(newPersona)
    ?x <- (object(is-a Persona))
	?comBasura <- (object(is-a CondicionFisica))
	=>
	(bind ?cbasura (yes-or-no-p "Sueles comer comida basura con frecuencia? si o no "))
    ;Falta hecho? slot??
	(send ?comBasura put-comida_basura ?cbasura)
)

(defrule PREGUNTES::askShopping
	(newPersona)
    ?x <- (object(is-a Persona))
	?compraF <- (object(is-a CondicionFisica))
	=>
	(bind ?compra (yes-or-no-p "Sueles ir a comprar con frecuencia? si o no "))
    ;Falta hecho? slot??
	(send ?compraF put-compra_con_frecuencia ?compra)
)

(defrule PREGUNTES::askRunning
	(newPersona)
    ?x <- (object(is-a Persona))
	?CorrerF <- (object(is-a CondicionFisica))
	=>
	(bind ?corre (yes-or-no-p "Sueles ir a correr con frecuencia? si o no "))
    ;Falta hecho? slot??
	(send ?CorrerF put-corre_con_frecuencia ?corre)
)

(defrule PREGUNTES::askSports
	(newPersona)
    ?x <- (object(is-a Persona))
	?DeporteF <- (object(is-a CondicionFisica))
	=>
	(bind ?deporte (yes-or-no-p "Sueles practicar algún deporte con frecuencia? si o no "))
    ;Falta hecho? slot??
	(send ?DeporteF put-deporte_con_frecuencia ?deporte)
)

(defrule PREGUNTES::askDiet
	(newPersona)
    ?x <- (object(is-a Persona))
	?DietaV <- (object(is-a CondicionFisica))
	=>
	(bind ?dieta (yes-or-no-p "Tienes una dieta variada? si o no "))
    ;Falta hecho? slot??
	(send ?DietaV put-dieta_variada ?dieta)
)

(defrule PREGUNTES::askSleep
	(newPersona)
    ?x <- (object(is-a Persona))
	?DuermeB <- (object(is-a CondicionFisica))
	=>
	(bind ?duerme (yes-or-no-p "Sueles dormir bien? si o no "))
    ;Falta hecho? slot??
	(send ?DuermeB put-duerme_bien ?duerme)
)

(defrule PREGUNTES::askSmoking
	(newPersona)
    ?x <- (object(is-a Persona))
	?FumaF <- (object(is-a CondicionFisica))
	=>
	(bind ?fuma (yes-or-no-p "Fumas? si o no "))
    ;Falta hecho? slot??
	(send ?FumaF put-fuma ?fuma)
)

(defrule PREGUNTES::askOperations
	(newPersona)
    ?x <- (object(is-a Persona))
	?OperR <- (object(is-a CondicionFisica))
	=>
	(bind ?operaciones (yes-or-no-p "Has tenido alguna operación reciente? si o no "))
    ;Falta hecho? slot??
	(send ?OperR put-operaciones_recientes ?operaciones)
)

(defrule PREGUNTES::askWalking
	(newPersona)
    ?x <- (object(is-a Persona))
	?PaseaF <- (object(is-a CondicionFisica))
	=>
	(bind ?pasea (yes-or-no-p "Sueles salir a pasear con frecuencia? si o no "))
    ;Falta hecho? slot??
	(send ?PaseaF put-pasea_con_frecuencia ?pasea)
)

(defrule PREGUNTES::askMusclePull
	(newPersona)
    ?x <- (object(is-a Persona))
	?tironesF <- (object(is-a CondicionFisica))
	=>
	(bind ?tirones (yes-or-no-p "Sueles tener tirones con frecuencia? si o no "))
    ;Falta hecho? slot??
	(send ?tironesF put-tirones_frecuentemente ?tirones)
)

(defrule PREGUNTES::askPain
	(newPersona)
    ?x <- (object(is-a Persona))
	?DolorS <- (object(is-a CondicionFisica))
	?DolorI <- (object(is-a CondicionFisica))
	=>
	(bind ?dolorart (yes-or-no-p "Te duelen las articulaciones con frecuencia? si o no "))
    ;Falta hecho? slot??
	(if (eq ?dolorart TRUE) then
		(bind ?dolorartS (yes-or-no-p "Suele ser en las articulaciones superiores si o no "))
		(send ?DolorS put-dolor_articulaciones_tronco_superior ?dolorartS)
		(bind ?dolorartI (yes-or-no-p "Suele ser en las articulaciones inferiores si o no "))
		(send ?DolorI put-dolor_articulaciones_tronco_inferior ?dolorartI)
	)
)

;;PREGUNTES SOBRE POSSIBLES ENFERMETATS;;

(defrule PREGUNTES::askArtrosis
	(newPersona)
    ?x <- (object(is-a Persona))
	?Eartrosis <- (object(is-a artrosis))
	=>
	(bind ?artrosiis (yes-or-no-p "Padeces de artrosis? si o no "))
	
    ;Falta hecho? slot??
	;(send ?Eartrosis put-artrosis ?artrosiis)
	(if (eq ?artrosiis TRUE) then
		(slot-insert$ ?x padece_de 1 ?Eartrosis)
	)
)

(defrule PREGUNTES::askArtritis
	(newPersona)
    ?x <- (object(is-a Persona))
	?Eartritis <- (object(is-a artritis))
	=>
	(bind ?artritis (yes-or-no-p "Padeces de artritis? si o no "))
    ;Falta hecho? slot??
	;(send ?Eartritis put-artritis ?artritis)
	(if (eq ?artritis TRUE) then
		(slot-insert$ ?x padece_de 1 ?Eartritis)
	)
)


(defrule PREGUNTES::askDepression
	(newPersona)
    ?x <- (object(is-a Persona))
	?EDepresion <- (object(is-a depresion))
	=>
	(bind ?depresion (yes-or-no-p "Padeces de depresión? si o no "))
    ;Falta hecho? slot??
	;(send ?EDepresion put-depresion ?depresion)
	(if (eq ?depresion TRUE) then
		(slot-insert$ ?x padece_de 1 ?EDepresion)
	)
)

(defrule PREGUNTES::askDiabetes ;tipos de diabates???
	(newPersona)
    ?x <- (object(is-a Persona))
	?EDiabetes <- (object(is-a diabetes))
	=>
	(bind ?diabetes (yes-or-no-p "Padeces de diabetes? si o no "))
    ;Falta hecho? slot??
	;(send ?EDiabetes put-diabetes ?diabetes)
	(if (eq ?diabetes TRUE) then
		(slot-insert$ ?x padece_de 1 ?EDiabetes)
	)
)

(defrule PREGUNTES::askCor
	(newPersona)
    ?x <- (object(is-a Persona))
	?Ecoronarias <- (object(is-a enfermedades_cardiovasculares))
	=>
	(bind ?coronarias (yes-or-no-p "Padeces de alguna enfermedad coronaria? si o no "))
    ;Falta hecho? slot??
	;(send ?Ecoronarias put-enfermedades_coronarias ?coronarias)
	(if (eq ?coronarias TRUE) then
		(slot-insert$ ?x padece_de 1 ?Ecoronarias)
	)
)

(defrule PREGUNTES::askCardiovascular
	(newPersona)
    ?x <- (object(is-a Persona))
	?Ecardiovascular <- (object(is-a enfermedades_cardiovasculares))
	=>
	(bind ?cardiovascular (yes-or-no-p "Padeces de alguna enfermedad cardiovascular? si o no "))
    ;Falta hecho? slot??
	;(send ?Ecardiovascular put-enfermedades_cardiovasculares ?cardiovascular)
	(if (eq ?cardiovascular TRUE) then
		(slot-insert$ ?x padece_de 1 ?Ecardiovascular)
	)
)

(defrule PREGUNTES::askBalance
	(newPersona)
    ?x <- (object(is-a Persona))
	?Eequilibrio <- (object(is-a falta_equilibrio))
	=>
	(bind ?faltae (yes-or-no-p "Sientes una considerable falta de equilibrio? si o no "))
    ;Falta hecho? slot??
	;(send ?Eequilibrio put-falta_equilibrio ?faltae)
	(if (eq ?faltae TRUE) then
		(slot-insert$ ?x padece_de 1 ?Eequilibrio)
	)
)

(defrule PREGUNTES::askFibromialgia
	(newPersona)
    ?x <- (object(is-a Persona))
	?EFibromialgia <- (object(is-a fibromialgia))
	=>
	(bind ?fibro (yes-or-no-p "Padeces de fibromialgia? si o no "))
    ;Falta hecho? slot??
	;(send ?EFibromialgia put-fibromialgia ?fibro)
	(if (eq ?fibro TRUE) then
		(slot-insert$ ?x padece_de 1 ?EFibromialgia)
	)
)

(defrule PREGUNTES::askBloodPressure
	(newPersona)
    ?x <- (object(is-a Persona))
	?Ehipertension <- (object(is-a hipertension))
	=>
	(bind ?hipertension (yes-or-no-p "Padeces de hipertensión? si o no "))
    ;Falta hecho? slot??
	;(send ?Ehipertension put-hipertension ?hipertension)
	(if (eq ?hipertension TRUE) then
		(slot-insert$ ?x padece_de 1 ?Ehipertension)
	)
)


(defrule PREGUNTES::askObesidad ;;BMI index?
	(newPersona)
    ?x <- (object(is-a Persona))
	?Eobesidad <- (object(is-a obesidad))
	=>
	(bind ?obesidad (yes-or-no-p "Padeces de obesidad? si o no "))
    ;Falta hecho? slot??
	;(send ?Eobesidad put-obesidad ?obesidad)
	(if (eq ?obesidad TRUE) then
		(slot-insert$ ?x padece_de 1 ?Eobesidad)
	)
)

(defrule PREGUNTES::askOsteoporosis
	(newPersona)
    ?x <- (object(is-a Persona))
	?Eosteoporosis <- (object(is-a osteoporosis))
	=>
	(bind ?osteo (yes-or-no-p "Padeces de osteoporosis? si o no "))
    ;Falta hecho? slot??
	;(send ?Eosteoporosis put-osteoporosis ?osteo)
	(if (eq ?osteo TRUE) then
		(slot-insert$ ?x padece_de 1 ?Eosteoporosis)
	)
)

(defrule PREGUNTES::askParkinson
	(newPersona)
    ?x <- (object(is-a Persona))
	?Eparkinson <- (object(is-a parkinson))
	=>
	(bind ?parkinson (yes-or-no-p "Padeces de parkinson? si o no "))
    ;Falta hecho? slot??
	;(send ?Eparkinson put-parkinson ?parkinson)
	(if (eq ?parkinson TRUE) then
		(slot-insert$ ?x padece_de 1 ?Eparkinson)
	)
)

(defmodule FILTRE_1 (import MAIN ?ALL) (import PREGUNTES ?ALL)(export ?ALL))

;descartar les instancies dels exercicis no presents en la relació mejorable_con

(deffunction eliminar_noMejorables (?f)
	(bind ?enf (find-all-instances ((?e Enfermedades)) (not (eq ( member ?f ?e:mejorable_con) FALSE))))
	(loop-for-count (?i 1 (length ?enf)) do
		(bind ?j (nth$ ?i ?enf))
		(bind ?pos (member ?f (send ?j get-mejorable_con)))
		(if (not (eq ?pos FALSE)) then (slot-delete$ ?j mejorable_con ?pos ?pos))
	)
	(assert (filtro1))
)

;;;; selecciona els exercicis restants

(defmodule SELECCIO (import MAIN ?ALL)(import PREGUNTES ?ALL)(import FILTRE_1 ?ALL)(export ?ALL))

(deftemplate validos 
	(multislot ejerciciosValidos (type INSTANCE) (allowed-classes Ejercicio))
)

(defclass Asig 
	(is-a USER)
	(role concrete)
	(multislot ejs
		(type INSTANCE)
		(allowed-classes Ejercicio)
		(create-accessor read-write)
		)
)

(defrule crea-instancia-asig
	(filtro1)
	=>
	(make-instance aux of Asig)
)

(defrule inicializaEjs 
	(filtro1)
	(not(validos))
	?x <- (object(is-a Persona))
	=>
	(bind ?ejercicios (assert(validos)))
	(bind ?ejv (find-all-instances ((?ej Ejercicio)) TRUE))
	(modify ?ejercicios (ejercicios ?ejv))
)


(defrule crea-sesiones 
	(filtro1)
	(not (sesiones_creadas))
	?x <- (object(is-a Persona))
	?programa <- (object(is-a Plan))
	?ej_v <- (validos (ejerciciosValidos $?ej_validos))
	=>
	(if (eq (length$ $?ej_validos) 0) then
		(assert (problemas "Lo sentimos, hemos detectado que no se encuentra en condiciones para hacer deporte. Vuelva a intentar cuando se haya recuperado."))
		(focus RESPOSTA)
		else 
			(bind ?inst (make-instance (sym-cat s) of Sesion))
				; Miramos la asignación de ejercicios (mientras no lleguemos al tiempo mínimo y queden ejercicios por asignar)
				
					; Determinamos repeticiones por nivel
					(while (not (eq (length$ $?ej_validos) 0)) do
							(bind ?ejerciciov (nth$ (+ (mod (random) (length$ $?ej_validos)) 1) $?ej_validos))
							;(send ?inst_e put-Tiene ?ejercicio)
							(slot-insert$ ?inst formado_por 1 ?ejerciciov )
						)
						(slot-insert$ ?programa compuesto_por 1 ?inst)
					
				)

			; Unimos sesión a programa
			
	(assert (sesiones_creadas))
	(focus RESPOSTA)
)

(defmodule RESPOSTA (import SELECCIO ?ALL) (import MAIN ?ALL)(import PREGUNTES ?ALL)(import FILTRE_1 ?ALL)(export ?ALL))

;imprimeix la resposta
(defrule printAnswer 
	(sesiones_creadas)
    ?plan <- (object(is-a Plan))
	?x <- (object(is-a Persona))
  =>
	(printout t crlf "**************************************************************************************************************" crlf crlf)
	(printout t "Hola " (send ?x get-nombre) ", este es el plan de entrenamiento que hemos creado para ti" crlf)
	(bind ?sesiones (send ?plan get-compuesto_por))


	(bind ?ejsesion (send ?sesiones get-formado_por))
    (loop-for-count (?j 1 (length ?ejsesion)) do
	(if (eq (class ?j) Aerobico) then
		(printout t "  " (send ?j get-nombreAero) crlf)
	)

	(if (eq (class ?j) Equilibrio) then
		(printout t "  " (send ?j get-nombreEqui) crlf)
	)

	(if (eq (class ?j) Flexibilidad) then
		(printout t "  " (send ?j get-nombreFlexi) crlf)
	)

	(if (eq (class ?j) Musculacion) then
		(printout t "  " (send ?j get-nombreMusc) crlf)
	)
        
	)
)

(defrule printProblem 
  (declare (salience 100))
  (problemas ?item)
  =>
	(printout t crlf "**************************************************************************************************************" crlf crlf)
  ;(printout t crlf crlf)
  (format t " %s%n%n%n" ?item)
  (halt)
)