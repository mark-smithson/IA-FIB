(define (problem problem_name) (:domain peticionador)
(:objects 
    r1 - rover
    al1 al2 - almacen
    as1 as2 as3 as4 as5 - asentamiento
    p1 p2 p3 p4 p5 - peticion 
)

(:init
    ;escenario inicial
    (= (prioridades-totales) 0)
    (= (combustible-total) 0)
    (= (peticiones-cerradas) 0)
    (= (suministros-base al1) 0)
    (= (suministros-base al2) 1)
    (= (suministros-base as1) 0)
    (= (suministros-base as2) 0)
    (= (suministros-base as3) 0)
    (= (suministros-base as4) 0)
    (= (suministros-base as5) 0)
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
    (= (suministros-rover r1) 0)
    (= (personal-rover r1) 0)
    (estacionado r1 al1)

    ;peticiones
    (peticion-abierta p1 as2)
    (peticion-personal p1)
    (= (prioridad-peticion p1) 1)
    (peticion-abierta p2 as1)
    (peticion-suministros p2)
    (= (prioridad-peticion p2) 1)
    (peticion-abierta p3 as5)
    (peticion-personal p3)
    (= (prioridad-peticion p3) 1)
    (peticion-abierta p4 as4)
    (peticion-personal p4)
    (= (prioridad-peticion p4) 3)
    (peticion-abierta p5 as3)
    (peticion-personal p5)
    (= (prioridad-peticion p5) 3)
)

(:goal
    (= (peticiones-cerradas) 4)
)

; Descomentar para minimizar el gasto de combustible y maximizar 
; las peticiones con prioridad
(:metric minimize (+ 
    (* (prioridades-totales) 2)
    (* (combustible-total) 3)
))
)
