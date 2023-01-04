(define (problem prob128) (:domain peticionador)
(:objects
    r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 r12 r13 r14 r15 r16 r17 r18 r19 r20 r21 r22 r23 r24 r25 r26 r27 r28 r29 r30 r31 r32 r33 r34 r35 r36 r37 r38 r39 r40 r41 r42 r43 r44 r45 r46 r47 r48 r49 r50 r51 r52 r53 r54 r55 r56 r57 r58 r59 r60 r61 r62 r63 r64 r65 r66 r67 r68 r69 r70 r71 r72 r73 r74 r75 r76 r77 r78 r79 r80 r81 r82 r83 r84 r85 r86 r87 r88 r89 r90 r91 r92 r93 r94 r95 r96 r97 r98 r99 r100 r101 r102 r103 r104 r105 r106 r107 r108 r109 r110 r111 r112 r113 r114 r115 r116 r117 r118 r119 r120 r121 r122 r123 r124 r125 r126 r127 - rover
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
    (= (suministros-rover r0) 0) (= (personal-rover r0) 0) (estacionado r0 b1)
    (= (suministros-rover r1) 0) (= (personal-rover r1) 0) (estacionado r1 b1)
    (= (suministros-rover r2) 0) (= (personal-rover r2) 0) (estacionado r2 b1)
    (= (suministros-rover r3) 0) (= (personal-rover r3) 0) (estacionado r3 b2)
    (= (suministros-rover r4) 0) (= (personal-rover r4) 0) (estacionado r4 b0)
    (= (suministros-rover r5) 0) (= (personal-rover r5) 0) (estacionado r5 b2)
    (= (suministros-rover r6) 0) (= (personal-rover r6) 0) (estacionado r6 b0)
    (= (suministros-rover r7) 0) (= (personal-rover r7) 0) (estacionado r7 b1)
    (= (suministros-rover r8) 0) (= (personal-rover r8) 0) (estacionado r8 b0)
    (= (suministros-rover r9) 0) (= (personal-rover r9) 0) (estacionado r9 b0)
    (= (suministros-rover r10) 0) (= (personal-rover r10) 0) (estacionado r10 b2)
    (= (suministros-rover r11) 0) (= (personal-rover r11) 0) (estacionado r11 b1)
    (= (suministros-rover r12) 0) (= (personal-rover r12) 0) (estacionado r12 b2)
    (= (suministros-rover r13) 0) (= (personal-rover r13) 0) (estacionado r13 b2)
    (= (suministros-rover r14) 0) (= (personal-rover r14) 0) (estacionado r14 b2)
    (= (suministros-rover r15) 0) (= (personal-rover r15) 0) (estacionado r15 b0)
    (= (suministros-rover r16) 0) (= (personal-rover r16) 0) (estacionado r16 b1)
    (= (suministros-rover r17) 0) (= (personal-rover r17) 0) (estacionado r17 b0)
    (= (suministros-rover r18) 0) (= (personal-rover r18) 0) (estacionado r18 b2)
    (= (suministros-rover r19) 0) (= (personal-rover r19) 0) (estacionado r19 b0)
    (= (suministros-rover r20) 0) (= (personal-rover r20) 0) (estacionado r20 b2)
    (= (suministros-rover r21) 0) (= (personal-rover r21) 0) (estacionado r21 b1)
    (= (suministros-rover r22) 0) (= (personal-rover r22) 0) (estacionado r22 b1)
    (= (suministros-rover r23) 0) (= (personal-rover r23) 0) (estacionado r23 b2)
    (= (suministros-rover r24) 0) (= (personal-rover r24) 0) (estacionado r24 b0)
    (= (suministros-rover r25) 0) (= (personal-rover r25) 0) (estacionado r25 b1)
    (= (suministros-rover r26) 0) (= (personal-rover r26) 0) (estacionado r26 b1)
    (= (suministros-rover r27) 0) (= (personal-rover r27) 0) (estacionado r27 b1)
    (= (suministros-rover r28) 0) (= (personal-rover r28) 0) (estacionado r28 b2)
    (= (suministros-rover r29) 0) (= (personal-rover r29) 0) (estacionado r29 b2)
    (= (suministros-rover r30) 0) (= (personal-rover r30) 0) (estacionado r30 b0)
    (= (suministros-rover r31) 0) (= (personal-rover r31) 0) (estacionado r31 b2)
    (= (suministros-rover r32) 0) (= (personal-rover r32) 0) (estacionado r32 b1)
    (= (suministros-rover r33) 0) (= (personal-rover r33) 0) (estacionado r33 b1)
    (= (suministros-rover r34) 0) (= (personal-rover r34) 0) (estacionado r34 b2)
    (= (suministros-rover r35) 0) (= (personal-rover r35) 0) (estacionado r35 b1)
    (= (suministros-rover r36) 0) (= (personal-rover r36) 0) (estacionado r36 b0)
    (= (suministros-rover r37) 0) (= (personal-rover r37) 0) (estacionado r37 b2)
    (= (suministros-rover r38) 0) (= (personal-rover r38) 0) (estacionado r38 b0)
    (= (suministros-rover r39) 0) (= (personal-rover r39) 0) (estacionado r39 b0)
    (= (suministros-rover r40) 0) (= (personal-rover r40) 0) (estacionado r40 b2)
    (= (suministros-rover r41) 0) (= (personal-rover r41) 0) (estacionado r41 b1)
    (= (suministros-rover r42) 0) (= (personal-rover r42) 0) (estacionado r42 b2)
    (= (suministros-rover r43) 0) (= (personal-rover r43) 0) (estacionado r43 b2)
    (= (suministros-rover r44) 0) (= (personal-rover r44) 0) (estacionado r44 b2)
    (= (suministros-rover r45) 0) (= (personal-rover r45) 0) (estacionado r45 b0)
    (= (suministros-rover r46) 0) (= (personal-rover r46) 0) (estacionado r46 b2)
    (= (suministros-rover r47) 0) (= (personal-rover r47) 0) (estacionado r47 b1)
    (= (suministros-rover r48) 0) (= (personal-rover r48) 0) (estacionado r48 b1)
    (= (suministros-rover r49) 0) (= (personal-rover r49) 0) (estacionado r49 b0)
    (= (suministros-rover r50) 0) (= (personal-rover r50) 0) (estacionado r50 b2)
    (= (suministros-rover r51) 0) (= (personal-rover r51) 0) (estacionado r51 b1)
    (= (suministros-rover r52) 0) (= (personal-rover r52) 0) (estacionado r52 b2)
    (= (suministros-rover r53) 0) (= (personal-rover r53) 0) (estacionado r53 b0)
    (= (suministros-rover r54) 0) (= (personal-rover r54) 0) (estacionado r54 b0)
    (= (suministros-rover r55) 0) (= (personal-rover r55) 0) (estacionado r55 b2)
    (= (suministros-rover r56) 0) (= (personal-rover r56) 0) (estacionado r56 b0)
    (= (suministros-rover r57) 0) (= (personal-rover r57) 0) (estacionado r57 b0)
    (= (suministros-rover r58) 0) (= (personal-rover r58) 0) (estacionado r58 b0)
    (= (suministros-rover r59) 0) (= (personal-rover r59) 0) (estacionado r59 b2)
    (= (suministros-rover r60) 0) (= (personal-rover r60) 0) (estacionado r60 b1)
    (= (suministros-rover r61) 0) (= (personal-rover r61) 0) (estacionado r61 b0)
    (= (suministros-rover r62) 0) (= (personal-rover r62) 0) (estacionado r62 b0)
    (= (suministros-rover r63) 0) (= (personal-rover r63) 0) (estacionado r63 b1)
    (= (suministros-rover r64) 0) (= (personal-rover r64) 0) (estacionado r64 b2)
    (= (suministros-rover r65) 0) (= (personal-rover r65) 0) (estacionado r65 b1)
    (= (suministros-rover r66) 0) (= (personal-rover r66) 0) (estacionado r66 b0)
    (= (suministros-rover r67) 0) (= (personal-rover r67) 0) (estacionado r67 b1)
    (= (suministros-rover r68) 0) (= (personal-rover r68) 0) (estacionado r68 b2)
    (= (suministros-rover r69) 0) (= (personal-rover r69) 0) (estacionado r69 b1)
    (= (suministros-rover r70) 0) (= (personal-rover r70) 0) (estacionado r70 b2)
    (= (suministros-rover r71) 0) (= (personal-rover r71) 0) (estacionado r71 b0)
    (= (suministros-rover r72) 0) (= (personal-rover r72) 0) (estacionado r72 b2)
    (= (suministros-rover r73) 0) (= (personal-rover r73) 0) (estacionado r73 b1)
    (= (suministros-rover r74) 0) (= (personal-rover r74) 0) (estacionado r74 b2)
    (= (suministros-rover r75) 0) (= (personal-rover r75) 0) (estacionado r75 b0)
    (= (suministros-rover r76) 0) (= (personal-rover r76) 0) (estacionado r76 b2)
    (= (suministros-rover r77) 0) (= (personal-rover r77) 0) (estacionado r77 b2)
    (= (suministros-rover r78) 0) (= (personal-rover r78) 0) (estacionado r78 b2)
    (= (suministros-rover r79) 0) (= (personal-rover r79) 0) (estacionado r79 b1)
    (= (suministros-rover r80) 0) (= (personal-rover r80) 0) (estacionado r80 b1)
    (= (suministros-rover r81) 0) (= (personal-rover r81) 0) (estacionado r81 b0)
    (= (suministros-rover r82) 0) (= (personal-rover r82) 0) (estacionado r82 b2)
    (= (suministros-rover r83) 0) (= (personal-rover r83) 0) (estacionado r83 b1)
    (= (suministros-rover r84) 0) (= (personal-rover r84) 0) (estacionado r84 b1)
    (= (suministros-rover r85) 0) (= (personal-rover r85) 0) (estacionado r85 b2)
    (= (suministros-rover r86) 0) (= (personal-rover r86) 0) (estacionado r86 b0)
    (= (suministros-rover r87) 0) (= (personal-rover r87) 0) (estacionado r87 b1)
    (= (suministros-rover r88) 0) (= (personal-rover r88) 0) (estacionado r88 b0)
    (= (suministros-rover r89) 0) (= (personal-rover r89) 0) (estacionado r89 b0)
    (= (suministros-rover r90) 0) (= (personal-rover r90) 0) (estacionado r90 b0)
    (= (suministros-rover r91) 0) (= (personal-rover r91) 0) (estacionado r91 b0)
    (= (suministros-rover r92) 0) (= (personal-rover r92) 0) (estacionado r92 b2)
    (= (suministros-rover r93) 0) (= (personal-rover r93) 0) (estacionado r93 b2)
    (= (suministros-rover r94) 0) (= (personal-rover r94) 0) (estacionado r94 b1)
    (= (suministros-rover r95) 0) (= (personal-rover r95) 0) (estacionado r95 b1)
    (= (suministros-rover r96) 0) (= (personal-rover r96) 0) (estacionado r96 b0)
    (= (suministros-rover r97) 0) (= (personal-rover r97) 0) (estacionado r97 b0)
    (= (suministros-rover r98) 0) (= (personal-rover r98) 0) (estacionado r98 b2)
    (= (suministros-rover r99) 0) (= (personal-rover r99) 0) (estacionado r99 b0)
    (= (suministros-rover r100) 0) (= (personal-rover r100) 0) (estacionado r100 b0)
    (= (suministros-rover r101) 0) (= (personal-rover r101) 0) (estacionado r101 b0)
    (= (suministros-rover r102) 0) (= (personal-rover r102) 0) (estacionado r102 b0)
    (= (suministros-rover r103) 0) (= (personal-rover r103) 0) (estacionado r103 b2)
    (= (suministros-rover r104) 0) (= (personal-rover r104) 0) (estacionado r104 b2)
    (= (suministros-rover r105) 0) (= (personal-rover r105) 0) (estacionado r105 b2)
    (= (suministros-rover r106) 0) (= (personal-rover r106) 0) (estacionado r106 b1)
    (= (suministros-rover r107) 0) (= (personal-rover r107) 0) (estacionado r107 b2)
    (= (suministros-rover r108) 0) (= (personal-rover r108) 0) (estacionado r108 b2)
    (= (suministros-rover r109) 0) (= (personal-rover r109) 0) (estacionado r109 b1)
    (= (suministros-rover r110) 0) (= (personal-rover r110) 0) (estacionado r110 b2)
    (= (suministros-rover r111) 0) (= (personal-rover r111) 0) (estacionado r111 b0)
    (= (suministros-rover r112) 0) (= (personal-rover r112) 0) (estacionado r112 b0)
    (= (suministros-rover r113) 0) (= (personal-rover r113) 0) (estacionado r113 b2)
    (= (suministros-rover r114) 0) (= (personal-rover r114) 0) (estacionado r114 b2)
    (= (suministros-rover r115) 0) (= (personal-rover r115) 0) (estacionado r115 b1)
    (= (suministros-rover r116) 0) (= (personal-rover r116) 0) (estacionado r116 b2)
    (= (suministros-rover r117) 0) (= (personal-rover r117) 0) (estacionado r117 b1)
    (= (suministros-rover r118) 0) (= (personal-rover r118) 0) (estacionado r118 b1)
    (= (suministros-rover r119) 0) (= (personal-rover r119) 0) (estacionado r119 b1)
    (= (suministros-rover r120) 0) (= (personal-rover r120) 0) (estacionado r120 b2)
    (= (suministros-rover r121) 0) (= (personal-rover r121) 0) (estacionado r121 b2)
    (= (suministros-rover r122) 0) (= (personal-rover r122) 0) (estacionado r122 b2)
    (= (suministros-rover r123) 0) (= (personal-rover r123) 0) (estacionado r123 b1)
    (= (suministros-rover r124) 0) (= (personal-rover r124) 0) (estacionado r124 b0)
    (= (suministros-rover r125) 0) (= (personal-rover r125) 0) (estacionado r125 b1)
    (= (suministros-rover r126) 0) (= (personal-rover r126) 0) (estacionado r126 b2)
    (= (suministros-rover r127) 0) (= (personal-rover r127) 0) (estacionado r127 b0)
    (peticion-abierta p0 b1) (peticion-suministros p0)
    (peticion-abierta p1 b1) (peticion-suministros p1)
    (peticion-abierta p2 b0) (peticion-suministros p2)
)
(:goal
    (= (peticiones-cerradas) 3)
)
)