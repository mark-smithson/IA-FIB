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

(defclass Flexibilidad
    (is-a Ejercicio)
    (role concrete)
    (pattern-match reactive)
)


(defclass Musculacion
    (is-a Ejercicio)
    (role concrete)
    (pattern-match reactive)
)

(defclass Enfermedades
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    
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
    (slot CondFisica
        (type INTEGER)
        (create-accessor read-write))
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
    (slot Cbaja
        (type INTEGER)
        (create-accessor read-write))
    (slot Calta
        (type INTEGER)
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
    (slot imc 
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
    (slot rm
        (type STRING)
        (create-accessor read-write))
    (slot duracionSesion
        (type INTEGER)
        (create-accessor read-write))
    (slot duracionCalentamiento
        (type INTEGER)
        (create-accessor read-write))
)

(definstances instances
    
    ([artritis] of artritis )

    ([artrosis] of artrosis )

    ([cardiovasculares] of enfermedades_cardiovasculares)

    ([coronarias] of enfermedades_coronarias   )

    ([depresion] of depresion
    )

    ([diabetes] of diabetes
    )

    ;; AEROBICO

     ([golf] of Aerobico
         (nombreEj "Golf")
     )

     ([marcha] of Aerobico
         (nombreEj "Marcha atlética")
     )

      ([pilates] of Aerobico
          (nombreEj "Pilates")
      )

      ([senderismo] of Aerobico
         (nombreEj "Senderismo")
      )

     ([yoga] of Aerobico
         (nombreEj "Yoga")
     )

     ([aquagym] of Aerobico
        (nombreEj "Aquagym")
     )

     ([saltocuerda] of Aerobico
        (nombreEj "Saltar a la cuerda")
     )

     ([remo] of Aerobico
        (nombreEj "Remar")
     )

     ([tennis] of Aerobico
        (nombreEj "Tennis")
     )

     ([eliptica] of Aerobico
        (nombreEj "Elíptica")
     )

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

    ([caminar_sentado] of Equilibrio
        (nombreEj "Simular que caminas sentado")
    )

    ([elevaciones_laterales_brazos] of Equilibrio
        (nombreEj "Elevaciones laterales con los brazos")
    )

    ([marcha_atras] of Equilibrio
        (nombreEj "Caminar marcha atrás")
    )

    ([hacer_el_flamenco] of Equilibrio
        (nombreEj "Postura del flamenco")
    )

    ([caminar_recta] of Equilibrio
        (nombreEj "Caminar en línea recta")
    )

    ([andar_de_puntillas] of Equilibrio
        (nombreEj "Andar de puntillas")
    )

    ([yogaE] of Equilibrio
        (nombreEj "Yoga")
    )
    ([pelota_suiza] of Equilibrio
        (nombreEj "Hacer equilibrio en una pelota suiza")
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
    ([rotaciones_cuello] of Flexibilidad
        (nombreEj "Rotaciones de cuello")
    )

    ([estiramientos_cuello] of Flexibilidad
        (nombreEj "Estiramientos de cuello")
    )

    ([estiramientos_gemelos] of Flexibilidad
        (nombreEj "Estiramientos de gemelos en pared")
    )

    ([rotacion_cintura] of Flexibilidad
        (nombreEj "Rotaciones de cintura en el suelo")
    )

    ([estiramientos_pierna_espalda_suelo] of Flexibilidad
        (nombreEj "Estiramiento de piernas y espalda en el suelo")
    )

    ([estiramientos_pierna_espalda_suelo] of Flexibilidad
        (nombreEj "Estiramiento de piernas y espalda en una silla")
    )

    ([estiramientos_cuadriceps] of Flexibilidad
        (nombreEj "Estiramientos de cuádriceps")
    )

    ([estiramientos_muneca] of Flexibilidad
        (nombreEj "Estiramientos de muñeca")
    )

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
    ([sentadillas_pesas] of Musculacion
        (nombreEj "Sentadillas con pesas")
    )

    ([fondos_triceps] of Musculacion
        (nombreEj "Fondos de tríceps con silla")
    )

    ([abdominales_suelo] of Musculacion
        (nombreEj "Abdominales con pesas en el suelo")
    )

    ([elevacion_goma] of Musculacion
        (nombreEj "Elevaciones de piernas con banda elástica")
    )

    ([extension_piernas_goma] of Musculacion
        (nombreEj "Extensiones de piernas con banda elástica")
    )

    ([extension_espalda_goma] of Musculacion
        (nombreEj "Extensiones de espalda con banda elástica")
    )

    ([pres_hombros] of Musculacion
        (nombreEj "Press de hombros con mancuernas")
    )

    ([sentadillas_goma] of Musculacion
        (nombreEj "Sentadillas con banda elástica")
    )

    ([curl_biceps] of Musculacion
        (nombreEj "Curl bíceps con mancuernas")
    )

    ([elevacion_piernas_lados] of Musculacion
        (nombreEj "Elevación de piernas a lados")
    )

    ([extension_rodilla] of Musculacion
        (nombreEj "Extensión de rodilla")
    )

    ([extension_triceps] of Musculacion
        (nombreEj "Extensión de tríceps con mancuernas")
    )

    ([flexion_hombros] of Musculacion
        (nombreEj "Flexión de hombros")
    )

    ([elevaciones_hombro] of Musculacion
        (nombreEj "Elevaciones laterales de hombro con mancuernas")
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
    ([rotacion_muneca_mano] of Ejs_Calentamiento
        (nombreEj "Rotaciones de muñecas y manos")
    )

     ([rotacion_codo_antbrazo] of Ejs_Calentamiento
         (nombreEj "Rotaciones de codos y antebrazos")
     )

    ([flexiones_brazo] of Ejs_Calentamiento
        (nombreEj "Flexiones de brazos")
    )

    ([saltosLL] of Ejs_Calentamiento
        (nombreEj "Saltos hacia los lados")
    )

    ([saltosAA] of Ejs_Calentamiento
        (nombreEj "Saltos hacia alante y hacia atrás")
    )

    ([marcha_sitio] of Ejs_Calentamiento
        (nombreEj "Marcha en el sitio")
    )

     ([rotacion_cabezahombros] of Ejs_Calentamiento
         (nombreEj "Rotaciones de cabeza y hombros")
     )

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
    )

    ([fibromialgia] of fibromialgia
    )

    ([hipertension] of hipertension
    )

    ([obesidad] of obesidad
    )

    ([osteoporosis] of osteoporosis
    )

    ([parkinson] of parkinson
    )
)
