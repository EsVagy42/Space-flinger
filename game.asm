;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _getInput
	.globl _setRotatedSprite
	.globl _applyDragToGameObject
	.globl _updateGameObject
	.globl _rotate
	.globl _sqrt
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _enemyUpdate
	.globl _SpaceMap
	.globl _SpaceTiles
	.globl _SpaceShipTiles
	.globl _activeEnemies
	.globl _enemies
	.globl _cordic_table
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
G$enemies$0_0$0==.
_enemies::
	.ds 168
G$activeEnemies$0_0$0==.
_activeEnemies::
	.ds 8
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
G$SpaceShipTiles$0_0$0==.
_SpaceShipTiles::
	.ds 112
G$SpaceTiles$0_0$0==.
_SpaceTiles::
	.ds 80
G$SpaceMap$0_0$0==.
_SpaceMap::
	.ds 1024
G$enemyUpdate$0_0$0==.
_enemyUpdate::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	G$sqrt$0$0	= .
	.globl	G$sqrt$0$0
	C$fixed.c$61$0_0$121	= .
	.globl	C$fixed.c$61$0_0$121
;fixed.c:61: fixed16 sqrt(fixed16 n) {
;	---------------------------------
; Function sqrt
; ---------------------------------
_sqrt::
	add	sp, #-10
;fixed.c:66: fixed16 x = div(n, FIXED(2));
	ld	a, d
	rlca
	sbc	a, a
	ld	c, a
	ld	a, d
	ld	d, e
	ld	e, #0x00
	inc	sp
	inc	sp
	push	de
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), c
	ld	de, #0x0000
	push	de
	ld	d, #0x02
	push	de
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__divslong
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	C$fixed.c$69$1_0$121	= .
	.globl	C$fixed.c$69$1_0$121
;fixed.c:69: while (abs(sub(x, div(n, x))) > tol) {
00101$:
	C$fixed.c$25$1_0$121	= .
	.globl	C$fixed.c$25$1_0$121
;fixed.c:25: return (fixed16)(((int32_t)a << FIXED_SHIFT) / b);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
	ld	b, a
	rlca
	sbc	a, a
	ld	d, a
	ld	e, a
	push	de
	push	bc
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__divslong
	ldhl	sp,	#8
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;fixed.c:17: return a - b;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ld	c, e
	ld	b, a
;fixed.c:30: if (a >= 0)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, h
;fixed.c:32: return a;
	jr	Z, 00108$
;fixed.c:36: return -a;
	xor	a, a
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
;fixed.c:69: while (abs(sub(x, div(n, x))) > tol) {
00108$:
	ld	e, b
	xor	a, a
	ld	d, a
	cp	a, c
	sbc	a, b
	bit	7, e
	jr	Z, 00133$
	bit	7, d
	jr	NZ, 00134$
	cp	a, a
	jr	00134$
00133$:
	bit	7, d
	jr	Z, 00134$
	scf
00134$:
	jr	NC, 00103$
;fixed.c:25: return (fixed16)(((int32_t)a << FIXED_SHIFT) / b);
	ldhl	sp,	#8
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl-)
	dec	hl
;fixed.c:13: return a + b;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
;fixed.c:25: return (fixed16)(((int32_t)a << FIXED_SHIFT) / b);
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	rlca
	sbc	a, a
	ld	(hl+), a
	ld	(hl), a
	ld	a, #0x08
00135$:
	ldhl	sp,	#6
	sla	(hl)
	inc	hl
	rl	(hl)
	inc	hl
	rl	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ,00135$
	ld	de, #0x0000
	push	de
	ld	d, #0x02
	push	de
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__divslong
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#6
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	C$fixed.c$71$1_0$121	= .
	.globl	C$fixed.c$71$1_0$121
;fixed.c:71: x = div(add(x, div(n, x)), FIXED(2));
	jp	00101$
00103$:
	C$fixed.c$75$1_0$121	= .
	.globl	C$fixed.c$75$1_0$121
;fixed.c:75: return x;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	C$fixed.c$76$1_0$121	= .
	.globl	C$fixed.c$76$1_0$121
;fixed.c:76: }
	add	sp, #10
	C$fixed.c$76$1_0$121	= .
	.globl	C$fixed.c$76$1_0$121
	XG$sqrt$0$0	= .
	.globl	XG$sqrt$0$0
	ret
	G$rotate$0$0	= .
	.globl	G$rotate$0$0
	C$fixed.c$103$1_0$147	= .
	.globl	C$fixed.c$103$1_0$147
;fixed.c:103: void rotate(fixed16* x, fixed16* y, fixed16 angle) {
;	---------------------------------
; Function rotate
; ---------------------------------
_rotate::
	add	sp, #-19
	ldhl	sp,	#16
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#14
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	C$fixed.c$105$2_0$147	= .
	.globl	C$fixed.c$105$2_0$147
;fixed.c:105: fixed16 current_angle = FIXED(0);
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), a
	C$fixed.c$108$3_0$149	= .
	.globl	C$fixed.c$108$3_0$149
;fixed.c:108: for (int8_t i = 0; i < 11; i++) {
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#18
	ld	(hl), #0x00
00107$:
	C$fixed.c$117$3_0$147	= .
	.globl	C$fixed.c$117$3_0$147
;fixed.c:117: fixed16 x_new = *x - sign * (*y >> i);
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	C$fixed.c$108$2_0$148	= .
	.globl	C$fixed.c$108$2_0$148
;fixed.c:108: for (int8_t i = 0; i < 11; i++) {
	ldhl	sp,	#18
	ld	a, (hl)
	xor	a, #0x80
	sub	a, #0x8b
	jp	NC, 00101$
	C$fixed.c$110$3_0$149	= .
	.globl	C$fixed.c$110$3_0$149
;fixed.c:110: fixed16 pre_angle = cordic_table[i][0];
	ld	a, (hl)
	ld	c, a
	rlca
	sbc	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_cordic_table
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;fixed.c:114: int sign = (sub(angle, current_angle)) > 0 ? 1 : -1;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	pop	hl
	push	hl
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	c, e
	ld	b, a
	ld	e, b
	xor	a, a
	ld	d, a
	cp	a, c
	sbc	a, b
	bit	7, e
	jr	Z, 00129$
	bit	7, d
	jr	NZ, 00130$
	cp	a, a
	jr	00130$
00129$:
	bit	7, d
	jr	Z, 00130$
	scf
00130$:
	jr	NC, 00111$
	ld	bc, #0x0001
	jr	00112$
00111$:
	ld	bc, #0xffff
00112$:
	C$fixed.c$117$3_0$149	= .
	.globl	C$fixed.c$117$3_0$149
;fixed.c:117: fixed16 x_new = *x - sign * (*y >> i);
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#8
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	push	af
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	pop	af
	inc	a
	jr	00132$
00131$:
	sra	d
	rr	e
00132$:
	dec	a
	jr	NZ, 00131$
	ldhl	sp,	#10
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl-), a
	ld	c, e
	ld	b, d
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ld	c, e
	ldhl	sp,	#12
	ld	(hl), c
	inc	hl
	ld	(hl), a
	C$fixed.c$118$3_0$149	= .
	.globl	C$fixed.c$118$3_0$149
;fixed.c:118: fixed16 y_new = *y + sign * (*x >> i);
	ldhl	sp,	#18
	ld	a, (hl)
	push	af
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	af
	inc	a
	jr	00134$
00133$:
	sra	b
	rr	c
00134$:
	dec	a
	jr	NZ, 00133$
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	C$fixed.c$121$3_0$149	= .
	.globl	C$fixed.c$121$3_0$149
;fixed.c:121: *x = x_new;
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	(de), a
	inc	de
	C$fixed.c$122$3_0$149	= .
	.globl	C$fixed.c$122$3_0$149
;fixed.c:122: *y = y_new;
	ld	a, (hl+)
	ld	(de), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	C$fixed.c$125$3_0$147	= .
	.globl	C$fixed.c$125$3_0$147
;fixed.c:125: current_angle = add(current_angle, sign * pre_angle);
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#10
	ld	a, c
	ld	(hl+), a
;fixed.c:13: return a + b;
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	pop	hl
	push	hl
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	C$fixed.c$125$5_0$154	= .
	.globl	C$fixed.c$125$5_0$154
;fixed.c:125: current_angle = add(current_angle, sign * pre_angle);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	C$fixed.c$108$2_0$148	= .
	.globl	C$fixed.c$108$2_0$148
;fixed.c:108: for (int8_t i = 0; i < 11; i++) {
	ldhl	sp,	#18
	inc	(hl)
	jp	00107$
00101$:
;fixed.c:129: *x = mul(*x, CORRECTION_FACTOR);
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#13
;fixed.c:21: return (fixed16)(((int32_t)a * b) >> FIXED_SHIFT);
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	rlca
	sbc	a, a
	ld	(hl+), a
	ld	(hl), a
	ld	de, #0x0000
	push	de
	ld	e, #0x9b
	push	de
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mullong
	ldhl	sp,	#10
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	(hl), a
	C$fixed.c$129$3_0$157	= .
	.globl	C$fixed.c$129$3_0$157
;fixed.c:129: *x = mul(*x, CORRECTION_FACTOR);
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	(de), a
	inc	de
;fixed.c:130: *y = mul(*y, CORRECTION_FACTOR);
	ld	a, (hl+)
	ld	(de), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
;fixed.c:21: return (fixed16)(((int32_t)a * b) >> FIXED_SHIFT);
	ldhl	sp,	#10
	ld	(hl), c
	inc	hl
	ld	(hl+), a
	rlca
	sbc	a, a
	ld	(hl+), a
	ld	(hl), a
	ld	de, #0x0000
	push	de
	ld	e, #0x9b
	push	de
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mullong
	ldhl	sp,	#10
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	(hl), a
	C$fixed.c$130$3_0$160	= .
	.globl	C$fixed.c$130$3_0$160
;fixed.c:130: *y = mul(*y, CORRECTION_FACTOR);
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	C$fixed.c$131$3_0$147	= .
	.globl	C$fixed.c$131$3_0$147
;fixed.c:131: }
	add	sp, #19
	pop	hl
	pop	af
	jp	(hl)
G$cordic_table$0_0$0 == .
_cordic_table:
	.dw #0x2d00
	.dw #0x0100
	.dw #0x1a90
	.dw #0x0080
	.dw #0x0e09
	.dw #0x0040
	.dw #0x0720
	.dw #0x0020
	.dw #0x0393
	.dw #0x0010
	.dw #0x01ca
	.dw #0x0008
	.dw #0x00e5
	.dw #0x0004
	.dw #0x0072
	.dw #0x0002
	.dw #0x0039
	.dw #0x0001
	.dw #0x001c
	.dw #0x0000
	.dw #0x000e
	.dw #0x0000
	G$updateGameObject$0$0	= .
	.globl	G$updateGameObject$0$0
	C$GameObject.c$31$3_0$165	= .
	.globl	C$GameObject.c$31$3_0$165
;GameObject.c:31: void updateGameObject(GameObject *go, GameObject *player)
;	---------------------------------
; Function updateGameObject
; ---------------------------------
_updateGameObject::
	add	sp, #-22
	ldhl	sp,	#18
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#16
	ld	a, c
	ld	(hl+), a
;GameObject.c:33: go->posx = add(go->posx, go->velx);
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#22
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#21
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
;fixed.c:13: return a + b;
	add	hl, bc
	ld	c, l
	ld	b, h
	C$GameObject.c$33$3_0$172	= .
	.globl	C$GameObject.c$33$3_0$172
;GameObject.c:33: go->posx = add(go->posx, go->velx);
	ldhl	sp,	#18
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	C$GameObject.c$34$2_0$165	= .
	.globl	C$GameObject.c$34$2_0$165
;GameObject.c:34: go->collider.posx = add(go->collider.posx, go->velx);
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
;fixed.c:13: return a + b;
	add	hl, bc
	ld	c, l
	ld	b, h
	C$GameObject.c$34$3_0$175	= .
	.globl	C$GameObject.c$34$3_0$175
;GameObject.c:34: go->collider.posx = add(go->collider.posx, go->velx);
	ldhl	sp,	#14
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	C$GameObject.c$35$1_0$165	= .
	.globl	C$GameObject.c$35$1_0$165
;GameObject.c:35: go->posy = add(go->posy, go->vely);
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#22
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#21
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	pop	de
	push	de
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
;fixed.c:13: return a + b;
	add	hl, bc
	ld	c, l
	ld	b, h
	C$GameObject.c$35$3_0$178	= .
	.globl	C$GameObject.c$35$3_0$178
;GameObject.c:35: go->posy = add(go->posy, go->vely);
	pop	hl
	push	hl
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	C$GameObject.c$36$1_0$165	= .
	.globl	C$GameObject.c$36$1_0$165
;GameObject.c:36: go->collider.posy = add(go->collider.posy, go->vely);
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ldhl	sp,#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#14
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#20
	ld	(hl+), a
	inc	de
	ld	a, (de)
;fixed.c:13: return a + b;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#14
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	C$GameObject.c$36$3_0$181	= .
	.globl	C$GameObject.c$36$3_0$181
;GameObject.c:36: go->collider.posy = add(go->collider.posy, go->vely);
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	C$GameObject.c$38$1_0$165	= .
	.globl	C$GameObject.c$38$1_0$165
;GameObject.c:38: if (go->spriteSizex == 1 && go->spriteSizey == 1)
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0012
	add	hl, de
	ld	e, l
	ld	d, h
	C$GameObject.c$40$2_0$165	= .
	.globl	C$GameObject.c$40$2_0$165
;GameObject.c:40: move_sprite(go->firstSprite, INT(go->posx) - INT(player->posx) + 84, INT(go->posy) - INT(player->posy) + 84);
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	inc	bc
	inc	bc
	push	de
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ldhl	sp,	#22
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#21
	ld	(hl), a
	C$GameObject.c$38$1_0$165	= .
	.globl	C$GameObject.c$38$1_0$165
;GameObject.c:38: if (go->spriteSizex == 1 && go->spriteSizey == 1)
	ldhl	sp,	#15
	ld	a, (hl)
	dec	a
	jr	NZ, 00125$
	ld	a, (de)
	dec	a
	jr	NZ, 00125$
;GameObject.c:40: move_sprite(go->firstSprite, INT(go->posx) - INT(player->posx) + 84, INT(go->posy) - INT(player->posy) + 84);
	pop	de
	push	de
	ld	a, (de)
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
;	spillPairReg hl
;	spillPairReg hl
	ldhl	sp,	#15
	ld	(hl), a
	ld	l, c
	ld	h, b
	ld	a, (hl+)
	ld	b, (hl)
	ldhl	sp,	#15
	ld	a, (hl)
	sub	a, b
	add	a, #0x54
	ld	b, a
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
;	spillPairReg hl
;	spillPairReg hl
	ld	c, a
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
	ld	e, a
	ld	a, c
	sub	a, e
	add	a, #0x54
	ld	c, a
	ldhl	sp,#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
;C:/gbdk-win64/gbdk/include/gb/gb.h:1675: OAM_item_t * itm = &shadow_OAM[nb];
	ld	e, (hl)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;C:/gbdk-win64/gbdk/include/gb/gb.h:1676: itm->y=y, itm->x=x;
	ld	(hl), b
	inc	hl
	ld	(hl), c
	C$GameObject.c$41$2_0$166	= .
	.globl	C$GameObject.c$41$2_0$166
;GameObject.c:41: return;
	jp	00118$
	C$GameObject.c$43$2_0$165	= .
	.globl	C$GameObject.c$43$2_0$165
;GameObject.c:43: for (int y = 0; y < go->spriteSizey; y++)
00125$:
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl+), a
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ld	bc, #0x0000
00116$:
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	rlca
	sbc	a, a
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	e, h
	ld	d, b
	ld	a, c
	sub	a, l
	ld	a, b
	sbc	a, h
	bit	7, e
	jr	Z, 00156$
	bit	7, d
	jr	NZ, 00157$
	cp	a, a
	jr	00157$
00156$:
	bit	7, d
	jr	Z, 00157$
	scf
00157$:
	jp	NC, 00118$
	C$GameObject.c$45$2_0$165	= .
	.globl	C$GameObject.c$45$2_0$165
;GameObject.c:45: for (int x = 0; x < go->spriteSizex; x++)
	xor	a, a
	ldhl	sp,	#20
	ld	(hl+), a
	ld	(hl), a
00113$:
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl+), a
	rlca
	sbc	a, a
	ld	(hl), a
	ldhl	sp,	#20
	ld	e, l
	ld	d, h
	ldhl	sp,	#14
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00158$
	bit	7, d
	jr	NZ, 00159$
	cp	a, a
	jr	00159$
00158$:
	bit	7, d
	jr	Z, 00159$
	scf
00159$:
	jp	NC, 00117$
;GameObject.c:47: move_sprite(go->firstSprite + y * go->spriteSizex + x, INT(go->posx) + x * 8 - INT(player->posx) + 84, INT(go->posy) + y * 8 - INT(player->posy) + 84);
	pop	de
	push	de
	ld	a, (de)
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
	ld	e, a
	ldhl	sp,	#11
	ld	(hl), c
	ld	a, (hl)
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
	ld	e, a
	ldhl	sp,	#15
	ld	a, (hl)
	sub	a, e
	add	a, #0x54
	ldhl	sp,	#12
	ld	(hl), a
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
	ld	e, a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
	ld	e, a
	ldhl	sp,	#15
	ld	a, (hl-)
	sub	a, e
	add	a, #0x54
	ld	(hl), a
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#15
	ld	(hl), a
	push	bc
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	call	__mulschar
	ld	a, c
	pop	bc
	ldhl	sp,	#15
	add	a, (hl)
	dec	hl
	dec	hl
	add	a, (hl)
	ld	e, a
;C:/gbdk-win64/gbdk/include/gb/gb.h:1675: OAM_item_t * itm = &shadow_OAM[nb];
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, e
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;C:/gbdk-win64/gbdk/include/gb/gb.h:1676: itm->y=y, itm->x=x;
	ldhl	sp,	#12
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	C$GameObject.c$45$4_0$169	= .
	.globl	C$GameObject.c$45$4_0$169
;GameObject.c:45: for (int x = 0; x < go->spriteSizex; x++)
	ldhl	sp,	#20
	inc	(hl)
	jp	NZ,00113$
	inc	hl
	inc	(hl)
	jp	00113$
00117$:
	C$GameObject.c$43$2_0$167	= .
	.globl	C$GameObject.c$43$2_0$167
;GameObject.c:43: for (int y = 0; y < go->spriteSizey; y++)
	inc	bc
	jp	00116$
00118$:
	C$GameObject.c$50$2_0$165	= .
	.globl	C$GameObject.c$50$2_0$165
;GameObject.c:50: }
	add	sp, #22
	C$GameObject.c$50$2_0$165	= .
	.globl	C$GameObject.c$50$2_0$165
	XG$updateGameObject$0$0	= .
	.globl	XG$updateGameObject$0$0
	ret
	G$applyDragToGameObject$0$0	= .
	.globl	G$applyDragToGameObject$0$0
	C$GameObject.c$58$2_0$198	= .
	.globl	C$GameObject.c$58$2_0$198
;GameObject.c:58: void applyDragToGameObject(GameObject* go, int8_t dragRatioShifts)
;	---------------------------------
; Function applyDragToGameObject
; ---------------------------------
_applyDragToGameObject::
	add	sp, #-5
	ldhl	sp,	#3
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
	C$GameObject.c$60$1_0$198	= .
	.globl	C$GameObject.c$60$1_0$198
;GameObject.c:60: if (go->velx != 0)
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	or	a, c
	jr	Z, 00102$
	C$GameObject.c$62$2_0$199	= .
	.globl	C$GameObject.c$62$2_0$199
;GameObject.c:62: fixed16 shiftedx = go->velx >> dragRatioShifts;
	ldhl	sp,	#2
	ld	a, (hl)
	push	af
	ld	e, c
	ld	d, b
	pop	af
	inc	a
	jr	00134$
00133$:
	sra	d
	rr	e
00134$:
	dec	a
	jr	NZ, 00133$
	C$GameObject.c$63$2_0$199	= .
	.globl	C$GameObject.c$63$2_0$199
;GameObject.c:63: go->velx = sub(go->velx, shiftedx != 0 ? shiftedx : 1);
	ld	a, d
	or	a, e
	jr	NZ, 00110$
	ld	de, #0x0001
00110$:
;fixed.c:17: return a - b;
	ld	a, c
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
	C$GameObject.c$63$4_0$202	= .
	.globl	C$GameObject.c$63$4_0$202
;GameObject.c:63: go->velx = sub(go->velx, shiftedx != 0 ? shiftedx : 1);
	pop	hl
	push	hl
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00102$:
	C$GameObject.c$65$1_0$198	= .
	.globl	C$GameObject.c$65$1_0$198
;GameObject.c:65: if (go->vely != 0)
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	or	a, c
	jr	Z, 00107$
	C$GameObject.c$67$2_0$200	= .
	.globl	C$GameObject.c$67$2_0$200
;GameObject.c:67: fixed16 shiftedy = go->vely >> dragRatioShifts;
	ldhl	sp,	#2
	ld	a, (hl)
	push	af
	ld	e, c
	ld	d, b
	pop	af
	inc	a
	jr	00136$
00135$:
	sra	d
	rr	e
00136$:
	dec	a
	jr	NZ, 00135$
	C$GameObject.c$68$2_0$200	= .
	.globl	C$GameObject.c$68$2_0$200
;GameObject.c:68: go->vely = sub(go->vely, shiftedy != 0 ? shiftedy : 1);
	ld	a, d
	or	a, e
	jr	NZ, 00112$
	ld	de, #0x0001
00112$:
	ld	a, c
;fixed.c:17: return a - b;
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
	C$GameObject.c$68$4_0$205	= .
	.globl	C$GameObject.c$68$4_0$205
;GameObject.c:68: go->vely = sub(go->vely, shiftedy != 0 ? shiftedy : 1);
	pop	hl
	push	hl
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00107$:
	C$GameObject.c$70$1_0$198	= .
	.globl	C$GameObject.c$70$1_0$198
;GameObject.c:70: }
	add	sp, #5
	C$GameObject.c$70$1_0$198	= .
	.globl	C$GameObject.c$70$1_0$198
	XG$applyDragToGameObject$0$0	= .
	.globl	XG$applyDragToGameObject$0$0
	ret
	G$setRotatedSprite$0$0	= .
	.globl	G$setRotatedSprite$0$0
	C$GameObject.c$72$1_0$208	= .
	.globl	C$GameObject.c$72$1_0$208
;GameObject.c:72: void setRotatedSprite(int8_t sprite, int8_t tile, fixed16 x, fixed16 y)
;	---------------------------------
; Function setRotatedSprite
; ---------------------------------
_setRotatedSprite::
	add	sp, #-15
	ldhl	sp,	#14
	ld	(hl-), a
	ld	(hl), e
	C$GameObject.c$74$1_0$208	= .
	.globl	C$GameObject.c$74$1_0$208
;GameObject.c:74: if (x == FIXED(0) && y == FIXED(0))
	ldhl	sp,	#18
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00102$
	ldhl	sp,	#20
	ld	a, (hl-)
	or	a, (hl)
	C$GameObject.c$76$2_0$209	= .
	.globl	C$GameObject.c$76$2_0$209
;GameObject.c:76: return;
	jp	Z,00132$
00102$:
;GameObject.c:78: BOOLEAN xsmaller = abs(x) < abs(y);
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	bit	7, (hl)
	jr	NZ, 00111$
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	jr	00113$
00111$:
	ld	de, #0x0000
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#12
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
00113$:
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	bit	7, (hl)
	jr	NZ, 00115$
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	jr	00117$
00115$:
	ld	de, #0x0000
	ldhl	sp,	#11
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00117$:
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00216$
	bit	7, d
	jr	NZ, 00217$
	cp	a, a
	jr	00217$
00216$:
	bit	7, d
	jr	Z, 00217$
	scf
00217$:
	ld	a, #0x00
	rla
	ldhl	sp,	#10
	ld	(hl), a
;GameObject.c:79: if ((abs(xsmaller ? x : y) << 1) < abs(xsmaller ? y : x))
	ld	a, (hl)
	or	a, a
	jr	Z, 00134$
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	jr	00135$
00134$:
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00135$:
;fixed.c:30: if (a >= 0)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, h
;fixed.c:32: return a;
	jr	Z, 00121$
;fixed.c:36: return -a;
	xor	a, a
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
;GameObject.c:79: if ((abs(xsmaller ? x : y) << 1) < abs(xsmaller ? y : x))
00121$:
	sla	c
	rl	b
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,	#10
	ld	a, (hl)
	or	a, a
	jr	NZ, 00137$
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
00137$:
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#9
;fixed.c:30: if (a >= 0)
	ld	(hl-), a
	ld	a, (hl+)
	bit	7, (hl)
	jr	NZ, 00123$
;fixed.c:32: return a;
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
	jr	00125$
00123$:
;fixed.c:36: return -a;
	ld	de, #0x0000
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#12
	ld	(hl-), a
	ld	(hl), e
;GameObject.c:79: if ((abs(xsmaller ? x : y) << 1) < abs(xsmaller ? y : x))
00125$:
	ldhl	sp,	#6
	ld	e, l
	ld	d, h
	ldhl	sp,	#11
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00219$
	bit	7, d
	jr	NZ, 00220$
	cp	a, a
	jr	00220$
00219$:
	bit	7, d
	jr	Z, 00220$
	scf
00220$:
	jp	NC, 00108$
	C$GameObject.c$81$2_1$211	= .
	.globl	C$GameObject.c$81$2_1$211
;GameObject.c:81: if (xsmaller)
	ldhl	sp,	#10
	ld	a, (hl)
	or	a, a
	jr	Z, 00105$
;GameObject.c:83: set_sprite_tile(sprite, tile);
	ldhl	sp,	#14
	ld	c, (hl)
;C:/gbdk-win64/gbdk/include/gb/gb.h:1602: shadow_OAM[nb].tile=tile;
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, c
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#13
	ld	a, (hl)
	ld	(bc), a
;GameObject.c:84: set_sprite_prop(sprite, y > 0 ? S_FLIPY : 0);
	ldhl	sp,	#4
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00221$
	bit	7, d
	jr	NZ, 00222$
	cp	a, a
	jr	00222$
00221$:
	bit	7, d
	jr	Z, 00222$
	scf
00222$:
	jr	NC, 00138$
	ld	bc, #0x0040
	jr	00139$
00138$:
	ld	bc, #0x0000
00139$:
	ldhl	sp,	#14
	ld	b, (hl)
;C:/gbdk-win64/gbdk/include/gb/gb.h:1648: shadow_OAM[nb].prop=prop;
	ld	l, b
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), c
	C$GameObject.c$84$2_1$211	= .
	.globl	C$GameObject.c$84$2_1$211
;GameObject.c:84: set_sprite_prop(sprite, y > 0 ? S_FLIPY : 0);
	jp	00132$
00105$:
;GameObject.c:88: set_sprite_tile(sprite, tile + 2);
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	c, a
	inc	c
	inc	c
;C:/gbdk-win64/gbdk/include/gb/gb.h:1602: shadow_OAM[nb].tile=tile;
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;GameObject.c:89: set_sprite_prop(sprite, x > 0 ? S_FLIPX : 0);
	ldhl	sp,	#2
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00223$
	bit	7, d
	jr	NZ, 00224$
	cp	a, a
	jr	00224$
00223$:
	bit	7, d
	jr	Z, 00224$
	scf
00224$:
	jr	NC, 00140$
	ld	bc, #0x0020
	jr	00141$
00140$:
	ld	bc, #0x0000
00141$:
	ldhl	sp,	#14
	ld	b, (hl)
;C:/gbdk-win64/gbdk/include/gb/gb.h:1648: shadow_OAM[nb].prop=prop;
	ld	l, b
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), c
	C$GameObject.c$89$1_1$210	= .
	.globl	C$GameObject.c$89$1_1$210
;GameObject.c:89: set_sprite_prop(sprite, x > 0 ? S_FLIPX : 0);
	jp	00132$
00108$:
;GameObject.c:94: set_sprite_tile(sprite, tile + 1);
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	c, a
	inc	c
	ld	b, (hl)
;C:/gbdk-win64/gbdk/include/gb/gb.h:1602: shadow_OAM[nb].tile=tile;
	ld	l, b
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;GameObject.c:95: set_sprite_prop(sprite, (x > 0 ? S_FLIPX : 0) | (y > 0 ? S_FLIPY : 0));
	ldhl	sp,	#2
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00225$
	bit	7, d
	jr	NZ, 00226$
	cp	a, a
	jr	00226$
00225$:
	bit	7, d
	jr	Z, 00226$
	scf
00226$:
	jr	NC, 00142$
	ldhl	sp,	#11
	ld	a, #0x20
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00143$
00142$:
	xor	a, a
	ldhl	sp,	#11
	ld	(hl+), a
	ld	(hl), a
00143$:
	ldhl	sp,	#4
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00227$
	bit	7, d
	jr	NZ, 00228$
	cp	a, a
	jr	00228$
00227$:
	bit	7, d
	jr	Z, 00228$
	scf
00228$:
	jr	NC, 00144$
	ldhl	sp,	#9
	ld	a, #0x40
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00145$
00144$:
	xor	a, a
	ldhl	sp,	#9
	ld	(hl+), a
	ld	(hl), a
00145$:
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl+)
	inc	hl
	ld	(hl+), a
	ld	a, (hl-)
	or	a, (hl)
	inc	hl
	ld	(hl+), a
	inc	hl
	ld	c, (hl)
;C:/gbdk-win64/gbdk/include/gb/gb.h:1648: shadow_OAM[nb].prop=prop;
	ldhl	sp,	#10
	ld	a, c
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00229$:
	ldhl	sp,	#10
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00229$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	ld	(de), a
	C$GameObject.c$95$1_1$208	= .
	.globl	C$GameObject.c$95$1_1$208
;GameObject.c:95: set_sprite_prop(sprite, (x > 0 ? S_FLIPX : 0) | (y > 0 ? S_FLIPY : 0));
00132$:
	C$GameObject.c$97$1_1$208	= .
	.globl	C$GameObject.c$97$1_1$208
;GameObject.c:97: }
	add	sp, #15
	pop	hl
	add	sp, #4
	jp	(hl)
	G$getInput$0$0	= .
	.globl	G$getInput$0$0
	C$main.c$15$1_1$259	= .
	.globl	C$main.c$15$1_1$259
;main.c:15: void getInput(uint8_t input, fixed16* x, fixed16* y)
;	---------------------------------
; Function getInput
; ---------------------------------
_getInput::
	add	sp, #-8
	ld	c, a
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
	C$main.c$17$1_0$259	= .
	.globl	C$main.c$17$1_0$259
;main.c:17: *x = FIXED(0);
	ld	a, d
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	C$main.c$18$1_0$259	= .
	.globl	C$main.c$18$1_0$259
;main.c:18: *y = FIXED(0);
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	pop	hl
	push	hl
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	C$main.c$20$1_0$259	= .
	.globl	C$main.c$20$1_0$259
;main.c:20: if (input & J_UP)
	bit	2, c
	jr	Z, 00102$
	C$main.c$22$2_0$260	= .
	.globl	C$main.c$22$2_0$260
;main.c:22: *y = -inputSpeed;
	pop	hl
	push	hl
	ld	a, #0xb4
	ld	(hl+), a
	ld	(hl), #0xff
00102$:
	C$main.c$24$1_0$259	= .
	.globl	C$main.c$24$1_0$259
;main.c:24: if (input & J_DOWN)
	bit	3, c
	jr	Z, 00104$
	C$main.c$26$2_0$261	= .
	.globl	C$main.c$26$2_0$261
;main.c:26: *y = inputSpeed;
	pop	hl
	push	hl
	ld	a, #0x4c
	ld	(hl+), a
	ld	(hl), #0x00
00104$:
	C$main.c$28$1_0$259	= .
	.globl	C$main.c$28$1_0$259
;main.c:28: if (input & J_LEFT)
	bit	1, c
	jr	Z, 00106$
	C$main.c$30$2_0$262	= .
	.globl	C$main.c$30$2_0$262
;main.c:30: *x = -inputSpeed;
	ldhl	sp,	#6
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0xb4
	ld	(hl+), a
	ld	(hl), #0xff
00106$:
	C$main.c$32$1_0$259	= .
	.globl	C$main.c$32$1_0$259
;main.c:32: if (input & J_RIGHT)
	bit	0, c
	jr	Z, 00108$
	C$main.c$34$2_0$263	= .
	.globl	C$main.c$34$2_0$263
;main.c:34: *x = inputSpeed;
	ldhl	sp,	#6
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x4c
	ld	(hl+), a
	ld	(hl), #0x00
00108$:
	C$main.c$37$1_0$259	= .
	.globl	C$main.c$37$1_0$259
;main.c:37: if (*x != 0 && *y != 0)
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00112$
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	or	a, c
	jr	Z, 00112$
	C$main.c$39$2_0$264	= .
	.globl	C$main.c$39$2_0$264
;main.c:39: *x = *x > 0 ? inputSpeedDiagonal : -inputSpeedDiagonal;
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl+), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	e, b
	xor	a, a
	ld	d, a
	cp	a, c
	sbc	a, b
	bit	7, e
	jr	Z, 00162$
	bit	7, d
	jr	NZ, 00163$
	cp	a, a
	jr	00163$
00162$:
	bit	7, d
	jr	Z, 00163$
	scf
00163$:
	jr	NC, 00114$
	ldhl	sp,	#4
	ld	a, #0x36
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00115$
00114$:
	ldhl	sp,	#4
	ld	a, #0xca
	ld	(hl+), a
	ld	(hl), #0xff
00115$:
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	C$main.c$40$2_0$264	= .
	.globl	C$main.c$40$2_0$264
;main.c:40: *y = *y > 0 ? inputSpeedDiagonal : -inputSpeedDiagonal;
	pop	bc
	push	bc
	pop	de
	push	de
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	e, h
	xor	a, a
	ld	d, a
	cp	a, l
	sbc	a, h
	bit	7, e
	jr	Z, 00164$
	bit	7, d
	jr	NZ, 00165$
	cp	a, a
	jr	00165$
00164$:
	bit	7, d
	jr	Z, 00165$
	scf
00165$:
	jr	NC, 00116$
	ld	de, #0x0036
	jr	00117$
00116$:
	ld	de, #0xffca
00117$:
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
00112$:
	C$main.c$42$1_0$259	= .
	.globl	C$main.c$42$1_0$259
;main.c:42: }
	add	sp, #8
	pop	hl
	pop	af
	jp	(hl)
	G$main$0$0	= .
	.globl	G$main$0$0
	C$main.c$68$1_0$269	= .
	.globl	C$main.c$68$1_0$269
;main.c:68: void main()
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-64
	C$main.c$70$1_0$269	= .
	.globl	C$main.c$70$1_0$269
;main.c:70: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
	C$main.c$71$1_0$269	= .
	.globl	C$main.c$71$1_0$269
;main.c:71: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
	C$main.c$73$2_0$270	= .
	.globl	C$main.c$73$2_0$270
;main.c:73: BOOLEAN attached = TRUE;
	ldhl	sp,	#46
	ld	(hl), #0x01
	C$main.c$75$2_0$270	= .
	.globl	C$main.c$75$2_0$270
;main.c:75: uint8_t enemyTimer = 255;
	ldhl	sp,	#61
	ld	(hl), #0xff
	C$main.c$78$1_1$270	= .
	.globl	C$main.c$78$1_1$270
;main.c:78: set_sprite_data(0, 12, SpaceShipTiles);
	ld	de, #_SpaceShipTiles
	push	de
	ld	hl, #0xc00
	push	hl
	call	_set_sprite_data
	add	sp, #4
;C:/gbdk-win64/gbdk/include/gb/gb.h:1602: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x03
	C$main.c$84$1_1$270	= .
	.globl	C$main.c$84$1_1$270
;main.c:84: set_bkg_data(0, 4, SpaceTiles);
	ld	de, #_SpaceTiles
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_bkg_data
	add	sp, #4
	C$main.c$86$1_1$270	= .
	.globl	C$main.c$86$1_1$270
;main.c:86: set_bkg_tiles(0, 0, 32, 32, SpaceMap);
	ld	de, #_SpaceMap
	push	de
	ld	hl, #0x2020
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
	C$main.c$89$1_2$271	= .
	.globl	C$main.c$89$1_2$271
;main.c:89: player.gameObject.posx = FIXED(0);
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	C$main.c$90$1_2$271	= .
	.globl	C$main.c$90$1_2$271
;main.c:90: player.gameObject.posy = FIXED(0);
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	C$main.c$91$1_2$271	= .
	.globl	C$main.c$91$1_2$271
;main.c:91: player.gameObject.velx = FIXED(0);
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	C$main.c$92$1_2$271	= .
	.globl	C$main.c$92$1_2$271
;main.c:92: player.gameObject.vely = FIXED(0);
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	C$main.c$93$1_2$271	= .
	.globl	C$main.c$93$1_2$271
;main.c:93: player.gameObject.firstSprite = 0;
	ldhl	sp,	#16
	C$main.c$94$1_2$271	= .
	.globl	C$main.c$94$1_2$271
;main.c:94: player.gameObject.spriteSizex = 1;
	xor	a, a
	ld	(hl+), a
	C$main.c$95$1_2$271	= .
	.globl	C$main.c$95$1_2$271
;main.c:95: player.gameObject.spriteSizey = 1;
	C$main.c$96$1_2$271	= .
	.globl	C$main.c$96$1_2$271
;main.c:96: player.accelerationShifts = 0;
	ld	a,#0x01
	ld	(hl+),a
	ld	(hl+), a
	C$main.c$97$1_2$271	= .
	.globl	C$main.c$97$1_2$271
;main.c:97: player.dragShifts = 5;
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x05
	C$main.c$98$1_3$269	= .
	.globl	C$main.c$98$1_3$269
;main.c:98: player.gameObject.collider.posx = add(player.gameObject.posx, FIXED(2));
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	c, a
;	spillPairReg hl
;	spillPairReg hl
;fixed.c:13: return a + b;
	ld	a, (hl)
	add	a, #0x02
	ld	b, a
	C$main.c$98$3_2$295	= .
	.globl	C$main.c$98$3_2$295
;main.c:98: player.gameObject.collider.posx = add(player.gameObject.posx, FIXED(2));
	ldhl	sp,	#8
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	C$main.c$99$1_2$271	= .
	.globl	C$main.c$99$1_2$271
;main.c:99: player.gameObject.collider.posy = add(player.gameObject.posy, FIXED(2));
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
;	spillPairReg hl
;	spillPairReg hl
;fixed.c:13: return a + b;
	ld	a, (hl)
	add	a, #0x02
	ld	b, a
	C$main.c$99$3_2$298	= .
	.globl	C$main.c$99$3_2$298
;main.c:99: player.gameObject.collider.posy = add(player.gameObject.posy, FIXED(2));
	ldhl	sp,	#10
	ld	a, c
	ld	(hl+), a
	C$main.c$100$1_2$271	= .
	.globl	C$main.c$100$1_2$271
;main.c:100: player.gameObject.collider.sizex = FIXED(4);
	ld	a, b
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	C$main.c$101$1_2$271	= .
	.globl	C$main.c$101$1_2$271
;main.c:101: player.gameObject.collider.sizey = FIXED(4);
	ld	a, #0x04
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x04
	C$main.c$105$1_3$272	= .
	.globl	C$main.c$105$1_3$272
;main.c:105: flinger.gameObject.posx = FIXED(0);
	xor	a, a
	ldhl	sp,	#21
	ld	(hl+), a
	C$main.c$106$1_3$272	= .
	.globl	C$main.c$106$1_3$272
;main.c:106: flinger.gameObject.posy = FIXED(0);
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	C$main.c$107$1_3$272	= .
	.globl	C$main.c$107$1_3$272
;main.c:107: flinger.gameObject.velx = FIXED(0);
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	C$main.c$108$1_3$272	= .
	.globl	C$main.c$108$1_3$272
;main.c:108: flinger.gameObject.vely = FIXED(0);
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	C$main.c$109$1_3$272	= .
	.globl	C$main.c$109$1_3$272
;main.c:109: flinger.gameObject.firstSprite = 1;
	ldhl	sp,	#37
	ld	(hl), #0x01
	C$main.c$110$1_3$272	= .
	.globl	C$main.c$110$1_3$272
;main.c:110: flinger.gameObject.spriteSizex = 1;
	inc	hl
	ld	(hl), #0x01
	C$main.c$111$1_3$272	= .
	.globl	C$main.c$111$1_3$272
;main.c:111: flinger.gameObject.spriteSizey = 1;
	inc	hl
	ld	(hl), #0x01
	C$main.c$112$1_3$272	= .
	.globl	C$main.c$112$1_3$272
;main.c:112: flinger.accelerationShifts = 6;
	inc	hl
	ld	(hl), #0x06
	C$main.c$113$1_3$272	= .
	.globl	C$main.c$113$1_3$272
;main.c:113: flinger.dragShifts = attachedFlingerDragShifts;
	inc	hl
	ld	(hl), #0x04
	C$main.c$114$1_3$269	= .
	.globl	C$main.c$114$1_3$269
;main.c:114: flinger.gameObject.collider.posx = flinger.gameObject.posx;
	ldhl	sp,	#21
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ldhl	sp,	#29
	ld	(hl), c
	inc	hl
	ld	(hl), b
	C$main.c$115$1_3$272	= .
	.globl	C$main.c$115$1_3$272
;main.c:115: flinger.gameObject.collider.posy = flinger.gameObject.posy;
	ldhl	sp,	#23
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ldhl	sp,	#31
	ld	(hl), c
	inc	hl
	ld	(hl), b
	C$main.c$116$1_3$272	= .
	.globl	C$main.c$116$1_3$272
;main.c:116: flinger.gameObject.collider.sizex = FIXED(8);
	inc	hl
	ld	(hl), #0x00
	inc	hl
	ld	(hl), #0x08
	C$main.c$117$1_3$272	= .
	.globl	C$main.c$117$1_3$272
;main.c:117: flinger.gameObject.collider.sizey = FIXED(8);
	inc	hl
	ld	(hl), #0x00
	inc	hl
	ld	(hl), #0x08
	C$main.c$119$1_3$269	= .
	.globl	C$main.c$119$1_3$269
;main.c:119: while(1)
	ldhl	sp,	#62
	ld	(hl), #0xff
00125$:
	C$main.c$123$2_3$273	= .
	.globl	C$main.c$123$2_3$273
;main.c:123: uint8_t input = joypad();
	call	_joypad
	ld	c, a
	C$main.c$124$2_3$273	= .
	.globl	C$main.c$124$2_3$273
;main.c:124: if (input & J_A)
	bit	4, c
	jr	Z, 00102$
	C$main.c$126$3_3$274	= .
	.globl	C$main.c$126$3_3$274
;main.c:126: attached = FALSE;
	ldhl	sp,	#46
	ld	(hl), #0x00
	C$main.c$127$3_3$274	= .
	.globl	C$main.c$127$3_3$274
;main.c:127: flinger.dragShifts = detachedFlingerDragShifts;
	ldhl	sp,	#41
	ld	(hl), #0x06
00102$:
	C$main.c$129$2_3$273	= .
	.globl	C$main.c$129$2_3$273
;main.c:129: getInput(input, &x, &y);
	ldhl	sp,	#42
	ld	e, l
	ld	d, h
	ld	hl, #44
	add	hl, sp
	push	hl
	ld	a, c
	call	_getInput
;main.c:130: accelerateGameObject(&player.gameObject, x, y);
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#42
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ldhl	sp,	#59
	ld	(hl+), a
	ld	(hl), e
;GameObject.c:54: go->velx = add(go->velx, x);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
;fixed.c:13: return a + b;
	add	hl, bc
	ld	c, l
	ld	b, h
;GameObject.c:54: go->velx = add(go->velx, x);
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
;GameObject.c:55: go->vely = add(go->vely, y);
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;fixed.c:13: return a + b;
	ldhl	sp,	#59
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
;GameObject.c:55: go->vely = add(go->vely, y);
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	C$main.c$131$2_3$273	= .
	.globl	C$main.c$131$2_3$273
;main.c:131: applyDragToGameObject(&player.gameObject, player.dragShifts);
	ldhl	sp,	#20
	ld	a, (hl)
	ld	hl, #0
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_applyDragToGameObject
	C$main.c$132$2_3$273	= .
	.globl	C$main.c$132$2_3$273
;main.c:132: updateGameObject(&player.gameObject, &player.gameObject);
	ld	hl, #0
	add	hl, sp
	ld	c, l
	ld	b, h
	ld	hl, #0
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_updateGameObject
	C$main.c$133$2_3$273	= .
	.globl	C$main.c$133$2_3$273
;main.c:133: setRotatedSprite(0, 0, x, y);
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	xor	a, a
	ld	e, a
	call	_setRotatedSprite
	C$main.c$135$2_3$273	= .
	.globl	C$main.c$135$2_3$273
;main.c:135: if (attached)
	ldhl	sp,	#46
	ld	a, (hl)
	or	a, a
	jp	Z, 00106$
;main.c:137: x = sub(player.gameObject.posx, flinger.gameObject.posx);
	ldhl	sp,	#21
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	hl
	push	hl
;fixed.c:17: return a - b;
	ld	a, l
	sub	a, c
	ld	c, a
	ld	a, h
	sbc	a, b
	ldhl	sp,	#57
	ld	(hl), c
	inc	hl
	C$main.c$137$5_3$310	= .
	.globl	C$main.c$137$5_3$310
;main.c:137: x = sub(player.gameObject.posx, flinger.gameObject.posx);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#58
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
;main.c:138: y = sub(player.gameObject.posy, flinger.gameObject.posy);
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;fixed.c:17: return a - b;
	sub	a, c
	ld	c, a
	ld	a, h
	sbc	a, b
	ldhl	sp,	#59
	ld	(hl), c
	inc	hl
	C$main.c$138$5_3$313	= .
	.globl	C$main.c$138$5_3$313
;main.c:138: y = sub(player.gameObject.posy, flinger.gameObject.posy);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	ldhl	sp,	#60
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
	C$main.c$139$3_3$275	= .
	.globl	C$main.c$139$3_3$275
;main.c:139: x = x >> flinger.accelerationShifts;
	ldhl	sp,	#40
	ld	a, (hl)
	push	af
	ldhl	sp,	#59
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	af
	inc	a
	jr	00322$
00321$:
	sra	b
	rr	c
00322$:
	dec	a
	jr	NZ, 00321$
	ldhl	sp,	#42
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	C$main.c$140$3_3$275	= .
	.globl	C$main.c$140$3_3$275
;main.c:140: y = y >> flinger.accelerationShifts;
	ldhl	sp,	#40
	ld	a, (hl)
	push	af
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	pop	af
	inc	a
	jr	00324$
00323$:
	sra	d
	rr	e
00324$:
	dec	a
	jr	NZ, 00323$
	ldhl	sp,	#44
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;main.c:141: accelerateGameObject(&flinger.gameObject, x, y);
	ldhl	sp,	#59
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;GameObject.c:54: go->velx = add(go->velx, x);
	ldhl	sp,	#25
	ld	a, (hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
;fixed.c:13: return a + b;
	add	hl, bc
	ld	c, l
	ld	b, h
;GameObject.c:54: go->velx = add(go->velx, x);
	ldhl	sp,	#25
	ld	a, c
	ld	(hl+), a
;GameObject.c:55: go->vely = add(go->vely, y);
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;fixed.c:13: return a + b;
	ldhl	sp,	#59
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
;GameObject.c:55: go->vely = add(go->vely, y);
	ldhl	sp,	#27
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	C$main.c$141$2_3$273	= .
	.globl	C$main.c$141$2_3$273
;main.c:141: accelerateGameObject(&flinger.gameObject, x, y);
	jp	00107$
00106$:
;main.c:145: if (checkCollision(&player.gameObject.collider, &flinger.gameObject.collider))
;GameObject.c:14: return !(a->posx >= b->posx + b->sizex || a->posx + a->sizex <= b->posx || a->posy >= b->posy + b->sizey || a->posy + a->sizey <= b->posy);
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#55
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#56
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#57
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#58
	ld	(hl), a
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#57
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#55
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00325$
	bit	7, d
	jr	NZ, 00326$
	cp	a, a
	jr	00326$
00325$:
	bit	7, d
	jr	Z, 00326$
	scf
00326$:
	jp	NC, 00164$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#59
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#60
	ld	(hl), a
	ldhl	sp,#55
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#59
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#57
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00327$
	bit	7, d
	jr	NZ, 00328$
	cp	a, a
	jr	00328$
00327$:
	bit	7, d
	jr	Z, 00328$
	scf
00328$:
	jr	NC, 00164$
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#57
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#58
	ld	(hl), a
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#59
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#60
	ld	(hl), a
	ldhl	sp,	#35
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#59
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#57
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00329$
	bit	7, d
	jr	NZ, 00330$
	cp	a, a
	jr	00330$
00329$:
	bit	7, d
	jr	Z, 00330$
	scf
00330$:
	jr	NC, 00164$
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#57
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#59
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00331$
	bit	7, d
	jr	NZ, 00332$
	cp	a, a
	jr	00332$
00331$:
	bit	7, d
	jr	Z, 00332$
	scf
00332$:
	jr	NC, 00164$
	xor	a, a
	jr	00165$
00164$:
	ld	a, #0x01
00165$:
	C$main.c$145$5_3$325	= .
	.globl	C$main.c$145$5_3$325
;main.c:145: if (checkCollision(&player.gameObject.collider, &flinger.gameObject.collider))
	xor	a,#0x01
	jr	Z, 00107$
	C$main.c$147$4_3$277	= .
	.globl	C$main.c$147$4_3$277
;main.c:147: attached = TRUE;
	ldhl	sp,	#46
	ld	(hl), #0x01
	C$main.c$148$4_3$277	= .
	.globl	C$main.c$148$4_3$277
;main.c:148: flinger.dragShifts = attachedFlingerDragShifts;
	ldhl	sp,	#41
	ld	(hl), #0x04
00107$:
	C$main.c$151$2_3$273	= .
	.globl	C$main.c$151$2_3$273
;main.c:151: applyDragToGameObject(&flinger.gameObject, flinger.dragShifts);
	ldhl	sp,	#41
	ld	a, (hl)
	ld	hl, #21
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_applyDragToGameObject
	C$main.c$152$2_3$273	= .
	.globl	C$main.c$152$2_3$273
;main.c:152: updateGameObject(&flinger.gameObject, &player.gameObject);
	ld	hl, #0
	add	hl, sp
	ld	c, l
	ld	b, h
	ld	hl, #21
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_updateGameObject
;main.c:154: for (uint8_t i = 0; i < maxEnemyNumber; i++)
	ldhl	sp,	#63
	ld	(hl), #0x00
00159$:
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x08
	jp	NC, 00116$
	C$main.c$156$1_3$269	= .
	.globl	C$main.c$156$1_3$269
;main.c:156: if (activeEnemies[i])
	ld	de, #_activeEnemies
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#49
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#48
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#60
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	Z, 00160$
;main.c:158: checkCollision(&enemies[i].gameObject.collider, &player.gameObject.collider);
	ldhl	sp,	#63
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	bc,#_enemies
	add	hl,bc
	push	hl
	ld	a, l
	ldhl	sp,	#51
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#50
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#53
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#52
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
;GameObject.c:14: return !(a->posx >= b->posx + b->sizex || a->posx + a->sizex <= b->posx || a->posy >= b->posy + b->sizey || a->posy + a->sizey <= b->posy);
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#55
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#56
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#57
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#58
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#61
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#60
	ld	(hl-), a
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00333$
	bit	7, d
	jr	NZ, 00334$
	cp	a, a
	jr	00334$
00333$:
	bit	7, d
	jr	Z, 00334$
	scf
00334$:
	jr	NC, 00174$
	ldhl	sp,#53
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#61
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#60
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#55
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00335$
	bit	7, d
	jr	NZ, 00336$
	cp	a, a
	jr	00336$
00335$:
	bit	7, d
	jr	Z, 00336$
	scf
00336$:
	ld	a, #0x00
	rla
00174$:
;main.c:159: if (checkCollision(&enemies[i].gameObject.collider, &flinger.gameObject.collider))
	ldhl	sp,	#51
	ld	a, (hl+)
	ld	c, (hl)
	ldhl	sp,	#55
	ld	(hl+), a
;GameObject.c:14: return !(a->posx >= b->posx + b->sizex || a->posx + a->sizex <= b->posx || a->posy >= b->posy + b->sizey || a->posy + a->sizey <= b->posy);
	ld	a, c
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#59
	ld	(hl), a
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#60
	ld	(hl), a
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#59
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#57
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00337$
	bit	7, d
	jr	NZ, 00338$
	cp	a, a
	jr	00338$
00337$:
	bit	7, d
	jr	Z, 00338$
	scf
00338$:
	jp	NC, 00182$
	ldhl	sp,#55
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#57
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#59
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00339$
	bit	7, d
	jr	NZ, 00340$
	cp	a, a
	jr	00340$
00339$:
	bit	7, d
	jr	Z, 00340$
	scf
00340$:
	jr	NC, 00182$
	ldhl	sp,	#55
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	inc	bc
	inc	bc
	ld	e, c
	ld	d, b
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#59
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#60
	ld	(hl), a
	ldhl	sp,	#35
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#59
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#57
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00341$
	bit	7, d
	jr	NZ, 00342$
	cp	a, a
	jr	00342$
00341$:
	bit	7, d
	jr	Z, 00342$
	scf
00342$:
	jr	NC, 00182$
	ldhl	sp,#55
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#57
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#59
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00343$
	bit	7, d
	jr	NZ, 00344$
	cp	a, a
	jr	00344$
00343$:
	bit	7, d
	jr	Z, 00344$
	scf
00344$:
	jr	NC, 00182$
	ldhl	sp,	#60
	ld	(hl), #0x00
	jr	00183$
00182$:
	ldhl	sp,	#60
	ld	(hl), #0x01
00183$:
	ldhl	sp,	#60
	ld	a, (hl)
	C$main.c$159$7_3$331	= .
	.globl	C$main.c$159$7_3$331
;main.c:159: if (checkCollision(&enemies[i].gameObject.collider, &flinger.gameObject.collider))
	xor	a,#0x01
	jr	Z, 00112$
	C$main.c$161$6_3$281	= .
	.globl	C$main.c$161$6_3$281
;main.c:161: activeEnemies[i] = FALSE;
	ldhl	sp,	#47
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;main.c:162: hide_sprite(enemies[i].gameObject.firstSprite);
	ldhl	sp,#49
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
;C:/gbdk-win64/gbdk/include/gb/gb.h:1703: shadow_OAM[nb].y = 0;
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	(hl), #0x00
	C$main.c$162$5_3$280	= .
	.globl	C$main.c$162$5_3$280
;main.c:162: hide_sprite(enemies[i].gameObject.firstSprite);
	jp	00160$
00112$:
	C$main.c$166$6_3$282	= .
	.globl	C$main.c$166$6_3$282
;main.c:166: if (i == enemyUpdate || i == enemyUpdate + (maxEnemyNumber >> 1))
	ldhl	sp,	#63
	ld	a, (hl)
	ld	hl, #_enemyUpdate
	sub	a, (hl)
	jr	Z, 00108$
	ld	a, (#_enemyUpdate)
	ldhl	sp,	#59
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#59
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#58
	ld	(hl), a
	ldhl	sp,	#63
	ld	a, (hl)
	ldhl	sp,	#59
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#57
	ld	a, (hl+)
	inc	hl
	sub	a, (hl)
	jp	NZ,00109$
	dec	hl
	ld	a, (hl+)
	inc	hl
	sub	a, (hl)
	jp	NZ,00109$
00108$:
;main.c:168: x = sub(player.gameObject.posx, enemies[i].gameObject.posx);
	ldhl	sp,#49
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	pop	hl
	push	hl
;fixed.c:17: return a - b;
	ld	a, l
	sub	a, c
	ld	c, a
	ld	a, h
	sbc	a, b
	ldhl	sp,	#57
	ld	(hl), c
	inc	hl
	C$main.c$168$9_3$337	= .
	.globl	C$main.c$168$9_3$337
;main.c:168: x = sub(player.gameObject.posx, enemies[i].gameObject.posx);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#42
	ld	(hl), a
	ldhl	sp,	#58
	ld	a, (hl)
	ldhl	sp,	#43
	ld	(hl), a
;main.c:169: y = sub(player.gameObject.posy, enemies[i].gameObject.posy);
	ldhl	sp,	#49
	ld	a, (hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;fixed.c:17: return a - b;
	sub	a, c
	ld	c, a
	ld	a, h
	sbc	a, b
	ldhl	sp,	#59
	ld	(hl), c
	inc	hl
	C$main.c$169$9_3$340	= .
	.globl	C$main.c$169$9_3$340
;main.c:169: y = sub(player.gameObject.posy, enemies[i].gameObject.posy);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#44
	ld	(hl), a
	ldhl	sp,	#60
	ld	a, (hl)
	ldhl	sp,	#45
	ld	(hl), a
	C$main.c$170$7_3$283	= .
	.globl	C$main.c$170$7_3$283
;main.c:170: x = x >> enemies[i].accelerationShifts;
	ldhl	sp,#49
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0013
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	push	af
	ldhl	sp,	#59
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	af
	inc	a
	jr	00349$
00348$:
	sra	b
	rr	c
00349$:
	dec	a
	jr	NZ, 00348$
	ldhl	sp,	#42
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	C$main.c$171$7_3$283	= .
	.globl	C$main.c$171$7_3$283
;main.c:171: y = y >> enemies[i].accelerationShifts;
	ld	a, (de)
	push	af
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	pop	af
	inc	a
	jr	00351$
00350$:
	sra	d
	rr	e
00351$:
	dec	a
	jr	NZ, 00350$
	ldhl	sp,	#44
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;main.c:172: accelerateGameObject(&enemies[i].gameObject, x, y);
	ldhl	sp,	#55
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#49
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#57
	ld	(hl+), a
;GameObject.c:54: go->velx = add(go->velx, x);
	ld	a, e
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#61
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#60
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
;fixed.c:13: return a + b;
	add	hl, bc
	ld	c, l
	ld	b, h
;GameObject.c:54: go->velx = add(go->velx, x);
	ldhl	sp,	#59
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;GameObject.c:55: go->vely = add(go->vely, y);
	ldhl	sp,#57
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#59
	ld	(hl+), a
	inc	de
	ld	a, (de)
;fixed.c:13: return a + b;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#55
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
;GameObject.c:55: go->vely = add(go->vely, y);
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	C$main.c$173$7_3$283	= .
	.globl	C$main.c$173$7_3$283
;main.c:173: applyDragToGameObject(&enemies[i].gameObject, enemies[i].dragShifts);
	ldhl	sp,#49
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0014
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ldhl	sp,	#49
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, c
	call	_applyDragToGameObject
	C$main.c$174$7_3$283	= .
	.globl	C$main.c$174$7_3$283
;main.c:174: setRotatedSprite(2 + i, 4, x, y);
	ldhl	sp,	#63
	ld	c, (hl)
	inc	c
	inc	c
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#44
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	e, #0x04
	ld	a, c
	call	_setRotatedSprite
00109$:
	C$main.c$176$6_3$282	= .
	.globl	C$main.c$176$6_3$282
;main.c:176: updateGameObject(&enemies[i].gameObject, &player.gameObject);
	ldhl	sp,	#49
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0
	add	hl, sp
	ld	c, l
	ld	b, h
	call	_updateGameObject
00160$:
	C$main.c$154$3_3$278	= .
	.globl	C$main.c$154$3_3$278
;main.c:154: for (uint8_t i = 0; i < maxEnemyNumber; i++)
	ldhl	sp,	#63
	inc	(hl)
	jp	00159$
00116$:
	C$main.c$181$2_3$273	= .
	.globl	C$main.c$181$2_3$273
;main.c:181: enemyUpdate++;
	ld	hl, #_enemyUpdate
	inc	(hl)
	C$main.c$182$2_3$273	= .
	.globl	C$main.c$182$2_3$273
;main.c:182: if (enemyUpdate == 4)
	ld	a, (hl)
	sub	a, #0x04
	jr	NZ, 00118$
	C$main.c$184$3_3$284	= .
	.globl	C$main.c$184$3_3$284
;main.c:184: enemyUpdate = 0;
	ld	hl, #_enemyUpdate
	ld	(hl), #0x00
00118$:
	C$main.c$187$2_3$273	= .
	.globl	C$main.c$187$2_3$273
;main.c:187: enemyTimer--;
	ldhl	sp,	#61
	C$main.c$188$2_3$273	= .
	.globl	C$main.c$188$2_3$273
;main.c:188: if (enemyTimer == 0)
	dec	(hl)
	ld	a, (hl)
	jp	NZ, 00123$
;main.c:57: for (uint8_t i = 0; i < maxEnemyNumber; i++)
	C$main.c$190$1_3$269	= .
	.globl	C$main.c$190$1_3$269
;main.c:190: int8_t index = loadEnemy();
	ld	c, #0x00
	ld	e, c
00156$:
	ld	a, e
	sub	a, #0x08
	jr	NC, 00150$
	ld	hl, #_activeEnemies
	ld	d, #0x00
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	NZ, 00157$
	ld	(hl), #0x01
	ldhl	sp,	#63
	ld	(hl), c
	jr	00151$
00157$:
	inc	e
	ld	c, e
	jr	00156$
00150$:
	ldhl	sp,	#63
	ld	(hl), #0xff
00151$:
	C$main.c$191$3_3$285	= .
	.globl	C$main.c$191$3_3$285
;main.c:191: if (index != -1)
	ldhl	sp,	#63
	ld	a, (hl)
	inc	a
	jp	Z,00120$
	C$main.c$193$4_3$286	= .
	.globl	C$main.c$193$4_3$286
;main.c:193: enemies[index].accelerationShifts = 11;
	ldhl	sp,	#63
	ld	c, (hl)
	ld	a, c
	rlca
	sbc	a, a
	ld	b, a
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	bc,#_enemies
	add	hl,bc
	ld	c, l
	ld	b, h
	ld	hl, #0x0013
	add	hl, bc
	ld	(hl), #0x0b
	C$main.c$194$4_3$286	= .
	.globl	C$main.c$194$4_3$286
;main.c:194: enemies[index].dragShifts = 4;
	ld	hl, #0x0014
	add	hl, bc
	ld	(hl), #0x04
	C$main.c$195$4_3$286	= .
	.globl	C$main.c$195$4_3$286
;main.c:195: enemies[index].gameObject.firstSprite = 2 + index;
	ld	hl, #0x0010
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#63
	ld	a, (hl)
	inc	a
	inc	a
	ld	(de), a
	C$main.c$196$4_3$286	= .
	.globl	C$main.c$196$4_3$286
;main.c:196: enemies[index].gameObject.spriteSizex = 1;
	ld	hl, #0x0011
	add	hl, bc
	ld	(hl), #0x01
	C$main.c$197$4_3$286	= .
	.globl	C$main.c$197$4_3$286
;main.c:197: enemies[index].gameObject.spriteSizey = 1;
	ld	hl, #0x0012
	add	hl, bc
	ld	(hl), #0x01
	C$main.c$198$4_3$286	= .
	.globl	C$main.c$198$4_3$286
;main.c:198: enemies[index].gameObject.posx = player.gameObject.posx;
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#54
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#55
	ld	(hl-), a
	ld	e, c
	ld	d, b
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	C$main.c$199$4_3$286	= .
	.globl	C$main.c$199$4_3$286
;main.c:199: enemies[index].gameObject.posy = sub(player.gameObject.posy, FIXED(80));
	ld	hl, #0x0002
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#58
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#57
	ld	(hl), a
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#58
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#59
;fixed.c:17: return a - b;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x5000
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#61
	ld	(hl-), a
	ld	(hl), e
	C$main.c$199$6_3$358	= .
	.globl	C$main.c$199$6_3$358
;main.c:199: enemies[index].gameObject.posy = sub(player.gameObject.posy, FIXED(80));
	ldhl	sp,#56
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	C$main.c$200$4_3$286	= .
	.globl	C$main.c$200$4_3$286
;main.c:200: enemies[index].gameObject.velx = FIXED(0);
	ld	hl, #0x0004
	add	hl, bc
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	C$main.c$201$4_3$286	= .
	.globl	C$main.c$201$4_3$286
;main.c:201: enemies[index].gameObject.vely = FIXED(0);
	ld	hl, #0x0006
	add	hl, bc
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	C$main.c$202$4_3$286	= .
	.globl	C$main.c$202$4_3$286
;main.c:202: enemies[index].gameObject.collider.posx = enemies[index].gameObject.posx;
	ld	hl, #0x0008
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#54
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	C$main.c$203$4_3$286	= .
	.globl	C$main.c$203$4_3$286
;main.c:203: enemies[index].gameObject.collider.posy = enemies[index].gameObject.posy;
	ld	hl, #0x000a
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	C$main.c$204$4_3$286	= .
	.globl	C$main.c$204$4_3$286
;main.c:204: enemies[index].gameObject.collider.sizex = FIXED(8);
	ld	hl, #0x000c
	add	hl, bc
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x08
	C$main.c$205$4_3$286	= .
	.globl	C$main.c$205$4_3$286
;main.c:205: enemies[index].gameObject.collider.sizey = FIXED(8);
	ld	hl, #0x000e
	add	hl, bc
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x08
	C$main.c$207$4_3$286	= .
	.globl	C$main.c$207$4_3$286
;main.c:207: enemyTimer = resetEnemyTimer;
	ldhl	sp,	#62
	ld	a, (hl-)
	C$main.c$208$4_3$286	= .
	.globl	C$main.c$208$4_3$286
;main.c:208: resetEnemyTimer--;
	ld	(hl+), a
	dec	(hl)
	jr	00123$
00120$:
	C$main.c$212$4_3$287	= .
	.globl	C$main.c$212$4_3$287
;main.c:212: enemyTimer++;
	ldhl	sp,	#61
	inc	(hl)
00123$:
;main.c:216: moveBackground(&player.gameObject);
;GameObject.c:101: move_bkg(INT(player->posx), INT(player->posy));
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	b, (hl)
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	a, (hl)
	ldh	(_SCX_REG + 0), a
;C:/gbdk-win64/gbdk/include/gb/gb.h:1208: SCX_REG=x, SCY_REG=y;
	ld	a, b
	ldh	(_SCY_REG + 0), a
	C$main.c$218$2_3$273	= .
	.globl	C$main.c$218$2_3$273
;main.c:218: wait_vbl_done();
	call	_wait_vbl_done
	jp	00125$
	C$main.c$220$1_3$269	= .
	.globl	C$main.c$220$1_3$269
;main.c:220: }
	add	sp, #64
	C$main.c$220$1_3$269	= .
	.globl	C$main.c$220$1_3$269
	XG$main$0$0	= .
	.globl	XG$main$0$0
	ret
	.area _CODE
	.area _INITIALIZER
Fmain$__xinit_SpaceShipTiles$0_0$0 == .
__xinit__SpaceShipTiles:
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x66	; 102	'f'
	.db #0x24	; 36
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x4e	; 78	'N'
	.db #0x7c	; 124
	.db #0x4f	; 79	'O'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x30	; 48	'0'
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0xce	; 206
	.db #0xfe	; 254
	.db #0xce	; 206
	.db #0xfe	; 254
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x56	; 86	'V'
	.db #0x3e	; 62
	.db #0x2c	; 44
	.db #0x7e	; 126
	.db #0x52	; 82	'R'
	.db #0xed	; 237
	.db #0xad	; 173
	.db #0x7f	; 127
	.db #0x3a	; 58
	.db #0x7e	; 126
	.db #0x44	; 68	'D'
	.db #0x3a	; 58
	.db #0x10	; 16
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x66	; 102	'f'
	.db #0x7e	; 126
	.db #0xe7	; 231
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x4e	; 78	'N'
	.db #0x7c	; 124
	.db #0x4f	; 79	'O'
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x3c	; 60
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x4c	; 76	'L'
	.db #0x7c	; 124
	.db #0x4c	; 76	'L'
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x3e	; 62
	.db #0x3c	; 60
	.db #0x1e	; 30
	.db #0x00	; 0
Fmain$__xinit_SpaceTiles$0_0$0 == .
__xinit__SpaceTiles:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0xff	; 255
	.db #0xeb	; 235
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xdf	; 223
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xdf	; 223
	.db #0x57	; 87	'W'
	.db #0x8f	; 143
	.db #0xff	; 255
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
Fmain$__xinit_SpaceMap$0_0$0 == .
__xinit__SpaceMap:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
Fmain$__xinit_enemyUpdate$0_0$0 == .
__xinit__enemyUpdate:
	.db #0x00	; 0
	.area _CABS (ABS)
