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
    (suministros-almacen ?b - almacen)         ; suministros en el almacén
    (personal-asentamiento ?b - asentamiento)   ; Personal disponible en el asentamiento
    (peticiones-cerradas)                       ; Número de peticiones cerradas
)

(:action mover ; Mueve el rover de una base a otra
    :parameters (?r - rover ?origen - base ?destino - base)
    :precondition (and 
        (estacionado ?r ?origen)
        (or (camino ?origen ?destino) (camino ?destino ?origen))
    )
    :effect (and 
        (not (estacionado ?r ?origen))
        (estacionado ?r ?destino)
    )
)

(:action cargar-suministros ; Carga al rover todos los suministros disponibles en el almacén
    :parameters (?r - rover ?a - almacen)
    :precondition (and 
        (estacionado ?r ?a)
        (> (suministros-almacen ?a) 0)
    )
    :effect (and 
        (increase (suministros-rover ?r) (suministros-almacen ?a))
        (assign (suministros-almacen ?a) 0)
    )
)

(:action embarcar-personal ; Embarca al rover todo el personal disponible en el asentamiento
    :parameters (?r - rover ?a - asentamiento)
    :precondition (and 
        (estacionado ?r ?a)
        (> (personal-asentamiento ?a) 0)
    )
    :effect (and 
        (increase (personal-rover ?r) (personal-asentamiento ?a))
        (assign (personal-asentamiento ?a) 0)
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
    )
)
)