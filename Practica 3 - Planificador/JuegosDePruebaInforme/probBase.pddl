(define (problem probBase) (:domain peticionador)
(:objects
    r0 - rover
    b1 b2 - almacen
    b0 b3 b4 - asentamiento
    p0 - peticion
)
(:init
    (= (peticiones-cerradas) 0)
    (camino b0 b1)
    (camino b0 b2)
    (camino b1 b4)
    (camino b2 b3)
    (camino b2 b4)
    (= (suministros-almacen b1) 0)
    (= (suministros-almacen b2) 0)
    (= (personal-asentamiento b0) 1)
    (= (personal-asentamiento b3) 0)
    (= (personal-asentamiento b4) 0)
    (= (suministros-rover r0) 0) (= (personal-rover r0) 0) (estacionado r0 b2)
    (peticion-abierta p0 b0) (peticion-personal p0)
)
(:goal
    (= (peticiones-cerradas) 1)
)
)