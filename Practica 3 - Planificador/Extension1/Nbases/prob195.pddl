(define (problem prob195) (:domain peticionador)
(:objects
    r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 - rover
    b2 b3 b5 b7 b8 b12 b15 b20 b24 b25 b26 b30 b32 b35 b37 b40 b41 b43 b44 b46 b48 b51 b52 b53 b56 b65 b67 b69 b70 b71 b74 b75 b83 b85 b92 b97 b99 b102 b104 b105 b107 b109 b110 b112 b117 b121 b122 b124 b125 b127 b128 b129 b132 b133 b134 b135 b136 b138 b139 b141 b142 b144 b145 b149 b152 b155 b156 b158 b159 b160 b161 b164 b165 b167 b169 b171 b172 b173 b174 b176 b177 b178 b183 b184 b186 b187 b188 b189 b191 b194 - almacen
    b0 b1 b4 b6 b9 b10 b11 b13 b14 b16 b17 b18 b19 b21 b22 b23 b27 b28 b29 b31 b33 b34 b36 b38 b39 b42 b45 b47 b49 b50 b54 b55 b57 b58 b59 b60 b61 b62 b63 b64 b66 b68 b72 b73 b76 b77 b78 b79 b80 b81 b82 b84 b86 b87 b88 b89 b90 b91 b93 b94 b95 b96 b98 b100 b101 b103 b106 b108 b111 b113 b114 b115 b116 b118 b119 b120 b123 b126 b130 b131 b137 b140 b143 b146 b147 b148 b150 b151 b153 b154 b157 b162 b163 b166 b168 b170 b175 b179 b180 b181 b182 b185 b190 b192 b193 - asentamiento
    p0 p1 p2 - peticion
)
(:init
    (= (peticiones-cerradas) 0)
    (camino b0 b53)
    (camino b0 b45)
    (camino b1 b121)
    (camino b2 b3)
    (camino b2 b27)
    (camino b2 b97)
    (camino b3 b141)
    (camino b4 b5)
    (camino b5 b20)
    (camino b5 b56)
    (camino b6 b148)
    (camino b7 b96)
    (camino b8 b9)
    (camino b9 b10)
    (camino b10 b11)
    (camino b11 b62)
    (camino b11 b145)
    (camino b12 b47)
    (camino b13 b107)
    (camino b13 b135)
    (camino b14 b15)
    (camino b15 b16)
    (camino b16 b17)
    (camino b16 b148)
    (camino b17 b179)
    (camino b18 b107)
    (camino b19 b106)
    (camino b19 b178)
    (camino b20 b21)
    (camino b21 b108)
    (camino b21 b65)
    (camino b22 b90)
    (camino b22 b131)
    (camino b23 b113)
    (camino b24 b25)
    (camino b25 b26)
    (camino b26 b27)
    (camino b28 b186)
    (camino b29 b30)
    (camino b30 b95)
    (camino b30 b174)
    (camino b31 b120)
    (camino b31 b82)
    (camino b32 b47)
    (camino b33 b34)
    (camino b34 b142)
    (camino b34 b72)
    (camino b35 b36)
    (camino b36 b179)
    (camino b36 b93)
    (camino b37 b102)
    (camino b38 b107)
    (camino b39 b63)
    (camino b39 b176)
    (camino b40 b41)
    (camino b41 b133)
    (camino b42 b118)
    (camino b43 b44)
    (camino b44 b193)
    (camino b46 b47)
    (camino b46 b182)
    (camino b47 b118)
    (camino b47 b127)
    (camino b48 b76)
    (camino b49 b161)
    (camino b50 b155)
    (camino b51 b180)
    (camino b51 b162)
    (camino b52 b53)
    (camino b52 b123)
    (camino b53 b127)
    (camino b54 b55)
    (camino b54 b177)
    (camino b55 b103)
    (camino b56 b121)
    (camino b56 b152)
    (camino b56 b183)
    (camino b57 b171)
    (camino b58 b65)
    (camino b59 b148)
    (camino b59 b194)
    (camino b60 b61)
    (camino b61 b191)
    (camino b61 b175)
    (camino b62 b72)
    (camino b63 b64)
    (camino b63 b68)
    (camino b64 b65)
    (camino b66 b78)
    (camino b67 b68)
    (camino b69 b70)
    (camino b69 b105)
    (camino b70 b71)
    (camino b71 b74)
    (camino b71 b184)
    (camino b73 b74)
    (camino b73 b187)
    (camino b74 b75)
    (camino b75 b76)
    (camino b76 b162)
    (camino b77 b78)
    (camino b78 b79)
    (camino b78 b168)
    (camino b79 b80)
    (camino b80 b113)
    (camino b80 b117)
    (camino b81 b160)
    (camino b81 b156)
    (camino b83 b84)
    (camino b84 b151)
    (camino b84 b113)
    (camino b85 b143)
    (camino b86 b87)
    (camino b86 b144)
    (camino b86 b153)
    (camino b87 b121)
    (camino b88 b89)
    (camino b88 b166)
    (camino b89 b125)
    (camino b89 b146)
    (camino b90 b91)
    (camino b90 b96)
    (camino b90 b134)
    (camino b91 b166)
    (camino b92 b93)
    (camino b92 b103)
    (camino b94 b95)
    (camino b94 b160)
    (camino b95 b159)
    (camino b98 b99)
    (camino b98 b165)
    (camino b99 b100)
    (camino b99 b119)
    (camino b99 b125)
    (camino b100 b101)
    (camino b101 b189)
    (camino b102 b103)
    (camino b104 b158)
    (camino b105 b172)
    (camino b106 b107)
    (camino b107 b108)
    (camino b108 b109)
    (camino b109 b192)
    (camino b110 b111)
    (camino b111 b117)
    (camino b111 b186)
    (camino b112 b113)
    (camino b112 b171)
    (camino b113 b118)
    (camino b114 b175)
    (camino b114 b115)
    (camino b116 b117)
    (camino b116 b157)
    (camino b117 b170)
    (camino b120 b125)
    (camino b122 b123)
    (camino b124 b125)
    (camino b126 b162)
    (camino b128 b190)
    (camino b129 b130)
    (camino b130 b156)
    (camino b132 b133)
    (camino b133 b134)
    (camino b133 b159)
    (camino b134 b161)
    (camino b136 b137)
    (camino b137 b138)
    (camino b138 b139)
    (camino b139 b140)
    (camino b140 b141)
    (camino b141 b142)
    (camino b142 b143)
    (camino b143 b180)
    (camino b147 b167)
    (camino b149 b150)
    (camino b150 b151)
    (camino b151 b152)
    (camino b154 b155)
    (camino b155 b156)
    (camino b158 b159)
    (camino b162 b193)
    (camino b163 b186)
    (camino b164 b165)
    (camino b167 b168)
    (camino b169 b170)
    (camino b173 b174)
    (camino b179 b180)
    (camino b180 b181)
    (camino b181 b182)
    (camino b185 b186)
    (camino b188 b189)
    (camino b189 b190)
    (camino b190 b191)
    (camino b191 b192)
    (camino b192 b193)
    (= (suministros-base b2) 1)
    (= (suministros-base b3) 1)
    (= (suministros-base b5) 0)
    (= (suministros-base b7) 1)
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
    (= (suministros-base b65) 0)
    (= (suministros-base b67) 0)
    (= (suministros-base b69) 0)
    (= (suministros-base b70) 0)
    (= (suministros-base b71) 0)
    (= (suministros-base b74) 0)
    (= (suministros-base b75) 0)
    (= (suministros-base b83) 0)
    (= (suministros-base b85) 0)
    (= (suministros-base b92) 0)
    (= (suministros-base b97) 0)
    (= (suministros-base b99) 0)
    (= (suministros-base b102) 0)
    (= (suministros-base b104) 0)
    (= (suministros-base b105) 0)
    (= (suministros-base b107) 0)
    (= (suministros-base b109) 0)
    (= (suministros-base b110) 0)
    (= (suministros-base b112) 0)
    (= (suministros-base b117) 0)
    (= (suministros-base b121) 0)
    (= (suministros-base b122) 0)
    (= (suministros-base b124) 0)
    (= (suministros-base b125) 0)
    (= (suministros-base b127) 0)
    (= (suministros-base b128) 0)
    (= (suministros-base b129) 0)
    (= (suministros-base b132) 0)
    (= (suministros-base b133) 0)
    (= (suministros-base b134) 0)
    (= (suministros-base b135) 0)
    (= (suministros-base b136) 0)
    (= (suministros-base b138) 0)
    (= (suministros-base b139) 0)
    (= (suministros-base b141) 0)
    (= (suministros-base b142) 0)
    (= (suministros-base b144) 0)
    (= (suministros-base b145) 0)
    (= (suministros-base b149) 0)
    (= (suministros-base b152) 0)
    (= (suministros-base b155) 0)
    (= (suministros-base b156) 0)
    (= (suministros-base b158) 0)
    (= (suministros-base b159) 0)
    (= (suministros-base b160) 0)
    (= (suministros-base b161) 0)
    (= (suministros-base b164) 0)
    (= (suministros-base b165) 0)
    (= (suministros-base b167) 0)
    (= (suministros-base b169) 0)
    (= (suministros-base b171) 0)
    (= (suministros-base b172) 0)
    (= (suministros-base b173) 0)
    (= (suministros-base b174) 0)
    (= (suministros-base b176) 0)
    (= (suministros-base b177) 0)
    (= (suministros-base b178) 0)
    (= (suministros-base b183) 0)
    (= (suministros-base b184) 0)
    (= (suministros-base b186) 0)
    (= (suministros-base b187) 0)
    (= (suministros-base b188) 0)
    (= (suministros-base b189) 0)
    (= (suministros-base b191) 0)
    (= (suministros-base b194) 0)
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
    (= (suministros-base b64) 0)
    (= (suministros-base b66) 0)
    (= (suministros-base b68) 0)
    (= (suministros-base b72) 0)
    (= (suministros-base b73) 0)
    (= (suministros-base b76) 0)
    (= (suministros-base b77) 0)
    (= (suministros-base b78) 0)
    (= (suministros-base b79) 0)
    (= (suministros-base b80) 0)
    (= (suministros-base b81) 0)
    (= (suministros-base b82) 0)
    (= (suministros-base b84) 0)
    (= (suministros-base b86) 0)
    (= (suministros-base b87) 0)
    (= (suministros-base b88) 0)
    (= (suministros-base b89) 0)
    (= (suministros-base b90) 0)
    (= (suministros-base b91) 0)
    (= (suministros-base b93) 0)
    (= (suministros-base b94) 0)
    (= (suministros-base b95) 0)
    (= (suministros-base b96) 0)
    (= (suministros-base b98) 0)
    (= (suministros-base b100) 0)
    (= (suministros-base b101) 0)
    (= (suministros-base b103) 0)
    (= (suministros-base b106) 0)
    (= (suministros-base b108) 0)
    (= (suministros-base b111) 0)
    (= (suministros-base b113) 0)
    (= (suministros-base b114) 0)
    (= (suministros-base b115) 0)
    (= (suministros-base b116) 0)
    (= (suministros-base b118) 0)
    (= (suministros-base b119) 0)
    (= (suministros-base b120) 0)
    (= (suministros-base b123) 0)
    (= (suministros-base b126) 0)
    (= (suministros-base b130) 0)
    (= (suministros-base b131) 0)
    (= (suministros-base b137) 0)
    (= (suministros-base b140) 0)
    (= (suministros-base b143) 0)
    (= (suministros-base b146) 0)
    (= (suministros-base b147) 0)
    (= (suministros-base b148) 0)
    (= (suministros-base b150) 0)
    (= (suministros-base b151) 0)
    (= (suministros-base b153) 0)
    (= (suministros-base b154) 0)
    (= (suministros-base b157) 0)
    (= (suministros-base b162) 0)
    (= (suministros-base b163) 0)
    (= (suministros-base b166) 0)
    (= (suministros-base b168) 0)
    (= (suministros-base b170) 0)
    (= (suministros-base b175) 0)
    (= (suministros-base b179) 0)
    (= (suministros-base b180) 0)
    (= (suministros-base b181) 0)
    (= (suministros-base b182) 0)
    (= (suministros-base b185) 0)
    (= (suministros-base b190) 0)
    (= (suministros-base b192) 0)
    (= (suministros-base b193) 0)
    (= (personal-base b0) 0)
    (= (personal-base b1) 0)
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
    (= (personal-base b64) 0)
    (= (personal-base b66) 0)
    (= (personal-base b68) 0)
    (= (personal-base b72) 0)
    (= (personal-base b73) 0)
    (= (personal-base b76) 0)
    (= (personal-base b77) 0)
    (= (personal-base b78) 0)
    (= (personal-base b79) 0)
    (= (personal-base b80) 0)
    (= (personal-base b81) 0)
    (= (personal-base b82) 0)
    (= (personal-base b84) 0)
    (= (personal-base b86) 0)
    (= (personal-base b87) 0)
    (= (personal-base b88) 0)
    (= (personal-base b89) 0)
    (= (personal-base b90) 0)
    (= (personal-base b91) 0)
    (= (personal-base b93) 0)
    (= (personal-base b94) 0)
    (= (personal-base b95) 0)
    (= (personal-base b96) 0)
    (= (personal-base b98) 0)
    (= (personal-base b100) 0)
    (= (personal-base b101) 0)
    (= (personal-base b103) 0)
    (= (personal-base b106) 0)
    (= (personal-base b108) 0)
    (= (personal-base b111) 0)
    (= (personal-base b113) 0)
    (= (personal-base b114) 0)
    (= (personal-base b115) 0)
    (= (personal-base b116) 0)
    (= (personal-base b118) 0)
    (= (personal-base b119) 0)
    (= (personal-base b120) 0)
    (= (personal-base b123) 0)
    (= (personal-base b126) 0)
    (= (personal-base b130) 0)
    (= (personal-base b131) 0)
    (= (personal-base b137) 0)
    (= (personal-base b140) 0)
    (= (personal-base b143) 0)
    (= (personal-base b146) 0)
    (= (personal-base b147) 0)
    (= (personal-base b148) 0)
    (= (personal-base b150) 0)
    (= (personal-base b151) 0)
    (= (personal-base b153) 0)
    (= (personal-base b154) 0)
    (= (personal-base b157) 0)
    (= (personal-base b162) 0)
    (= (personal-base b163) 0)
    (= (personal-base b166) 0)
    (= (personal-base b168) 0)
    (= (personal-base b170) 0)
    (= (personal-base b175) 0)
    (= (personal-base b179) 0)
    (= (personal-base b180) 0)
    (= (personal-base b181) 0)
    (= (personal-base b182) 0)
    (= (personal-base b185) 0)
    (= (personal-base b190) 0)
    (= (personal-base b192) 0)
    (= (personal-base b193) 0)
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
    (= (personal-base b65) 0)
    (= (personal-base b67) 0)
    (= (personal-base b69) 0)
    (= (personal-base b70) 0)
    (= (personal-base b71) 0)
    (= (personal-base b74) 0)
    (= (personal-base b75) 0)
    (= (personal-base b83) 0)
    (= (personal-base b85) 0)
    (= (personal-base b92) 0)
    (= (personal-base b97) 0)
    (= (personal-base b99) 0)
    (= (personal-base b102) 0)
    (= (personal-base b104) 0)
    (= (personal-base b105) 0)
    (= (personal-base b107) 0)
    (= (personal-base b109) 0)
    (= (personal-base b110) 0)
    (= (personal-base b112) 0)
    (= (personal-base b117) 0)
    (= (personal-base b121) 0)
    (= (personal-base b122) 0)
    (= (personal-base b124) 0)
    (= (personal-base b125) 0)
    (= (personal-base b127) 0)
    (= (personal-base b128) 0)
    (= (personal-base b129) 0)
    (= (personal-base b132) 0)
    (= (personal-base b133) 0)
    (= (personal-base b134) 0)
    (= (personal-base b135) 0)
    (= (personal-base b136) 0)
    (= (personal-base b138) 0)
    (= (personal-base b139) 0)
    (= (personal-base b141) 0)
    (= (personal-base b142) 0)
    (= (personal-base b144) 0)
    (= (personal-base b145) 0)
    (= (personal-base b149) 0)
    (= (personal-base b152) 0)
    (= (personal-base b155) 0)
    (= (personal-base b156) 0)
    (= (personal-base b158) 0)
    (= (personal-base b159) 0)
    (= (personal-base b160) 0)
    (= (personal-base b161) 0)
    (= (personal-base b164) 0)
    (= (personal-base b165) 0)
    (= (personal-base b167) 0)
    (= (personal-base b169) 0)
    (= (personal-base b171) 0)
    (= (personal-base b172) 0)
    (= (personal-base b173) 0)
    (= (personal-base b174) 0)
    (= (personal-base b176) 0)
    (= (personal-base b177) 0)
    (= (personal-base b178) 0)
    (= (personal-base b183) 0)
    (= (personal-base b184) 0)
    (= (personal-base b186) 0)
    (= (personal-base b187) 0)
    (= (personal-base b188) 0)
    (= (personal-base b189) 0)
    (= (personal-base b191) 0)
    (= (personal-base b194) 0)
    (= (suministros-rover r0) 0) (= (personal-rover r0) 0) (estacionado r0 b16)
    (= (suministros-rover r1) 0) (= (personal-rover r1) 0) (estacionado r1 b66)
    (= (suministros-rover r2) 0) (= (personal-rover r2) 0) (estacionado r2 b179)
    (= (suministros-rover r3) 0) (= (personal-rover r3) 0) (estacionado r3 b40)
    (= (suministros-rover r4) 0) (= (personal-rover r4) 0) (estacionado r4 b114)
    (= (suministros-rover r5) 0) (= (personal-rover r5) 0) (estacionado r5 b135)
    (= (suministros-rover r6) 0) (= (personal-rover r6) 0) (estacionado r6 b124)
    (= (suministros-rover r7) 0) (= (personal-rover r7) 0) (estacionado r7 b143)
    (= (suministros-rover r8) 0) (= (personal-rover r8) 0) (estacionado r8 b154)
    (= (suministros-rover r9) 0) (= (personal-rover r9) 0) (estacionado r9 b193)
    (peticion-abierta p0 b0) (peticion-suministros p0)
    (peticion-abierta p1 b9) (peticion-suministros p1)
    (peticion-abierta p2 b100) (peticion-suministros p2)
)
(:goal
    (= (peticiones-cerradas) 3)
)
)