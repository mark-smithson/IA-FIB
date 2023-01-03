(define (problem prob3) (:domain peticionador)
(:objects
    r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 - rover
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
    (= (suministros-rover r2) 0) (= (personal-rover r2) 0) (estacionado r2 b2)
    (= (suministros-rover r3) 0) (= (personal-rover r3) 0) (estacionado r3 b1)
    (= (suministros-rover r4) 0) (= (personal-rover r4) 0) (estacionado r4 b1)
    (= (suministros-rover r5) 0) (= (personal-rover r5) 0) (estacionado r5 b2)
    (= (suministros-rover r6) 0) (= (personal-rover r6) 0) (estacionado r6 b1)
    (= (suministros-rover r7) 0) (= (personal-rover r7) 0) (estacionado r7 b0)
    (= (suministros-rover r8) 0) (= (personal-rover r8) 0) (estacionado r8 b2)
    (= (suministros-rover r9) 0) (= (personal-rover r9) 0) (estacionado r9 b1)
    (peticion-abierta p0 b1) (peticion-suministros p0)
    (peticion-abierta p1 b0) (peticion-suministros p1)
    (peticion-abierta p2 b0) (peticion-suministros p2)
)
(:goal
    (= (peticiones-cerradas) 3)
)
)