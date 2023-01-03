(define (problem prob1) (:domain peticionador)
(:objects
    r0 r1 - rover
    b2 - almacen
    b0 b1 - asentamiento
    p0 p1 p2 - peticion
)
(:init
    (= (peticiones-cerradas) 0)
    (camino b0 b1)
    (camino b0 b2)
    (camino b1 b2)
    (= (suministros-base b2) 3)
    (= (suministros-base b0) 0)
    (= (suministros-base b1) 0)
    (= (personal-base b0) 0)
    (= (personal-base b1) 0)
    (= (personal-base b2) 0)
    (= (suministros-rover r0) 0) (= (personal-rover r0) 0) (estacionado r0 b2)
    (= (suministros-rover r1) 0) (= (personal-rover r1) 0) (estacionado r1 b3)
    (peticion-abierta p0 b1) (peticion-suministros p0)
    (peticion-abierta p1 b0) (peticion-suministros p1)
    (peticion-abierta p2 b0) (peticion-suministros p2)
)
(:goal
    (= (peticiones-cerradas) 3)
)
)