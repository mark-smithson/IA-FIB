(define (problem prueba) (:domain peticionador)
    (:objects 
        r - rover
        b1 b2 b3 b4 - base
        p1 - peticion
    )

    (:init
        (= (subministros-base b1) 0)
        (= (subministros-base b2) 1)
        (= (subministros-base b3) 0)
        (= (subministros-base b4) 0)
        (= (subministros-rover r) 0)
        (camino b1 b2)
        (camino b2 b3)
        (camino b3 b4)
        (estacionado r b1)
        (peticion-realizada p1 b4)
    )

    (:goal 
        (peticion-satisfecha p1 b4)
    )

    ;un-comment the following line if metric is needed
    ;(:metric minimize (???))
)


