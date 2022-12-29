(define (domain peticionador)

(:requirements :adl :fluents :typing)

(:types
    rover base peticion - object
    asentamiento almacen - base
)

(:predicates
    (estacionado ?r - rover ?b - base)                  ; El rover se encuentra estacionado en esa base
    (camino ?b1 - base ?b2 - base)                      ; Existe un camino entre ambas bases
    (peticion-abierta ?p - peticion ?a - asentamiento)  ; Petición realizada por un asentamiento
    (peticion-suministros ?p - peticion)               ; La petición es un suministro
    (peticion-personal ?p - peticion)                   ; La petición es personal
)

(:functions
    (suministros-rover ?r - rover)             ; suministros que está transportando el rover
    (personal-rover ?r - rover)                 ; Personal que está transportando el rover
    (suministros-base ?b - base)               ; suministros en el almacén
    (personal-base ?b - base)                   ; Personal disponible en el asentamiento
    (peticiones-cerradas)                       ; Número de peticiones cerradas
    (combustible ?r - rover)                    ; Combustible del rover
    (combustible-total)                         ; Combustible usado de todos los rovers
    (prioridad-peticion ?p - peticion)          ; Prioridad de una peticion
    (prioridades-totales)                       ; Suma de las prioridades de las peticiones hechas
)

(:action mover ; Mueve el rover de una base a otra
    :parameters (?r - rover ?origen - base ?destino - base)
    :precondition (and 
        (estacionado ?r ?origen)
        (or (camino ?origen ?destino) (camino ?destino ?origen))
        (> (combustible ?r) 0)
    )
    :effect (and 
        (not (estacionado ?r ?origen))
        (estacionado ?r ?destino)
        (decrease (combustible ?r) 1)
        (increase (combustible-total) 1)
    )
)

(:action cargar-suministros ; Carga al rover todos los suministros disponibles en el almacén
    :parameters (?r - rover ?b - base)
    :precondition (and 
        (estacionado ?r ?b)
        (> (suministros-base ?b) 0)
        (= (suministros-rover ?r) 0)
        (= (personal-rover ?r) 0)
    )
    :effect (and 
        (increase (suministros-rover ?r) 1)
        (decrease (suministros-base ?b) 1)
    )
)

(:action descargar-suministros ; Descargar los suministros del rover
    :parameters (?r - rover ?b - base)
    :precondition (and 
        (estacionado ?r ?b)
        (> (suministros-rover ?r) 0)
    )
    :effect (and 
        (decrease (suministros-rover ?r) 1)
        (increase (suministros-base ?b) 1)
    )
)


(:action embarcar-personal ; Embarca al rover todo el personal disponible en el asentamiento
    :parameters (?r - rover ?b - base)
    :precondition (and 
        (estacionado ?r ?b)
        (> (personal-base ?b) 0)
        (< (personal-rover ?r) 2)
        (= (suministros-rover ?r) 0)
    )
    
    :effect (and 
        (increase (personal-rover ?r) 1) 
        (decrease (personal-base ?b) 1)
    )
)

(:action desembarcar-personal ; Desembarca el personal del rover
    :parameters (?r - rover ?b - base)
    :precondition (and 
        (estacionado ?r ?b)
        (> (personal-rover ?r) 0)
    )
    :effect (and 
        (increase (personal-base ?b) (personal-rover ?r))
        (assign (personal-rover ?r) 0)
    )
)


(:action satisfacer-peticion-suministros ; Satisface las peticiones de suministros de los asentamientos
    :parameters (?r - rover ?a - asentamiento ?p - peticion)
    :precondition (and 
        (estacionado ?r ?a)
        (peticion-abierta ?p ?a)
        (peticion-suministros ?p)
        (> (suministros-rover ?r) 0)
    )
    :effect (and
        (decrease (suministros-rover ?r) 1)
        (not (peticion-abierta ?p ?a))
        (increase (peticiones-cerradas) 1)
        (when (= (prioridad-peticion ?p) 1) (increase (prioridades-totales) 3))
        (when (= (prioridad-peticion ?p) 2) (increase (prioridades-totales) 2))
        (when (= (prioridad-peticion ?p) 3) (increase (prioridades-totales) 1))
    )
)

(:action satisfacer-peticion-personal ; Satisface las peticiones de personal de los asentamientos
    :parameters (?r - rover ?a - asentamiento ?p - peticion)
    :precondition (and 
        (estacionado ?r ?a)
        (peticion-abierta ?p ?a)
        (peticion-personal ?p)
        (> (personal-rover ?r) 0)
    )
    :effect (and 
        (decrease (personal-rover ?r) 1)
        (not (peticion-abierta ?p ?a))
        (increase (peticiones-cerradas) 1)
        (when (= (prioridad-peticion ?p) 1) (increase (prioridades-totales) 3))
        (when (= (prioridad-peticion ?p) 2) (increase (prioridades-totales) 2))
        (when (= (prioridad-peticion ?p) 3) (increase (prioridades-totales) 1))
    )
)
)