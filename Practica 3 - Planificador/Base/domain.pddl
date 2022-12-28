;Header and description

(define (domain peticionador)

    (:requirements :adl :typing :fluents)

    (:types
        rover base peticion - object
    )

    (:predicates 
        (estacionado ?r - rover ?b - base)
        (camino ?b_origen -base ?b_destino - base)
        (peticion-realizada ?p - peticion ?b - base)
        (peticion-satisfecha ?p - peticion ?b - base)
    )


    (:functions
        (subministros-base ?b - base)
        (subministros-rover ?r - rover)
    )
    

    (:action mover
        :parameters (?r - rover ?b_origen - base ?b_destino - base)
        :precondition (and
                        (estacionado ?r ?b_origen)
                        (or (camino ?b_origen ?b_destino) (camino ?b_destino ?b_origen))
                        )
        :effect (and 
                    (not (estacionado ?r ?b_origen))
                    (estacionado ?r ?b_destino)
                )
    )

    (:action cargar-subministros
        :parameters (?r - rover ?b - base)
        :precondition (and
                        (estacionado ?r ?b)
                        (>= (subministros-base ?b) 1)
                        )
        :effect (and 
                    (increase (subministros-rover ?r) 1)
                    (decrease (subministros-base ?b) 1)
                )
    )

    (:action descarga-subministros
        :parameters (?r - rover ?b - base ?p - peticion)
        :precondition (and
                        (estacionado ?r ?b)
                        (>= (subministros-rover ?r) 1)
                        (peticion-realizada ?p ?b)
                        )
        :effect (and 
                    (increase (subministros-base ?b) 1)
                    (decrease (subministros-rover ?r) 1)
                    (peticion-satisfecha ?p ?b)
                    (not (peticion-realizada ?p ?b))
                )
    )
    
)