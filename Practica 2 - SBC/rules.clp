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

(deffunction assignExercise (?ejercicio ?sesion)
	(bind ?ejsSes (send ?sesion get-EjPrincipal))
	(bind ?ejsSes (insert$ ?ejsSes (+(length$ ?ejsSes)1)?ejercicio))
	(send ?sesion put-EjPrincipal ?ejsSes)

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
    ;?x <- (object(is-a Persona))
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
	(if (eq ?redMob FALSE) then (assert (RedMobOK)))
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
	(if (eq ?stairs FALSE) then (assert (StairsOK)))
)

(defrule PREGUNTES::askAlcohol
	(newPersona)
    ?x <- (object(is-a Persona))
	?bebAlc <- (object(is-a CondicionFisica))
	=>
	(bind ?alch (yes-or-no-p "Sueles beber alcohol con frecuencia? si o no "))
    ;Falta hecho? slot??
	(send ?bebAlc put-bebe_alcohol ?alch)
	(if (eq ?alch FALSE) then (assert (AlcoholOK)))
)

(defrule PREGUNTES::askF
	(newPersona)
    ?x <- (object(is-a Persona))
	?caidasF <- (object(is-a CondicionFisica))
	=>
	(bind ?caidas (yes-or-no-p "Tienes caídas frecuentes? si o no "))
    ;Falta hecho? slot??
	(send ?caidasF put-caidas_frecuentemente ?caidas)
	(if (eq ?caidas FALSE) then (assert (CaidasOK)))
)

(defrule PREGUNTES::askTired
	(newPersona)
    ?x <- (object(is-a Persona))
	?cansancioR <- (object(is-a CondicionFisica))
	=>
	(bind ?cansancio (yes-or-no-p "Te sueles cansar rápidamente? si o no "))
    ;Falta hecho? slot??
	(send ?cansancioR put-cansancio_rapido ?cansancio)
	(if (eq ?cansancio FALSE) then (assert (CansancioOK)))
)

(defrule PREGUNTES::askJunkFood
	(newPersona)
    ?x <- (object(is-a Persona))
	?comBasura <- (object(is-a CondicionFisica))
	=>
	(bind ?cbasura (yes-or-no-p "Sueles comer comida basura con frecuencia? si o no "))
    ;Falta hecho? slot??
	(send ?comBasura put-comida_basura ?cbasura)
	(if (eq ?cbasura FALSE) then (assert (CBasuraOK)))
)

(defrule PREGUNTES::askShopping
	(newPersona)
    ?x <- (object(is-a Persona))
	?compraF <- (object(is-a CondicionFisica))
	=>
	(bind ?compra (yes-or-no-p "Sueles ir a comprar con frecuencia? si o no "))
    ;Falta hecho? slot??
	(send ?compraF put-compra_con_frecuencia ?compra)
	(if (eq ?compra TRUE) then (assert (ComprasOK)))
)

(defrule PREGUNTES::askRunning
	(newPersona)
    ?x <- (object(is-a Persona))
	?CorrerF <- (object(is-a CondicionFisica))
	=>
	(bind ?corre (yes-or-no-p "Sueles ir a correr con frecuencia? si o no "))
    ;Falta hecho? slot??
	(send ?CorrerF put-corre_con_frecuencia ?corre)
	(if (eq ?corre TRUE) then (assert (RunningOK)))
)

(defrule PREGUNTES::askSports
	(newPersona)
    ?x <- (object(is-a Persona))
	?DeporteF <- (object(is-a CondicionFisica))
	=>
	(bind ?deporte (yes-or-no-p "Sueles practicar algún deporte con frecuencia? si o no "))
    ;Falta hecho? slot??
	(send ?DeporteF put-deporte_con_frecuencia ?deporte)
	(if (eq ?deporte TRUE) then (assert (DeporteOK)))
)

(defrule PREGUNTES::askDiet
	(newPersona)
    ?x <- (object(is-a Persona))
	?DietaV <- (object(is-a CondicionFisica))
	=>
	(bind ?dieta (yes-or-no-p "Tienes una dieta variada? si o no "))
    ;Falta hecho? slot??
	(send ?DietaV put-dieta_variada ?dieta)
	(if (eq ?dieta TRUE) then (assert (DietaOK)))
)

(defrule PREGUNTES::askSleep
	(newPersona)
    ?x <- (object(is-a Persona))
	?DuermeB <- (object(is-a CondicionFisica))
	=>
	(bind ?duerme (yes-or-no-p "Sueles dormir bien? si o no "))
    ;Falta hecho? slot??
	(send ?DuermeB put-duerme_bien ?duerme)
	(if (eq ?duerme TRUE) then (assert (DuermeOK)))
)

(defrule PREGUNTES::askSmoking
	(newPersona)
    ?x <- (object(is-a Persona))
	?FumaF <- (object(is-a CondicionFisica))
	=>
	(bind ?fuma (yes-or-no-p "Fumas? si o no "))
    ;Falta hecho? slot??
	(send ?FumaF put-fuma ?fuma)
	(if (eq ?fuma FALSE) then (assert (FumaOK)))
)

(defrule PREGUNTES::askOperations
	(newPersona)
    ?x <- (object(is-a Persona))
	?OperS <- (object(is-a CondicionFisica))
	?OperI<- (object(is-a CondicionFisica))
	=>
	(bind ?operaciones (yes-or-no-p "Has tenido alguna operación reciente? si o no "))
    ;Falta hecho? slot??
	(if (eq ?operaciones TRUE) then
		(bind ?operS (yes-or-no-p "Es en el tronco superior si o no "))
		(send ?OperS put-operaciones_recientes_superior ?operS)
		(if (eq ?operS FALSE) then (assert (OperacionesSuperiorOK)))
		(bind ?operI (yes-or-no-p "Es en el tronco inferior si o no "))
		(send ?OperI put-operaciones_recientes_inferior ?operI)
		(if (eq ?operI FALSE) then (assert (OperacionesInferiorOK)))
	)
)

(defrule PREGUNTES::askWalking
	(newPersona)
    ?x <- (object(is-a Persona))
	?PaseaF <- (object(is-a CondicionFisica))
	=>
	(bind ?pasea (yes-or-no-p "Sueles salir a pasear con frecuencia? si o no "))
    ;Falta hecho? slot??
	(send ?PaseaF put-pasea_con_frecuencia ?pasea)
	(if (eq ?pasea TRUE) then (assert (PaseaOK)))
)

(defrule PREGUNTES::askMusclePull
	(newPersona)
    ?x <- (object(is-a Persona))
	?tironesF <- (object(is-a CondicionFisica))
	=>
	(bind ?tirones (yes-or-no-p "Sueles tener tirones con frecuencia? si o no "))
    ;Falta hecho? slot??
	(send ?tironesF put-tirones_frecuentemente ?tirones)
	(if (eq ?tirones FALSE) then (assert (TironesOK)))
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
		(if (eq ?dolorartS FALSE) then (assert (TroncoSuperiorOK)))
		(bind ?dolorartI (yes-or-no-p "Suele ser en las articulaciones inferiores si o no "))
		(send ?DolorI put-dolor_articulaciones_tronco_inferior ?dolorartI)
		(if (eq ?dolorartI FALSE) then (assert (TroncoInferiorOK)))
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
		(assert(artrosis))
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
		(assert(artritis))
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
		(assert(depresion))
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
		(assert(diabetes))
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
		(assert(coronarias))
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
		(assert(cardiovascular))
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
		(assert(Faltaequilibrio))
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
		(assert(fibromialgia))
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
		(assert(hipertension))
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
		(assert(obesidad))
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
		(assert(osteoporosis))
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
	(focus FILTRE_1)
	;(printout t crlf "---noMoreQuestions---" crlf)
)


(defmodule FILTRE_1 (import MAIN ?ALL) (import PREGUNTES ?ALL)(export ?ALL))

;Per cada exercici escull si poden formar part del plan de newPersona o no

;Exercicis aeròbics
(defrule ejBaile
	(newPersona)
	(RedMobOK)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(or (depresion)(diabetes)(enfermedades_coronarias)(hipertension)(obesidad))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "bailar") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejBici
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (depresion)(diabetes)(coronarias)(cardiovascular)(hipertension)(obesidad)(artritis)(fibromialgia))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "bici") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejBiciSuperior
	(newPersona)
	(TroncoSuperiorOK)
	(OperacionesSuperiorOK)
	(or (depresion)(diabetes)(coronarias)(cardiovascular)(hipertension)(obesidad)(artritis)(fibromialgia))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "biciSuperior") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejCaminar
	(newPersona)
	(TroncoInferiorOK)
	(RedMobOK)
	(OperacionesInferiorOK)
	(or (depresion)(diabetes)(coronarias)(cardiovascular)(hipertension)(obesidad)(artritis)(fibromialgia)(osteoporosis)(artrosis))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "caminar") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejCorrer
	(newPersona)
	(TroncoInferiorOK)
	(RedMobOK)
	(OperacionesInferiorOK)
	(or (depresion)(diabetes)(coronarias)(hipertension)(obesidad))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "correr") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
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
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "nadar") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

;Exercicis D'EQUILIBRI

(defrule ejAndarPuntillas
	(newPersona)
	(TroncoInferiorOK)
	(OperacionesInferiorOK)
	(RedMobOK)
	(or (diabetes)(hipertension)(obesidad)(osteoporosis)(fibromialgia))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "andar_de_puntillas") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejFlexionDeCadera
	(newPersona)
	(TroncoInferiorOK)
	(TroncoSuperiorOK)
	(OperacionesSuperiorOK)
	(OperacionesInferiorOK)
	(RedMobOK)
	(or (diabetes)(hipertension)(obesidad)(fibromialgia))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "flexion_de_cadera") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejExtensionDeCadera
	(newPersona)
	(TroncoInferiorOK)
	(TroncoSuperiorOK)
	(OperacionesSuperiorOK)
	(OperacionesInferiorOK)
	(RedMobOK)
	(or (diabetes)(hipertension)(obesidad)(fibromialgia))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "extension_de_cadera") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejLevLateralPierna
	(newPersona)
	(TroncoInferiorOK)
	(OperacionesInferiorOK)
	(RedMobOK)
	(or (diabetes)(hipertension)(obesidad)(fibromialgia)(osteoporosis))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj  "levantamiento_lateral_pierna") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejTaiChi
	(newPersona)
	(or (diabetes)(hipertension)(obesidad)(fibromialgia)(osteoporosis)(parkinson)(depresion))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj  "tai_chi") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

;Exercicis FLEXIBILITAT

(defrule ejEstCuadriceps
	(newPersona)
	(RedMobOK)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(or (artritis)(artrosis)(cardiovasculares)(coronarias)(fibromialgia)(osteoporosis)(obesidad))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj  "estiramientos_cuadriceps") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejEstMuneca
	(newPersona)
	(OperacionesSuperiorOK)
	(TroncoSuperiorOK)
	(or (artritis)(artrosis)(cardiovasculares)(coronarias)(fibromialgia)(osteoporosis)(obesidad))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj  "estiramientos_muneca") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejEstPantorrillas
	(newPersona)
	(RedMobOK)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(or (artritis)(artrosis)(cardiovasculares)(coronarias)(fibromialgia)(osteoporosis)(obesidad))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj  "estiramientos_pantorrillas") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejTendonesMuslo
	(newPersona)
	(RedMobOK)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(or (artritis)(artrosis)(cardiovasculares)(coronarias)(fibromialgia)(osteoporosis)(obesidad))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj  "estiramientos_tendones_muslo") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejTobillos
	(newPersona)
	(RedMobOK)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(or (artritis)(artrosis)(cardiovasculares)(coronarias)(fibromialgia)(osteoporosis)(obesidad))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj  "estiramientos_tobillos") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejEstTriceps
	(newPersona)
	(OperacionesSuperiorOK)
	(TroncoSuperiorOK)
	(or (artritis)(artrosis)(cardiovasculares)(coronarias)(fibromialgia)(osteoporosis)(obesidad))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj  "estiramientos_triceps") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejRotCader
	(newPersona)
	(RedMobOK)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(or (artritis)(artrosis)(cardiovasculares)(coronarias)(fibromialgia)(osteoporosis)(obesidad))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj  "rotacion_cadera") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejRotHombros
	(newPersona)
	(OperacionesSuperiorOK)
	(TroncoSuperiorOK)
	(or (artritis)(artrosis)(cardiovasculares)(coronarias)(fibromialgia)(osteoporosis)(obesidad))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj  "rotacion_hombros") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

;Exercicis MUSCULACIÓ

(defrule ejCurlBiceps
	(newPersona)
	(OperacionesSuperiorOK)
	(TroncoSuperiorOK)
	(or (cardiovasculares)(coronarias)(hipertension)(obesidad))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "curl_biceps") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejElevacionPiernasLados
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (cardiovasculares)(coronarias)(hipertension)(obesidad))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "elevacion_piernas_lados") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejExtensionRodilla
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (cardiovasculares)(coronarias)(hipertension)(obesidad))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "extension_rodilla") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejExtensionTriceps
	(newPersona)
	(OperacionesSuperiorOK)
	(TroncoSuperiorOK)
	(or (cardiovasculares)(coronarias)(hipertension)(obesidad))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "extension_triceps") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejFlexionHombros
	(newPersona)
	(OperacionesSuperiorOK)
	(TroncoSuperiorOK)
	(or (cardiovasculares)(coronarias)(hipertension)(obesidad))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "flexion_hombros") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejFlexionPlantar
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (cardiovasculares)(coronarias)(hipertension)(obesidad))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "flexion_plantar") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejLevantarBrazos
	(newPersona)
	(OperacionesSuperiorOK)
	(TroncoSuperiorOK)
	(or (cardiovasculares)(coronarias)(hipertension)(obesidad))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "levantar_brazos") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejLevantarseSilla
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (cardiovasculares)(coronarias)(hipertension)(obesidad))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "levantarse_silla") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

;Exercicis CALENTAMENT

(defrule ejCBiceps
	(newPersona)
	(OperacionesSuperiorOK)
	(TroncoSuperiorOK)
	(or (artritis)(artrosis)(depresion)(diabetes)(cardiovasculares)(coronarias)(Faltaequilibrio)(hipertension)(obesidad)(osteoporosis)(parkinson))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Extension de biceps") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejCTriceps
	(newPersona)
	(OperacionesSuperiorOK)
	(TroncoSuperiorOK)
	(or (artritis)(artrosis)(depresion)(diabetes)(cardiovasculares)(coronarias)(Faltaequilibrio)(hipertension)(obesidad)(osteoporosis)(parkinson))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Extension de triceps") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejCSpinning
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (artritis)(artrosis)(depresion)(diabetes)(cardiovasculares)(coronarias)(Faltaequilibrio)(hipertension)(obesidad)(osteoporosis)(parkinson))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Spinning calmado") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejCEspalda
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (artritis)(artrosis)(depresion)(diabetes)(cardiovasculares)(coronarias)(Faltaequilibrio)(hipertension)(obesidad)(osteoporosis)(parkinson))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Extension de espalda") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejCTobillo
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (artritis)(artrosis)(depresion)(diabetes)(cardiovasculares)(coronarias)(Faltaequilibrio)(hipertension)(obesidad)(osteoporosis)(parkinson))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Rotaciones de tobillo") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejCQuadriceps
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (artritis)(artrosis)(depresion)(diabetes)(cardiovasculares)(coronarias)(Faltaequilibrio)(hipertension)(obesidad)(osteoporosis)(parkinson))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Extension de quadriceps") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejCCadera
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (artritis)(artrosis)(depresion)(diabetes)(cardiovasculares)(coronarias)(Faltaequilibrio)(hipertension)(obesidad)(osteoporosis)(parkinson))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Rotaciones de cadera") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

(defrule ejCGemelo
	(newPersona)
	(OperacionesInferiorOK)
	(TroncoInferiorOK)
	(RedMobOK)
	(or (artritis)(artrosis)(depresion)(diabetes)(cardiovasculares)(coronarias)(Faltaequilibrio)(hipertension)(obesidad)(osteoporosis)(parkinson))
	?p<-(planprueba ?planPrueba)
	=>
	(bind ?ex (find-instance ((?e Ejercicio)) (eq (str-compare ?e:nombreEj "Extension de gemelo") 0)))
	(bind ?exe (nth$ 1 ?ex))
	(send ?exe put-parte_de ?planPrueba)
)

;faltan estiramientos creo


(defrule noMoreFilters
	(newPersona)
	=>
	(focus ASSIGNACIO)
)

(defmodule ASSIGNACIO (import MAIN ?ALL) (import PREGUNTES ?ALL)(import FILTRE_1 ?ALL)(export ?ALL))

(defrule assignEnfermedad
	(declare (salience 0))
	(newPersona)
	?ej <- (object
		(is-a ?class&: (subclassp ?class Ejercicio))
		(parte_de ?planPrueba&:(neq ?planPrueba [nil]))
	)
	?ses<- (object (is-a Sesion))
	(not (done ?ej ?ses))
	=>
	(assert (done ?ej ?ses))
	;llamar función assign
	(assignExercise ?ej ?ses)
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
	=>
	(bind ?exercicis (find-all-instances ((?e Ejercicio))
		(neq (send ?e get-parte_de)[nil])
	))

	(bind ?dias (find-all-instances ((?d Sesion))
		(neq ?d [nil])
	))

	(printout t crlf)

	(printout t "--------------------------------------------------------------" crlf)
	(printout t "------------------- Plan de ejercicios -----------------------" crlf)
	(printout t "--------------------------------------------------------------" crlf)
	(printout t "Hola " (send ?x get-nombre) ", este es el plan de entrenamiento que hemos creado para ti" crlf)
	(printout t crlf)


	(foreach ?sesion ?dias do
		
		(printout t crlf (upcase (send ?sesion get-dia)))
		(printout t crlf)


		(bind ?principales (send ?sesion get-EjPrincipal))
		
		(printout t "  " "Ejercio :" crlf)

		(foreach ?ej ?principales do
			(printout t "    " (send ?ej get-nombreEj))
			(printout t crlf)
		)

	)

	(printout t crlf "FIN" crlf crlf)
	;(exit)
)