(define (problem probExt2O) (:domain peticionador)
(:objects
    r0 r1 r2 r3 - rover
    b0 b1 b2 b4 b5 b6 - almacen
    b3 - asentamiento
    p0 p1 p2 p3 p4 p5 - peticion
)
(:init
    (= (combustible-total) 0) (= (peticiones-cerradas) 0)
    (camino b0 b3)
    (camino b1 b2)
    (camino b1 b4)
    (camino b2 b3)
    (camino b3 b5)
    (camino b4 b5)
    (camino b5 b6)
    (= (suministros-base b0) 2)
    (= (suministros-base b1) 0)
    (= (suministros-base b2) 0)
    (= (suministros-base b4) 0)
    (= (suministros-base b5) 0)
    (= (suministros-base b6) 0)
    (= (personal-base b3) 0)
    (= (suministros-rover r0) 0) (= (personal-rover r0) 0) (= (combustible r0) 21) (estacionado r0 b5)
    (= (suministros-rover r1) 0) (= (personal-rover r1) 0) (= (combustible r1) 21) (estacionado r1 b3)
    (= (suministros-rover r2) 0) (= (personal-rover r2) 0) (= (combustible r2) 21) (estacionado r2 b0)
    (= (suministros-rover r3) 0) (= (personal-rover r3) 0) (= (combustible r3) 21) (estacionado r3 b3)
    (peticion-abierta p0 b3) (peticion-suministros p0)
    (peticion-abierta p1 b3) (peticion-suministros p1)
    (peticion-abierta p2 b3) (peticion-suministros p2)
    (peticion-abierta p3 b3) (peticion-suministros p3)
    (peticion-abierta p4 b3) (peticion-suministros p4)
    (peticion-abierta p5 b3) (peticion-suministros p5)
)
(:goal
    (= (peticiones-cerradas) 2)
))
(:metric minimize (combustible-total)))
