(define (problem prob64) (:domain peticionador)
(:objects
    r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 - rover
    b2 b3 b5 b7 b8 b12 b15 b20 b24 b25 b26 b30 b32 b35 b37 b40 b41 b43 b44 b46 b48 b51 b52 b53 b56 - almacen
    b0 b1 b4 b6 b9 b10 b11 b13 b14 b16 b17 b18 b19 b21 b22 b23 b27 b28 b29 b31 b33 b34 b36 b38 b39 b42 b45 b47 b49 b50 b54 b55 b57 b58 b59 b60 b61 b62 b63 - asentamiento
    p0 p1 p2 - peticion
)
(:init
    (= (peticiones-cerradas) 0)
    (camino b0 b1)
    (camino b0 b63)
    (camino b1 b2)
    (camino b2 b3)
    (camino b2 b8)
    (camino b3 b4)
    (camino b4 b53)
    (camino b4 b19)
    (camino b5 b6)
    (camino b6 b49)
    (camino b6 b25)
    (camino b7 b8)
    (camino b7 b31)
    (camino b9 b10)
    (camino b9 b48)
    (camino b10 b23)
    (camino b10 b21)
    (camino b11 b32)
    (camino b11 b56)
    (camino b12 b63)
    (camino b13 b14)
    (camino b14 b15)
    (camino b15 b52)
    (camino b16 b49)
    (camino b16 b17)
    (camino b16 b27)
    (camino b16 b37)
    (camino b18 b42)
    (camino b18 b20)
    (camino b19 b26)
    (camino b22 b23)
    (camino b23 b45)
    (camino b24 b59)
    (camino b24 b47)
    (camino b28 b29)
    (camino b29 b44)
    (camino b30 b62)
    (camino b32 b33)
    (camino b32 b51)
    (camino b33 b43)
    (camino b34 b35)
    (camino b35 b36)
    (camino b36 b37)
    (camino b37 b39)
    (camino b38 b39)
    (camino b40 b41)
    (camino b41 b42)
    (camino b42 b43)
    (camino b43 b44)
    (camino b44 b45)
    (camino b45 b46)
    (camino b46 b50)
    (camino b49 b50)
    (camino b50 b51)
    (camino b52 b53)
    (camino b53 b54)
    (camino b54 b55)
    (camino b55 b56)
    (camino b57 b58)
    (camino b58 b59)
    (camino b59 b60)
    (camino b60 b61)
    (camino b61 b62)
    (camino b62 b63)
    (= (suministros-base b2) 1)
    (= (suministros-base b3) 0)
    (= (suministros-base b5) 1)
    (= (suministros-base b7) 0)
    (= (suministros-base b8) 0)
    (= (suministros-base b12) 0)
    (= (suministros-base b15) 0)
    (= (suministros-base b20) 0)
    (= (suministros-base b24) 0)
    (= (suministros-base b25) 0)
    (= (suministros-base b26) 0)
    (= (suministros-base b30) 0)
    (= (suministros-base b32) 0)
    (= (suministros-base b35) 0)
    (= (suministros-base b37) 0)
    (= (suministros-base b40) 0)
    (= (suministros-base b41) 0)
    (= (suministros-base b43) 0)
    (= (suministros-base b44) 0)
    (= (suministros-base b46) 0)
    (= (suministros-base b48) 0)
    (= (suministros-base b51) 0)
    (= (suministros-base b52) 0)
    (= (suministros-base b53) 0)
    (= (suministros-base b56) 0)
    (= (suministros-base b0) 0)
    (= (suministros-base b1) 0)
    (= (suministros-base b4) 0)
    (= (suministros-base b6) 0)
    (= (suministros-base b9) 0)
    (= (suministros-base b10) 0)
    (= (suministros-base b11) 0)
    (= (suministros-base b13) 0)
    (= (suministros-base b14) 0)
    (= (suministros-base b16) 0)
    (= (suministros-base b17) 0)
    (= (suministros-base b18) 0)
    (= (suministros-base b19) 0)
    (= (suministros-base b21) 0)
    (= (suministros-base b22) 0)
    (= (suministros-base b23) 0)
    (= (suministros-base b27) 0)
    (= (suministros-base b28) 0)
    (= (suministros-base b29) 0)
    (= (suministros-base b31) 0)
    (= (suministros-base b33) 0)
    (= (suministros-base b34) 0)
    (= (suministros-base b36) 0)
    (= (suministros-base b38) 0)
    (= (suministros-base b39) 0)
    (= (suministros-base b42) 0)
    (= (suministros-base b45) 0)
    (= (suministros-base b47) 0)
    (= (suministros-base b49) 0)
    (= (suministros-base b50) 0)
    (= (suministros-base b54) 0)
    (= (suministros-base b55) 0)
    (= (suministros-base b57) 0)
    (= (suministros-base b58) 0)
    (= (suministros-base b59) 0)
    (= (suministros-base b60) 0)
    (= (suministros-base b61) 0)
    (= (suministros-base b62) 0)
    (= (suministros-base b63) 0)
    (= (personal-base b0) 0)
    (= (personal-base b1) 1)
    (= (personal-base b4) 0)
    (= (personal-base b6) 0)
    (= (personal-base b9) 0)
    (= (personal-base b10) 0)
    (= (personal-base b11) 0)
    (= (personal-base b13) 0)
    (= (personal-base b14) 0)
    (= (personal-base b16) 0)
    (= (personal-base b17) 0)
    (= (personal-base b18) 0)
    (= (personal-base b19) 0)
    (= (personal-base b21) 0)
    (= (personal-base b22) 0)
    (= (personal-base b23) 0)
    (= (personal-base b27) 0)
    (= (personal-base b28) 0)
    (= (personal-base b29) 0)
    (= (personal-base b31) 0)
    (= (personal-base b33) 0)
    (= (personal-base b34) 0)
    (= (personal-base b36) 0)
    (= (personal-base b38) 0)
    (= (personal-base b39) 0)
    (= (personal-base b42) 0)
    (= (personal-base b45) 0)
    (= (personal-base b47) 0)
    (= (personal-base b49) 0)
    (= (personal-base b50) 0)
    (= (personal-base b54) 0)
    (= (personal-base b55) 0)
    (= (personal-base b57) 0)
    (= (personal-base b58) 0)
    (= (personal-base b59) 0)
    (= (personal-base b60) 0)
    (= (personal-base b61) 0)
    (= (personal-base b62) 0)
    (= (personal-base b63) 0)
    (= (personal-base b2) 0)
    (= (personal-base b3) 0)
    (= (personal-base b5) 0)
    (= (personal-base b7) 0)
    (= (personal-base b8) 0)
    (= (personal-base b12) 0)
    (= (personal-base b15) 0)
    (= (personal-base b20) 0)
    (= (personal-base b24) 0)
    (= (personal-base b25) 0)
    (= (personal-base b26) 0)
    (= (personal-base b30) 0)
    (= (personal-base b32) 0)
    (= (personal-base b35) 0)
    (= (personal-base b37) 0)
    (= (personal-base b40) 0)
    (= (personal-base b41) 0)
    (= (personal-base b43) 0)
    (= (personal-base b44) 0)
    (= (personal-base b46) 0)
    (= (personal-base b48) 0)
    (= (personal-base b51) 0)
    (= (personal-base b52) 0)
    (= (personal-base b53) 0)
    (= (personal-base b56) 0)
    (= (suministros-rover r0) 0) (= (personal-rover r0) 0) (estacionado r0 b40)
    (= (suministros-rover r1) 0) (= (personal-rover r1) 0) (estacionado r1 b30)
    (= (suministros-rover r2) 0) (= (personal-rover r2) 0) (estacionado r2 b37)
    (= (suministros-rover r3) 0) (= (personal-rover r3) 0) (estacionado r3 b23)
    (= (suministros-rover r4) 0) (= (personal-rover r4) 0) (estacionado r4 b24)
    (= (suministros-rover r5) 0) (= (personal-rover r5) 0) (estacionado r5 b23)
    (= (suministros-rover r6) 0) (= (personal-rover r6) 0) (estacionado r6 b4)
    (= (suministros-rover r7) 0) (= (personal-rover r7) 0) (estacionado r7 b33)
    (= (suministros-rover r8) 0) (= (personal-rover r8) 0) (estacionado r8 b60)
    (= (suministros-rover r9) 0) (= (personal-rover r9) 0) (estacionado r9 b8)
    (peticion-abierta p0 b10) (peticion-suministros p0)
    (peticion-abierta p1 b14) (peticion-suministros p1)
    (peticion-abierta p2 b16) (peticion-personal p2)
)
(:goal
    (= (peticiones-cerradas) 3)
)
)