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
	.globl _subBCD
	.globl _addBCD
	.globl _rotate
	.globl _sqrt
	.globl _set_sprite_data
	.globl _set_win_tile_xy
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _enemyUpdate
	.globl _SpaceshipPoints
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
_enemies::
	.ds 208
_activeEnemies::
	.ds 8
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_SpaceShipTiles::
	.ds 2048
_SpaceTiles::
	.ds 2048
_SpaceMap::
	.ds 1024
_SpaceshipPoints::
	.ds 1
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
;fixed.c:69: while (abs(sub(x, div(n, x))) > tol) {
00101$:
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
;fixed.c:71: x = div(add(x, div(n, x)), FIXED(2));
	jp	00101$
00103$:
;fixed.c:75: return x;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;fixed.c:76: }
	add	sp, #10
	ret
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
;fixed.c:105: fixed16 current_angle = FIXED(0);
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), a
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
;fixed.c:108: for (int8_t i = 0; i < 11; i++) {
	ldhl	sp,	#18
	ld	a, (hl)
	xor	a, #0x80
	sub	a, #0x8b
	jp	NC, 00101$
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
;fixed.c:121: *x = x_new;
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	(de), a
	inc	de
;fixed.c:122: *y = y_new;
	ld	a, (hl+)
	ld	(de), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
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
;fixed.c:125: current_angle = add(current_angle, sign * pre_angle);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
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
;fixed.c:131: }
	add	sp, #19
	pop	hl
	pop	af
	jp	(hl)
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
;fixed.c:133: void addBCD(uint8_t arr1[], uint8_t arr2[], uint8_t size)
;	---------------------------------
; Function addBCD
; ---------------------------------
_addBCD::
	add	sp, #-9
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;fixed.c:135: BOOLEAN carry = FALSE;
	ldhl	sp,	#0
	ld	(hl), #0x00
;fixed.c:136: for (int8_t i = size - 1; i >= 0; i--)
	ldhl	sp,	#11
	ld	a, (hl)
	dec	a
	ldhl	sp,	#8
	ld	(hl), a
00106$:
	ldhl	sp,	#8
	ld	a, (hl)
	bit	7, a
	jr	NZ, 00108$
;fixed.c:138: arr1[i] += arr2[i] + (carry ? 1 : 0);
	ld	a, (hl-)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#3
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#2
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00110$
	ld	a, #0x01
	ld	b, #0x00
	jr	00111$
00110$:
	xor	a, a
	ld	b, a
00111$:
	add	a, c
	ldhl	sp,	#3
	ld	c, (hl)
	dec	hl
	add	a, c
	ld	c, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
;fixed.c:139: if (arr1[i] >= 0x0A)
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	cp	a, #0x0a
	jr	C, 00102$
;fixed.c:141: arr1[i] -= 0x0A;
	add	a, #0xf6
	ld	c, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
;fixed.c:142: carry = TRUE;
	ldhl	sp,	#0
	ld	(hl), #0x01
	jr	00107$
00102$:
;fixed.c:146: carry = FALSE;
	ldhl	sp,	#0
	ld	(hl), #0x00
00107$:
;fixed.c:136: for (int8_t i = size - 1; i >= 0; i--)
	ldhl	sp,	#8
	dec	(hl)
	jr	00106$
00108$:
;fixed.c:149: }
	add	sp, #9
	pop	hl
	inc	sp
	jp	(hl)
;fixed.c:151: void subBCD(uint8_t arr1[], uint8_t arr2[], uint8_t size)
;	---------------------------------
; Function subBCD
; ---------------------------------
_subBCD::
	add	sp, #-9
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;fixed.c:153: BOOLEAN borrow = FALSE;
	ldhl	sp,	#0
	ld	(hl), #0x00
;fixed.c:154: for (int8_t i = size - 1; i >= 0; i--)
	ldhl	sp,	#11
	ld	a, (hl)
	dec	a
	ldhl	sp,	#8
	ld	(hl), a
00106$:
	ldhl	sp,	#8
	ld	a, (hl)
	bit	7, a
	jr	NZ, 00108$
;fixed.c:156: arr1[i] -= arr2[i] + (borrow ? 1 : 0);
	ld	a, (hl-)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#3
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#2
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00110$
	ld	a, #0x01
	ld	b, #0x00
	jr	00111$
00110$:
	xor	a, a
	ld	b, a
00111$:
	add	a, c
	ld	c, a
	ldhl	sp,	#3
	ld	a, (hl-)
	sub	a, c
	ld	c, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
;fixed.c:157: if (arr1[i] >= 0x0A)
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	cp	a, #0x0a
	jr	C, 00102$
;fixed.c:159: arr1[i] += 0x0A;
	inc	hl
	ld	(hl), a
	add	a, #0x0a
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	ld	(de), a
;fixed.c:160: borrow = TRUE;
	ldhl	sp,	#0
	ld	(hl), #0x01
	jr	00107$
00102$:
;fixed.c:164: borrow = FALSE;
	ldhl	sp,	#0
	ld	(hl), #0x00
00107$:
;fixed.c:154: for (int8_t i = size - 1; i >= 0; i--)
	ldhl	sp,	#8
	dec	(hl)
	jr	00106$
00108$:
;fixed.c:167: }
	add	sp, #9
	pop	hl
	inc	sp
	jp	(hl)
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
;GameObject.c:33: go->posx = add(go->posx, go->velx);
	ldhl	sp,	#18
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
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
;GameObject.c:34: go->collider.posx = add(go->collider.posx, go->velx);
	ldhl	sp,	#14
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
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
;GameObject.c:35: go->posy = add(go->posy, go->vely);
	pop	hl
	push	hl
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
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
;GameObject.c:36: go->collider.posy = add(go->collider.posy, go->vely);
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
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
;GameObject.c:41: return;
	jp	00118$
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
;GameObject.c:45: for (int x = 0; x < go->spriteSizex; x++)
	ldhl	sp,	#20
	inc	(hl)
	jp	NZ,00113$
	inc	hl
	inc	(hl)
	jp	00113$
00117$:
;GameObject.c:43: for (int y = 0; y < go->spriteSizey; y++)
	inc	bc
	jp	00116$
00118$:
;GameObject.c:50: }
	add	sp, #22
	ret
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
;GameObject.c:63: go->velx = sub(go->velx, shiftedx != 0 ? shiftedx : 1);
	pop	hl
	push	hl
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00102$:
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
;GameObject.c:68: go->vely = sub(go->vely, shiftedy != 0 ? shiftedy : 1);
	pop	hl
	push	hl
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00107$:
;GameObject.c:70: }
	add	sp, #5
	ret
;GameObject.c:72: void setRotatedSprite(int8_t sprite, int8_t tile, fixed16 x, fixed16 y)
;	---------------------------------
; Function setRotatedSprite
; ---------------------------------
_setRotatedSprite::
	add	sp, #-15
	ldhl	sp,	#14
	ld	(hl-), a
	ld	(hl), e
;GameObject.c:74: if (x == FIXED(0) && y == FIXED(0))
	ldhl	sp,	#18
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00102$
	ldhl	sp,	#20
	ld	a, (hl-)
	or	a, (hl)
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
;GameObject.c:95: set_sprite_prop(sprite, (x > 0 ? S_FLIPX : 0) | (y > 0 ? S_FLIPY : 0));
00132$:
;GameObject.c:97: }
	add	sp, #15
	pop	hl
	add	sp, #4
	jp	(hl)
;main.c:50: void getInput(uint8_t input, fixed16* x, fixed16* y)
;	---------------------------------
; Function getInput
; ---------------------------------
_getInput::
	add	sp, #-8
	ld	c, a
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
;main.c:52: *x = FIXED(0);
	ld	a, d
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;main.c:53: *y = FIXED(0);
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
;main.c:55: if (input & J_UP)
	bit	2, c
	jr	Z, 00102$
;main.c:57: *y = -inputSpeed;
	pop	hl
	push	hl
	ld	a, #0xb4
	ld	(hl+), a
	ld	(hl), #0xff
00102$:
;main.c:59: if (input & J_DOWN)
	bit	3, c
	jr	Z, 00104$
;main.c:61: *y = inputSpeed;
	pop	hl
	push	hl
	ld	a, #0x4c
	ld	(hl+), a
	ld	(hl), #0x00
00104$:
;main.c:63: if (input & J_LEFT)
	bit	1, c
	jr	Z, 00106$
;main.c:65: *x = -inputSpeed;
	ldhl	sp,	#6
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0xb4
	ld	(hl+), a
	ld	(hl), #0xff
00106$:
;main.c:67: if (input & J_RIGHT)
	bit	0, c
	jr	Z, 00108$
;main.c:69: *x = inputSpeed;
	ldhl	sp,	#6
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x4c
	ld	(hl+), a
	ld	(hl), #0x00
00108$:
;main.c:72: if (*x != 0 && *y != 0)
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
;main.c:74: *x = *x > 0 ? inputSpeedDiagonal : -inputSpeedDiagonal;
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
;main.c:75: *y = *y > 0 ? inputSpeedDiagonal : -inputSpeedDiagonal;
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
;main.c:77: }
	add	sp, #8
	pop	hl
	pop	af
	jp	(hl)
;main.c:147: void main()
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-128
	dec	sp
;main.c:150: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:151: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:152: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;C:/gbdk-win64/gbdk/include/gb/gb.h:1468: WX_REG=x, WY_REG=y;
	xor	a, a
	ldh	(_WX_REG + 0), a
	ld	a, #0x88
	ldh	(_WY_REG + 0), a
;main.c:156: uint8_t score[6] = {0, 0, 0, 0, 0, 0};
	ldhl	sp,	#0
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
;main.c:157: uint8_t lives[2] = {0, 3};
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x03
;main.c:159: uint8_t enemyTimer = 1;
	ldhl	sp,	#127
	ld	(hl), #0x01
;main.c:162: OBP0_REG = 0x1B;
	ld	a, #0x1b
	ldh	(_OBP0_REG + 0), a
;main.c:164: set_sprite_data(0, 128, SpaceShipTiles);
	ld	de, #_SpaceShipTiles
	push	de
	ld	hl, #0x8000
	push	hl
	call	_set_sprite_data
	add	sp, #4
;C:/gbdk-win64/gbdk/include/gb/gb.h:1602: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x03
;main.c:170: set_bkg_data(0, 128, SpaceTiles);
	ld	de, #_SpaceTiles
	push	de
	ld	hl, #0x8000
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:172: set_bkg_tiles(0, 0, 32, 32, SpaceMap);
	ld	de, #_SpaceMap
	push	de
	ld	hl, #0x2020
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;main.c:175: player.gameObject.posx = FIXED(0);
	xor	a, a
	ldhl	sp,	#8
	ld	(hl+), a
;main.c:176: player.gameObject.posy = FIXED(0);
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
;main.c:177: player.gameObject.velx = FIXED(0);
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
;main.c:178: player.gameObject.vely = FIXED(0);
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;main.c:179: player.gameObject.firstSprite = 0;
	ldhl	sp,	#24
;main.c:180: player.gameObject.spriteSizex = 1;
	xor	a, a
	ld	(hl+), a
;main.c:181: player.gameObject.spriteSizey = 1;
;main.c:182: player.accelerationShifts = 0;
	ld	a,#0x01
	ld	(hl+),a
	ld	(hl+), a
;main.c:183: player.dragShifts = 5;
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x05
;main.c:184: player.gameObject.collider.posx = add(player.gameObject.posx, FIXED(2));
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	c, a
;	spillPairReg hl
;	spillPairReg hl
;fixed.c:13: return a + b;
	ld	a, (hl)
	add	a, #0x02
	ld	b, a
;main.c:184: player.gameObject.collider.posx = add(player.gameObject.posx, FIXED(2));
	ldhl	sp,	#16
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:185: player.gameObject.collider.posy = add(player.gameObject.posy, FIXED(2));
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	c, a
;	spillPairReg hl
;	spillPairReg hl
;fixed.c:13: return a + b;
	ld	a, (hl)
	add	a, #0x02
	ld	b, a
;main.c:185: player.gameObject.collider.posy = add(player.gameObject.posy, FIXED(2));
	ldhl	sp,	#18
	ld	a, c
	ld	(hl+), a
;main.c:186: player.gameObject.collider.sizex = FIXED(4);
	ld	a, b
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
;main.c:187: player.gameObject.collider.sizey = FIXED(4);
	ld	a, #0x04
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x04
;main.c:188: player.deathTimer = 0;
	ldhl	sp,	#29
;main.c:189: player.invincibilityTimer = invincibilityFrames;
	xor	a, a
	ld	(hl+), a
;main.c:193: flinger.gameObject.posx = FIXED(0);
	ld	a, #0x78
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
;main.c:194: flinger.gameObject.posy = FIXED(0);
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
;main.c:195: flinger.gameObject.velx = FIXED(0);
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
;main.c:196: flinger.gameObject.vely = FIXED(0);
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;main.c:197: flinger.gameObject.firstSprite = 1;
	ldhl	sp,	#47
;main.c:198: flinger.gameObject.spriteSizex = 1;
;main.c:199: flinger.gameObject.spriteSizey = 1;
	ld	a,#0x01
	ld	(hl+),a
	ld	(hl+), a
;main.c:200: flinger.accelerationShifts = 6;
	ld	a, #0x01
	ld	(hl+), a
;main.c:201: flinger.dragShifts = attachedFlingerDragShifts;
	ld	a, #0x06
	ld	(hl+), a
	ld	(hl), #0x04
;main.c:202: flinger.gameObject.collider.posx = flinger.gameObject.posx;
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#39
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:203: flinger.gameObject.collider.posy = flinger.gameObject.posy;
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#41
	ld	a, c
	ld	(hl+), a
;main.c:204: flinger.gameObject.collider.sizex = FIXED(8);
	ld	a, b
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
;main.c:205: flinger.gameObject.collider.sizey = FIXED(8);
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x08
;main.c:206: flinger.attached = TRUE;
	ldhl	sp,	#52
	ld	(hl), #0x01
;main.c:208: while(1)
00156$:
;main.c:212: if (player.deathTimer == 0)
	ldhl	sp,	#29
	ld	c, (hl)
	ld	a, c
	or	a, a
	jr	NZ, 00108$
;main.c:214: uint8_t input = joypad();
	call	_joypad
	ld	c, a
;main.c:215: if (input & J_A)
	bit	4, c
	jr	Z, 00102$
;main.c:217: flinger.attached = FALSE;
	ldhl	sp,	#52
;main.c:218: flinger.dragShifts = detachedFlingerDragShifts;
	xor	a, a
	ld	(hl-), a
	ld	(hl), #0x06
00102$:
;main.c:220: getInput(input, &x, &y);
	ldhl	sp,	#123
	ld	e, l
	ld	d, h
	ld	hl, #125
	add	hl, sp
	push	hl
	ld	a, c
	call	_getInput
;main.c:221: accelerateGameObject(&player.gameObject, x, y);
	ldhl	sp,	#125
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#123
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ldhl	sp,	#121
	ld	(hl+), a
	ld	(hl), e
;GameObject.c:54: go->velx = add(go->velx, x);
	ldhl	sp,	#12
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
	ldhl	sp,	#12
	ld	a, c
	ld	(hl+), a
;GameObject.c:55: go->vely = add(go->vely, y);
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;fixed.c:13: return a + b;
	ldhl	sp,	#121
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
;GameObject.c:55: go->vely = add(go->vely, y);
	ldhl	sp,	#14
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:222: setRotatedSprite(0, 0, x, y);
	ldhl	sp,	#125
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#125
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	xor	a, a
	ld	e, a
	call	_setRotatedSprite
	jr	00109$
00108$:
;main.c:226: if (player.deathTimer > playerDeathHaltFrames)
	ld	a, #0x78
	sub	a, c
	jr	NC, 00104$
;main.c:229: (explosionAnimationFrames - ((player.deathTimer - playerDeathHaltFrames) >> 2)) + explosionOffset);
	ld	b, #0x00
	ld	a, c
	add	a, #0x88
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	sra	b
	rr	c
	sra	b
	rr	c
	ld	a, #0x0c
	sub	a, c
	ld	c, a
;main.c:228: set_sprite_tile(player.gameObject.firstSprite,
	ld	hl, #24
	add	hl, sp
	ld	e, l
	ld	d, h
	ld	a, (de)
;C:/gbdk-win64/gbdk/include/gb/gb.h:1602: shadow_OAM[nb].tile=tile;
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
	inc	hl
	inc	hl
	ld	(hl), c
;main.c:230: applyDragToGameObject(&player.gameObject, player.dragShifts);
	ldhl	sp,	#28
	ld	a, (hl)
	ld	hl, #8
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_applyDragToGameObject
00104$:
;main.c:232: player.deathTimer--;
	ldhl	sp,	#29
;main.c:233: if (!player.deathTimer)
	dec	(hl)
	ld	a, (hl)
	jr	NZ, 00109$
;main.c:235: uint8_t subLives[] = {0, 1};
	ldhl	sp,	#107
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	ldhl	sp,	#108
	ld	(hl), #0x01
;main.c:236: subBCD(lives, subLives, 2);
	ld	a, #0x02
	push	af
	inc	sp
	ld	hl, #7
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_subBCD
;main.c:237: player.invincibilityTimer = invincibilityFrames;
	ldhl	sp,	#30
	ld	(hl), #0x78
00109$:
;main.c:240: applyDragToGameObject(&player.gameObject, player.dragShifts);
	ldhl	sp,	#28
	ld	a, (hl)
	ld	hl, #8
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_applyDragToGameObject
;main.c:242: if (flinger.attached)
	ldhl	sp,	#52
	ld	a, (hl)
	ld	hl, #128
	add	hl, sp
	ld	(hl), a
;main.c:250: if (flinger.gameObject.velx == 0 && flinger.gameObject.vely == 0)
;main.c:242: if (flinger.attached)
	ld	a, (hl)
	or	a, a
	jp	Z, 00118$
;main.c:244: x = sub(player.gameObject.posx, flinger.gameObject.posx);
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#117
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#118
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#119
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#120
;fixed.c:17: return a - b;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#117
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#122
	ld	(hl-), a
	ld	(hl), e
;main.c:244: x = sub(player.gameObject.posx, flinger.gameObject.posx);
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
;main.c:245: y = sub(player.gameObject.posy, flinger.gameObject.posy);
	ldhl	sp,	#33
	ld	a, (hl)
	ldhl	sp,	#115
	ld	(hl), a
	ldhl	sp,	#34
	ld	a, (hl)
	ldhl	sp,	#116
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#117
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#118
;fixed.c:17: return a - b;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#115
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#120
	ld	(hl-), a
	ld	(hl), e
;main.c:245: y = sub(player.gameObject.posy, flinger.gameObject.posy);
	ld	a, (hl)
	ldhl	sp,	#125
	ld	(hl), a
	ldhl	sp,	#120
	ld	a, (hl)
	ldhl	sp,	#126
	ld	(hl), a
;fixed.c:30: if (a >= 0)
	ldhl	sp,	#121
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#122
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	bit	7, (hl)
	jr	NZ, 00170$
;fixed.c:32: return a;
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#116
	ld	(hl), a
	ldhl	sp,	#122
	ld	a, (hl)
	ldhl	sp,	#117
	ld	(hl), a
	jr	00172$
00170$:
;fixed.c:36: return -a;
	ld	de, #0x0000
	ldhl	sp,	#121
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#120
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl)
	ldhl	sp,	#116
	ld	(hl), a
	ldhl	sp,	#120
	ld	a, (hl)
	ldhl	sp,	#117
	ld	(hl), a
;main.c:246: if (abs(x) + abs(y) < flingerDistance)
00172$:
	ldhl	sp,	#125
	ld	a, (hl)
	ldhl	sp,	#118
	ld	(hl), a
	ldhl	sp,	#126
	ld	a, (hl)
	ldhl	sp,	#119
;fixed.c:30: if (a >= 0)
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#121
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#122
	ld	(hl), a
	bit	7, (hl)
	jr	NZ, 00174$
;fixed.c:32: return a;
	ldhl	sp,	#118
	ld	a, (hl)
	ldhl	sp,	#121
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#122
	ld	(hl), a
	jr	00176$
00174$:
;fixed.c:36: return -a;
	ld	de, #0x0000
	ldhl	sp,	#118
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#122
	ld	(hl-), a
	ld	(hl), e
;main.c:246: if (abs(x) + abs(y) < flingerDistance)
00176$:
	ldhl	sp,#116
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#121
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	a, h
	xor	a, #0x80
	sub	a, #0x8d
	jr	NC, 00114$
;main.c:248: x = -x;
	ld	de, #0x0000
	ldhl	sp,	#123
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#124
	ld	(hl-), a
;main.c:249: y = -y;
	ld	a, e
	ld	(hl+), a
	inc	hl
	ld	de, #0x0000
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#126
	ld	(hl-), a
	ld	(hl), e
;main.c:250: if (flinger.gameObject.velx == 0 && flinger.gameObject.vely == 0)
	ldhl	sp,	#35
	ld	a, (hl+)
	or	a,(hl)
	jr	NZ, 00114$
	inc	hl
	ld	a, (hl+)
	or	a,(hl)
	jr	NZ, 00114$
;main.c:252: flinger.gameObject.velx = FIXED(.1);
	ldhl	sp,	#35
	ld	a, #0x19
	ld	(hl+), a
	xor	a, a
;main.c:253: flinger.gameObject.vely = FIXED(.1);
	ld	(hl+), a
	ld	a, #0x19
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00114$:
;main.c:256: x = x >> flinger.accelerationShifts;
	ldhl	sp,	#50
	ld	a, (hl)
	inc	a
	jr	00508$
00507$:
	ldhl	sp,	#124
	sra	(hl)
	dec	hl
	rr	(hl)
00508$:
	dec	a
	jr	NZ, 00507$
;main.c:257: y = y >> flinger.accelerationShifts;
	ldhl	sp,	#50
	ld	a, (hl)
	inc	a
	jr	00510$
00509$:
	ldhl	sp,	#126
	sra	(hl)
	dec	hl
	rr	(hl)
00510$:
	dec	a
	jr	NZ, 00509$
;main.c:258: accelerateGameObject(&flinger.gameObject, x, y);
	ldhl	sp,	#125
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#123
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ldhl	sp,	#121
	ld	(hl+), a
	ld	(hl), e
;GameObject.c:54: go->velx = add(go->velx, x);
	ldhl	sp,	#35
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
	ldhl	sp,	#35
	ld	a, c
	ld	(hl+), a
;GameObject.c:55: go->vely = add(go->vely, y);
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;fixed.c:13: return a + b;
	ldhl	sp,	#121
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
;GameObject.c:55: go->vely = add(go->vely, y);
	ldhl	sp,	#37
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:258: accelerateGameObject(&flinger.gameObject, x, y);
	jp	00119$
00118$:
;main.c:262: if (checkCollision(&player.gameObject.collider, &flinger.gameObject.collider))
;GameObject.c:14: return (abs(sub(a->posx, b->posx)) < add(a->sizex, b->sizex) >> 1 && abs(sub(a->posy, b->posy)) < add(a->sizey, b->sizey) >> 1);
	ldhl	sp,	#39
	ld	a, (hl)
	ldhl	sp,	#119
	ld	(hl), a
	ldhl	sp,	#40
	ld	a, (hl)
	ldhl	sp,	#120
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#121
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#122
;fixed.c:17: return a - b;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#119
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	c, e
	ld	b, a
;fixed.c:30: if (a >= 0)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, h
	jr	NZ, 00182$
;fixed.c:32: return a;
	ldhl	sp,	#115
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00184$
00182$:
;fixed.c:36: return -a;
	xor	a, a
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
	ldhl	sp,	#115
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;GameObject.c:14: return (abs(sub(a->posx, b->posx)) < add(a->sizex, b->sizex) >> 1 && abs(sub(a->posy, b->posy)) < add(a->sizey, b->sizey) >> 1);
00184$:
	ldhl	sp,	#43
	ld	a, (hl)
	ldhl	sp,	#117
	ld	(hl), a
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#118
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#119
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#120
;fixed.c:13: return a + b;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#117
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#123
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#122
	ld	(hl), a
;GameObject.c:14: return (abs(sub(a->posx, b->posx)) < add(a->sizex, b->sizex) >> 1 && abs(sub(a->posy, b->posy)) < add(a->sizey, b->sizey) >> 1);
	sra	(hl)
	dec	hl
	rr	(hl)
	ldhl	sp,	#115
	ld	e, l
	ld	d, h
	ldhl	sp,	#121
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00511$
	bit	7, d
	jr	NZ, 00512$
	cp	a, a
	jr	00512$
00511$:
	bit	7, d
	jr	Z, 00512$
	scf
00512$:
	jr	NC, 00260$
	ldhl	sp,	#41
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#18
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
	ldhl	sp,	#118
	ld	(hl), c
	inc	hl
;fixed.c:30: if (a >= 0)
	ld	(hl-), a
	ld	a, (hl+)
	bit	7, (hl)
	jr	NZ, 00188$
;fixed.c:32: return a;
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#121
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#122
	ld	(hl), a
	jr	00190$
00188$:
;fixed.c:36: return -a;
	ld	de, #0x0000
	ldhl	sp,	#118
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#122
	ld	(hl-), a
	ld	(hl), e
;GameObject.c:14: return (abs(sub(a->posx, b->posx)) < add(a->sizex, b->sizex) >> 1 && abs(sub(a->posy, b->posy)) < add(a->sizey, b->sizey) >> 1);
00190$:
	ldhl	sp,	#45
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#22
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
;GameObject.c:14: return (abs(sub(a->posx, b->posx)) < add(a->sizex, b->sizex) >> 1 && abs(sub(a->posy, b->posy)) < add(a->sizey, b->sizey) >> 1);
	sra	b
	rr	c
	ldhl	sp,	#121
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00513$
	bit	7, d
	jr	NZ, 00514$
	cp	a, a
	jr	00514$
00513$:
	bit	7, d
	jr	Z, 00514$
	scf
00514$:
	jr	C, 00261$
00260$:
	xor	a, a
	jr	00262$
00261$:
	ld	a, #0x01
00262$:
;main.c:262: if (checkCollision(&player.gameObject.collider, &flinger.gameObject.collider))
	or	a, a
	jr	Z, 00119$
;main.c:264: flinger.attached = TRUE;
	ldhl	sp,	#52
;main.c:265: flinger.dragShifts = attachedFlingerDragShifts;
	ld	a, #0x01
	ld	(hl-), a
	ld	(hl), #0x04
00119$:
;main.c:268: applyDragToGameObject(&flinger.gameObject, flinger.dragShifts);
	ldhl	sp,	#51
	ld	a, (hl)
	ld	hl, #31
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_applyDragToGameObject
;main.c:269: updateGameObject(&flinger.gameObject, &player.gameObject);
	ld	hl, #8
	add	hl, sp
	ld	c, l
	ld	b, h
	ld	hl, #31
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_updateGameObject
;main.c:271: for (uint8_t i = 0; i < maxEnemyNumber; i++)
	ld	hl, #128
	add	hl, sp
	ld	(hl), #0x00
00250$:
	ld	hl, #128
	add	hl, sp
	ld	a, (hl)
	sub	a, #0x08
	jp	NC, 00147$
;main.c:273: if (activeEnemies[i])
	ld	de, #_activeEnemies
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#122
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#121
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	Z, 00251$
;main.c:275: if (enemies[i].deathTimer == 0)
	ld	hl, #128
	add	hl, sp
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	bc,#_enemies
	add	hl,bc
	push	hl
	ld	a, l
	ldhl	sp,	#111
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#110
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0015
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#113
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#112
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#122
	ld	(hl), a
;main.c:282: enemies[i].points = SpaceshipPoints[enemies[i].type] + (flinger.attached ? 0 : 1);
	ldhl	sp,#109
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0017
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#115
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#114
	ld	(hl), a
;main.c:283: set_sprite_prop(enemies[i].gameObject.firstSprite, 0);
	ldhl	sp,#109
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#117
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#116
	ld	(hl), a
;main.c:275: if (enemies[i].deathTimer == 0)
	ldhl	sp,	#122
	ld	a, (hl)
	or	a, a
	jp	NZ, 00136$
;main.c:277: if (checkCollision(&enemies[i].gameObject.collider, &flinger.gameObject.collider))
	ldhl	sp,#109
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#123
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#122
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#117
	ld	(hl), a
	ldhl	sp,	#122
	ld	a, (hl)
	ldhl	sp,	#118
	ld	(hl), a
;GameObject.c:14: return (abs(sub(a->posx, b->posx)) < add(a->sizex, b->sizex) >> 1 && abs(sub(a->posy, b->posy)) < add(a->sizey, b->sizey) >> 1);
	ldhl	sp,	#39
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,#121
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
;fixed.c:17: return a - b;
	ld	a, l
	sub	a, c
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	sbc	a, b
	ld	c, l
	ld	b, a
;fixed.c:30: if (a >= 0)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, h
;fixed.c:32: return a;
	jr	Z, 00197$
;fixed.c:36: return -a;
	xor	a, a
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
;GameObject.c:14: return (abs(sub(a->posx, b->posx)) < add(a->sizex, b->sizex) >> 1 && abs(sub(a->posy, b->posy)) < add(a->sizey, b->sizey) >> 1);
00197$:
	ldhl	sp,	#43
	ld	a, (hl)
	ldhl	sp,	#119
	ld	(hl), a
	ldhl	sp,	#44
	ld	a, (hl)
	ldhl	sp,	#120
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#123
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#122
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
;fixed.c:13: return a + b;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#119
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
;GameObject.c:14: return (abs(sub(a->posx, b->posx)) < add(a->sizex, b->sizex) >> 1 && abs(sub(a->posy, b->posy)) < add(a->sizey, b->sizey) >> 1);
	sra	h
	rr	l
	ld	e, h
	ld	d, b
	ld	a, c
	sub	a, l
	ld	a, b
	sbc	a, h
	bit	7, e
	jr	Z, 00515$
	bit	7, d
	jr	NZ, 00516$
	cp	a, a
	jr	00516$
00515$:
	bit	7, d
	jr	Z, 00516$
	scf
00516$:
	jr	NC, 00263$
	ldhl	sp,	#41
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#117
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
	ld	l, (hl)
;	spillPairReg hl
;fixed.c:17: return a - b;
	sub	a, c
	ld	c, a
	ld	a, l
	sbc	a, b
	ld	b, a
;fixed.c:30: if (a >= 0)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, h
	jr	NZ, 00201$
;fixed.c:32: return a;
	ldhl	sp,	#119
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00203$
00201$:
;fixed.c:36: return -a;
	xor	a, a
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
	ldhl	sp,	#119
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;GameObject.c:14: return (abs(sub(a->posx, b->posx)) < add(a->sizex, b->sizex) >> 1 && abs(sub(a->posy, b->posy)) < add(a->sizey, b->sizey) >> 1);
00203$:
	ldhl	sp,	#45
	ld	a, (hl)
	ldhl	sp,	#121
	ld	(hl), a
	ldhl	sp,	#46
	ld	a, (hl)
	ldhl	sp,	#122
	ld	(hl), a
	ldhl	sp,#117
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;fixed.c:13: return a + b;
	ldhl	sp,	#121
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
;GameObject.c:14: return (abs(sub(a->posx, b->posx)) < add(a->sizex, b->sizex) >> 1 && abs(sub(a->posy, b->posy)) < add(a->sizey, b->sizey) >> 1);
	sra	b
	rr	c
	ldhl	sp,	#119
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00517$
	bit	7, d
	jr	NZ, 00518$
	cp	a, a
	jr	00518$
00517$:
	bit	7, d
	jr	Z, 00518$
	scf
00518$:
	jr	C, 00264$
00263$:
	xor	a, a
	jr	00265$
00264$:
	ld	a, #0x01
00265$:
;main.c:277: if (checkCollision(&enemies[i].gameObject.collider, &flinger.gameObject.collider))
	or	a, a
	jp	Z, 00124$
;main.c:279: enemies[i].deathTimer = totalAnimationFrames;
	ldhl	sp,	#111
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x32
;main.c:280: enemies[i].gameObject.spriteSizex = 1;
	ldhl	sp,#109
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	ld	(hl), #0x01
;main.c:281: enemies[i].gameObject.spriteSizey = 1;
	ldhl	sp,#109
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0012
	add	hl, de
	ld	(hl), #0x01
;main.c:282: enemies[i].points = SpaceshipPoints[enemies[i].type] + (flinger.attached ? 0 : 1);
	ldhl	sp,#109
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0016
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ld	hl, #_SpaceshipPoints
	ld	b, #0x00
	add	hl, bc
	ld	c, (hl)
	ldhl	sp,	#52
	ld	a, (hl)
	or	a, a
	jr	Z, 00266$
	xor	a, a
	jr	00267$
00266$:
	ld	a, #0x01
00267$:
	add	a, c
	ld	c, a
	ldhl	sp,	#113
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;main.c:283: set_sprite_prop(enemies[i].gameObject.firstSprite, 0);
	ldhl	sp,#115
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;C:/gbdk-win64/gbdk/include/gb/gb.h:1648: shadow_OAM[nb].prop=prop;
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
	inc	hl
	ld	(hl), #0x00
;main.c:284: set_sprite_tile(enemies[i].gameObject.firstSprite, explosionOffset);
	ldhl	sp,#115
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
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
	ld	(hl), #0x07
;main.c:285: enemies[i].gameObject.velx = flinger.gameObject.velx;
	ldhl	sp,#109
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#123
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#122
	ld	(hl), a
	ldhl	sp,	#35
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#121
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:286: enemies[i].gameObject.vely = flinger.gameObject.vely;
	ldhl	sp,#109
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#123
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#122
	ld	(hl), a
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#121
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:287: updateGameObject(&enemies[i].gameObject, &player.gameObject);
	ldhl	sp,	#109
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #8
	add	hl, sp
	ld	c, l
	ld	b, h
	call	_updateGameObject
	jp	00137$
00124$:
;main.c:291: if (i == enemyUpdate || i == enemyUpdate + (maxEnemyNumber >> 1))
	ld	hl, #128
	add	hl, sp
	ld	a, (hl)
	ld	hl, #_enemyUpdate
	sub	a, (hl)
	jr	Z, 00120$
	ld	hl, #_enemyUpdate
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ld	hl, #128
	add	hl, sp
	ld	e, (hl)
	ld	d, #0x00
	ld	a, e
	sub	a, c
	jp	NZ,00121$
	ld	a, d
	sub	a, b
	jp	NZ,00121$
00120$:
;main.c:293: x = sub(player.gameObject.posx, enemies[i].gameObject.posx);
	ldhl	sp,#109
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#8
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
	ldhl	sp,	#119
	ld	(hl), c
	inc	hl
;main.c:293: x = sub(player.gameObject.posx, enemies[i].gameObject.posx);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#123
	ld	(hl), a
	ldhl	sp,	#120
	ld	a, (hl)
	ldhl	sp,	#124
	ld	(hl), a
;main.c:294: y = sub(player.gameObject.posy, enemies[i].gameObject.posy);
	ldhl	sp,	#109
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
	ldhl	sp,	#10
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
	ldhl	sp,	#121
	ld	(hl), c
	inc	hl
;main.c:294: y = sub(player.gameObject.posy, enemies[i].gameObject.posy);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#125
	ld	(hl), a
	ldhl	sp,	#122
	ld	a, (hl)
	ldhl	sp,	#126
	ld	(hl), a
;main.c:295: x = x >> enemies[i].accelerationShifts;
	ldhl	sp,#109
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0013
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	push	af
	ldhl	sp,	#121
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	af
	inc	a
	jr	00523$
00522$:
	sra	b
	rr	c
00523$:
	dec	a
	jr	NZ, 00522$
	ldhl	sp,	#123
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:296: y = y >> enemies[i].accelerationShifts;
	ld	a, (de)
	push	af
	ldhl	sp,	#123
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	pop	af
	inc	a
	jr	00525$
00524$:
	sra	d
	rr	e
00525$:
	dec	a
	jr	NZ, 00524$
	ldhl	sp,	#125
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;main.c:297: accelerateGameObject(&enemies[i].gameObject, x, y);
	ldhl	sp,	#117
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#109
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#119
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
	ldhl	sp,	#123
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#122
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
	ldhl	sp,	#121
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;GameObject.c:55: go->vely = add(go->vely, y);
	ldhl	sp,#119
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
	ldhl	sp,	#121
	ld	(hl+), a
	inc	de
	ld	a, (de)
;fixed.c:13: return a + b;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#117
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
;main.c:298: applyDragToGameObject(&enemies[i].gameObject, enemies[i].dragShifts);
	ldhl	sp,#109
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0014
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ldhl	sp,	#109
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, c
	call	_applyDragToGameObject
;main.c:299: setRotatedSprite(2 + i, 4, x, y);
	ld	hl, #128
	add	hl, sp
	ld	c, (hl)
	inc	c
	inc	c
	ldhl	sp,	#125
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#125
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	e, #0x04
	ld	a, c
	call	_setRotatedSprite
00121$:
;main.c:301: updateGameObject(&enemies[i].gameObject, &player.gameObject);
	ldhl	sp,	#109
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #8
	add	hl, sp
	ld	c, l
	ld	b, h
	call	_updateGameObject
	jp	00137$
00136$:
;main.c:306: enemies[i].deathTimer--;
	ldhl	sp,	#122
	ld	c, (hl)
	dec	c
	ldhl	sp,	#111
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;main.c:307: if (!enemies[i].deathTimer)
	ldhl	sp,#111
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#122
	ld	(hl), a
	ld	a, c
	or	a, a
	jr	NZ, 00133$
;main.c:309: activeEnemies[i] = FALSE;
	dec	hl
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), #0x00
;main.c:310: hide_sprite(enemies[i].gameObject.firstSprite);
	ldhl	sp,#115
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
;C:/gbdk-win64/gbdk/include/gb/gb.h:1703: shadow_OAM[nb].y = 0;
	ld	l, a
	ld	de, #_shadow_OAM+0
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	(hl), #0x00
;main.c:310: hide_sprite(enemies[i].gameObject.firstSprite);
	jp	00137$
00133$:
;main.c:314: if (enemies[i].deathTimer == pointFrames)
	ldhl	sp,	#122
	ld	a, (hl)
	sub	a, #0x1e
	jp	NZ,00130$
;main.c:316: addScore(score, enemies[i].points);
	ldhl	sp,#113
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;main.c:98: uint8_t lookup[7][8] = {
	ldhl	sp,	#53
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a, #0x01
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a, #0x00
	ld	(hl+), a
	ld	a, #0x02
	ld	(hl+), a
	ld	a, #0x05
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a, #0x05
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a, #0x01
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a, #0x00
	ld	(hl+), a
	ld	a, #0x02
	ld	(hl+), a
	ld	a, #0x05
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a, #0x05
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a, #0x01
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	a,#0x00
	ld	(hl+),a
	ld	(hl+), a
	ld	(hl), #0x00
;main.c:108: uint8_t *addScore = lookup[num];
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl, #53
	add	hl, sp
	add	hl, bc
	ld	c, l
	ld	b, h
;main.c:110: addBCD(score, addScore, 6);
	ld	a, #0x06
	push	af
	inc	sp
	ld	hl, #1
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_addBCD
;main.c:317: set_sprite_tile(enemies[i].gameObject.firstSprite, pointOffset + enemies[i].points);
	ldhl	sp,#113
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, #0x79
	ldhl	sp,	#122
	ld	(hl), a
	ldhl	sp,#115
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;C:/gbdk-win64/gbdk/include/gb/gb.h:1602: shadow_OAM[nb].tile=tile;
	ldhl	sp,	#120
	ld	a, c
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00528$:
	ldhl	sp,	#120
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00528$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#120
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#119
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#122
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#121
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	ld	(de), a
;main.c:317: set_sprite_tile(enemies[i].gameObject.firstSprite, pointOffset + enemies[i].points);
	jp	00137$
00130$:
;main.c:283: set_sprite_prop(enemies[i].gameObject.firstSprite, 0);
	ldhl	sp,#115
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#121
;main.c:319: else if (enemies[i].deathTimer < pointFrames)
	ld	(hl+), a
	ld	a, (hl)
	sub	a, #0x1e
	jr	NC, 00127$
;main.c:321: scroll_sprite(enemies[i].gameObject.firstSprite, 0, -1);
	dec	hl
;C:/gbdk-win64/gbdk/include/gb/gb.h:1691: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, (hl)
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00529$:
	ldhl	sp,	#121
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00529$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#119
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#118
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#120
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#121
;C:/gbdk-win64/gbdk/include/gb/gb.h:1692: itm->y+=y, itm->x+=x;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl)
	dec	a
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl-)
	dec	hl
	ld	(de), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#120
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#119
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#122
	ld	(hl), a
	ld	c, (hl)
	ldhl	sp,	#118
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;main.c:321: scroll_sprite(enemies[i].gameObject.firstSprite, 0, -1);
	jp	00137$
00127$:
;main.c:326: (explosionAnimationFrames - ((enemies[i].deathTimer - pointFrames) >> 2)) + explosionOffset);
	ldhl	sp,	#122
	ld	a, (hl-)
	dec	hl
	ld	c, a
	ld	b, #0x00
	ld	de, #0x001e
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ld	(hl-), a
	ld	a, e
	ld	(hl+), a
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	ld	a, (hl)
	ldhl	sp,	#122
	ld	(hl), a
	ld	a, #0x0c
	sub	a, (hl)
	ldhl	sp,	#118
	ld	(hl), a
;main.c:325: set_sprite_tile(enemies[i].gameObject.firstSprite,
	ldhl	sp,	#121
;C:/gbdk-win64/gbdk/include/gb/gb.h:1602: shadow_OAM[nb].tile=tile;
	ld	a, (hl)
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00530$:
	ldhl	sp,	#121
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00530$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#121
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#120
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#123
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#122
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#118
	ld	a, (hl)
	ld	(de), a
;main.c:327: applyDragToGameObject(&enemies[i].gameObject, enemies[i].dragShifts);
	ldhl	sp,#109
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0014
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#123
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#122
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#109
	ld	a, (hl)
	ldhl	sp,	#121
	ld	(hl), a
	ldhl	sp,	#110
	ld	a, (hl)
	ldhl	sp,	#122
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_applyDragToGameObject
;main.c:328: scroll_sprite(enemies[i].gameObject.firstSprite, INT(enemies[i].gameObject.velx), INT(enemies[i].gameObject.vely));
	ldhl	sp,#109
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	a, (hl+)
	ld	a, (hl)
	ldhl	sp,	#121
	ld	(hl), a
	ldhl	sp,#109
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	a, (hl+)
	ld	a, (hl)
	ldhl	sp,	#122
	ld	(hl), a
	ldhl	sp,#115
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;C:/gbdk-win64/gbdk/include/gb/gb.h:1691: OAM_item_t * itm = &shadow_OAM[nb];
	ldhl	sp,	#119
	ld	a, c
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#120
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	a, #0x02
00531$:
	ldhl	sp,	#117
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00531$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#121
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#120
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#120
	ld	a, (hl-)
	dec	hl
;C:/gbdk-win64/gbdk/include/gb/gb.h:1692: itm->y+=y, itm->x+=x;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	add	a, (hl)
	ld	(hl), a
	ldhl	sp,#117
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#121
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,#117
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#122
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#121
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl)
	ldhl	sp,	#122
	add	a, (hl)
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	ld	(de), a
;main.c:328: scroll_sprite(enemies[i].gameObject.firstSprite, INT(enemies[i].gameObject.velx), INT(enemies[i].gameObject.vely));
00137$:
;main.c:332: if (!player.invincibilityTimer)
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#122
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	NZ, 00143$
;main.c:334: if (checkCollision(&enemies[i].gameObject.collider, &player.gameObject.collider) && !player.deathTimer && !enemies[i].deathTimer)
	ldhl	sp,#109
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#116
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;GameObject.c:14: return (abs(sub(a->posx, b->posx)) < add(a->sizex, b->sizex) >> 1 && abs(sub(a->posy, b->posy)) < add(a->sizey, b->sizey) >> 1);
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#121
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#122
	ld	(hl), a
	ld	l, c
	ld	h, b
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;fixed.c:17: return a - b;
	ldhl	sp,#121
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ld	b, a
	ld	a, e
	ld	(hl+), a
;fixed.c:30: if (a >= 0)
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	bit	7, (hl)
	jr	NZ, 00221$
;fixed.c:32: return a;
	dec	hl
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#122
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	jr	00223$
00221$:
;fixed.c:36: return -a;
	ld	de, #0x0000
	ldhl	sp,	#121
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	b, a
	ld	c, e
	ldhl	sp,	#119
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;GameObject.c:14: return (abs(sub(a->posx, b->posx)) < add(a->sizex, b->sizex) >> 1 && abs(sub(a->posy, b->posy)) < add(a->sizey, b->sizey) >> 1);
00223$:
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#121
	ld	(hl), a
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#122
	ld	(hl), a
	ldhl	sp,#116
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;fixed.c:13: return a + b;
	ldhl	sp,	#121
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
;GameObject.c:14: return (abs(sub(a->posx, b->posx)) < add(a->sizex, b->sizex) >> 1 && abs(sub(a->posy, b->posy)) < add(a->sizey, b->sizey) >> 1);
	sra	b
	rr	c
	ldhl	sp,	#119
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00532$
	bit	7, d
	jr	NZ, 00533$
	cp	a, a
	jr	00533$
00532$:
	bit	7, d
	jr	Z, 00533$
	scf
00533$:
	jp	NC, 00268$
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#116
	ld	a, (hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#119
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;fixed.c:17: return a - b;
	ldhl	sp,#119
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, e
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl)
	ldhl	sp,	#118
	ld	(hl), a
	ldhl	sp,	#122
	ld	a, (hl)
	ldhl	sp,	#119
;fixed.c:30: if (a >= 0)
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#121
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#122
	ld	(hl), a
	bit	7, (hl)
	jr	NZ, 00227$
;fixed.c:32: return a;
	ldhl	sp,	#118
	ld	a, (hl)
	ldhl	sp,	#121
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#122
	ld	(hl), a
	jr	00229$
00227$:
;fixed.c:36: return -a;
	ld	de, #0x0000
	ldhl	sp,	#118
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#122
	ld	(hl-), a
	ld	(hl), e
;GameObject.c:14: return (abs(sub(a->posx, b->posx)) < add(a->sizex, b->sizex) >> 1 && abs(sub(a->posy, b->posy)) < add(a->sizey, b->sizey) >> 1);
00229$:
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#119
	ld	(hl), a
	ldhl	sp,	#23
	ld	a, (hl)
	ldhl	sp,	#120
	ld	(hl), a
	ldhl	sp,#116
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;fixed.c:13: return a + b;
	ldhl	sp,	#119
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
;GameObject.c:14: return (abs(sub(a->posx, b->posx)) < add(a->sizex, b->sizex) >> 1 && abs(sub(a->posy, b->posy)) < add(a->sizey, b->sizey) >> 1);
	sra	b
	rr	c
	ldhl	sp,	#121
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00534$
	bit	7, d
	jr	NZ, 00535$
	cp	a, a
	jr	00535$
00534$:
	bit	7, d
	jr	Z, 00535$
	scf
00535$:
	jr	C, 00269$
00268$:
	ldhl	sp,	#122
	ld	(hl), #0x00
	jr	00270$
00269$:
	ldhl	sp,	#122
	ld	(hl), #0x01
00270$:
	ldhl	sp,	#122
	ld	a, (hl)
;main.c:334: if (checkCollision(&enemies[i].gameObject.collider, &player.gameObject.collider) && !player.deathTimer && !enemies[i].deathTimer)
	or	a, a
	jp	Z, 00251$
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jp	NZ, 00251$
	ldhl	sp,#111
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#122
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	NZ, 00251$
;main.c:336: player.deathTimer = explosionFrames + playerDeathHaltFrames;
	ldhl	sp,	#29
	ld	(hl), #0x8c
;main.c:337: flinger.dragShifts = detachedFlingerDragShifts;
	ldhl	sp,	#51
;main.c:338: flinger.attached = FALSE;
	ld	a, #0x06
	ld	(hl+), a
	ld	(hl), #0x00
	jp	00251$
00143$:
;main.c:343: set_sprite_prop(player.gameObject.firstSprite, (player.invincibilityTimer >> 2) & 1 ? get_sprite_prop(player.gameObject.firstSprite) | S_PRIORITY : get_sprite_prop(player.gameObject.firstSprite) & ~S_PRIORITY);
	ldhl	sp,	#122
	ld	a, (hl)
	rrca
	rrca
	and	a, #0x01
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00271$
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#122
	ld	(hl), a
;C:/gbdk-win64/gbdk/include/gb/gb.h:1658: return shadow_OAM[nb].prop;
	ld	a, (hl-)
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00536$:
	ldhl	sp,	#121
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00536$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#121
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#120
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#123
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#122
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
;main.c:343: set_sprite_prop(player.gameObject.firstSprite, (player.invincibilityTimer >> 2) & 1 ? get_sprite_prop(player.gameObject.firstSprite) | S_PRIORITY : get_sprite_prop(player.gameObject.firstSprite) & ~S_PRIORITY);
	set	7, a
	jr	00272$
00271$:
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#122
	ld	(hl), a
;C:/gbdk-win64/gbdk/include/gb/gb.h:1658: return shadow_OAM[nb].prop;
	ld	a, (hl-)
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00537$:
	ldhl	sp,	#121
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00537$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#121
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#120
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#123
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#122
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
;main.c:343: set_sprite_prop(player.gameObject.firstSprite, (player.invincibilityTimer >> 2) & 1 ? get_sprite_prop(player.gameObject.firstSprite) | S_PRIORITY : get_sprite_prop(player.gameObject.firstSprite) & ~S_PRIORITY);
	res	7, a
00272$:
	ldhl	sp,	#118
	ld	(hl), a
	ldhl	sp,	#24
	ld	c, (hl)
;C:/gbdk-win64/gbdk/include/gb/gb.h:1648: shadow_OAM[nb].prop=prop;
	ldhl	sp,	#121
	ld	a, c
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00538$:
	ldhl	sp,	#121
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00538$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#121
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#120
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#123
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#122
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#118
	ld	a, (hl)
	ld	(de), a
;main.c:344: player.invincibilityTimer--;
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#122
	ld	(hl), a
	ld	a, (hl)
	dec	a
	ldhl	sp,	#30
	ld	(hl), a
00251$:
;main.c:271: for (uint8_t i = 0; i < maxEnemyNumber; i++)
	ld	hl, #128
	add	hl, sp
	inc	(hl)
	jp	00250$
00147$:
;main.c:349: enemyUpdate++;
	ld	hl, #_enemyUpdate
	inc	(hl)
;main.c:350: if (enemyUpdate == 4)
	ld	a, (hl)
	sub	a, #0x04
	jr	NZ, 00149$
;main.c:352: enemyUpdate = 0;
	ld	hl, #_enemyUpdate
	ld	(hl), #0x00
00149$:
;main.c:355: enemyTimer--;
	ldhl	sp,	#127
;main.c:356: if (enemyTimer == 0)
	dec	(hl)
	ld	a, (hl)
	jp	NZ, 00154$
;main.c:136: for (uint8_t i = 0; i < maxEnemyNumber; i++)
;main.c:358: int8_t index = loadEnemy();
	ld	c, #0x00
	ld	e, c
00247$:
	ld	a, e
	sub	a, #0x08
	jr	NC, 00237$
	ld	hl, #_activeEnemies
	ld	d, #0x00
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	NZ, 00248$
	ld	(hl), #0x01
	ld	hl, #128
	add	hl, sp
	ld	(hl), c
	jr	00238$
00248$:
	inc	e
	ld	c, e
	jr	00247$
00237$:
	ld	hl, #128
	add	hl, sp
	ld	(hl), #0xff
00238$:
;main.c:359: if (index != -1)
	ld	hl, #128
	add	hl, sp
	ld	a, (hl)
	inc	a
	jp	Z,00151$
;main.c:361: enemies[index].accelerationShifts = 11;
	ld	hl, #128
	add	hl, sp
	ld	c, (hl)
	ld	a, c
	rlca
	sbc	a, a
	ld	b, a
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	bc,#_enemies
	add	hl,bc
	ld	c, l
	ld	b, h
	ld	hl, #0x0013
	add	hl, bc
	ld	(hl), #0x0b
;main.c:362: enemies[index].dragShifts = 4;
	ld	hl, #0x0014
	add	hl, bc
	ld	(hl), #0x04
;main.c:363: enemies[index].gameObject.firstSprite = 2 + index;
	ld	hl, #0x0010
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	hl, #128
	add	hl, sp
	ld	a, (hl)
	inc	a
	inc	a
	ld	(de), a
;main.c:364: enemies[index].gameObject.spriteSizex = 1;
	ld	hl, #0x0011
	add	hl, bc
	ld	(hl), #0x01
;main.c:365: enemies[index].gameObject.spriteSizey = 1;
	ld	hl, #0x0012
	add	hl, bc
	ld	(hl), #0x01
;main.c:366: enemies[index].gameObject.posx = player.gameObject.posx;
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#117
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#118
	ld	(hl-), a
	ld	e, c
	ld	d, b
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;main.c:367: enemies[index].gameObject.posy = sub(player.gameObject.posy, FIXED(80));
	ld	hl, #0x0002
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#121
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#120
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#121
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#122
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
	ld	hl, #128
	add	hl, sp
	ld	(hl-), a
	ld	(hl), e
;main.c:367: enemies[index].gameObject.posy = sub(player.gameObject.posy, FIXED(80));
	ldhl	sp,#119
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#127
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;main.c:368: enemies[index].gameObject.velx = FIXED(0);
	ld	hl, #0x0004
	add	hl, bc
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;main.c:369: enemies[index].gameObject.vely = FIXED(0);
	ld	hl, #0x0006
	add	hl, bc
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;main.c:370: enemies[index].gameObject.collider.posx = enemies[index].gameObject.posx;
	ld	hl, #0x0008
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#117
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;main.c:371: enemies[index].gameObject.collider.posy = enemies[index].gameObject.posy;
	ld	hl, #0x000a
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#127
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;main.c:372: enemies[index].gameObject.collider.sizex = FIXED(8);
	ld	hl, #0x000c
	add	hl, bc
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x08
;main.c:373: enemies[index].gameObject.collider.sizey = FIXED(8);
	ld	hl, #0x000e
	add	hl, bc
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x08
;main.c:374: enemies[index].type = follower;
	ld	hl, #0x0016
	add	hl, bc
	ld	(hl), #0x00
;main.c:375: enemies[index].deathTimer = 0;
	ld	hl, #0x0015
	add	hl, bc
	ld	(hl), #0x00
;main.c:377: enemyTimer = resetEnemyTimer;
	ldhl	sp,	#127
	ld	(hl), #0xff
	jr	00154$
00151$:
;main.c:381: enemyTimer++;
	ldhl	sp,	#127
	inc	(hl)
00154$:
;main.c:385: updateGameObject(&player.gameObject, &player.gameObject);
	ld	hl, #8
	add	hl, sp
	ld	c, l
	ld	b, h
	ld	hl, #8
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_updateGameObject
;main.c:387: showScore(score);
;main.c:81: for (uint8_t i = 0; i < 6; i++)
	ld	c, #0x00
00253$:
	ld	a, c
	sub	a, #0x06
	jr	NC, 00241$
;main.c:83: set_win_tile_xy(i + 1, 0, score[i] + numbersOffset);
	ld	e, c
	ld	d, #0x00
	ld	hl, #0
	add	hl, sp
	add	hl, de
	ld	a, (hl)
	add	a, #0x76
	ld	b, c
	inc	b
	ld	h, a
	ld	l, #0x00
	push	hl
	push	bc
	inc	sp
	call	_set_win_tile_xy
	add	sp, #3
;main.c:81: for (uint8_t i = 0; i < 6; i++)
	inc	c
	jr	00253$
;main.c:387: showScore(score);
00241$:
;main.c:388: showLives(lives);
;main.c:89: set_win_tile_xy(18, 0, numbersOffset - 1);
	ld	a, #0x75
	push	af
	inc	sp
	ld	hl, #0x12
	push	hl
	call	_set_win_tile_xy
	add	sp, #3
;main.c:90: for (uint8_t i = 0; i < 2; i++)
	ld	c, #0x00
00256$:
	ld	a, c
	sub	a, #0x02
	jr	NC, 00243$
;main.c:92: set_win_tile_xy(i + 19, 0, lives[i] + numbersOffset);
	ld	e, c
	ld	d, #0x00
	ld	hl, #6
	add	hl, sp
	add	hl, de
	ld	a, (hl)
	add	a, #0x76
	ld	b, a
	ld	a, c
	add	a, #0x13
	push	bc
	inc	sp
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_win_tile_xy
	add	sp, #3
;main.c:90: for (uint8_t i = 0; i < 2; i++)
	inc	c
	jr	00256$
;main.c:388: showLives(lives);
00243$:
;main.c:390: moveBackground(&player.gameObject);
;GameObject.c:101: move_bkg(INT(player->posx), INT(player->posy));
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	b, (hl)
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	a, (hl)
	ldh	(_SCX_REG + 0), a
;C:/gbdk-win64/gbdk/include/gb/gb.h:1208: SCX_REG=x, SCY_REG=y;
	ld	a, b
	ldh	(_SCY_REG + 0), a
;main.c:392: wait_vbl_done();
	call	_wait_vbl_done
	jp	00156$
;main.c:394: }
	add	sp, #127
	inc	sp
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
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
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x6c	; 108	'l'
	.db #0x6c	; 108	'l'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x64	; 100	'd'
	.db #0x26	; 38
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x32	; 50	'2'
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc4	; 196
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xce	; 206
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x4c	; 76	'L'
	.db #0x00	; 0
	.db #0x82	; 130
	.db #0x00	; 0
	.db #0xec	; 236
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe4	; 228
	.db #0x00	; 0
	.db #0x8a	; 138
	.db #0x00	; 0
	.db #0xca	; 202
	.db #0x00	; 0
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0xc4	; 196
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x92	; 146
	.db #0x00	; 0
	.db #0xad	; 173
	.db #0x00	; 0
	.db #0xad	; 173
	.db #0x00	; 0
	.db #0xad	; 173
	.db #0x00	; 0
	.db #0x92	; 146
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xda	; 218
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0xdd	; 221
	.db #0x00	; 0
	.db #0x8d	; 141
	.db #0x00	; 0
	.db #0xda	; 218
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xca	; 202
	.db #0x00	; 0
	.db #0x95	; 149
	.db #0x00	; 0
	.db #0xd5	; 213
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0xca	; 202
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0xd5	; 213
	.db #0x00	; 0
	.db #0xd5	; 213
	.db #0x00	; 0
	.db #0xd5	; 213
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
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
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0xe7	; 231
	.db #0xe7	; 231
	.db #0xe7	; 231
	.db #0xdb	; 219
	.db #0xc3	; 195
	.db #0xdb	; 219
	.db #0xc3	; 195
	.db #0xc3	; 195
	.db #0xc3	; 195
	.db #0x81	; 129
	.db #0xc3	; 195
	.db #0x81	; 129
	.db #0xc3	; 195
	.db #0x99	; 153
	.db #0xdb	; 219
	.db #0xe7	; 231
	.db #0xe7	; 231
	.db #0xdb	; 219
	.db #0xdb	; 219
	.db #0xbd	; 189
	.db #0xbd	; 189
	.db #0xbd	; 189
	.db #0xbd	; 189
	.db #0xbd	; 189
	.db #0xbd	; 189
	.db #0xbd	; 189
	.db #0xbd	; 189
	.db #0xdb	; 219
	.db #0xdb	; 219
	.db #0xe7	; 231
	.db #0xe7	; 231
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xe7	; 231
	.db #0xe7	; 231
	.db #0xe7	; 231
	.db #0xe7	; 231
	.db #0xd7	; 215
	.db #0xd7	; 215
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xc3	; 195
	.db #0xc3	; 195
	.db #0xbd	; 189
	.db #0xbd	; 189
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfb	; 251
	.db #0xfb	; 251
	.db #0xe7	; 231
	.db #0xe7	; 231
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0xdd	; 221
	.db #0xdd	; 221
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xbd	; 189
	.db #0xbd	; 189
	.db #0xc3	; 195
	.db #0xc3	; 195
	.db #0xd7	; 215
	.db #0xd7	; 215
	.db #0xd7	; 215
	.db #0xd7	; 215
	.db #0xb7	; 183
	.db #0xb7	; 183
	.db #0xb7	; 183
	.db #0xb7	; 183
	.db #0x83	; 131
	.db #0x83	; 131
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xc1	; 193
	.db #0xc1	; 193
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xc3	; 195
	.db #0xc3	; 195
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xdd	; 221
	.db #0xdd	; 221
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0x87	; 135
	.db #0x87	; 135
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0xbd	; 189
	.db #0xbd	; 189
	.db #0xfb	; 251
	.db #0xfb	; 251
	.db #0xfb	; 251
	.db #0xfb	; 251
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xf7	; 247
	.db #0xef	; 239
	.db #0xef	; 239
	.db #0xef	; 239
	.db #0xef	; 239
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xd7	; 215
	.db #0xd7	; 215
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xc3	; 195
	.db #0xc3	; 195
	.db #0xfb	; 251
	.db #0xfb	; 251
	.db #0xfb	; 251
	.db #0xfb	; 251
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xc7	; 199
	.db #0xc7	; 199
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
__xinit__SpaceshipPoints:
	.db #0x00	; 0
__xinit__enemyUpdate:
	.db #0x00	; 0
	.area _CABS (ABS)
