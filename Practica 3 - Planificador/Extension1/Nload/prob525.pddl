(define (problem prob525) (:domain peticionador)
(:objects
    r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 - rover
    b2 - almacen
    b0 b1 - asentamiento
    p0 p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p27 p28 p29 p30 p31 p32 p33 p34 p35 p36 p37 p38 p39 p40 p41 p42 p43 p44 p45 p46 p47 p48 p49 p50 p51 p52 p53 p54 p55 p56 p57 p58 p59 p60 p61 p62 p63 p64 p65 p66 p67 p68 p69 p70 p71 p72 p73 p74 p75 p76 p77 p78 p79 p80 p81 p82 p83 p84 p85 p86 p87 p88 p89 p90 p91 p92 p93 p94 p95 p96 p97 p98 p99 p100 p101 p102 p103 p104 p105 p106 p107 p108 p109 p110 p111 p112 p113 p114 p115 p116 p117 p118 p119 p120 p121 p122 p123 p124 p125 p126 p127 p128 p129 p130 p131 p132 p133 p134 p135 p136 p137 p138 p139 p140 p141 p142 p143 p144 p145 p146 p147 p148 p149 p150 p151 p152 p153 p154 p155 p156 p157 p158 p159 p160 p161 p162 p163 p164 p165 p166 p167 p168 p169 p170 p171 p172 p173 p174 p175 p176 p177 p178 p179 p180 p181 p182 p183 p184 p185 p186 p187 p188 p189 p190 p191 p192 p193 p194 p195 p196 p197 p198 p199 p200 p201 p202 p203 p204 p205 p206 p207 p208 p209 p210 p211 p212 p213 p214 p215 p216 p217 p218 p219 p220 p221 p222 p223 p224 p225 p226 p227 p228 p229 p230 p231 p232 p233 p234 p235 p236 p237 p238 p239 p240 p241 p242 p243 p244 p245 p246 p247 p248 p249 p250 p251 p252 p253 p254 p255 p256 p257 p258 p259 p260 p261 p262 p263 p264 p265 p266 p267 p268 p269 p270 p271 p272 p273 p274 p275 p276 p277 p278 p279 p280 p281 p282 p283 p284 p285 p286 p287 p288 p289 p290 p291 p292 p293 p294 p295 p296 p297 p298 p299 p300 p301 p302 p303 p304 p305 p306 p307 p308 p309 p310 p311 p312 p313 p314 p315 p316 p317 p318 p319 p320 p321 p322 p323 p324 p325 p326 p327 p328 p329 p330 p331 p332 p333 p334 p335 p336 p337 p338 p339 p340 p341 p342 p343 p344 p345 p346 p347 p348 p349 p350 p351 p352 p353 p354 p355 p356 p357 p358 p359 p360 p361 p362 p363 p364 p365 p366 p367 p368 p369 p370 p371 p372 p373 p374 p375 p376 p377 p378 p379 p380 p381 p382 p383 p384 p385 p386 p387 p388 p389 p390 p391 p392 p393 p394 p395 p396 p397 p398 p399 p400 p401 p402 p403 p404 p405 p406 p407 p408 p409 p410 p411 p412 p413 p414 p415 p416 p417 p418 p419 p420 p421 p422 p423 p424 p425 p426 p427 p428 p429 p430 p431 p432 p433 p434 p435 p436 p437 p438 p439 p440 p441 p442 p443 p444 p445 p446 p447 p448 p449 p450 p451 p452 p453 p454 p455 p456 p457 p458 p459 p460 p461 p462 p463 p464 p465 p466 p467 p468 p469 p470 p471 p472 p473 p474 p475 p476 p477 p478 p479 p480 p481 p482 p483 p484 p485 p486 p487 p488 p489 p490 p491 p492 p493 p494 p495 p496 p497 p498 p499 p500 p501 p502 p503 p504 p505 p506 p507 p508 p509 p510 p511 p512 p513 p514 p515 p516 p517 p518 p519 p520 p521 p522 p523 p524 - peticion
)
(:init
    (= (peticiones-cerradas) 0)
    (camino b0 b1)
    (camino b0 b2)
    (camino b1 b2)
    (= (suministros-base b2) 215)
    (= (suministros-base b0) 0)
    (= (suministros-base b1) 0)
    (= (personal-base b0) 119)
    (= (personal-base b1) 116)
    (= (personal-base b2) 0)
    (= (suministros-rover r0) 0) (= (personal-rover r0) 0) (estacionado r0 b3)
    (= (suministros-rover r1) 0) (= (personal-rover r1) 0) (estacionado r1 b3)
    (= (suministros-rover r2) 0) (= (personal-rover r2) 0) (estacionado r2 b3)
    (= (suministros-rover r3) 0) (= (personal-rover r3) 0) (estacionado r3 b2)
    (= (suministros-rover r4) 0) (= (personal-rover r4) 0) (estacionado r4 b1)
    (= (suministros-rover r5) 0) (= (personal-rover r5) 0) (estacionado r5 b1)
    (= (suministros-rover r6) 0) (= (personal-rover r6) 0) (estacionado r6 b3)
    (= (suministros-rover r7) 0) (= (personal-rover r7) 0) (estacionado r7 b2)
    (= (suministros-rover r8) 0) (= (personal-rover r8) 0) (estacionado r8 b0)
    (= (suministros-rover r9) 0) (= (personal-rover r9) 0) (estacionado r9 b1)
    (peticion-abierta p0 b0) (peticion-suministros p0)
    (peticion-abierta p1 b1) (peticion-suministros p1)
    (peticion-abierta p2 b1) (peticion-suministros p2)
    (peticion-abierta p3 b1) (peticion-suministros p3)
    (peticion-abierta p4 b1) (peticion-suministros p4)
    (peticion-abierta p5 b0) (peticion-suministros p5)
    (peticion-abierta p6 b1) (peticion-suministros p6)
    (peticion-abierta p7 b0) (peticion-suministros p7)
    (peticion-abierta p8 b0) (peticion-suministros p8)
    (peticion-abierta p9 b1) (peticion-suministros p9)
    (peticion-abierta p10 b0) (peticion-suministros p10)
    (peticion-abierta p11 b0) (peticion-suministros p11)
    (peticion-abierta p12 b1) (peticion-suministros p12)
    (peticion-abierta p13 b1) (peticion-suministros p13)
    (peticion-abierta p14 b1) (peticion-suministros p14)
    (peticion-abierta p15 b0) (peticion-suministros p15)
    (peticion-abierta p16 b1) (peticion-suministros p16)
    (peticion-abierta p17 b0) (peticion-suministros p17)
    (peticion-abierta p18 b1) (peticion-suministros p18)
    (peticion-abierta p19 b0) (peticion-suministros p19)
    (peticion-abierta p20 b0) (peticion-suministros p20)
    (peticion-abierta p21 b1) (peticion-suministros p21)
    (peticion-abierta p22 b0) (peticion-suministros p22)
    (peticion-abierta p23 b0) (peticion-suministros p23)
    (peticion-abierta p24 b1) (peticion-suministros p24)
    (peticion-abierta p25 b1) (peticion-suministros p25)
    (peticion-abierta p26 b1) (peticion-suministros p26)
    (peticion-abierta p27 b1) (peticion-suministros p27)
    (peticion-abierta p28 b1) (peticion-suministros p28)
    (peticion-abierta p29 b0) (peticion-suministros p29)
    (peticion-abierta p30 b0) (peticion-suministros p30)
    (peticion-abierta p31 b1) (peticion-suministros p31)
    (peticion-abierta p32 b1) (peticion-suministros p32)
    (peticion-abierta p33 b1) (peticion-suministros p33)
    (peticion-abierta p34 b1) (peticion-suministros p34)
    (peticion-abierta p35 b0) (peticion-suministros p35)
    (peticion-abierta p36 b1) (peticion-suministros p36)
    (peticion-abierta p37 b0) (peticion-suministros p37)
    (peticion-abierta p38 b1) (peticion-suministros p38)
    (peticion-abierta p39 b1) (peticion-suministros p39)
    (peticion-abierta p40 b0) (peticion-suministros p40)
    (peticion-abierta p41 b1) (peticion-suministros p41)
    (peticion-abierta p42 b1) (peticion-suministros p42)
    (peticion-abierta p43 b0) (peticion-suministros p43)
    (peticion-abierta p44 b0) (peticion-suministros p44)
    (peticion-abierta p45 b1) (peticion-suministros p45)
    (peticion-abierta p46 b0) (peticion-suministros p46)
    (peticion-abierta p47 b0) (peticion-suministros p47)
    (peticion-abierta p48 b0) (peticion-suministros p48)
    (peticion-abierta p49 b0) (peticion-suministros p49)
    (peticion-abierta p50 b0) (peticion-suministros p50)
    (peticion-abierta p51 b0) (peticion-suministros p51)
    (peticion-abierta p52 b1) (peticion-suministros p52)
    (peticion-abierta p53 b0) (peticion-suministros p53)
    (peticion-abierta p54 b0) (peticion-suministros p54)
    (peticion-abierta p55 b1) (peticion-suministros p55)
    (peticion-abierta p56 b1) (peticion-suministros p56)
    (peticion-abierta p57 b1) (peticion-suministros p57)
    (peticion-abierta p58 b1) (peticion-suministros p58)
    (peticion-abierta p59 b0) (peticion-suministros p59)
    (peticion-abierta p60 b1) (peticion-suministros p60)
    (peticion-abierta p61 b0) (peticion-suministros p61)
    (peticion-abierta p62 b1) (peticion-suministros p62)
    (peticion-abierta p63 b0) (peticion-suministros p63)
    (peticion-abierta p64 b1) (peticion-suministros p64)
    (peticion-abierta p65 b0) (peticion-suministros p65)
    (peticion-abierta p66 b1) (peticion-suministros p66)
    (peticion-abierta p67 b0) (peticion-suministros p67)
    (peticion-abierta p68 b1) (peticion-suministros p68)
    (peticion-abierta p69 b0) (peticion-suministros p69)
    (peticion-abierta p70 b0) (peticion-suministros p70)
    (peticion-abierta p71 b0) (peticion-suministros p71)
    (peticion-abierta p72 b1) (peticion-suministros p72)
    (peticion-abierta p73 b0) (peticion-suministros p73)
    (peticion-abierta p74 b0) (peticion-suministros p74)
    (peticion-abierta p75 b1) (peticion-suministros p75)
    (peticion-abierta p76 b1) (peticion-suministros p76)
    (peticion-abierta p77 b1) (peticion-suministros p77)
    (peticion-abierta p78 b0) (peticion-suministros p78)
    (peticion-abierta p79 b0) (peticion-suministros p79)
    (peticion-abierta p80 b0) (peticion-suministros p80)
    (peticion-abierta p81 b0) (peticion-suministros p81)
    (peticion-abierta p82 b0) (peticion-suministros p82)
    (peticion-abierta p83 b0) (peticion-suministros p83)
    (peticion-abierta p84 b1) (peticion-suministros p84)
    (peticion-abierta p85 b1) (peticion-suministros p85)
    (peticion-abierta p86 b1) (peticion-suministros p86)
    (peticion-abierta p87 b0) (peticion-suministros p87)
    (peticion-abierta p88 b0) (peticion-suministros p88)
    (peticion-abierta p89 b1) (peticion-suministros p89)
    (peticion-abierta p90 b0) (peticion-suministros p90)
    (peticion-abierta p91 b1) (peticion-suministros p91)
    (peticion-abierta p92 b1) (peticion-suministros p92)
    (peticion-abierta p93 b1) (peticion-suministros p93)
    (peticion-abierta p94 b1) (peticion-suministros p94)
    (peticion-abierta p95 b1) (peticion-suministros p95)
    (peticion-abierta p96 b1) (peticion-suministros p96)
    (peticion-abierta p97 b0) (peticion-suministros p97)
    (peticion-abierta p98 b0) (peticion-suministros p98)
    (peticion-abierta p99 b0) (peticion-suministros p99)
    (peticion-abierta p100 b1) (peticion-suministros p100)
    (peticion-abierta p101 b1) (peticion-suministros p101)
    (peticion-abierta p102 b1) (peticion-suministros p102)
    (peticion-abierta p103 b0) (peticion-suministros p103)
    (peticion-abierta p104 b0) (peticion-suministros p104)
    (peticion-abierta p105 b1) (peticion-suministros p105)
    (peticion-abierta p106 b0) (peticion-suministros p106)
    (peticion-abierta p107 b1) (peticion-suministros p107)
    (peticion-abierta p108 b1) (peticion-suministros p108)
    (peticion-abierta p109 b1) (peticion-suministros p109)
    (peticion-abierta p110 b0) (peticion-suministros p110)
    (peticion-abierta p111 b0) (peticion-suministros p111)
    (peticion-abierta p112 b0) (peticion-suministros p112)
    (peticion-abierta p113 b0) (peticion-suministros p113)
    (peticion-abierta p114 b0) (peticion-suministros p114)
    (peticion-abierta p115 b0) (peticion-suministros p115)
    (peticion-abierta p116 b0) (peticion-suministros p116)
    (peticion-abierta p117 b1) (peticion-suministros p117)
    (peticion-abierta p118 b0) (peticion-suministros p118)
    (peticion-abierta p119 b1) (peticion-suministros p119)
    (peticion-abierta p120 b1) (peticion-suministros p120)
    (peticion-abierta p121 b0) (peticion-suministros p121)
    (peticion-abierta p122 b0) (peticion-suministros p122)
    (peticion-abierta p123 b1) (peticion-suministros p123)
    (peticion-abierta p124 b1) (peticion-suministros p124)
    (peticion-abierta p125 b1) (peticion-suministros p125)
    (peticion-abierta p126 b0) (peticion-suministros p126)
    (peticion-abierta p127 b0) (peticion-suministros p127)
    (peticion-abierta p128 b0) (peticion-suministros p128)
    (peticion-abierta p129 b1) (peticion-suministros p129)
    (peticion-abierta p130 b0) (peticion-suministros p130)
    (peticion-abierta p131 b1) (peticion-suministros p131)
    (peticion-abierta p132 b1) (peticion-suministros p132)
    (peticion-abierta p133 b1) (peticion-suministros p133)
    (peticion-abierta p134 b1) (peticion-suministros p134)
    (peticion-abierta p135 b0) (peticion-suministros p135)
    (peticion-abierta p136 b0) (peticion-suministros p136)
    (peticion-abierta p137 b0) (peticion-suministros p137)
    (peticion-abierta p138 b0) (peticion-suministros p138)
    (peticion-abierta p139 b1) (peticion-suministros p139)
    (peticion-abierta p140 b1) (peticion-suministros p140)
    (peticion-abierta p141 b1) (peticion-suministros p141)
    (peticion-abierta p142 b0) (peticion-suministros p142)
    (peticion-abierta p143 b1) (peticion-suministros p143)
    (peticion-abierta p144 b1) (peticion-suministros p144)
    (peticion-abierta p145 b1) (peticion-suministros p145)
    (peticion-abierta p146 b1) (peticion-suministros p146)
    (peticion-abierta p147 b1) (peticion-suministros p147)
    (peticion-abierta p148 b1) (peticion-suministros p148)
    (peticion-abierta p149 b0) (peticion-suministros p149)
    (peticion-abierta p150 b0) (peticion-suministros p150)
    (peticion-abierta p151 b0) (peticion-suministros p151)
    (peticion-abierta p152 b0) (peticion-suministros p152)
    (peticion-abierta p153 b1) (peticion-suministros p153)
    (peticion-abierta p154 b1) (peticion-suministros p154)
    (peticion-abierta p155 b0) (peticion-suministros p155)
    (peticion-abierta p156 b0) (peticion-suministros p156)
    (peticion-abierta p157 b1) (peticion-suministros p157)
    (peticion-abierta p158 b1) (peticion-suministros p158)
    (peticion-abierta p159 b0) (peticion-suministros p159)
    (peticion-abierta p160 b1) (peticion-suministros p160)
    (peticion-abierta p161 b0) (peticion-suministros p161)
    (peticion-abierta p162 b0) (peticion-suministros p162)
    (peticion-abierta p163 b1) (peticion-suministros p163)
    (peticion-abierta p164 b1) (peticion-suministros p164)
    (peticion-abierta p165 b0) (peticion-suministros p165)
    (peticion-abierta p166 b1) (peticion-suministros p166)
    (peticion-abierta p167 b1) (peticion-suministros p167)
    (peticion-abierta p168 b1) (peticion-suministros p168)
    (peticion-abierta p169 b0) (peticion-suministros p169)
    (peticion-abierta p170 b0) (peticion-suministros p170)
    (peticion-abierta p171 b1) (peticion-suministros p171)
    (peticion-abierta p172 b0) (peticion-suministros p172)
    (peticion-abierta p173 b0) (peticion-suministros p173)
    (peticion-abierta p174 b0) (peticion-suministros p174)
    (peticion-abierta p175 b0) (peticion-suministros p175)
    (peticion-abierta p176 b1) (peticion-suministros p176)
    (peticion-abierta p177 b0) (peticion-suministros p177)
    (peticion-abierta p178 b1) (peticion-suministros p178)
    (peticion-abierta p179 b0) (peticion-suministros p179)
    (peticion-abierta p180 b1) (peticion-suministros p180)
    (peticion-abierta p181 b1) (peticion-suministros p181)
    (peticion-abierta p182 b0) (peticion-suministros p182)
    (peticion-abierta p183 b0) (peticion-suministros p183)
    (peticion-abierta p184 b1) (peticion-suministros p184)
    (peticion-abierta p185 b1) (peticion-suministros p185)
    (peticion-abierta p186 b0) (peticion-suministros p186)
    (peticion-abierta p187 b1) (peticion-suministros p187)
    (peticion-abierta p188 b0) (peticion-suministros p188)
    (peticion-abierta p189 b1) (peticion-suministros p189)
    (peticion-abierta p190 b1) (peticion-suministros p190)
    (peticion-abierta p191 b0) (peticion-suministros p191)
    (peticion-abierta p192 b0) (peticion-suministros p192)
    (peticion-abierta p193 b0) (peticion-suministros p193)
    (peticion-abierta p194 b1) (peticion-suministros p194)
    (peticion-abierta p195 b1) (peticion-suministros p195)
    (peticion-abierta p196 b1) (peticion-suministros p196)
    (peticion-abierta p197 b0) (peticion-suministros p197)
    (peticion-abierta p198 b1) (peticion-suministros p198)
    (peticion-abierta p199 b1) (peticion-suministros p199)
    (peticion-abierta p200 b0) (peticion-suministros p200)
    (peticion-abierta p201 b0) (peticion-suministros p201)
    (peticion-abierta p202 b0) (peticion-suministros p202)
    (peticion-abierta p203 b1) (peticion-suministros p203)
    (peticion-abierta p204 b1) (peticion-suministros p204)
    (peticion-abierta p205 b0) (peticion-suministros p205)
    (peticion-abierta p206 b0) (peticion-suministros p206)
    (peticion-abierta p207 b0) (peticion-suministros p207)
    (peticion-abierta p208 b0) (peticion-suministros p208)
    (peticion-abierta p209 b1) (peticion-suministros p209)
    (peticion-abierta p210 b1) (peticion-suministros p210)
    (peticion-abierta p211 b0) (peticion-suministros p211)
    (peticion-abierta p212 b0) (peticion-suministros p212)
    (peticion-abierta p213 b1) (peticion-suministros p213)
    (peticion-abierta p214 b1) (peticion-suministros p214)
    (peticion-abierta p215 b0) (peticion-suministros p215)
    (peticion-abierta p216 b0) (peticion-suministros p216)
    (peticion-abierta p217 b1) (peticion-suministros p217)
    (peticion-abierta p218 b0) (peticion-suministros p218)
    (peticion-abierta p219 b0) (peticion-suministros p219)
    (peticion-abierta p220 b1) (peticion-personal p220)
    (peticion-abierta p221 b0) (peticion-personal p221)
    (peticion-abierta p222 b0) (peticion-personal p222)
    (peticion-abierta p223 b1) (peticion-personal p223)
    (peticion-abierta p224 b1) (peticion-personal p224)
    (peticion-abierta p225 b1) (peticion-personal p225)
    (peticion-abierta p226 b0) (peticion-personal p226)
    (peticion-abierta p227 b1) (peticion-personal p227)
    (peticion-abierta p228 b1) (peticion-personal p228)
    (peticion-abierta p229 b1) (peticion-personal p229)
    (peticion-abierta p230 b0) (peticion-personal p230)
    (peticion-abierta p231 b1) (peticion-personal p231)
    (peticion-abierta p232 b0) (peticion-personal p232)
    (peticion-abierta p233 b0) (peticion-personal p233)
    (peticion-abierta p234 b1) (peticion-personal p234)
    (peticion-abierta p235 b0) (peticion-personal p235)
    (peticion-abierta p236 b1) (peticion-personal p236)
    (peticion-abierta p237 b1) (peticion-personal p237)
    (peticion-abierta p238 b0) (peticion-personal p238)
    (peticion-abierta p239 b0) (peticion-personal p239)
    (peticion-abierta p240 b0) (peticion-personal p240)
    (peticion-abierta p241 b1) (peticion-personal p241)
    (peticion-abierta p242 b0) (peticion-personal p242)
    (peticion-abierta p243 b0) (peticion-personal p243)
    (peticion-abierta p244 b0) (peticion-personal p244)
    (peticion-abierta p245 b0) (peticion-personal p245)
    (peticion-abierta p246 b0) (peticion-personal p246)
    (peticion-abierta p247 b0) (peticion-personal p247)
    (peticion-abierta p248 b0) (peticion-personal p248)
    (peticion-abierta p249 b1) (peticion-personal p249)
    (peticion-abierta p250 b1) (peticion-personal p250)
    (peticion-abierta p251 b0) (peticion-personal p251)
    (peticion-abierta p252 b0) (peticion-personal p252)
    (peticion-abierta p253 b0) (peticion-personal p253)
    (peticion-abierta p254 b0) (peticion-personal p254)
    (peticion-abierta p255 b1) (peticion-personal p255)
    (peticion-abierta p256 b0) (peticion-personal p256)
    (peticion-abierta p257 b1) (peticion-personal p257)
    (peticion-abierta p258 b1) (peticion-personal p258)
    (peticion-abierta p259 b1) (peticion-personal p259)
    (peticion-abierta p260 b0) (peticion-personal p260)
    (peticion-abierta p261 b0) (peticion-personal p261)
    (peticion-abierta p262 b0) (peticion-personal p262)
    (peticion-abierta p263 b1) (peticion-personal p263)
    (peticion-abierta p264 b1) (peticion-personal p264)
    (peticion-abierta p265 b1) (peticion-personal p265)
    (peticion-abierta p266 b1) (peticion-personal p266)
    (peticion-abierta p267 b1) (peticion-personal p267)
    (peticion-abierta p268 b1) (peticion-personal p268)
    (peticion-abierta p269 b0) (peticion-personal p269)
    (peticion-abierta p270 b0) (peticion-personal p270)
    (peticion-abierta p271 b0) (peticion-personal p271)
    (peticion-abierta p272 b1) (peticion-personal p272)
    (peticion-abierta p273 b0) (peticion-personal p273)
    (peticion-abierta p274 b1) (peticion-personal p274)
    (peticion-abierta p275 b0) (peticion-personal p275)
    (peticion-abierta p276 b0) (peticion-personal p276)
    (peticion-abierta p277 b0) (peticion-personal p277)
    (peticion-abierta p278 b1) (peticion-personal p278)
    (peticion-abierta p279 b0) (peticion-personal p279)
    (peticion-abierta p280 b0) (peticion-personal p280)
    (peticion-abierta p281 b0) (peticion-personal p281)
    (peticion-abierta p282 b1) (peticion-personal p282)
    (peticion-abierta p283 b1) (peticion-personal p283)
    (peticion-abierta p284 b1) (peticion-personal p284)
    (peticion-abierta p285 b0) (peticion-personal p285)
    (peticion-abierta p286 b0) (peticion-personal p286)
    (peticion-abierta p287 b0) (peticion-personal p287)
    (peticion-abierta p288 b1) (peticion-personal p288)
    (peticion-abierta p289 b0) (peticion-personal p289)
    (peticion-abierta p290 b0) (peticion-personal p290)
    (peticion-abierta p291 b0) (peticion-personal p291)
    (peticion-abierta p292 b1) (peticion-personal p292)
    (peticion-abierta p293 b1) (peticion-personal p293)
    (peticion-abierta p294 b1) (peticion-personal p294)
    (peticion-abierta p295 b0) (peticion-personal p295)
    (peticion-abierta p296 b1) (peticion-personal p296)
    (peticion-abierta p297 b1) (peticion-personal p297)
    (peticion-abierta p298 b1) (peticion-personal p298)
    (peticion-abierta p299 b0) (peticion-personal p299)
    (peticion-abierta p300 b0) (peticion-personal p300)
    (peticion-abierta p301 b1) (peticion-personal p301)
    (peticion-abierta p302 b1) (peticion-personal p302)
    (peticion-abierta p303 b0) (peticion-personal p303)
    (peticion-abierta p304 b1) (peticion-personal p304)
    (peticion-abierta p305 b1) (peticion-personal p305)
    (peticion-abierta p306 b0) (peticion-personal p306)
    (peticion-abierta p307 b1) (peticion-personal p307)
    (peticion-abierta p308 b1) (peticion-personal p308)
    (peticion-abierta p309 b1) (peticion-personal p309)
    (peticion-abierta p310 b0) (peticion-personal p310)
    (peticion-abierta p311 b1) (peticion-personal p311)
    (peticion-abierta p312 b1) (peticion-personal p312)
    (peticion-abierta p313 b1) (peticion-personal p313)
    (peticion-abierta p314 b0) (peticion-personal p314)
    (peticion-abierta p315 b0) (peticion-personal p315)
    (peticion-abierta p316 b0) (peticion-personal p316)
    (peticion-abierta p317 b1) (peticion-personal p317)
    (peticion-abierta p318 b0) (peticion-personal p318)
    (peticion-abierta p319 b0) (peticion-personal p319)
    (peticion-abierta p320 b1) (peticion-personal p320)
    (peticion-abierta p321 b1) (peticion-personal p321)
    (peticion-abierta p322 b0) (peticion-personal p322)
    (peticion-abierta p323 b1) (peticion-personal p323)
    (peticion-abierta p324 b1) (peticion-personal p324)
    (peticion-abierta p325 b0) (peticion-personal p325)
    (peticion-abierta p326 b0) (peticion-personal p326)
    (peticion-abierta p327 b1) (peticion-personal p327)
    (peticion-abierta p328 b1) (peticion-personal p328)
    (peticion-abierta p329 b0) (peticion-personal p329)
    (peticion-abierta p330 b1) (peticion-personal p330)
    (peticion-abierta p331 b1) (peticion-personal p331)
    (peticion-abierta p332 b0) (peticion-personal p332)
    (peticion-abierta p333 b1) (peticion-personal p333)
    (peticion-abierta p334 b0) (peticion-personal p334)
    (peticion-abierta p335 b1) (peticion-personal p335)
    (peticion-abierta p336 b0) (peticion-personal p336)
    (peticion-abierta p337 b1) (peticion-personal p337)
    (peticion-abierta p338 b1) (peticion-personal p338)
    (peticion-abierta p339 b0) (peticion-personal p339)
    (peticion-abierta p340 b0) (peticion-personal p340)
    (peticion-abierta p341 b1) (peticion-personal p341)
    (peticion-abierta p342 b0) (peticion-personal p342)
    (peticion-abierta p343 b1) (peticion-personal p343)
    (peticion-abierta p344 b0) (peticion-personal p344)
    (peticion-abierta p345 b1) (peticion-personal p345)
    (peticion-abierta p346 b1) (peticion-personal p346)
    (peticion-abierta p347 b0) (peticion-personal p347)
    (peticion-abierta p348 b1) (peticion-personal p348)
    (peticion-abierta p349 b0) (peticion-personal p349)
    (peticion-abierta p350 b1) (peticion-personal p350)
    (peticion-abierta p351 b1) (peticion-personal p351)
    (peticion-abierta p352 b0) (peticion-personal p352)
    (peticion-abierta p353 b0) (peticion-personal p353)
    (peticion-abierta p354 b1) (peticion-personal p354)
    (peticion-abierta p355 b0) (peticion-personal p355)
    (peticion-abierta p356 b0) (peticion-personal p356)
    (peticion-abierta p357 b1) (peticion-personal p357)
    (peticion-abierta p358 b1) (peticion-personal p358)
    (peticion-abierta p359 b1) (peticion-personal p359)
    (peticion-abierta p360 b1) (peticion-personal p360)
    (peticion-abierta p361 b0) (peticion-personal p361)
    (peticion-abierta p362 b1) (peticion-personal p362)
    (peticion-abierta p363 b1) (peticion-personal p363)
    (peticion-abierta p364 b1) (peticion-personal p364)
    (peticion-abierta p365 b0) (peticion-personal p365)
    (peticion-abierta p366 b0) (peticion-personal p366)
    (peticion-abierta p367 b0) (peticion-personal p367)
    (peticion-abierta p368 b0) (peticion-personal p368)
    (peticion-abierta p369 b1) (peticion-personal p369)
    (peticion-abierta p370 b1) (peticion-personal p370)
    (peticion-abierta p371 b1) (peticion-personal p371)
    (peticion-abierta p372 b0) (peticion-personal p372)
    (peticion-abierta p373 b0) (peticion-personal p373)
    (peticion-abierta p374 b0) (peticion-personal p374)
    (peticion-abierta p375 b0) (peticion-personal p375)
    (peticion-abierta p376 b1) (peticion-personal p376)
    (peticion-abierta p377 b1) (peticion-personal p377)
    (peticion-abierta p378 b1) (peticion-personal p378)
    (peticion-abierta p379 b0) (peticion-personal p379)
    (peticion-abierta p380 b0) (peticion-personal p380)
    (peticion-abierta p381 b0) (peticion-personal p381)
    (peticion-abierta p382 b1) (peticion-personal p382)
    (peticion-abierta p383 b1) (peticion-personal p383)
    (peticion-abierta p384 b1) (peticion-personal p384)
    (peticion-abierta p385 b1) (peticion-personal p385)
    (peticion-abierta p386 b1) (peticion-personal p386)
    (peticion-abierta p387 b1) (peticion-personal p387)
    (peticion-abierta p388 b0) (peticion-personal p388)
    (peticion-abierta p389 b0) (peticion-personal p389)
    (peticion-abierta p390 b0) (peticion-personal p390)
    (peticion-abierta p391 b0) (peticion-personal p391)
    (peticion-abierta p392 b1) (peticion-personal p392)
    (peticion-abierta p393 b1) (peticion-personal p393)
    (peticion-abierta p394 b1) (peticion-personal p394)
    (peticion-abierta p395 b0) (peticion-personal p395)
    (peticion-abierta p396 b1) (peticion-personal p396)
    (peticion-abierta p397 b1) (peticion-personal p397)
    (peticion-abierta p398 b1) (peticion-personal p398)
    (peticion-abierta p399 b1) (peticion-personal p399)
    (peticion-abierta p400 b0) (peticion-personal p400)
    (peticion-abierta p401 b1) (peticion-personal p401)
    (peticion-abierta p402 b1) (peticion-personal p402)
    (peticion-abierta p403 b1) (peticion-personal p403)
    (peticion-abierta p404 b1) (peticion-personal p404)
    (peticion-abierta p405 b0) (peticion-personal p405)
    (peticion-abierta p406 b1) (peticion-personal p406)
    (peticion-abierta p407 b1) (peticion-personal p407)
    (peticion-abierta p408 b0) (peticion-personal p408)
    (peticion-abierta p409 b1) (peticion-personal p409)
    (peticion-abierta p410 b0) (peticion-personal p410)
    (peticion-abierta p411 b0) (peticion-personal p411)
    (peticion-abierta p412 b0) (peticion-personal p412)
    (peticion-abierta p413 b1) (peticion-personal p413)
    (peticion-abierta p414 b1) (peticion-personal p414)
    (peticion-abierta p415 b1) (peticion-personal p415)
    (peticion-abierta p416 b0) (peticion-personal p416)
    (peticion-abierta p417 b0) (peticion-personal p417)
    (peticion-abierta p418 b0) (peticion-personal p418)
    (peticion-abierta p419 b1) (peticion-personal p419)
    (peticion-abierta p420 b0) (peticion-personal p420)
    (peticion-abierta p421 b1) (peticion-personal p421)
    (peticion-abierta p422 b0) (peticion-personal p422)
    (peticion-abierta p423 b0) (peticion-personal p423)
    (peticion-abierta p424 b0) (peticion-personal p424)
    (peticion-abierta p425 b1) (peticion-personal p425)
    (peticion-abierta p426 b1) (peticion-personal p426)
    (peticion-abierta p427 b0) (peticion-personal p427)
    (peticion-abierta p428 b0) (peticion-personal p428)
    (peticion-abierta p429 b1) (peticion-personal p429)
    (peticion-abierta p430 b0) (peticion-personal p430)
    (peticion-abierta p431 b0) (peticion-personal p431)
    (peticion-abierta p432 b1) (peticion-personal p432)
    (peticion-abierta p433 b1) (peticion-personal p433)
    (peticion-abierta p434 b1) (peticion-personal p434)
    (peticion-abierta p435 b1) (peticion-personal p435)
    (peticion-abierta p436 b0) (peticion-personal p436)
    (peticion-abierta p437 b1) (peticion-personal p437)
    (peticion-abierta p438 b1) (peticion-personal p438)
    (peticion-abierta p439 b1) (peticion-personal p439)
    (peticion-abierta p440 b0) (peticion-personal p440)
    (peticion-abierta p441 b1) (peticion-personal p441)
    (peticion-abierta p442 b0) (peticion-personal p442)
    (peticion-abierta p443 b1) (peticion-personal p443)
    (peticion-abierta p444 b0) (peticion-personal p444)
    (peticion-abierta p445 b0) (peticion-personal p445)
    (peticion-abierta p446 b0) (peticion-personal p446)
    (peticion-abierta p447 b1) (peticion-personal p447)
    (peticion-abierta p448 b1) (peticion-personal p448)
    (peticion-abierta p449 b1) (peticion-personal p449)
    (peticion-abierta p450 b1) (peticion-personal p450)
    (peticion-abierta p451 b1) (peticion-personal p451)
    (peticion-abierta p452 b1) (peticion-personal p452)
    (peticion-abierta p453 b0) (peticion-personal p453)
    (peticion-abierta p454 b0) (peticion-personal p454)
    (peticion-abierta p455 b1) (peticion-personal p455)
    (peticion-abierta p456 b0) (peticion-personal p456)
    (peticion-abierta p457 b0) (peticion-personal p457)
    (peticion-abierta p458 b1) (peticion-personal p458)
    (peticion-abierta p459 b0) (peticion-personal p459)
    (peticion-abierta p460 b0) (peticion-personal p460)
    (peticion-abierta p461 b0) (peticion-personal p461)
    (peticion-abierta p462 b0) (peticion-personal p462)
    (peticion-abierta p463 b1) (peticion-personal p463)
    (peticion-abierta p464 b0) (peticion-personal p464)
    (peticion-abierta p465 b0) (peticion-personal p465)
    (peticion-abierta p466 b0) (peticion-personal p466)
    (peticion-abierta p467 b1) (peticion-personal p467)
    (peticion-abierta p468 b0) (peticion-personal p468)
    (peticion-abierta p469 b1) (peticion-personal p469)
    (peticion-abierta p470 b1) (peticion-personal p470)
    (peticion-abierta p471 b1) (peticion-personal p471)
    (peticion-abierta p472 b1) (peticion-personal p472)
    (peticion-abierta p473 b0) (peticion-personal p473)
    (peticion-abierta p474 b1) (peticion-personal p474)
    (peticion-abierta p475 b1) (peticion-personal p475)
    (peticion-abierta p476 b1) (peticion-personal p476)
    (peticion-abierta p477 b1) (peticion-personal p477)
    (peticion-abierta p478 b1) (peticion-personal p478)
    (peticion-abierta p479 b0) (peticion-personal p479)
    (peticion-abierta p480 b1) (peticion-personal p480)
    (peticion-abierta p481 b1) (peticion-personal p481)
    (peticion-abierta p482 b0) (peticion-personal p482)
    (peticion-abierta p483 b0) (peticion-personal p483)
    (peticion-abierta p484 b0) (peticion-personal p484)
    (peticion-abierta p485 b0) (peticion-personal p485)
    (peticion-abierta p486 b1) (peticion-personal p486)
    (peticion-abierta p487 b0) (peticion-personal p487)
    (peticion-abierta p488 b1) (peticion-personal p488)
    (peticion-abierta p489 b0) (peticion-personal p489)
    (peticion-abierta p490 b0) (peticion-personal p490)
    (peticion-abierta p491 b0) (peticion-personal p491)
    (peticion-abierta p492 b1) (peticion-personal p492)
    (peticion-abierta p493 b0) (peticion-personal p493)
    (peticion-abierta p494 b1) (peticion-personal p494)
    (peticion-abierta p495 b0) (peticion-personal p495)
    (peticion-abierta p496 b1) (peticion-personal p496)
    (peticion-abierta p497 b0) (peticion-personal p497)
    (peticion-abierta p498 b1) (peticion-personal p498)
    (peticion-abierta p499 b0) (peticion-personal p499)
    (peticion-abierta p500 b0) (peticion-personal p500)
    (peticion-abierta p501 b1) (peticion-personal p501)
    (peticion-abierta p502 b1) (peticion-personal p502)
    (peticion-abierta p503 b1) (peticion-personal p503)
    (peticion-abierta p504 b1) (peticion-personal p504)
    (peticion-abierta p505 b1) (peticion-personal p505)
    (peticion-abierta p506 b0) (peticion-personal p506)
    (peticion-abierta p507 b0) (peticion-personal p507)
    (peticion-abierta p508 b0) (peticion-personal p508)
    (peticion-abierta p509 b1) (peticion-personal p509)
    (peticion-abierta p510 b0) (peticion-personal p510)
    (peticion-abierta p511 b0) (peticion-personal p511)
    (peticion-abierta p512 b1) (peticion-personal p512)
    (peticion-abierta p513 b0) (peticion-personal p513)
    (peticion-abierta p514 b0) (peticion-personal p514)
    (peticion-abierta p515 b1) (peticion-personal p515)
    (peticion-abierta p516 b1) (peticion-personal p516)
    (peticion-abierta p517 b1) (peticion-personal p517)
    (peticion-abierta p518 b1) (peticion-personal p518)
    (peticion-abierta p519 b1) (peticion-personal p519)
    (peticion-abierta p520 b1) (peticion-personal p520)
    (peticion-abierta p521 b1) (peticion-personal p521)
    (peticion-abierta p522 b0) (peticion-personal p522)
    (peticion-abierta p523 b0) (peticion-personal p523)
    (peticion-abierta p524 b1) (peticion-personal p524)
)
(:goal
    (= (peticiones-cerradas) 450)
)
)