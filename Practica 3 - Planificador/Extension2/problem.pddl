(define (problem problem_name) (:domain peticionador)
(:objects 
    r1 - rover
    al1 al2 - almacen
    as1 as2 as3 as4 as5 - asentamiento
    p1 p2 p3 p4 - peticion 
)

(:init
    ;escenario inicial
    (= (combustible-total) 0)
    (= (peticiones-cerradas) 0)
    (= (subministros-base al1) 0)
    (= (subministros-base al2) 1)
    (= (subministros-base as1) 0)
    (= (subministros-base as2) 0)
    (= (subministros-base as3) 0)
    (= (subministros-base as4) 0)
    (= (subministros-base as5) 0)
    (= (personal-base al1) 0)
    (= (personal-base al2) 0)
    (= (personal-base as1) 3)
    (= (personal-base as2) 0)    
    (= (personal-base as3) 0)    
    (= (personal-base as4) 0)    
    (= (personal-base as5) 0)
    (camino al1 as1)
    (camino as1 as2)
    (camino as2 as3)
    (camino as3 as4)
    (camino as4 as5)
    (camino as5 al2)
    (= (combustible r1) 15)
    (= (subministros-rover r1) 0)
    (= (personal-rover r1) 0)
    (estacionado r1 al1)

    ;peticiones
    (peticion-abierta p1 as2)
    (peticion-personal p1)
    (peticion-abierta p2 as1)
    (peticion-subministros p2)
    (peticion-abierta p3 as5)
    (peticion-personal p3)
    (peticion-abierta p4 as4)
    (peticion-personal p4)
)

(:goal
    (= (peticiones-cerradas) 4)
)

;descomentar para minimizar el gasto de combustible
(:metric minimize (combustible-total))
)
