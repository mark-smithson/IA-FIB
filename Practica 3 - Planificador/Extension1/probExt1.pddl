(define (problem probExt1) (:domain peticionador)
(:objects
    r0 r1 r2 r3 - rover
    b0 b1 b3 b5 b6 - almacen
    b2 b4 - asentamiento
    p0 p1 p2 p3 p4 p5 - peticion
)
(:init
    (= (peticiones-cerradas) 0)
    (camino b0 b6)
    (camino b0 b5)
    (camino b1 b2)
    (camino b2 b6)
    (camino b3 b4)
    (camino b4 b5)
    (camino b5 b6)
    (= (suministros-base b0) 1)
    (= (suministros-base b1) 0)
    (= (suministros-base b3) 0)
    (= (suministros-base b5) 0)
    (= (suministros-base b6) 0)
    (= (personal-base b2) 0)
    (= (personal-base b4) 1)
    (= (suministros-rover r0) 0) (= (personal-rover r0) 0) (estacionado r0 b2)
    (= (suministros-rover r1) 0) (= (personal-rover r1) 0) (estacionado r1 b3)
    (= (suministros-rover r2) 0) (= (personal-rover r2) 0) (estacionado r2 b3)
    (= (suministros-rover r3) 0) (= (personal-rover r3) 0) (estacionado r3 b1)
    (peticion-abierta p0 b2) (peticion-suministros p0)
    (peticion-abierta p1 b2) (peticion-suministros p1)
    (peticion-abierta p2 b4) (peticion-personal p2)
    (peticion-abierta p3 b4) (peticion-personal p3)
    (peticion-abierta p4 b4) (peticion-personal p4)
    (peticion-abierta p5 b2) (peticion-personal p5)
)
(:goal
    (= (peticiones-cerradas) 2)
)
)