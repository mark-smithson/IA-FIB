(define (problem problem_name) (:domain domain_name)
(:objects 
    r - rover
    al1 al2 - almacen
    as1 as2 as3 as4 as5 - asentamiento
    p1 p2 - peticion 
)

(:init
    ;escenario inicial
    (= (peticiones-cerradas) 0)
    (= (subministros-almacen al1) 0)
    (= (subministros-almacen al2) 1)
    (= (personal-asentamiento as1) 1)    
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
    (= (subministros-rover r) 0)
    (= (personal-rover r) 0)
    (estacionado r al1)

    ;peticiones
    (peticion-abierta p1 as2)
    (peticion-personal p1)
    (peticion-abierta p2 as1)
    (peticion-subministros p2)
)

(:goal
    (= (peticiones-cerradas) 2)
)
)
