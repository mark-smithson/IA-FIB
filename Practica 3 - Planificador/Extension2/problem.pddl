(define (problem problem_name) (:domain domain_name)
(:objects 
    r1 r2 r3 - rover
    al1 al2 - almacen
    as1 as2 as3 as4 as5 - asentamiento
    p1 p2 p3 p4 - peticion 
)

(:init
    ;escenario inicial
    (= (peticiones-cerradas) 0)
    (= (combustible-total) 0)
    (= (subministros-almacen al1) 0)
    (= (subministros-almacen al2) 1)
    (= (personal-asentamiento as1) 3)    
    (= (personal-asentamiento as2) 0)    
    (= (personal-asentamiento as3) 0)    
    (= (personal-asentamiento as4) 0)    
    (= (personal-asentamiento as5) 0)
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
    (= (combustible r2) 15)
    (= (subministros-rover r2) 0)
    (= (personal-rover r2) 0)
    (estacionado r2 al1)
    (= (combustible r3) 15)
    (= (subministros-rover r3) 0)
    (= (personal-rover r3) 0)
    (estacionado r3 al1)

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
