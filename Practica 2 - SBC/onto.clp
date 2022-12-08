;;; ---------------------------------------------------------
;;; ontoFinal.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology ontoFinal.owl
;;; :Date 07/12/2022 12:13:02

(defclass Ejercicio
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot parte_de
        (type INSTANCE)
        (create-accessor read-write))
    (slot aire_libre
        (type SYMBOL)
        (create-accessor read-write))
    (slot en_casa
        (type SYMBOL)
        (create-accessor read-write))
    (slot gimnasio
        (type SYMBOL)
        (create-accessor read-write))
    (slot intensidad
        (type STRING)
        (create-accessor read-write))

    (slot nombreEj
        (type STRING)
        (create-accessor read-write))

    (slot duracionEj
        (type INTEGER)
        (create-accessor read-write))

    (slot series
        (type INTEGER)
        (create-accessor read-write))
    (slot repeticiones
        (type INTEGER)
        (create-accessor read-write))
    (slot frecuencia
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Aerobico
    (is-a Ejercicio)
    (role concrete)
    (pattern-match reactive)
    
)

(defclass bailar
    (is-a Aerobico)
    (role concrete)
    (pattern-match reactive)
)

(defclass bici
    (is-a Aerobico)
    (role concrete)
    (pattern-match reactive)
)

(defclass caminar
    (is-a Aerobico)
    (role concrete)
    (pattern-match reactive)
)

(defclass correr
    (is-a Aerobico)
    (role concrete)
    (pattern-match reactive)
)

(defclass nadar
    (is-a Aerobico)
    (role concrete)
    (pattern-match reactive)
)

(defclass Ejs_Calentamiento
    (is-a Ejercicio)
    (role concrete)
    (pattern-match reactive)
)

(defclass Equilibrio
    (is-a Ejercicio)
    (role concrete)
    (pattern-match reactive)
)

(defclass andar_de_puntillas
    (is-a Equilibrio)
    (role concrete)
    (pattern-match reactive)
)

(defclass extension_de_cadera
    (is-a Equilibrio)
    (role concrete)
    (pattern-match reactive)
)

(defclass flexion_de_cadera
    (is-a Equilibrio)
    (role concrete)
    (pattern-match reactive)
)

(defclass levantamiento_lateral_pierna
    (is-a Equilibrio)
    (role concrete)
    (pattern-match reactive)
)

(defclass tai_chi
    (is-a Equilibrio)
    (role concrete)
    (pattern-match reactive)
)

(defclass Estiramientos
    (is-a Ejercicio)
    (role concrete)
    (pattern-match reactive)
)

(defclass Flexibilidad
    (is-a Ejercicio)
    (role concrete)
    (pattern-match reactive)
)

(defclass estiramientos_cuadriceps
    (is-a Flexibilidad)
    (role concrete)
    (pattern-match reactive)
)

(defclass estiramientos_muneca
    (is-a Flexibilidad)
    (role concrete)
    (pattern-match reactive)
)

(defclass estiramientos_pantorrillas
    (is-a Flexibilidad)
    (role concrete)
    (pattern-match reactive)
)

(defclass estiramientos_tendones_muslo
    (is-a Flexibilidad)
    (role concrete)
    (pattern-match reactive)
)

(defclass estiramientos_tobillos
    (is-a Flexibilidad)
    (role concrete)
    (pattern-match reactive)
)

(defclass estiramientos_triceps
    (is-a Flexibilidad)
    (role concrete)
    (pattern-match reactive)
)

(defclass rotacion_cadera
    (is-a Flexibilidad)
    (role concrete)
    (pattern-match reactive)
)

(defclass rotacion_hombros
    (is-a Flexibilidad)
    (role concrete)
    (pattern-match reactive)
)

(defclass Musculacion
    (is-a Ejercicio)
    (role concrete)
    (pattern-match reactive)
)

(defclass curl_biceps
    (is-a Musculacion)
    (role concrete)
    (pattern-match reactive)
)

(defclass elevacion_piernas_lados
    (is-a Musculacion)
    (role concrete)
    (pattern-match reactive)
)

(defclass extension_rodilla
    (is-a Musculacion)
    (role concrete)
    (pattern-match reactive)
)

(defclass extension_triceps
    (is-a Musculacion)
    (role concrete)
    (pattern-match reactive)
)

(defclass flexion_hombros
    (is-a Musculacion)
    (role concrete)
    (pattern-match reactive)
)

(defclass flexion_plantar
    (is-a Musculacion)
    (role concrete)
    (pattern-match reactive)
)

(defclass levantar_brazos
    (is-a Musculacion)
    (role concrete)
    (pattern-match reactive)
)

(defclass levantarse_silla
    (is-a Musculacion)
    (role concrete)
    (pattern-match reactive)
)

(defclass Enfermedades
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot mejorable_con
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass artritis
    (is-a Enfermedades)
    (role concrete)
    (pattern-match reactive)
)

(defclass artrosis
    (is-a Enfermedades)
    (role concrete)
    (pattern-match reactive)
)

(defclass depresion
    (is-a Enfermedades)
    (role concrete)
    (pattern-match reactive)
)

(defclass diabetes
    (is-a Enfermedades)
    (role concrete)
    (pattern-match reactive)
)

(defclass enfermedades_cardiovasculares
    (is-a Enfermedades)
    (role concrete)
    (pattern-match reactive)
)

(defclass enfermedades_coronarias
    (is-a Enfermedades)
    (role concrete)
    (pattern-match reactive)
)

(defclass falta_equilibrio
    (is-a Enfermedades)
    (role concrete)
    (pattern-match reactive)
)

(defclass fibromialgia
    (is-a Enfermedades)
    (role concrete)
    (pattern-match reactive)
)

(defclass hipertension
    (is-a Enfermedades)
    (role concrete)
    (pattern-match reactive)
)

(defclass obesidad
    (is-a Enfermedades)
    (role concrete)
    (pattern-match reactive)
)

(defclass osteoporosis
    (is-a Enfermedades)
    (role concrete)
    (pattern-match reactive)
)

(defclass parkinson
    (is-a Enfermedades)
    (role concrete)
    (pattern-match reactive)
)

(defclass CondicionFisica
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot ahoga_subir_escalera
        (type SYMBOL)
        (create-accessor read-write))
    (slot bebe_alcohol
        (type SYMBOL)
        (create-accessor read-write))
    (slot caidas_frecuentemente
        (type SYMBOL)
        (create-accessor read-write))
    (slot cansancio_rapido
        (type SYMBOL)
        (create-accessor read-write))
    (slot comida_basura
        (type SYMBOL)
        (create-accessor read-write))
    (slot compra_con_frecuencia
        (type SYMBOL)
        (create-accessor read-write))
    (slot corre_con_frecuencia
        (type SYMBOL)
        (create-accessor read-write))
    (slot deporte_con_frecuencia
        (type SYMBOL)
        (create-accessor read-write))
    (slot dieta_variada
        (type SYMBOL)
        (create-accessor read-write))
    (slot dolor_articulaciones_tronco_inferior
        (type SYMBOL)
        (create-accessor read-write))
    (slot dolor_articulaciones_tronco_superior
        (type SYMBOL)
        (create-accessor read-write))
    (slot duerme_bien
        (type SYMBOL)
        (create-accessor read-write))
    (slot fuma
        (type SYMBOL)
        (create-accessor read-write))
    (slot operaciones_recientes_superior
        (type SYMBOL)
        (create-accessor read-write))
    (slot operaciones_recientes_inferior
        (type SYMBOL)
        (create-accessor read-write))
    (slot pasea_con_frecuencia
        (type SYMBOL)
        (create-accessor read-write))
    (slot tirones_frecuentemente
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass Persona
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot padece_de
        (type INSTANCE)
        (create-accessor read-write))
    (slot tiene
        (type INSTANCE)
        (create-accessor read-write))
    (slot altura
        (type SYMBOL)
        (create-accessor read-write))
    (slot edad
        (type INTEGER)
        (range 65 120)
        (create-accessor read-write))
    (slot disponibilidad
        (type INTEGER)
        (create-accessor read-write))
    (slot mobilidad_reducida
        (type SYMBOL)
        (create-accessor read-write))
    (slot nombre
        (type STRING)
        (create-accessor read-write))
    (slot peso
        (type SYMBOL)
        (create-accessor read-write))
    (slot preferencia_intensidad
        (type INTEGER)
        (create-accessor read-write))
    (slot sexo
        (type STRING)
        (create-accessor read-write))
)

(defclass Plan
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot compuesto_por
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Sesion
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot Calentamiento
        (type INSTANCE)
        (create-accessor read-write))
    (multislot EjPrincipal
        (type INSTANCE)
        (create-accessor read-write))
    (multislot Estiramientos
        (type INSTANCE)
        (create-accessor read-write))
    (slot dia
        (type STRING)
        (create-accessor read-write))
)

(definstances instances
    ([Media] of CondicionFisica
         (ahoga_subir_escalera  "true")
         (bebe_alcohol  "true")
         (caidas_frecuentemente  "false")
         (cansancio_rapido  "false")
         (comida_basura  "false")
         (compra_con_frecuencia  "true")
         (corre_con_frecuencia  "false")
         (deporte_con_frecuencia  "true")
         (dieta_variada  "true")
         (duerme_bien  "true")
         (fuma  "true")
         (operaciones_recientes_superior  "false")
         (operaciones_recientes_inferior "true")
         (pasea_con_frecuencia  "true")
         (tirones_frecuentemente  "false")
    )

    ([artritis] of artritis
         (mejorable_con  [ejaerobico] [ejflexibilidad] [ejmusculacion])
    )

    ([artrosis] of artrosis
         (mejorable_con  [ejaerobico] [ejflexibilidad] [ejmusculacion])
    )

    ([cardiovasculares] of enfermedades_cardiovasculares
         (mejorable_con  [ejaerobico] [ejequilibrio] [ejflexibilidad] [ejmusculacion])
    )

    ([coronarias] of enfermedades_coronarias
         (mejorable_con  [ejaerobico] [ejequilibrio] [ejflexibilidad] [ejmusculacion])
    )

    ([depresion] of depresion
         (mejorable_con  [ejaerobico] [ejequilibrio] [ejflexibilidad])
    )

    ([diabetes] of diabetes
         (mejorable_con  [ejaerobico] [ejequilibrio] [ejmusculacion])
    )

    ;; AEROBICO
    ([caminar] of Aerobico
        (nombreEj "Caminar")
    )
    ([bailar] of Aerobico
        (nombreEj "Bailar")
    )
    ([nadar] of Aerobico
        (nombreEj "Nadar")
    )
    ([correr] of Aerobico
        (nombreEj "Correr")
    )
    ([bici] of Aerobico
        (nombreEj "Bici")
    )

    ([biciSuperior] of Aerobico
        (nombreEj "Bici de tren superior")
    )

    ;; EQUILIBRIO
    ([andar_de_puntillas] of Equilibrio
        (nombreEj "Andar de puntillas")
    )

    ([flexion_de_cadera] of Equilibrio
        (nombreEj "Flexión de cadera")
    )

    ([extension_de_cadera] of Equilibrio
        (nombreEj "Extensión de cadera")
    )

    ([levantamiento_lateral_pierna] of Equilibrio
        (nombreEj "Levantamiento lateral pierna")
    )

    ([tai_chi] of Equilibrio
         (nombreEj "Tai chi")
    )

    ;; FLEXIBILIDAD
    ([estiramientos_cuadriceps] of Flexibilidad
        (nombreEj "Estiramientos de cuádriceps")
    )

    ([estiramientos_muneca] of Flexibilidad
        (nombreEj "Estiramientos de muñeca")
    )

   ; ([estiramientos_cuadriceps] of Flexibilidad
    ;    (nombreEj "Estiramientos_cuadriceps")
    ;)

    ([estiramientos_pantorrillas] of Flexibilidad
        (nombreEj "Estiramientos de pantorrillas")
    )

    ([estiramientos_tendones_muslo] of Flexibilidad
        (nombreEj "Estiramientos de tendones muslo")
    )

    ([estiramientos_tobillos] of Flexibilidad
        (nombreEj "Estiramientos de tobillos")
    )

    ([estiramientos_triceps] of Flexibilidad
        (nombreEj "Estiramientos de tríceps")
    )

    ([rotacion_cadera] of Flexibilidad
        (nombreEj "Rotación de cadera")
    )

    ([rotacion_hombros] of Flexibilidad
        (nombreEj "Rotación de hombros")
    )

    ;; MUSCULACION
    ([curl_biceps] of Musculacion
        (nombreEj "Curl bíceps")
    )

    ([elevacion_piernas_lados] of Musculacion
        (nombreEj "Elevación de piernas a lados")
    )

    ([extension_rodilla] of Musculacion
        (nombreEj "Extensión de rodilla")
    )

    ([extension_triceps] of Musculacion
        (nombreEj "Extensión de tríceps")
    )

    ([flexion_hombros] of Musculacion
        (nombreEj "Flexión de hombros")
    )

    ([flexion_plantar] of Musculacion
        (nombreEj "Flexión plantar")
    )

    ([levantar_brazos] of Musculacion
        (nombreEj "Levantar brazos")
    )

    ([levantarse_silla] of Musculacion
        (nombreEj "Levantarse de la silla")
    )

    ;; CALENTAMIENTO
    ([CBiceps] of Ejs_Calentamiento
        (nombreEj "Extensión de bíceps")
    )

    ([CTriceps] of Ejs_Calentamiento
        (nombreEj "Extensión de tríceps")
    )

    ([CSpinning] of Ejs_Calentamiento
        (nombreEj "Spinning calmado")
    )

    ([CEspalda] of Ejs_Calentamiento
        (nombreEj "Extensión de espalda")
    )

    ([CTobillo] of Ejs_Calentamiento
        (nombreEj "Rotaciones de tobillo")
    )

    ([CQuadriceps] of Ejs_Calentamiento
        (nombreEj "Extensión de quádriceps")
    )

    ([CCadera] of Ejs_Calentamiento
        (nombreEj "Rotaciones de cadera")
    )

    ([CGemelo] of Ejs_Calentamiento
        (nombreEj "Extensión de gemelo")
    )


    ([faltaequilib] of falta_equilibrio
         (mejorable_con  [ejaerobico] [ejequilibrio])
    )

    ([fibromialgia] of fibromialgia
         (mejorable_con  [ejaerobico] [ejflexibilidad])
    )

    ([hipertension] of hipertension
         (mejorable_con  [ejaerobico] [ejmusculacion])
    )

    ([obesidad] of obesidad
         (mejorable_con  [ejaerobico] [ejequilibrio] [ejflexibilidad] [ejmusculacion])
    )

    ([osteoporosis] of osteoporosis
         (mejorable_con  [ejaerobico] [ejequilibrio] [ejflexibilidad] [ejmusculacion])
    )

    ([parkinson] of parkinson
         (mejorable_con  [ejaerobico] [ejequilibrio])
    )

)
