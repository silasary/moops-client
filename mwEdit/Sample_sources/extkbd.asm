; re: Racunari 78

	%PAGESIZE	66,132
	%TITLE	'Gp ExtKbd V1.0'
	%SUBTTL	'Structures, Equates & Macros'
        %NOMACS
        IDEAL
        P286N
        
	INCLUDE	"\rr\rr.inc"

	@PageBreak	'Code'
	
	@CodeDriver

Start:
header	dd	-1			; link to next device driver
	dw	1000000000000000b	; device driver attributes
	dw	strategy   	     	; offset of strategy routine
	dw	interrupt		; offset of interrupt routine
	db	' EXT KBD'		; device name

reg_ptr	dd	?

jmp_tab	dw	initialize
	dw	null	;media_check
	dw	null	;build_bpb
	dw	null	;ioctl_read
	dw	null	;read
	dw	null	;nond_read
	dw	null	;input_status
	dw	null	;input_flush
	dw	null	;write
	dw	null	;write_verify
	dw	null	;output_status
	dw	null	;output_flush
	dw	null	;ioctl_write
	dw	null	;device_open
	dw	null	;device_close
	dw	null	;removable
	dw	null	;output_busy
	
keybuflen EQU 256
keybuf	db	keybuflen	dup (?)

PROC	strategy	FAR
	mov	[WORD PTR CS:reg_ptr],bx
	mov	[WORD PTR CS:reg_ptr+2],es
	ret
ENDP

PROC	interrupt	FAR
	push	ax bx cx dx si di bp ds es
	
	push	cs
	pop	ds
	
	les	di,[reg_ptr]
	mov	bl,[ES:DI+2]		; [ES:DI.cmd]
	xor	bh,bh
	shl	bx,1
	add	bx,OFFSET jmp_tab
	call	[WORD PTR bx]
	les	di,[reg_ptr]
	or	ax,100h
	mov	[ES:DI+3],ax		; [ES:DI.status]
	
	pop	es ds bp di si dx cx bx ax
	ret
ENDP

PROC	null	NEAR
	xor	ax,ax
	ret
ENDP

PROC	initialize	NEAR
	mov	ax,cs
	mov	bx,OFFSET keybuf
	add	bx,keybuflen
	shr	bx,4
	add	ax,bx
	inc	ax
	cmp	ax,0FFFh
	ja	cantInstall
	mov	[WORD PTR ES:DI+14],OFFSET initialize	; [ES:DI.addr]
	mov	[WORD PTR ES:DI+16],cs			; [ES:DI.addr+2]
	mov	dx,OFFSET Signature
	mov	ah,9
	int	21h
	push	ds
	ASSUME	DS:Nothing
	mov	ax,040h
	mov	ds,ax
	mov	ax,cs
	shl	ax,4
	add	ax,OFFSET keybuf
	sub	ax,0400h
	mov	[DS:01Ah],ax
	mov	[DS:01Ch],ax
	mov	[DS:080h],ax
	add	ax,keybuflen
	mov	[DS:082h],ax
	pop	ds		
	ASSUME	DS:Code
	jmp	short	exitfirst
cantInstall:
	mov	[WORD PTR ES:DI+14],0	; [ES:DI.addr]
	mov	[WORD PTR ES:DI+16],0	; [ES:DI.addr+2]
	mov	dx,OFFSET Signature
	mov	ah,9
	int	21h
	mov	dx,OFFSET NotLow
	mov	ah,9
	int	21h
testAgain:
	mov	ah,6
	mov	dl,0FFh
	int	21h
	je	testAgain
exitfirst:
	ret	
ENDP
	
        @PageBreak	'Data'

Signature	db	'Gp ExtKbd V1.01',13,10
Author		db	'(c) Primo` Gabrijel~i~, 1992',13,10,'$'
NotLow		db	'Cannot install - not loaded LOW enough!',7,13,10
		db	'Press any key to continue...',13,10,'$'

ENDS

	END	Start

