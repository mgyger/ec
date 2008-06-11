; Source Equivalent for ThinkPad Embedded Controller Firmware
; -----------------------------------------------------------

; H8S/2161BV Pin Assignments
; 32..25 PE  -> keyboard scan matrix outputs
; 50..43 PF  -> keyboard scan matrix outputs
; 58..51 PG  <- keyboard scan matrix inputs
;    108 P13 -> BJT -> ThinkLight LED
;      3 P44 -> BJT -> IGFET -> fan motor
;     80 P62 <- BJT <- fan tachometer signal

		.include "h8s2161.h"

; ThinkPad Type and ID Selection (mutually exclusive)
;type1R	= -1
;type1V	= -1	; not supported
;type1Y	= -1
;type70	= -1
;type76	= -1

;id	= 12
;id	= 14
;id	= 15
;id	= 16
;id	= 24
;id	= 25
;id	= 26
;id	= 27
;id	= 28
;id	= 29
;id	= 62
;id	= 63
;id	= 66
;id	= 68
;id	= 69
;id	= 70
;id	= 71

		.conf = 0		; used for conf mutual exclusion check

		.macro	conf  type buildid1 typestr buildid2 typeid version level timestamp1 timestamp2 checksum1 checksum2 checksum3 md5=-
		.ifndef type\type
		type\type  =  0		; assign constant for use of simpler expressions
		.elseif type\type \(&&) id == \buildid1
		type\type  = -1		; reassign ~0 if !0 for simpler &-expressions
		.conf      = .conf + 1	; count number of selected configurations
		.print "# \type\()HT\buildid1\()WW (version \version)"
		.ifnc -, \md5
		.print "\md5  -"
		.endif
		typestr    = \typestr
		buildid1   = (\buildid1 / 10 + '0) << 8 | (\buildid1 % 10 + '0)	; binary -> ascii
		buildid2   = \buildid2
		typeid     = \typeid
		version    = \version
		level      = \level
		timestamp1 = \timestamp1
		timestamp2 = \timestamp2
		checksum1  = \checksum1
		checksum2  = \checksum2
		checksum3  = \checksum3
		.endif
		.endm

; Type 1R: T40/p; T41/p; T42/p; R50/p; R51 1829..1831, 1836
conf 1R 15  0x3152 0x3272 0x48  0x1020 0x01000015  0x66b6798 0x66b6798  0x7c49 0x399a 0x6fce  d1103e48f64a58b646cafcf1071b3d05 ; (T40)
conf 1R 62  0x3152 0x3273 0x48  0x2030 0x01000062  0x7305f4c 0x7305f4d  0xaee8 0xd7e6 0x6513  d3960638afd59bdc5858ff68beaa69ce ; +T41  +R50
conf 1R 63  0x3152 0x3273 0x48  0x2040 0x01000063  0x732465d 0x732465e  0xceb4 0xf0d5 0x38f5  01ea0447d43971e91f3f834fa3da43f6 ; +T41p +R50p
conf 1R 66  0x3152 0x3274 0x48  0x3001 0x01000066  0x8334b94 0x8334b95  0xa443 0xea9d 0xeb13  63272d64df937a506c0022647d4b3d26 ; +R51
conf 1R 68  0x3152 0x3274 0x48  0x3011 0x01030068  0x87766ee 0x87766ef  0x865b 0xceff 0xe79a  9f8d0532aaa630ff20b087662b35ee2c ; +T42  +T42p
conf 1R 69  0x3152 0x3275 0x48  0x3020 0x01030069  0x8ca681b 0x8ca681b  0x7733 0xcd80 0x8d3f  ad1410d2bfc6985b014f6f8292e966ef
conf 1R 70  0x3152 0x3730 0x48  0x3030 0x01030070  0x8e1624f 0x8e1624f  0x7bd3 0xd335 0x196f  c9f36ba18e02ebd39818fa085fad6bec
conf 1R 71  0x3152 0x3731 0x48  0x3040 0x01030071  0x95d64bf 0x95d64bf  0x7308 0x5fb5 0x6479  bfcdf0d3d8d7a3048832367ae840007c

; Type 1Y: T43/p 2668..2669, 0x2678..2679, 0x2686..2687
conf 1Y 24  0x3159 0x3234 0x4a  0x1010 0x01010000  0xa3a672f 0xa3a6730  0x74af 0x9d19 0x39c0  3a01b124842971a8ee8e388341d81f85
conf 1Y 26  0x3159 0x3236 0x4a  0x1030 0x01030000  0xa886308 0xa886308  0x759a 0xa0f3 0xe979  31b5ca27ed880e0cfa41812503ec3f4d
conf 1Y 27  0x3159 0x3237 0x4a  0x1040 0x01040000  0xb676139 0xb676139  0x7679 0xa1e3 0xe97f  40a7810831cbb14bb32db16113de7b9f
conf 1Y 28  0x3159 0x3238 0x4a  0x1050 0x01050000  0xc345a2c 0xc345a2c  0xcd79 0xa823 0xd84c  236e8aded160bb4f0567adcaa2f0703f
conf 1Y 29  0x3159 0x3239 0x4a  0x1060 0x01060000  0xcba4dff 0xcba4dff  0xe27d 0xb3ca 0xf0b3  79d91ad18613acc99e2bfc7486ce1cd4

; Type 70: T43 1871..1876; R52 0x1858..1863, 0x1958
conf 70 24  0x3730 0x3234 0x99  0x1010 0x01020000  0xa3c5174 0x978488c  0x4fb3 0x0d42 0xb036  7670cdfaba59b487701a84abb4e279b6
conf 70 26  0x3730 0x3236 0x99  0x1030 0x01040000  0xab46c95 0xa9578b6  0x2e82 0xdbfb 0x8fe6  b1358487547d2b887ee8ffd888060f5e
conf 70 27  0x3730 0x3237 0x99  0x1040 0x01050000  0xc4e528b 0xa9578b6  0x3a1a 0xdbfb 0x920e  8a890dda6252af0b965e24d8628ae3df
conf 70 28  0x3730 0x3238 0x99  0x1050 0x01060000  0xcba6de3 0xa9578b6  0x27b3 0xdbfb 0x9c49  091c2006917b3fead67729becbb06d48

; Type 76: R52 1846..1850, 1870
conf 76 12  0x3736 0x3132 0x9f  0x1020 0x01020000  0xa7962fa 0xa7962d2  0x209e 0x00ca 0x6986  fcb328084b548750af690df53955c84a
conf 76 14  0x3736 0x3134 0x9f  0x1040 0x01040000  0xab44de5 0xab44de1  0x2fca 0x1580 0xd983  fc4888d2db7c03693ca0c8303b89ff95
conf 76 15  0x3736 0x3135 0x9f  0x1050 0x01050000  0xc4e5923 0xab44de1  0x161a 0x1580 0xc6cc  62cbaea72c449a8bf9ce0d276ea599ad
conf 76 16  0x3736 0x3136 0x9f  0x1060 0x01060000  0xcba676e 0xab44de1  0x10d6 0x1580 0x28c6  7371b503a576f3e8cf343a06ca1ff223

; Type 1V: R50e, R51 2883, 0x2887..2889, 0x2894..2895	; not supported
conf 1V 24  0x3156 0x3274 0x49  0x1000 0x00000000  0x8596ece 0x76d4fb7  0xaf9c 0xf768 0x224f  890faff49e193daaf6c2a943585885d6
conf 1V 25  0x3156 0x3274 0x49  0x1010 0x00000000  0x879743f 0x76d4fb7  0xa7ce 0xf768 0x11da  5437df6ece40f05659561b174c76d8af
conf 1V 26  0x3156 0x3236 0x49  0x1020 0x00000000  0x8ed7308 0x76d4fb7  0x9a68 0xf768 0xed0e  42dc1a160a713ca897148086f8678ef5
conf 1V 27  0x3156 0x3237 0x49  0x1030 0x00000000  0x9264c1c 0x76d4fb7  0xc502 0xf768 0x5938  71f293b4cea0c3c62214a29f62383cd2
conf 1V 28  0x3156 0x3238 0x49  0x1040 0x00000000  0xa3148fa 0xa31479e  0xc0fc 0x0447 0x2c0c  2c67d7ceecce7d50a4a0883bbcc434be

.if .conf <> 1 || !level
		.error "no or multiple type and/or id configuration settings"
		.error "(e.g. on command line: --defsym type1Y=1 --defsym id=28)"
		.abort
.endif

		.macro	zero  register		; mov #0, register
		xor	\register, \register
		.endm


		i = 7				; CCR Interrupt Mask Bit
		c = 0				; CCR Carry Flag

		.macro	set  bit		; Set CCR Bit
		orc	#1 << \bit, ccr
		.endm

		.macro	clr  bit		; Clear CCR Bit
		andc	#1 << \bit ^ M8, ccr
		.endm

						; Relative 16-bit Jump Table for Switch
		.macro	case  index=-1 c0=-1 c1=-1 c2=-1 c3=-1 c4=-1 c5=-1 c6=-1 c7=-1
		.if \index > 0			; Index 0 resets case
		.fill \index - .case, 2		; Use 0 for holes in case range
		.endif
		.ifnc -1, \index		; Allow ,, to continue index
		.case = \index
		.endif
		.irp	case, \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7
		.ifnc -1, \case
		.word \case - .
		.case = .case + 1
		.endif
		.endr
		.endm


		.text				; ROM/Flash Memory

; Exception Handling Vector Table

		.org   0 * 4
_reset:		.long reset			; Reset Vector

		.org   6 * 4			; Power-Down Modes
_dtrns:		.long NULL			; Direct Transition

		.org   7 * 4
_nmi:		.long rte			; Non-Maskable External Interrupt
_trap0:		.long NULL			; Trap Instruction 0
_trap1:		.long NULL			; Trap Instruction 1
_trap2:		.long NULL			; Trap Instruction 2
_trap3:		.long NULL			; Trap Instruction 3

		.org  16 * 4			; Maskable External Interrupts
_irq0:		.long irq0			; External Interrupt Request 0
_irq1:		.long rte			; External Interrupt Request 1
_irq2:		.long irq2			; External Interrupt Request 2
_irq3:		.long rte			; External Interrupt Request 3
_irq4:		.long rte			; External Interrupt Request 4
_irq5:		.long rte			; External Interrupt Request 5
_irq6:		.long irq6_irq7			; IRQ6/KIN0..KIN7
_irq7:		.long irq6_irq7			; IRQ7/WUE0..WUE7/KIN8..KIN15

		.org  24 * 4			; Internal Interrupts
_swtend:	.long rte			; Software-Activated Data Transfer End
_wovi0:		.long rte			; WDT_0 Watchdog Interval Timer
_wovi1:		.long wovi1			; WDT_1 Watchdog Interval Timer
_break:		.long rte			; Address Break (Breakpoint)
_adi:		.long rte			; A/D Conversion End

		.org  48 * 4			; 16-bit Free Running Timer
_icia:		.long icia			; FRT Input Capture A
_icib:		.long icib			; FRT Input Capture B
_icic:		.long icic			; FRT Input Capture C
_icid:		.long rte			; FRT Input Capture D
_ocia:		.long ocia			; FRT Output Compare A
_ocib:		.long rte			; FRT Output Compare B
_fovi:		.long fovi			; FRT Overflow

		.org  64 * 4			; 8-bit Timer Channel 0
_cmia0:		.long rte			; TMR_0 Compare Match A
_cmib0:		.long rte			; TMR_0 Compare Match B
_ovi0:		.long rte			; TMR_0 Overflow

		.org  68 * 4			; 8-bit Timer Channel 1
_cmia1:		.long rte			; TMR_1 Compare Match A
_cmib1:		.long rte			; TMR_1 Compare Match B
_ovi1:		.long rte			; TMR_1 Overflow

		.org  72 * 4			; 8-bit Timer Channel X/Y
_cmiay:		.long cmiay			; TMR_Y Compare Match A
_cmiby:		.long rte			; TMR_Y Compare Match B
_oviy:		.long rte			; TMR_Y Overflow
_icix:		.long rte			; Input Capture X

		.org  76 * 4			; X-BUS (ISA Host Bus)
_ibf1:		.long rte			; XBS IDR_1 Reception Completion
_ibf2:		.long rte			; XBS IDR_2 Reception Completion
_ibf3:		.long rte			; XBS IDR_3 Reception Completion
_ibf4:		.long rte			; XBS IDR_4 Reception Completion

		.org  80 * 4			; Serial Communication (UART/IrDA)
_eri0:		.long rte			; SCI_0 Reception Error
_rxi0:		.long rte			; SCI_0 Reception Completion
_txi0:		.long rte			; SCI_0 Transmission Data Empty
_tei0:		.long rte			; SCI_0 Transmission End
_eri1:		.long rte			; SCI_1 Reception Error
_rxi1:		.long rte			; SCI_1 Reception Completion
_txi1:		.long rte			; SCI_1 Transmission Data Empty
_tei1:		.long rte			; SCI_1 Transmission End
_eri2:		.long rte			; SCI_2 Reception Error
_rxi2:		.long rte			; SCI_2 Reception Completion
_txi2:		.long rte			; SCI_2 Transmission Data Empty
_tei2:		.long rte			; SCI_2 Transmission End

		.org  92 * 4			; I콯 Bus (SMBus)
_iici0:		.long iici0			; IIC_0 Transmission/Reception Completion
_ddcswi:	.long rte			; IIC_0 Format Switch
_iici1:		.long iici1			; IIC_1 Transmission/Reception Completion

		.org  96 * 4			; Keyboard Buffer Controller (PS/2 Mouse/Keyboard)
_kbia:		.long kbia			; Keyboard Reception Completion A
_kbib:		.long kbib			; Keyboard Reception Completion B
_kbic:		.long kbic			; Keyboard Reception Completion C

		.org 108 * 4			; Low Pin Count (LPC) Host Bus
_erri:		.long rte			; LPC Transfer Error
_ibfi1:		.long ibfi1			; LPC IDR1 Reception Completion (0x60/0x64)
_ibfi2:		.long ibfi2			; LPC IDR2 Reception Completion (0x62/0x66)
_ibfi3:		.long ibfi3			; LPC IDR3 Reception Completion

; ==============================================

		.org 0x000200, -(type1Y || level < 0x01050000)
		.octa 0x434f52502e2049424d20323030312041
		.octa 0x4c4c2052494748545320524553455256
		.word 0x4544

		.align 3, -(type1Y || level < 0x01050000)
byte0xE8:	.word version
		.byte typeid
		.byte 0

byte0xF8:	.long timestamp1
		.byte 0, 0

		.align 4, -(type1Y || level < 0x01050000)
byte0xF0:	.word typestr
		.ascii "HT"
		.word buildid1
		.ascii "WW"
		.ascii "________"

byte0xEF:	.byte 3
byte0xEB:	.byte 4

		.byte 2, 6

		.org 0x000264
		.octa 0x28432920436f70797269676874204942
		.long 0x4d20436f, 0x72702e20, 0x32303031
.if     type1Y && level >= 0x01050000
		.byte 0x2c, 0x20, 0x32, 0x30, 0x30, 0x35
.elseif level >= 0x01000066
		.byte 0x2c, 0x20, 0x32, 0x30, 0x30, 0x34
.elseif level >= 0x01000062
		.byte 0x2c, 0x20, 0x32, 0x30, 0x30, 0x33
.endif
		.octa 0x20416c6c205269676874732052657365
		.octa 0x7276656420555320476f7665726e6d65
		.octa 0x6e742055736572732052657374726963
		.octa 0x74656420526967687473202d20557365
		.octa 0x2c206475706c69636174696f6e206f72
		.octa 0x20646973636c6f737572652072657374
		.octa 0x72696374656420627920475341204144
		.octa 0x50205363686564756c6520436f6e7472
		.octa 0x61637420776974682049424d20436f72
		.byte 0x70, 0x2e, 0x20
.if type1Y && level >= 0x01050000
		.octa 0x28432920436f70797269676874204c45
		.octa 0x4e4f564f20323030352c203230303620
		.octa 0x416c6c20526967687473205265736572
		.byte 0x76, 0x65, 0x64
.endif

		.org 0x000400 - 2, -(type1Y || level < 0x01050000)
chksum1:	.word checksum1			; checksum #1 (0x000000..0x0003fd)

; ----------------------------------------------

dataStart:
chksum2:	.word checksum2			; checksum #2 (0x000402..0x000fff)

		.align 4, -1
		.byte 0x00, 0x40
		.byte typeid

		.align 2, -1
byte0xFC:	.long timestamp2


off_00418:
.if type1R
		.long 10f
.else
		.long 0f, 1f
.if type70
		.long 2f, 3f
.endif
	num_00418 = (. - off_00418) / 4

0:		.long 10f, 11f, 12f
1:		.long 20f, 21f, 22f
.if type70
2:		.long 30f, 31f, 32f
3:		.long 40f, 41f, 42f
.endif
.endif


dacTabsPtr:	.long dacTabs

fnTabsPtr:	.long fnTabs

keyLocTabPtr:	.long keyLocTab

volAccKeyTabPtr:.long volAccKeyTab

delayTabPtr:	.long delayTab

fanLevelTabPtr:	.long fanLevelTab


off_00450:
.if type1R
		.long 50f
.else
		.long 5f, 6f
.if type70
		.long 7f, 8f
.endif
	num_00450 = (. - off_00450) / 4

5:		.long 50f, 51f, 52f
	num_5 = (. - 5b) / 4
6:		.long 60f, 61f, 62f
.if type70
7:		.long 70f, 71f, 72f
8:		.long 80f, 81f, 82f
.endif
.endif


off_00470:	.long byte_00b16

off_00474:	.long byte_00b20


.if     type1Y
10:		.word 0x28
		.long byte_0062c, byte_0065f, byte_00681, byte_00692
		.long byte_006b4, byte_006c5, byte_006d6, byte_006e7
		.long byte_006f8, byte_0071a, byte_0073c, byte_0074d
		.long byte_0074d, byte_0074d, byte_0074d, byte_0074d

11:		.word 0x2a
		.long byte_0063d, byte_00670, byte_00681, byte_006a3
		.long byte_006b4, byte_006c5, byte_006d6, byte_006e7
		.long byte_00709, byte_0072b, byte_0073c, byte_0074d
		.long byte_0074d, byte_0074d, byte_0074d, byte_0074d

12:		.word 0x26
		.long byte_0064e, byte_00670, byte_00681, byte_006a3
		.long byte_006b4, byte_006c5, byte_006d6, byte_006e7
		.long byte_00709, byte_0072b, byte_0073c, byte_0074d
		.long byte_0074d, byte_0074d, byte_0074d, byte_0074d

20:		.word 0x28
		.long byte_0075e, byte_00791, byte_007b3, byte_007c4
		.long byte_007e6, byte_007f7, byte_00808, byte_00819
		.long byte_0082a, byte_0084c, byte_0086e, byte_0087f
		.long byte_0087f, byte_0087f, byte_0087f, byte_0087f

21:		.word 0x2a
		.long byte_0076f, byte_007a2, byte_007b3, byte_007d5
		.long byte_007e6, byte_007f7, byte_00808, byte_00819
		.long byte_0083b, byte_0085d, byte_0086e, byte_0087f
		.long byte_0087f, byte_0087f, byte_0087f, byte_0087f

22:		.word 0x26
		.long byte_00780, byte_007a2, byte_007b3, byte_007d5
		.long byte_007e6, byte_007f7, byte_00808, byte_00819
		.long byte_0083b, byte_0085d, byte_0086e, byte_0087f
		.long byte_0087f, byte_0087f, byte_0087f, byte_0087f
.elseif type76
10:		.word 0x28
		.long byte_0062c, byte_0064e, byte_00670, byte_00681
		.long byte_006a3, byte_006b4, byte_006c5, byte_006d6
		.long byte_006e7, byte_006f8, byte_0071a, byte_0072b
		.long byte_0072b, byte_0072b, byte_0072b, byte_0072b

11:		.word 0x2a
		.long byte_0063d, byte_0065f, byte_00670, byte_00692
		.long byte_006a3, byte_006b4, byte_006c5, byte_006d6
		.long byte_006e7, byte_00709, byte_0071a, byte_0072b
		.long byte_0072b, byte_0072b, byte_0072b, byte_0072b

12:		.word 0x26
		.long byte_0063d, byte_0065f, byte_00670, byte_00692
		.long byte_006a3, byte_006b4, byte_006c5, byte_006d6
		.long byte_006e7, byte_00709, byte_0071a, byte_0072b
		.long byte_0072b, byte_0072b, byte_0072b, byte_0072b

20:		.word 0x28
		.long byte_0073c, byte_0075e, byte_00780, byte_00791
		.long byte_007b3, byte_007c4, byte_007d5, byte_007e6
		.long byte_007f7, byte_00808, byte_0082a, byte_0083b
		.long byte_0083b, byte_0083b, byte_0083b, byte_0083b

21:		.word 0x2a
		.long byte_0074d, byte_0076f, byte_00780, byte_007a2
		.long byte_007b3, byte_007c4, byte_007d5, byte_007e6
		.long byte_007f7, byte_00819, byte_0082a, byte_0083b
		.long byte_0083b, byte_0083b, byte_0083b, byte_0083b

22:		.word 0x26
		.long byte_0074d, byte_0076f, byte_00780, byte_007a2
		.long byte_007b3, byte_007c4, byte_007d5, byte_007e6
		.long byte_007f7, byte_00819, byte_0082a, byte_0083b
		.long byte_0083b, byte_0083b, byte_0083b, byte_0083b
.elseif type70
10:		.word 0x28
		.long byte_007f8, byte_0081a, byte_0083c, byte_00b17
		.long byte_0085e, byte_0085e, byte_0086f, byte_00880
		.long byte_00891, byte_008b3, byte_008d5, byte_00b17
		.long byte_00b17, byte_00b17, byte_00b17, byte_00b17

11:		.word 0x2a
		.long byte_00809, byte_0082b, byte_0084d, byte_00b17
		.long byte_0085e, byte_0085e, byte_0086f, byte_00880
		.long byte_008a2, byte_008c4, byte_008e6, byte_00b17
		.long byte_00b17, byte_00b17, byte_00b17, byte_00b17

12:		.word 0x26
		.long byte_00809, byte_0082b, byte_0084d, byte_00b17
		.long byte_0085e, byte_0085e, byte_0086f, byte_00880
		.long byte_008a2, byte_008c4, byte_008e6, byte_00b17
		.long byte_00b17, byte_00b17, byte_00b17, byte_00b17

20:		.word 0x28
		.long byte_008f7, byte_00919, byte_0093b, byte_00b17
		.long byte_0085e, byte_0085e, byte_0086f, byte_00880
		.long byte_0095d, byte_0097f, byte_009a1, byte_00b17
		.long byte_00b17, byte_00b17, byte_00b17, byte_00b17

21:		.word 0x2a
		.long byte_00908, byte_0092a, byte_0094c, byte_00b17
		.long byte_0085e, byte_0085e, byte_0086f, byte_00880
		.long byte_0096e, byte_00990, byte__09b2, byte_00b17
		.long byte_00b17, byte_00b17, byte_00b17, byte_00b17

22:		.word 0x26
		.long byte_00908, byte_0092a, byte_0094c, byte_00b17
		.long byte_0085e, byte_0085e, byte_0086f, byte_00880
		.long byte_0096e, byte_00990, byte__09b2, byte_00b17
		.long byte_00b17, byte_00b17, byte_00b17, byte_00b17

30:		.word 0x28
		.long byte_009c3, byte_009e5, byte_00a07, byte_00b17
		.long byte_0085e, byte_0085e, byte_0086f, byte_00880
		.long byte_00a18, byte_00a3a, byte_00a5c, byte_00b17
		.long byte_00b17, byte_00b17, byte_00b17, byte_00b17

31:		.word 0x2a
		.long byte_009d4, byte_009f6, byte_00a07, byte_00b17
		.long byte_0085e, byte_0085e, byte_0086f, byte_00880
		.long byte_00a29, byte_00a4b, byte_00a5c, byte_00b17
		.long byte_00b17, byte_00b17, byte_00b17, byte_00b17

32:		.word 0x26
		.long byte_009d4, byte_009f6, byte_00a07, byte_00b17
		.long byte_0085e, byte_0085e, byte_0086f, byte_00880
		.long byte_00a29, byte_00a4b, byte_00a5c, byte_00b17
		.long byte_00b17, byte_00b17, byte_00b17, byte_00b17

40:		.word 0x28
		.long byte_00a6d, byte_00a8f, byte_00ab1, byte_00b17
		.long byte_0085e, byte_0085e, byte_0086f, byte_00880
		.long byte_00ac2, byte_00ae4, byte_00b06, byte_00b17
		.long byte_00b17, byte_00b17, byte_00b17, byte_00b17

41:		.word 0x2a
		.long byte_00a7e, byte_00aa0, byte_00ab1, byte_00b17
		.long byte_0085e, byte_0085e, byte_0086f, byte_00880
		.long byte_00ad3, byte_00af5, byte_00b06, byte_00b17
		.long byte_00b17, byte_00b17, byte_00b17, byte_00b17

42:		.word 0x26
		.long byte_00a7e, byte_00aa0, byte_00ab1, byte_00b17
		.long byte_0085e, byte_0085e, byte_0086f, byte_00880
		.long byte_00ad3, byte_00af5, byte_00b06, byte_00b17
		.long byte_00b17, byte_00b17, byte_00b17, byte_00b17
.elseif type1R
10:		.long byte_00488, byte_00499, byte_004aa, byte_004bb
		.long byte_004cc, byte_004dd, byte_004ee, byte_004ff
.endif


dacTabs:	.long volumeTab,  volumeTab
		.long curBrightnessTab, curBrightnessTab + 9

		.fill 6, 4


.if     type1Y
byte_0062c:	.byte 0x9a, 1, 1, 0x64, 0, 0x36, 0x34, 0x61, 0x5f, 0x63, 0x80, 0x30, 0x2b, 0x34, 0x2f, 0x5e, 0x5c
byte_0063d:	.byte 0x9a, 1, 1, 0x64, 0, 0x5e, 0x5c, 0x61, 0x5f, 0x63, 0x80, 0x2e, 0x29, 0x41, 0x3c, 0x5b, 0x58
byte_0064e:	.byte 0x9a, 1, 1, 0x65, 0, 0x5f, 0x5d, 0x61, 0x5f, 0x63, 0x80, 0x2e, 0x29, 0x41, 0x3c, 0x5c, 0x59
byte_0065f:	.byte 0x9a, 4, 1, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x29, 0x24, 0x30, 0x2b, 0x80, 0x80
byte_00670:	.byte 0x9a, 4, 1, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x2a, 0x25, 0x2d, 0x28, 0x80, 0x80
byte_00681:	.byte 0x98, 0, 2, 0x44, 0, 0x41, 0x3f, 0x80, 0x80, 0x43, 0x80, 0x80, 0x80, 0x80, 0x80, 0x3f, 0x3c
byte_00692:	.byte 0x9a, 3, 1, 0x7d, 0, 0x3d, 0x3b, 0x7a, 0x78, 0x7c, 0x80, 0x30, 0x2b, 0x33, 0x2e, 0x36, 0x33
byte_006a3:	.byte 0x9a, 3, 1, 0x7d, 0, 0x5f, 0x5d, 0x7a, 0x78, 0x7c, 0x80, 0x2f, 0x2a, 0x39, 0x34, 0x5c, 0x59
byte_006b4:	.byte 0x80, 0, 1, 0x64, 0, 0x5a, 0x50, 0x80, 0x80, 0x5f, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_006c5:	.byte 0x80, 0, 1, 0x64, 0, 0x5a, 0x50, 0x80, 0x80, 0x5f, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_006d6:	.byte 0x80, 0, 2, 0x4b, 0, 0x37, 0x32, 0x80, 0x80, 0x49, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_006e7:	.byte 0x80, 0, 2, 0x4b, 0, 0x32, 0x2d, 0x80, 0x80, 0x49, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_006f8:	.byte 0x96, 0, 2, 0x80, 0, 0x46, 0x44, 0x4b, 0x49, 0x80, 0x80, 0x2a, 0x25, 0x2b, 0x26, 0x41, 0x3e
byte_00709:	.byte 0x96, 0, 2, 0x80, 0, 0x46, 0x44, 0x4b, 0x49, 0x80, 0x80, 0x2d, 0x28, 0x2f, 0x2a, 0x41, 0x3e
byte_0071a:	.byte 0x9a, 0, 1, 0x4a, 0, 0x43, 0x41, 0x47, 0x45, 0x49, 0x80, 0x2a, 0x25, 0x2b, 0x26, 0x2e, 0x2b
byte_0072b:	.byte 0x9a, 0, 1, 0x4a, 0, 0x43, 0x41, 0x47, 0x45, 0x49, 0x80, 0x2a, 0x25, 0x2d, 0x28, 0x40, 0x3d
byte_0073c:	.byte 0x9a, 2, 1, 0x68, 0, 0x61, 0x5f, 0x65, 0x63, 0x67, 0x80, 0x80, 0x80, 0x80, 0x80, 0x5e, 0x5b
byte_0074d:	.byte 0x00, 0, 0, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_0075e:	.byte 0x9a, 1, 1, 0x64, 0, 0x34, 0x32, 0x61, 0x5f, 0x63, 0x80, 0x30, 0x2b, 0x32, 0x2d, 0x5e, 0x5c
byte_0076f:	.byte 0x9a, 1, 1, 0x64, 0, 0x5e, 0x5c, 0x61, 0x5f, 0x63, 0x80, 0x2d, 0x28, 0x40, 0x3b, 0x5b, 0x58
byte_00780:	.byte 0x9a, 1, 1, 0x65, 0, 0x5f, 0x5d, 0x61, 0x5f, 0x63, 0x80, 0x2e, 0x29, 0x41, 0x3c, 0x5c, 0x59
byte_00791:	.byte 0x9a, 4, 1, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x2a, 0x25, 0x31, 0x2c, 0x80, 0x80
byte_007a2:	.byte 0x9a, 4, 1, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x29, 0x24, 0x2c, 0x27, 0x80, 0x80
byte_007b3:	.byte 0x98, 0, 2, 0x44, 0, 0x41, 0x3f, 0x80, 0x80, 0x43, 0x80, 0x80, 0x80, 0x80, 0x80, 0x3f, 0x3c
byte_007c4:	.byte 0x9a, 3, 1, 0x7d, 0, 0x3d, 0x3b, 0x7a, 0x78, 0x7c, 0x80, 0x30, 0x2b, 0x33, 0x2e, 0x36, 0x33
byte_007d5:	.byte 0x9a, 3, 1, 0x7d, 0, 0x5f, 0x5d, 0x7a, 0x78, 0x7c, 0x80, 0x2f, 0x2a, 0x39, 0x34, 0x5c, 0x59
byte_007e6:	.byte 0x80, 0, 1, 0x64, 0, 0x5a, 0x50, 0x80, 0x80, 0x5f, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_007f7:	.byte 0x80, 0, 1, 0x64, 0, 0x5a, 0x50, 0x80, 0x80, 0x5f, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_00808:	.byte 0x80, 0, 2, 0x4b, 0, 0x37, 0x32, 0x80, 0x80, 0x49, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_00819:	.byte 0x80, 0, 2, 0x4b, 0, 0x32, 0x2d, 0x80, 0x80, 0x49, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_0082a:	.byte 0x96, 0, 2, 0x80, 0, 0x46, 0x44, 0x4b, 0x49, 0x80, 0x80, 0x2a, 0x25, 0x2b, 0x26, 0x41, 0x3e
byte_0083b:	.byte 0x96, 0, 2, 0x80, 0, 0x46, 0x44, 0x4b, 0x49, 0x80, 0x80, 0x27, 0x22, 0x29, 0x24, 0x41, 0x3e
byte_0084c:	.byte 0x9a, 0, 1, 0x4a, 0, 0x43, 0x41, 0x47, 0x45, 0x49, 0x80, 0x2a, 0x25, 0x2b, 0x26, 0x2e, 0x2b
byte_0085d:	.byte 0x9a, 0, 1, 0x4a, 0, 0x43, 0x41, 0x47, 0x45, 0x49, 0x80, 0x2f, 0x2a, 0x32, 0x2d, 0x40, 0x3d
byte_0086e:	.byte 0x9a, 2, 1, 0x68, 0, 0x61, 0x5f, 0x65, 0x63, 0x67, 0x80, 0x80, 0x80, 0x80, 0x80, 0x5e, 0x5b
byte_0087f:	.byte 0x00, 0, 0, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
		.byte 0x9a, 1, 1, 0x64, 0, 0x5e, 0x5c, 0x61, 0x60, 0x62, 0x80, 0x2d, 0x2b, 0x3b, 0x35, 0x57, 0x54
		.byte 0x9a, 4, 1, 0x45, 0, 0x3d, 0x3b, 0x40, 0x3e, 0x43, 0x80, 0x2d, 0x2b, 0x34, 0x31, 0x38, 0x35
		.byte 0x98, 0, 2, 0x44, 0, 0x3d, 0x3b, 0x40, 0x3e, 0x42, 0x80, 0x27, 0x25, 0x2c, 0x28, 0x3a, 0x38
		.byte 0x9a, 3, 1, 0x7d, 0, 0x76, 0x73, 0x79, 0x77, 0x7b, 0x80, 0x2f, 0x2d, 0x38, 0x35, 0x62, 0x5f
		.byte 0x80, 0, 1, 0x64, 0, 0x5a, 0x50, 0x80, 0x80, 0x5f, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
		.byte 0x80, 0, 1, 0x64, 0, 0x5a, 0x50, 0x80, 0x80, 0x5f, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
		.byte 0x80, 0, 2, 0x4b, 0, 0x37, 0x32, 0x80, 0x80, 0x49, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
		.byte 0x80, 0, 2, 0x4b, 0, 0x32, 0x2d, 0x80, 0x80, 0x49, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
		.byte 0x96, 0, 2, 0x64, 0, 0x4b, 0x46, 0x80, 0x80, 0x5f, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
		.byte 0x9a, 0, 1, 0x64, 0, 0x41, 0x3c, 0x80, 0x80, 0x5f, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
		.byte 0x9a, 2, 1, 0x64, 0, 0x46, 0x41, 0x80, 0x80, 0x5f, 0x80, 0x80, 0x80, 0x3c, 0x37, 0x42, 0x3f
		.byte 0x00, 0, 0, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
		.byte 0x9a, 1, 1, 0x64, 0, 0x5e, 0x5c, 0x61, 0x60, 0x62, 0x80, 0x2d, 0x2b, 0x3b, 0x35, 0x57, 0x53
		.byte 0x9a, 1, 1, 0x64, 0, 0x5e, 0x5c, 0x61, 0x60, 0x62, 0x80, 0x2d, 0x2b, 0x3b, 0x35, 0x57, 0x52
.elseif type76
byte_0062c:	.byte 0x9a, 1, 1, 0x64, 0, 0x36, 0x34, 0x61, 0x5f, 0x63, 0x80, 0x2f, 0x2a, 0x34, 0x2f, 0x5e, 0x5c
byte_0063d:	.byte 0x9a, 1, 1, 0x64, 0, 0x5e, 0x5c, 0x61, 0x5f, 0x63, 0x80, 0x2b, 0x26, 0x46, 0x41, 0x5d, 0x5a
byte_0064e:	.byte 0x9a, 4, 1, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x28, 0x23, 0x31, 0x2c, 0x80, 0x80
byte_0065f:	.byte 0x9a, 4, 1, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x28, 0x23, 0x3a, 0x35, 0x80, 0x80
byte_00670:	.byte 0x98, 0, 2, 0x41, 0, 0x3e, 0x3c, 0x80, 0x80, 0x40, 0x80, 0x80, 0x80, 0x80, 0x80, 0x3c, 0x39
byte_00681:	.byte 0x9a, 3, 1, 0x7d, 0, 0x60, 0x5e, 0x7a, 0x78, 0x7c, 0x80, 0x3c, 0x37, 0x3f, 0x3a, 0x42, 0x3f
byte_00692:	.byte 0x9a, 3, 1, 0x7d, 0, 0x5e, 0x5c, 0x7a, 0x78, 0x7c, 0x80, 0x3d, 0x38, 0x40, 0x3b, 0x5b, 0x58
byte_006a3:	.byte 0x80, 0, 1, 0x64, 0, 0x5a, 0x50, 0x80, 0x80, 0x5f, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_006b4:	.byte 0x80, 0, 1, 0x64, 0, 0x5a, 0x50, 0x80, 0x80, 0x5f, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_006c5:	.byte 0x80, 0, 2, 0x4b, 0, 0x37, 0x32, 0x80, 0x80, 0x49, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_006d6:	.byte 0x80, 0, 2, 0x4b, 0, 0x32, 0x2d, 0x80, 0x80, 0x49, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_006e7:	.byte 0x96, 0, 2, 0x80, 0, 0x43, 0x41, 0x48, 0x46, 0x80, 0x80, 0x28, 0x23, 0x2b, 0x26, 0x3e, 0x3b
byte_006f8:	.byte 0x9a, 0, 1, 0x4c, 0, 0x45, 0x43, 0x49, 0x47, 0x4b, 0x80, 0x2d, 0x28, 0x2e, 0x29, 0x31, 0x2e
byte_00709:	.byte 0x9a, 0, 1, 0x4c, 0, 0x45, 0x43, 0x49, 0x47, 0x4b, 0x80, 0x2d, 0x28, 0x2e, 0x29, 0x42, 0x3f
byte_0071a:	.byte 0x9a, 2, 1, 0x67, 0, 0x60, 0x5e, 0x64, 0x62, 0x66, 0x80, 0x80, 0x80, 0x80, 0x80, 0x5d, 0x5a
byte_0072b:	.byte 0x00, 0, 0, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_0073c:	.byte 0x9a, 1, 1, 0x64, 0, 0x36, 0x34, 0x61, 0x5f, 0x63, 0x80, 0x2f, 0x2a, 0x34, 0x2f, 0x5e, 0x5c
byte_0074d:	.byte 0x9a, 1, 1, 0x64, 0, 0x5e, 0x5c, 0x61, 0x5f, 0x63, 0x80, 0x2b, 0x26, 0x46, 0x41, 0x5d, 0x5a
byte_0075e:	.byte 0x9a, 4, 1, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x28, 0x23, 0x31, 0x2c, 0x80, 0x80
byte_0076f:	.byte 0x9a, 4, 1, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x28, 0x23, 0x3a, 0x35, 0x80, 0x80
byte_00780:	.byte 0x98, 0, 2, 0x41, 0, 0x3e, 0x3c, 0x80, 0x80, 0x40, 0x80, 0x80, 0x80, 0x80, 0x80, 0x3c, 0x39
byte_00791:	.byte 0x9a, 3, 1, 0x7d, 0, 0x5e, 0x5c, 0x7a, 0x78, 0x7c, 0x80, 0x3c, 0x37, 0x3f, 0x3a, 0x42, 0x3f
byte_007a2:	.byte 0x9a, 3, 1, 0x7d, 0, 0x5e, 0x5c, 0x7a, 0x78, 0x7c, 0x80, 0x3d, 0x38, 0x40, 0x3b, 0x5b, 0x58
byte_007b3:	.byte 0x80, 0, 1, 0x64, 0, 0x5a, 0x50, 0x80, 0x80, 0x5f, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_007c4:	.byte 0x80, 0, 1, 0x64, 0, 0x5a, 0x50, 0x80, 0x80, 0x5f, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_007d5:	.byte 0x80, 0, 2, 0x4b, 0, 0x37, 0x32, 0x80, 0x80, 0x49, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_007e6:	.byte 0x80, 0, 2, 0x4b, 0, 0x32, 0x2d, 0x80, 0x80, 0x49, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_007f7:	.byte 0x96, 0, 2, 0x80, 0, 0x43, 0x41, 0x48, 0x46, 0x80, 0x80, 0x28, 0x23, 0x2b, 0x26, 0x3e, 0x3b
byte_00808:	.byte 0x9a, 0, 1, 0x4c, 0, 0x45, 0x43, 0x49, 0x47, 0x4b, 0x80, 0x2d, 0x28, 0x2e, 0x29, 0x31, 0x2e
byte_00819:	.byte 0x9a, 0, 1, 0x4c, 0, 0x45, 0x43, 0x49, 0x47, 0x4b, 0x80, 0x2d, 0x28, 0x2e, 0x29, 0x42, 0x3f
byte_0082a:	.byte 0x9a, 2, 1, 0x67, 0, 0x60, 0x5e, 0x64, 0x62, 0x66, 0x80, 0x80, 0x80, 0x80, 0x80, 0x5d, 0x5a
byte_0083b:	.byte 0x00, 0, 0, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
		.byte 0x9a, 1, 1, 0x64, 0, 0x5e, 0x5c, 0x61, 0x60, 0x62, 0x80, 0x2d, 0x2b, 0x3b, 0x35, 0x57, 0x54
		.byte 0x9a, 4, 1, 0x45, 0, 0x3d, 0x3b, 0x40, 0x3e, 0x43, 0x80, 0x2d, 0x2b, 0x34, 0x31, 0x38, 0x35
		.byte 0x98, 0, 2, 0x44, 0, 0x3d, 0x3b, 0x40, 0x3e, 0x42, 0x80, 0x27, 0x25, 0x2c, 0x28, 0x3a, 0x38
		.byte 0x9a, 3, 1, 0x7d, 0, 0x76, 0x73, 0x79, 0x77, 0x7b, 0x80, 0x2f, 0x2d, 0x38, 0x35, 0x62, 0x5f
		.byte 0x80, 0, 1, 0x64, 0, 0x5a, 0x50, 0x80, 0x80, 0x5f, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
		.byte 0x80, 0, 1, 0x64, 0, 0x5a, 0x50, 0x80, 0x80, 0x5f, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
		.byte 0x80, 0, 2, 0x4b, 0, 0x37, 0x32, 0x80, 0x80, 0x49, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
		.byte 0x80, 0, 2, 0x4b, 0, 0x32, 0x2d, 0x80, 0x80, 0x49, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
		.byte 0x96, 0, 2, 0x64, 0, 0x4b, 0x46, 0x80, 0x80, 0x5f, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
		.byte 0x9a, 0, 1, 0x64, 0, 0x41, 0x3c, 0x80, 0x80, 0x5f, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
		.byte 0x9a, 2, 1, 0x64, 0, 0x46, 0x41, 0x80, 0x80, 0x5f, 0x80, 0x80, 0x80, 0x3c, 0x37, 0x42, 0x3f
		.byte 0x00, 0, 0, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
		.byte 0x9a, 1, 1, 0x64, 0, 0x5e, 0x5c, 0x61, 0x60, 0x62, 0x80, 0x2d, 0x2b, 0x3b, 0x35, 0x57, 0x53
		.byte 0x9a, 1, 1, 0x64, 0, 0x5e, 0x5c, 0x61, 0x60, 0x62, 0x80, 0x2d, 0x2b, 0x3b, 0x35, 0x57, 0x52
.elseif type70
byte_007f8:	.byte 0x9a, 1, 1, 0x64, 0, 0x49, 0x47, 0x61, 0x5f, 0x63, 0x80, 0x2a, 0x25, 0x47, 0x42, 0x5f, 0x5d
byte_00809:	.byte 0x9a, 1, 1, 0x64, 0, 0x5f, 0x5d, 0x61, 0x5f, 0x63, 0x80, 0x2a, 0x25, 0x5c, 0x59, 0x5d, 0x5a
byte_0081a:	.byte 0x9a, 4, 1, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x2e, 0x29, 0x35, 0x30, 0x80, 0x80
byte_0082b:	.byte 0x9a, 4, 1, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x2e, 0x29, 0x80, 0x80, 0x80, 0x80
byte_0083c:	.byte 0x9a, 3, 1, 0x43, 0, 0x40, 0x3e, 0x80, 0x80, 0x42, 0x80, 0x80, 0x80, 0x80, 0x80, 0x3e, 0x3b
byte_0084d:	.byte 0x9a, 3, 1, 0x43, 0, 0x40, 0x3e, 0x80, 0x80, 0x42, 0x80, 0x80, 0x80, 0x3e, 0x3b, 0x80, 0x80
byte_0085e:	.byte 0x80, 0, 1, 0x5f, 0, 0x80, 0x80, 0x5a, 0x50, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
.if level < 0x01040000
byte_0086f:	.byte 0x80, 0, 2, 0x4f, 0, 0x37, 0x32, 0x80, 0x80, 0x4c, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_00880:	.byte 0x80, 0, 2, 0x4f, 0, 0x32, 0x2d, 0x80, 0x80, 0x4c, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
.else
byte_0086f:	.byte 0x80, 0, 2, 0x4f, 0, 0x80, 0x80, 0x37, 0x32, 0x4c, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_00880:	.byte 0x80, 0, 2, 0x4f, 0, 0x80, 0x80, 0x32, 0x2d, 0x4c, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
.endif
byte_00891:	.byte 0x96, 0, 2, 0x80, 0, 0x49, 0x47, 0x4e, 0x4c, 0x80, 0x80, 0x27, 0x22, 0x2d, 0x28, 0x44, 0x41
byte_008a2:	.byte 0x96, 0, 2, 0x80, 0, 0x49, 0x47, 0x4e, 0x4c, 0x80, 0x80, 0x27, 0x22, 0x44, 0x41, 0x80, 0x80
byte_008b3:	.byte 0x9a, 0, 1, 0x46, 0, 0x3f, 0x3d, 0x43, 0x41, 0x45, 0x80, 0x2f, 0x2a, 0x34, 0x2f, 0x37, 0x34
byte_008c4:	.byte 0x9a, 0, 1, 0x46, 0, 0x3f, 0x3d, 0x43, 0x41, 0x45, 0x80, 0x2f, 0x2a, 0x3c, 0x39, 0x80, 0x80
byte_008d5:	.byte 0x9a, 2, 1, 0x5c, 0, 0x55, 0x53, 0x59, 0x57, 0x5b, 0x80, 0x2b, 0x26, 0x32, 0x2d, 0x52, 0x4f
byte_008e6:	.byte 0x9a, 2, 1, 0x5c, 0, 0x55, 0x53, 0x59, 0x57, 0x5b, 0x80, 0x2b, 0x26, 0x52, 0x4f, 0x80, 0x80
byte_008f7:	.byte 0x9a, 1, 1, 0x64, 0, 0x45, 0x43, 0x61, 0x5f, 0x63, 0x80, 0x29, 0x24, 0x43, 0x3e, 0x5e, 0x5c
byte_00908:	.byte 0x9a, 1, 1, 0x64, 0, 0x5e, 0x5c, 0x61, 0x5f, 0x63, 0x80, 0x29, 0x24, 0x5b, 0x58, 0x5c, 0x59
byte_00919:	.byte 0x9a, 4, 1, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x2c, 0x27, 0x36, 0x31, 0x80, 0x80
byte_0092a:	.byte 0x9a, 4, 1, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x2c, 0x27, 0x80, 0x80, 0x80, 0x80
byte_0093b:	.byte 0x9a, 3, 1, 0x42, 0, 0x3f, 0x3d, 0x80, 0x80, 0x41, 0x80, 0x80, 0x80, 0x80, 0x80, 0x3d, 0x3a
byte_0094c:	.byte 0x9a, 3, 1, 0x42, 0, 0x3f, 0x3d, 0x80, 0x80, 0x41, 0x80, 0x80, 0x80, 0x3d, 0x3a, 0x80, 0x80
byte_0095d:	.byte 0x96, 0, 2, 0x80, 0, 0x48, 0x46, 0x4d, 0x4b, 0x80, 0x80, 0x27, 0x22, 0x2d, 0x28, 0x43, 0x40
byte_0096e:	.byte 0x96, 0, 2, 0x80, 0, 0x48, 0x46, 0x4d, 0x4b, 0x80, 0x80, 0x27, 0x22, 0x43, 0x40, 0x80, 0x80
byte_0097f:	.byte 0x9a, 0, 1, 0x46, 0, 0x3f, 0x3d, 0x43, 0x41, 0x45, 0x80, 0x2e, 0x29, 0x2b, 0x26, 0x2e, 0x2b
byte_00990:	.byte 0x9a, 0, 1, 0x46, 0, 0x3f, 0x3d, 0x43, 0x41, 0x45, 0x80, 0x2e, 0x29, 0x3c, 0x39, 0x80, 0x80
byte_009a1:	.byte 0x9a, 2, 1, 0x5c, 0, 0x55, 0x53, 0x59, 0x57, 0x5b, 0x80, 0x2a, 0x25, 0x33, 0x2e, 0x52, 0x4f
byte__09b2:	.byte 0x9a, 2, 1, 0x5c, 0, 0x55, 0x53, 0x59, 0x57, 0x5b, 0x80, 0x2a, 0x25, 0x52, 0x4f, 0x80, 0x80
byte_009c3:	.byte 0x9a, 1, 1, 0x64, 0, 0x34, 0x32, 0x61, 0x5f, 0x63, 0x80, 0x2f, 0x2a, 0x32, 0x2d, 0x5f, 0x5d
byte_009d4:	.byte 0x9a, 1, 1, 0x64, 0, 0x5f, 0x5d, 0x61, 0x5f, 0x63, 0x80, 0x2c, 0x27, 0x3f, 0x3a, 0x5c, 0x59
byte_009e5:	.byte 0x9a, 4, 1, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x29, 0x24, 0x30, 0x2b, 0x80, 0x80
byte_009f6:	.byte 0x9a, 4, 1, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x28, 0x23, 0x2b, 0x26, 0x80, 0x80
byte_00a07:	.byte 0x9a, 3, 1, 0x44, 0, 0x41, 0x3f, 0x80, 0x80, 0x43, 0x80, 0x80, 0x80, 0x80, 0x80, 0x3f, 0x3c
byte_00a18:	.byte 0x96, 0, 2, 0x80, 0, 0x46, 0x44, 0x4b, 0x49, 0x80, 0x80, 0x2a, 0x25, 0x2b, 0x26, 0x41, 0x3e
byte_00a29:	.byte 0x96, 0, 2, 0x80, 0, 0x49, 0x47, 0x4e, 0x4c, 0x80, 0x80, 0x27, 0x22, 0x29, 0x24, 0x41, 0x3e
byte_00a3a:	.byte 0x9a, 0, 1, 0x40, 0, 0x39, 0x37, 0x3d, 0x3b, 0x3f, 0x80, 0x2a, 0x25, 0x2b, 0x26, 0x2e, 0x2b
byte_00a4b:	.byte 0x9a, 0, 1, 0x40, 0, 0x39, 0x37, 0x3d, 0x3b, 0x3f, 0x80, 0x2e, 0x29, 0x31, 0x2c, 0x36, 0x33
byte_00a5c:	.byte 0x9a, 2, 1, 0x68, 0, 0x61, 0x5f, 0x65, 0x63, 0x67, 0x80, 0x80, 0x80, 0x80, 0x80, 0x5e, 0x5b
byte_00a6d:	.byte 0x9a, 1, 1, 0x64, 0, 0x34, 0x32, 0x61, 0x5f, 0x63, 0x80, 0x30, 0x2b, 0x32, 0x2d, 0x5f, 0x5d
byte_00a7e:	.byte 0x9a, 1, 1, 0x64, 0, 0x5f, 0x5d, 0x61, 0x5f, 0x63, 0x80, 0x2d, 0x28, 0x40, 0x3b, 0x5c, 0x59
byte_00a8f:	.byte 0x9a, 4, 1, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x2a, 0x25, 0x31, 0x2c, 0x80, 0x80
byte_00aa0:	.byte 0x9a, 4, 1, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x29, 0x24, 0x2c, 0x27, 0x80, 0x80
byte_00ab1:	.byte 0x9a, 3, 1, 0x44, 0, 0x41, 0x3f, 0x80, 0x80, 0x43, 0x80, 0x80, 0x80, 0x80, 0x80, 0x3f, 0x3c
byte_00ac2:	.byte 0x96, 0, 2, 0x80, 0, 0x46, 0x44, 0x4b, 0x49, 0x80, 0x80, 0x2a, 0x25, 0x2b, 0x26, 0x41, 0x3e
byte_00ad3:	.byte 0x96, 0, 2, 0x80, 0, 0x46, 0x44, 0x4b, 0x49, 0x80, 0x80, 0x27, 0x22, 0x29, 0x24, 0x41, 0x3e
byte_00ae4:	.byte 0x9a, 0, 1, 0x40, 0, 0x39, 0x37, 0x3d, 0x3b, 0x3f, 0x80, 0x2a, 0x25, 0x2b, 0x26, 0x2e, 0x2b
byte_00af5:	.byte 0x9a, 0, 1, 0x40, 0, 0x39, 0x37, 0x3d, 0x3b, 0x3f, 0x80, 0x2f, 0x2a, 0x32, 0x2d, 0x36, 0x33
byte_00b06:	.byte 0x9a, 2, 1, 0x68, 0, 0x61, 0x5f, 0x65, 0x63, 0x67, 0x80, 0x80, 0x80, 0x80, 0x80, 0x5e, 0x5b
byte_00b17:	.byte 0x00, 0, 0, 0x80, 0, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
.elseif type1R
byte_00488:	.byte 0x9a, 1, 1, 0x5f, 0, 0x59, 0x57, 0x5c, 0x5a, 0x5d, 0x80, 0x2e, 0x2b, 0x35, 0x2f, 0x55, 0x52
byte_00499:	.byte 0x9a, 4, 1, 0x45, 0, 0x3c, 0x3a, 0x3f, 0x3d, 0x43, 0x80, 0x2b, 0x28, 0x2f, 0x2c, 0x39, 0x36
byte_004aa:	.byte 0x98, 0, 1, 0x48, 0, 0x41, 0x3f, 0x44, 0x42, 0x46, 0x80, 0x26, 0x22, 0x2b, 0x27, 0x3e, 0x3c
byte_004bb:	.byte 0x9a, 0, 1, 0x4e, 0, 0x49, 0x48, 0x4b, 0x4a, 0x4c, 0x80, 0x2e, 0x28, 0x30, 0x2a, 0x43, 0x40
byte_004cc:	.byte 0x80, 0, 1, 0x64, 0, 0x5a, 0x50, 0x80, 0x80, 0x5f, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_004dd:	.byte 0x80, 0, 1, 0x64, 0, 0x5a, 0x50, 0x80, 0x80, 0x5f, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_004ee:	.byte 0x80, 0, 2, 0x4b, 0, 0x37, 0x32, 0x80, 0x80, 0x49, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
byte_004ff:	.byte 0x80, 0, 2, 0x4b, 0, 0x32, 0x2d, 0x80, 0x80, 0x49, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
.endif


		.align 1, -1
volumeTab:	.byte num_volumeTab
		.byte 0, 40, 56, 72, 87, 100, 112, 124, 136, 149, 163, 179, 197, 219, 255
	num_volumeTab = . - volumeTab - 1


brightnessTabsStart:
.if     type1Y || type76
brightnessTab1:	.byte 8
		.word   18,  9790, 22650, 43263, 2048, 3100, 11584, 23416
		.byte 158

brightnessTab2:	.byte 8
		.word   18,  9790, 22650, 43263, 2048, 2839,  9520, 17240
		.byte 119

brightnessTab3:	.byte 8
		.word 1816, 11330, 23939, 45311, 2048, 1549,  6441, 16475
		.byte 124
.elseif type70
brightnessTab1:	.byte 8
		.byte 0, 18, 38, 62, 88, 122, 168, 255

		.byte 8
		.byte 0, 12, 28, 45, 64,  91, 120, 158

brightnessTab2:	.byte 8
		.byte 0, 18, 38, 62, 88, 122, 168, 255

		.byte 8
		.byte 0, 11, 23, 37, 48,  67,  88, 119

brightnessTab3:	.byte 8
		.byte 7, 24, 44, 66, 93, 131, 176, 255

		.byte 8
		.byte 0,  6, 13, 25, 41,  64,  91, 124
.elseif type1R && level >= 0x01000062
brightnessTab1:
brightnessTab3:	.byte 8
		.byte 0, 18, 38, 62, 88, 122, 168, 255

		.byte 8
		.byte 0, 12, 28, 45, 64,  91, 120, 158

brightnessTab2:	.byte 8
		.byte 0, 18, 38, 62, 88, 122, 168, 255

		.byte 8
		.byte 0, 11, 23, 37, 48,  67,  88, 119
.elseif type1R
brightnessTab1:
brightnessTab2:
brightnessTab3:	.byte 8
		.byte 0, 18, 38, 62, 88, 122, 168, 255

		.byte 8
		.byte 0, 12, 28, 45, 64,  91, 120, 158
.endif
	num_brightnessTabs = (. - brightnessTabsStart) / 9 / 2


		.align 1, -1
fnTabs:		.long fnTab1, fnTab2

fnTab1:		.byte size_fnTab1
.if     type1R && level < 0x01000062
		.byte 0x03, 112, 0x03, 113, 0x03, 114, 0x03, 115	; F1, F2, F3, F4
		.byte 0x47,  80, 0x57,  81, 0x03, 118, 0x03, 119	; Home, End, F7, F8
		.byte 0x03, 120, 0x03,  77, 0x03, 122, 0x03, 123	; F9, Access, F11, F12
		.byte 0x27,  78, 0x17,  88, 0x33,  94, 0x63,  85	; Vol-, Vol+, Mute, PgUp
		.byte 0x00,   0, 0x00,   0, 0x00,   0, 0x03,  61	; __, __, __, Space
		.byte 0x03, 116						; F5
.elseif type1R && level < 0x01030071
		.byte 0x03, 112, 0x03, 113, 0x03, 114, 0x73, 115	; F1, F2, F3, F4
		.byte 0x47,  80, 0x57,  81, 0x03, 118, 0x03, 119	; Home, End, F7, F8
		.byte 0x03, 120, 0x03,  77, 0x03, 122, 0x83, 123	; F9, Access, F11, F12
		.byte 0x27,  78, 0x17,  88, 0x33,  94, 0x63,  85	; Vol-, Vol+, Mute, PgUp
		.byte 0x00,   0, 0x00,   0, 0x00,   0, 0x03,  61	; __, __, __, Space
		.byte 0x03, 116						; F5
.else
		.byte 0x03, 112, 0x03, 113, 0x03, 114, 0x73, 115	; F1, F2, F3, F4
		.byte 0x47,  80, 0x57,  81, 0x03, 118, 0x03, 119	; Home, End, F7, F8
		.byte 0x03, 120, 0x03,  77, 0x03, 122, 0x83, 123	; F9, Access, F11, F12
		.byte 0x27,  78, 0x17,  88, 0x33,  94, 0x63,  85	; Vol-, Vol+, Mute, PgUp
		.byte 0x03,  75, 0x03,  76, 0x03,  15, 0x03,  61	; Ins, Del, BS, Space
		.byte 0x03, 116, 0x03, 117, 0x03, 121, 0x03,  86	; F5, F6, F10, PgDn
.endif
	size_fnTab1 = . - fnTab1 - 1

fnTab2:		.byte size_fnTab2
		.byte 0x03, 112, 0x03, 113, 0x03, 114, 0x03, 115	; F1, F2, F3, F4
		.byte 0x47,  80, 0x57,  81, 0x03, 118, 0x03, 119	; Home, End, F7, F8
		.byte 0x03, 120, 0x03,  77, 0x03, 122, 0x03, 123	; F9, Access, F11, F12
		.byte 0x27,  75, 0x17,  76, 0x33,  15, 0x63,  85	; Ins, Del, BS, PgUp
		.byte 0x03,  78, 0x03,  88, 0x03,  94, 0x03,  61	; Vol-, Vol+, Mute, Space
		.byte 0x03, 116						; F5
.ifeq type1R && level < 0x01030071
		.byte 0x03, 117, 0x03, 121, 0x03,  86			; F6, F10, PgDn
.endif
	size_fnTab2 = . - fnTab2 - 1


		.align 1, -1
keyLocTab:	.byte   1,   2,  17,  16,  31, 110,  46,  65	; `      1      Q      Tab    A      Esc    Z      (App)
		.byte 112,   3,  18,  30,  32,  45,  47,   0	; F1     2      W      CapsLk S      (|)    X      __
		.byte 113,   4,  19, 114,  33, 115,  48,   0	; F2     3      E      F3     D      F4     C      __
		.byte   6,   5,  20,  21,  34,  35,  49,  50	; 5      4      R      T      F      G      V      B
		.byte   7,   8,  23,  22,  37,  36,  52,  51	; 6      7      U      Y      J      H      M      N
		.byte  13,   9,  24,  28,  38, 117,  53,  56	; =      8      I      ]      K      F6     ,      (/)
		.byte 119,  10,  25, 118,  39,  66,  54,  67	; F8     9      O      F7     L      ??     .      ??
		.byte  12,  11,  26,  27,  40,  41,  42,  55	; -      0      P      [      ;      '      (#)    ?
		.byte 120, 121,  14,  15,  29, 116,  43,  61	; F9     F10    ??     BS     \      F5     Enter  Space
		.byte  75, 123,  63,  59,  71,   0,   0,  89	; Ins    F12    (WinR) (WinL) ??     __     __     Right
		.byte  76, 122,  88,  78,  94,  77,   0,  84	; Del    F11    Vol+   Vol-   Mute   Access __     Down
		.byte  85,  86,   0,   0,   0,   0, 109, 111	; PgUp   PgDn   __     __     __     __     Back   Forward
		.byte  80,  81,  73,  72, 107,  83, 126,  79	; Home   End    ??     ??     ??     Up     Pause  Left
		.byte   0, 124, 125,   0,   0,  60,   0,  62	; __     PrtSc  ScrLk  __     __     AltL   __     AltR
		.byte   0,   0,   0,  44,   0,   0,  57,   0	; __     __     __     ShiftL __     __     ShiftR __
		.byte  58,   0,   0,   0,   0,   0,  64,   0	; CtrlL  __     __     __     __     __     CtrlR  __

		.byte   0,   0,   0,   0,   0,  74,   0,   0	; __     __     __     __     __     ??     __     __

		.align 1, -1
volAccKeyTab:	.octa 0x000000000000000000003c0000000000	; Vol+, Vol-, Mute, Access
		.byte 0x00

		.align 1, -1
delayTab:	.word  500
		.word  250
		.word 1000
		.word  500

		.align 1, -1
fanLevelTab:	.byte num_fanLevelTab
		.byte 0, 1, 1, 2, 2, 2, 3, 3
	num_fanLevelTab = . - fanLevelTab - 1


.if     type1Y
		.align 1, -1
50:		.byte 4
		.word 8972, 58382, 42512, 19071

		.align 1, -1
51:		.byte 4
		.word 9740, 58383, 53778, 18559

		.align 1, -1
52:		.byte 4
		.word 9740, 58383, 53778, 18559

		.align 1, -1
60:		.byte 4
		.word 8972,  7181, 31247, 53887

		.align 1, -1
61:		.byte 4
		.word 9740,  7183, 30737, 53375

		.align 1, -1
62:		.byte 4
		.word 9740,  7183, 30737, 53375
.elseif type76
		.align 1, -1
50:		.byte 4
		.word 8972, 58381, 33807, 53887

		.align 1, -1
51:		.byte 4
		.word 9740, 58383,  2577, 40575

		.align 1, -1
52:		.byte 4
		.word 9740, 58383,  2577, 40575

		.align 1, -1
60:		.byte 4
		.word 8972, 58381, 33807, 41087

		.align 1, -1
61:		.byte 4
		.word 9740, 58383, 10257, 48255

		.align 1, -1
62:		.byte 4
		.word 9740, 58383, 10257, 48255
.elseif type70
		.align 1, -1
50:		.byte 4
		.word 8972, 32781, 31246, 63103

		.align 1, -1
51:		.byte 4
		.word 9741, 31246, 62993, 12415

		.align 1, -1
52:		.byte 4
		.word 9741, 31246, 62993, 12415

		.align 1, -1
60:		.byte 4
		.word 8972, 32781, 38926, 63103

		.align 1, -1
61:		.byte 4
		.word 9741, 38926, 62992, 52351

		.align 1, -1
62:		.byte 4
		.word 9741, 38926, 62992, 52351

		.align 1, -1
70:		.byte 4
		.word 8971, 47117, 31247, 38527

		.align 1, -1
71:		.byte 4
		.word 9739, 47119,  7697, 22655

		.align 1, -1
72:		.byte 4
		.word 9739, 47119,  7697, 22655

		.align 1, -1
80:		.byte 4
		.word 8971, 47117,  8207, 23167

		.align 1, -1
81:		.byte 4
		.word 9739, 47118, 50193, 14975

		.align 1, -1
82:		.byte 4
		.word 9739, 47118, 50193, 14975
.elseif type1R
		.align 1, -1
50:		.byte 4
		.word   11, 47118,  4111, 61567
.endif


		.align 1, -1
byte_00b16:	.byte 8
		.byte 0, 34, 42, 80, 57, 85, 60, 44

		.align 1, -1
byte_00b20:	.byte 8
		.align 1, 0x77
		.word    0,  -1			; 0
		.word    0,  -1			; 1
		.word   30,  -1			; 2
		.word   -1,   5			; 3
		.word 1800,  30			; 4
.if level < 0x01000062
		.word 2700,  60			; 5
.else
		.word   -1,  60			; 5
.endif
		.word   -1,  80			; 6
		.word   -1, 100			; 7

.ifeq type1R && level < 0x01030071
long_00b42:	.ascii "Z75L"			; 0 
		.ascii "Z75M"			; 1 
		.ascii "Z7SN"			; 2 
		.ascii "Z75S"			; 3 
		.ascii "Z75T"			; 4 
		.ascii "Z7SR"			; 5 
		.ascii "Z75X"			; 6 
		.ascii "Z7EG"			; 7 
		.ascii "Z7SV"			; 8 
		.long 0				; 9
.endif

; ==============================================

		.org 0x001000, -1
codeStart:
checkSums:	mov	#off_01038, er1

loc_01006:	mov	@er1+, er2
		cmp	#-1, er2
		beq	loc_0102a

		mov	@er1+, er3
		zero	er4

loc_0101a:	mov	@er2+, r5
		add	r5, r4
		cmp	er2, er3
		bne	loc_0101a

		cmp	#0, r4
		bne	loc_0102a

		bra	loc_01006

loc_0102a:	cmp	#0, r4
		beq	loc_01034

		set	c
		bra	loc_01036

loc_01034:	clr	c

loc_01036:	jmp	@er0

off_01038:	.long ROM
		.long dataStart
		.long codeStart
		.long ROMend
		.long -1

; ----------------------------------------------

checkHiRAM:	mov	#off_010ba, er7		; High Internal RAM Start
		bra	loc_0105a

checkLoRAM:	mov	#off_010b2, er7		; Low Internal RAM Start

loc_0105a:	mov	#0, r3
		mov	@er7, er4
		mov	@(4,er7), er2		; RAM End

loc_01068:	mov	r3, @-er2
		cmp	er2, er4
		bne	loc_01068

		mov	#testpatterns,	er6

loc_01074:	mov	r3l, r3h
		mov	@er6+, r3l
		mov	#loc_01080, er1
		bra	checkPattern		; RAM Start

loc_01080:	bcs	loc_0108c

		mov	#off_010b2, er2		; Low Internal RAM Start
		cmp	er2, er6
		bne	loc_01074

loc_0108c:	jmp	@er0

; ----------------------------------------------

checkPattern:	mov	@er7, er2
		mov	@(4,er7), er4		; RAM End

loc_01098:	mov	@er2, r5h
		mov	r3l, @er2
		cmp	r3h, r5h
		bne	loc_010aa

		adds	#1, er2
		cmp	er4, er2
		bne	loc_01098

		clr	c
		jmp	@er1

loc_010aa:	set	c
		jmp	@er1

testpatterns:	.byte 0b10101010, 0b01010101, 0b11111111, 0b00000000

off_010b2:	.long RAM     & M24		; Low Internal RAM Start
		.long RAMend  & M24		; Low Internal RAM End
off_010ba:	.long RAM8    & M24		; High Internal RAM Start
		.long RAM8end & M24		; High Internal RAM End

; ----------------------------------------------

clearRAM:	mov	#0, r2
		mov	#stack, er3
		mov	#RAMend & M24, er4	; Low Internal RAM End

loc_010d2:	mov	r2, @er3
		adds	#2, er3
		cmp	er3, er4
		bne	loc_010d2

		mov	#RAM8 & M24, er3	; High Internal RAM Start
		mov	#RAM8end & M24, er4	; High Internal RAM End

loc_010e6:	mov	r2, @er3
		adds	#2, er3
		cmp	er3, er4
		bne	loc_010e6

		jmp	@er0

; ----------------------------------------------

		.global reset
reset:		mov	#loc_010fa, er6
		jmp	nop1

loc_010fa:	mov	#buildid2, r0		; # of build id (e.g. .ascii "28")
		mov	@byte_ffe080, r1	; # of build id in RAM
		cmp	r0, r1
		bne	loc_01124

		mov	#loc_01112, er0
		jmp	clearRAM

loc_01112:	mov	#80000, er0		; 80000 * 5 states @ 10 MHz = 40 ms

delay:		nop
		nop
		dec	#1, er0
		bne	delay

		bra	loc_0118e:16

loc_01124:	mov	#loc_0112e, er0
		jmp	checkSums

loc_0112e:	mov	#1, r0h
		bcs	loc_0114a

		mov	#loc_0113c, er0
		jmp	checkLoRAM

loc_0113c:	bcs	loc_01148

		mov	#loc_01148, er0
		jmp	checkHiRAM

loc_01148:	mov	#2, r0h

loc_0114a:	bcs	loc_01158

		mov	@mdcr:8, r0h		; Mode Control Register
		and	#3, r0h
		cmp	#2, r0h			; Advanced Mode, ROM Enabled
		beq	loc_01158

		mov	#3, r0h			; Assume Normal Mode
		set	c

loc_01158:	bcc	advanced

		b clr	mstpcrl.mstp0		; LPC, WUEMRB (Module Stop Control Register L)
		b set	hicr_0.lpc1e		; LPC Channel 1 Enable (0x60/0x64) (LPC Host Interface Control Register 0)
		mov	#0xfc, r0h
		mov	r0h, @odr2		; LPC Output Data Register 2 (0x62)

loc_0116a:	b tst	str2.ibf2		; Input Buffer Full (LPC Status Register 2 (0x66))
		beq	loc_01182

		mov	@idr2, r0h		; LPC Input Data Register 2 (0x62/0x66)

		cmp	#0xff, r0h
		bne	loc_01182

		b set	mstpcrl.mstp0		; LPC, WUEMRB (Module Stop Control Register L)
		bra	reset:16

loc_01182:	bra	loc_0116a

advanced:	mov	#buildid2, r0		; # of build id (e.g. .ascii "28")
		mov	r0, @byte_ffe080	; # of build id in RAM

loc_0118e:	mov	@rts_0126c, r0		; the program code for 'rts'
		mov	r0, @hook		; initially contains 0x5470 (rts)
		mov	#stack, sp
		jsr	sub_0eb2c

		mov	#0, r0h
		mov	#0x0f, r0l
		mov	#taskQueueIdx, er1

loc_011ae:	mov	r0h, @-er1
		dec	r0l
		bne	loc_011ae

		mov	#seq0Init, r0
		bsr	doTaskSeq:16

		mov	#0, r0h
		mov	#0, r0l

loc_011c0:	b ld	pb2pin			; Pin PB2/-WUE2/-CS3 (Port B Input Data Register)
		bxor	#0, r0l
		bcc	loc_011d0

		mov	#0, r0h
		bild	#0, r0l
		bst	#0, r0l
		bra	loc_011d2

loc_011d0:	inc	r0h

loc_011d2:	cmp	#0x20, r0h
		blo	loc_011c0

		btst	#0, r0l
		bne	loc_011e6

		mov	#seq3, r0h
		mov	r0h, @taskSeqOffset
		bra	loc_0128a:16


loc_011e6:	mov	#seq1InitA, r0
		bsr	doTaskSeq

		mov	#7, r0h
		jsr	sub_06968

		mov	#seq1, r0h
		mov	r0h, @taskSeqOffset
		bra	loc_0128a:16

; ----------------------------------------------

sub_011fe:	mov	#seq3Init, r0
		mov	#seq3, r1h

loc_01204:	extu	er0
		mov	r1h, @taskSeqOffset
		mov	#stack, sp
		bsr	doTaskSeq

		bra	loc_0128a


sub_01216:	mov	#seq2Init, r0
		mov	#seq2, r1h
		bra	loc_01204


sub_0121e:	mov	#seq1InitB, r0

loc_01222:	mov	#seq1, r1h
		bra	loc_01204


		mov	#seq1InitA, r0
		bra	loc_01222

; ----------------------------------------------

doTaskSeq:	push	er0
		jsr	hook

		pop	er0
		mov	#taskSeqTab, er1
		exts	er0
		add	er1, er0
		mov	@er0+, er1
		mov	@er0+, er0
		sub	er1, er0
		shlr	#2, er0			; # of entries

taskLoop0:	cmp	#0, r0l
		beq	rts_0126c

		mov	@er1+, er2
		push	er0
		push	er1
		jsr	@er2

		pop	er1
		pop	er0
		dec	r0l
		bra	taskLoop0

rts_0126c:	rts

; ----------------------------------------------

sub_0126e:	mov	#seq3, r0h
		bra	loc_01278


sub_01272:	mov	#seq2, r0h
		bra	loc_01278


sub_01276:	mov	#seq1, r0h

loc_01278:	mov	@taskSeqOffset, r0l
		cmp	r0h, r0l
		bne	loc_01286

		clr	c
		bra	rts_01288

loc_01286:	set	c

rts_01288:	rts


loc_0128a:	bsr	initScheduler:16

		zero	er0
		mov	@taskSeqOffset, r0l
		cmp	#seq2, r0l
		beq	loc_012a0

		cmp	#seq3, r0l
		bne	loc_012a6

loc_012a0:	bset	#6, @byte_ffff00:8
		bra	loc_012aa

loc_012a6:	bclr	#6, @byte_ffff00:8

loc_012aa:	add	#taskSeqTab, er0
		mov	@er0, er0
		subs	#4, er0
		push	er0
		zero	er2
		mov	er2, @long_ffe868
		mov	er2, @long_ffe86c

mainLoop:	mov	@word_ffe870, er1
		inc	#1, er1
		mov	er1, @word_ffe870
		jsr	hook

		bsr	runTasks:16

		mov	@sp, er0		; pop+push er0
		mov	#taskQueueIdx, er1

taskLoop:	mov	@er1, r2l
		beq	loc_01342

		exts	r2
		exts	er2
		add	er2, er1
		shll	#2, er2
		add	er2, er0
		mov	@er0, er2
		stm	er0-er1, @-sp
		jsr	@er2

		ldm	@sp+, er0-er1
		btst	#6, @byte_ffff00:8
		beq	loc_01340

		stc	ccr, r2h
		mov	er1, er3
		sub	#taskQueueIdx, er3
		dec	r3l
		zero	er4
		mov	r3l, r4l
		shlr	#2, r4l
		shlr	r4l
		add	#long_ffe868, er4
		and	#7, r3l
		ldc	r2h, ccr
		bcc	loc_0133c

		bset	r3l, @er4
		bra	loc_01340

loc_0133c:	bclr	r3l, @er4

loc_01340:	bra	taskLoop

loc_01342:	btst	#6, @byte_ffff00:8
		beq	loc_01376

		mov	@long_ffe868, er2
		bne	loc_01376

		mov	@long_ffe86c, er2
		bne	loc_01376

		jsr	sub_0eb4e

		bcc	loc_01376

		mov	#seqSleep1, r0
		bsr	doTaskSeq:16

		jsr	sleep

		mov	#seqSleep2, r0
		bsr	doTaskSeq:16

loc_01376:	bra	mainLoop:16

; ----------------------------------------------

initScheduler:	mov	#0, r0h
		mov	r0h, @taskQueueIdx
		mov	#taskQueue, er0
		mov	#0x80, r1h
		mov	#0x40, r1l

clearQueue:	mov	r1h, @er0
		adds	#1, er0
		dec	r1l
		bne	clearQueue

		zero	er0
		mov	@taskSeqOffset, r0l
		add	#taskSeqTab, er0
		mov	@er0+, er1
		mov	@er0, er2
		mov	#taskEnabledBitVec, er3
		mov	#0, r4l
		mov	r4l, @er3

loc_013b6:	mov	@er1+, er0
		beq	loc_013c0		; NULL pointer

		bset	r4l, @er3

loc_013c0:	inc	r4l
		cmp	#8, r4l
		bne	loc_013cc

		mov	#0, r4l
		adds	#1, er3
		mov	r4l, @er3

loc_013cc:	cmp	er2, er1
		bne	loc_013b6

		mov	@taskEnabledBitVec + 0, er0
		mov	@taskEnabledBitVec + 4, er1
		mov	er0, @backTaskReadyBitVec + 0
		mov	er1, @backTaskReadyBitVec + 4
		bset	#5, @byte_ffff00:8
		rts

; ----------------------------------------------

runTasks:	bsr	runFrontTask

		bsr	runBackTask

		rts

; ----------------------------------------------

runBackTask:	btst	#5, @byte_ffff00:8
		beq	rts_01414

		bclr	#5, @byte_ffff00:8
		mov	#backTaskReadyBitVec, er0
		mov	#sub_01472, er1
		bsr	sub_01436

rts_01414:	rts

; ----------------------------------------------

runFrontTask:	btst	#4, @byte_ffff00:8
		beq	rts_0142e

		bclr	#4, @byte_ffff00:8
		mov	#frontTaskReadyBitVec, er0
		mov	#sub_0149c, er1
		bsr	sub_01436

rts_0142e:	rts

; ----------------------------------------------

.if !type1R
sub_01430:	bclr	#6, @byte_ffff00:8
		rts
.endif

; ----------------------------------------------

sub_01436:	mov	er1, er3
		mov	#0, r1h

loc_0143a:	mov	#8, r1l

loc_0143c:	mov	#0, r2l
		set	i
		mov	@er0, r2h
		mov	r2l, @er0
		clr	i
		adds	#1, er0
		mov	r2h, r2l
		beq	loc_01466

		mov	#8, r2l

loc_0144e:	inc	r1h
		shlr	r2h
		bcc	loc_01460

		stm	er0-er3, @-sp
		mov	r1h, r0h
		jsr	@er3

		ldm	@sp+, er0-er3

loc_01460:	dec	r2l
		bne	loc_0144e

		bra	loc_01468

loc_01466:	add	#8, r1h

loc_01468:	dec	r1l
		bne	loc_0143c

		cmp	#0x40, r1h
		blo	loc_0143a

		rts

; ----------------------------------------------

sub_01472:	mov	#taskQueueIdx, er1
		bsr	sub_014be

		bcc	rts_0149a

		mov	@taskQueueIdx, r3l
		beq	loc_01486

		sub	r0h, r3l

loc_01486:	mov	r0h, @taskQueueIdx
		zero	er4
		mov	r0h, r4l
		add	#taskQueueIdx, er4
		mov	r3l, @er4

rts_0149a:	rts

; ----------------------------------------------

sub_0149c:	mov	#taskQueueIdx, er1
		bsr	sub_014be

		bcs	rts_014bc

		mov	@er1, r2l
		exts	r2
		exts	er2
		mov	er1, er3
		add	er2, er3
		mov	@er3, r4l
		beq	loc_014b6

		add	r2l, r4l

loc_014b6:	mov	r4l, @er1
		mov	#0x80, r0h
		mov	r0h, @er3

rts_014bc:	rts

; ----------------------------------------------

sub_014be:	mov	#0, r0l

loc_014c0:	mov	@er1, r2l
		bne	loc_014c8

		set	c
		bra	rts_014da

loc_014c8:	add	r2l, r0l
		cmp	r0h, r0l
		bne	loc_014d2

		clr	c
		bra	rts_014da

loc_014d2:	exts	r2
		exts	er2
		add	er2, er1
		bra	loc_014c0

rts_014da:	rts

; ----------------------------------------------

schedBackTask:		; r0h: task offset
		mov	#backTaskReadyBitVec, er2
		bset	#5, @byte_ffff00:8

loc_014e6:	shlr	#2, r0h
		zero	er1
		mov	r0h, r1l
		shlr	#2, r1l
		shlr	r1l
		and	#7, r0h
		add	er1, er2
		add	#taskEnabledBitVec, er1
		btst	r0h, @er1
		beq	rts_01506

		bset	r0h, @er2

rts_01506:	rts


schedFrontTask:		; r0h: task offset
		mov	#frontTaskReadyBitVec, er2
		bset	#4, @byte_ffff00:8
		bra	loc_014e6

; ----------------------------------------------

taskSeqTab:
	seq0Init   = . - taskSeqTab
		.long taskSeq0Init		; 0x00 (after reset)
	seq1InitA  = . - taskSeqTab
		.long taskSeq1InitA		; 0x04
	seq1       = . - taskSeqTab
		.long taskSeq1			; 0x08
	seq2Init   = . - taskSeqTab
		.long taskSeq2Init		; 0x0c
	seq2       = . - taskSeqTab
		.long taskSeq2			; 0x10
	seq1InitB  = . - taskSeqTab
		.long taskSeq1InitB		; 0x14
	seq3Init   = . - taskSeqTab
		.long taskSeq3Init		; 0x18
	seq3       = . - taskSeqTab
		.long taskSeq3			; 0x1c
	seqSleep1  = . - taskSeqTab
		.long taskSeqSleep		; 0x20 before sleep
	seqSleep2  = . - taskSeqTab
		.long taskSeqSleep		; 0x24 after sleep
		.long taskSeqsEnd		; 0x28 tab end

; ----------------------------------------------

.if type1R
fovi:
irq6_irq7:
.endif
rte:		rte				; Return from Exception

; ----------------------------------------------

sub_01542:	mov	#0x40, r0l
		mov	#task00o, r0h
		mov	r0h, @byte_ffe3a3
		mov	#byte_ffe3a4, er1
		mov	#0x80, r0h

loc_01554:	mov	r0h, @er1
		adds	#1, er1
		dec	r0l
		bne	loc_01554

		rts

; ----------------------------------------------

task00:		mov	#word_ffe872, er1
		mov	#byte_ffe3a3, er2

loc_0156a:	mov	@er2, r0l
		beq	loc_015e8

		exts	r0
		exts	er0
		mov	er0, er3
		shal	er3
		add	er1, er3
		mov	@er3, r4
		stm	er0-er3, @-sp
		mov	r4, r0
		jsr	cmpTick

		ldm	@sp+, er0-er3
		bcc	loc_015b4

		mov	er2, er3
		add	er0, er3
		mov	@er3, r4h
		beq	loc_01594

		add	r0l, r4h

loc_01594:	mov	r4h, @er2
		mov	#0x80, r4h
		mov	r4h, @er3
		sub	#byte_ffe3a3, er3
		dec	r3l
		stm	er0-er3, @-sp
		mov	r3l, r0h
		shll	#2, r0h
		jsr	schedBackTask

		ldm	@sp+, er0-er3
		bra	loc_015e6

loc_015b4:	mov	@er3, r3
		mov	@tick, r4
		cmp	r3, r4
		bhs	loc_015c4

		sub	r4, r3
		bra	loc_015ca

loc_015c4:	not	r4
		inc	#1, r4
		add	r4, r3

loc_015ca:	mov	r3, r4
		beq	loc_015e4

		stm	er0-er3, @-sp
		mov	#0, r0h
		mov	r3, r0
		jsr	sub_034c2

		mov	#task00o, r0h
		jsr	schedFrontTask

		ldm	@sp+, er0-er3

loc_015e4:	bra	loc_015f4

loc_015e6:	bra	loc_015f0

loc_015e8:	mov	#task00o, r0h
		jsr	schedFrontTask

		bra	loc_015f4

loc_015f0:	bra	loc_0156a:16

loc_015f4:	clr	c
		rts

; ----------------------------------------------

schedBackTaskDelayed:	; r0h: task offset, r1: delay in ms
		shlr	#2, r0h
		inc	r0h
		stm	er0-er1, @-sp
		bsr	checkSchedTaskI:16

		mov	er1, er2
		ldm	@sp+, er0-er1
		bcs	loc_01622

		mov	@er2, r3l
		exts	r3
		exts	er3
		mov	er3, er4
		add	er2, er4
		mov	@er4, r0l
		beq	loc_0161c

		add	r3l, r0l

loc_0161c:	mov	r0l, @er2
		mov	#0x80, r0l
		mov	r0l, @er4

loc_01622:	mov	r1, r2
		bne	loc_01632

		dec	r0h
		shll	#2, r0h
		jsr	schedBackTask

		bra	rts_016a4:16

loc_01632:	mov	#byte_ffe3a3, er2
		zero	er3
		mov	r0h, r3l
		add	er3, er2
		shll	er3
		add	#word_ffe872, er3
		mov	@tick, r0
		add	r1, r0
		mov	r0, @er3
		push	er2
		mov	#byte_ffe3a3, er1
		mov	#word_ffe872, er2

loc_01662:	mov	@er1, r3l
		beq	loc_01686

		exts	r3
		exts	er3
		mov	er3, er4
		shal	er4
		add	er4, er2
		mov	@er2, r4
		cmp	r0, r4
		blo	loc_0167c

		sub	r0, r4
		bpl	loc_01686

		bra	loc_01682

loc_0167c:	mov	r0, r5
		sub	r4, r5
		bmi	loc_01686

loc_01682:	add	er3, er1
		bra	loc_01662

loc_01686:	pop	er2
		mov	@er1, r0l
		beq	loc_01696

		exts	r0
		exts	er0
		add	er1, er0
		sub	er2, er0

loc_01696:	mov	er2, er3
		sub	er1, er3
		mov	r3l, @er1
		mov	r0l, @er2
		mov	#task00o, r0h
		jsr	schedBackTask

rts_016a4:	rts

; ----------------------------------------------

checkSchedTaskI:	; r0h: task index
		mov	#byte_ffe3a3, er1
		jmp	sub_014be


checkSchedTask:		; r0h: task offset
		shlr	#2, r0h
		inc	r0h
		bra	checkSchedTaskI

; ----------------------------------------------

sub_016b6:	mov	#task00o, r0h
		jmp	schedBackTask

; ----------------------------------------------

cmpTick:	mov	@tick, r1

loc_016c2:	cmp	r0, r1
		blo	loc_016ca

		sub	r0, r1
		bra	loc_016d2

loc_016ca:	mov	#0xffff, r2
		sub	r0, r2
		add	r2, r1

loc_016d2:	mov	#0x7fff, r2
		mov	r1, r0
		cmp	r2, r1
		rts


sub_016dc:	mov	@word_ffe9bc, r1
		bra	loc_016c2


sub_016e4:	mov	@word_ffe9be, r1
		bra	loc_016c2

; ----------------------------------------------

parity:		clr	c
		bxor	#0, r0h
		bxor	#1, r0h
		bxor	#2, r0h
		bxor	#3, r0h
		bxor	#4, r0h
		bxor	#5, r0h
		bxor	#6, r0h
		bxor	#7, r0h
		rts

; ----------------------------------------------

delay25:	mov	#25, r0h		;  25 * 10 states @ 10 MHz =  25 탎
		bra	busywait

delay50:	mov	#50, r0h		;  50 * 10 states @ 10 MHz =  50 탎
		bra	busywait

delay100:	mov	#100, r0h		; 100 * 10 states @ 10 MHz = 100 탎

busywait:	nop
		nop
		nop
		nop
		nop
		nop
		nop
		dec	r0h
		bne	busywait

		rts

; ----------------------------------------------

; 13.1 ms @ 10 MHz

setWaitTime1:	b set	sbycr.sts2		; Standby Timer Select 2 (Standby Control Register)
		b clr	sbycr.sts1		; Standby Timer Select 1 (Standby Control Register)
		b clr	sbycr.sts0		; Standby Timer Select 0 (Standby Control Register)
		bsr	sub_01970:16

		rts

; ----------------------------------------------

sub_01730:	mov	#100, r0
		mov	@tick, r1
		add	r1, r0
		mov	r0, @tock
		rts

; ----------------------------------------------

task01:		mov	@P2DDRcopy, r0h
		btst	#4, r0h
		beq	loc_0179c

		b ild	p24dr			; Pin P24/PW12 (Port 2 Data Register)
		bcc	loc_0179c

		b ild	p94dr			; Pin P94/-IOW (Port 9 Data Register)
		bcc	loc_0176e

		mov	#100, r0
		mov	@tick, r1
		add	r1, r0
		mov	r0, @tock
		bra	loc_01798

loc_0176e:	mov	@tock, r0
		jsr	cmpTick

		bcc	loc_01798

		push	er0
		stc	ccr, r0l
		set	i
		mov	@P2DDRcopy, r0h
		bclr	#4, r0h			; p24ddr = 0
		mov	r0h, @P2DDRcopy
		mov	r0h, @p2ddr:8		; Port 2 Data Direction Register
		ldc	r0l, ccr
		pop	er0

loc_01798:	set	c
		bra	rts_0179e

loc_0179c:	clr	c

rts_0179e:	rts

; ----------------------------------------------

sub_017a0:	push	er0
		stc	ccr, r0l
		set	i
		b clr	p24dr			; Pin P24/PW12 (Port 2 Data Register)
		mov	@P2DDRcopy, r0h
		bset	#4, r0h			; p24ddr = 1
		mov	r0h, @P2DDRcopy
		mov	r0h, @p2ddr:8		; Port 2 Data Direction Register
		ldc	r0l, ccr
		pop	er0
		jmp	sub_011fe

; ----------------------------------------------

sub_017c6:	push	er0
		stc	ccr, r0l
		set	i
		b clr	pb1odr			; Pin PB1/-WUE1/HIRQ4/LSCI (Port B Output Data Register)
		mov	@PBDDRcopy, r0h
		bset	#1, r0h
		mov	r0h, @PBDDRcopy
		mov	r0h, @pbddr:8		; Port B Data Direction Register
		ldc	r0l, ccr
		pop	er0
		rts

; ----------------------------------------------

setupPB1DDRin:	push	er0
		stc	ccr, r0l
		set	i
		mov	@PBDDRcopy, r0h
		bclr	#1, r0h			; pb1ddr = 0
		mov	r0h, @PBDDRcopy
		mov	r0h, @pbddr:8		; Port B Data Direction Register
		ldc	r0l, ccr
		pop	er0
		rts

; ----------------------------------------------

sub_0180a:	jsr	sub_05704

		jsr	sub_0535a

		jsr	sub_05cf6

		rts

; ----------------------------------------------

sub_01818:	jsr	sub_035d4

		jsr	sub_056f4

		jsr	sub_0537c

		jsr	sub_05d14

		jsr	sub_02ee6

		rts

; ----------------------------------------------

loc_0182e:	mov	#0, r3h

loc_01830:	mov	@er0+, er1
		beq	loc_01840

		mov	@er0+, er2
		sub	er1, er2
		add	r2l, r3h
		bra	loc_01830

loc_01840:	mov	r3h, r0h
		set	c
		rts

; ----------------------------------------------

loc_01846:	mov	er0, @long_ffe8f8
		mov	@er0, er1
		mov	er1, @long_ffe8fc
		jsr	sub_01862

		set	c
		rts

; ----------------------------------------------

sub_01862:	mov	@long_ffe8fc, er1
		mov	@er1+, r0h

loc_0186c:	mov	@long_ffe8f8, er2
		mov	@(4,er2), er3
		cmp	er3, er1
		blo	loc_018a2

		add	#8, er2
		mov	@er2, er1
		beq	loc_0189e

		mov	er1, @long_ffe8fc
		mov	er2, @long_ffe8f8
		clr	c
		bra	loc_018a0

loc_0189e:	set	c

loc_018a0:	bra	rts_018ac

loc_018a2:	mov	er1, @long_ffe8fc
		clr	c

rts_018ac:	rts


loc_018ae:	mov	er1, @long_ffe8f8
		mov	@er1, er1
		mov	er1, @long_ffe8fc
		jsr	sub_018ca

		set	c
		rts

; ----------------------------------------------

sub_018ca:	mov	@long_ffe8fc, er1
		mov	r0h, @er1
		adds	#1, er1
		bra	loc_0186c

		mov	r0h, r1l
		mov	#0, r1h
		mov	#100, r2h
		divxu	r2h, r1
		mov	r1l, r0h
		mov	#10, r2h
		mov	r1h, r1l
		mov	#0, r1h
		divxu	r2h, r1
		shll	r1l
		shll	r1l
		shll	r1l
		shll	r1l
		or	r1l, r1h
		mov	r1h, r0l
		rts

; ----------------------------------------------

		rts

; ----------------------------------------------

		mov	#0, r0h
		rts

; ----------------------------------------------

		.macro	setDDR  bit port out level
.if 0x\port <> 7
		mov	#0x\port << 8 | 1 << 7 | \level << 6 | \bit, r0
.if !\out
		and	#7, r0l
.endif
.if 0x\port > 9
		mov	#p\port\()odr, r1
.else
		mov	#p\port\()dr, r1
.endif
		mov	#p\port\()ddr, r2
.else
		mov	#0x\port << 8 | 0 << 7 | \level << 6 | \bit, r0
		mov	#0, r1
		mov	#0, r2
.endif
		jsr	sub_018fe
		.endm


		.macro	setInL  port bit
		setDDR	\bit \port 0 0
		.endm

		.macro	setInH  port bit
		setDDR	\bit \port 0 1
		.endm

		.macro	setOutL  port bit
		setDDR	\bit \port 1 0
		.endm

		.macro	setOutH  port bit
		setDDR	\bit \port 1 1
		.endm


sub_018fe:	cmp	#0, r0h
		beq	rts_0195c

		cmp	#0x10, r0h
		bhi	rts_0195c

		mov	r2, r3
		beq	rts_0195c

		mov	#-1 >> 16, e1
		mov	e1, e2
		mov	#P1DDRcopy, er3
		dec	r0h
		add	r0h, r3l
		addx	#0, r3h
		bcc	loc_01920

		inc	#1, e3

loc_01920:	mov	r0l, r0h
		and	#7, r0h
		stc	ccr, r4h
		set	i
		btst	#7, r0l
		beq	loc_01944

		btst	#6, r0l
		bne	loc_01936

		bclr	r0h, @er1
		bra	loc_0193a

loc_01936:	bset	r0h, @er1

loc_0193a:	mov	@er3, r4l
		bset	r0h, r4l
		mov	r4l, @er3
		mov	r4l, @er2
		bra	loc_0195a

loc_01944:	mov	@er3, r4l
		bclr	r0h, r4l
		mov	r4l, @er3
		mov	r4l, @er2
		btst	#6, r0l
		bne	loc_01956

		bclr	r0h, @er1
		bra	loc_0195a

loc_01956:	bset	r0h, @er1

loc_0195a:	ldc	r4h, ccr

rts_0195c:	rts

; ----------------------------------------------

switch_er1_r0h: zero	e0
		mov	r0h, r0l
		mov	#0, r0h
		shll	r0
		add	er1, er0
		mov	@er0, r1
		exts	er1
		add	er1, er0
		jmp	@er0

; ----------------------------------------------

sub_01970:	mov	#ramFreeArea, er0
		mov	er0, @ramFreeLevel
		rts

; ----------------------------------------------

malloc:		mov	#RAMend & M24, er1
		mov	@ramFreeLevel, er2
		sub	er2, er1
		btst	#0, r0l
		beq	loc_01996

		inc	#1, r0			; round up to word size

loc_01996:	cmp	r1, r0
		bhi	nomem

		push	er2
		mov	#0, e0
		add	er0, er2
		mov	er2, @ramFreeLevel
		pop	er0
		clr	c
		bra	rts_019ba

nomem:		zero	er0
		set	c

rts_019ba:	rts

; ----------------------------------------------

initPorts1:	setOutL 2 0			; Pin P20/PW8
		setOutL 2 1			; Pin P21/PW9
		setOutL 2 2			; Pin P22/PW10

		bset	#1, @byte_ffff05:8
		bclr	#1, @byte_ffff02:8
		bset	#2, @byte_ffff05:8
		bclr	#2, @byte_ffff02:8
		bset	#4, @byte_ffff04:8
		bset	#4, @byte_ffff01:8
		bset	#5, @byte_ffff04:8
		bclr	#5, @byte_ffff01:8
		bset	#6, @byte_ffff04:8
		bclr	#6, @byte_ffff01:8
		bset	#0, @byte_ffff05:8
		bset	#0, @byte_ffff02:8
		bset	#3, @byte_ffff05:8
		bset	#3, @byte_ffff02:8

		setOutH 2 6			; Pin P26/PW14
		setOutL d 0			; Pin PD0
		setOutL d 1			; Pin PD1
		setOutL c 5			; Pin PC5
		setOutL c 6			; Pin PC6
		setOutL 1 3			; Pin P13/PW3
.if !type70
		setOutL c 4			; Pin PC4
.endif
		setOutL d 6			; Pin PD6

.if !type70
		push	er0
		stc	ccr, r0l
		set	i
		b clr	pd5odr			; Pin PD5 (Port D Output Data Register)
		mov	@PDDDRcopy, r0h
		bset	#5, r0h
		mov	r0h, @PDDDRcopy
		mov	r0h, @pdddr		; Port D Data Direction Register
		ldc	r0l, ccr
		pop	er0
.endif
		setOutL c 7			; Pin PC7

		mov	@byte_ffff04, r0h
		or	#0x0f, r0h
		mov	r0h, @byte_ffff04
		mov	@byte_ffff03, r0l
		bset	#1, r0l
		mov	r0l, @byte_ffff03
		mov	@byte_ffff06, r1l
		bset	#1, r1l
		mov	r1l, @byte_ffff06
		mov	@byte_ffff01, r0l
		bset	#7, r0l
		mov	r0l, @byte_ffff01
		mov	@byte_ffff04, r1l
		bset	#7, r1l
		mov	r1l, @byte_ffff04
		jsr	sub_01e16

		setOutL 2 3			; Pin P23/PW11
.if !type70
		setInL	7 4			; Pin P74/AN4
.endif
.if level < 0x01000062
		setOutL	d 7			; Pin PD7
		b set	pd7odr			; Pin PD7 (Port D Output Data Register)
.endif
		rts

; ----------------------------------------------

initPorts2:	bset	#4, @byte_ffff07:8
		bclr	#0, @byte_ffff02:8
		bclr	#3, @byte_ffff02:8
		setOutH 2 5			; Pin P25/PW13
		setOutH 2 7			; Pin P27/PW15/CBLANK

		b clr	p25dr			; Pin P25/PW13 (Port 2 Data Register)
		b clr	p27dr			; Pin P27/PW15/CBLANK (Port 2 Data Register)
.if type1R
		setOutL d 2			; Pin PD2
.else
		setOutH d 2			; Pin PD2
.endif
		setOutL d 3			; Pin PD3

		b set	pc5odr			; Pin PC5 (Port C Output Data Register)
		b set	pc6odr			; Pin PC6 (Port C Output Data Register)
		b ild	pc5pin			; Pin PC5 (Port C Input Data Register)
		mov	#0, r0h
		jsr	setPINcopy

		b ld	p13dr			; Pin P13/PW3 (Port 1 Data Register)
		mov	#1, r0h
		jsr	setPINcopy

.if !type70
		b ld	pc4pin			; Pin PC4 (Port C Input Data Register)
		mov	#2, r0h
		jsr	setPINcopy
.endif

.if type1R
		b ild	pd2pin			; Pin PD2 (Port D Input Data Register)
.else
		b ld	pd2pin			; Pin PD2 (Port D Input Data Register)
.endif
		mov	#4, r0h
		jsr	setPINcopy

		b ld	pd6pin			; Pin PD6 (Port D Input Data Register)
		mov	#5, r0h
		jsr	setPINcopy

.if !type70
		b ld	pd5pin			; Pin PD5 (Port D Input Data Register)
		mov	#6, r0h
		jsr	setPINcopy
.endif

.if type1R
		b ild	pd7pin			; Pin PD7 (Port D Input Data Register)
		mov	#7, r0h
		jsr	setPINcopy
.endif

		bra	loc_01c0e

; ----------------------------------------------

sub_01bee:	setOutH 2 5			; Pin P25/PW13
		setOutH 2 7			; Pin P27/PW15/CBLANK

loc_01c0e:	bset	#5, @byte_ffff05:8
		bset	#5, @byte_ffff02:8
		jsr	sub_01e16

		jsr	sub_02060

		rts

; ----------------------------------------------

task02_3:	btst	#4, @byte_ffff07:8
		bne	1f

.if !type70
		setInL	c 4			; Pin PC4
.endif
		setInL	d 6			; Pin PD6
.if !type70
		setInL	d 5			; Pin PD5
.endif

		jsr	sub_01e16

		bset	#4, @byte_ffff07:8
1:
.if type70 || type1R
		clr	c
		rts
.endif

task02_1_2:	mov	@byte_ffe3e4, r0h
		mov	#off_01c78, er1
		jsr	switch_er1_r0h

		clr	c
		rts


off_01c78:	case 0	sub_01c86 sub_01c8c sub_01ca6 sub_01d38
		case 4	sub_01cba sub_01cde sub_01d2e

; ----------------------------------------------

sub_01c86:	bset	#7, @byte_ffff07:8
		bra	sub_01c96


sub_01c8c:	mov	#task02o, r0h
		mov	#1000, r1
		jsr	schedBackTaskDelayed

sub_01c96:	mov	@byte_ffe3e4, r0h
		inc	r0h
		mov	r0h, @byte_ffe3e4
		rts

; ----------------------------------------------

sub_01ca6:	mov	#task02o, r0h
		jsr	checkSchedTask

		bcs	loc_01cb6

		mov	#task02o, r0h
		jsr	schedFrontTask

		bra	rts_01cb8

loc_01cb6:	bsr	sub_01c96

rts_01cb8:	rts

; ----------------------------------------------

sub_01cba:
.if !type70 && !type1R
		jsr	sub_07548

		bst	#0, @byte_ffff07:8
		bxor	#1, @byte_ffff07:8
		bcs	loc_01cda
.endif

		bld	#6, @byte_ffff07:8
		bxor	#7, @byte_ffff07:8
		bcs	loc_01cda

		mov	#task02o, r0h
		jsr	schedFrontTask

		bra	rts_01cdc

loc_01cda:	bsr	sub_01c96

rts_01cdc:	rts

; ----------------------------------------------

sub_01cde:	btst	#6, @byte_ffff07:8
		beq	loc_01cec

		b clr	pc6odr			; Pin PC6 (Port C Output Data Register)
.if !type70 && !type1R
		bra	loc_01cf2

loc_01cec:	b set	pc6odr			; Pin PC6 (Port C Output Data Register)

loc_01cf2:	bld	#6, @byte_ffff07:8
		bst	#7, @byte_ffff07:8
		btst	#0, @byte_ffff07:8
		beq	loc_01d08
.endif

		b clr	pc5odr			; Pin PC5 (Port C Output Data Register)
		bra	loc_01d22

.if type70 || type1R
loc_01cec:	b set	pc6odr			; Pin PC6 (Port C Output Data Register)
.endif

loc_01d08:	jsr	sub_01276

		bcc	loc_01d1c

		mov	#0, r0h
		jsr	getPINcopy

		b ist	pc5odr			; Pin PC5 (Port C Output Data Register)
		bra	loc_01d22

loc_01d1c:	b set	pc5odr			; Pin PC5 (Port C Output Data Register)

loc_01d22:
.if !type70 && !type1R
		bld	#0, @byte_ffff07:8
		bst	#1, @byte_ffff07:8
		bra	sub_01c96:16
.else
		bld	#6, @byte_ffff07:8
		bst	#7, @byte_ffff07:8
		bra	sub_01c96
.endif

; ----------------------------------------------

sub_01d2e:	mov	#4, r0h
		mov	r0h, @byte_ffe3e4
		rts

; ----------------------------------------------

sub_01d38:	jsr	sub_0fe8e

		jmp	sub_01c96

; ----------------------------------------------

sub_01d40:	bset	#0, @byte_ffff02:8
		bset	#3, @byte_ffff02:8
		b set	p26dr			; Pin P26/PW14 (Port 2 Data Register)
		setOutL c 5			; Pin PC5
		setOutL c 6			; Pin PC6

.if !type1R
		jsr	sub_01fe2
.endif

		b clr	pd6odr			; Pin PD6 (Port D Output Data Register)
.if !type70
		setInL	d 5			; Pin PD5
.endif
.if type1R
		setInL	d 2			; Pin PD2
.else
		setInH	d 2			; Pin PD2
.endif
		setInL	d 3			; Pin PD3

sub_01dac:	bclr	#5, @byte_ffff05:8
		setInH	2 5			; Pin P25/PW13
		setInH	2 7			; Pin P27/PW15/CBLANK

		b clr	p13dr			; Pin P13/PW3 (Port 1 Data Register)
.if !type70
		btst	#5, @byte_ffff07:8
		bne	loc_01e10

		b clr	pc4odr			; Pin PC4 (Port C Output Data Register)
.endif
		b clr	pd6odr			; Pin PD6 (Port D Output Data Register)
.if !type70
		push	er0
		stc	ccr, r0l
		set	i
		b clr	pd5odr			; Pin PD5 (Port D Output Data Register)
		mov	@PDDDRcopy, r0h
		bset	#5, r0h
		mov	r0h, @PDDDRcopy
		mov	r0h, @pdddr		; Port D Data Direction Register
		ldc	r0l, ccr
		pop	er0
.endif

loc_01e10:	jsr	sub_01e16

		rts

; ----------------------------------------------

sub_01e16:	push	er0
		push	er1
		push	er2
		push	er6
		mov	#loc_01e58, er6
		mov	@byte_ffff01, r0h
		mov	@byte_ffff04, r1l
		and	r1l, r0h
		mov	@byte_ffff02, r0l
		mov	@byte_ffff05, r1l
		and	r1l, r0l
		mov	@byte_ffff03, r1h
		mov	@byte_ffff06, r1l
		and	r1l, r1h
		bra	loc_01e6a

loc_01e58:	pop	er6
		pop	er2
		pop	er1
		pop	er0
		rts


loc_01e6a:	mov	#0x18, r1l

loc_01e6c:	b clr	p20dr			; Pin P20/PW8 (Port 2 Data Register)
		shll	r0h
		rotxl	r0l
		rotxl	r1h
		b st	p21dr			; Pin P21/PW9 (Port 2 Data Register)
		b set	p20dr			; Pin P20/PW8 (Port 2 Data Register)
		dec	r1l
		bne	loc_01e6c

		b clr	p22dr			; Pin P22/PW10 (Port 2 Data Register)
		b set	p22dr			; Pin P22/PW10 (Port 2 Data Register)
		jmp	@er6

; ----------------------------------------------

rts_01e8c:	rts

; ----------------------------------------------

sub_01e8e:	clr	c
		rts

; ----------------------------------------------

sub_01e92:	bclr	#4, @byte_ffff01:8
		jsr	sub_01e16

		rts

; ----------------------------------------------

sub_01e9c:	bset	#4, @byte_ffff01:8
		bclr	#5, @byte_ffff01:8
		bclr	#6, @byte_ffff01:8
		jsr	sub_01e16

		rts

; ----------------------------------------------

sub_01eae:	cmp	#1, r0h
		beq	loc_01ebc

		bset	#5, @byte_ffff01:8
		bclr	#6, @byte_ffff01:8
		bra	loc_01ec4

loc_01ebc:	bclr	#5, @byte_ffff01:8
		bset	#6, @byte_ffff01:8

loc_01ec4:	bset	#4, @byte_ffff01:8

loc_01ec8:	jmp	sub_01e16


sub_01ecc:	bclr	#5, @byte_ffff01:8
		bclr	#6, @byte_ffff01:8
		bra	loc_01ec8

; ----------------------------------------------

.if level < 0x01000062
		bra	sub_01e9c

; ----------------------------------------------
.else
sub_01ed6:	b set	pc7odr			; Pin PC7 (Port C Output Data Register)
		rts

; ----------------------------------------------

sub_01ede:	b clr	pc7odr			; Pin PC7 (Port C Output Data Register)
		rts
.endif

; ----------------------------------------------

		bld	#4, @byte_ffff01:8
		rts

; ----------------------------------------------

		bild	#5, @byte_ffff01:8
		rts

; ----------------------------------------------

setP2_567:	bld	#2, r0l
		b ist	p25dr			; Pin P25/PW13 (Port 2 Data Register)
		bld	#3, r0h
		b ist	p26dr			; Pin P26/PW14 (Port 2 Data Register)
		bld	#1, r0l
		b ist	p27dr			; Pin P27/PW15/CBLANK (Port 2 Data Register)
		bld	#0, r0h
		bist	#0, @byte_ffff02:8
		bld	#4, r0h
		bist	#1, @byte_ffff02:8
		bld	#5, r0h
		bist	#2, @byte_ffff02:8
		bld	#1, r0h
		bist	#3, @byte_ffff02:8
		jmp	sub_01e16

; ----------------------------------------------

nop1:		jmp	@er6

; ----------------------------------------------

sub_01f22:	b clr	pc5odr			; Pin PC5 (Port C Output Data Register)
		rts

; ----------------------------------------------

sub_01f2a:
.if     type1R
		btst	#7, @byte_ffff07:8
		bne	rts_01f36
.elseif !type70
		btst	#1, @byte_ffff07:8
		bne	rts_01f36
.endif

		b set	pc5odr			; Pin PC5 (Port C Output Data Register)

rts_01f36:	rts

; ----------------------------------------------

sub_01f38:
.if type1R
		b clr	pd2odr			; Pin PD2 (Port D Output Data Register)
.else
		b set	pd2odr			; Pin PD2 (Port D Output Data Register)
.endif
		b set	pd3odr			; Pin PD3 (Port D Output Data Register)
		rts

; ----------------------------------------------

sub_01f46:
.if type1R
		b set	pd2odr			; Pin PD2 (Port D Output Data Register)
.else
		b clr	pd2odr			; Pin PD2 (Port D Output Data Register)
.endif
		b clr	pd3odr			; Pin PD3 (Port D Output Data Register)
		rts

; ----------------------------------------------

.if type70
sub_01f72:	b set	pd6odr			; Pin PD6 (Port D Output Data Register)
		b set	pd6odr			; Pin PD6 (Port D Output Data Register)
		rts

; ----------------------------------------------

sub_01f7a:	b clr	pd6odr			; Pin PD6 (Port D Output Data Register)
		b clr	pd6odr			; Pin PD6 (Port D Output Data Register)
		rts
.endif

; ----------------------------------------------

lightOn:	b set	p13dr			; Pin P13/PW3 (Port 1 Data Register)
		rts

; ----------------------------------------------

lightOff:	b clr	p13dr			; Pin P13/PW3 (Port 1 Data Register)
		rts

; ----------------------------------------------

sub_01f60:
.if !type70
		b set	pc4odr			; Pin PC4 (Port C Output Data Register)
		rts
.endif

; ----------------------------------------------

sub_01f68:
.if !type70
		b clr	pc4odr			; Pin PC4 (Port C Output Data Register)
.endif
		rts

; ----------------------------------------------

rts_01f70:	rts

; ----------------------------------------------

.if !type70
sub_01f72:	b set	pd6odr			; Pin PD6 (Port D Output Data Register)
		rts

; ----------------------------------------------

sub_01f7a:	b clr	pd6odr			; Pin PD6 (Port D Output Data Register)
		rts
.endif

; ----------------------------------------------

sub_01f82:
.if !type70
		push	er0
		stc	ccr, r0l
		set	i
		mov	@PDDDRcopy, r0h
		bclr	#5, r0h
		mov	r0h, @PDDDRcopy
		mov	r0h, @pdddr		; Port D Data Direction Register
		ldc	r0l, ccr
		pop	er0
		rts
.endif

; ----------------------------------------------

sub_01fa4:
.if !type70
		push	er0
		stc	ccr, r0l
		set	i
		b clr	pd5odr			; Pin PD5 (Port D Output Data Register)
		mov	@PDDDRcopy, r0h
		bset	#5, r0h
		mov	r0h, @PDDDRcopy
		mov	r0h, @pdddr		; Port D Data Direction Register
		ldc	r0l, ccr
		pop	er0
.endif
		rts

; ----------------------------------------------

sub_01fba:
.if type1R
		b clr	pd7odr			; Pin PD7 (Port D Output Data Register)
		rts
.endif

; ----------------------------------------------

sub_01fc2:
.if type1R
		b set	pd7odr			; Pin PD7 (Port D Output Data Register)
		rts

; ----------------------------------------------

sub_01fca:	btst	#2, @byte_ffff07:8
		bne	rts_01fea
		bhs	rts_01fea

		b ild	pc4pin			; Pin PC4 (Port C Input Data Register)
		b st	pc4odr			; Pin PC4 (Port C Output Data Register)
		b ld	pc4pin			; Pin PC4 (Port C Input Data Register)
		mov	#2, r0h
		jsr	setPINcopy

rts_01fea:	rts

; ----------------------------------------------

sub_02090:	btst	#2, @byte_ffff07:8
		bne	rts_0200c
		bhs	rts_0200c

		b ild	pd6pin			; Pin PD6 (Port D Input Data Register)
		b st	pd6odr			; Pin PD6 (Port D Output Data Register)
		b ld	pd6pin			; Pin PD6 (Port D Input Data Register)
		mov	#5, r0h
		jsr	setPINcopy

rts_0200c:
.endif
		rts     

; ----------------------------------------------

sub_01fce:	bset	#5, @byte_ffff02:8
		jsr	sub_01e16

		rts

; ----------------------------------------------

sub_01fd8:	bclr	#5, @byte_ffff02:8
		jsr	sub_01e16

		rts

; ----------------------------------------------

sub_01fe2:	bset	#6, @byte_ffff07:8
		bra	loc_01ff2

sub_01fe8:	bclr	#6, @byte_ffff07:8
		bra	loc_01ff2

sub_01fee:	bst	#6, @byte_ffff07:8

loc_01ff2:	mov	#task02o, r0h
		jsr	schedBackTask

		rts

; ----------------------------------------------

		mov	#0, r0h
		b ild	pc6pin			; Pin PC6 (Port C Input Data Register)
		bst	#0, r0h
		rts

; ----------------------------------------------

sub_02006:	bld	#0, r0h
		b st	pd0odr			; Pin PD0 (Port D Output Data Register)
		bld	#1, r0h
		b st	pd1odr			; Pin PD1 (Port D Output Data Register)
		rts

; ----------------------------------------------

sub_02018:	and	#0x0f, r0h
		set	i
		mov	@byte_ffff01, r0l
		and	#0xf0, r0l
		or	r0h, r0l
		mov	r0l, @byte_ffff01
		clr	i
		jmp	sub_01e16

; ----------------------------------------------

		rts
		rts

; ----------------------------------------------

sub_02036:	bset	#5, @byte_ffff07:8
		rts

; ----------------------------------------------

sub_0203c:	bclr	#5, @byte_ffff07:8
		rts

; ----------------------------------------------

sub_02042:	bset	#2, @byte_ffff07:8
		rts

; ----------------------------------------------

sub_02048:	bclr	#2, @byte_ffff07:8
		rts

; ----------------------------------------------

sub_0204e:	bcc	loc_02056

		jsr	sub_14712

		bra	loc_0205a

loc_02056:	jsr	sub_1470a

loc_0205a:	jsr	sub_0b4d8

		rts

; ----------------------------------------------

sub_02060:	btst	#3, @byte_ffff07:8
		beq	loc_02072

		jsr	sub_074bc

		bcs	loc_02072

		jsr	sub_01fd8

		bra	rts_02076

loc_02072:	jsr	sub_01fce

rts_02076:	rts


sub_02078:	bset	#3, @byte_ffff07:8
		bra	sub_02060

sub_0207e:	bclr	#3, @byte_ffff07:8
		bra	sub_02060

; ----------------------------------------------

rts_02084:	rts

; ----------------------------------------------

.if level >= 0x01000062
sub_02086:	mov	@byte_ffff01, r0h
		and	#0x0f, r0h
		rts
.endif

; ----------------------------------------------

.if !type1R
sub_02090:	mov	#task02o, r0h
		jsr	schedBackTask

		rts
.endif

; ----------------------------------------------

sub_02098:	jsr	sub_020de

		mov	#byte_0284a, er0
		mov	er0, @long_ffe904
		mov	#byte_028ca, er0
		mov	er0, @long_ffe908
		mov	#byte_0294a, er0
		mov	er0, @long_ffe90c
		mov	#0, r0h
		mov	r0h, @byte_ffff08
		mov	#byte_027fa, er0
		mov	er0, @long_ffe910
		rts

; ----------------------------------------------

sub_020de:	mov	#0, er0
		mov	r0h, @byte_ffff09
		mov	r0h, @byte_ffff0a
		mov	#0, r1h

loc_020f2:	mov	r1h, @(byte_ffe3e5,er0)
		inc	r0l
		cmp	#0x10, r0l
		bne	loc_020f2

		jsr	sub_03742

		rts

; ----------------------------------------------

sub_02106:	bset	#6, @byte_ffff08
.if type1R
		rts
.else
		bra	loc_02118
.endif

sub_02110:	bclr	#6, @byte_ffff08

.if !type1R
loc_02118:	jsr	sub_02b1e
.endif

		rts

; ----------------------------------------------

		bld	#6, @byte_ffff08
		rts

; ----------------------------------------------

sub_02128:
.if !type1R
		btst	#0, r0h
		beq	loc_02136

		btst	#1, @byte_ffff08
		bne	rts_0214c
.endif

loc_02136:	bld	#0, r0h
		bst	#1, @byte_ffff0a
		bst	#1, @byte_ffff09
.if !type1R
		jsr	sub_0241c
.endif

rts_0214c:	rts

; ----------------------------------------------

sub_0214e:	btst	#4, @byte_ffff08
		beq	sub_02106

		rts

; ----------------------------------------------

sub_0215a:	bra	sub_02110

		bset	#4, @byte_ffff08
		bra	loc_0216e

		bclr	#4, @byte_ffff08

loc_0216e:	jsr	sub_054f2

		cmp	#3, r0l
		bne	rts_02186

		btst	#4, @byte_ffff08
		bne	loc_02184

		bsr	sub_02106

		bra	rts_02186

loc_02184:	bsr	sub_02110

rts_02186:	rts

; ----------------------------------------------

		mov	#0, r0h
		bld	#4, @byte_ffff08
		bist	#0, r0h
		rts

; ----------------------------------------------

sub_02196:	mov	#0, r1h
		mov	r1h, @byte_ffe3f5
		mov	r0h, r3h
		jsr	sub_038ac

		mov	r0h, r0l
		mov	r3h, r0h
		cmp	#3, r0l
		bne	loc_021c8

		jsr	sub_024de

		jsr	sub_02450

		cmp	#0, r0l
		beq	loc_021c6

		jsr	sub_03610

		bild	#1, r2h
		band	#7, r0h
		bcs	loc_021c6

		jsr	sub_0261c

loc_021c6:	bra	loc_02238

loc_021c8:	jsr	sub_02450

		jsr	sub_02292

		jsr	sub_024a6

		bcs	loc_021e4

		bld	#7, r0h
		mov	r1l, r0h
		bst	#7, r0h
		jsr	sub_02450

		jsr	sub_02292

loc_021e4:	cmp	#0, r0h
		beq	loc_02238

		jsr	sub_024b8

		bixor	#7, r0h
		bcc	loc_02238

		btst	#7, r1h
		bne	loc_021f8

		btst	#6, r1h
		beq	loc_02218

loc_021f8:	btst	#7, r0h
		bne	loc_0220a

		btst	#7, r1h
		beq	loc_02206

		jsr	sub_0250c

		bra	loc_0220a

loc_02206:	jsr	sub_0253e

loc_0220a:	jsr	sub_0261c

		btst	#7, r0h
		beq	loc_02216

		jsr	sub_0259a

loc_02216:	bra	loc_02234

loc_02218:	btst	#2, r1h
		beq	loc_02222

		jsr	sub_02690

		bra	loc_02234

loc_02222:	jsr	sub_0259a

		jsr	sub_0261c

		btst	#1, r1h
		beq	loc_02234

		bset	#7, r0h
		jsr	sub_0261c

loc_02234:	jsr	sub_024de

loc_02238:	jsr	sub_023a8

		jsr	sub_026fa

		rts

; ----------------------------------------------

sub_02242:	push	er0
		jsr	sub_035c0

		mov	r0, r1
		pop	er0
		cmp	#0, r1l
		bne	rts_02290

		mov	#0, r1h
		mov	r1h, @byte_ffe3f5
		mov	r0h, r3h
		jsr	sub_038ac

		mov	r0h, r0l
		mov	r3h, r0h
		cmp	#3, r0l
		bne	loc_02280

		jsr	sub_02450

		cmp	#0, r0l
		beq	loc_0227e

		jsr	sub_03610

		btst	#0, r2h
		bne	loc_0227e

		jsr	sub_0261c

loc_0227e:	bra	loc_0228c

loc_02280:	jsr	sub_02450

		jsr	sub_02292

		jsr	sub_0261c

loc_0228c:	jsr	sub_026fa

rts_02290:	rts

; ----------------------------------------------

sub_02292:	mov	r0h, r1l
		bclr	#7, r1l
		mov	#0, r1h
		cmp	#0x4b, r1l
		blo	loc_022b6

		cmp	#0x59, r1l
		bhi	loc_022b6

		btst	#1, @byte_ffff0a
		beq	loc_022ae

		bset	#7, r1h
		bra	loc_022b0

loc_022ae:	bset	#6, r1h

loc_022b0:	bset	#5, r1h
		jmp	rts_023a6

loc_022b6:	cmp	#0x5f, r1l
		bne	loc_022c2

		bset	#6, r1h
		bset	#5, r1h
		jmp	rts_023a6

loc_022c2:	cmp	#0x7c, r1l
		bne	loc_022f2

		mov	@byte_ffff0a, r1l
		and	#0x0c, r1l
		beq	loc_022d2

		bset	#4, r1h

loc_022d2:	btst	#5, @byte_ffff0a
		bne	loc_022e8

		btst	#4, @byte_ffff0a
		bne	loc_022e8

		bset	#7, r1h

loc_022e8:	bset	#5, r1h
		bset	#3, r1h
		mov	#0x44, r1l
.if type1R
		bra	rts_023a6
.else
		bra	rts_023a6:16
.endif

loc_022f2:	cmp	#0x7d, r1l
		bne	loc_02328

		mov	@byte_ffff0a, r1l
		mov	r1l, r2h
		and	#0xc0, r1l
		beq	loc_02322

.if level >= 0x01050000
		btst	#3, @byte_ffff08
		bne	loc_02316
.endif

		btst	#6, @byte_ffff08
		bne	loc_02322

loc_02316:	btst	#5, @byte_ffff08
		bne	loc_02322

		bset	#4, r1h

loc_02322:	bset	#3, r1h
		mov	#0x5a, r1l
		bra	rts_023a6

loc_02328:	cmp	#0x7e, r1l
		bne	loc_0234e

		btst	#7, r0h
		beq	loc_02334

		mov	#0, r0h
		bra	loc_0234c

loc_02334:	mov	@byte_ffff0a, r1l
		and	#0x30, r1l
		beq	loc_02344

		bset	#4, r1h
		bset	#5, r1h
		bra	loc_02346

loc_02344:	bset	#2, r1h

loc_02346:	bset	#3, r1h
		bset	#1, r1h
		mov	#0x46, r1l

loc_0234c:	bra	rts_023a6

loc_0234e:	cmp	#0x46, r1l
		bne	loc_02360

		btst	#7, r0h
		beq	loc_0235a

		mov	#0, r0h
		bra	loc_0235e

loc_0235a:	bset	#5, r1h
		bset	#1, r1h

loc_0235e:	bra	rts_023a6

loc_02360:
.if !type1R
		cmp	#0x5a, r1l
		bne	loc_0239c

		btst	#1, @byte_ffff08
		beq	loc_0239c

		btst	#7, r0h
		bne	loc_0239c

		push	er0
		push	er1
		jsr	sub_03924

		mov	r0h, r2h
		pop	er1
		pop	er0
		btst	#1, r2h
		bne	loc_02394

		btst	#1, @byte_ffff0a:16
		beq	loc_0239a

loc_02394:	jsr	sub_02404

		mov	#0, r0h

loc_0239a:	bra	rts_023a6
.endif

loc_0239c:	mov	@byte_ffff0a, r2h
		jsr	sub_02766

rts_023a6:	rts

; ----------------------------------------------

sub_023a8:	mov	r0h, r2l
		bclr	#7, r2l
		cmp	#0x2c, r2l
		blo	loc_023e8

		cmp	#0x40, r2l
		bhi	loc_023e8

		mov	#0, r2h
		mov	@(byte_0243a - 0x2c,er2), r3h
		bmi	loc_023e8

		bild	#7, r0h
		bcc	loc_023d6

		bset	r3h, @byte_ffff0a
		bset	r3h, @byte_ffff09
		bra	loc_023e6

loc_023d6:	bclr	r3h, @byte_ffff0a
		bclr	r3h, @byte_ffff09

loc_023e6:	bra	rts_02402

loc_023e8:	cmp	#0x5a, r2l
		bne	rts_02402

		btst	#7, r0h
		bne	rts_02402

.if !type1R
		push	er0
		push	er1
		bsr	sub_02404

		pop	er1
		pop	er0

rts_02402:	rts

; ----------------------------------------------

sub_02404:
.endif
		bild	#1, @byte_ffff0a
		bst	#1, @byte_ffff0a
		bst	#1, @byte_ffff09

.if type1R
rts_02402:
.else
sub_0241c:	btst	#1, @byte_ffff08
		beq	rts_02438

		jsr	sub_03924

		bld	#1, @byte_ffff0a
		bst	#1, r0h
		jsr	sub_06968

rts_02438:
.endif
		rts

; ----------------------------------------------

byte_0243a:	.byte 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 6, 5, -1, 3, -1, 2, -1, 4, -1

; ----------------------------------------------

sub_02450:	push	er0
		jsr	sub_038ac

		mov	r0h, r2l
		pop	er0
		dec	r2l
		mov	#0, r2h
		mov	#0, e2
		shll	#2, er2
		mov	#long_ffe904, er3
		add	er2, er3
		mov	@er3, er2
		mov	r0h, r3l
		bclr	#7, r3l
		mov	#0, r3h
		mov	#0, e3
		add	er3, er2
		mov	@er2, r0l
		bne	rts_02486

		mov	#0, r0h

rts_02486:	rts

; ----------------------------------------------

.if !type1R
		mov	#long_ffe904, er3
		mov	@er3, er2
		mov	r0h, r3l
		bclr	#7, r3l
		mov	#0, r3h
		mov	#0, e3
		add	er3, er2
		mov	@er2, r0l
		bne	rts_024a4

		mov	#0, r0h

rts_024a4:	rts
.endif

; ----------------------------------------------

sub_024a6:	bild	#7, r0h
		bcs	loc_024b4

		bild	#3, r1h
		bcs	loc_024b2

		jsr	sub_024b8

loc_024b2:	bra	rts_024b6

loc_024b4:	bild	#4, r1h

rts_024b6:	rts

; ----------------------------------------------

sub_024b8:	mov	r0h, r3l
		bclr	#7, r3l
		mov	r3l, r4h
		and	#7, r4h
		shlr	r3l
		shlr	r3l
		shlr	r3l
		mov	#0, r3h
		mov	#0, e3
		mov	@(byte_ffe3e5,er3), r3h
		clr	c
		btst	r4h, r3h
		beq	rts_024dc

		set	c

rts_024dc:	rts

; ----------------------------------------------

sub_024de:	mov	r0h, r3l
		bclr	#7, r3l
		mov	r3l, r4h
		and	#7, r4h
		shlr	r3l
		shlr	r3l
		shlr	r3l
		mov	#0, r3h
		mov	#0, e3
		mov	@(byte_ffe3e5,er3), r4l
		bclr	r4h, r4l
		bild	#7, r0h
		bcc	loc_02502

		bset	r4h, r4l

loc_02502:	mov	r4l, @(byte_ffe3e5,er3)
		rts

; ----------------------------------------------

sub_0250c:	mov	@byte_ffff09, r2h
		and	#0xc0, r2h
		bne	rts_0253c

		push	er0
		push	er1
		mov	#0x2c, r0h
		jsr	sub_02450

		mov	#0, r1h
		bset	#5, r1h
		jsr	sub_0261c

		bset	#7, @byte_ffff09
		pop	er1
		pop	er0

rts_0253c:	rts

; ----------------------------------------------

sub_0253e:	mov	@byte_ffff09, r2h
		and	#0xc0, r2h
		beq	rts_02598

		push	er0
		push	er1
		btst	#6, @byte_ffff09
		beq	loc_02568

		mov	#0xb9, r0h
		jsr	sub_02450

		mov	#0, r1h
		bset	#5, r1h
		jsr	sub_0261c

loc_02568:	btst	#7, @byte_ffff09
		beq	loc_02580

		mov	#0xac, r0h
		jsr	sub_02450

		mov	#0, r1h
		bset	#5, r1h
		jsr	sub_0261c

loc_02580:	bclr	#6, @byte_ffff09
		bclr	#7, @byte_ffff09
		pop	er1
		pop	er0

rts_02598:	rts

; ----------------------------------------------

sub_0259a:	mov	@byte_ffff09, r2h
		mov	@byte_ffff0a, r2l
		xor	r2h, r2l
		beq	rts_0261a

		push	er0
		push	er1
		btst	#6, r2l
		beq	loc_025d6

		push	er2
		mov	#0x39, r0h
		bld	#6, @byte_ffff09
		bst	#7, r0h
		jsr	sub_02450

		mov	#0, r1h
		bset	#5, r1h
		jsr	sub_0261c

		pop	er2

loc_025d6:	btst	#7, r2l
		beq	loc_025f2

		mov	#0x2c, r0h
		bld	#7, @byte_ffff09
		bst	#7, r0h
		jsr	sub_02450

		mov	#0, r1h
		bset	#5, r1h
		jsr	sub_0261c

loc_025f2:	bld	#6, @byte_ffff0a
		bst	#6, @byte_ffff09
		bld	#7, @byte_ffff0a
		bst	#7, @byte_ffff09
		pop	er1
		pop	er0

rts_0261a:	rts

; ----------------------------------------------

sub_0261c:	push	er0
		jsr	sub_038ac

		mov	r0h, r2h
		pop	er0
		cmp	#3, r2h
		beq	loc_02662

		mov	r0h, r2l
		bclr	#7, r2l
		mov	r2l, r3h
		shlr	r2l
		shlr	r2l
		shlr	r2l
		mov	#0, r2h
		mov	#0, e2
		mov	@(byte_0283a,er2), r3l
		and	#7, r3h
		btst	r3h, r3l
		beq	loc_02650

		bset	#5, r1h

loc_02650:	btst	#5, r1h
		beq	loc_02662

		push	er0
		mov	#0xe0, r0l
		jsr	sub_026dc

		pop	er0

loc_02662:	btst	#7, r0h
		beq	loc_0268a

		push	er0
		jsr	sub_038ac

		mov	r0h, r2h
		pop	er0
		cmp	#1, r2h
		beq	loc_02688

		push	er0
		mov	#0xf0, r0l
		jsr	sub_026dc

		pop	er0
		bra	loc_0268a

loc_02688:	bset	#7, r0l

loc_0268a:	jsr	sub_026dc

		rts

; ----------------------------------------------

sub_02690:	push	er0
		mov	#0xe1, r0l
		jsr	sub_026dc

		mov	#0x3a, r0h
		jsr	sub_02450

		mov	#0, r1h
		jsr	sub_0261c

		pop	er2
		push	er0
		mov	r2, r0
		jsr	sub_0261c

		push	er0
		mov	#0xe1, r0l
		jsr	sub_026dc

		pop	er2
		pop	er0
		push	er2
		bset	#7, r0h
		jsr	sub_0261c

		pop	er0
		bset	#7, r0h
		jsr	sub_0261c

		rts

; ----------------------------------------------

sub_026dc:	mov	@byte_ffe3f5, r2l
		mov	#0, r2h
		mov	#0, e2
		mov	r0l, @(byte_ffe3f6,er2)
		inc	r2l
		mov	r2l, @byte_ffe3f5
		rts

; ----------------------------------------------

sub_026fa:	push	er0
		jsr	sub_035c0

		mov	@byte_ffe3f5, r2l
		beq	loc_0273c

		cmp	r0h, r2l
		bhi	loc_02738

		mov	#0, er3

loc_02714:	mov	@(byte_ffe3f6,er3), r0h
		push	er2
		push	er3
		jsr	sub_034e4

		pop	er3
		pop	er2
		inc	r3l
		cmp	r2l, r3l
		bne	loc_02714

		bra	loc_0273c

loc_02738:	jsr	sub_02742

loc_0273c:	pop	er0
		rts

; ----------------------------------------------

sub_02742:	push	er0
		push	er1
		jsr	sub_038ac

		cmp	#1, r0h
		bne	loc_02756

		mov	#-1, r0h
		bra	loc_02758

loc_02756:	mov	#0, r0h

loc_02758:	jsr	sub_03526

		pop	er1
		pop	er0
		rts

; ----------------------------------------------

sub_02766:	btst	#7, @byte_ffff08
		bne	rts_027b8

		mov	@long_ffe910, er2
		mov	r0h, r3l
		bclr	#7, r3l
		cmp	#0x40, r3l
		bhs	rts_027b8

		mov	#0, r3h
		mov	#0, e3
		add	er3, er2
		mov	@er2, r1l
		beq	rts_027b8

		btst	#7, r0h
		bne	loc_027b6

		btst	#6, @byte_ffff08

.if level >= 0x01050000
		beq	loc_027aa

		btst	#1, @byte_ffff08
		beq	loc_027b6

		jsr	sub_0551e

		bcc	loc_027b6
.else
		bne	loc_027b6
.endif

loc_027aa:	btst	#1, @byte_ffff0a
		beq	loc_027b6

		bset	#4, r1h

loc_027b6:	bset	#3, r1h

rts_027b8:	rts

; ----------------------------------------------

byte_027ba:	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
		.byte 0x5b, 0x60, 0x65, 0x5f, 0x00, 0x00, 0x00, 0x00
		.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x5c
		.byte 0x61, 0x66, 0x64, 0x6c, 0x00, 0x00, 0x00, 0x00
		.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x5d, 0x62, 0x67
		.byte 0x69, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
		.byte 0x00, 0x00, 0x00, 0x00, 0x63, 0x00, 0x68, 0x6a
		.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

byte_027fa:	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
		.byte 0x5b, 0x60, 0x65, 0x5f, 0x00, 0x00, 0x00, 0x00
		.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x5c
		.byte 0x61, 0x66, 0x64, 0x00, 0x00, 0x00, 0x00, 0x00
		.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x5d, 0x62, 0x67
		.byte 0x69, 0x00, 0x00, 0x6c, 0x00, 0x00, 0x00, 0x00
		.byte 0x00, 0x00, 0x00, 0x00, 0x63, 0x00, 0x68, 0x6a
		.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

byte_0283a:	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc8
		.byte 0x81, 0x07, 0x00, 0x80, 0x00, 0xb8, 0x00, 0x00

byte_0284a:	.byte 0x00, 0x29, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07
		.byte 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x7d, 0x0e
		.byte 0x0f, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16
		.byte 0x17, 0x18, 0x19, 0x1a, 0x1b, 0x2b, 0x3a, 0x1e
		.byte 0x1f, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26
		.byte 0x27, 0x28, 0x2b, 0x1c, 0x2a, 0x56, 0x2c, 0x2d
		.byte 0x2e, 0x2f, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35
		.byte 0x73, 0x36, 0x1d, 0x6c, 0x38, 0x39, 0x38, 0x32
		.byte 0x1d, 0x7b, 0x79, 0x70, 0x54, 0x45, 0x46, 0x65
		.byte 0x66, 0x67, 0x63, 0x52, 0x53, 0x1c, 0x00, 0x4b
		.byte 0x47, 0x4f, 0x52, 0x48, 0x50, 0x49, 0x51, 0x53
		.byte 0x00, 0x4d, 0x45, 0x47, 0x4b, 0x4f, 0x00, 0x35
		.byte 0x48, 0x4c, 0x50, 0x52, 0x37, 0x49, 0x4d, 0x51
		.byte 0x53, 0x4a, 0x4e, 0x68, 0x1c, 0x6a, 0x01, 0x69
		.byte 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, 0x40, 0x41, 0x42
		.byte 0x43, 0x44, 0x57, 0x58, 0x37, 0x46, 0x45, 0x00

byte_028ca:	.byte 0x00, 0x0e, 0x16, 0x1e, 0x26, 0x25, 0x2e, 0x36
		.byte 0x3d, 0x3e, 0x46, 0x45, 0x4e, 0x55, 0x6a, 0x66
		.byte 0x0d, 0x15, 0x1d, 0x24, 0x2d, 0x2c, 0x35, 0x3c
		.byte 0x43, 0x44, 0x4d, 0x54, 0x5b, 0x5d, 0x58, 0x1c
		.byte 0x1b, 0x23, 0x2b, 0x34, 0x33, 0x3b, 0x42, 0x4b
		.byte 0x4c, 0x52, 0x5d, 0x5a, 0x12, 0x61, 0x1a, 0x22
		.byte 0x21, 0x2a, 0x32, 0x31, 0x3a, 0x41, 0x49, 0x4a
		.byte 0x51, 0x59, 0x14, 0x48, 0x11, 0x29, 0x11, 0x3a
		.byte 0x14, 0x67, 0x64, 0x13, 0x84, 0x77, 0x7e, 0x10
		.byte 0x18, 0x20, 0x5e, 0x70, 0x71, 0x5a, 0x00, 0x6b
		.byte 0x6c, 0x69, 0x70, 0x75, 0x72, 0x7d, 0x7a, 0x71
		.byte 0x00, 0x74, 0x77, 0x6c, 0x6b, 0x69, 0x00, 0x4a
		.byte 0x75, 0x73, 0x72, 0x70, 0x7c, 0x7d, 0x74, 0x7a
		.byte 0x71, 0x7b, 0x79, 0x28, 0x5a, 0x38, 0x76, 0x30
		.byte 0x05, 0x06, 0x04, 0x0c, 0x03, 0x0b, 0x83, 0x0a
		.byte 0x01, 0x09, 0x78, 0x07, 0x7c, 0x7e, 0x77, 0x00

byte_0294a:	.byte 0x00, 0x0e, 0x16, 0x1e, 0x26, 0x25, 0x2e, 0x36
		.byte 0x3d, 0x3e, 0x46, 0x45, 0x4e, 0x55, 0x5d, 0x66
		.byte 0x0d, 0x15, 0x1d, 0x24, 0x2d, 0x2c, 0x35, 0x3c
		.byte 0x43, 0x44, 0x4d, 0x54, 0x5b, 0x5c, 0x14, 0x1c
		.byte 0x1b, 0x23, 0x2b, 0x34, 0x33, 0x3b, 0x42, 0x4b
		.byte 0x4c, 0x52, 0x53, 0x5a, 0x12, 0x13, 0x1a, 0x22
		.byte 0x21, 0x2a, 0x32, 0x31, 0x3a, 0x41, 0x49, 0x4a
		.byte 0x51, 0x59, 0x11, 0x00, 0x19, 0x29, 0x39, 0x00
		.byte 0x58, 0x85, 0x86, 0x87, 0x00, 0x00, 0x00, 0x00
		.byte 0x00, 0x00, 0x00, 0x67, 0x64, 0x5a, 0x00, 0x61
		.byte 0x6e, 0x65, 0x67, 0x63, 0x60, 0x6f, 0x6d, 0x64
		.byte 0x00, 0x6a, 0x76, 0x6c, 0x6b, 0x69, 0x00, 0x77
		.byte 0x75, 0x73, 0x72, 0x70, 0x7e, 0x7d, 0x74, 0x7a
		.byte 0x71, 0x84, 0x7c, 0x00, 0x79, 0x00, 0x08, 0x00
		.byte 0x07, 0x0f, 0x17, 0x1f, 0x27, 0x2f, 0x37, 0x3f
		.byte 0x47, 0x4f, 0x56, 0x5e, 0x57, 0x5f, 0x62, 0x00
		.byte 0x6a, 0x20, 0x00, 0xff, 0xff, 0x0a, 0xe0, 0xc0
		.byte 0x47, 0x04, 0x06, 0xfe, 0x40, 0x02, 0x04, 0x01
		.byte 0x54, 0x70, 0x6a, 0x20, 0x00, 0xff, 0xff, 0x0a
		.byte 0xe0, 0x0c, 0x47, 0x04, 0x06, 0xfe, 0x40, 0x02
		.byte 0x04, 0x01, 0x54, 0x70, 0x6a, 0x20, 0x00, 0xff
		.byte 0xff, 0x0a, 0xe0, 0x30, 0x47, 0x04, 0x06, 0xfe
		.byte 0x40, 0x02, 0x04, 0x01, 0x54, 0x70

; ----------------------------------------------

sub_02a00:	cmp	#0, r0h
		bne	loc_02a24

		mov	#byte_027fa, er0
		mov	er0, @long_ffe910
		bclr	#7, @byte_ffff08
		bclr	#5, @byte_ffff08
		bra	rts_02a5c

loc_02a24:	cmp	#1, r0h
		bne	loc_02a48

		mov	#byte_027ba, er0
		mov	er0, @long_ffe910
		bclr	#7, @byte_ffff08
		bclr	#5, @byte_ffff08
		bra	rts_02a5c

loc_02a48:	cmp	#2, r0h
		bne	rts_02a5c

		bset	#7, @byte_ffff08
		bset	#5, @byte_ffff08

rts_02a5c:	rts

; ----------------------------------------------

sub_02a5e:	cmp	#0, r0l
		beq	loc_02af2:16

		cmp	#3, r0l
		bhi	loc_02af2:16

		btst	#7, @byte_ffff08
		bne	loc_02af2

		mov	#long_ffe904, er2
		dec	r0l
		push	er0
		mov	#0, r0h
		mov	#0, e0
		shll	#2, er0
		add	er0, er2
		mov	@er2, er2
		pop	er0
		mov	#0, r0l
		mov	er2, er3
		mov	#0, r1h

loc_02a98:	mov	@er2+, r1l
		cmp	#0x40, r1h
		blo	loc_02aa2

		cmp	#0x5a, r1h
		blo	loc_02aa6

loc_02aa2:	cmp	r1l, r0h
		beq	loc_02aac

loc_02aa6:	inc	r1h
		cmp	#0x80, r1h
		blo	loc_02a98

loc_02aac:	cmp	#0x80, r1h
		bhs	loc_02af0

		cmp	#0x40, r1h
		bhs	loc_02ac8

		mov	@long_ffe910, er2
		add	r1h, r2l
		addx	#0, r2h
		bcc	loc_02ac4

		inc	#1, e2

loc_02ac4:	mov	@er2, r1h
		bra	loc_02ae2

loc_02ac8:	mov	@long_ffe910, er2
		mov	#0, r4h

loc_02ad2:	mov	@er2+, r4l
		cmp	r4l, r1h
		beq	loc_02ae0

		inc	r4h
		cmp	#0x40, r4h
		blo	loc_02ad2

		mov	#0, r4h

loc_02ae0:	mov	r4h, r1h

loc_02ae2:	cmp	#0, r1h
		beq	loc_02af0

		add	r1h, r3l
		addx	#0, r3h
		bcc	loc_02aee

		inc	#1, e3

loc_02aee:	mov	@er3, r0l

loc_02af0:	bra	rts_02af4

loc_02af2:	mov	#0, r0l

rts_02af4:	rts

; ----------------------------------------------

.if !type1R
sub_02af6:	bset	#3, @byte_ffff08
		bra	sub_02b1e

sub_02b00:	bclr	#3, @byte_ffff08
		bra	sub_02b1e

sub_02b0a:	bset	#2, @byte_ffff08
		bra	sub_02b1e

sub_02b14:	bclr	#2, @byte_ffff08
		bra	sub_02b1e

sub_02b1e:	sub	er0, er0		; mov #0, er0
		bld	#7, @byte_ffff08
		bst	#4, r0l
		bld	#3, @byte_ffff08
		bst	#3, r0l
		bld	#2, @byte_ffff08
		bst	#2, r0l
		push	er0
		jsr	sub_054f2

		pop	er1
		cmp	#0, r0h
		beq	loc_02b5c

		cmp	#3, r0l
		bne	loc_02b56

		bset	#0, r1l
		bra	loc_02b5c

loc_02b56:	cmp	#2, r0l
		bne	loc_02b5c

		bset	#1, r1l

loc_02b5c:	mov	@(long_02bd2,er1), r0h
		mov	@byte_ffff08, r0l
		xor	r0h, r0l
		and	#3, r0l
		beq	rts_02bd0

		mov	#-1, r1h
		btst	#1, r0l
		beq	loc_02b8c

		btst	#1, r0h
		beq	loc_02b8a

		bclr	#1, @byte_ffff0a:16
		bclr	#1, @byte_ffff09:16
		mov	#0, r1h
		bra	loc_02b8c

loc_02b8a:	mov	#1, r1h

loc_02b8c:	btst	#0, r0l
		beq	loc_02b9a

		btst	#0, r0h
		beq	loc_02b98

		mov	#0, r1h
		bra	loc_02b9a

loc_02b98:	mov	#1, r1h

loc_02b9a:	push	er0
		cmp	#-1, r1h
		beq	loc_02bb8

		push	er1
		jsr	sub_03924

		pop	er1
		cmp	#0, r1h
		bne	loc_02bb4

		bclr	#1, r0h

loc_02bb4:	jsr	sub_06968

loc_02bb8:	pop	er0
		bld	#1, r0h
		bst	#1, @byte_ffff08
		bld	#0, r0h
		bst	#0, @byte_ffff08

rts_02bd0:	rts


long_02bd2:	.long 0x00000000
		.long 0x00010101
.if level >= 0x01050000
		.long 0x02030000
.else
		.long 0x02010000
.endif
		.long 0x00000000
		.long 0x00000000
		.long 0x01010100
		.long 0x00000000
		.long 0x01010100

; ----------------------------------------------

sub_02bf2:	bild	#1, @byte_ffff08
		rts

; ----------------------------------------------

sub_02bfc:	bild	#0, @byte_ffff08
		rts

; ----------------------------------------------

sub_02c06:	bld	#1, @byte_ffff0a:16
		rts
.endif

; ----------------------------------------------

; FRT Output Compare A

ocia:		push	er0
		b clr	tier.ociae		; Output Compare Interrupt A Enable (FRT Timer Interrupt Enable Register)
		b clr	tcsr.ocfa		; Output Compare Flag A (FRT Timer Control/Status Register)
		b clr	tocr.ocrs		; Output Compare Register Select (FRT Timer Output Compare Control Register)
		mov	@word_ffe914, r0	; initially 1250 = 1 ms @ 10 MHz
		mov	r0, @ocra		; FRT Output Compare Register A
		clr	i
		push	er1
		push	er2
		mov	@curScanLine, r0h
		jsr	setScanLine

		mov	#20, r0h		; 20 * 5 states @ 10 MHz = 10 탎

busywait1:	nop
		nop
		dec	r0h
		bne	busywait1

		btst	#5, @byte_ffff0b:8
		beq	loc_02c74

		set	i
		mov	@tick, r0
		inc	#1, r0
		mov	r0, @tick
		clr	i
		mov	@word_ffe928, r0
		bmi	loc_02c74

		dec	#1, r0
		mov	r0, @word_ffe928
		bpl	loc_02c74

		jsr	sub_016b6

loc_02c74:	btst	#7, @byte_ffff0b:8
		beq	loc_02c7e

		jmp	loc_02d2c

loc_02c7e:	btst	#6, @byte_ffff0b:8
		beq	loc_02d02

		bld	#5, @byte_ffff0b:8
		bxor	#4, @byte_ffff0b:8
		bcs	loc_02d00

		mov	@pgpin, r1h		; Port G Input Data Register
		not	r1h
		mov	@byte_ffe3fe, r1l
		cmp	r1h, r1l
		bne	loc_02cf2

		mov	@byte_ffe3ff, r1l
		inc	r1l
		mov	r1l, @byte_ffe3ff
		mov	@byte_ffe401, r0h
		cmp	r0h, r1l
		blo	loc_02cf0

		mov	@curScanLine, r0l
		mov	#0, r0h
		mov	#0, e0
		mov	@(curScanRead,er0), r1l
		cmp	r1l, r1h
		beq	loc_02ce8

		mov	r1h, @(curScanRead,er0)
		bset	#3, @byte_ffff0c:8
		mov	#0x10, r1l
		mov	r1l, @byte_ffe400
		mov	#task03o, r0h
		jsr	schedBackTask

loc_02ce8:	bclr	#6, @byte_ffff0b:8
		jsr	nextScanLine

loc_02cf0:	bra	loc_02d00

loc_02cf2:	mov	r1h, @byte_ffe3fe
		mov	#0, r0h
		mov	r0h, @byte_ffe3ff

loc_02d00:	bra	loc_02d2c

loc_02d02:	bsr	readScanLine

		btst	#6, @byte_ffff0b:8
		bne	loc_02d24

		mov	@byte_ffe400, r2l
		beq	loc_02d22

		dec	r2l
		mov	r2l, @byte_ffe400
		bne	loc_02d22

		mov	#task03o, r0h
		jsr	schedBackTask

loc_02d22:	bra	loc_02d2c

loc_02d24:	bld	#5, @byte_ffff0b:8
		bst	#4, @byte_ffff0b:8

loc_02d2c:	mov	#13, r0h
		bsr	setScanLine

		mov	@word_ffe914, r0
		mov	#625, r1
		add	r1, r0
		mov	r0, @word_ffe914	;  +625 / 1.25 MHz = +500 탎 @ 10 MHz
		bld	#5, @byte_ffff0b:8
		bist	#5, @byte_ffff0b:8
		pop	er2
		pop	er1
		set	i
		b set	tier.ociae		; Output Compare Interrupt A Enable (FRT Timer Interrupt Enable Register)
		pop	er0
		rte

; ----------------------------------------------

readScanLine:	mov	@curScanLine, r0l
		mov	#0, r0h
		mov	#0, e0
		mov	@(curScanRead,er0), r1l
		mov	@pgpin, r1h		; Port G Input Data Register
		not	r1h
		cmp	r1l, r1h
		beq	loc_02d90

		bset	#6, @byte_ffff0b:8
		mov	r1h, @byte_ffe3fe
		mov	#0, r0h
		mov	r0h, @byte_ffe3ff
		bra	rts_02d92

loc_02d90:	bsr	nextScanLine

rts_02d92:	rts

; ----------------------------------------------

setScanLine:	mov	#word_02db0, er1
		shll	r0h
		add	r0h, r1l
		addx	#0, r1h
		bcc	loc_02da4

		inc	#1, e1

loc_02da4:	mov	@er1, r0
		mov	r0h, @peddr		; Port E Data Direction Register
		mov	r0l, @pfddr		; Port F Data Direction Register
		rts


word_02db0:	.word 0b0000000100000000	;  0
		.word 0b0000001000000000	;  1
		.word 0b0000010000000000	;  2
		.word 0b0000100000000000	;  3
		.word 0b0001000000000000	;  4
		.word 0b0010000000000000	;  5
		.word 0b0100000000000000	;  6
		.word 0b1000000000000000	;  7
		.word 0b0000000000000001	;  8
		.word 0b0000000000000010	;  9
		.word 0b0000000000000100	; 10
		.word 0b0000000000001000	; 11
		.word 0b0000000000010000	; 12
		.word 0b0000000000100000	; 13
		.word 0b0000000001000000	; 14
		.word 0b0000000010000000	; 15

; ----------------------------------------------

nextScanLine:	mov	@curScanLine, r0l
		inc	r0l
		and	#0x0f, r0l
		mov	r0l, @curScanLine
		rts

; ----------------------------------------------

sub_02de2:	b clr	tier.ociae		; Output Compare Interrupt A Enable (FRT Timer Interrupt Enable Register)
		mov	#0, r0
		mov	r0h, @byte_ffff0b:8
		bset	#7, @byte_ffff0b:8
		mov	#curScanRead, er1
		mov	#prePrevScanRead, er2
		mov	#16, r3h

clrScanBufs1:	mov	r0h, @er1
		mov	r0h, @er2
		adds	#1, er1
		adds	#1, er2
		dec	r3h
		bne	clrScanBufs1

		mov	#0x10, r1h
		mov	r1h, @byte_ffe400
		mov	#7, r1h
		mov	r1h, @byte_ffe401
		bsr	initFRT

		jsr	sub_02098

		jsr	sub_033c2

		mov	#-1, r0h
		mov	r0h, @byte_ffe40a
		rts

; ----------------------------------------------

initFRT:	b clr	mstpcrh.mstp13		; FRT (Module Stop Control Register H)
		mov	#625, r1		; 625 / 1.25 MHz = 500 탎 @ 10 MHz
		stc	ccr, r2h
		set	i
		b clr	tocr.ocrs		; Output Compare Register Select (FRT Timer Output Compare Control Register)
		mov	r1, @ocra		; FRT Output Compare Register A
		ldc	r2h, ccr
		b clr	tcsr.cclra		; Counter Clear A (FRT Timer Control/Status Register)
		b clr	tcr.cks1		; Clock Select 1 (FRT Timer Control Register): phi/8 internal clock
		b set	tcr.cks0		; Clock Select 0 (FRT Timer Control Register): = 1.25 MHz @ 10 MHz
		mov	#1250, r0		; 1250 / 1.25 MHz = 1 ms @ 10 MHz
		mov	r0, @word_ffe914
		mov	#0, r0
		stc	ccr, r1h
		set	i
		mov	r0, @frc		; FRT Free-Running Counter
		b clr	tcsr.ocfa		; Output Compare Flag A (FRT Timer Control/Status Register)
		b set	tier.ociae		; Output Compare Interrupt A Enable (FRT Timer Interrupt Enable Register)
		ldc	r1h, ccr
		rts

; ----------------------------------------------

sub_02e72:	mov	#0, r0h
		bset	#7, @byte_ffff0b:8
		bclr	#6, @byte_ffff0b:8
		mov	#0, r0h
		mov	#curScanRead, er1
		mov	#prePrevScanRead, er2
		mov	#16, r3h

clrScanBufs2:	mov	r0h, @er1
		mov	r0h, @er2
		adds	#1, er1
		adds	#1, er2
		dec	r3h
		bne	clrScanBufs2

		mov	r0h, @byte_ffe93a
		mov	r0h, @byte_ffe94c
		mov	#0, r0h
		mov	r0h, @byte_ffe408
		mov	r0h, @byte_ffff0c:8
		bset	#6, @byte_ffff0c:8
		bclr	#7, @byte_ffff0b:8
		mov	#500, r1		; 500 ms
		mov	r1, @typematicDelay
		mov	#92, r1			;  92 ms = 10.9 cps
		mov	r1, @typematicIntvl
		jsr	sub_020de

		rts

; ----------------------------------------------

		stm	er0-er3, @-sp
		mov	#6, r0h

loc_02ed6:	bset	r0h, @byte_ffff0c:8

loc_02eda:	mov	#task03o, r0h
		jsr	schedBackTask

		ldm	@sp+, er0-er3
		rts


sub_02ee6:	stm	er0-er3, @-sp
		mov	#6, r0h

loc_02eec:	bclr	r0h, @byte_ffff0c:8
		bra	loc_02eda


sub_02ef2:	stm	er0-er3, @-sp
		mov	#5, r0h
		bra	loc_02ed6


sub_02efa:	stm	er0-er3, @-sp
		mov	#5, r0h
		bra	loc_02eec


sub_02f02:	stm	er0-er3, @-sp
		mov	#4, r0h
		bra	loc_02ed6


sub_02f0a:	stm	er0-er3, @-sp
		mov	#4, r0h
		bra	loc_02eec

; ----------------------------------------------

sub_02f12:	bild	#4, @byte_ffff0c:8
		rts

; ----------------------------------------------

sub_02f18:	mov	#0, r0h
		mov	r0h, @byte_ffe408
		rts

; ----------------------------------------------

sub_02f22:	mov	r0, @typematicDelay
		mov	r1, @typematicIntvl
		rts

; ----------------------------------------------

task03:		mov	@byte_ffff0c:8, r0h
		and	#0x70, r0h
		bne	loc_03040:16

		btst	#3, @byte_ffff0c:8
		beq	loc_02fda:16

		set	i
		mov	@byte_ffe400, r0h
		beq	loc_02f50

		clr	i
		bra	loc_02fda:16

loc_02f50:	bclr	#3, @byte_ffff0c:8
		mov	@curScanRead +  0, r0
		mov	r0, @prevScanRead +  0
		mov	@curScanRead +  2, r0
		mov	@curScanRead +  4, r1
		mov	@curScanRead +  6, r2
		mov	@curScanRead +  8, r3
		mov	@curScanRead + 10, r4
		mov	@curScanRead + 12, r5
		mov	@curScanRead + 14, r6
		clr	i
		mov	r0, @prevScanRead +  2
		mov	r1, @prevScanRead +  4
		mov	r2, @prevScanRead +  6
		mov	r3, @prevScanRead +  8
		mov	r4, @prevScanRead + 10
		mov	r5, @prevScanRead + 12
		mov	r6, @prevScanRead + 14
		jsr	checkKeyCount

		bcc	loc_02fd2

		btst	#7, @byte_ffff0c:8
		bne	loc_02fcc

		mov	#task03o, r0h
		mov	#0, r1
		jsr	schedBackTaskDelayed

loc_02fcc:	bset	#7, @byte_ffff0c:8
		bra	loc_02fda

loc_02fd2:	bclr	#7, @byte_ffff0c:8
		jsr	sub_0304a

loc_02fda:	btst	#7, @byte_ffff0c:8
		bne	loc_02fea

		mov	@byte_ffe408, r0h
		bmi	loc_03040

		beq	loc_03040

loc_02fea:	mov	#task03o, r0h
		jsr	checkSchedTask

		bcc	loc_03040

		btst	#7, @byte_ffff0c:8
		beq	loc_03010

		jsr	sub_02742

		mov	#0, r0h
		mov	r0h, @byte_ffe408
		mov	#task03o, r0h
		mov	#750, r1
		jsr	schedBackTaskDelayed

		bra	loc_03040

loc_03010:	mov	@byte_ffe408, r0h
		bmi	loc_03040

		beq	loc_03040

		jsr	sub_024b8

		bcc	loc_03038

		mov	@byte_ffe408, r0h
		jsr	sub_02242

		mov	#task03o, r0h
		mov	@typematicIntvl, r1
		jsr	schedBackTaskDelayed

		bra	loc_03040

loc_03038:	mov	#0, r0h
		mov	r0h, @byte_ffe408

loc_03040:	mov	#task03o, r0h
		jsr	schedFrontTask

		clr	c
		rts

; ----------------------------------------------

sub_0304a:	mov	#15 + 1, er1

loc_03050:	mov	@(prevScanRead,er1), r2h
		mov	@(prePrevScanRead,er1), r2l
		xor	r2h, r2l
		beq	loc_0312c:16

		mov	#7, r3l

loc_03068:	btst	r3l, r2l
		beq	loc_0311e:16

		mov	er1, er4
		shal	r4l
		shal	r4l
		shal	r4l
		add	r3l, r4l
		jsr	sub_07a8a

		btst	r3l, r2h
		beq	loc_030ac

		cmp	#0x80, r4l
		bhs	loc_030ac

		push	er1
		push	er2
		push	er3
		push	er4
		mov	r4l, r0h
		jsr	sub_0790e

		pop	er4
		pop	er3
		pop	er2
		pop	er1
		mov	r0h, r4l

loc_030ac:	mov	@keyLocTabPtr, er0
		add	r4, r0
		bcc	loc_030ba

		inc	#1, e0

loc_030ba:	cmp	#-1, r4l
		beq	loc_0311e

		mov	@er0, r0h
		beq	loc_0311e

.if !type1R
		mov	#77, r0l		; Access key location
		cmp	r0l, r0h
		bne	loc_030e6

		btst	r3l, r2h
		beq	loc_030e0

		mov	#0x2b, r0h
		mov	@byte_ffe5ed, r0l	; 0x8e
		beq	loc_030d8

		mov	r0l, r0h

loc_030d8:	mov	r0h, @byte_ffe403
		bra	loc_030e6

loc_030e0:	mov	@byte_ffe403, r0h
.endif

loc_030e6:	btst	r3l, r2h
		bne	loc_030ec

		bset	#7, r0h

loc_030ec:	push	er1
		push	er2
		push	er3
		jsr	sub_02196

		btst	#7, r0h
		bne	loc_03112

		mov	r0h, @byte_ffe408
		mov	#task03o, r0h
		mov	@typematicDelay, r1
		jsr	schedBackTaskDelayed

loc_03112:	pop	er3
		pop	er2
		pop	er1

loc_0311e:	dec	r3l
		bpl	loc_03068:16

		mov	r2h, @(prePrevScanRead,er1)

loc_0312c:	dec	r1l
		bmi	rts_03134

		bra	loc_03050:16

rts_03134:	rts

; ----------------------------------------------

sub_03136:	cmp	#0, r0h
		beq	loc_031a0

		mov	r0h, r0l
		bclr	#7, r0l
		cmp	#0x14, r0l
		bhs	loc_0319e

		mov	r0l, r1h
		mov	r0l, r2l
		and	#7, r1h
		shlr	r2l
		shlr	r2l
		shlr	r2l
		mov	#0, r2h
		mov	#0, e2
		mov	@(byte_ffe404,er2), r1l
		bclr	r1h, r1l
		btst	#7, r0h
		bne	loc_03164

		bset	r1h, r1l

loc_03164:	mov	r1l, @(byte_ffe404,er2)
		mov	#0x59, r1h
		mov	r0h, r1l
		bclr	#7, r1l
		add	r1h, r1l
		bld	#7, r0h
		bst	#7, r1l
		mov	r1l, r0h
		mov	r0h, @byte_ffe408
		push	er0
		mov	#task03o, r0h
		mov	@typematicDelay, r1
		jsr	schedBackTaskDelayed

		pop	er0
		jsr	sub_02196

		mov	r0h, @byte_ffe408

loc_0319e:	bra	rts_031ac

loc_031a0:	jsr	sub_02742

		mov	#0, r0h
		mov	r0h, @byte_ffe408

rts_031ac:	rts

; ----------------------------------------------

sub_031ae:	mov	#0, r0h
		mov	#0, er1
		mov	#4, r0l

loc_031b8:	mov	@(byte_ffe404,er1), r2h
		beq	loc_031d2

		mov	#0, r2l

loc_031c4:	btst	r2l, r2h
		bne	loc_031de

		inc	r0h
		inc	r2l
		cmp	#8, r2l
		blo	loc_031c4

		bra	loc_031d4

loc_031d2:	add	#8, r0h

loc_031d4:	inc	#1, er1
		dec	r0l
		bne	loc_031b8

		set	c
		rts


loc_031de:	clr	c
		rts

; ----------------------------------------------

checkKeyCount:	mov	#prevScanRead, er0
		mov	#16, r1h
		mov	#0, r1l

loc_031ec:	mov	@er0+, r2l
		beq	loc_0321e

		mov	r2l, r3h
		xor	r1l, r2l
		not	r2l
		and	r1l, r2l
		beq	loc_0321c

		mov	#0, r4h
		mov	#0, e4
		mov	r3h, r4l
		shlr	r4l
		shlr	r4l
		shlr	r4l
		mov	@(byte_0326c,er4), r2l
		mov	r3h, r2h
		and	#7, r2h
		btst	r2h, r2l
		beq	loc_0321c

		set	c
		bra	loc_03224

loc_0321c:	or	r3h, r1l

loc_0321e:	dec	r1h
		bne	loc_031ec

		clr	c

loc_03224:	bcs	rts_0326a

		mov	#prevScanRead + 15, er0
		mov	#16, r1h
		mov	#0, r1l

loc_03230:	mov	@er0, r2l
		subs	#1, er0
		beq	loc_03264

		mov	r2l, r3h
		xor	r1l, r2l
		not	r2l
		and	r1l, r2l
		beq	loc_03262

		mov	#0, r4h
		mov	#0, e4
		mov	r3h, r4l
		shlr	r4l
		shlr	r4l
		shlr	r4l
		mov	@(byte_0326c,er4), r2l
		mov	r3h, r2h
		and	#7, r2h
		btst	r2h, r2l
		beq	loc_03262

		set	c
		bra	rts_0326a

loc_03262:	or	r3h, r1l

loc_03264:	dec	r1h
		bne	loc_03230

		clr	c

rts_0326a:	rts


byte_0326c:	.byte ~0b00010111, ~1, ~1, ~0, ~1, ~0, ~0, ~0
		.byte          ~1, ~0, ~0, ~0, ~0, ~0, ~0, ~0
		.byte          ~1, ~0, ~0, ~0, ~0, ~0, ~0, ~0
		.byte          ~0, ~0, ~0, ~0, ~0, ~0, ~0, ~0

; ----------------------------------------------

sub_0328c:	set	i
		bld	#7, @byte_ffff0b:8
		bset	#7, @byte_ffff0b:8
		clr	i
		bst	#0, r0h
		bld	#6, @byte_ffff0c:8
		bset	#6, @byte_ffff0c:8
		bst	#1, r0h
		mov	r0h, @byte_ffe40b
		mov	#0, r0h
		mov	r0h, @peddr		; Port E Data Direction Register
		mov	r0h, @pfddr		; Port F Data Direction Register
		rts

; ----------------------------------------------

sub_032b6:	mov	@byte_ffe40b, r0h
		bld	#0, r0h
		bst	#7, @byte_ffff0b:8
		bld	#1, r0h
		bst	#6, @byte_ffff0c:8
		rts

; ----------------------------------------------

		mov	@keyLocTabPtr, er1
		mov	#0, r2h

loc_032d4:	mov	@er1+, r2l
		beq	loc_032dc

		cmp	r0h, r2l
		beq	loc_032e2

loc_032dc:	inc	r2h
		bpl	loc_032d4

		mov	#-1, r2h

loc_032e2:	mov	r2h, r0h
		rts

; ----------------------------------------------

getKeyLoc:	cmp	#128, r0h
		bhs	loc_032fe

		mov	@keyLocTabPtr, er1
		add	r0h, r1l
		addx	#0, r1h
		bcc	loc_032fa

		inc	#1, e1

loc_032fa:	mov	@er1, r0h
		bra	rts_03300

loc_032fe:	mov	#0, r0h

rts_03300:	rts

; ----------------------------------------------

		mov	r0h, r1l
		and	#7, r0h
		shlr	r1l
		shlr	r1l
		shlr	r1l
		mov	#0, r1h
		mov	#0, e1
		mov	@(prePrevScanRead,er1), r0l
		btst	r0h, r0l
		beq	loc_03322

		clr	c
		bra	rts_03324

loc_03322:	set	c

rts_03324:	rts

; ----------------------------------------------

rts_03326:	rts

; ----------------------------------------------

sub_03328:	bset	#7, @byte_ffff0b:8
		rts

; ----------------------------------------------

sub_0332e:	mov	#prePrevScanRead, er1
		mov	#16, r0h

loc_03336:	mov	@er1+, r0l
		bne	loc_0333e

		dec	r0h
		bne	loc_03336

loc_0333e:	bne	loc_03344

		set	c
		bra	rts_03346

loc_03344:	clr	c

rts_03346:	rts

; ----------------------------------------------

sub_03348:	mov	@byte_ffe409, r0h
		cmp	#7, r0h
		bne	loc_03356

		set	c
		bra	rts_03358

loc_03356:	clr	c

rts_03358:	rts

; ----------------------------------------------

sub_0335a:	and	#7, r0h
		mov	r0h, @byte_ffe409
		cmp	#7, r0h
		bne	loc_0336c

		jsr	sub_03328

		bra	rts_03398

loc_0336c:	mov	r0h, r1l
		mov	#0, r1h
		mov	#0, e1
		mov	@(byte_0339a,er1), r0h
		push	er0
		and	#7, r0h
		jsr	rts_03326

		pop	er0
		shlr	r0h
		shlr	r0h
		shlr	r0h
		shlr	r0h
		and	#7, r0h
		jsr	sub_02a00

rts_03398:	rts


byte_0339a:	.byte 0x00, 0x12, 0x01, 0x22, 0x20, 0x02, 0x21, 0x00

; ----------------------------------------------

sub_033a2:	mov	@byte_ffe409, r0l
		and	#7, r0l
		mov	#0, r0h
		mov	#0, e1
		mov	@(byte_0339a,er0), r0h
		rts

; ----------------------------------------------

sub_033ba:	mov	@byte_ffe409, r0h
		rts

; ----------------------------------------------

sub_033c2:	b set	p10pcr			; Pin P10/PW0 (Port 1 Pull-Up MOS Control Register)
		b set	p11pcr			; Pin P11/PW1 (Port 1 Pull-Up MOS Control Register)
		b set	p12pcr			; Pin P12/PW2 (Port 1 Pull-Up MOS Control Register)
		jsr	delay25

		mov	@p1dr:8, r0h		; Port 1 Data Register
		and	#7, r0h
		b clr	p10pcr			; Pin P10/PW0 (Port 1 Pull-Up MOS Control Register)
		b clr	p11pcr			; Pin P11/PW1 (Port 1 Pull-Up MOS Control Register)
		b clr	p12pcr			; Pin P12/PW2 (Port 1 Pull-Up MOS Control Register)
		push	er0
		bld	#2, r0h
		bst	#3, @byte_ffff0b:8
		jsr	sub_10fec

		pop	er0
		bclr	#2, r0h
		push	er0
		jsr	sub_10ed8

		pop	er0
		jmp	sub_0335a

; ----------------------------------------------

sub_03406:	set	c
		bra	loc_0340c

sub_0340a:	clr	c

loc_0340c:	mov	@byte_ffe40a, r0h
		bmi	rts_03430

		mov	#byte_ffe94c, er1
		bcc	loc_03422

		bset	r0h, @er1
		bra	loc_03426

loc_03422:	bclr	r0h, @er1

loc_03426:	bset	#3, @byte_ffff0c:8
		mov	#task03o, r0h
		jsr	schedBackTask

rts_03430:	rts

; ----------------------------------------------

sub_03432:	mov	@byte_ffe40a, r0h
		bmi	loc_03468

		mov	#byte_ffe93a, er1
		btst	r0h, @er1
		bne	loc_03468

		bset	r0h, @er1
		mov	@keyLocTabPtr, er1
		add	#0x80, er1
		add	r0h, r1l
		addx	#0, r1h
		bcc	loc_03460

		inc	#1, e1

loc_03460:	mov	@er1, r0h
		beq	loc_03468

		jsr	sub_02196

loc_03468:	bra	sub_03406

; ----------------------------------------------

sub_0346a:	cmp	#0, r0h
		beq	loc_03472

		cmp	#6, r0h
		bne	rts_03492

loc_03472:	bhi	rts_03492

		dec	r0h
		mov	@byte_ffe40a, r0l
		bmi	loc_0348c

		cmp	r0h, r0l
		beq	loc_0348c

		mov	#byte_ffe94c, er1
		bclr	r0l, @er1

loc_0348c:	mov	r0h, @byte_ffe40a

rts_03492:	rts

; ----------------------------------------------

chkIfVolAccKey:	btst	#2, @byte_ffff0b:8
		beq	loc_034be

		mov	@volAccKeyTabPtr, er1
		mov	r0h, r0l
		shlr	r0l
		shlr	r0l
		shlr	r0l
		add	r0l, r1l
		addx	#0, r1h
		bcc	loc_034b2

		inc	#1, e1

loc_034b2:	and	#7, r0h
		btst	r0h, @er1
		beq	loc_034be

		clr	c
		bra	rts_034c0

loc_034be:	set	c

rts_034c0:	rts

; ----------------------------------------------

sub_034c2:	btst	#7, r0h
		beq	loc_034ca

		mov	#0, r0

loc_034ca:	mov	r0, @word_ffe928
		rts

; ----------------------------------------------

sub_034d2:	bild	#3, @byte_ffff0b:8
		rts

; ----------------------------------------------

sub_034d8:	set	c
		bra	loc_034de

sub_034dc:	clr	c

loc_034de:	bst	#2, @byte_ffff0b:8
		rts

; ----------------------------------------------

sub_034e4:	jsr	sub_035f0

		mov	#0x10, r1h

loc_034ea:	mov	@byte_ffe41e, r1l
		mov	@byte_ffe420, r0l
		cmp	r1h, r0l
		bhs	loc_03522

		mov	#0, r1h
		mov	#0, e1
		mov	r0h, @(byte_ffe40d,er1)
		inc	r1l
		inc	r0l
		cmp	#0x11, r1l
		bne	loc_03512

		mov	#0, r1l

loc_03512:	mov	r1l, @byte_ffe41e
		mov	r0l, @byte_ffe420
		clr	c
		bra	rts_03524

loc_03522:	set	c

rts_03524:	rts


sub_03526:	jsr	sub_035f0

		mov	#0x11, r1h
		bra	loc_034ea

; ----------------------------------------------

sub_0352e:	jsr	sub_035f0

		btst	#7, @byte_ffff0d
		beq	loc_0354c

		mov	@byte_ffe40c, r0h
		bclr	#7, @byte_ffff0d
		bra	rts_03584

loc_0354c:	mov	@byte_ffe420, r0l
		beq	loc_03582

		mov	@byte_ffe41f, r1l
		mov	#0, r1h
		mov	#0, e1
		mov	@(byte_ffe40d,er1), r0h
		inc	r1l
		dec	r0l
		cmp	#0x11, r1l
		bne	loc_03572

		mov	#0, r1l

loc_03572:	mov	r1l, @byte_ffe41f
		mov	r0l, @byte_ffe420
		clr	c
		bra	rts_03584

loc_03582:	set	c

rts_03584:	rts

; ----------------------------------------------

sub_03586:	jsr	sub_035f0

		btst	#7, @byte_ffff0d
		beq	loc_0359c

		mov	@byte_ffe40c, r0h
		bra	rts_035be

loc_0359c:	mov	@byte_ffe420, r0l
		beq	loc_035bc

		mov	@byte_ffe41f, r1l
		mov	#0, r1h
		mov	#0, e1
		mov	@(byte_ffe40d,er1), r0h
		clr	c
		bra	rts_035be

loc_035bc:	set	c

rts_035be:	rts

; ----------------------------------------------

sub_035c0:	jsr	sub_035f0

		mov	#0x10, r0h
		mov	@byte_ffe420, r0l
		sub	r0l, r0h
		bcc	rts_035d2

		mov	#0, r0h

rts_035d2:	rts

; ----------------------------------------------

sub_035d4:	mov	#0, r0h
		mov	r0h, @byte_ffff0d
		mov	r0h, @byte_ffe41e
		mov	r0h, @byte_ffe41f
		mov	r0h, @byte_ffe420
		rts

; ----------------------------------------------

sub_035f0:	btst	#5, @byte_ffff0d
		beq	rts_03604

		push	er0
		bsr	sub_035d4

		pop	er0

rts_03604:	rts

; ----------------------------------------------

sub_03606:	bset	#5, @byte_ffff0d
		rts

; ----------------------------------------------

sub_03610:	push	er3
		mov	r0l, r2l
		mov	r2l, r3l
		and	#3, r2l
		shll	r2l
		shlr	r3l
		shlr	r3l
		mov	#0, r3h
		mov	#0, e3
		mov	@(byte_ffe44f,er3), r3h
		mov	#0, r2h
		btst	r2l, r3h
		beq	loc_03636

		bset	#0, r2h

loc_03636:	inc	r2l
		btst	r2l, r3h
		beq	loc_0363e

		bset	#1, r2h

loc_0363e:	pop	er3
		rts

; ----------------------------------------------

sub_03644:	stc	ccr, r0l
		set	i
		bld	#0, @byte_ffff0e
		bclr	#0, @byte_ffff0e
		bst	#0, r1l
		ldc	r0l, ccr
		bld	#0, r1l
		rts

; ----------------------------------------------

sub_03660:	mov	r0h, r1l
		and	#3, r0h
		shll	r0h
		shlr	r1l
		shlr	r1l
		mov	#0, r1h
		mov	#0, e1
		stc	ccr, r0l
		set	i
		mov	@(byte_ffe427,er1), r2h
		mov	r2h, r2l
		bclr	r0h, r2h
		mov	r2h, @(byte_ffe427,er1)
		mov	@(byte_ffe44f,er1), r2h
		ldc	r0l, ccr
		mov	r0h, r0l
		mov	#0, r0h
		btst	r0l, r2h
		beq	loc_0369c

		bset	#0, r0h

loc_0369c:	inc	r0l
		btst	r0l, r2h
		beq	loc_036a4

		bset	#1, r0h

loc_036a4:	btst	r0l, r2l
		beq	loc_036aa

		bset	#7, r0h

loc_036aa:	dec	r0l
		clr	c
		btst	r0l, r2l
		beq	rts_036b4

		set	c

rts_036b4:	rts

; ----------------------------------------------

sub_036b6:	mov	#0, r0l
		bra	loc_036c2

sub_036ba:	mov	#3, r0l
		bra	loc_036c2

sub_036be:	mov	#1, r0l
		bra	loc_036c2

loc_036c2:	cmp	#0xa0, r0h
		bhs	rts_03740

		mov	r0h, r1l
		bclr	#7, r1l
		mov	r1l, r2l
		and	#3, r2l
		shll	r2l
		shlr	r1l
		shlr	r1l
		mov	#0, r1h
		mov	#0, e1
		mov	@(byte_ffe44f,er1), r2h
		bclr	r2l, r2h
		bld	#0, r0l
		bcc	loc_036ea

		bset	r2l, r2h

loc_036ea:	inc	r2l
		bclr	r2l, r2h
		bld	#1, r0l
		bcc	loc_036f4

		bset	r2l, r2h

loc_036f4:	mov	r2h, @(byte_ffe44f,er1)
		mov	r0h, r1l
		bclr	#7, r1l
		mov	r1l, r2l
		and	#3, r2l
		shll	r2l
		shlr	r1l
		shlr	r1l
		mov	#0, r1h
		mov	#0, e1
		stc	ccr, r0l
		set	i
		mov	@(byte_ffe427,er1), r2h
		bset	r2l, r2h
		inc	r2l
		bset	r2l, r2h
		mov	r2h, @(byte_ffe427,er1)
		ldc	r0l, ccr
		set	i
		bset	#7, @byte_ffff0e
		bset	#0, @byte_ffff0e
		ldc	r0l, ccr

rts_03740:	rts

; ----------------------------------------------

sub_03742:	push	er0
		mov	#byte_ffe44f, er1
		mov	#byte_037f0, er2
		mov	#0x28, r0h

loc_03754:	mov	@er2+, r0l
		mov	r0l, @er1
		adds	#1, er1
		dec	r0h
		bne	loc_03754

		jsr	sub_03786

		stc	ccr, r0h
		set	i
		mov	#0, r2h
		mov	r2h, @byte_ffe426
		bset	#3, @byte_ffff0e
		bset	#7, @byte_ffff0e
		ldc	r0h, ccr
		pop	er0
		rts

; ----------------------------------------------

sub_03786:	mov	#0, er2

loc_0378c:	mov	r2h, @(byte_ffe427,er2)
		inc	r2l
		cmp	#0x28, r2l
		bne	loc_0378c

		rts

; ----------------------------------------------

sub_0379c:	mov	#0x00, r1l
		mov	#1, r1h

loc_037a0:	mov	#0, er2

loc_037a6:	mov	r1l, @(byte_ffe44f,er2)
		inc	r2l
		cmp	#0x28, r2l
		bne	loc_037a6

		push	er1
		jsr	sub_03786

		pop	er1
		stc	ccr, r1l
		set	i
		mov	r1h, @byte_ffe426
		bset	#3, @byte_ffff0e
		bset	#7, @byte_ffff0e
		ldc	r1l, ccr
		rts


sub_037de:	mov	#0xff, r1l
		mov	#2, r1h
		bra	loc_037a0


sub_037e4:	mov	#0x55, r1l
		mov	#3, r1h
		bra	loc_037a0


sub_037ea:	mov	#0xaa, r1l
		mov	#4, r1h
		bra	loc_037a0


byte_037f0:	.byte 0x00, 0x40, 0x01, 0x40, 0x3c, 0x43, 0x0c, 0x40
		.byte 0x00, 0x40, 0x00, 0x40, 0x00, 0x40, 0x04, 0x40
		.byte 0x00, 0x40, 0x00, 0x40, 0x00, 0x50, 0x0d, 0x50
		.byte 0x10, 0x44, 0x44, 0x55, 0x55, 0x55, 0x14, 0x14
		.byte 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

; ----------------------------------------------

sub_03818:	mov	#0, r0h

loc_0381a:	mov	r0h, r1l
		bclr	#7, r1l
		mov	r1l, r2l
		and	#3, r2l
		shll	r2l
		inc	r2l
		shlr	r1l
		shlr	r1l
		mov	#0, r1h
		mov	#0, e1
		stc	ccr, r0l
		set	i
		mov	@(byte_ffe427,er1), r2h
		btst	r2l, r2h
		beq	loc_0384c

		dec	r2l
		bset	r2l, r2h
		mov	r2h, @(byte_ffe427,er1)

loc_0384c:	ldc	r0l, ccr
		inc	r0h
		cmp	#0xa0, r0h
		blo	loc_0381a

		mov	#-1, r0h
		mov	r0h, @byte_ffff0e
		mov	@typematic, r0h
		jsr	setTypematic

		mov	@byte_ffe424, r0h
		jsr	sub_05ce2

		rts

; ----------------------------------------------

sub_03872:	cmp	#0, r0h
		beq	sub_038ac

		cmp	#4, r0h
		bhs	loc_03882

		mov	r0h, r0l
		bsr	sub_038bc

		clr	c
		bra	loc_038aa

loc_03882:	mov	@byte_ffe421, r0l
		btst	#6, r0l
		bne	loc_038a8

		cmp	#0x81, r0h
		beq	loc_03898

		cmp	#0x82, r0h
		beq	loc_03898

		cmp	#0x8a, r0h
		bne	loc_038a8

loc_03898:	mov	r0h, r0l
		bclr	#7, r0h
		cmp	#0x0a, r0h
		bne	loc_038a2

		mov	#3, r0h

loc_038a2:	bsr	sub_038bc

		clr	c
		bra	loc_038aa

loc_038a8:	set	c

loc_038aa:	bra	rts_038ba

; ----------------------------------------------

sub_038ac:	mov	@byte_ffe422, r0h
		mov	@byte_ffe423, r0l
		clr	c

rts_038ba:	rts

; ----------------------------------------------

sub_038bc:	stc	ccr, r1h
		set	i
		bset	#6, @byte_ffff0e
		bset	#7, @byte_ffff0e
		mov	r0h, @byte_ffe422
		mov	r0l, @byte_ffe423
		ldc	r1h, ccr
		rts

; ----------------------------------------------

sub_038e0:	stc	ccr, r1h
		set	i
		bld	#6, @byte_ffff0e
		bclr	#6, @byte_ffff0e
		mov	@byte_ffe422, r0h
		mov	@byte_ffe423, r0l
		bst	#0, r1h
		ldc	r1h, ccr
		rts

; ----------------------------------------------

sub_03906:	stc	ccr, r0l
		set	i
		bset	#5, @byte_ffff0e
		bset	#7, @byte_ffff0e
		mov	r0h, @byte_ffe424
		ldc	r0l, ccr
		rts

; ----------------------------------------------

sub_03924:	mov	@byte_ffe424, r0h
		rts

; ----------------------------------------------

sub_0392c:	stc	ccr, r1h
		set	i
		bld	#5, @byte_ffff0e
		bclr	#5, @byte_ffff0e
		mov	@byte_ffe424, r0h
		bst	#0, r0l
		ldc	r1h, ccr
		bld	#0, r0l
		rts

; ----------------------------------------------

sub_0394e:	stc	ccr, r0l
		set	i
		bset	#4, @byte_ffff0e
		bset	#7, @byte_ffff0e
		mov	r0h, @typematic
		ldc	r0l, ccr
		rts

; ----------------------------------------------

		mov	@typematic, r0h
		rts

; ----------------------------------------------

sub_03974:	stc	ccr, r1h
		set	i
		bld	#4, @byte_ffff0e
		bclr	#4, @byte_ffff0e
		mov	@typematic, r0h
		bst	#0, r0l
		ldc	r1h, ccr
		bld	#0, r0l
		rts

; ----------------------------------------------

sub_03996:	stc	ccr, r1h
		set	i
		bld	#3, @byte_ffff0e
		bclr	#3, @byte_ffff0e
		mov	@byte_ffe426, r0h
		bst	#0, r0l
		ldc	r1h, ccr
		bld	#0, r0l
		rts

; ----------------------------------------------

sub_039b8:	stc	ccr, r0l
		set	i
		bset	#1, @byte_ffff0e
		bset	#7, @byte_ffff0e
		mov	@byte_ffe421, r1h
		bclr	#7, r1h
		mov	r1h, @byte_ffe421
		ldc	r0l, ccr
		jsr	sub_02f0a

		rts

; ----------------------------------------------

sub_039e2:	stc	ccr, r0l
		set	i
		bset	#1, @byte_ffff0e
		bset	#7, @byte_ffff0e
		mov	@byte_ffe421, r1h
		bset	#7, r1h
		mov	r1h, @byte_ffe421
		ldc	r0l, ccr
		jsr	sub_02f02

		rts

; ----------------------------------------------

		mov	@byte_ffe421, r0l
		bld	#7, r0l
		rts

; ----------------------------------------------

sub_03a16:	stc	ccr, r1h
		set	i
		bld	#1, @byte_ffff0e
		bclr	#1, @byte_ffff0e
		mov	@byte_ffe421, r0h
		bst	#0, r0l
		ldc	r1h, ccr
		bld	#7, r0h
		bst	#0, r0h
		bld	#0, r0l
		rts

; ----------------------------------------------

sub_03a3c:	stc	ccr, r1h
		set	i
		bld	#2, @byte_ffff0e
		bclr	#2, @byte_ffff0e
		bst	#0, r0l
		ldc	r1h, ccr
		bld	#0, r0l
		rts

; ----------------------------------------------

sub_03a58:	stc	ccr, r1h
		set	i
		bld	#7, @byte_ffff0e
		bclr	#7, @byte_ffff0e
		bst	#0, r0l
		ldc	r1h, ccr
		bld	#0, r0l
		rts

; ----------------------------------------------

sub_03a74:	jsr	sub_03742

		mov	#0x2b, r0h		; 500 ms, 10.9 cps
		mov	r0h, @typematic
		mov	#2, r0h
		mov	r0h, @byte_ffe422
		mov	r0h, @byte_ffe423
		mov	#0, r0h
		mov	r0h, @byte_ffe424
		mov	r0h, @byte_ffe421
		bset	#2, r0h
		bset	#7, r0h
		mov	r0h, @byte_ffff0e
		rts

; ----------------------------------------------

off_03aa8:	.long byte_ffe421, byte_ffe477, NULL

; ----------------------------------------------

sub_03ab4:	mov	#off_03aa8, er0
		jmp	loc_0182e

; ----------------------------------------------

sub_03abe:	mov	#off_03aa8, er0
		jmp	loc_01846

; ----------------------------------------------

sub_03ac8:	jmp	sub_01862

; ----------------------------------------------

sub_03acc:	mov	#off_03aa8, er1
		jmp	loc_018ae

; ----------------------------------------------

sub_03ad6:	jsr	sub_018ca

		bcc	rts_03ae2

		jsr	sub_03818

		set	c

rts_03ae2:	rts

; ----------------------------------------------

enableLPC1:	b clr	mstpcrl.mstp0		; LPC, WUEMRB (Module Stop Control Register L)
		b set	hicr_0.lpc1e		; LPC Channel 1 Enable (0x60/0x64) (LPC Host Interface Control Register 0)
		mov	#0, r0h
		mov	#0x30, r0l
		mov	#byte_ffe4aa, er1

loc_03af8:	mov	r0h, @-er1
		dec	r0l
		bne	loc_03af8

		mov	r0h, @str1		; LPC Status Register 1 (0x64)
		mov	r0h, @byte_ffff0f
		mov	r0h, @byte_ffff10
		bsr	sub_03b3c

		mov	#0x10, r0h
		mov	r0h, @str1		; LPC Status Register 1 (0x64)
		mov	#0x30, r0h
		mov	r0h, @byte_ffe47a
		mov	#0x55, r0h
		mov	r0h, @odr1		; LPC Output Data Register 1 (0x60)
		b set	hicr_2.ibfie1		; IDR1 Receive Completion Interrupt Enable (LPC Host Interface Control Register 2)
		mov	#0, r0h
		mov	r0h, @byte_ffe4b0
		mov	#1, r0h
		mov	r0h, @byte_ffe47b
		rts

; ----------------------------------------------

sub_03b3c:	setOutH 4 0			; Pin P40/TMCI0/TxD2/IrTxD

		b clr	sirqcr0.irq12e1		; Host IRQ12 Interrupt Enable 1 (LPC SERIRQ Control Register 0)
		b clr	sirqcr0.irq1e1		; Host IRQ1 Interrupt Enable 1 (LPC SERIRQ Control Register 0)

loc_03b58:	setOutH 8 1			; Pin P81/-CS2/GA20

		b ld	p81dr			; Pin P81/-CS2/GA20 (Port 8 Data Register)
		bst	#3, @byte_ffff0f
		rts

; ----------------------------------------------

sub_03b76:	setInH	4 0			; Pin P40/TMCI0/TxD2/IrTxD

		b ld	p81dr			; Pin P81/-CS2/GA20 (Port 8 Data Register)
		bst	#3, @byte_ffff0f
		setInH	8 1			; Pin P81/-CS2/GA20

		b clr	hicr_0.lpc1e		; LPC Channel 1 Enable (0x60/0x64) (LPC Host Interface Control Register 0)
		rts

; ----------------------------------------------

sub_03bae:	bsr	sub_03b3c

		b set	hicr_0.lpc1e		; LPC Channel 1 Enable (0x60/0x64) (LPC Host Interface Control Register 0)
		mov	#0, r0h
		mov	r0h, @byte_ffe4b0
		bclr	#2, @byte_ffff0f
		b set	str1.burst		; Burst Mode For Polled Command Processing (LPC Status Register 1 (0x64))
		rts

; ----------------------------------------------

		mov	#byte_03c0c, er1
		mov	@byte_ffe4aa, r2h
		mov	#6, r2l

loc_03bdc:	shll	r2h
		bcc	loc_03c04

		mov	@er1, r0h
		push	er1
		push	er2
		push	er0
		jsr	sub_024de

		pop	er0
		bset	#7, r0h
		jsr	sub_02196

		pop	er2
		pop	er1

loc_03c04:	adds	#1, er1
		dec	r2l
		bne	loc_03bdc

		rts


byte_03c0c:	.byte 0x2c, 0x39, 0x3a, 0x40, 0x3c, 0x3e

; ----------------------------------------------

task04:		btst	#0, @byte_ffff0f
		beq	loc_03c3a

		mov	@word_ffe952, r0
		jsr	cmpTick

		bcc	loc_03c32

		bclr	#0, @byte_ffff0f
		bra	loc_03c3a

loc_03c32:	jsr	sub_03cd6

		jmp	rts_03cd4

loc_03c3a:	btst	#2, @byte_ffff0f
		bne	loc_03c9a

		mov	@str1, r1h		; LPC Status Register 1 (0x64)
		jsr	sub_04454

		bcs	loc_03c54

		jsr	sub_03e80

		bra	loc_03c92

loc_03c54:	mov	@byte_ffff0f, r1l
		btst	#7, r1l
		beq	loc_03c82

		mov	#0, r0l
		btst	#5, r1l
		beq	loc_03c6c

		btst	#0, r1h
		beq	loc_03c6c

		mov	#-1, r0l
		bra	loc_03c78

loc_03c6c:	btst	#6, r1l
		beq	loc_03c78

		jsr	sub_0447c

		bcc	loc_03c78

		mov	#-1, r0l

loc_03c78:	cmp	#0, r0l
		bne	loc_03c80

		jsr	sub_03ea0

loc_03c80:	bra	loc_03c92

loc_03c82:	jsr	sub_0447c

		bcs	loc_03c90

		jsr	sub_03e22

		jsr	sub_045ce

loc_03c90:	bsr	sub_03cd6

loc_03c92:	b set	hicr_2.ibfie1		; IDR1 Receive Completion Interrupt Enable (LPC Host Interface Control Register 2)
		bra	rts_03cd4

loc_03c9a:	mov	@byte_ffe479, r0h
		cmp	#0x80, r0h
		bne	loc_03cd0

		b tst	str1.obf1		; Output Buffer Full (LPC Status Register 1 (0x64))
		bne	loc_03cd0

		mov	@byte_ffe48e, r0h
		mov	#0, r0l
		jsr	sub_03d98

		bclr	#2, @byte_ffff0f
		b set	str1.burst		; Burst Mode For Polled Command Processing (LPC Status Register 1 (0x64))
		mov	#0, r0h
		mov	r0h, @byte_ffe479
		bra	rts_03cd4

loc_03cd0:	jsr	sub_04b10

rts_03cd4:	rts

; ----------------------------------------------

sub_03cd6:	b tst	str1.obf1		; Output Buffer Full (LPC Status Register 1 (0x64))
		bne	rts_03cfa

		mov	@byte_ffe47a, r0h
		btst	#4, r0h
		bne	loc_03cec

		jsr	sub_04b10

loc_03cec:	mov	@byte_ffe47a, r0h
		btst	#5, r0h
		bne	rts_03cfa

		jsr	sub_09180

rts_03cfa:	rts

; ----------------------------------------------

sub_03cfc:	cmp	#0x80, r0h
		bhs	rts_03d96:16

		mov	@byte_ffe490, r2h
		cmp	r0h, r2h
		beq	rts_03d96:16

		mov	@byte_ffe491, r2h
		cmp	r0h, r2h
		beq	rts_03d96:16

		mov	@byte_ffe479, r1l
		bmi	rts_03d96

		push	er1
		btst	#1, r0l
		bne	loc_03d40

		push	er0
		jsr	sub_0539e

		pop	er0
		bcc	loc_03d40

		mov	#1, r0l
		jsr	sub_02a5e

		bra	loc_03d42

loc_03d40:	mov	#0, r0l

loc_03d42:	pop	er1
		mov	#0, r1h
		mov	#0, e1
		mov	@(byte_ffe49a,er1), r2h
		cmp	r0h, r2h
		beq	loc_03d60

		cmp	#0, r0l
		beq	loc_03d8e

		cmp	r0l, r2h
		bne	loc_03d8e

loc_03d60:	cmp	#0x0f, r1l
		beq	loc_03d6e

		mov	@(byte_ffe49b,er1), r2h
		bne	loc_03d8a

loc_03d6e:	mov	@byte_ffe48e, r0h
		beq	loc_03d7a

		mov	#0x80, r1l
		bra	loc_03d88

loc_03d7a:	bclr	#2, @byte_ffff0f
		b set	str1.burst		; Burst Mode For Polled Command Processing (LPC Status Register 1 (0x64))

loc_03d88:	bra	loc_03d8c

loc_03d8a:	inc	r1l

loc_03d8c:	bra	loc_03d90

loc_03d8e:	mov	#0, r1l

loc_03d90:	mov	r1l, @byte_ffe479

rts_03d96:	rts

; ----------------------------------------------

sub_03d98:	push	er0
		push	er1
		push	er2
		and	#0b11100000, r0l
		mov	@str1, r1h		; LPC Status Register 1 (0x64)
		and	#0b00011111, r1h
		or	r0l, r1h
		bset	#4, r1h
		mov	@byte_ffe47a, r1l
		mov	#-1, r2h
		btst	#5, r0l
		beq	loc_03dde

		mov	@byte_ffe4ae, r2l
		beq	loc_03dce

		dec	r2l
		mov	r2l, @byte_ffe4ae
		bra	loc_03dd6

loc_03dce:	bset	#1, @byte_ffe4ac

loc_03dd6:	btst	#1, r1l
		beq	loc_03ddc

		mov	#1, r2h

loc_03ddc:	bra	loc_03dfe

loc_03dde:	mov	@byte_ffe4ad, r2l
		beq	loc_03df0

		dec	r2l
		mov	r2l, @byte_ffe4ad
		bra	loc_03df8

loc_03df0:	bset	#0, @byte_ffe4ac

loc_03df8:	btst	#0, r1l
		beq	loc_03dfe

		mov	#0, r2h

loc_03dfe:	set	i
		cmp	#-1, r2h
		beq	loc_03e0a

		bset	r2h, @sirqcr0		; LPC SERIRQ Control Register 0

loc_03e0a:	mov	r1h, @str1		; LPC Status Register 1 (0x64)
		mov	r0h, @odr1		; LPC Output Data Register 1 (0x60)
		clr	i
		pop	er2
		pop	er1
		pop	er0
		rts

; ----------------------------------------------

sub_03e22:	bclr	#4, @byte_ffe47a
		jsr	sub_04b44

		jsr	sub_04b10

		mov	#1, r1h
		mov	r1h, @byte_ffe4ad
		bra	loc_03e54

loc_03e3c:	bclr	#5, @byte_ffe47a
		jsr	sub_089a8

		jsr	sub_09180

		mov	#0x14, r1h
		mov	r1h, @byte_ffe4ae

loc_03e54:	bset	#0, @byte_ffff0f
		push	er0
		push	er1
		mov	@tick, r0
		mov	#100, r1
		add	r1, r0
		mov	r0, @word_ffe952
		pop	er1
		pop	er0
		rts

; ----------------------------------------------

sub_03e80:	mov	r0h, @byte_ffe477
		mov	#0, r0l
		mov	r0l, @byte_ffe478
		mov	@byte_ffff0f, r1h
		bclr	#7, r1h
		bclr	#5, r1h
		bclr	#6, r1h
		mov	r1h, @byte_ffff0f

; ----------------------------------------------

sub_03ea0:	mov	@byte_ffe477, r1h
		mov	@byte_ffe478, r1l
		mov	@byte_ffff0f, r2h
		cmp	#0x3f, r1h
		bhi	loc_03ebc

		jsr	sub_04018

		bra	loc_03f02

loc_03ebc:	cmp	#0x7f, r1h
		bhi	loc_03ec6

		jsr	sub_04048

		bra	loc_03f02

loc_03ec6:	cmp	#0xf0, r1h
		blo	loc_03ed0

		jsr	sub_040be

		bra	loc_03f02

loc_03ed0:	mov	r1h, r4l
		shlr	r4l
		shlr	r4l
		shlr	r4l
		shlr	r4l
		and	#7, r4l
		mov	#0, r4h
		mov	#0, e4
		mov	#off_03f2c, er3
		add	er4, er3
		mov	@er3, r4l
		beq	loc_03f02

		add	er4, er3
		mov	r1h, r4l
		and	#0x0f, r4l
		add	er4, er3
		mov	@er3, r4l
		beq	loc_03f02

		add	er4, er3
		mov	@er3, er4
		jsr	@er4

loc_03f02:	mov	r1l, @byte_ffe478
		mov	r2h, @byte_ffff0f
		btst	#7, r2h
		beq	rts_03f2a

		btst	#6, r2h
		beq	rts_03f2a

		set	i
		btst	#7, @byte_ffff11
		bne	loc_03f28

		b set	hicr_2.ibfie1		; IDR1 Receive Completion Interrupt Enable (LPC Host Interface Control Register 2)

loc_03f28:	clr	i

rts_03f2a:	rts

; ----------------------------------------------

; Relative 8-bit Jump/Switch Tables

off_03f2c:					; 0x0x..0x6x (0x2x, 0x4x, 0x5x, 0x6x)
		.irp off, . . off_03f33 . off_03f43 off_03f53 off_03f63
		.byte \off - .
		.endr

off_03f33:					; 0x20..0x2f
		.irp off, . . . . off_03f74 off_03f78 off_03f7c off_03f80 off_03f84 off_03f88 off_03f8c off_03f90 . off_03f94 off_03f98 .
		.byte \off - .
		.endr

off_03f43:					; 0x40..0x4f
		.irp off, off_03f9c off_03fa0 off_03fa4 off_03fa0 . . . . . . . . . . . .
		.byte \off - .
		.endr

off_03f53:					; 0x50..0x5f
		.irp off, off_03fa8 off_03fac off_03fb0 off_03fb4 off_03fb8 . . . . . . . . . . .
		.byte \off - .
		.endr

off_03f63:					; 0x60..0x6f
		.irp off, off_03fbc . . . . . . . . . . . . . . .
		.byte \off - .
		.endr

		.align 1, -1
off_03f74:	.long sub_040f4			; 0x24
off_03f78:	.long sub_04120			; 0x25
off_03f7c:	.long sub_04156			; 0x26
off_03f80:	.long sub_0419a			; 0x27
off_03f84:	.long sub_041b0			; 0x28
off_03f88:	.long sub_03fc0			; 0x29
off_03f8c:	.long sub_04002			; 0x2a
off_03f90:	.long sub_03fc0			; 0x2b
off_03f94:	.long sub_041c6			; 0x2d
off_03f98:	.long sub_041dc			; 0x2e
off_03f9c:	.long sub_041f2			; 0x40
off_03fa0:	.long sub_0422e			; 0x41, 0x43
off_03fa4:	.long sub_0422a			; 0x42
off_03fa8:	.long sub_0425e			; 0x50
off_03fac:	.long sub_042c0			; 0x51
off_03fb0:	.long sub_042d8			; 0x52
off_03fb4:	.long sub_042f0			; 0x53
off_03fb8:	.long sub_04308			; 0x54
off_03fbc:	.long sub_04324			; 0x60

; ----------------------------------------------

sub_03fc0:	cmp	#0, r1l
		bne	loc_03fd4

		b tst	str1.obf1		; Output Buffer Full (LPC Status Register 1 (0x64))
		beq	loc_03fd4

		bset	#7, r2h
		bset	#5, r2h
		inc	r1l
		bra	rts_04000

loc_03fd4:	cmp	#0xa9, r1h
		bne	loc_03fe0

		mov	#sub_09100, er3
		bra	loc_03fe6

loc_03fe0:	mov	#sub_09e76, er3

loc_03fe6:	push	er1
		push	er2
		jsr	@er3

		pop	er2
		pop	er1
		mov	#0, r0l
		jsr	sub_03d98

		bclr	#7, r2h

rts_04000:	rts

; ----------------------------------------------

sub_04002:	push	er1
		push	er2
		jsr	enableLPC1

		pop	er2
		pop	er1
		rts

; ----------------------------------------------

sub_04018:	cmp	#0, r1l
		bne	loc_0402c

		b tst	str1.obf1		; Output Buffer Full (LPC Status Register 1 (0x64))
		beq	loc_0402c

		bset	#7, r2h
		bset	#5, r2h
		inc	r1l
		bra	rts_04046

loc_0402c:	mov	r1h, r3l
		and	#0x1f, r3l
		mov	#0, r3h
		mov	#0, e3
		mov	@(byte_ffe47a,er3), r0h
		mov	#0, r0l
		jsr	sub_03d98

		bclr	#7, r2h

rts_04046:	rts

; ----------------------------------------------

sub_04048:	cmp	#0, r1l
		bne	loc_04054

		bset	#7, r2h
		bset	#6, r2h
		inc	r1l
		bra	rts_04076

loc_04054:	mov	r1h, r3l
		and	#0x1f, r3l
		mov	#0, r3h
		mov	#0, e3
		mov	r0h, @(byte_ffe47a,er3)
		cmp	#0, r3l
		bne	loc_04074

		push	er2
		bsr	sub_04078

		pop	er2

loc_04074:	bclr	#7, r2h

rts_04076:	rts

; ----------------------------------------------

sub_04078:	bld	#2, r0h
		b st	str1.dbu12		; Defined By User (LPC Status Register 1 (0x64))
		push	er0
		btst	#5, r0h
		beq	loc_0408e

		jsr	sub_091c0

		bra	loc_04092

loc_0408e:	jsr	sub_09180

loc_04092:	mov	@sp, er0		; pop+push er0
		btst	#4, r0h
		beq	loc_040a0

		jsr	sub_04b3a

		bra	loc_040a4

loc_040a0:	jsr	sub_04b10

loc_040a4:	pop	er0
		btst	#1, r0h
		bne	loc_040b2

		b clr	sirqcr0.irq12e1		; Host IRQ12 Interrupt Enable 1 (LPC SERIRQ Control Register 0)

loc_040b2:	btst	#0, r0h
		bne	rts_040bc

		b clr	sirqcr0.irq1e1		; Host IRQ1 Interrupt Enable 1 (LPC SERIRQ Control Register 0)

rts_040bc:	rts

; ----------------------------------------------

sub_040be:	mov	#-1 >> 16, e4
		mov	#1, r6h

loc_040c4:	mov	#off_0429c, er3
		mov	#3, r5h

loc_040cc:	btst	r5h, r1h
		bne	loc_040e6

		mov	@er3+, r4h
		mov	@er3+, r4l
		mov	@er3+, r5l
		cmp	#1, r6h
		bne	loc_040e0

		bclr	r5l, @er4
		bra	loc_040e4

loc_040e0:	bset	r5l, @er4

loc_040e4:	bra	loc_040ea

loc_040e6:	adds	#2, er3
		adds	#1, er3

loc_040ea:	dec	r5h
		bpl	loc_040cc

		dec	r6h
		bpl	loc_040c4

		rts

; ----------------------------------------------

sub_040f4:	cmp	#0, r1l
		bne	loc_04108

		b tst	str1.obf1		; Output Buffer Full (LPC Status Register 1 (0x64))
		beq	loc_04108

		bset	#7, r2h
		bset	#5, r2h
		inc	r1l
		bra	rts_0411e

loc_04108:	mov	@byte_ffe49a, r0h
		beq	loc_04114

		mov	#0xfa, r0h
		bra	loc_04116

loc_04114:	mov	#0xf1, r0h

loc_04116:	mov	#0, r0l
		jsr	sub_03d98

		bclr	#7, r2h

rts_0411e:	rts

; ----------------------------------------------

sub_04120:	cmp	#0, r1l
		bne	loc_0412c

		bset	#7, r2h
		bset	#6, r2h
		inc	r1l
		bra	rts_04154

loc_0412c:	cmp	#0x11, r1l
		bhi	loc_0414e

		mov	r1l, r3l
		mov	#0, r3h
		mov	#0, e3
		mov	r0h, @(byte_ffe499,er3)
		inc	r1l
		cmp	#0x11, r1l
		bls	loc_0414e

		mov	r3h, @(byte_ffe499,er3)

loc_0414e:	cmp	#0, r0h
		bne	rts_04154

		bclr	#7, r2h

rts_04154:	rts

; ----------------------------------------------

sub_04156:	cmp	#0, r1l
		bne	loc_04182

		mov	@byte_ffe49a, r0h
		beq	loc_04180

		mov	r1l, @byte_ffe479
		mov	@byte_ffe48d, r0h
		beq	loc_04178

		bset	#7, r2h
		bset	#5, r2h
		inc	r1l
		bra	loc_04180

loc_04178:	b clr	str1.burst		; Burst Mode For Polled Command Processing (LPC Status Register 1 (0x64))
		bset	#2, r2h

loc_04180:	bra	rts_04198

loc_04182:	mov	@byte_ffe48d, r0h
		mov	#0, r0l
		jsr	sub_03d98

		bclr	#7, r2h
		b clr	str1.burst		; Burst Mode For Polled Command Processing (LPC Status Register 1 (0x64))
		bset	#2, r2h

rts_04198:	rts

; ----------------------------------------------

sub_0419a:	bset	#5, @byte_ffe47a
		push	er2
		jsr	sub_091c0

		pop	er2
		rts

; ----------------------------------------------

sub_041b0:	bclr	#5, @byte_ffe47a
		push	er2
		jsr	sub_09180

		pop	er2
		rts

; ----------------------------------------------

sub_041c6:	bset	#4, @byte_ffe47a
		push	er2
		jsr	sub_04b3a

		pop	er2
		rts

; ----------------------------------------------

sub_041dc:	bclr	#4, @byte_ffe47a
		push	er2
		jsr	sub_04b10

		pop	er2
		rts

; ----------------------------------------------

sub_041f2:	cmp	#0, r1l
		bne	loc_04206

		b tst	str1.obf1		; Output Buffer Full (LPC Status Register 1 (0x64))
		beq	loc_04206

		bset	#7, r2h
		bset	#5, r2h
		inc	r1l
		bra	rts_04210

loc_04206:	bsr	sub_04212

		mov	#0, r0l
		jsr	sub_03d98

		bclr	#7, r2h

rts_04210:	rts

; ----------------------------------------------

sub_04212:	mov	#0, r0h
		set	c
		bst	#2, r0h
		b ld	kbcrh_1.kdi		; Keyboard Data In (PS/2 Keyboard Control Register H Channel 1)
		bst	#1, r0h
		b ld	kbcrh_0.kdi		; Keyboard Data In (PS/2 Keyboard Control Register H Channel 0)
		bst	#0, r0h
		rts

; ----------------------------------------------

sub_0422a:	bsr	sub_04212

		bra	loc_04238


sub_0422e:	bsr	sub_04212

		shll	r0h
		shll	r0h
		shll	r0h
		shll	r0h

loc_04238:	mov	@str1, r0l		; LPC Status Register 1 (0x64)
		and	#0x0f, r0l
		and	#0xf0, r0h
		or	r0l, r0h
		mov	r0h, @str1		; LPC Status Register 1 (0x64)
		b tst	str1.ibf1		; Input Buffer Full (LPC Status Register 1 (0x64))
		beq	loc_0425a

		bclr	#7, r2h
		bld	#2, r2h
		b ist	str1.burst		; Burst Mode For Polled Command Processing (LPC Status Register 1 (0x64))
		bra	rts_0425c

loc_0425a:	bset	#7, r2h

rts_0425c:	rts

; ----------------------------------------------

sub_0425e:	cmp	#0, r1l
		bne	loc_04272

		b tst	str1.obf1		; Output Buffer Full (LPC Status Register 1 (0x64))
		beq	loc_04272

		bset	#7, r2h
		bset	#5, r2h
		inc	r1l
		bra	rts_0429a

loc_04272:	mov	#-1 >> 16, e5
		mov	#off_042a8, er3
		mov	#7, r4h

loc_0427e:	mov	@er3+, r5h
		mov	@er3+, r5l
		mov	@er3+, r4l
		btst	r4l, @er5
		beq	loc_0428e

		bset	r4h, r0h
		bra	loc_04290

loc_0428e:	bclr	r4h, r0h

loc_04290:	dec	r4h
		bpl	loc_0427e

		mov	#0, r0l
		jsr	sub_03d98

rts_0429a:	rts

; ----------------------------------------------

off_0429c:	.word kbcrl_1			; PS/2 Keyboard Control Register L Channel 1
		.byte 6
		.word kbcrl_1			; PS/2 Keyboard Control Register L Channel 1
		.byte 5
		.word p8dr			; Port 8 Data Register
		.byte 1
		.word p4dr			; Port 4 Data Register
		.byte 0

off_042a8:	.word kbcrh_0			; PS/2 Keyboard Control Register H Channel 0
		.byte 5
		.word kbcrh_0			; PS/2 Keyboard Control Register H Channel 0
		.byte 6
		.word sirqcr0			; LPC SERIRQ Control Register 0
		.byte 1
		.word sirqcr0			; LPC SERIRQ Control Register 0
		.byte 0
		.word kbcrh_1			; PS/2 Keyboard Control Register H Channel 1
		.byte 6
		.word kbcrh_1			; PS/2 Keyboard Control Register H Channel 1
		.byte 5
		.word p8dr			; Port 8 Data Register
		.byte 1
		.word p4dr			; Port 4 Data Register
		.byte 0

; ----------------------------------------------

sub_042c0:	cmp	#0, r1l
		bne	loc_042cc

		bset	#7, r2h
		bset	#6, r2h
		inc	r1l
		bra	rts_042d6

loc_042cc:	bld	#1, r0h
		b st	p81dr			; Pin P81/-CS2/GA20 (Port 8 Data Register)
		bst	#3, r2h
		bclr	#7, r2h

rts_042d6:	rts

; ----------------------------------------------

sub_042d8:	cmp	#0, r1l
		bne	loc_042e6

		bset	#7, r2h
		bset	#6, r2h
		bset	#5, r2h
		inc	r1l
		bra	rts_042ee

loc_042e6:	mov	#0, r0l
		jsr	sub_03d98

		bclr	#7, r2h

rts_042ee:	rts

; ----------------------------------------------

sub_042f0:	cmp	#0, r1l
		bne	loc_042fe

		bset	#7, r2h
		bset	#6, r2h
		bset	#5, r2h
		inc	r1l
		bra	rts_04306

loc_042fe:	mov	#0x20, r0l
		jsr	sub_03d98

		bclr	#7, r2h

rts_04306:	rts

; ----------------------------------------------

sub_04308:	cmp	#0, r1l
		bne	loc_04314

		bset	#7, r2h
		bset	#6, r2h
		inc	r1l
		bra	rts_04322

loc_04314:	push	er2
		jsr	loc_03e3c

		pop	er2
		bclr	#7, r2h

rts_04322:	rts

; ----------------------------------------------

sub_04324:	cmp	#0, r1l
		bne	loc_04338

		b tst	str1.obf1		; Output Buffer Full (LPC Status Register 1 (0x64))
		beq	loc_04338

		bset	#7, r2h
		bset	#5, r2h
		inc	r1l
		bra	rts_0435a

loc_04338:	push	er2
		jsr	sub_04acc

		pop	er2
		bld	#0, r0h
		mov	#0, r0h
		bst	#0, r0h
		b ld	kbcrh_1.kclki		; Keyboard Clock In (PS/2 Keyboard Control Register H Channel 1)
		bst	#1, r0h
		mov	#0, r0l
		jsr	sub_03d98

		bclr	#7, r2h

rts_0435a:	rts

; ----------------------------------------------

sub_0435c:	cmp	#0xf0, r0h
		bne	loc_0436c

		bset	#4, @byte_ffff0f
		mov	#0, r0h
		bra	rts_04394

loc_0436c:	cmp	#0x84, r0h
		bhi	loc_0438c

		mov	#byte_04396, er1
		add	r0h, r1l
		addx	#0, r1h
		bcc	loc_0437e

		inc	#1, e1

loc_0437e:	mov	@er1, r0h
		bld	#4, @byte_ffff0f
		bor	#7, r0h
		bst	#7, r0h

loc_0438c:	bclr	#4, @byte_ffff0f

rts_04394:	rts


byte_04396:	.byte   -1, 0x43, 0x41, 0x3f, 0x3d, 0x3b, 0x3c, 0x58
		.byte 0x64, 0x44, 0x42, 0x40, 0x3e, 0x0f, 0x29, 0x59
		.byte 0x65, 0x38, 0x2a, 0x70, 0x1d, 0x10, 0x02, 0x5a
		.byte 0x66, 0x71, 0x2c, 0x1f, 0x1e, 0x11, 0x03, 0x5b
		.byte 0x67, 0x2e, 0x2d, 0x20, 0x12, 0x05, 0x04, 0x5c
		.byte 0x68, 0x39, 0x2f, 0x21, 0x14, 0x13, 0x06, 0x5d
		.byte 0x69, 0x31, 0x30, 0x23, 0x22, 0x15, 0x07, 0x5e
		.byte 0x6a, 0x72, 0x32, 0x24, 0x16, 0x08, 0x09, 0x5f
		.byte 0x6b, 0x33, 0x25, 0x17, 0x18, 0x0b, 0x0a, 0x60
		.byte 0x6c, 0x34, 0x35, 0x26, 0x27, 0x19, 0x0c, 0x61
		.byte 0x6d, 0x73, 0x28, 0x74, 0x1a, 0x0d, 0x62, 0x6e
		.byte 0x3a, 0x36, 0x1c, 0x1b, 0x75, 0x2b, 0x63, 0x76
		.byte 0x55, 0x56, 0x77, 0x78, 0x79, 0x7a, 0x0e, 0x7b
		.byte 0x7c, 0x4f, 0x7d, 0x4b, 0x47, 0x7e, 0x7f, 0x6f
		.byte 0x52, 0x53, 0x50, 0x4c, 0x4d, 0x48, 0x01, 0x45
		.byte 0x57, 0x4e, 0x51, 0x4a, 0x37, 0x49, 0x46, 0x54
		.byte 0x80, 0x81, 0x82, 0x41, 0x54,   -1

; ----------------------------------------------

; LPC IDR1 Reception Completion (0x60/0x64)

ibfi1:		b clr	hicr_2.ibfie1		; IDR1 Receive Completion Interrupt Enable (LPC Host Interface Control Register 2)
		clr	i
		push	er0
		b tst	str1.c_d1		; Command/-Data (0x64/0x60) (LPC Status Register 1 (0x64))
		bne	loc_0444c

		btst	#7, @byte_ffff11
		bne	loc_0444c

		mov	@idr1, r0h		; LPC Input Data Register 1 (0x60/0x64)
		mov	r0h, @byte_ffe4af
		bset	#7, @byte_ffff11

loc_0444c:	set	i
		pop	er0
		rte

; ----------------------------------------------

sub_04454:	set	i
		btst	#7, @byte_ffff11
		bne	loc_04476

		mov	@str1, r0h		; LPC Status Register 1 (0x64)
		clr	i
		btst	#3, r0h
		beq	loc_04476

		btst	#1, r0h
		beq	loc_04476

		mov	@idr1, r0h		; LPC Input Data Register 1 (0x60/0x64)
		clr	c
		bra	rts_0447a

loc_04476:	clr	i
		set	c

rts_0447a:	rts

; ----------------------------------------------

sub_0447c:	btst	#7, @byte_ffff11
		beq	loc_0449c

		set	i
		bclr	#7, @byte_ffff11
		mov	@byte_ffe4af, r0h
		clr	i
		clr	c
		bra	rts_0449e

loc_0449c:	set	c

rts_0449e:	rts

; ----------------------------------------------

sub_044a0:	btst	#7, r0l
		beq	loc_044da

		mov	@byte_ffe4ab, r1h
		mov	@byte_ffe47b, r1l
		cmp	r1h, r1l
		bls	loc_044d8

		inc	r1h
		mov	r1h, @byte_ffe4ab
		mov	#0xfe, r0h
		btst	#5, r0l
		bne	loc_044c8

		jsr	sub_03e22

		bra	loc_044cc

loc_044c8:	jsr	loc_03e3c

loc_044cc:	bset	#0, @byte_ffff0f
		mov	#0, r0h
		rts


loc_044d8:	bra	loc_044e2

loc_044da:	mov	#0, r1h
		mov	r1h, @byte_ffe4ab

loc_044e2:	mov	@str1, r1h		; LPC Status Register 1 (0x64)
		btst	#0, r1h
		bne	loc_044f4

		btst	#7, @byte_ffff0f
		beq	loc_044f8

loc_044f4:	mov	#-1, r0h
		bra	rts_04500

loc_044f8:	jsr	rts_10e5c

		jsr	sub_04734

rts_04500:	rts

; ----------------------------------------------

sub_04502:	bclr	#0, @byte_ffff0f
		push	er0
		jsr	sub_04636

		pop	er0
		mov	#0xc0, r1h
		and	r0l, r1h
		bne	loc_04540

		btst	#5, r0l
		bne	loc_04540

		mov	@byte_ffe47a, r1h
		btst	#6, r1h
		beq	loc_04540

		push	er0
		jsr	sub_0435c

		pop	er1
		mov	r1l, r0l
		cmp	#0, r0h
		bne	loc_04540

		mov	#1, r0h
		bra	loc_04568

loc_04540:	btst	#2, @byte_ffff0f
		beq	loc_04562

		mov	#0xe0, r1h
		and	r0l, r1h
		bne	loc_04554

		jsr	sub_03cfc

loc_04554:	btst	#2, @byte_ffff0f
		beq	loc_04560

		mov	#1, r0h

loc_04560:	bra	loc_04568

loc_04562:	jsr	sub_03d98

		mov	#0, r0h

loc_04568:	push	er0
		jsr	sub_045ce

		pop	er0
		rts

; ----------------------------------------------

sub_04576:	set	c
		b tst	str1.obf1		; Output Buffer Full (LPC Status Register 1 (0x64))
		bne	rts_04588

		mov	@byte_ffe47a, r0h
		bld	#5, r0h

rts_04588:	rts

; ----------------------------------------------

		set	c
		b tst	str1.obf1		; Output Buffer Full (LPC Status Register 1 (0x64))
		bne	rts_0459c

		mov	@byte_ffe47a, r0h
		bld	#4, r0h

rts_0459c:	rts

; ----------------------------------------------

sub_0459e:	mov	@byte_ffe47a, r1h
		btst	#6, r1h
		beq	rts_045ac

		jsr	sub_0435c

rts_045ac:	rts

; ----------------------------------------------

		set	i

loc_045b0:	b tst	str1.ibf1		; Input Buffer Full (LPC Status Register 1 (0x64))
		beq	loc_045b0

		b tst	str1.c_d1		; Command/-Data (0x64/0x60) (LPC Status Register 1 (0x64))
		bne	loc_045c8

		mov	@idr1, r0h		; LPC Input Data Register 1 (0x60/0x64)
		clr	c
		bra	loc_045ca

loc_045c8:	set	c

loc_045ca:	clr	i
		rts

; ----------------------------------------------

sub_045ce:	jsr	sub_10e58

		rts

; ----------------------------------------------

off_045d4:	.long byte_ffff0f, byte_ffff10, byte_ffe477, byte_ffe4ab, NULL

; ----------------------------------------------

sub_045e8:	mov	#off_045d4, er0
		jmp	loc_0182e

; ----------------------------------------------

sub_045f2:	b ld	p81dr			; Pin P81/-CS2/GA20 (Port 8 Data Register)
		bst	#3, @byte_ffff0f
		mov	#off_045d4, er0
		jmp	loc_01846

; ----------------------------------------------

sub_04608:	jmp	sub_01862

; ----------------------------------------------

sub_0460c:	mov	#off_045d4, er1
		jmp	loc_018ae

; ----------------------------------------------

sub_04616:	jsr	sub_018ca

		bcc	rts_04634

		mov	@byte_ffe47a, r0h
		jsr	sub_04078

		bld	#3, @byte_ffff0f
		b st	p81dr			; Pin P81/-CS2/GA20 (Port 8 Data Register)
		set	c

rts_04634:	rts

; ----------------------------------------------

sub_04636:	btst	#5, r0l
		bne	rts_046b8

		btst	#0, r0l
		beq	rts_046b8

		push	er0
		jsr	sub_038ac

		mov	r0h, r1h
		pop	er0
		cmp	#1, r1h
		bne	loc_0465c

		bld	#7, r0h
		bst	#7, @byte_ffff12
		bclr	#7, r0h

loc_0465c:	cmp	#0xf0, r0h
		bne	loc_0466a

		bset	#7, @byte_ffff12
		bra	rts_046b8

loc_0466a:	cmp	#0xe0, r0h
		bne	loc_04678

		bset	#6, @byte_ffff12
		bra	rts_046b8

loc_04678:	cmp	#0xe1, r0h
		bne	loc_04686

		bset	#5, @byte_ffff12
		bra	rts_046b8

loc_04686:	btst	#5, @byte_ffff12
		bne	loc_0469c

		bsr	sub_046ba

		mov	#0, r1h
		mov	r1h, @byte_ffff12
		bra	rts_046b8

loc_0469c:	btst	#4, @byte_ffff12
		bne	loc_046b0

		bset	#4, @byte_ffff12
		bra	rts_046b8

loc_046b0:	mov	#0, r1h
		mov	r1h, @byte_ffff12

rts_046b8:	rts

; ----------------------------------------------

sub_046ba:	dec	r1h
		mov	r1h, r1l
		mov	#8, r2h
		mulxu	r2h, r1
		mov	#0, e1
		mov	#7, r2h

loc_046c8:	mov	@(byte_04708,er1), r2l
		bld	#7, r2l
		bxor	#6, @byte_ffff12
		bcs	loc_04700

		bclr	#7, r2l
		cmp	r2l, r0h
		bne	loc_04700

		mov	@byte_ffe4aa, r2l
		btst	#7, @byte_ffff12
		bne	loc_046f6

		bset	r2h, r2l
		bra	loc_046f8

loc_046f6:	bclr	r2h, r2l

loc_046f8:	mov	r2l, @byte_ffe4aa
		bra	rts_04706

loc_04700:	adds	#1, er1
		dec	r2h
		bpl	loc_046c8

rts_04706:	rts


byte_04708:	.byte 0x2a, 0x36, 0x1d, 0x80 | 0x1d, 0x38, 0x80 | 0x38, 0x80 | 0x2a, 0x80 | 0x36
		.byte 0x12, 0x59, 0x14, 0x80 | 0x14, 0x11, 0x80 | 0x11, 0x80 | 0x12, 0x80 | 0x59
		.byte 0x12, 0x59, 0x11,        0x58, 0x19,        0x39,        0x00,        0x00

; ----------------------------------------------

sub_04720:	bset	#7, @byte_ffff10
		rts

; ----------------------------------------------

sub_0472a:	bclr	#7, @byte_ffff10
		rts

; ----------------------------------------------

sub_04734:	btst	#0, r0l
		bne	loc_0474a

		btst	#5, r0l
		bne	loc_04744

		mov	#0, r1h
		mov	r1h, @byte_ffe4b0

loc_04744:	jsr	sub_04502

		bra	rts_0476e

loc_0474a:	btst	#5, r0l
		beq	loc_04754

		jsr	sub_04888

		bra	rts_0476e

loc_04754:	mov	@byte_ffe4b0, r1l
		shll	#2, r1l
		mov	#0, r1h
		mov	#0, e1
		mov	@(off_04770,er1), er1
		jmp	@er1

rts_0476e:	rts


off_04770:	.long sub_04784, sub_047de, sub_04812, sub_04856, sub_04876

; ----------------------------------------------

sub_04784:	btst	#7, @byte_ffff10
		bne	loc_04794

		jsr	sub_04502

		bra	loc_047ca

loc_04794:	cmp	#0xf0, r0h
		bne	loc_047a6

		jsr	sub_04502

		mov	#2, r1h
		mov	r1h, @byte_ffe4b0
		bra	loc_047ca

loc_047a6:	cmp	#0xe0, r0h
		bne	loc_047b6

		mov	#1, r0h
		mov	r0h, @byte_ffe4b0
		mov	#1, r0h
		bra	loc_047ca

loc_047b6:	cmp	#0xe1, r0h
		bne	loc_047c6

		mov	#3, r1h
		mov	r1h, @byte_ffe4b0
		mov	#1, r0h
		bra	loc_047ca

loc_047c6:	bsr	sub_04820

		mov	#1, r0h

loc_047ca:	push	er0
		mov	#0x33, r0h
		jsr	sub_10cc0

		jsr	sub_045ce

		pop	er0
		rts

; ----------------------------------------------

sub_047de:	cmp	#0xf0, r0h
		bne	loc_047f0

		jsr	sub_04808

		mov	#0, r1h
		mov	r1h, @byte_ffe4b0
		bra	rts_04806

loc_047f0:	bsr	sub_04838

		bcc	loc_047fc

		jsr	sub_0487e

		mov	#1, r0h
		bra	rts_04806

loc_047fc:	bsr	sub_04808

		mov	#2, r1h
		mov	r1h, @byte_ffe4b0

rts_04806:	rts

; ----------------------------------------------

sub_04808:	mov	#0xe0, r0h
		jsr	sub_04502

		mov	#-1, r0h
		rts

; ----------------------------------------------

sub_04812:	mov	#0, r1h
		mov	r1h, @byte_ffe4b0
		jsr	sub_04502

		rts

; ----------------------------------------------

sub_04820:	bsr	sub_04838

		bcs	loc_04834

		jsr	sub_04502

		mov	#0, r1h
		mov	r1h, @byte_ffe4b0
		clr	c
		bra	rts_04836

loc_04834:	set	c

rts_04836:	rts

; ----------------------------------------------

sub_04838:	push	er0
		jsr	sub_038ac

		mov	r0h, r1h
		pop	er0
		cmp	#1, r1h
		bne	loc_04852

		btst	#7, r0h
		beq	loc_04852

		clr	c
		bra	rts_04854

loc_04852:	set	c

rts_04854:	rts

; ----------------------------------------------

sub_04856:	mov	#sub_04866, er2

loc_0485c:	cmp	#0xf0, r0h
		beq	loc_04862

		jsr	@er2

loc_04862:	mov	#1, r0h
		rts

; ----------------------------------------------

sub_04866:	mov	@byte_ffe4b0, r1h
		inc	r1h
		mov	r1h, @byte_ffe4b0
		rts

; ----------------------------------------------

sub_04876:	mov	#sub_0487e, er2
		bra	loc_0485c

; ----------------------------------------------

sub_0487e:	mov	#0, r1h
		mov	r1h, @byte_ffe4b0
		rts

; ----------------------------------------------

sub_04888:	btst	#2, r0l
		bne	loc_04892

		jsr	sub_04502

		bra	rts_048ba

loc_04892:	btst	#7, @byte_ffff10
		beq	loc_048a4

		jsr	sub_09114

		mov	#1, r0h
		bra	loc_048a8

loc_048a4:	jsr	sub_04502

loc_048a8:	push	er0
		mov	#0x33, r0h
		jsr	sub_10cc0

		jsr	sub_045ce

		pop	er0

rts_048ba:	rts

; ----------------------------------------------

ret0A:		mov	@byte_ffe47a, r0h
		rts

; ----------------------------------------------

sub_048c4:	mov	r0h, @byte_ffe47a
		jsr	sub_04078

		rts

; ----------------------------------------------

sub_048d0:	bld	#1, @byte_ffe4ac
		rts

; ----------------------------------------------

sub_048da:	bld	#0, @byte_ffe4ac
		rts

; ----------------------------------------------

sub_048e4:	mov	#0, r0h
		mov	r0h, @byte_ffe4ac
		mov	r0h, @byte_ffe4ad
		mov	r0h, @byte_ffe4ae
		rts

; ----------------------------------------------

sub_048fa:	bclr	#0, @byte_ffe4ac
		bclr	#1, @byte_ffe4ac
		rts

; ----------------------------------------------

sub_0490c:	mov	#0, r0h
		mov	r0h, @byte_ffff13
		mov	r0h, @byte_ffe4b1
		jsr	sub_056f4

		rts

; ----------------------------------------------

task05: 	mov	@byte_ffff13, r1h
		btst	#7, r1h
		beq	loc_04966

		jsr	sub_054f2

		cmp	#3, r0l
		bne	loc_04954

		jsr	sub_02f12

		bcc	loc_04954

		mov	@byte_ffe4b1, r0l
		shll	#2, r0l
		mov	#0, r0h
		mov	#0, e0
		mov	@(off_04ab0,er0), er0
		jsr	@er0

		bra	loc_04960

loc_04954:	jsr	sub_0496a

		mov	#0, r1h
		mov	r1h, @byte_ffe4b1

loc_04960:	bcs	loc_04966

		jsr	sub_04a36

loc_04966:	clr	c
		rts

; ----------------------------------------------

sub_0496a:	bsr	sub_049c6

		bcc	rts_04992

		bsr	sub_049de

		bcs	loc_0497c

		mov	#2, r1h
		mov	r1h, @byte_ffe4b1
		bra	rts_04992

loc_0497c:	jsr	sub_05d3a

		bcc	loc_04990

		bsr	sub_049f6

		bcs	loc_0498e

		mov	#1, r1h
		mov	r1h, @byte_ffe4b1

loc_0498e:	bra	rts_04992

loc_04990:	set	c

rts_04992:	rts

; ----------------------------------------------

sub_04994:	bsr	sub_049c6

		bcc	rts_049aa

		jsr	sub_05d3a

		bcc	loc_049a2

		bsr	sub_049f6

		bcc	rts_049aa

loc_049a2:	mov	#0, r1h
		mov	r1h, @byte_ffe4b1

rts_049aa:	rts

; ----------------------------------------------

sub_049ac:	bsr	sub_049c6

		bcc	rts_049c4

		bsr	sub_049de

		bcc	rts_049c4

		jsr	sub_09d90

		bcs	rts_049c4

		mov	#0, r1h
		mov	r1h, @byte_ffe4b1
		set	c

rts_049c4:	rts

; ----------------------------------------------

sub_049c6:	btst	#5, @byte_ffff13
		beq	loc_049da

		mov	@word_ffe956, r0
		clr	c
		bra	rts_049dc

loc_049da:	set	c

rts_049dc:	rts

; ----------------------------------------------

sub_049de:	btst	#6, @byte_ffff13
		beq	loc_049f2

		mov	@word_ffe954, r0
		clr	c
		bra	rts_049f4

loc_049f2:	set	c

rts_049f4:	rts

; ----------------------------------------------

sub_049f6:	jsr	sub_03586

		bcs	loc_04a32

		mov	#1, r0l
		jsr	sub_02f12

		bcs	loc_04a0c

		jsr	sub_0352e

		set	c
		bra	loc_04a30

loc_04a0c:	btst	#4, @byte_ffff13
		beq	loc_04a2e

		jsr	sub_0352e

		btst	#3, @byte_ffff13
		beq	loc_04a2a

		mov	#1, r0l
		jsr	sub_04be0

loc_04a2a:	set	c
		bra	loc_04a30

loc_04a2e:	clr	c

loc_04a30:	bra	rts_04a34

loc_04a32:	set	c

rts_04a34:	rts

; ----------------------------------------------

sub_04a36:	push	er0
		jsr	rts_10eee

		pop	er0
		push	er0
		jsr	sub_044a0

		pop	er1
		cmp	#0, r0h
		bne	loc_04a5a

		bclr	#7, @byte_ffff13

loc_04a5a:	cmp	#-1, r0h
		beq	rts_04aae

		mov	@byte_ffff13, r1h
		btst	#5, r1h
		beq	loc_04a7c

		bclr	#5, @byte_ffff13
		mov	@word_ffe954, r0
		jsr	loc_05686

		bra	rts_04aae

loc_04a7c:	btst	#0, r1l
		beq	loc_04a84

		btst	#1, r1l
		beq	loc_04aa2

loc_04a84:	btst	#6, r1h
		beq	loc_04aa2

		bclr	#6, @byte_ffff13
		mov	@word_ffe954, r0
		mov	r0, @word_ffe956
		jsr	loc_05686

		bra	rts_04aae

loc_04aa2:	jsr	sub_0352e

		mov	#0, r0l
		mov	r0, @word_ffe956

rts_04aae:	rts

; ----------------------------------------------

off_04ab0:	.long sub_0496a, sub_04994, sub_049ac

; ----------------------------------------------

rts_04abc:	rts

; ----------------------------------------------

sub_04abe:	jsr	sub_09dbc

		mov	#0, r0h
		mov	r0h, @byte_ffff13
		rts

; ----------------------------------------------

sub_04acc:	bld	#7, @byte_ffff13
		bst	#0, r0h
		bset	#1, r0h
		rts

; ----------------------------------------------

sub_04ada:	mov	@word_ffe956, r0
		mov	r0, @word_ffe954
		bclr	#6, @byte_ffff13
		bset	#5, @byte_ffff13
		rts

; ----------------------------------------------

sub_04af8:	mov	r0, @word_ffe954
		bset	#6, @byte_ffff13
		bclr	#5, @byte_ffff13
		rts

; ----------------------------------------------

sub_04b10:	bset	#7, @byte_ffff13
		jsr	sub_054f2

		cmp	#3, r0l
		bne	rts_04b38

		mov	@byte_ffe4b1, r0h
		cmp	#1, r0h
		beq	rts_04b38

		btst	#6, @byte_ffff13
		bne	rts_04b38

		jsr	sub_09dbc

rts_04b38:	rts

; ----------------------------------------------

sub_04b3a:	bclr	#7, @byte_ffff13
		rts

; ----------------------------------------------

sub_04b44:	bclr	#6, @byte_ffff13
		push	er0
		jsr	sub_054f2

		cmp	#3, r0l
		bne	loc_04b5c

		jsr	sub_09e06

loc_04b5c:	pop	er0
		mov	#2, r1h
		mov	r1h, @byte_ffe4b1
		jsr	sub_0567e

		bsr	sub_04b10

		rts

; ----------------------------------------------

sub_04b70:	jsr	sub_04c22

		cmp	#1, r0h
		bne	rts_04b98

		bset	#4, @byte_ffff13
		bset	#3, @byte_ffff13
		jsr	sub_09e52

		jsr	sub_09130

		jsr	sub_12882

		jsr	sub_10ef0

rts_04b98:	rts

; ----------------------------------------------

sub_04b9a:	bset	#4, @byte_ffff13
		bclr	#3, @byte_ffff13
		jsr	sub_09e44

		jsr	sub_09130

		jsr	sub_10f02

		rts

; ----------------------------------------------

sub_04bb8:	btst	#4, @byte_ffff13
		beq	rts_04bde

		bclr	#4, @byte_ffff13
		bclr	#3, @byte_ffff13
		jsr	sub_09e66

		jsr	sub_0916c

		jsr	sub_10f14

rts_04bde:	rts

; ----------------------------------------------

sub_04be0:
.if !type1R
		push	er0
.endif
		jsr	sub_12892

		bcs	loc_04c1c

		cmp	#1, r0h
		bne	loc_04bf6

		mov	#0x32, r0h
		jsr	sub_10cc0

		bra	loc_04c1c

loc_04bf6:	cmp	#0, r0h
		bne	loc_04c06

		mov	#0x31, r0h
		jsr	sub_10cc0

		jsr	sub_04bb8

		bra	loc_04c1c

loc_04c06:
.if !type1R
		pop	er0
		jsr	sub_0459e

		mov	r0h, @byte_ffe586	; 0x27
.endif
		mov	#0x30, r0h
		jsr	sub_10cc0

.if !type1R
		bra	rts_04c20
.endif

loc_04c1c:
.if !type1R
		pop	er0
.endif

rts_04c20:	rts

; ----------------------------------------------

sub_04c22:	jsr	sub_127cc

		and	#0x0c, r0h
		beq	rts_04c2c

		mov	#1, r0h

rts_04c2c:	rts

; ----------------------------------------------

		btst	#3, @byte_ffff13
		beq	loc_04c3c

		mov	#1, r0h
		bra	rts_04c4c

loc_04c3c:	btst	#4, @byte_ffff13
		beq	loc_04c4a

		mov	#2, r0h
		bra	rts_04c4c

loc_04c4a:	mov	#0, r0h

rts_04c4c:	rts

; ----------------------------------------------

sub_04c4e:	mov	#0, er0
		mov	r0h, @byte_ffe4b2
		mov	er0, @long_ffe95a
		mov	r0h, @byte_ffe4b3
		mov	r0h, @byte_ffe4b4
		mov	r0h, @byte_ffe4b5
		mov	r0h, @byte_ffff14
		mov	#off_05560, er0
		mov	er0, @long_ffe95e
		mov	@tick, r0
		mov	#2500, r1
		add	r1, r0
		mov	r0, @word_ffe970
		rts

; ----------------------------------------------

sub_04c9c:	mov	@tick, r0
		mov	r0, @word_ffe970
		jsr	sub_07862

		rts

; ----------------------------------------------

		rts

; ----------------------------------------------

sub_04cb0:	bsr	sub_04cc4

		jsr	sub_01818

sub_04cb6:	mov	#0, r0h
		mov	r0h, @byte_ffe4b4
		jsr	sub_0215a

		rts

; ----------------------------------------------

sub_04cc4:	mov	#0, r0h
		mov	r0h, @byte_ffe4bd
		jsr	loc_0786e

		rts

; ----------------------------------------------

task06_2:	mov	@byte_ffe4bd, r0h
		mov	#off_04ce2, er1
		jmp	switch_er1_r0h


off_04ce2:	case 0	sub_04cea sub_04cee sub_04d12 sub_04d24

; ----------------------------------------------

sub_04cea:	clr	c
		rts

; ----------------------------------------------

sub_04cee:	mov	@tick, r0
		mov	#500, r1
		add	r1, r0
		mov	r0, @word_ffe970

sub_04d00:	mov	@byte_ffe4bd, r0h
		inc	r0h
		mov	r0h, @byte_ffe4bd
		set	c
		rts

; ----------------------------------------------

sub_04d12:	mov	@word_ffe970, r0
		jsr	cmpTick

		bcc	loc_04d20

		bsr	sub_04d00

loc_04d20:	set	c
		rts

; ----------------------------------------------

sub_04d24:	jsr	sub_074d0

		bcc	loc_04d2e

		bsr	sub_04cc4

		bra	loc_04d4c

loc_04d2e:	b tst	kbcrh_0.kclki		; Keyboard Clock In (PS/2 Keyboard Control Register H Channel 0)
		bne	loc_04d4c

		mov	#0x64, r0h

loc_04d38:	b tst	kbcrh_0.kclki		; Keyboard Clock In (PS/2 Keyboard Control Register H Channel 0)
		bne	loc_04d46

		dec	r0h
		bne	loc_04d38

		bra	loc_04d4c

loc_04d46:	mov	#0x3a, r0h
		jsr	sub_10cc0

loc_04d4c:	set	c
		rts

; ----------------------------------------------

task06_1:	btst	#6, @byte_ffff14
		beq	loc_04d62

		jsr	sub_04f6e

		jmp	loc_04dd0

loc_04d62:	mov	@byte_ffe4b4, r0h
		mov	@byte_ffe4b5, r0l
		cmp	r0h, r0l
		beq	loc_04d8a

		jsr	sub_04e3e

		mov	@byte_ffe4b4, r0h
		mov	r0h, @byte_ffe4b5
		jsr	rts_10ed6

		jmp	loc_04dd0

loc_04d8a:	mov	@long_ffe95a, er1
		beq	loc_04d9a

		jsr	sub_04dd4

		bra	loc_04dd0

loc_04d9a:	mov	@byte_ffe4b4, r0h
		cmp	#2, r0h
		bne	loc_04daa

		jsr	sub_04fa8

		bra	loc_04dc2

loc_04daa:	cmp	#0, r0h
		bne	loc_04db4

		jsr	sub_05020

		bra	loc_04dc2

loc_04db4:	cmp	#3, r0h
		bne	loc_04dbe

		jsr	sub_05050

		bra	loc_04dc2

loc_04dbe:	jsr	sub_05020

loc_04dc2:	mov	@byte_ffe4b3, r0h
		cmp	#3, r0h
		beq	loc_04dd0

		jsr	sub_09dbc

loc_04dd0:	clr	c
		rts

; ----------------------------------------------

sub_04dd4:	mov	@byte_ffe4b3, r0h
		cmp	#3, r0h
		beq	loc_04de2

		jsr	sub_09dbc

loc_04de2:	mov	@word_ffe972, r0
		jsr	cmpTick

		bcc	rts_04e3c

		mov	@byte_ffe4b2, r0h
		cmp	#0xf2, r0h
		bne	loc_04e38

		mov	@byte_ffe96e, r0h
		cmp	#0xff, r0h
		bne	loc_04e1a

		mov	#3, r0h
		mov	r0h, @byte_ffe4b4
		mov	#0, r0h
		mov	r0h, @byte_ffe4b6
		mov	r0h, @byte_ffe4b7
		bra	loc_04e22

loc_04e1a:	mov	#6, r0h
		mov	r0h, @byte_ffe4b4

loc_04e22:	mov	#0, er0
		mov	er0, @long_ffe95a
		mov	r0h, @byte_ffe4b2
		bra	rts_04e3c

loc_04e38:	jsr	sub_054a6

rts_04e3c:	rts

; ----------------------------------------------

sub_04e3e:	bclr	#2, @byte_ffff14
		cmp	#1, r0h
		bne	loc_04e50

		jsr	sub_04ee6

		bra	rts_04e70

loc_04e50:	mov	@byte_ffe4b3, r1h
		cmp	#2, r1h
		bne	loc_04e64

		bset	#6, @byte_ffff14
		bra	rts_04e70

loc_04e64:	mov	#0, r1h
		mov	r1h, @byte_ffe4b3
		jsr	sub_04e72

rts_04e70:	rts

; ----------------------------------------------

sub_04e72:	cmp	#3, r0h
		bne	loc_04e9c

		mov	#off_05560, er1
		mov	er1, @long_ffe95e
		mov	#off_050c2, er1
		mov	er1, @long_ffe974
		mov	#1, r0h
		mov	r0h, @byte_ffe4b8
		bra	loc_04eba

loc_04e9c:	cmp	#2, r0h
		bne	loc_04eba

		mov	r0h, @byte_ffe4b3
		mov	#off_05560, er1
		mov	er1, @long_ffe95e
		jsr	sub_04ece

		bra	loc_04eba

loc_04eba:	mov	@tick, r1
		mov	#1250, r2
		add	r2, r1
		mov	r1, @word_ffe970
		rts

; ----------------------------------------------

sub_04ece:	jsr	sub_02106

		jsr	sub_03a16

		btst	#0, r0h
		bne	loc_04ede

		mov	#0xf4, r0h
		bra	loc_04ee0

loc_04ede:	mov	#0xf5, r0h

loc_04ee0:	jsr	sub_04f0c

		rts

; ----------------------------------------------

sub_04ee6:	btst	#5, @byte_ffff14
		bne	rts_04f0a

		bset	#5, @byte_ffff14
		mov	#-1, r0h
		mov	r0h, @byte_ffe96e
		mov	r0h, @byte_ffe96f
		mov	#0xf2, r0h
		bsr	sub_04f0c

rts_04f0a:	rts

; ----------------------------------------------

sub_04f0c:	mov	#0, r0l
		mov	r0l, @byte_ffe4ba
		mov	r0h, @byte_ffe4b2

sub_04f1a:	mov	@byte_ffe4b2, r0h
		mov	#off_055a4, er1
		jsr	sub_05ecc

		mov	er0, @long_ffe95a
		mov	er1, @long_ffe962
		mov	#0, er1
		mov	er1, @long_ffe962+8
		mov	er1, @long_ffe962+4
		mov	@byte_ffe4b2, r0h
		mov	#50, r1
		mov	@tick, r2
		add	r1, r2
		mov	r2, @word_ffe972
		jsr	sub_09d54

		rts

; ----------------------------------------------

sub_04f6e:	jsr	sub_031ae

		bcs	loc_04f88

		jsr	sub_035c0

		cmp	#0x0a, r0h
		blo	loc_04f86

		jsr	sub_031ae

		bset	#7, r0h
		jsr	sub_03136

loc_04f86:	bra	rts_04fa6

loc_04f88:	bclr	#6, @byte_ffff14
		mov	#0, r0h
		mov	r0h, @byte_ffe4b3
		jsr	sub_02110

		mov	@byte_ffe4b4, r0h
		jsr	sub_04e72

rts_04fa6:	rts

; ----------------------------------------------

sub_04fa8:	jsr	sub_03a58

		bcc	loc_04fe8

		jsr	sub_03a3c

		bcc	loc_04fbc

		mov	#-1, r0h
		jsr	sub_04f0c

		bra	loc_04fe6

loc_04fbc:	jsr	sub_038e0

		bcs	loc_04fd4

		jsr	sub_03996

		bcs	loc_04fd4

		jsr	sub_03644

		bcs	loc_04fd4

		jsr	sub_03a16

		bcc	loc_04fe6

loc_04fd4:	jsr	sub_03a16

		btst	#0, r0h
		beq	loc_04fe0

		mov	#0xf5, r0h
		bra	loc_04fe2

loc_04fe0:	mov	#0xf4, r0h

loc_04fe2:	jsr	sub_04f0c

loc_04fe6:	bra	rts_0501e

loc_04fe8:	btst	#2, @byte_ffff14
		bne	loc_05004

		mov	@word_ffe970, r0
		jsr	cmpTick

		bcc	rts_0501e

		mov	#0xee, r0h
		jsr	sub_04f0c

loc_05004:	bclr	#2, @byte_ffff14
		mov	@tick, r0
		mov	#1250, r1
		add	r1, r0
		mov	r0, @word_ffe970

rts_0501e:	rts

; ----------------------------------------------

sub_05020:	mov	@word_ffe970, r0
		jsr	cmpTick

		bcc	rts_0504e

		btst	#1, @byte_ffff14
		bne	loc_0503c

		mov	#-1, r0h
		jsr	sub_04f0c

loc_0503c:	mov	@tick, r0
		mov	#1250, r1
		add	r1, r0
		mov	r0, @word_ffe970

rts_0504e:	rts

; ----------------------------------------------

sub_05050:	mov	@byte_ffe4b8, r0h
		beq	loc_05074

		mov	@byte_ffe4b8, r1h
		inc	r1h
		mov	r1h, @byte_ffe4b8
		mov	@long_ffe974, er1
		jsr	switch_er1_r0h

		bra	rts_050a6

loc_05074:	mov	@byte_ffe4b3, r0h
		cmp	#3, r0h
		beq	rts_050a6

		jsr	sub_03a58

		bcc	loc_0509c

		mov	#off_050a8, er0
		mov	er0, @long_ffe974
		mov	#1, r0h
		mov	r0h, @byte_ffe4b8
		bra	rts_050a6

loc_0509c:	jsr	sub_05d3a

		bcc	rts_050a6

		jsr	sub_0180a

rts_050a6:	rts

; ----------------------------------------------

off_050a8:	case  0 .         sub_050e2 sub_050f8 sub_0513a
		case  4 sub_0514a sub_0516c sub_05180 sub_05194
		case  8 sub_051dc sub_051fc sub_051c6 sub_05340
		case 12 sub_0524e

off_050c2:	case  0 .         sub_05258 sub_05122 sub_0513a
		case  4 sub_0514a sub_0525e sub_05280 sub_05292
		case  8 sub_052d6 sub_052e4 sub_052c2 sub_05340
		case 12 sub_05350

		case  0 .         sub_05270 sub_0524e

; ----------------------------------------------

sub_050e2:	jsr	sub_03a3c

		bcc	rts_050f6

		mov	#-1, r0h
		jsr	sub_04f0c

		bset	#4, @byte_ffff14

rts_050f6:	rts

; ----------------------------------------------

sub_050f8:	jsr	sub_038e0

		bcc	loc_05112

		mov	r0l, @byte_ffe4bc
		mov	r0l, @byte_ffe96e
		mov	#0xf0, r0h
		jsr	sub_04f0c

		bra	rts_05120

loc_05112:	mov	@byte_ffe4b8, r1h
		add	#2, r1h
		mov	r1h, @byte_ffe4b8

rts_05120:	rts

; ----------------------------------------------

sub_05122:	jsr	sub_038e0

		mov	r0l, @byte_ffe4bc
		mov	r0l, @byte_ffe96e
		mov	#0xf0, r0h
		jsr	sub_04f0c

		rts

; ----------------------------------------------

sub_0513a:	mov	#0, r0h
		mov	r0h, @byte_ffe96e
		mov	#0xf0, r0h
		jsr	sub_04f0c

		rts

; ----------------------------------------------

sub_0514a:	mov	@byte_ffe4bc, r0h
		mov	@byte_ffe4bb, r0l
		cmp	r0h, r0l
		beq	rts_0516a

		jsr	sub_038ac

		mov	r0h, @byte_ffe96e
		mov	#0xf0, r0h
		jsr	sub_04f0c

rts_0516a:	rts

; ----------------------------------------------

sub_0516c:	jsr	sub_0392c

		bcc	rts_0517e

		mov	r0h, @byte_ffe96e
		mov	#0xed, r0h
		jsr	sub_04f0c

rts_0517e:	rts

; ----------------------------------------------

sub_05180:	jsr	sub_03974

		bcc	rts_05192

		mov	r0h, @byte_ffe96e
		mov	#0xf3, r0h
		jsr	sub_04f0c

rts_05192:	rts

; ----------------------------------------------

sub_05194:	jsr	sub_03996

		bcc	rts_051c4

		cmp	#1, r0h
		bne	loc_051a2

		mov	#0xf7, r0h
		bra	loc_051bc

loc_051a2:	cmp	#2, r0h
		bne	loc_051aa

		mov	#0xf8, r0h
		bra	loc_051bc

loc_051aa:	cmp	#3, r0h
		bne	loc_051b2

		mov	#0xf9, r0h
		bra	loc_051bc

loc_051b2:	cmp	#4, r0h
		bne	loc_051ba

		mov	#0xfa, r0h
		bra	loc_051bc

loc_051ba:	mov	#0, r0h

loc_051bc:	cmp	#0, r0h
		beq	rts_051c4

		jsr	sub_04f0c

rts_051c4:	rts

; ----------------------------------------------

sub_051c6:	jsr	sub_03a16

		bcc	rts_051da

		btst	#0, r0h
		bne	loc_051d4

		mov	#0xf4, r0h
		bra	loc_051d6

loc_051d4:	mov	#0xf5, r0h

loc_051d6:	jsr	sub_04f0c

rts_051da:	rts

; ----------------------------------------------

sub_051dc:	jsr	sub_03644

		bcs	loc_051f2

		mov	@byte_ffe4b8, r1h
		inc	r1h
		mov	r1h, @byte_ffe4b8
		bra	rts_051fa

loc_051f2:	mov	#0, r0h
		mov	r0h, @byte_ffe4b8+1

rts_051fa:	rts

; ----------------------------------------------

sub_051fc:	mov	@byte_ffe4b8+1, r1h

loc_05202:	cmp	#0xa0, r1h
		bcc	loc_0521a

		push	er1
		mov	r1h, r0h
		jsr	sub_03660

		pop	er1
		bcs	loc_0521a

		inc	r1h
		bra	loc_05202

loc_0521a:	mov	r1h, @byte_ffe4b8+1
		bcc	rts_0524c

		mov	r1h, @byte_ffe96e
		and	#3, r0h
		bne	loc_05230

		mov	#0xfb, r0h
		bra	loc_0523a

loc_05230:	cmp	#1, r0h
		bne	loc_05238

		mov	#0xfd, r0h
		bra	loc_0523a

loc_05238:	mov	#0xfc, r0h

loc_0523a:	jsr	sub_04f0c

		mov	@byte_ffe4b8, r1h
		dec	r1h
		mov	r1h, @byte_ffe4b8

rts_0524c:	rts

; ----------------------------------------------

sub_0524e:	mov	#0, r0h
		mov	r0h, @byte_ffe4b8
		rts

; ----------------------------------------------

sub_05258:	jsr	sub_03a3c

		rts

; ----------------------------------------------

sub_0525e:	jsr	sub_0392c

		mov	r0h, @byte_ffe96e
		mov	#0xed, r0h
		jsr	sub_04f0c

		rts

; ----------------------------------------------

sub_05270:	mov	#0, r0h
		mov	r0h, @byte_ffe96e
		mov	#0xed, r0h
		jsr	sub_04f0c

		rts

; ----------------------------------------------

sub_05280:	jsr	sub_03974

		mov	r0h, @byte_ffe96e
		mov	#0xf3, r0h
		jsr	sub_04f0c

		rts

; ----------------------------------------------

sub_05292:	jsr	sub_03996

		cmp	#1, r0h
		bne	loc_0529e

		mov	#0xf7, r0h
		bra	loc_052b8

loc_0529e:	cmp	#2, r0h
		bne	loc_052a6

		mov	#0xf8, r0h
		bra	loc_052b8

loc_052a6:	cmp	#3, r0h
		bne	loc_052ae

		mov	#0xf9, r0h
		bra	loc_052b8

loc_052ae:	cmp	#4, r0h
		bne	loc_052b6

		mov	#0xfa, r0h
		bra	loc_052b8

loc_052b6:	mov	#0, r0h

loc_052b8:	cmp	#0, r0h
		beq	rts_052c0

		jsr	sub_04f0c

rts_052c0:	rts

; ----------------------------------------------

sub_052c2:	jsr	sub_03a16

		btst	#0, r0h
		bne	loc_052ce

		mov	#0xf4, r0h
		bra	loc_052d0

loc_052ce:	mov	#0xf5, r0h

loc_052d0:	jsr	sub_04f0c

		rts

; ----------------------------------------------

sub_052d6:	jsr	sub_03644

		mov	#0, r0h
		mov	r0h, @byte_ffe4b8+1
		rts

; ----------------------------------------------

sub_052e4:	mov	@byte_ffe4b8+1, r1h

loc_052ea:	cmp	#0xa0, r1h
		bcc	loc_05304

		push	er1
		mov	r1h, r0h
		jsr	sub_03660

		pop	er1
		bld	#7, r0h
		bcs	loc_05304

		inc	r1h
		bra	loc_052ea

loc_05304:	mov	r1h, @byte_ffe4b8+1
		bcc	rts_0533e

		mov	r1h, @byte_ffe96e
		inc	r1h
		mov	r1h, @byte_ffe4b8+1
		and	#3, r0h
		bne	loc_05322

		mov	#0xfb, r0h
		bra	loc_0532c

loc_05322:	cmp	#1, r0h
		bne	loc_0532a

		mov	#0xfd, r0h
		bra	loc_0532c

loc_0532a:	mov	#0xfc, r0h

loc_0532c:	jsr	sub_04f0c

		mov	@byte_ffe4b8, r1h
		dec	r1h
		mov	r1h, @byte_ffe4b8

rts_0533e:	rts

; ----------------------------------------------

sub_05340:	jsr	sub_03a58

		bcc	rts_0534e

		mov	#1, r0h
		mov	r0h, @byte_ffe4b8

rts_0534e:	rts

; ----------------------------------------------

sub_05350:	mov	#0, r0h
		mov	r0h, @byte_ffe4b8
		rts

; ----------------------------------------------

sub_0535a:	mov	@byte_ffe4b3, r0h
		cmp	#3, r0h
		beq	rts_0537a

		mov	#3, r0h
		mov	r0h, @byte_ffe4b3
		mov	#0, r0h
		jsr	sub_10cc0

		jsr	sub_0214e

		jsr	sub_10e5e

rts_0537a:	rts

; ----------------------------------------------

sub_0537c:	mov	@byte_ffe4b3, r0h
		cmp	#3, r0h
		bne	rts_0539c

		mov	#0, r0h
		jsr	sub_10cc0

		jsr	sub_0215a

		mov	#0, r0h
		mov	r0h, @byte_ffe4b3
		jsr	loc_10e62

rts_0539c:	rts

; ----------------------------------------------

sub_0539e:	mov	@byte_ffe4b3, r0h
		cmp	#2, r0h
		bne	loc_053ac

		clr	c
		bra	rts_053ae

loc_053ac:	set	c

rts_053ae:	rts

; ----------------------------------------------

sub_053b0:	bclr	#5, @byte_ffff14
		mov	#1, r1h
		mov	r1h, @byte_ffe4b4
		rts

; ----------------------------------------------

sub_053c2:	btst	#6, r0l
		beq	loc_053ca

		jmp	sub_054a6

loc_053ca:	btst	#7, r0l
		beq	loc_053e6

		mov	@long_ffe95a, er2
		beq	loc_053de

		jsr	sub_04f1a

		bra	loc_053e4

loc_053de:	mov	#0xfe, r0h
		jsr	sub_09d54

loc_053e4:	bra	loc_05458

loc_053e6:	cmp	#0xfe, r0h
		bne	loc_05422

		mov	@long_ffe95a, er1
		beq	loc_05420

		mov	@byte_ffe4ba, r0l
		inc	r0l
		mov	r0l, @byte_ffe4ba
		cmp	#8, r0l
		blo	loc_0541c

		mov	#0, er1
		mov	er1, @long_ffe95a
		mov	r1l, @byte_ffe4b2
		bra	loc_05420

loc_0541c:	jsr	sub_04f1a

loc_05420:	bra	loc_05458

loc_05422:	mov	@long_ffe95a, er1
		beq	loc_05434

		mov	#0x82, r1h
		jsr	sub_0545e

		bra	loc_05458

loc_05434:	mov	@byte_ffe4b4, r1h
		cmp	#0, r1h
		bne	loc_05448

		cmp	#0xaa, r0h
		bne	loc_05446

		jsr	sub_053b0

loc_05446:	bra	loc_05458

loc_05448:	bset	#2, @byte_ffff14
		cmp	#2, r1h
		bne	loc_05458

		jsr	sub_054e2

loc_05458:	mov	#1, r0h
		rts

; ----------------------------------------------

sub_0545c:	mov	#0x84, r1h

; ----------------------------------------------

sub_0545e:	mov	@tick, r2
		mov	#50, r3
		add	r3, r2
		mov	r2, @word_ffe972
		mov	@long_ffe95a, er2
		beq	rts_0549a

		mov	r0h, r0l
		mov	r1h, r0h
		mov	#long_ffe95a, er1
		jsr	sub_05d9e

		mov	@long_ffe95a, er1
		bne	rts_0549a

		mov	#0, r0h
		mov	r0h, @byte_ffe4b2

rts_0549a:	rts

; ----------------------------------------------

sub_0549c:	jsr	sub_09d54

		rts

; ----------------------------------------------

		jsr	sub_035d4

sub_054a6:	mov	#0, r0h
		mov	r0h, @byte_ffe4b4
		mov	#0, er0
		mov	r0h, @byte_ffe4b2
		mov	er0, @long_ffe95a
		bclr	#4, @byte_ffff14
		mov	@byte_ffe4b3, r0h
		cmp	#3, r0h
		bne	rts_054e0

		jsr	sub_056f4

		jsr	sub_0537c

		jsr	sub_05d14

rts_054e0:	rts

; ----------------------------------------------

sub_054e2:	mov	@byte_ffe4b3, r1h
		cmp	#2, r1h
		bne	rts_054f0

		jsr	sub_03136

rts_054f0:	rts

; ----------------------------------------------

sub_054f2:	mov	@byte_ffe4b4, r0h
		mov	@byte_ffe4b3, r0l
		rts

; ----------------------------------------------

sub_05500:	mov	r0l, @byte_ffe4b3
		cmp	#3, r0l
		bne	rts_0550e

		jsr	sub_0535a

rts_0550e:	rts

; ----------------------------------------------

sub_05510:	mov	@byte_ffe4b6, r0h
		mov	@byte_ffe4b7, r0l
		rts

; ----------------------------------------------

.if level >= 0x01050000
sub_0551e:	push	r0
		mov	@byte_ffe4b3, r0l
		cmp	#3, r0l
		bne	loc_0552e

		set	c
		bra	loc_05530

loc_0552e:	clr	c

loc_05530:	pop	r0
		rts
.endif

; ----------------------------------------------

		mov	@byte_ffe4b2, r0h
		bne	loc_05558

		mov	@byte_ffe4b4, r0h
		mov	@byte_ffe4b3, r0l
		cmp	#3, r0h
		bne	loc_05558

		cmp	#3, r0l
		bne	loc_05558

		jsr	sub_035c0

		cmp	#0, r0l
		bne	loc_0555c

loc_05558:	clr	c
		bra	rts_0555e

loc_0555c:	set	c

rts_0555e:	rts

; ----------------------------------------------

off_05560:	.long rts_05ef8			;  0
		.long rts_05ef8			;  1
		.long rts_05ef8			;  2
		.long rts_05ef8			;  3
		.long sub_05f14			;  4
		.long rts_05ef8			;  5
		.long rts_05ef8			;  6
		.long rts_05ef8			;  7
		.long sub_05fd2			;  8
		.long sub_05f44			;  9
		.long rts_05ef8			; 10
		.long rts_05ef8			; 11
		.long rts_05ef8			; 12
		.long sub_05fc0			; 13
		.long sub_05fcc			; 14
		.long rts_05ef8			; 15
		.long sub_05fda			; 16

off_055a4:	.long sub_055f4			;  0
		.long NULL			;  1
		.long NULL			;  2
		.long NULL			;  3
		.long NULL			;  4
		.long NULL			;  5
		.long NULL			;  6
		.long NULL			;  7
		.long NULL			;  8
		.long NULL			;  9
		.long NULL			; 10
		.long NULL			; 11
		.long NULL			; 12
		.long sub_0563a			; 13
		.long NULL			; 14
		.long sub_05632			; 15
		.long NULL			; 16
		.long NULL			; 17
		.long NULL			; 18
		.long NULL			; 19

; ----------------------------------------------

sub_055f4:	cmp	#0xfa, r0l
		bne	loc_0560c

		mov	@tick, r1
		mov	#500, r2
		add	r2, r1
		mov	r1, @word_ffe972
		bra	rts_05630

loc_0560c:	cmp	#0xaa, r0l
		bne	loc_05624

		mov	@byte_ffe4b4, r1h
		cmp	#3, r1h
		beq	loc_05622

		cmp	#2, r1h
		beq	loc_05622

		jsr	sub_053b0

loc_05622:	bra	rts_05630

loc_05624:	cmp	#0xfc, r0l
		bne	rts_05630

		mov	#5, r1h
		mov	r1h, @byte_ffe4b4

rts_05630:	rts

; ----------------------------------------------

sub_05632:	mov	r0l, @byte_ffe4bb
		rts

; ----------------------------------------------

sub_0563a:	mov	@(0x14,er1), r1h
		mov	r1h, @byte_ffe4b6
		mov	r0l, @byte_ffe4b7
		mov	r0l, r1l
		mov	#0xab20, r0
		cmp	r0, r1
		bne	loc_0565e

		mov	#2, r0h
		mov	r0h, @byte_ffe4b4
		bra	rts_0567c

loc_0565e:	cmp	#0xab, r1h
		beq	loc_0566a

		mov	#1, r0
		cmp	r0, r1
		bne	loc_05674

loc_0566a:	mov	#3, r0h
		mov	r0h, @byte_ffe4b4
		bra	rts_0567c

loc_05674:	mov	#4, r0h
		mov	r0h, @byte_ffe4b4

rts_0567c:	rts

; ----------------------------------------------

sub_0567e:	mov	#0, er1
		bra	loc_056a6

loc_05686:	mov	#4, er1
		bra	loc_056a6

sub_0568e:	mov	#8, er1
		bra	loc_056a6

sub_05696:	mov	#0x0c, er1
		bra	loc_056a6

		mov	#0x10, er1
		bra	loc_056a6

loc_056a6:	mov	@long_ffe978, er2
		add	er2, er1
		mov	@er1, er1
		jmp	@er1

		rts

; ----------------------------------------------

off_056b8:	.long sub_05932			; 0
		.long sub_059ac			; 1
		.long sub_053c2			; 2
		.long sub_0545c			; 3
		.long sub_0549c			; 4

off_056cc:	.long sub_05932			; 0
		.long sub_059ac			; 1
		.long sub_059f0			; 2
		.long sub_05a54			; 3
		.long sub_05ab8			; 4
		.long sub_09d54			; 5
		.long rts_05702			; 6
		.long sub_044a0			; 7
		.long rts_05702			; 8
		.long sub_09d54			; 9

; ----------------------------------------------

sub_056f4:	mov	#off_056b8, er0

loc_056fa:	mov	er0, @long_ffe978

rts_05702:	rts


sub_05704:	mov	#off_056cc, er0
		bra	loc_056fa

; ----------------------------------------------

sub_0570c:	bsr	sub_05728

		mov	#6, r0h
		mov	r0h, @byte_ffe4bf
		bset	#6, @byte_ffff15
		bset	#3, @byte_ffff15
		rts

; ----------------------------------------------

sub_05728:	mov	#0, r0h
		mov	r0h, @byte_ffe4be
		mov	r0h, @byte_ffff15
		mov	r0h, @byte_ffe4bf
		bsr	sub_05760

		mov	#off_05b5c, er0
		mov	er0, @long_ffe980
		mov	#off_05abc, er0
		mov	er0, @long_ffe992
		jsr	sub_03a74

		rts

; ----------------------------------------------

sub_05760:	mov	#0, r0h
		jsr	sub_06968

		rts

; ----------------------------------------------

sub_05768:	jsr	sub_03924

		jsr	sub_05ce2

		rts

; ----------------------------------------------

task07:		mov	@byte_ffe4bf, r0h
		mov	#off_05786, er1
		jsr	switch_er1_r0h

		clr	c
		rts


off_05786:	case 0	sub_0579c sub_057e4 sub_0581a sub_05832
		case 4	sub_0584e sub_05862 sub_058ba sub_058ca
		case 8	sub_057e4 sub_05832 sub_05902

; ----------------------------------------------

sub_0579c:
.if level >= 0x01050000 && level < 0x01060000
		btst	#1, @byte_ffff15
		bne	loc_057dc

		jsr	sub_054f2

		cmp	#0, r0l
		beq	loc_057d2

		cmp	#3, r0h
		bne	loc_057d2

		mov	@long_ffe97c, er0
		bne	loc_057d2

		mov	#task07o, r0h
		jsr	checkSchedTask

		bcc	loc_057dc

		bset	#2, @byte_ffff15
		mov	#0xee, r0h
		jsr	sub_0593c

loc_057d2:	mov	#task07o, r0h
		mov	#1000, r1
		jsr	schedBackTaskDelayed

loc_057dc:
.endif
		mov	#task07o, r0h
		jsr	schedFrontTask

		rts

; ----------------------------------------------

sub_057e4:	jsr	sub_04acc

		and	#3, r0h
		cmp	#3, r0h
		bne	rts_05818

		jsr	sub_020de

		jsr	sub_035d4

		jsr	sub_02e72

		mov	#2, r0h
		jsr	sub_03872

		mov	#0, r0h
		jsr	sub_06968

		jsr	sub_03a74

sub_0580a:	mov	@byte_ffe4bf, r0h
		inc	r0h
		mov	r0h, @byte_ffe4bf

rts_05818:	rts

; ----------------------------------------------

sub_0581a:	mov	#0, er0
		mov	r0h, @byte_ffe4be
		mov	er0, @long_ffe97c
		bsr	sub_0580a

		rts

; ----------------------------------------------

sub_05832:	mov	#7, r0h
		jsr	sub_06968

		mov	#task07o, r0h
		mov	#500, r1
		jsr	schedBackTaskDelayed

		bsr	sub_0580a

		bset	#6, @byte_ffff15
		rts

; ----------------------------------------------

sub_0584e:	mov	#task07o, r0h
		jsr	checkSchedTask

		bcc	loc_0585a

		bsr	sub_0580a

		bra	rts_05860

loc_0585a:	mov	#task07o, r0h
		jsr	schedFrontTask

rts_05860:	rts

; ----------------------------------------------

sub_05862:	mov	#0, r0h
		jsr	sub_06968

		jsr	sub_035d4

		jsr	sub_054f2

		cmp	#5, r0l
		bne	loc_0587e

		mov	#0xfc00, r0
		jsr	sub_04af8

		bra	loc_058a8

loc_0587e:	cmp	#3, r0l
		beq	loc_05890

		push	er0
		jsr	sub_03348

		pop	er0
		bcs	loc_058a8

loc_05890:	push	er0
		mov	#0xaa00, r0
		jsr	sub_04af8

		pop	er0
		cmp	#3, r0l
		beq	loc_058a8

		jsr	sub_02ee6

loc_058a8:	mov	#0, r0h
		mov	r0h, @byte_ffe4bf
		bclr	#6, @byte_ffff15
		rts

; ----------------------------------------------

sub_058ba:	mov	#task07o, r0h
		mov	#2500, r1
		jsr	schedBackTaskDelayed

		bsr	sub_0580a:16

		rts

; ----------------------------------------------

sub_058ca:	mov	#task07o, r0h
		jsr	checkSchedTask

		bcc	loc_058dc

		mov	#5, r0h
		mov	r0h, @byte_ffe4bf
		bra	rts_05900

loc_058dc:	jsr	sub_054f2

		cmp	#3, r0h
		bne	loc_058ee

		mov	#5, r0h
		mov	r0h, @byte_ffe4bf
		bra	rts_05900

loc_058ee:	cmp	#5, r0h
		bne	rts_05900

		mov	r0h, r0l
		jsr	sub_05500

		mov	#5, r0h
		mov	r0h, @byte_ffe4bf

rts_05900:	rts

; ----------------------------------------------

sub_05902:	mov	@long_ffe97c, er0
		beq	loc_05916

		mov	@byte_ffe4be, r0h
		cmp	#-1, r0h
		beq	rts_05930

loc_05916:	mov	#0, r0h
		jsr	sub_06968

		jsr	sub_02ee6

		mov	#0, r0h
		mov	r0h, @byte_ffe4bf
		bclr	#6, @byte_ffff15

rts_05930:	rts

; ----------------------------------------------

sub_05932:	btst	#6, @byte_ffff15
		bne	loc_059a2

sub_0593c:	push	er0
		mov	@long_ffe992, er1
		jsr	sub_05ecc

		pop	er2
		bcs	loc_0595a

		mov	r2h, @byte_ffe4be
		bra	loc_05964

loc_0595a:	mov	@long_ffe97c, er3
		bne	loc_0599c

loc_05964:	mov	er0, @long_ffe97c
		mov	er1, @long_ffe984
		mov	#0, er1
		mov	er1, @long_ffe98c
		mov	er1, @long_ffe988
		mov	r1h, @byte_ffe4bf
		push	er2
		jsr	sub_02ef2

		pop	er2

loc_0599c:	mov	r2, r0
		mov	#0x81, r1h
		bra	sub_059ae

loc_059a2:	mov	#0xfe40, r0
		jsr	sub_04af8

		rts

; ----------------------------------------------

sub_059ac:	mov	#0x83, r1h

sub_059ae:	btst	#4, @byte_ffff15
		beq	loc_059c4

		bclr	#4, @byte_ffff15
		cmp	#0x83, r1h
		beq	loc_059ec

loc_059c4:	mov	@long_ffe97c, er2
		beq	loc_059ec

		mov	r0h, r0l
		mov	r1h, r0h
		mov	#long_ffe97c, er1
		jsr	sub_05d9e

		mov	@long_ffe97c, er1
		bne	loc_059ea

		jsr	sub_02efa

loc_059ea:	bra	rts_059ee

loc_059ec:	mov	#0, r0h

rts_059ee:	rts

; ----------------------------------------------

sub_059f0:	btst	#6, r0l
		bne	loc_05a5a

		btst	#7, r0l
		beq	loc_05a08

		btst	#3, @byte_ffff15
		beq	loc_05a5a

		jsr	sub_04af8

		bra	loc_05a50

loc_05a08:	cmp	#0xfe, r0h
		bne	loc_05a24

		jsr	sub_04af8

		mov	#0, er1
		mov	er1, @long_ffe97c
		jsr	sub_02efa

		bra	loc_05a50

loc_05a24:
.if level >= 0x01050000 && level < 0x01060000
		btst	#2, @byte_ffff15
		beq	loc_05a3a

		bclr	#2, @byte_ffff15
		mov	#0x83, r1h
		bra	loc_05a3c
.endif

loc_05a3a:	mov	#0x82, r1h
loc_05a3c:	mov	@long_ffe97c, er2
		bne	sub_059ae:16

		jsr	sub_04af8

		jsr	sub_02efa

loc_05a50:	mov	#0, r0h
		rts

; ----------------------------------------------

sub_05a54:	mov	#0x84, r1h
		bra	sub_059ae:16

loc_05a5a:
.if level >= 0x01050000 && level < 0x01060000
		btst	#2, @byte_ffff15
		beq	loc_05a72

		bclr	#2, @byte_ffff15
		mov	#0x83, r1h
		jsr	sub_059ae

loc_05a72:
.endif
		jsr	sub_01818

		mov	@long_ffe97c, er0
		beq	loc_05ab0

		mov	@byte_ffe4be, r0h
		mov	@long_ffe992, er1
		jsr	sub_05ecc

		mov	er1, @long_ffe984
		mov	@long_ffe988, er0
		mov	er0, @long_ffe97c
		mov	#0x80, r0h
		jsr	sub_059ae

loc_05ab0:	jsr	sub_054a6

		mov	#0, r0h
		rts

; ----------------------------------------------

sub_05ab8:	jmp	sub_09d54

off_05abc:	.long sub_05be4			;  0
		.long sub_04ada			;  1
		.long sub_036be			;  2
		.long sub_036ba			;  3
		.long sub_036b6			;  4
		.long sub_037ea			;  5
		.long sub_037e4			;  6
		.long sub_037de			;  7
		.long sub_0379c			;  8
		.long sub_039b8			;  9
		.long sub_039e2			; 10
		.long sub_05c14			; 11
		.long sub_05c1e			; 12
		.long NULL			; 13
		.long sub_05cb4			; 14
		.long NULL			; 15
		.long sub_05cb4			; 16
		.long sub_05cac			; 17
		.long sub_05cbc			; 18
		.long sub_05cce			; 19

off_05b0c:	.long sub_05bf4			;  0
		.long NULL			;  1
		.long sub_036be			;  2
		.long sub_036ba			;  3
		.long sub_036b6			;  4
		.long sub_037ea			;  5
		.long sub_037e4			;  6
		.long sub_037de			;  7
		.long sub_0379c			;  8
		.long sub_039b8			;  9
		.long sub_039e2			; 10
		.long sub_05c14			; 11
		.long sub_05c1e			; 12
		.long sub_05fda			; 13
		.long sub_05cb4			; 14
		.long NULL			; 15
		.long sub_05cb4			; 16
		.long sub_05cac			; 17
		.long sub_05cbc			; 18
		.long sub_05cce			; 19

off_05b5c:	.long rts_05ef8			;  0
		.long sub_05efa			;  1
		.long sub_05efe			;  2
		.long sub_05f08			;  3
		.long sub_05f14			;  4
		.long sub_05f0e			;  5
		.long sub_05f64			;  6
		.long sub_05f2c			;  7
		.long rts_05ef8			;  8
		.long sub_05f44			;  9
		.long rts_05ef8			; 10
		.long rts_05ef8			; 11
		.long sub_05fc0			; 12
		.long rts_05ef8			; 13
		.long rts_05ef8			; 14
		.long sub_05fda			; 15
		.long rts_05ef8			; 16

off_05ba0:	.long rts_05ef8			;  0
		.long sub_05efa			;  1
		.long sub_05fb0			;  2
		.long sub_05fb0			;  3
		.long sub_05f14			;  4
		.long sub_05fb0			;  5
		.long sub_05f64			;  6
		.long sub_05f2c			;  7
		.long rts_05ef8			;  8
		.long sub_05f44			;  9
		.long sub_05fa4			; 10
		.long sub_05faa			; 11
		.long sub_05fc0			; 12
		.long rts_05ef8			; 13
		.long rts_05ef8			; 14
		.long sub_05fda			; 15
		.long rts_05ef8			; 16

; ----------------------------------------------

sub_05be4:	mov	#1, r1h
		mov	r1h, @byte_ffe4bf
		mov	#task07o, r0h
		jsr	schedBackTask

		rts

; ----------------------------------------------

sub_05bf4:	mov	#8, r1h
		mov	r1h, @byte_ffe4bf
		mov	#task07o, r0h
		jsr	schedBackTask

		rts

; ----------------------------------------------

		jsr	sub_03742

		mov	#0x2b, r0h		; 500 ms, 10.9 cps
		jsr	setTypematic

		jsr	sub_02f18

		rts

; ----------------------------------------------

sub_05c14:	jsr	sub_02f18

		jsr	sub_039b8

		rts

; ----------------------------------------------

sub_05c1e:	cmp	#0x80, r0h
		bhs	loc_05c26

		bsr	setTypematic

		bra	rts_05c38

loc_05c26:	mov	#0xfe, r2h
		mov	r2h, @(0x14,er1)
		mov	#byte_0605f, er2
		mov	er2, @(0,er1)

rts_05c38:	rts

; ----------------------------------------------

setTypematic:	jsr	sub_0394e

		mov	#0, r3l
		bld	#5, r0h
		bst	#0, r3l
		bld	#6, r0h
		bst	#1, r3l
		inc	r3l
		mov	#250, r0l		; 250, 500, 750, 1000 ms delay
		mulxu	r0l, r3
		mov	r0h, r2l
		and	#0x1f, r2l
		shll	r2l
		mov	#0, r2h
		mov	#0, e2
		mov	@(repeatTab,er2), r2	; 30..2 char/s repeate rate
		mov	r3, r0
		mov	r2, r1
		jsr	sub_02f22

		rts


repeatTab:	.word  33,  38,  42,  46,  50,  54,  58,  63	; 30.3, 26.3, 23.8, 21.7, 20.0, 18.5, 17.2, 15.9 cps
		.word  67,  75,  83,  92, 100, 108, 117, 125	; 14.9, 13.3, 12.0, 10.9, 10.0,  9.3,  8.5,  8.0 cps
		.word 133, 150, 167, 183, 200, 217, 234, 250	;  7.5,  6.7,  6.0,  5.5,  5.0,  4.6,  4.3,  4.0 cps
		.word 267, 300, 334, 367, 400, 437, 467, 500	;  3.7,  3.3,  3.0,  2.7,  2.5,  2.3,  2.1,  2.0 cps

; ----------------------------------------------

sub_05cac:	mov	#0xee, r0h
		mov	r0h, @(0x14,er1)
		rts

; ----------------------------------------------

sub_05cb4:	mov	#0xfe, r0h
		mov	r0h, @(0x14,er1)
		rts

; ----------------------------------------------

sub_05cbc:	mov	r0h, @(0x14,er1)
		jsr	sub_03906

		bld	#1, r0h
		bst	#0, r0h
		jsr	sub_02128

		rts

; ----------------------------------------------

sub_05cce:	jsr	sub_033a2

		and	#7, r0h
		inc	r0h
		mov	r0h, @(0x14,er1)
		mov	#1, r0h
		mov	r0h, @(0x15,er1)
		rts

; ----------------------------------------------

sub_05ce2:	jsr	sub_03906

		mov	@long_ffe980, er2
		mov	@(0x1c,er2), er2
		jmp	@er2

; ----------------------------------------------

sub_05cf6:	mov	#off_05ba0, er0
		mov	er0, @long_ffe980
		mov	#off_05b0c, er0
		mov	er0, @long_ffe992
		rts

; ----------------------------------------------

sub_05d14:	mov	#off_05b5c, er0
		mov	er0, @long_ffe980
		mov	#off_05abc, er0
		mov	er0, @long_ffe992
		jsr	sub_03924

		jsr	sub_05f2c

		rts

; ----------------------------------------------

sub_05d3a:	push	er0
		mov	@byte_ffe4bf, r0h
		bne	loc_05d50

		mov	@long_ffe97c, er0
		beq	loc_05d54

loc_05d50:	clr	c
		bra	loc_05d56

loc_05d54:	set	c

loc_05d56:	pop	er0
		rts

; ----------------------------------------------

		bset	#3, @byte_ffff15
		rts

; ----------------------------------------------

		bclr	#3, @byte_ffff15
		rts

; ----------------------------------------------

		mov	#0, r0h
		bld	#3, @byte_ffff15
		bst	#0, r0h
		rts

; ----------------------------------------------

.if level >= 0x01050000 && level < 0x01060000
		bst	#1, @byte_ffff15
		stm	er0-er2, @-sp
		mov	@byte_ffe4bf, r0l
		bne	loc_05d98

		mov	#task07o, r0h
		jsr	schedBackTask

loc_05d98:	ldm	@sp+, er0-er2
		rts
.endif

; ----------------------------------------------

sub_05d9e:	mov	@(0,er1), er2
		beq	rts_05dd4

		mov	@er2, r3h
		btst	#7, r3h
		beq	loc_05dc6

		push	er1
		bsr	sub_05dd6

		pop	er1
		mov	er2, @(0,er1)
		cmp	#0x81, r0h
		bne	loc_05dc6

		mov	er2, @(0x10,er1)

loc_05dc6:	mov	er2, er3
		beq	loc_05dce

		bsr	sub_05e04

		bra	rts_05dd4

loc_05dce:	mov	er2, @(0,er1)

rts_05dd4:	rts

; ----------------------------------------------

sub_05dd6:	mov	@er2+, r4l
		btst	#7, r4l
		bne	loc_05df0

		mov	#0, r4h
		bld	#6, r4l
		bst	#1, r4h
		bld	#5, r4l
		bst	#0, r4h
		add	r4h, r2l
		addx	#0, r2h
		bcc	loc_05dee

		inc	#1, e2

loc_05dee:	bra	loc_05e00

loc_05df0:	cmp	r4l, r0h
		beq	rts_05e02

		cmp	#-1, r4l
		bne	loc_05e00

		mov	#0, er2
		bra	rts_05e02

loc_05e00:	bra	sub_05dd6

rts_05e02:	rts

; ----------------------------------------------

sub_05e04:	mov	@(0,er1), er2
		beq	rts_05e7a

		mov	@er2, r4l
		btst	#7, r4l
		beq	loc_05e26

		cmp	#-1, r4l
		bne	loc_05e24

		mov	#0, er2
		mov	er2, @(0,er1)
		rts


loc_05e24:	bra	rts_05e7a

loc_05e26:	adds	#1, er2
		mov	er2, @(0,er1)
		mov	r4l, r4h
		and	#0x1f, r4h
		shll	r4h
		shll	r4h
		mov	@(4,er1), er3
		add	r4h, r3l
		addx	#0, r3h
		bcc	loc_05e44

		inc	#1, e3

loc_05e44:	mov	@er3, er3
		beq	loc_05e60

		push	er0
		push	er1
		mov	r0l, r0h
		jsr	@er3

		pop	er1
		pop	er0
		bra	loc_05e78

loc_05e60:	mov	#0, r4h
		bld	#6, r4l
		bst	#1, r4h
		bld	#5, r4l
		bst	#0, r4h
		add	r4h, r2l
		addx	#0, r2h
		bcc	loc_05e72

		inc	#1, e2

loc_05e72:	mov	er2, @(0,er1)

loc_05e78:	bra	sub_05e04

rts_05e7a:	rts

; ----------------------------------------------

off_05e7c:	.long byte_05fe8		;  0
		.long byte_05ff9		;  1
		.long byte_06000		;  2
		.long byte_06000		;  3
		.long byte_06000		;  4
		.long byte_06016		;  5
		.long byte_06016		;  6
		.long byte_06016		;  7
		.long byte_06016		;  8
		.long byte_06022		;  9
		.long byte_06022		; 10
		.long byte_06040		; 11
		.long byte_0604c		; 12
		.long byte_06067		; 13
		.long byte_0610b		; 14
		.long byte_0607d		; 15
		.long byte_0610b		; 16
		.long byte_06100		; 17
		.long byte_06115		; 18
		.long byte_06129		; 19

; ----------------------------------------------

sub_05ecc:	cmp	#0xec, r0h
		bhs	loc_05ed6

		mov	#0xf1, r0h
		mov	#1, r3h
		bra	loc_05ed8

loc_05ed6:	mov	#0, r3h

loc_05ed8:	mov	r0h, r2l
		mov	#0, r2h
		not	r2l
		mov	#0, e2
		shll	#2, er2
		mov	@(off_05e7c,er2), er0
		add	er1, er2
		mov	@er2, er1
		bld	#0, r3h
		rts

; ----------------------------------------------

rts_05ef8:	rts

; ----------------------------------------------

sub_05efa:	jmp	sub_03606

; ----------------------------------------------

sub_05efe:	mov	#0xfa, r0h

loc_05f00:	mov	#0, r0l
		jsr	sub_04af8

		rts


sub_05f08:	mov	@(0x14,er1), r0h
		bra	loc_05f00

sub_05f0e:	mov	@(0x15,er1), r0h
		bra	loc_05f00

; ----------------------------------------------

sub_05f14:	mov	@(0,er1), er3
		mov	@er3+, r2h
		mov	er3, @(0,er1)
		add	r2h, r3l
		addx	#0, r3h
		bcc	loc_05f2a

		inc	#1, e3

loc_05f2a:	jmp	@er3

; ----------------------------------------------

sub_05f2c:
.if !type1R
		jsr	sub_02bfc

		bcs	loc_05f34

		bclr	#1, r0h

loc_05f34:	jsr	sub_02bf2

		bcs	loc_05f40

		jsr	sub_02c06

		bst	#1, r0h
.endif

loc_05f40:	jmp	sub_06968

; ----------------------------------------------

sub_05f44:	mov	@(0,er1), er3
		mov	#0, r2h
		mov	#0, e2
		mov	@er3, r2l
		bpl	loc_05f5a

		mov	#0xff, r2h
		mov	#0xffff, e2

loc_05f5a:	add	er2, er3
		mov	er3, @(0,er1)
		rts

; ----------------------------------------------

sub_05f64:	push	er1
		jsr	sub_0539e

		pop	er1
		bcs	loc_05f78

		mov	#0xab83, r0
		bra	loc_05f7c

loc_05f78:	mov	#0xab84, r0

loc_05f7c:	mov	r0h, @(0x14,er1)
		mov	r0l, @(0x15,er1)
		rts

; ----------------------------------------------

		push	er1
		jsr	sub_05510

		pop	er1
		mov	r0, r2
		bne	loc_05f9a

		mov	#0xab83, r0

loc_05f9a:	mov	r0h, @(0x14,er1)
		mov	r0l, @(0x15,er1)
		rts

; ----------------------------------------------

sub_05fa4:	mov	r0l, r0h
		bra	loc_05f00:16

; ----------------------------------------------

sub_05faa:	mov	r0l, r0h
		jmp	sub_09d54

; ----------------------------------------------

sub_05fb0:	mov	@(0,er1), er2
		subs	#1, er2
		mov	er2, @(0x0c,er1)
		rts

; ----------------------------------------------

sub_05fc0:	mov	@(8,er1), er2
		beq	rts_05fca

		jmp	@er2

rts_05fca:	rts

; ----------------------------------------------

sub_05fcc:	mov	r0l, @(0x14,er1)
		rts

; ----------------------------------------------

sub_05fd2:	mov	@(0x14,er1), r0h
		jmp	sub_09d54

; ----------------------------------------------

sub_05fda:	mov	#0, er0
		mov	er0, @(0,er1)
		rts

; ----------------------------------------------

byte_05fe8:	.byte 0x81, 0x01, 0x0b, 0x02, 0x84, 0x82, 0x0a, 0x0d
		.byte 0x83, 0x0c, 0x82, 0x0a, 0x0d, 0x10, 0x83, 0x0f
		.byte -1

byte_05ff9:	.byte 0x81, 0x0b, 0x0c, 0x84, 0x0f, 0x10, -1

byte_06000:	.byte 0x81, 0x01, 0x0b, 0x02, 0x84, 0x08, 0x82, 0x0a
		.byte 0x08, 0x83, 0x81, 0x0c, 0x0b, 0x02, 0x84, 0x82
		.byte 0x0a, 0x10, 0x83, 0x29, 0xf6, -1

byte_06016:	.byte 0x81, 0x01, 0x0c, 0x0b, 0x02, 0x84, 0x82, 0x0a
		.byte 0x10, 0x83, 0x0f, -1

byte_06022:	.byte 0x81, 0x01, 0x24, 0x0a, 0x0c, 0x0b, 0x02, 0x84
		.byte 0x82, 0x0a, 0x10, 0x83, 0x0f, -1

; ----------------------------------------------

		jsr	sub_03742

		mov	#0x2b, r0h		; 500 ms, 10.9 cps
		jsr	setTypematic

		jsr	sub_02f18

		rts

; ----------------------------------------------

byte_06040:	.byte 0x81, 0x01, 0x0c, 0x0b, 0x02, 0x84, 0x82, 0x0a
		.byte 0x10, 0x83, 0x0f, -1

byte_0604c:	.byte 0x81, 0x0b, 0x02, 0x84, 0x82, 0x0a, 0x08, 0x83
		.byte 0x81, 0x0b, 0x0c, 0x02, 0x84, 0x82, 0x0a, 0x10
		.byte 0x83, 0x0f, -1

byte_0605f:	.byte 0x03, 0x84, 0x82, 0x0a, 0x83, 0x29, 0xef, -1

byte_06067:	.byte 0x81, 0x0b, 0x02, 0x06, 0x84, 0x82, 0x0a, 0x83
		.byte 0x03, 0x0c, 0x82, 0x0a, 0x0e, 0x83, 0x05, 0x82
		.byte 0x0a, 0x0d, 0x10, 0x83, 0x0f, -1

byte_0607d:	.byte 0x81, 0x01, 0x0b, 0x24, 0x28, 0x02, 0x84, 0x82
		.byte 0x0a, 0x08, 0x83, 0x81, 0x0b, 0x24, 0x22, 0x02
		.byte 0x84, 0x82, 0x0a, 0x24, 0x3a, 0x29, 0x12, 0x83
		.byte 0x24, 0x4b, 0x03, 0x82, 0x0d, 0x10, 0x0a, 0x83
		.byte 0x0f, -1

byte_0609f:	.byte 0x03, 0x82, 0x0a, 0x83, 0x29, 0xe4, -1

byte_060a6:	.byte 0x10, 0x83, 0x0f, -1

; ----------------------------------------------

		jmp	sub_02f18

; ----------------------------------------------

		mov	r0h, @(0x14,er1)
		jsr	sub_03872

		bcc	rts_060ca

		mov	#0xfe, r2h
		mov	r2h, @(0x14,er1)
		mov	#byte_0609f, er2
		mov	er2, @(0,er1)

rts_060ca:	rts

; ----------------------------------------------

		mov	@(0x14,er1), r0h
		bne	rts_060e0

		mov	@(0,er1), er0
		adds	#2, er0
		mov	er0, @(0,er1)

rts_060e0:	rts

; ----------------------------------------------

		mov	@(0x14,er1), r0h
		bne	loc_060f2

		jsr	sub_038ac

		mov	r0h, @(0x14,er1)
		bra	rts_060fe

loc_060f2:	mov	#byte_060a6+2, er2
		mov	er2, @(0,er1)

rts_060fe:	rts

; ----------------------------------------------

byte_06100:	.byte 0x81, 0x0b, 0x0c, 0x03, 0x84, 0x82, 0x10, 0x0a
		.byte 0x83, 0x0f, -1

byte_0610b:	.byte 0x81, 0x0b, 0x0c, 0x03, 0x84, 0x82, 0x0a, 0x83
		.byte 0x0f, -1

byte_06115:	.byte 0x81, 0x0b, 0x02, 0x84, 0x82, 0x0a, 0x08, 0x83
		.byte 0x81, 0x0b, 0x0c, 0x07, 0x02, 0x84, 0x82, 0x0a
		.byte 0x10, 0x83, 0x0f, -1

byte_06129:	.byte 0x81, 0x0b, 0x0c, 0x02, 0x84, 0x82, 0x0a, 0x83
		.byte 0x03, 0x82, 0x0a, 0x0e, 0x83, 0x05, 0x82, 0x0a
		.byte 0x0d, 0x10, 0x83, 0x0f, -1

; ----------------------------------------------

task08:		mov	#task08o, r0h
		jsr	checkSchedTask

		bcc	loc_061ae

		mov	#task08o, r0h
		mov	#125, r1
		jsr	schedBackTaskDelayed

		jsr	sub_078ea

		bcs	loc_061ae

		mov	#word_ffe996, er3
		mov	#2, r4h

loc_0615e:	mov	@(1,er3), r0l
		mov	@er3, r0h
		beq	loc_06188

		push	er3
		bsr	sub_061d4

		pop	er3
		bcc	loc_06186

		mov	#0, er0
		mov	r0h, @er3
		mov	r0h, @(1,er3)
		mov	er0, @long_ffe9a4

loc_06186:	bra	loc_0618e

loc_06188:	adds	#2, er3
		dec	r4h
		bne	loc_0615e

loc_0618e:	mov	@word_ffe996, r0h
		bne	loc_061ae

		mov	@word_ffe998, r0h
		bne	loc_061ae

		jsr	rts_078c8

		bld	#6, @byte_ffff16:8
		jsr	sub_01fee

		jsr	sub_0fe68

loc_061ae:	mov	#task08o, r0h
		jsr	schedFrontTask

		mov	@word_ffe996, r0
		bne	loc_061c4

		mov	@word_ffe998, r0
		beq	loc_061cc

loc_061c4:	jsr	sub_10e6e

		set	c
		bra	rts_061d2

loc_061cc:	jsr	sub_10e72

		clr	c

rts_061d2:	rts

; ----------------------------------------------

sub_061d4:	mov	@long_ffe9a4, er1
		bne	loc_061fe

		push	er0
		jsr	sub_065a4

		pop	er0
		mov	#125, r1
		mulxu	r0l, r1
		mov	@tick, r2
		add	r1, r2
		mov	r2, @word_ffe9a2

loc_061fe:	cmp	#0, r0l
		beq	loc_0623e

		push	er0
		mov	@word_ffe9a2, r0
		jsr	cmpTick

		pop	er0
		bcc	loc_0623e

		push	er0
		jsr	sub_065a4

		pop	er0
		mov	#125, r1
		mulxu	r0l, r1
		mov	@tick, r0
		add	r1, r0
		mov	r0, @word_ffe9a2
		jsr	sub_065f4

		clr	c
		bra	rts_06288

loc_0623e:	mov	@long_ffe9a4, er3
		mov	@er3+, r1h
		cmp	#-1, r1h
		beq	loc_06276

		mov	@er3+, r1l
		mov	@er3+, r2l
		mov	er3, @long_ffe9a4
		mov	#125, r3l
		mulxu	r3l, r2
		push	er1
		mov	#task08o, r0h
		mov	r2, r1
		jsr	schedBackTaskDelayed

		pop	er1
		mov	r1, r0
		jsr	sub_065c6

		clr	c
		bra	rts_06288

loc_06276:	cmp	#0, r0l
		bne	loc_06282

		jsr	sub_065f4

		set	c
		bra	rts_06288

loc_06282:	jsr	sub_065f4

		clr	c

rts_06288:	rts

; ----------------------------------------------

enableTMR_01:	b clr	mstpcrh.mstp12		; TMR_0, TMR_1 (Module Stop Control Register H)
		mov	#-1, r0
		mov	r0, @word_ffe99a
		mov	#-1, r0
.if !type1R
		and	#~0x1f00, r0
.endif
		mov	r0, @word_ffe99c
		jsr	sub_110da

		mov	#0, r0h
		mov	r0h, @byte_ffff16:8
		jsr	sub_01fe8

		bsr	sub_062fc

		bra	loc_062ea


sub_062b6:	mov	@word_ffe99a, r0
		mov	r0, @word_ffe99e
		mov	#0xe600, r1
		or	r0h, r1h
		or	r0l, r1l
		mov	r1, @word_ffe99a
		mov	@word_ffe99c, r0
		mov	r0, @word_ffe9a0
		mov	#0, r1
		or	r0h, r1h
		or	r0l, r1l
		mov	r1, @word_ffe99c

loc_062ea:	mov	#word_ffe996, er1
		bsr	sub_06310

		mov	#word_ffe998, er1
		bsr	sub_06310

		rts

; ----------------------------------------------

sub_062fc:	push	er0
		mov	#task08o, r0h
		mov	#0, r1
		jsr	schedBackTaskDelayed

		pop	er0
		rts

; ----------------------------------------------

sub_06310:	mov	@er1, r0h
		beq	rts_06338

		dec	r0h
		push	er1
		jsr	sub_06502

		pop	er1
		bcc	rts_06338

		push	er1
		jsr	sub_065f4

		pop	er1
		mov	#0, r0h
		mov	r0h, @er1
		mov	r0h, @(1,er1)

rts_06338:	rts

; ----------------------------------------------

sub_0633a:	mov	#0, r0h
		mov	r0h, @word_ffe998
		mov	r0h, @word_ffe998+1
		jsr	sub_065f4

		rts

; ----------------------------------------------

sub_0634e:	mov	@word_ffe99e, r0
		mov	r0, @word_ffe99a
		mov	@word_ffe9a0, r0
		mov	r0, @word_ffe99c
		rts

; ----------------------------------------------

sub_06368:	jsr	sub_01fe8

.if !type1R
		mov	#0, r0h
		mov	r0h, @word_ffe996
		mov	r0h, @word_ffe996+1
		mov	r0h, @word_ffe998
		mov	r0h, @word_ffe998+1
.endif
		jsr	sub_065f4

		rts

; ----------------------------------------------

sub_0638c:	push	er0
		bsr	sub_063a0

		pop	er0
		bcs	rts_0639e

		mov	r0l, @word_ffe998+1

rts_0639e:	rts

; ----------------------------------------------

sub_063a0:	cmp	#byte_06631 - byte_0661c, r0h
		bhs	loc_063e2

		jsr	sub_06502

		bcs	loc_063e2

		mov	@word_ffe998, r0l
		beq	loc_063dc

		mov	r0h, r1l
		mov	#0, r1h
		mov	#0, e1
		mov	@(byte_0661c,er1), r2h
		mov	r0l, r1l
		dec	r1l
		mov	@(byte_0661c,er1), r2l
		cmp	r2h, r2l
		bls	loc_063d8

		bsr	sub_063e6

		clr	c
		bra	loc_063da

loc_063d8:	set	c

loc_063da:	bra	loc_063e0

loc_063dc:	bsr	sub_063e6

		clr	c

loc_063e0:	bra	rts_063e4

loc_063e2:	set	c

rts_063e4:	rts

; ----------------------------------------------

sub_063e6:	inc	r0h
		mov	r0h, @word_ffe998
		mov	#0, r0h
		mov	r0h, @word_ffe998+1
		mov	@word_ffe996, r3h
		bne	rts_06414

		jsr	sub_065f4

		mov	#0, er0
		mov	er0, @long_ffe9a4
		jsr	sub_062fc

rts_06414:	rts

; ----------------------------------------------

sub_06416:	mov	@word_ffe998, r0h
		beq	loc_06422

		dec	r0h
		bra	rts_06424

loc_06422:	mov	#-1, r0h

rts_06424:	rts

; ----------------------------------------------

		cmp	#8, r0h
		bhs	loc_0643a

		mov	@word_ffe99a, r0l
		bset	r0h, r0l
		mov	r0l, @word_ffe99a
		bra	rts_06480

loc_0643a:	cmp	#0x10, r0h
		bhs	loc_06452

		mov	@word_ffe99a+1, r0l
		add	#0xf8, r0h
		bset	r0h, r0l
		mov	r0l, @word_ffe99a+1
		add	#8, r0h
		bra	rts_06480

loc_06452:	cmp	#0x18, r0h
		bhs	loc_0646a

		mov	@word_ffe99c, r0l
		add	#0xf0, r0h
		bset	r0h, r0l
		mov	r0l, @word_ffe99c
		add	#0x10, r0h
		bra	rts_06480

loc_0646a:	cmp	#0x20, r0h
		bhs	rts_06480

		add	#0xe8, r0h
		mov	@word_ffe99c+1, r0l
		bset	r0h, r0l
		mov	r0l, @word_ffe99c+1
		add	#0x18, r0h

rts_06480:	rts

; ----------------------------------------------

		cmp	#8, r0h
		bhs	loc_06496

		mov	@word_ffe99a, r0l
		bclr	r0h, r0l
		mov	r0l, @word_ffe99a
		bra	rts_064dc

loc_06496:	cmp	#0x10, r0h
		bhs	loc_064ae

		mov	@word_ffe99a+1, r0l
		add	#0xf8, r0h
		bclr	r0h, r0l
		mov	r0l, @word_ffe99a+1
		add	#8, r0h
		bra	rts_064dc

loc_064ae:	cmp	#0x18, r0h
		bhs	loc_064c6

		mov	@word_ffe99c, r0l
		add	#0xf0, r0h
		bclr	r0h, r0l
		mov	r0l, @word_ffe99c
		add	#0x10, r0h
		bra	rts_064dc

loc_064c6:	cmp	#0x20, r0h
		bhs	rts_064dc

		mov	@word_ffe99c+1, r0l
		add	#0xe8, r0h
		bclr	r0h, r0l
		mov	r0l, @word_ffe99c+1
		add	#0x18, r0h

rts_064dc:	rts

; ----------------------------------------------

		mov	#-1, r0
		mov	r0, @word_ffe99a
		mov	r0, @word_ffe99c
		rts

; ----------------------------------------------

		mov	#0, r0
		mov	r0, @word_ffe99a
		mov	r0, @word_ffe99c
		rts

; ----------------------------------------------

sub_06502:	push	er0
		cmp	#8, r0h
		bhs	loc_06512

		mov	@word_ffe99a, r0l
		bra	loc_0653a

loc_06512:	cmp	#0x10, r0h
		bhs	loc_06520

		mov	@word_ffe99a+1, r0l
		add	#0xf8, r0h
		bra	loc_0653a

loc_06520:	cmp	#0x18, r0h
		bhs	loc_06520

		mov	@word_ffe99c, r0l
		add	#0xf0, r0h
		bra	loc_0653a

		cmp	#0x20, r0h
		bhs	loc_06520

		mov	@word_ffe99c+1, r0l
		add	#0xe8, r0h

loc_0653a:	btst	r0h, r0l
		beq	loc_06542

		set	c
		bra	loc_06544

loc_06542:	clr	c

loc_06544:	pop	er0
		rts

; ----------------------------------------------

sub_0654a:	cmp	#byte_06631 - byte_0661c, r0h
		bhs	rts_06576

		bsr	sub_06502

		bcs	rts_06576

		inc	r0h
		mov	r0h, @word_ffe996
		mov	r0l, @word_ffe996+1
		jsr	sub_065f4

		mov	#0, er0
		mov	er0, @long_ffe9a4
		jsr	sub_062fc

rts_06576:	rts

; ----------------------------------------------

sub_06578:	mov	@word_ffe996, r0h
		beq	rts_065a2

		mov	#0, r0
		mov	r0h, @word_ffe996
		mov	r0l, @word_ffe996+1
		jsr	sub_065f4

		mov	#0, er0
		mov	er0, @long_ffe9a4

rts_065a2:	rts

; ----------------------------------------------

sub_065a4:	zero	er1
		mov	r0h, r1l
		dec	r1l
		shll	er1
		mov	#off_06632, er0
		add	er1, er0
		mov	@er0, r1
		exts	er1
		add	er1, er0
		mov	er0, @long_ffe9a4
		rts

; ----------------------------------------------

sub_065c6:	btst	#7, @byte_ffff16:8
		bne	rts_065f2

		cmp	#0, r0h
		beq	sub_065f4

		mov	r0l, @tcora_0:8		; TMR_0 Time Constant Register A
		shlr	r0l
		mov	r0l, @tcorb_0:8		; TMR_0 Time Constant Register B
		mov	#6, r1h
		mov	r1h, @tcsr_0:8		; TMR_0 Timer Control/Status Register
		and	#3, r0h
		or	#8, r0h
		mov	r0h, @tcr_0:8		; TMR_0 Timer Control Register
		jsr	rts_078c6

		btst	#4, @byte_ffff16:8
		bne	rts_065f2

		jsr	sub_01fe8

		jsr	sub_0fe5c

rts_065f2:	rts

; ----------------------------------------------

sub_065f4:	mov	#0, r0h
		mov	r0h, @tcr_0:8		; TMR_0 Timer Control Register
		mov	#0xf0, r0h
		mov	r0h, @tcsr_0:8		; TMR_0 Timer Control/Status Register
		rts

; ----------------------------------------------

sub_065fe:	bsr	sub_065f4

		jsr	rts_078c8

		bset	#7, @byte_ffff16:8
		bld	#6, @byte_ffff16:8
		jsr	sub_01fee

		jsr	sub_0fe68

		rts

; ----------------------------------------------

sub_06616:	bclr	#7, @byte_ffff16:8
		rts

; ----------------------------------------------

byte_0661c:	.byte 0, 1, 2, 3, 3, 3, 4, 0
		.byte 2, 1, 5, 5, 5, 5, 5, 5
.if !type1R
		.byte 5, 5, 5, 5, 5
.endif
byte_06631:

		.align 1, -1
off_06632:	case  0 byte_0665c byte_06666 byte_06694 byte_066a0
		case  4 byte_066aa byte_066a0 byte_066b7 byte_066c4
		case  8 byte_066ce byte_066dd byte_06710 byte_066f3
		case 12 byte_06706 byte_06700 byte_066fa byte_066dd
.if !type1R
		case 16 byte_06715 byte_0671c byte_06720 byte_06727
		case 20 byte_06734
.endif

byte_0665c:	.byte  0,   0,   2
		.byte  2, 177,   8
		.byte  0,   0,   2
		.byte -1
byte_06666:	.byte  0,   0,  80
		.byte  2, 125,   4
		.byte  3,  31,   4
		.byte  2, 125,   4
		.byte  3,  31,   4
		.byte  2, 125,   4
		.byte  3,  31,   4
		.byte  0,   0,   8
		.byte  2, 125,   4
		.byte  3,  31,   4
		.byte  2, 125,   4
		.byte  3,  31,   4
		.byte  2, 125,   4
		.byte  3,  31,   4
		.byte  0,   0,   2
		.byte -1
byte_06694:	.byte  0,   0,   1
		.byte  2, 125,   1
		.byte  0,   0,   1
		.byte  2, 125,   1
byte_066a0:	.byte  0,   0,   2
		.byte  2, 125,   1
		.byte  0,   0,   1
		.byte -1
byte_066aa:	.byte  0,   0,   2
		.byte  2, 125,   2
		.byte  3,  31,   2
		.byte  0,   0,   2
		.byte -1
byte_066b7:	.byte  0,   0,   1
		.byte  2,  88,   1
		.byte  2, 111,   1
		.byte  0,   0,   1
		.byte -1
byte_066c4:	.byte  0,   0,   1
		.byte  2,  88,   2
		.byte  0,   0,   1
		.byte -1
byte_066ce:	.byte  0,   0,   2
		.byte  2,  88,   1
		.byte  0,   0,   1
		.byte  2,  88,   1
		.byte  0,   0,   2
byte_066dd:	.byte  0,   0,   1
		.byte  2,  88,   1
		.byte  0,   0,   1
		.byte  2,  88,   1
		.byte  0,   0,   1
		.byte  2,  88,   1
		.byte  0,   0,   2
		.byte -1
byte_066f3:	.byte  0,   0,   2
		.byte  3,  22,   1
		.byte -1
byte_066fa:	.byte  0,   0,   1
		.byte  3,  31,   1
byte_06700:	.byte  0,   0,   1
		.byte  3,  31,   1
byte_06706:	.byte  0,   0,   1
		.byte  3,  31,   1
		.byte  0,   0,   1
		.byte -1
byte_06710:	.byte  2,  88,  32
		.byte -1
		.byte -1
.if !type1R
byte_06715:	.byte  0,   0,   1
		.byte  2, 125,   1
		.byte -1
byte_0671c:	.byte  2,  88, 240
		.byte -1
byte_06720:	.byte  0,   0,   1
		.byte  2, 125,   1
		.byte -1
byte_06727:	.byte  0,   0,   1
		.byte  2,  88,   1
		.byte  2, 111,   1
		.byte  0,   0,   1
		.byte -1
byte_06734:	.byte  0,   0,   1
		.byte  3,  31,   1
		.byte  0,   0,   1
		.byte -1
.endif
		.align 1, -1

; ----------------------------------------------

loc_0673e:	not	r0h
		not	r0l
		mov	r0, @word_ffe99a
		rts

; ----------------------------------------------

		mov	@word_ffe99a, r0
		not	r0h
		not	r0l
		rts

; ----------------------------------------------

loc_06756:	not	r0h
		not	r0l
		mov	r0, @word_ffe99c
		rts

; ----------------------------------------------

sub_06762:	mov	@word_ffe99c, r0
		not	r0h
		not	r0l
		rts

; ----------------------------------------------

sub_0676e:	bset	#4, @byte_ffff16:8
		rts

; ----------------------------------------------

sub_06774:	bset	#5, @byte_ffff16:8
		bset	#6, @byte_ffff16:8
		mov	@word_ffe996, r0h
		bne	rts_06790

		mov	@word_ffe998, r0h
		bne	rts_06790

		jsr	sub_01fe2

rts_06790:	rts

; ----------------------------------------------

sub_06792:	bclr	#4, @byte_ffff16:8
		rts

; ----------------------------------------------

sub_06798:	bclr	#5, @byte_ffff16:8
		bclr	#6, @byte_ffff16:8
		jsr	sub_01fe8

		rts

; ----------------------------------------------

		mov	#0, r0h
		bld	#6, @byte_ffff16:8
		bst	#0, r0h
		rts

; ----------------------------------------------

sub_067b0:	mov	#task09o, r0h
		mov	#1003, r1
		jsr	schedBackTaskDelayed

		mov	#0, r0h
		mov	r0h, @word_ffe9b9
		bset	#0, r0h
		mov	r0h, @word_ffe9b8
		bset	#6, @byte_ffff17
		mov	#0xffff, r0
		jsr	setP2_567

		rts

; ----------------------------------------------

sub_067dc:	mov	#0x30, r1
		set	i
		mov	@word_ffe9b8, r0
		and	r1h, r0l
		and	r1l, r0h
		mov	r0, @word_ffe9b8
		clr	i
		zero	r0
		mov	#long_ffe9a8, er1

loc_067fc:	cmp	#4, r0h
		beq	loc_06806

		cmp	#5, r0h
		beq	loc_06806

		mov	r0h, @er1

loc_06806:	adds	#1, er1
		inc	r0l
		cmp	#8, r0l
		blo	loc_067fc

		bclr	#6, @byte_ffff17
		rts

; ----------------------------------------------

task09:		mov	#task09o, r0h
		jsr	checkSchedTask

		bcc	loc_06862

		bclr	#6, @byte_ffff17:8
		bclr	#5, @byte_ffff17:8
		mov	#0, r0h
		mov	#long_ffe9a8, er2

loc_06830:	mov	@er2, r1
		btst	#7, r1h
		beq	loc_06850

		bset	#5, @byte_ffff17:8
		push	er0
		push	er2
.if type1R
		bsr	sub_0687e
.else
		jsr	sub_0687e
.endif
		pop	er2
		pop	er0
		mov	r1, @er2

loc_06850:	adds	#2, er2
		inc	r0h
		cmp	#8, r0h
		bne	loc_06830

		mov	#task09o, r0h
		mov	#50, r1
		jsr	schedBackTaskDelayed

loc_06862:	btst	#6, @byte_ffff17:8
		bne	loc_06872

		mov	@word_ffe9b8, r0
		jsr	setP2_567

loc_06872:	mov	#task09o, r0h
		jsr	schedFrontTask

		bld	#5, @byte_ffff17:8
		rts

; ----------------------------------------------

sub_0687e:	dec	r1l
		beq	loc_06884

		bpl	rts_068c4

loc_06884:	zero	er2
		mov	r1h, r2l
		shlr	#2, r2l
		and	#0x1c, r2l
		add	#off_068c6, er2
		mov	@er2, er2
		zero	er3
		mov	r1h, r3l
		and	#0x0f, r3l
		add	er2, er3
		mov	@er3, r1l
		btst	#7, r1l
		beq	loc_068ac

		and	#0xf0, r1h
		mov	@er2, r1l

loc_068ac:	btst	#0, r1h
		bne	loc_068ba

		bset	r0h, @word_ffe9b8
		bra	loc_068c2

loc_068ba:	bclr	r0h, @word_ffe9b8

loc_068c2:	inc	r1h

rts_068c4:	rts


off_068c6:	.long byte_068d6, byte_068d9
.if !type1R
		.long byte_068dc, byte_068df
.endif

byte_068d6:	.byte 0x05, 0x05, 0x80
byte_068d9:	.byte 0x26, 0x02, 0x80
.if !type1R
byte_068dc:	.byte 0x4e, 0x02, 0x80
byte_068df:	.byte 0x02, 0x4e, 0x80
.endif

; ----------------------------------------------

sub_068e2:	set	c
		bra	loc_068e8

sub_068e6:	clr	c

loc_068e8:	stc	ccr, r0l
		cmp	#0x0f, r0h
		bhi	rts_06922

		push	er0
		bsr	sub_06924

		pop	er0
		zero	er1
		mov	r0h, r1l
		shlr	#2, r1l
		shlr	r1l
		add	#word_ffe9b8, er1
		and	#7, r0h
		ldc	r0l, ccr
		bcs	loc_06914

		bclr	r0h, @er1
		bra	loc_06918

loc_06914:	bset	r0h, @er1

loc_06918:	mov	@word_ffe9b8, r0
		jsr	setP2_567

rts_06922:	rts

; ----------------------------------------------

sub_06924:	cmp	#8, r0h
		bhi	rts_0693a

		zero	er1
		mov	r0h, r1l
		shll	r1l
		add	#long_ffe9a8, er1
		zero	r2
		mov	r2, @er1

rts_0693a:	rts

; ----------------------------------------------

sub_0693c:	mov	#0x8000, r1

loc_06940:	cmp	#8, r0h
		bhi	rts_06954

		zero	er2
		mov	r0h, r2l
		shll	r2l
		add	#long_ffe9a8, er2
		mov	r1, @er2

rts_06954:	rts


loc_06956:	mov	#0x9000, r1
		bra	loc_06940

.if !type1R
		mov	#0xa000, r1
		bra	loc_06940

		mov	#0xb000, r1
		bra	loc_06940
.endif

; ----------------------------------------------

sub_06968:	bld	#0, r0h
		bst	#0, @word_ffe9b9
		bld	#1, r0h
		bst	#2, @word_ffe9b9
		bld	#2, r0h
		bst	#1, @word_ffe9b9
		mov	#task09o, r0h
		jsr	schedBackTask

		rts

; ----------------------------------------------

task10:		mov	@word_ffe9ba, r0
		jsr	cmpTick

		mov	#1000, r1
		cmp	r1, r0
		blo	loc_069fe

		push	er0
		sub	r1, r0
		mov	@tick, r1
		sub	r0, r1
		mov	r1, @word_ffe9ba
		mov	@word_ffe9be, r0
		inc	#1, r0
		mov	r0, @word_ffe9be
		btst	#7, @byte_ffff19:8
		beq	loc_069e8

		mov	@internalDateL, r0
		inc	#1, r0
		mov	r0, @internalDateL
		mov	r0, r1
		bne	loc_069e8

		mov	@internalDateH, r0
		inc	#1, r0
		mov	r0, @internalDateH

loc_069e8:	pop	er0
		mov	#2000, r1
		sub	r0, r1
		mov	#task10o, r0h
		jsr	schedBackTaskDelayed

		mov	#task10o, r0h
		jsr	schedFrontTask

loc_069fe:	clr	c
		rts

; ----------------------------------------------

jSetupTMR_XY:	jsr	setupTMR_XY

enableTMR_01XY: b clr	mstpcrh.mstp12		; TMR_0, TMR_1 (Module Stop Control Register H)
		b clr	mstpcrh.mstp8		; TMR_X, TMR_Y (Module Stop Control Register H)
		mov	@tick, r0
		mov	r0, @word_ffe9ba
		rts

; ----------------------------------------------

sub_06a1c:	mov	#0, r0h
		set	i
		b ld	syscr.hie		; XBR Host Interface Enable (System Control Register)
		b clr	syscr.hie		; XBR Host Interface Enable (System Control Register)
		b set	tconrs.tmrx_y		; TMR_X/TMR_Y Access Select (Timer Connection Register S)
		mov	r0h, @tcr_y:8		; TMR_Y Timer Control Register
		mov	r0h, @tcsr_y:8		; TMR_Y Timer Control/Status Registers
		b st	syscr.hie		; XBR Host Interface Enable (System Control Register)
		clr	i
		rts

; ----------------------------------------------

sub_06a38:	jsr	setupTMR_XY

		rts

; ----------------------------------------------

sub_06a3e:	mov	#0, r0h
		set	i
		b ld	syscr.hie		; XBR Host Interface Enable (System Control Register)
		b clr	syscr.hie		; XBR Host Interface Enable (System Control Register)
		b set	tconrs.tmrx_y		; TMR_X/TMR_Y Access Select (Timer Connection Register S)
		mov	r0h, @tcr_y:8		; TMR_Y Timer Control Register
		mov	r0h, @tcsr_y:8		; TMR_Y Timer Control/Status Registers
		b st	syscr.hie		; XBR Host Interface Enable (System Control Register)
		clr	i
		rts

; ----------------------------------------------

setupTMR_XY:	mov	#0xfa, r0h
		mov	#9, r0l
		bset	#6, r0l
		mov	#0, r1h
		set	i
		b ld	syscr.hie		; XBR Host Interface Enable (System Control Register)
		b clr	syscr.hie		; XBR Host Interface Enable (System Control Register)
		b set	tconrs.tmrx_y		; TMR_X/TMR_Y Access Select (Timer Connection Register S)
		mov	r0h, @tcora_y:8		; TMR_Y Time Constant Register A
		b st	syscr.hie		; XBR Host Interface Enable (System Control Register)
		clr	i
		set	i
		b ld	syscr.hie		; XBR Host Interface Enable (System Control Register)
		b clr	syscr.hie		; XBR Host Interface Enable (System Control Register)
		b set	tconrs.tmrx_y		; TMR_X/TMR_Y Access Select (Timer Connection Register S)
		mov	r1h, @tcnt_y:8		; TMR_Y Timer Counter
		b clr	tcsr_y.cmfa		; Compare-Match Flag A (TMR_Y Timer Control/Status Registers)
		mov	r0l, @tcr_y:8		; TMR_Y Timer Control Register
		b st	syscr.hie		; XBR Host Interface Enable (System Control Register)
		clr	i
		rts

; ----------------------------------------------

; TMR_Y Compare Match A

cmiay:		b ld	syscr.hie		; XBR Host Interface Enable (System Control Register)
		b clr	syscr.hie		; XBR Host Interface Enable (System Control Register)
		b set	tconrs.tmrx_y		; TMR_X/TMR_Y Access Select (Timer Connection Register S)
		b clr	tcr_y.cmiea		; Compare-Match Interrupt Enable A (TMR_Y Timer Control Register)
		b clr	tcsr_y.cmfa		; Compare-Match Flag A (TMR_Y Timer Control/Status Registers)
		b st	syscr.hie		; XBR Host Interface Enable (System Control Register)
		clr	i
		push	er0
		mov	@word_ffe9bc, r0
		inc	#1, r0
		mov	r0, @word_ffe9bc
		pop	er0
		set	i
		b ld	syscr.hie		; XBR Host Interface Enable (System Control Register)
		b clr	syscr.hie		; XBR Host Interface Enable (System Control Register)
		b set	tconrs.tmrx_y		; TMR_X/TMR_Y Access Select (Timer Connection Register S)
		b set	tcr_y.cmiea		; Compare-Match Interrupt Enable A (TMR_Y Timer Control Register)
		b st	syscr.hie		; XBR Host Interface Enable (System Control Register)
		rte

; ----------------------------------------------

; r0 yr, r1h month, r1l day, r2h 24hr, r2l min, r3h sec

setDate:	push	er0
		jsr	ckValidDate

		bcc	valid

		jmp	invalid

valid:		mov	#1980, r4
		sub	r4, r0
		mov	r0l, r0h
		beq	0f

		dec	r0l
		shlr	r0l
		shlr	r0l
		inc	r0l

0:		mov	#0x78, r4h
		cmp	r4h, r0h
		bls	loc_06b06

		dec	r0l

loc_06b06:	mov	#0x6d, r4l
		mulxu	r0h, r4
		add	r0h, r4h
		add	r0l, r4l
		addx	#0, r4h
		dec	r1h
		mov	@sp, er0		; pop+push er0
		jsr	isNotLeapYr

		bcs	loc_06b24

		mov	#leapYrDays, er5
		bra	loc_06b2a

loc_06b24:	mov	#nonLeapYrDays, er5

loc_06b2a:	shll	r1h
		add	r1h, r5l
		addx	#0, r5h
		bcc	loc_06b34

		inc	#1, e5

loc_06b34:	mov	@er5, r0
		add	r0, r4
		dec	r1l
		add	r1l, r4l
		addx	#0, r4h
		mov	r2h, r0l
		mov	#60, r0h
		mulxu	r0h, r0
		add	r2l, r0l
		addx	#0, r0h
		push	er3
		push	er0
		mov	#1440, r0
		mov	r4, r1
		jsr	sub_0c4ee

		pop	er2
		add	r2, r0
		bcc	loc_06b64

		inc	#1, r1

loc_06b64:	mov	r0, r2
		mov	r1, r3
		mov	#6, r4h

loc_06b6a:	shll	r0l
		rotxl	r0h
		rotxl	r1l
		rotxl	r1h
		dec	r4h
		bne	loc_06b6a

		shll	r2l
		rotxl	r2h
		rotxl	r3l
		rotxl	r3h
		shll	r2l
		rotxl	r2h
		rotxl	r3l
		rotxl	r3h
		sub	r2, r0
		bcc	loc_06b8c

		dec	#1, r1

loc_06b8c:	sub	r3, r1
		pop	er3
		add	r3h, r0l
		addx	#0, r0h
		addx	#0, r1l
		addx	#0, r1h
		mov	r0, @internalDateL
		mov	r1, @internalDateH
		bset	#7, @byte_ffff19:8
		jsr	sub_0c83c

		clr	c

invalid:	pop	er0
		rts


nonLeapYrDays:	.word 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365
leapYrDays:	.word 0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366

; ----------------------------------------------

daysPerMonth:	push	er1
		push	er2
		push	er3
		bsr	isNotLeapYr

		bcs	loc_06c02

		mov	#leapYrDays, er2
		bra	loc_06c08

loc_06c02:	mov	#nonLeapYrDays, er2

loc_06c08:	dec	r1h
		shll	r1h
		add	r1h, r2l
		addx	#0, r2h
		bcc	loc_06c14

		inc	#1, e2

loc_06c14:	mov	@er2+, r3
		mov	@er2, r2
		sub	r3, r2
		mov	r2l, r0h
		pop	er3
		pop	er2
		pop	er1
		rts

; ----------------------------------------------

; r0 yr, r1h month, r1l day, r2h 24hr, r2l min, r3h sec

ckValidDate:	push	er4
		mov	#2108, r4
		cmp	r4, r0
		bhs	invalidDate

		mov	#1980, r4
		cmp	r4, r0
		blo	invalidDate

		cmp	#1, r1h
		blo	invalidDate

		cmp	#12, r1h
		bhi	invalidDate

		cmp	#1, r1l
		blo	invalidDate

		push	er0
		jsr	daysPerMonth

		mov	r0h, r4h
		pop	er0
		cmp	r4h, r1l
		bhi	invalidDate

		cmp	#24, r2h
		bhs	invalidDate

		cmp	#60, r2l
		bhs	invalidDate

		cmp	#60, r3h
		bhs	invalidDate

		clr	c
		bra	loc_06c6e

invalidDate:	set	c

loc_06c6e:	pop	er4
		rts

; ----------------------------------------------

isNotLeapYr:	push	er0
		push	er1
		push	er2
		shlr	r0h
		rotxr	r0l
		bcs	loc_06cb6

		shlr	r0h
		rotxr	r0l
		bcs	loc_06cb6

		mov	#25, r1h
		mov	#0, r2h
		mov	r0h, r2l
		beq	loc_06c98

		divxu	r1h, r2
		mov	r2l, r0h

loc_06c98:	mov	r0l, r2l
		divxu	r1h, r2
		mov	r2l, r0l
		cmp	#0, r2h
		bne	loc_06cb2

		btst	#0, r0l
		bne	loc_06cae

		btst	#1, r0l
		bne	loc_06cae

		clr	c
		bra	loc_06cb0

loc_06cae:	set	c

loc_06cb0:	bra	loc_06cb4

loc_06cb2:	clr	c

loc_06cb4:	bra	loc_06cb8

loc_06cb6:	set	c

loc_06cb8:	pop	er2
		pop	er1
		pop	er0
		rts

; ----------------------------------------------

sub_06cc6:	bild	#7, @byte_ffff19:8
		bcc	loc_06cd0

		jmp	rts_06db0

loc_06cd0:	mov	@internalDateL, r2
		mov	@internalDateH, r3
		mov	#60, r1
		jsr	sub_0c49a

		push	er4
		mov	r0, r2
		mov	r1, r3
		mov	#60, r1
		jsr	sub_0c49a

		push	er4
		mov	r0, r2
		mov	r1, r3
		mov	#24, r1
		jsr	sub_0c49a

		push	er4
		mov	r0, r2
		mov	r1, r3
		mov	#365, r1
		jsr	sub_0c49a

		cmp	#0, r0l
		beq	loc_06d20

		mov	#365, r1
		add	r1, r4
		dec	r0l

loc_06d20:	mov	r0l, r0h
		beq	loc_06d38

		dec	r0l
		shlr	r0l
		shlr	r0l
		inc	r0l
		mov	#120, r1h
		cmp	r1h, r0h
		bls	loc_06d34

		dec	r0l

loc_06d34:	sub	r0l, r4l
		subx	#0, r4h

loc_06d38:	push	er0
		mov	#1980, r1
		add	r0h, r1l
		addx	#0, r1h
		mov	r1, r0
		jsr	isNotLeapYr

		pop	er0
		bcs	loc_06d56

		mov	#366, r1
		bra	loc_06d5a

loc_06d56:	mov	#365, r1

loc_06d5a:	cmp	r1, r4
		blo	loc_06d62

		inc	r0h
		sub	r1, r4

loc_06d62:	mov	#1980, r1
		add	r0h, r1l
		addx	#0, r1h
		mov	r1, r0
		jsr	isNotLeapYr

		bcs	loc_06d7a

		mov	#leapYrDays, er1
		bra	loc_06d80

loc_06d7a:	mov	#nonLeapYrDays, er1

loc_06d80:	mov	#0, r2h

loc_06d82:	mov	@er1+, r3
		cmp	r3, r4
		blo	loc_06d8c

		inc	r2h
		bra	loc_06d82

loc_06d8c:	cmp	#1, r2h
		beq	loc_06d96

		mov	@(-4,er1), r3
		sub	r3, r4

loc_06d96:	mov	r2h, r1h
		mov	r4l, r1l
		inc	r1l
		pop	er2
		mov	r2l, r2h
		pop	er3
		mov	r3l, r2l
		pop	er3
		mov	r3l, r3h
		clr	c

rts_06db0:	rts

; ----------------------------------------------

sub_06db2:	jsr	sub_06cc6

		bcs	rts_06dd6

		mov	#1980, r2
		sub	r2, r0
		shll	r0l
		shll	r1h
		shll	r1h
		shll	r1h
		shll	r1h
		shll	r1h
		bst	#0, r0l
		mov	r0l, r0h
		mov	r1l, r0l
		and	#0x1f, r0l
		or	r1h, r0l
		clr	c

rts_06dd6:	rts

; ----------------------------------------------

		mov	r0, r1
		beq	loc_06de8

		shlr	r1h
		add	#0, r1h
		and	#1, r0h
		shll	r1h
		or	r1h, r0h
		bra	rts_06dec

loc_06de8:	mov	#0, r0

rts_06dec:	rts

; ----------------------------------------------

long_06dee:	.long 0xffffffff, 0x00000000
.if     type1R
long_06df6:	.long 0xffffffff, 0x00000000
long_06dfe:	.long 0xfffffffb, 0x00000004
.elseif type70
long_06df6:	.long 0xffffffff, 0x00000000
long_06dfe:	.long 0xffffffff, 0x00000000
.else
long_06df6:	.long 0xffffdfff, 0x00000000
long_06dfe:	.long 0xffffdfff, 0x00000000
.endif

; ----------------------------------------------

task11:		mov	#task11o, r0h
		jsr	checkSchedTask

		bcc	loc_06fc8:16

		btst	#3, @byte_ffff1a:8
		beq	loc_06e48

		mov	@word_ffe9c4, r0
		jsr	cmpTick

		bcc	loc_06e46

		bclr	#3, @byte_ffff1a:8
		mov	@byte_ffe9c8, er0
		jsr	sub_10dfa

		mov	@byte_ffe9c8, er0
		mov	er0, er1
		mov	#8, er1
		bsr	sub_0705a:16

loc_06e46:	bra	loc_06e58

loc_06e48:	jsr	sub_0126e

		bcc	loc_06e58

		b ld	pb2pin			; Pin PB2/-WUE2/-CS3 (Port B Input Data Register)
		bcs	loc_06e58

		jsr	sub_011fe

loc_06e58:	btst	#2, @byte_ffff1a:8
		beq	loc_06ea0

		mov	@word_ffe9c6, r0
		jsr	cmpTick

		bcc	loc_06ea0

		bclr	#2, @byte_ffff1a:8
		push	er0
		stc	ccr, r0l
		set	i
		b clr	p95dr			; Pin P95/-CS1 (Port 9 Data Register)
		mov	@P9DDRcopy, r0h
		bset	#5, r0h
		mov	r0h, @P9DDRcopy
		mov	r0h, @p9ddr:8		; Port 9 Data Direction Register
		ldc	r0l, ccr
		pop	er0
		btst	#5, @byte_ffff1a:8
		bne	loc_06ea0

		mov	#0x28, r0h
		jsr	sub_10cc0

		bset	#5, @byte_ffff1a:8

loc_06ea0:	bclr	#7, @byte_ffff1a:8
		mov	#task11o, r0h
		mov	#10, r1
		jsr	schedBackTaskDelayed

		mov	#0, r0
		mov	r0, r1
		bsr	sub_07374:16

		mov	r1, e0
		mov	@long_ffe9dc, er2
		mov	@er2+, er3
		and	er3, er0
		mov	@er2+, er3
		or	er3, er0
		zero	er3
		not	er3
		zero	er6
		mov	er0, er1
		mov	#long_ffe9cc, er2
		mov	#4, r4h

loc_06ee6:	mov	@er2+, er5
		xor	er1, er5
		or	er5, er6
		not	er5
		and	er5, er3
		dec	r4h
		bne	loc_06ee6

		or	#0x00 + 0x40 & type1R, er3
		mov	#long_07598, er2

loc_06f08:	mov	@er2+, er5
		beq	loc_06f20

		mov	er5, er4
		and	er3, er4
		cmp	er4, er5
		beq	loc_06f1e

		not	er5
		and	er5, er3

loc_06f1e:	bra	loc_06f08

loc_06f20:	zero	er2
		mov	@byte_ffe4c0, r2l
		_mov	er0, long_ffe9cc,er2
		add	#4, r2l
		and	#0x0c, r2l
		mov	r2l, @byte_ffe4c0
		mov	@byte_ffe9c8, er1
		mov	er1, er2
		xor	er0, er2
		and	er3, er2
		beq	loc_06f82

		and	er3, er0
		not	er3
		and	er3, er1
		or	er0, er1
		mov	er1, @byte_ffe9c8
		btst	#3, @byte_ffff1a:8
		bne	loc_06f80

		mov	er2, er1
		bsr	sub_0705a:16

		mov	@byte_ffe9c8, er0
		jsr	sub_10dfa

loc_06f80:	bra	loc_06f8a

loc_06f82:	mov	er6, er6
		beq	loc_06f8a

		bset	#7, @byte_ffff1a:8

loc_06f8a:	btst	#4, @byte_ffff1a:8
		beq	loc_06fa4

		btst	#0, @byte_ffff1a:8
		beq	loc_06fa0

		jsr	sub_045ce

		mov	#0x33, r0h
		jsr	sub_10cc0

loc_06fa0:	b set	tier.icice		; Input Capture Interrupt C Enable (FRT Timer Interrupt Enable Register)

loc_06fa4:	bclr	#0, @byte_ffff1a:8
		btst	#1, @byte_ffff1a:8
		beq	loc_06fb8

		mov	#0x37, r0h
		jsr	sub_10cc0

		bclr	#1, @byte_ffff1a:8

loc_06fb8:	btst	#7, @byte_ffff1b:8
		beq	loc_06fc8

		mov	#0x3b, r0h
		jsr	sub_10cc0

		bclr	#7, @byte_ffff1b:8

loc_06fc8:	mov	#task11o, r0h
		jsr	schedFrontTask

		btst	#3, @byte_ffe9cb
		beq	loc_06fdc

		set	c
		bra	rts_06fe0

loc_06fdc:	bld	#7, @byte_ffff1a:8

rts_06fe0:	rts

; ----------------------------------------------

sub_06fe2:	zero	er0
		mov	er0, @byte_ffe9c8
		mov	er0, @long_ffe9cc
		mov	er0, @long_ffe9d0
		mov	er0, @long_ffe9d4
		mov	er0, @long_ffe9d8
		mov	r0h, @byte_ffe4c0
		mov	r0h, @byte_ffff1a:8
		mov	#task11o, r0h
		mov	#100, r1
		jsr	schedBackTaskDelayed

		mov	@tick, r0
		mov	#600, r1
		add	r0, r1
		mov	r1, @word_ffe9c4
		bset	#3, @byte_ffff1a:8
		mov	#long_06dfe, er0
		mov	er0, @long_ffe9dc
		bset	#5, @byte_ffff1a:8
		rts

; ----------------------------------------------

sub_0704a:	mov	#long_06df6, er0
		mov	er0, @long_ffe9dc
		rts

; ----------------------------------------------

sub_0705a:	stm	er0-er1, @-sp
		mov	#off_07418, er2
		mov	#off_073d8, er4
		mov	#0x20, r3h

loc_0706c:	shlr	er1
		bcc	loc_070be

		stm	er0-er3, @-sp
		push	er4
		mov	@er2, r4
		beq	loc_0709c

		exts	er4
		add	er4, er2

loc_07080:	mov	@er2+, er4
		beq	loc_0709c

		bld	#0, r0l
		push	er0
		push	er2
		jsr	@er4

		pop	er2
		pop	er0
		bra	loc_07080

loc_0709c:	pop	er4
		btst	#0, r0l
		bne	loc_070aa

		mov	@(1,er4), r0h
		bra	loc_070ac

loc_070aa:	mov	@er4, r0h

loc_070ac:	beq	loc_070ba

		push	er4
		jsr	sub_10cc0

		pop	er4

loc_070ba:	ldm	@sp+, er0-er3

loc_070be:	shlr	er0
		adds	#2, er2
		adds	#2, er4
		dec	r3h
		bne	loc_0706c

		ldm	@sp+, er0-er1
		mov	#long_07598, er2
		mov	#byte_075a0, er3
		mov	#off_075a2, er4

loc_070de:	mov	@er2+, er5
		beq	rts_07126

		and	er1, er5
		beq	loc_07120

		stm	er0-er3, @-sp
		push	er4
		mov	@er3, r0h
		beq	loc_070fa

		jsr	sub_10cc0

loc_070fa:	mov	@sp, er4		; pop+push er4
		mov	@er4, r5
		beq	loc_07118

		exts	er5
		add	er5, er4

loc_07106:	mov	@er4+, er5
		beq	loc_07118

		push	er4
		jsr	@er5

		pop	er4
		bra	loc_07106

loc_07118:	pop	er4
		ldm	@sp+, er0-er3

loc_07120:	adds	#1, er3
		adds	#2, er4
		bra	loc_070de

rts_07126:	rts

; ----------------------------------------------

sub_07128:
.if type1R
		bcc	loc_071aa

.else
		bcs	loc_0712e

		jmp	loc_071aa

loc_0712e:
.endif
.if level < 0x01000062
		jsr	sub_0126e

		bcs	loc_0716c
.else
		jsr	sub_01276

		bcc	loc_0716c
.endif

		push	er0
		stc	ccr, r0l
		set	i
		b clr	p95dr			; Pin P95/-CS1 (Port 9 Data Register)
		mov	@P9DDRcopy, r0h
		bset	#5, r0h
		mov	r0h, @P9DDRcopy
		mov	r0h, @p9ddr:8		; Port 9 Data Direction Register
		ldc	r0l, ccr
		pop	er0
.if level < 0x01000062
		bra	loc_071d4
.else
		jsr	sub_01272

		bcs	loc_071d4

		mov	#0x28, r0h
		jsr	sub_10cc0

		bclr	#2, @byte_ffff1a:8
		bset	#5, @byte_ffff1a:8
		bra	rts_071dc
.endif

loc_0716c:	btst	#6, @byte_ffff1a:8
		beq	loc_0717a

		mov	#8, r0h
		jsr	sub_063a0

		bra	loc_071a8

loc_0717a:	bset	#2, @byte_ffff1a:8
		btst	#2, @byte_ffe9cb
		bne	loc_0718e

		mov	#0, r1
		bra	loc_0719a

loc_0718e:	mov	@delayTabPtr, er1
		mov	@(6,er1), r1

loc_0719a:	mov	@tick, r0
		add	r1, r0
		mov	r0, @word_ffe9c6

loc_071a8:	bra	rts_071dc

loc_071aa:	push	er0
		stc	ccr, r0l
		set	i
		mov	@P9DDRcopy, r0h
		bclr	#5, r0h
		mov	r0h, @P9DDRcopy
		mov	r0h, @p9ddr:8		; Port 9 Data Direction Register
		ldc	r0l, ccr
		pop	er0
		btst	#5, @byte_ffff1a:8
		beq	loc_071d4

		mov	#0x29, r0h
		jsr	sub_10cc0

loc_071d4:	bclr	#2, @byte_ffff1a:8
		bclr	#5, @byte_ffff1a:8

rts_071dc:	rts

; ----------------------------------------------

sub_071de:	bcc	rts_071f2

		btst	#2, @byte_ffe9cb
		beq	rts_071f2

		jsr	rts_10eee

		jsr	sub_045ce

rts_071f2:	rts

; ----------------------------------------------

sub_071f4:	stc	ccr, r0h
		push	er0
		jsr	sub_0126e

		pop	er0
		bcc	loc_0722e

		ldc	r0h, ccr
.if level >= 0x01000062
		stc	ccr, r0h
		push	er0
		jsr	sub_148d4

		pop	er0
		ldc	r0h, ccr
.endif
		bcc	loc_07224

		jsr	sub_06416

		cmp	#1, r0h
		bne	loc_07224

		jsr	sub_0633a

loc_07224:	mov	#6, r0h
		jsr	sub_063a0

		jsr	sub_0fe38

loc_0722e:	jsr	sub_0d8d6

		jsr	sub_0d862

		rts

; ----------------------------------------------

sub_07238:	clr	c
		rts

; ----------------------------------------------

		stc	ccr, r0l
		set	i
		mov	@P2DDRcopy, r0h
		btst	#4, r0h			; p24ddr
		beq	loc_07256

		b ild	p24dr			; Pin P24/PW12 (Port 2 Data Register)
		bst	#0, r0h
		ldc	r0l, ccr
		bld	#0, r0h
		bra	rts_07260

loc_07256:	mov	@byte_ffe9c8, r0h
		ldc	r0l, ccr
		bld	#3, r0h

rts_07260:	rts

; ----------------------------------------------

sub_07262:	bclr	#6, @byte_ffff1a:8
		rts

; ----------------------------------------------

sub_07268:	bset	#6, @byte_ffff1a:8
		rts

; ----------------------------------------------

		mov	#0, r0h
		bld	#6, @byte_ffff1a:8
		bist	#0, r0h
		rts

; ----------------------------------------------

sub_07278:	bld	#6, r0h
		jsr	rts_02084

		and	#0x70, r0h
		b ld	p14dr			; Pin P14/PW4 (Port 1 Data Register)
		bst	#0, r0h
		b ld	p15dr			; Pin P15/PW5 (Port 1 Data Register)
		bst	#1, r0h
.if type1R
		b ld	p16dr
		bst	#2, r0h
		b ld	p17dr
		bst	#3, r0h
.else
		bclr	#2, r0h
		bclr	#3, r0h
.endif
		rts

; ----------------------------------------------

sub_07292:	bsr	sub_075ac:16

		mov	r0l, r0h
		rts

; ----------------------------------------------

sub_0729a:	bset	#4, @byte_ffff1a:8
		rts

; ----------------------------------------------

sub_072a0:	bclr	#4, @byte_ffff1a:8
		rts

; ----------------------------------------------

loc_072a6:	mov	#100, r0h
		divxu	r0h, r1
		mov	r1l, r0h
		rts

; ----------------------------------------------

rts_072ae:	rts

; ----------------------------------------------

sub_072b0:	mov	@delayTabPtr, er1
		mov	@(6,er1), r1
		bra	loc_072a6

; ----------------------------------------------

sub_072be:	mov	#0, r0h
		rts

; ----------------------------------------------

		push	er1
		zero	er1
		mov	r0h, r1l
		shlr	#2, r1l
		shlr	r1l
		add	#byte_ffe9c8, er1
		and	#7, r0h
		btst	r0h, @er1
		beq	loc_072e2

		set	c
		bra	loc_072e4

loc_072e2:	clr	c

loc_072e4:	pop	er1
		rts

; ----------------------------------------------

sub_072ea:	mov	#long_06dee, er0
		mov	er0, @long_ffe9dc
		bclr	#7, @byte_ffff1b:8
		b set	tier.icibe		; Input Capture Interrupt B Enable (FRT Timer Interrupt Enable Register)
		bclr	#1, @byte_ffff1a:8
		rts

; ----------------------------------------------

sub_07306:	bclr	#0, @byte_ffff1a:8
		mov	#long_06dee, er0
		mov	er0, @long_ffe9dc
		rts

; ----------------------------------------------

sub_0731a:	mov	@byte_ffe9c8, r0
		mov	@byte_ffe9ca, r1
		stm	er0-er1, @-sp
		jsr	sub_06fe2

		ldm	@sp+, er0-er1
		mov	r0, @byte_ffe9c8
		mov	r1, @byte_ffe9ca
		b clr	tier.icibe		; Input Capture Interrupt B Enable (FRT Timer Interrupt Enable Register)
		bclr	#7, @byte_ffff1b:8
		bclr	#1, @byte_ffff1a:8
		b clr	tier.icibe		; Input Capture Interrupt B Enable (FRT Timer Interrupt Enable Register)
		rts

; ----------------------------------------------

; FRT Input Capture C

icic:		b clr	tier.icice		; Input Capture Interrupt C Enable (FRT Timer Interrupt Enable Register)
		bset	#0, @byte_ffff1a:8
		b clr	tcsr.icfc		; Input Capture Flag C (FRT Timer Control/Status Register)
		rte

; ----------------------------------------------

; FRT Input Capture B

icib:		b clr	tcsr.icfb		; Input Capture Flag B (FRT Timer Control/Status Register)
		bset	#1, @byte_ffff1a:8
		rte

; ----------------------------------------------

		btst	#5, @byte_ffff1a:8
		bne	rts_07372

		btst	#3, @byte_ffff1a:8

rts_07372:	rts

; ----------------------------------------------

sub_07374:	b ild	p67dr			; Pin P67/-IRQ7/TMOX/-KIN7/CIN7 (Port 6 Data Register)
		bst	#0, r0l
		b ld	pc0pin			; Pin PC0 (Port C Input Data Register)
		bst	#2, r0l
		b ild	p94dr			; Pin P94/-IOW (Port 9 Data Register)
		bst	#3, r0l
		b ild	p65dr			; Pin P65/FTID/-KIN5/CIN5 (Port 6 Data Register)
		bst	#4, r0l
.if type1R
		b ild	p60dr			; Pin P60/FTCI/TMIX/-KIN0/CIN0/HFBACKI (Port 6 Data Register)
		bst	#5, r0l
		b ild	p80dr			; Pin Pin P80/HA0/-PME (Port 8 Data Register)
		bst	#6, r0l
.endif
.if level >= 0x01000062
		b ild	pd7pin			; Pin PD7 (Port D Input Data Register)
		bst	#7, r0l
.endif
		b ild	p61dr			; Pin P61/FTOA/-KIN1/CIN1/VSYNCO (Port 6 Data Register)
		bst	#0, r0h
		b ild	pc1pin			; Pin PC1 (Port C Input Data Register)
		bst	#1, r0h
		b ld	p14dr			; Pin P14/PW4 (Port 1 Data Register)
		bst	#2, r0h
		b ld	p15dr			; Pin P15/PW5 (Port 1 Data Register)
		bst	#3, r0h
.if !type70
.if type1R
		b ld	p16dr			; Pin P16/PW6 (Port 1 Data Register)
.else
		b ild	p16dr			; Pin P16/PW6 (Port 1 Data Register)
.endif
		bst	#4, r0h
		b ld	p17dr			; Pin P17/PW7 (Port 1 Data Register)
		bst	#5, r0h
.endif
		b ld	p93dr			; Pin P93/-IOR (Port 9 Data Register)
		bst	#7, r0h
.if type1R
		b ild	p66dr			; Pin P66/-IRQ6/FTOB/-KIN6/CIN6 (Port 6 Data Register)
		bst	#5, r1l
.else
		b ld	pa0pin			; Pin PA0/-KIN8/CIN8 (Port A Input Data Register)
		bst	#0, r1l
.endif
.if !type70
		b ld	pd4pin			; Pin PD4 (Port D Input Data Register)
		bst	#6, r1l
.endif
		b ld	p90dr			; Pin P90/-IRQ2/-ADTRG/-ECS2 (Port 9 Data Register)
		bst	#7, r1l
		rts

; ----------------------------------------------

off_073d8:	.word 0x3900, 0,      0x2A2B, 0
.if type1R
		.word 0x2627, 0x5400, 0x3e00, 0
.else
		.word 0x2627, 0,      0,      0
.endif
		.word 0x2C2D, 0x5000, 0,      0
		.word 0,      0,      0,      0x5253
		.word 0,      0,      0,      0
.if     type1R
		.word 0,      0x5600, 0x5700, 0x3C00
.elseif type70
		.word 0,      0,      0,      0x3C00
.else
		.word 0,      0,      0x5700, 0x3C00
.endif
		.word 0,      0,      0,      0
		.word 0,      0,      0,      0


off_07418:	case  0 off_07458
		case  2 off_07468 off_07474 off_0747c
.if type1R
		case  5 off_072b4
.endif
.if level >= 0x01000062
		case  7 off_07488
.endif
		case  8 off_07490
.if !type1R && !type70
		case 13 off_07498
.endif
.if !type1R
		case 16 off_074a0
.else
		case 21 off_074a0
.endif
		case 32


off_07458:	.long sub_071de, sub_07c40, sub_07de2, NULL

off_07468:	.long sub_0ec7e, sub_02060, NULL

off_07474:	.long sub_07128, NULL

off_0747c:	.long sub_071f4, sub_147ec, NULL

.if type1R
off_072b4:	.long sub_01fca, NULL
.endif

.if level >= 0x01000062
off_07488:	.long sub_14a38, NULL
.endif

off_07490:	.long sub_0204e, NULL

.if !type1R && !type70
off_07498:	.long sub_14d84, NULL
.endif

off_074a0:	.long sub_02090, NULL

; ----------------------------------------------

sub_074a8:	bild	#0, @byte_ffe9cb
		rts

; ----------------------------------------------

		bild	#1, @byte_ffe9cb
		rts

; ----------------------------------------------

sub_074bc:	bld	#2, @byte_ffe9cb
		rts

; ----------------------------------------------

		bild	#3, @byte_ffe9cb
		rts

; ----------------------------------------------

sub_074d0:	bild	#4, @byte_ffe9cb
		rts

; ----------------------------------------------

		bild	#5, @byte_ffe9cb
		rts

; ----------------------------------------------

		bild	#6, @byte_ffe9cb
		rts

; ----------------------------------------------

sub_074ee:	bild	#7, @byte_ffe9cb
		rts

; ----------------------------------------------

sub_074f8:	bld	#0, @byte_ffe9ca
		rts

; ----------------------------------------------

		bild	#1, @byte_ffe9ca
		rts

; ----------------------------------------------

		bild	#2, @byte_ffe9ca
		rts

; ----------------------------------------------

		bild	#3, @byte_ffe9ca
		rts

; ----------------------------------------------

sub_07520:	bild	#4, @byte_ffe9ca
		rts

; ----------------------------------------------

sub_0752a:	bild	#5, @byte_ffe9ca
		rts

; ----------------------------------------------

		bild	#6, @byte_ffe9ca
		rts

; ----------------------------------------------

		bild	#7, @byte_ffe9ca
		rts

; ----------------------------------------------

sub_07548:
.if type1R
		bild	#0, @byte_ffe9c9
.else
		bld	#0, @byte_ffe9c9
.endif
		rts

; ----------------------------------------------

		bild	#1, @byte_ffe9c9
		rts

; ----------------------------------------------

		bild	#2, @byte_ffe9c9
		rts

; ----------------------------------------------

		bild	#3, @byte_ffe9c9
		rts

; ----------------------------------------------

		bild	#4, @byte_ffe9c9
		rts

; ----------------------------------------------

		bild	#5, @byte_ffe9c9
		rts

; ----------------------------------------------

		bild	#6, @byte_ffe9c9
		rts

; ----------------------------------------------

		bild	#7, @byte_ffe9c9
		rts

; ----------------------------------------------

long_07598:	.long 0x00000c00 + 0x00003000 & type1R, NULL

byte_075a0:	.byte 0x38, 0xff

off_075a2:	.word 2
		.long sub_1471a, NULL

; ----------------------------------------------

sub_075ac:	mov	@byte_ffe9c8, er0
		shlr	#2, er0
		shlr	#2, er0
		shlr	#2, er0
		shlr	#2, er0
		shlr	#2, er0
		and	#0b0011 + 0b1100 & type1R, er0
		rts

; ----------------------------------------------

sub_075c6:	jsr	setupPB1DDRin

		mov	#0, r0h
		mov	r0h, @byte_ffff1c
		mov	r0h, @byte_ffff1d
		mov	r0h, @byte_ffe4c2
		rts

; ----------------------------------------------

task12:		b ild	pb6pin			; Pin PB6/-WUE6 (Port B Input Data Register)
		bcc	loc_075ea

		jsr	sub_01216

loc_075ea:	clr	c
		rts

; ----------------------------------------------

task12_2:	mov	@byte_ffe4c1, r0h
		mov	#off_075fe, er1
		jmp	switch_er1_r0h


off_075fe:	case 0	sub_0761a sub_07642 sub_0768a sub_076ca
		case 4	sub_0760e sub_07664 sub_076e0 sub_076f8

; ----------------------------------------------

sub_0760e:	mov	#40, r1
		bra	loc_0762a

		mov	#20, r1
		bra	loc_0762a

sub_0761a:	mov	#5, r1
		bra	loc_0762a

		mov	#1000, r1
		bra	loc_0762a

		mov	#200, r1

loc_0762a:	mov	#task12o, r0h
		jsr	schedBackTaskDelayed

		mov	@byte_ffe4c1, r0h
		inc	r0h
		mov	r0h, @byte_ffe4c1
		set	c
		rts

; ----------------------------------------------

sub_07642:	mov	#task12o, r0h
		jsr	checkSchedTask

		bcc	loc_0765a

		mov	@byte_ffe4c1, r0h
		inc	r0h
		mov	r0h, @byte_ffe4c1
		bra	loc_07660

loc_0765a:	mov	#task12o, r0h
		jsr	schedFrontTask

loc_07660:	set	c
		rts

; ----------------------------------------------

sub_07664:	mov	#task12o, r0h
		jsr	checkSchedTask

		bcc	loc_07680

		jsr	loc_03b58

		mov	@byte_ffe4c1, r0h
		inc	r0h
		mov	r0h, @byte_ffe4c1
		bra	loc_07686

loc_07680:	mov	#task12o, r0h
		jsr	schedFrontTask

loc_07686:	set	c
		rts

; ----------------------------------------------

sub_0768a:	btst	#6, @byte_ffff1d:8
		beq	loc_0769e

		mov	@byte_ffff1c, r0h
		beq	loc_0769e

		bclr	#2, r0h
		cmp	#0, r0h
		beq	sub_076ca

loc_0769e:	btst	#6, @byte_ffff1d:8
		beq	sub_076ca

		bclr	#6, @byte_ffff1d:8
		mov	@byte_ffff1c, r0l
		bne	sub_076ca

		mov	#0x0a, r0h
		mov	r0h, @byte_ffe4c2
		jsr	sub_017c6

		mov	@byte_ffe4c1, r0h
		inc	r0h
		mov	r0h, @byte_ffe4c1

sub_076ca:	b ild	pb6pin			; Pin PB6/-WUE6 (Port B Input Data Register)
		bcs	loc_076dc

		mov	#4, r0h
		mov	r0h, @byte_ffe4c1
		set	c
		bra	rts_076de

loc_076dc:	clr	c

rts_076de:	rts

; ----------------------------------------------

sub_076e0:	b tst	pb3pin			; Pin PB3/-WUE3/-CS4 (Port B Input Data Register)
		beq	loc_076f4

		mov	@byte_ffe4c1, r0h
		inc	r0h
		mov	r0h, @byte_ffe4c1

loc_076f4:	set	c
		rts

; ----------------------------------------------

sub_076f8:	jsr	sub_0121e

		set	c
		rts

; ----------------------------------------------

sub_07700:	bset	#7, @byte_ffff1d:8
		mov	#0, r0h
		mov	r0h, @byte_ffe4c1
		mov	r0h, @byte_ffe4c2
		btst	#7, @byte_ffff1c:8
		beq	loc_07720

		jsr	sub_078ca

		jsr	sub_065fe

loc_07720:	bclr	#6, @byte_ffff1d:8
		bra	loc_07732


sub_07726:	bclr	#7, @byte_ffff1d:8
		jsr	sub_078d6

		jsr	sub_06616

loc_07732:	jsr	setupPB1DDRin

		rts

; ----------------------------------------------

rts_07738:	rts

; ----------------------------------------------

sub_0773a:	jsr	sub_078d6

		jsr	sub_06616

		mov	#7, r0h
		bra	loc_077bc:16

		mov	#6, r0h
		bra	loc_077bc

		mov	#5, r0h
		bra	loc_077bc

		mov	#4, r0h
		bra	loc_077bc

		mov	#3, r0h
		bra	loc_077bc

loc_07758:	mov	#2, r0h
		bra	loc_077bc

loc_0775c:	mov	#0, r0h
		bra	loc_077bc

		mov	#1, r0h
		bra	loc_077bc

loc_07764:	btst	#7, @byte_ffff1d:8
		beq	loc_07772

		jsr	sub_078ca

		jsr	sub_065fe

loc_07772:	mov	#7, r0h
		bra	loc_07794

		mov	#6, r0h
		bra	loc_07794

		mov	#5, r0h
		bra	loc_07794

		mov	#4, r0h
		bra	loc_07794

		mov	#3, r0h
		bra	loc_07794

loc_07786:	bset	#2, @byte_ffff1c:8
		rts


loc_0778c:	mov	#0, r0h
		bra	loc_07794

		mov	#1, r0h
		bra	loc_07794

loc_07794:	bset	r0h, @byte_ffff1c:8
		push	er0
		stc	ccr, r0l
		set	i
		b clr	p43dr			; Pin P43/TMCI1/HIRQ11/HSYNCI (Port 4 Data Register)
		mov	@P4DDRcopy, r0h
		bset	#3, r0h
		mov	r0h, @P4DDRcopy
		mov	r0h, @p4ddr:8		; Port 4 Data Direction Register
		ldc	r0l, ccr
		pop	er0
		rts


loc_077bc:	bclr	r0h, @byte_ffff1c:8
		stc	ccr, r0h
		set	i
		mov	@byte_ffff1c, r0l
		bne	loc_077ea

		push	er0
		stc	ccr, r0l
		set	i
		mov	@P4DDRcopy, r0h
		bclr	#3, r0h
		mov	r0h, @P4DDRcopy
		mov	r0h, @p4ddr:8		; Port 4 Data Direction Register
		ldc	r0l, ccr
		pop	er0

loc_077ea:	ldc	r0h, ccr
		rts

; ----------------------------------------------

		bild	#7, @byte_ffff1c:8
		rts

; ----------------------------------------------

		mov	@byte_ffe4c2, r0h
		rts

; ----------------------------------------------

sub_077fc:	bset	#6, @byte_ffff1d:8
		rts

; ----------------------------------------------

sub_07802:	mov	#0, r0h
		mov	r0h, @byte_ffff1e
		bset	#7, @byte_ffff1e
		jsr	rts_01e8c

		rts

; ----------------------------------------------

task13:		btst	#5, @byte_ffff1e
		beq	loc_07858

		mov	#task13o, r0h
		jsr	checkSchedTask

		bcc	loc_0784e

		jsr	loc_07758

		bclr	#5, @byte_ffff1e
		btst	#4, @byte_ffff1e
		beq	loc_0784c

		bclr	#4, @byte_ffff1e
		jsr	rts_01e8c

loc_0784c:	bra	loc_07854

loc_0784e:	mov	#task13o, r0h
		jsr	schedFrontTask

loc_07854:	set	c
		bra	rts_07860

loc_07858:	mov	#task13o, r0h
		jsr	schedFrontTask

		clr	c

rts_07860:	rts

; ----------------------------------------------

sub_07862:	bclr	#6, @byte_ffff1e
		set	c
		bra	loc_07870

loc_0786e:	clr	c

loc_07870:	bst	#7, @byte_ffff1e
		bor	#3, @byte_ffff1e

loc_07880:	bcs	loc_078ac

		bclr	#4, @byte_ffff1e
		jsr	sub_01e8e

		bcs	loc_078aa

		jsr	rts_01e8c

		mov	#task13o, r0h
		mov	#1000, r1
		jsr	schedBackTaskDelayed

		bset	#5, @byte_ffff1e
		jsr	loc_07786

loc_078aa:	bra	rts_078c4

loc_078ac:	btst	#5, @byte_ffff1e
		bne	loc_078bc

		jsr	rts_01e8c

		bra	rts_078c4

loc_078bc:	bset	#4, @byte_ffff1e

rts_078c4:	rts

; ----------------------------------------------

rts_078c6:	rts

rts_078c8:	rts

; ----------------------------------------------

sub_078ca:	bset	#6, @byte_ffff1e
		clr	c
		bra	loc_07880

; ----------------------------------------------

sub_078d6:	btst	#6, @byte_ffff1e
		beq	rts_078c4

		bclr	#6, @byte_ffff1e
		bra	rts_078c8

; ----------------------------------------------

sub_078ea:	clr	c
		rts

; ----------------------------------------------

off_078ee:	.long volumeUp			; 1 Volume+
		.long volumeDown		; 2 Volume-
		.long volumeMute		; 3 Mute
		.long brighter			; 4 Brighter
		.long dimmer			; 5 Dimmer
		.long toggleLight		; 6 ThinkLight
.if level >= 0x01000062
		.long enterStandby		; 7 Standby
		.long enterHibernation		; 8 Hibernation
.endif
	num_078ee = (. - off_078ee) / 4

; ----------------------------------------------

sub_0790e:	push	er0
		jsr	sub_074a8

		pop	er0
		bist	#2, @byte_ffff1f
		bcc	loc_07942

		btst	#7, @byte_ffff20:8
		bne	loc_07942

		btst	#6, @byte_ffff20:8
		bne	loc_07942

		push	er0
		jsr	chkIfVolAccKey

		pop	er0
		bcc	loc_07942

		bra	rts_07a2e:16

loc_07942:	push	er0
		jsr	getKeyLoc

		mov	@long_ffe9e0, er1
		mov	@er1+, r3h
		shlr	r3h
		mov	#0, r2h

loc_07958:	mov	@er1+, r4h
		mov	@er1+, r4l
		cmp	r4l, r0h
		beq	loc_07968

		inc	r2h
		cmp	r3h, r2h
		blo	loc_07958

		set	c

loc_07968:	pop	er0
		bcs	loc_079b2

		btst	#0, r4h
		beq	loc_079b0

		btst	#1, r4h
		beq	loc_079a2

		btst	#7, @byte_ffff1f:8
		beq	loc_079a2

		inc	r2h
		mov	r2h, r0h
		btst	#2, r4h
		beq	loc_07988

		bsr	sub_07b56:16

loc_07988:
.if level >= 0x01000062
		jsr	sub_07fca

		bcs	loc_0799e
.endif

		push	er0
		jsr	sub_10ee0

		pop	er0
		bsr	sub_07d9a:16

loc_0799e:	mov	#-1, r0h
		bra	loc_079b0

loc_079a2:	stm	er0-er3, @-sp
		mov	#0x0c, r0h
		jsr	sub_063a0

		ldm	@sp+, er0-er3

loc_079b0:	bra	loc_079ca

loc_079b2:	btst	#7, @byte_ffff1f:8
		beq	loc_079ca

		btst	#4, @byte_ffff1f:8
		beq	loc_079ca

		jsr	getKeyLoc

		bset	#7, r0h
		jsr	sub_10cc0

		mov	#-1, r0h

loc_079ca:	push	er0
		btst	#7, @byte_ffff20:8
		beq	loc_079e2

		bclr	#7, @byte_ffff20:8
		jsr	sub_07cb6

		mov	#0x73, r0h
		jsr	sub_10cc0

loc_079e2:	jsr	sub_045ce

		pop	er0
		cmp	#-1, r0h
		beq	loc_07a08

		btst	#5, @byte_ffff20:8
		bne	loc_07a08

		push	er0
		jsr	sub_074a8

		bcs	loc_07a02

		jsr	sub_03432

loc_07a02:	pop	er0
		bra	loc_07a16

loc_07a08:	btst	#5, @byte_ffff20:8
		bne	loc_07a16

		mov	#0, r0l
		mov	r0l, @byte_ffe4c5

loc_07a16:	btst	#3, @byte_ffff1f:8
		bne	loc_07a1e

		mov	#-1, r0h

loc_07a1e:	cmp	#-1, r0h
		bne	rts_07a2e

		push	er0
		jsr	sub_02f18

		pop	er0

rts_07a2e:	rts

; ----------------------------------------------

sub_07a30:	bset	#7, @byte_ffff1f:8
		rts

; ----------------------------------------------

sub_07a36:	bclr	#7, @byte_ffff1f:8
		rts

; ----------------------------------------------

		mov	#0, r0h
		bld	#7, @byte_ffff1f:8
		bst	#0, r0h
		rts

; ----------------------------------------------

sub_07a46:	mov	@delayTabPtr, er0
		mov	@(4,er0), r0
		mov	r0, @word_ffe9e8
		jsr	sub_034d2

		bcs	loc_07a6e

		mov	@fnTabsPtr, er0
		mov	@(4,er0), er0
		bra	loc_07a7a

loc_07a6e:	mov	@fnTabsPtr, er0
		mov	@er0, er0

loc_07a7a:	mov	er0, @long_ffe9e0

; ----------------------------------------------

sub_07a82:	mov	#0, r0h
		mov	r0h, @byte_ffe4c5

sub_07a8a:	push	er0
		mov	#0, r0h
		mov	r0h, @byte_ffe4c3
		mov	r0h, @byte_ffe4c4
		pop	er0
		clr	c
		rts

; ----------------------------------------------

task14:		mov	@byte_ffe4c4, r0h
		mov	#off_07ab8, er1
		jsr	switch_er1_r0h

		clr	c
		rts


off_07ab8:	case 0	sub_07b4c sub_07ac6 sub_07b02 sub_07b24
		case 4	sub_07ade sub_07b02 sub_07b1a

; ----------------------------------------------

sub_07ac6:	mov	@delayTabPtr, er1
		mov	@(0,er1), r1
		mov	#task14o, r0h
		jsr	schedBackTaskDelayed

		bsr	sub_07af0

		set	c
		rts

; ----------------------------------------------

sub_07ade:	mov	@delayTabPtr, er1
		mov	@(2,er1), r1
		mov	#task14o, r0h
		jsr	schedBackTaskDelayed

sub_07af0:	mov	@byte_ffe4c4, r0h
		inc	r0h
		mov	r0h, @byte_ffe4c4
		set	c
		rts

; ----------------------------------------------

sub_07b02:	mov	#task14o, r0h
		jsr	checkSchedTask

		bcc	loc_07b10

		bsr	sub_07af0

		set	c
		bra	rts_07b18

loc_07b10:	mov	#task14o, r0h
		jsr	schedFrontTask

		clr	c

rts_07b18:	rts

; ----------------------------------------------

sub_07b1a:	mov	#4, r0h
		mov	r0h, @byte_ffe4c4
		bra	loc_07b26

sub_07b24:	bsr	sub_07af0

loc_07b26:	mov	@byte_ffe4c3, r0h
		beq	loc_07b40

		jsr	sub_10ee0

		mov	@byte_ffe4c3, r0h
		bsr	sub_07d9a:16

		set	c
		bra	rts_07b4a

loc_07b40:	mov	#0, r0h
		mov	r0h, @byte_ffe4c4
		clr	c

rts_07b4a:	rts

; ----------------------------------------------

sub_07b4c:	mov	#task14o, r0h
		jsr	schedFrontTask

		clr	c
		rts

; ----------------------------------------------

sub_07b56:	push	er0
		mov	r0h, @byte_ffe4c3
		mov	#1, r0l
		mov	r0l, @byte_ffe4c4
		mov	#task14o, r0h
		jsr	schedBackTask

		pop	er0
		rts

; ----------------------------------------------

task15:		mov	@byte_ffe4c5, r0h
		mov	#off_07b88, er1
		jsr	switch_er1_r0h

		clr	c
		rts


off_07b88:	case 0	sub_07bcc sub_07b98 sub_07bd6 sub_07bee
		case 4	sub_07bcc sub_07bfc sub_07bd6 sub_07c1e

; ----------------------------------------------

sub_07b98:	jsr	sub_0332e

		bcc	loc_07bba

		mov	@word_ffe9e8, r1
		bmi	loc_07bb0

		mov	#task15o, r0h
		jsr	schedBackTaskDelayed

		bsr	sub_07c0c

		bra	loc_07bb8

loc_07bb0:	mov	#4, r0h
		mov	r0h, @byte_ffe4c5

loc_07bb8:	bra	loc_07bc8

loc_07bba:	mov	@byte_ffe4c5, r0h
		add	#2, r0h
		mov	r0h, @byte_ffe4c5

loc_07bc8:	set	c
		rts

; ----------------------------------------------

sub_07bcc:	mov	#task15o, r0h
		jsr	schedFrontTask

		clr	c
		rts

; ----------------------------------------------

sub_07bd6:	mov	#task15o, r0h
		jsr	checkSchedTask

		bcc	loc_07be4

		bsr	sub_07c0c

		set	c
		bra	rts_07bec

loc_07be4:	mov	#task15o, r0h
		jsr	schedFrontTask

		clr	c

rts_07bec:	rts

; ----------------------------------------------

sub_07bee:	bsr	sub_07c2c

		mov	#0, r0h
		mov	r0h, @byte_ffe4c5
		clr	c
		rts

; ----------------------------------------------

sub_07bfc:	mov	@tick, r1		; redundant
		mov	#10, r1
		mov	#task15o, r0h
		jsr	schedBackTaskDelayed

sub_07c0c:	mov	@byte_ffe4c5, r0h
		inc	r0h
		mov	r0h, @byte_ffe4c5
		set	c
		rts

; ----------------------------------------------

sub_07c1e:	bsr	sub_07c36

		mov	#0, r0h
		mov	r0h, @byte_ffe4c5
		clr	c
		rts

; ----------------------------------------------

sub_07c2c:	jsr	sub_03406

		bset	#5, @byte_ffff20:8
		rts

; ----------------------------------------------

sub_07c36:	jsr	sub_0340a

		bclr	#5, @byte_ffff20:8
		rts

; ----------------------------------------------

sub_07c40:	btst	#6, @byte_ffff1f
		beq	rts_07cb4

		bcc	loc_07c5a

		jsr	sub_01276

		bst	#2, @byte_ffff1f
		bra	rts_07cb4

loc_07c5a:	btst	#2, @byte_ffff1f
		beq	loc_07c6e

		bclr	#2, @byte_ffff1f
		bra	rts_07cb4

loc_07c6e:	btst	#6, @byte_ffff20
		beq	loc_07c84

		bclr	#6, @byte_ffff20
		mov	#0x73, r0h
		bra	loc_07cac

loc_07c84:	btst	#7, @byte_ffff20
		beq	loc_07ca2

		bset	#6, @byte_ffff20
		bclr	#7, @byte_ffff20
		mov	#0x72, r0h
		bra	loc_07cac

loc_07ca2:	bset	#7, @byte_ffff20
		mov	#0x70, r0h

loc_07cac:	jsr	sub_07cb6

		jsr	sub_10cc0

rts_07cb4:	rts

; ----------------------------------------------

sub_07cb6:	bld	#7, @byte_ffff20
		bst	#0, @byte_ffe56d	; 0x0e
		bld	#6, @byte_ffff20
		bst	#1, @byte_ffe56d	; 0x0e
		rts

; ----------------------------------------------

sub_07cd8:	btst	#6, @byte_ffff1f:8
		bne	rts_07d04

		bset	#6, @byte_ffff1f:8
		bset	#5, @byte_ffff1f:8
		bra	loc_07cf0

sub_07ce8:	bclr	#6, @byte_ffff1f:8
		bclr	#5, @byte_ffff1f:8

loc_07cf0:	bclr	#7, @byte_ffff20
		bclr	#6, @byte_ffff20
		jsr	sub_07cb6

rts_07d04:	rts

; ----------------------------------------------

		mov	#0, r0h
		bld	#6, @byte_ffff1f:8
		bst	#0, r0h
		rts

; ----------------------------------------------

		cmp	#2, r0h
		bhi	loc_07d26

		mov	#0x34, r1h
		shll	r0h
		bsr	sub_07d46

		bst	#6, @byte_ffff1f:8
		inc	r0h
		bsr	sub_07d46

		bst	#5, @byte_ffff1f:8

loc_07d26:	mov	r0l, r0h
		cmp	#3, r0h
		bhi	rts_07d44

		cmp	#0, r0h
		beq	rts_07d44

		dec	r0h
		mov	#0x24, r1h
		shll	r0h
		bsr	sub_07d46

		bst	#7, @byte_ffff20:8
		inc	r0h
		bsr	sub_07d46

		bst	#6, @byte_ffff20:8

rts_07d44:	rts

; ----------------------------------------------

sub_07d46:	clr	c
		btst	r0h, r1h
		beq	rts_07d4e

		set	c

rts_07d4e:	rts

; ----------------------------------------------

		mov	#0, r0h
		bld	#6, @byte_ffff1f:8
		bst	#0, r0h
		btst	#5, @byte_ffff1f:8
		beq	loc_07d60

		mov	#2, r0h

loc_07d60:	mov	#0, r0l
		bld	#7, @byte_ffff20:8
		bst	#1, r0l
		btst	#6, @byte_ffff20:8
		beq	loc_07d70

		mov	#3, r0l

loc_07d70:	cmp	#0, r0l
		bne	rts_07d82

		push	er0
		jsr	sub_074a8

		pop	er0
		bist	#0, r0l

rts_07d82:	rts

; ----------------------------------------------

		bset	#4, @byte_ffff1f:8
		rts

; ----------------------------------------------

		bclr	#4, @byte_ffff1f:8
		rts

; ----------------------------------------------

		mov	#0, r0h
		bld	#4, @byte_ffff1f:8
		bst	#0, r0h
		rts

; ----------------------------------------------

sub_07d9a:	stm	er0-er3, @-sp
		mov	@long_ffe9e0, er1
		adds	#1, er1
		zero	er2
		mov	r0h, r2l
		dec	r2l
		shll	r2l
		add	er2, er1
		mov	@er1, r2l
		shlr	#2, r2l
		shlr	#2, r2l
		beq	loc_07dd0

		cmp	#num_078ee, r2l
		bhi	loc_07dd0

		dec	r2l
		shll	#2, r2
		mov	@(off_078ee,er2), er1
		jsr	@er1

loc_07dd0:	ldm	@sp+, er0-er3
		rts

; ----------------------------------------------

sub_07dd6:	bset	#3, @byte_ffff1f:8
		rts

; ----------------------------------------------

sub_07ddc:	bclr	#3, @byte_ffff1f:8
		rts

; ----------------------------------------------

sub_07de2:	stc	ccr, r0h
		push	er0
		jsr	sub_01276

		pop	er0
		bcs	rts_07e30

		ldc	r0h, ccr
		bcc	loc_07e0c

		btst	#4, @byte_ffff20:8
		bne	loc_07e0a

		mov	#1, r0h
		mov	r0h, @byte_ffe4c5
		mov	#task15o, r0h
		jsr	schedBackTask

loc_07e0a:	bra	rts_07e30

loc_07e0c:	mov	@byte_ffe4c5, r0h
		bne	loc_07e1a

		jsr	sub_07c36

		bra	rts_07e30

loc_07e1a:	cmp	#5, r0h
		bhs	rts_07e30

		jsr	sub_07c2c

		mov	#5, r0h
		mov	r0h, @byte_ffe4c5
		mov	#task15o, r0h
		jsr	schedBackTask

rts_07e30:	rts

; ----------------------------------------------

sub_07e32:	bset	#4, @byte_ffff20:8
		rts

; ----------------------------------------------

sub_07e38:	bclr	#4, @byte_ffff20:8
		rts

; ----------------------------------------------

sub_07e3e:	cmp	#-1, r0h
		bne	loc_07e48

		mov	#-1, r1
		bra	loc_07e4e

loc_07e48:	mov	#100, r1
		mulxu	r0h, r1

loc_07e4e:	mov	r1, @word_ffe9e8
		rts

; ----------------------------------------------

brighter:	mov	#1, r0h
		jmp	dacUp

; ----------------------------------------------

dimmer:		mov	#1, r0h
		jmp	dacDown

; ----------------------------------------------

volumeUp:	mov	#0, r0h
		jmp	dacUp

; ----------------------------------------------

volumeDown:	mov	#0, r0h
		jmp	dacDown

; ----------------------------------------------

.if !type1R
		rts
.endif

; ----------------------------------------------

toggleLight:	mov	#1, r0h
		jsr	getPINcopy

		bcs	loc_07e80

		jsr	lightOn

		set	c
		bra	loc_07e86

loc_07e80:	jsr	lightOff

		clr	c

loc_07e86:	mov	#1, r0h
		jsr	setPINcopy

		rts

; ----------------------------------------------

.if level >= 0x01000062
enterStandby:	jsr	enterStandby1

		rts

; ----------------------------------------------

enterHibernation:
		jsr	enterHibernation1

		rts
.endif

; ----------------------------------------------

sub_07e9a:	cmp	#0, r0l
		beq	loc_07f54:16

		cmp	#0x80, r0h
		beq	loc_07eaa

		cmp	#0x81, r0h
		bne	loc_07f54:16

loc_07eaa:	mov	@long_ffe9e0, er2
		cmp	#RAM & M24, er2
		blo	loc_07ec6

		cmp	#0x81, r0h
		beq	loc_07f20

		mov	@er2, r3h
		shlr	r3h
		cmp	r0l, r3h
		bhs	loc_07f20

loc_07ec6:	stm	er0-er1, @-sp
		shll	r0l
		mov	#0, r0h
		inc	#1, r0
		jsr	malloc

		mov	er0, er2
		ldm	@sp+, er0-er1
		bcs	loc_07f1e

		mov	@long_ffe9e0, er3
		mov	@er3+, r4h
		shlr	r4h
		cmp	r0l, r4h
		bls	loc_07eee

		mov	r0l, r4h

loc_07eee:	mov	er2, @long_ffe9e0
		mov	r0l, r4l
		shll	r4l
		mov	r4l, @er2
		adds	#1, er2
		mov	r4h, r4l
		shll	r4h

loc_07f02:	mov	@er3+, r5h
		mov	r5h, @er2
		adds	#1, er2
		dec	r4h
		bne	loc_07f02

		mov	r0l, r4h
		sub	r4l, r4h
		beq	loc_07f1c

		mov	#3, r4l

loc_07f14:	mov	r4l, @er2
		adds	#2, er2
		dec	r4h
		bne	loc_07f14

loc_07f1c:	clr	c

loc_07f1e:	bra	loc_07f22

loc_07f20:	clr	c

loc_07f22:	bcs	loc_07f52

		mov	@long_ffe9e0, er2
		mov	@er2, r3h
		shlr	r3h
		cmp	r0l, r3h
		bhs	loc_07f38

		mov	r3h, r0l
		bra	loc_07f3e

loc_07f38:	mov	r0l, r3h
		shll	r3h
		mov	r3h, @er2

loc_07f3e:	adds	#1, er2
		cmp	#0x80, r0h
		bne	loc_07f46

		adds	#1, er2

loc_07f46:	mov	@er1+, r0h
		mov	r0h, @er2
		adds	#2, er2
		dec	r0l
		bne	loc_07f46

		clr	c

loc_07f52:	bra	rts_07f56

loc_07f54:	set	c

rts_07f56:	rts

; ----------------------------------------------

.if level >= 0x01000062
sub_07f58:	mov	#0, r0
		mov	r0, @word_ffe9e4
		mov	r0, @word_ffe9e6
		mov	#task16o, r0h
		jsr	schedFrontTask

		clr	c
		rts

; ----------------------------------------------

task16:		btst	#3, @byte_ffff20:8
		beq	loc_07f86

		mov	#word_ffe9e4, er1
		bsr	sub_07fb6

		bcc	loc_07f86

		bclr	#3, @byte_ffff20:8

loc_07f86:	btst	#2, @byte_ffff20:8
		beq	loc_07f9a

		mov	#word_ffe9e6, er1
		bsr	sub_07fb6

		bcc	loc_07f9a

		bclr	#2, @byte_ffff20:8

loc_07f9a:	bld	#3, @byte_ffff20
		bor	#2, @byte_ffff20
		bcs	loc_07fb2

		mov	#task16o, r0h
		jsr	schedFrontTask

loc_07fb2:	clr	c
		rts

; ----------------------------------------------

sub_07fb6:	mov	@er1, r0
		jsr	sub_016e4

		rts

; ----------------------------------------------

sub_07fbe:	bclr	#3, @byte_ffff20:8
		rts

; ----------------------------------------------

sub_07fc4:	bclr	#2, @byte_ffff20:8
		rts

; ----------------------------------------------

sub_07fca:	push	er0
		cmp	#4, r0h
		bne	loc_07fe4

		btst	#3, @byte_ffff20:8
		bne	loc_07ffa

		bset	#3, @byte_ffff20:8
		mov	#word_ffe9e4, er1
		bra	loc_08006

loc_07fe4:	cmp	#0x0c, r0h
		bne	loc_07ffe

		btst	#2, @byte_ffff20:8
		bne	loc_07ffa

		bset	#2, @byte_ffff20:8
		mov	#word_ffe9e6, er1
		bra	loc_08006

loc_07ffa:	set	c
		bra	loc_08000

loc_07ffe:	clr	c

loc_08000:	pop	er0
		rts


loc_08006:	mov	@word_ffe9be, e0
		mov	#0x3c, r0
		add	e0, r0
		mov	r0, @er1
		mov	#task16o, r0h
		jsr	schedBackTask

		bra	loc_07ffe
.endif

; ----------------------------------------------

sub_0801c:	mov	#0, r0l
		mov	r0l, @byte_ffe4c6
		mov	r0l, @byte_ffe4c7
		mov	r0l, @byte_ffe4c8
		bset	#3, @byte_ffe4c8
		mov	r0l, @byte_ffe515
		mov	#loc_08ab0, er0
		mov	er0, @long_ffe9fa
		mov	#sub_08c48, er0
		mov	er0, @long_ffe9f2
		mov	#rts_08d26, er0
		mov	er0, @long_ffe9fe
		mov	er0, @long_ffe9f6
		mov	#0, r0l
		mov	r0l, @byte_ffe4d3
		rts

; ----------------------------------------------

task17:		mov	@byte_ffe4d3, r0h
		mov	#off_08094, er1
		jsr	switch_er1_r0h

		bcs	rts_08092

		mov	#task17o, r0h
		jsr	schedFrontTask

rts_08092:	rts


off_08094:	case 0	sub_08178 sub_0823a sub_0817c sub_08406
		case 4	sub_0809e

; ----------------------------------------------

sub_0809e:	mov	@byte_ffe4d6, r0h
		mov	#off_080b0, er1
		jsr	switch_er1_r0h

		rts


off_080b0:	case 0	sub_080b4 sub_08156

; ----------------------------------------------

sub_080b4:	mov	@byte_ffe4d4, r0l
		cmp	#0, r0l
		bne	loc_080ce

		mov	@byte_ffe4d5, r0l
		mov	r0l, @byte_ffe4d3
		bra	loc_08152:16

loc_080ce:	bclr	#5, @byte_ffe594	; 0x35
		bclr	#6, @byte_ffe594	; 0x35
		mov	#0, r0l
		mov	r0l, @byte_ffe4c6
		mov	r0l, @byte_ffe4c7
		bld	#3, @byte_ffe4c8
		mov	r0l, @byte_ffe4c8
		bst	#3, @byte_ffe4c8
		mov	r0l, @byte_ffe515
		mov	#loc_08ab0, er0
		mov	er0, @long_ffe9fa
		mov	#sub_08c48, er0
		mov	er0, @long_ffe9f2
		mov	#rts_08d26, er0
		mov	er0, @long_ffe9fe
		mov	er0, @long_ffe9f6
		jsr	sub_0a358

		jsr	sub_0a362

		jsr	sub_0a390

		jsr	sub_0a396

		mov	#1, r0l
		mov	r0l, @byte_ffe4d6

loc_08152:	set	c
		rts

; ----------------------------------------------

sub_08156:	jsr	sub_0a3ec

		bne	loc_08174

		jsr	sub_0a352

		jsr	sub_0a362

		jsr	sub_0a38a

		mov	@byte_ffe4d5, r0l
		mov	r0l, @byte_ffe4d3

loc_08174:	set	c
		rts

; ----------------------------------------------

sub_08178:	clr	c
		rts

; ----------------------------------------------

sub_0817c:	mov	@byte_ffe4d7, r0h
		mov	#off_0818e, er1
		jsr	switch_er1_r0h

		rts


off_0818e:	case 0	sub_08194 sub_08202 sub_08236

; ----------------------------------------------

sub_08194:	jsr	sub_0a3ec

		bne	loc_081fe

		jsr	sub_0a352

		jsr	sub_0a362

		jsr	sub_0a38a

		bclr	#2, @byte_ffe4c6
		bset	#3, @byte_ffe4c6
		bset	#5, @byte_ffe594	; 0x35
		bset	#6, @byte_ffe594	; 0x35
		mov	#sub_08c48, er0
		mov	er0, @long_ffe9fa
		mov	er0, @long_ffe9f2
		mov	#rts_08d26, er0
		mov	er0, @long_ffe9fe
		mov	er0, @long_ffe9f6
		jsr	sub_0a5b4

		mov	#1, r0l
		mov	r0l, @byte_ffe4d7

loc_081fe:	set	c
		rts

; ----------------------------------------------

sub_08202:	jsr	sub_0a5aa

		bne	loc_08232

		mov	#2, r0l
		mov	r0l, @byte_ffe4d7
		mov	#loc_08ab0, er0
		mov	er0, @long_ffe9f2
		jsr	sub_0a372

		bclr	#4, @byte_ffe4c7
		mov	#0, r0h
		mov	r0h, @byte_ffe56a	; 0x0b

loc_08232:	set	c
		rts

; ----------------------------------------------

sub_08236:	clr	c
		rts

; ----------------------------------------------

sub_0823a:	mov	@byte_ffe4d8, r0h
		mov	#off_0824c, er1
		jsr	switch_er1_r0h

		rts


off_0824c:	case 0	sub_08254 sub_082be sub_0834c sub_08402

; ----------------------------------------------

sub_08254:	bclr	#3, @byte_ffe4c6
		bclr	#6, @byte_ffe594	; 0x35
		bclr	#0, @byte_ffe4c8
		mov	#loc_08ab0, er0
		mov	er0, @long_ffe9fa
		mov	#sub_08c48, er0
		mov	er0, @long_ffe9f2
		mov	#rts_08d26, er0
		mov	er0, @long_ffe9fe
		mov	er0, @long_ffe9f6
		mov	#1, r0l
		mov	r0l, @byte_ffe4d8
		jsr	sub_09dea

		jsr	sub_0a358

		jsr	sub_0a368

		jsr	sub_0a390

		jsr	loc_0a39c

		clr	c
		rts

; ----------------------------------------------

sub_082be:	bld	#3, @byte_ffe4c6
		bist	#2, @byte_ffe4c6
		bst	#5, @byte_ffe594	; 0x35
		bst	#0, @byte_ffe4c8
		bcs	loc_082fe

		mov	#loc_08ab0, er0
		mov	er0, @long_ffe9fa
		mov	#sub_08c48, er0
		mov	er0, @long_ffe9f2
		bra	loc_0831a

loc_082fe:	mov	#sub_08c48, er0
		mov	er0, @long_ffe9fa
		mov	#loc_08ab0, er0
		mov	er0, @long_ffe9f2

loc_0831a:	mov	#rts_08d26, er0
		mov	er0, @long_ffe9fe
		mov	er0, @long_ffe9f6
		bclr	#4, @byte_ffe4c7
		mov	#0, r0h
		mov	r0h, @byte_ffe56a	; 0x0b
		mov	#2, r0h
		mov	r0h, @byte_ffe4d8
		clr	c
		rts

; ----------------------------------------------

sub_0834c:	mov	#sub_08c48, er0
		mov	er0, @long_ffe9f2
		mov	er0, @long_ffe9fa
		mov	#rts_08d26, er0
		mov	er0, @long_ffe9fe
		mov	er0, @long_ffe9f6
		bclr	#2, @byte_ffe4c6
		bclr	#0, @byte_ffe4c8
		bclr	#1, @byte_ffe4c8
		btst	#3, @byte_ffe4c6
		bne	loc_083be

		mov	#-1, r0h
		jsr	sub_09d28

		mov	#sub_08c8c, er0
		mov	er0, @long_ffe9fa
		mov	#sub_08d7e, er0
		mov	er0, @long_ffe9fe
		bra	loc_083f6

loc_083be:	jsr	sub_0a3ec

		beq	loc_083c8

		set	c
		bra	rts_08400

loc_083c8:	jsr	sub_0a352

		jsr	sub_0a362

		jsr	sub_0a38a

		mov	#-1, r0h
		jsr	sub_09d3e

		mov	#sub_08c8c, er0
		mov	er0, @long_ffe9f2
		mov	#sub_08d7e, er0
		mov	er0, @long_ffe9f6

loc_083f6:	mov	#3, r0h
		mov	r0h, @byte_ffe4d8
		clr	c

rts_08400:	rts

; ----------------------------------------------

sub_08402:	clr	c
		rts

; ----------------------------------------------

sub_08406:	mov	@byte_ffe4d9, r0h
		mov	#off_0841a, er1
		jsr	switch_er1_r0h

		set	c
		rts


off_0841a:	case 0	sub_08424 sub_0848a sub_08502 rts_08858
		case 4	rts_0885a

; ----------------------------------------------

sub_08424:	mov	#3, r0l
		mov	r0l, @byte_ffe4d0
		mov	#0, r0h
		mov	r0h, @byte_ffe4d1
		mov	r0h, @byte_ffe4d2
		mov	r0h, @byte_ffe4cf
		mov	r0h, @byte_ffe4cc
		mov	r0h, @byte_ffe4ce
		mov	r0h, @byte_ffe4cb
		mov	r0h, @byte_ffe4cd
		bset	#2, @byte_ffe4c6
		bclr	#0, @byte_ffe4c7
		bclr	#2, @byte_ffe4c7
		bclr	#1, @byte_ffe4c7
		bclr	#5, @byte_ffe594	; 0x35
		mov	#1, r0l
		mov	r0l, @byte_ffe4d9
		rts

; ----------------------------------------------

sub_0848a:	mov	#2, r0l
		mov	r0l, @byte_ffe4d9
		mov	#sub_08ab8, er0
		mov	er0, @long_ffe9fa
		mov	#sub_08d28, er0
		mov	er0, @long_ffe9fe
		mov	#sub_08b28, er0
		mov	er0, @long_ffe9f2
		mov	#sub_08d58, er0
		mov	er0, @long_ffe9f6
		mov	#1, r0l
		mov	r0l, @byte_ffe4e2
		mov	#task20o, r0h
		mov	#1000, r1
		jsr	schedBackTaskDelayed

		jsr	sub_09dea

		jsr	sub_0a358

		jsr	sub_0a368

		jsr	sub_0a390

		jsr	loc_0a3a0

		bclr	#4, @byte_ffe4c7
		mov	#0, r0h
		mov	r0h, @byte_ffe56a	; 0x0b
		rts

; ----------------------------------------------

sub_08502:	btst	#4, @byte_ffe4c6
		bne	loc_0883e:16

		btst	#1, @byte_ffe4c7
		bne	loc_0883e:16

		btst	#1, @byte_ffe4c6
		beq	loc_0883e:16

		btst	#0, @byte_ffe4c6
		bne	loc_087ec:16

		mov	@byte_ffe4cc, r0l
		cmp	#3, r0l
		blo	loc_085b6

		mov	#0, er1

loc_08542:	shll	r1l
		mov	@(word_ffea06,er1), r0
		mov	r0, @(word_ffea36,er1)
		shlr	r1l
		inc	#1, er1
		cmp	#3, r1l
		blo	loc_08542

		mov	@word_ffea06, r0l
		and	#7, r0l
		mov	r0l, @byte_ffe4d1
		bset	#0, @byte_ffe4c6
		mov	@byte_ffe4cc, r3l
		shll	r3l
		cmp	#6, r3l
		bne	loc_08582

		mov	#0, r2l
		bra	loc_085a8

loc_08582:	mov	#0, er2
		mov	#6, er1

loc_0858e:	mov	@(word_ffea06,er1), r0
		mov	r0, @(word_ffea06,er2)
		inc	#2, er2
		inc	#2, er1
		cmp	r1l, r3l
		bne	loc_0858e

		shlr	r2l

loc_085a8:	mov	r2l, @byte_ffe4cc
		bclr	#0, @byte_ffe4cb

loc_085b6:	btst	#6, @byte_ffe4c6
		beq	loc_085d0

		mov	@byte_ffe4ce, r0l
		mov	@byte_ffe4d0, r2l
		cmp	r2l, r0l
		bhs	loc_085f4

loc_085d0:	btst	#0, @byte_ffe4c6
		beq	loc_087ec:16

		mov	@byte_ffe4d2, r0l
		mov	@word_ffea36, r3l
		or	r0l, r3l
		mov	r3l, @word_ffea36
		bra	loc_087ec:16

loc_085f4:	btst	#0, @byte_ffe4c6
		bne	loc_086a6:16

		mov	#0, er1

loc_08606:	shll	r1l
		mov	@(word_ffea1e,er1), r0
		mov	r0, @(word_ffea36,er1)
		shlr	r1l
		inc	#1, er1
		cmp	r2l, r1l
		blo	loc_08606

		mov	@byte_ffe4d1, r0l
		mov	@word_ffea36, r3l
		or	r0l, r3l
		and	#0xf7, r3l
		bld	#3, @byte_ffe4c8
		bst	#3, r3l
		mov	r3l, @word_ffea36
		mov	@word_ffea1e, r0l
		and	#7, r0l
		mov	r0l, @byte_ffe4d2
		bset	#0, @byte_ffe4c6

loc_08656:	mov	@byte_ffe4d0, r2l
		mov	@byte_ffe4ce, r3l
		shll	r2l
		shll	r3l
		cmp	r2l, r3l
		bne	loc_0866e

		mov	#0, r4l
		bra	loc_08694

loc_0866e:	extu	r2
		extu	er2
		mov	#0, er4
		mov	er2, er1

loc_0867a:	mov	@(word_ffea1e,er1), r0
		mov	r0, @(word_ffea1e,er4)
		inc	#2, er4
		inc	#2, er1
		cmp	r1l, r3l
		bne	loc_0867a

		shlr	r4l

loc_08694:	mov	r4l, @byte_ffe4ce
		bclr	#0, @byte_ffe4cd
		bra	loc_087ec:16

loc_086a6:	mov	@word_ffea1e, r0l
		and	#7, r0l
		mov	@word_ffea36, r3l
		or	r0l, r3l
		mov	r3l, @word_ffea36
		bld	#4, @word_ffea36
		bxor	#4, @word_ffea1e
		mov	#2, er0
		mov	@(word_ffea36,er0), r1l
		mov	@(word_ffea1e,er0), r1h
		bcc	loc_086fc

		add	r1h, r1l
		bcs	loc_086f2

		bset	#4, @word_ffea36
		bra	loc_0872e

loc_086f2:	bclr	#4, @word_ffea36
		bra	loc_0872e

loc_086fc:	bld	#4, @word_ffea36
		bcc	loc_0871e

		neg	r1l
		neg	r1h
		add	r1h, r1l
		bcs	loc_08712

		neg	r1l
		bra	loc_0872e

loc_08712:	bset	#6, @word_ffea36
		mov	#1, r1l
		bra	loc_0872e

loc_0871e:	add	r1h, r1l
		bcs	loc_08724

		bra	loc_0872e

loc_08724:	bset	#6, @word_ffea36
		mov	#-1, r1l

loc_0872e:	mov	r1l, @(word_ffea36,er0)
		bld	#5, @word_ffea36
		bxor	#5, @word_ffea1e
		mov	#4, er0
		mov	@(word_ffea36,er0), r1l
		mov	@(word_ffea1e,er0), r1h
		bcc	loc_08776

		add	r1h, r1l
		bcs	loc_0876c

		bset	#5, @word_ffea36
		bra	loc_087a8

loc_0876c:	bclr	#5, @word_ffea36
		bra	loc_087a8

loc_08776:	bld	#5, @word_ffea36
		bcc	loc_08798

		neg	r1l
		neg	r1h
		add	r1h, r1l
		bcs	loc_0878c

		neg	r1l
		bra	loc_087a8

loc_0878c:	bset	#7, @word_ffea36
		mov	#1, r1l
		bra	loc_087a8

loc_08798:	add	r1h, r1l
		bcs	loc_0879e

		bra	loc_087a8

loc_0879e:	bset	#7, @word_ffea36
		mov	#-1, r1l

loc_087a8:	mov	r1l, @(word_ffea36,er0)
		mov	#1, er0
		mov	@byte_ffe4d0, r2l
		shll	r2l
		inc	r2l

loc_087c0:	mov	@(word_ffea36,er0), r1l
		mov	@(word_ffea1e,er0), r1h
		or	r1h, r1l
		mov	r1l, @(word_ffea36,er0)
		inc	#2, er0
		cmp	r2l, r0l
		blo	loc_087c0

		bset	#0, @byte_ffe4c6
		bra	loc_08656:16

loc_087ec:	btst	#0, @byte_ffe4c6
		beq	rts_08856

		mov	@byte_ffe4cf, r1l
		shll	r1l
		extu	r1
		extu	er1
		mov	@(word_ffea36,er1), r0
		push	er1
		jsr	sub_044a0

		pop	er1
		cmp	#-1, r0h
		beq	rts_08856

		shlr	r1l
		inc	r1l
		mov	@byte_ffe4d0, r2l
		cmp	r2l, r1l
		beq	loc_0883e

		cmp	#1, r0h
		bne	loc_08850

		btst	#0, @byte_ffe4c7
		bne	loc_0883e

		mov	r1l, @byte_ffe4cf
		bra	loc_087ec

loc_0883e:	bclr	#0, @byte_ffe4c7
		bclr	#0, @byte_ffe4c6
		mov	#0, r1l

loc_08850:	mov	r1l, @byte_ffe4cf

rts_08856:	rts

; ----------------------------------------------

rts_08858:	rts

rts_0885a:	rts

rts_0885c:	rts

; ----------------------------------------------

sub_0885e:	mov	@byte_ffe4d3, r0l
		cmp	#2, r0l
		bne	loc_088a4

		mov	#sub_08c48, er0
		mov	er0, @long_ffe9fa
		mov	#loc_08ab0, er0
		mov	er0, @long_ffe9f2
		mov	#rts_08d26, er0
		mov	er0, @long_ffe9fe
		mov	er0, @long_ffe9f6
		mov	#2, r0l
		mov	r0l, @byte_ffe4d7
		bra	loc_08922

loc_088a4:	cmp	#1, r0l
		bne	loc_088b2

		mov	#1, r0l
		mov	r0l, @byte_ffe4d8
		bra	loc_08922

loc_088b2:	cmp	#3, r0l
		bne	loc_08922

		mov	#0, r0l
		mov	r0l, @byte_ffe4d1
		mov	r0l, @byte_ffe4d2
		mov	r0l, @byte_ffe4cf
		mov	r0l, @byte_ffe4cc
		mov	r0l, @byte_ffe4ce
		mov	r0l, @byte_ffe4cb
		mov	r0l, @byte_ffe4cd
		mov	#2, r0l
		mov	r0l, @byte_ffe4d9
		mov	#sub_08ab8, er0
		mov	er0, @long_ffe9fa
		mov	#sub_08d28, er0
		mov	er0, @long_ffe9fe
		mov	#sub_08b28, er0
		mov	er0, @long_ffe9f2
		mov	#sub_08d58, er0
		mov	er0, @long_ffe9f6

loc_08922:	mov	#task17o, r0h
		jsr	schedBackTask

		bclr	#7, @byte_ffe4c6
		bclr	#6, @byte_ffe4c6
		bclr	#5, @byte_ffe4c6
		bclr	#4, @byte_ffe4c6
		bclr	#1, @byte_ffe4c6
		bclr	#0, @byte_ffe4c6
		bclr	#4, @byte_ffe4c7
		bclr	#3, @byte_ffe4c7
		bclr	#2, @byte_ffe4c7
		bclr	#1, @byte_ffe4c7
		bclr	#0, @byte_ffe4c7
		bclr	#6, @byte_ffe4c7
		bclr	#5, @byte_ffe4c7
		mov	#0, r0l
		mov	r0l, @byte_ffe515
		mov	r0l, @byte_ffe4c8
		bset	#3, @byte_ffe4c8
		rts

; ----------------------------------------------

sub_089a8:	mov	r0h, @byte_ffe4ca
		push	er1
		push	er2
		mov	@byte_ffe515, r1l
		extu	r1
		extu	er1
		mov	r0h, @(byte_ffe4e5,er1)
		inc	r1l
		cmp	#0x30, r1l
		bne	loc_089d0

		mov	#0, r1l

loc_089d0:	mov	r1l, @byte_ffe515
		mov	@byte_ffe4d3, r1l
		cmp	#3, r1l
		bne	loc_08a52

		btst	#2, @byte_ffe4c7
		beq	loc_089fa

		mov	#rts_08f28, er2
		bclr	#2, @byte_ffe4c7
		bra	loc_08a42

loc_089fa:	btst	#2, @byte_ffe4c8
		beq	loc_08a0c

		mov	#sub_08f2a, er2
		bra	loc_08a42

loc_08a0c:	mov	#off_08e34, er1

loc_08a12:	mov	@(0,er1), r2l
		cmp	r0h, r2l
		beq	loc_08a2a

		add	#6, er1
		cmp	#off_08e88, er1
		beq	loc_08a52

		bra	loc_08a12

loc_08a2a:	mov	@byte_ffe4d9, r2l
		cmp	#3, r2l
		bne	loc_08a3c

		mov	@(1,er1), r2l
		btst	#0, r2l
		bne	loc_08a52

loc_08a3c:	mov	@(2,er1), er2

loc_08a42:	mov	er2, @long_ffe9ea
		bset	#7, @byte_ffe4c7

loc_08a52:	btst	#2, @byte_ffe4c6
		beq	loc_08a68

		push	er0
		jsr	sub_09d28

		pop	er0

loc_08a68:	mov	@byte_ffe4d3, r1l
		cmp	#3, r1l
		beq	loc_08a92

		cmp	#2, r1l
		beq	loc_08a8e

		cmp	#1, r1l
		bne	loc_08a92

		btst	#2, @byte_ffe4c8
		bne	loc_08a92

		btst	#0, @byte_ffe4c8
		beq	loc_08a92

loc_08a8e:	jsr	sub_09d3e

loc_08a92:	pop	er2
		pop	er1
		rts

; ----------------------------------------------

sub_08a9c:	mov	@long_ffe9f2, er1
		jmp	@er1

; ----------------------------------------------

sub_08aa6:	mov	@long_ffe9fa, er1
		jmp	@er1

loc_08ab0:	jmp	sub_044a0

		clr	c
		rts

; ----------------------------------------------

sub_08ab8:	btst	#4, @byte_ffe4c6
		bne	loc_08bf0:16

		btst	#1, @byte_ffe4c7
		bne	loc_08c66:16

		mov	@byte_ffe4d9, r3l
		cmp	#2, r3l
		bne	loc_08ab0

		btst	#1, @byte_ffe4c6
		beq	loc_08ab0

		push	er1
		btst	#0, @byte_ffe4cb
		bne	loc_08b18

		mov	@byte_ffe4cc, r1l
		shll	r1l
		extu	r1
		extu	er1
		mov	r0, @(word_ffea06,er1)
		shlr	r1l
		inc	r1l
		cmp	#0x0c, r1l
		bist	#0, @byte_ffe4cb
		mov	#0, r0h
		bra	loc_08b1c

loc_08b18:	mov	#-1, r0h
		bra	loc_08b22

loc_08b1c:	mov	r1l, @byte_ffe4cc

loc_08b22:	pop	er1
		rts

; ----------------------------------------------

sub_08b28:	btst	#5, @byte_ffe4c6
		bne	loc_08c4c:16

		btst	#3, @byte_ffe4c7
		bne	loc_08c4c:16

		btst	#3, @byte_ffe4c6
		beq	loc_08c4c:16

		btst	#6, @byte_ffe4c7
		bne	loc_08c4c:16

		mov	@byte_ffe4d9, r3l
		cmp	#2, r3l
		bne	loc_08c4c:16

		push	er1
		btst	#0, @byte_ffe4cd
		beq	loc_08b84

		btst	#0, @byte_ffe4c6
		bne	loc_08baa

		mov	#0, r1l
		mov	r1l, @byte_ffe4ce

loc_08b84:	mov	@byte_ffe4ce, r1l
		shll	r1l
		extu	r1
		extu	er1
		mov	r0, @(word_ffea1e,er1)
		shlr	r1l
		inc	r1l
		cmp	#0x0c, r1l
		bist	#0, @byte_ffe4cd
		mov	#0, r0h
		bra	loc_08bae

loc_08baa:	mov	#-1, r0h
		bra	loc_08bb4

loc_08bae:	mov	r1l, @byte_ffe4ce

loc_08bb4:	pop	er1
		rts

; ----------------------------------------------

sub_08bba:	push	er0
		push	er1
		mov	@byte_ffe4ce, r1l
		mov	#0, r1h
		mov	@byte_ffe4d0, r0l
		divxu	r0l, r1
		cmp	#0, r1h
		beq	loc_08be6

		bclr	#0, @byte_ffe4cd
		mov	#0, r1h
		mov	r1h, @byte_ffe4ce

loc_08be6:	pop	er1
		pop	er0
		rts

; ----------------------------------------------

loc_08bf0:	btst	#6, r0l
		bne	loc_08c1a

		btst	#7, r0l
		bne	loc_08c1a

		cmp	#0xfa, r0h
		bne	loc_08c1a

		btst	#7, @byte_ffe4c7
		beq	loc_08c1a

		push	er0
		mov	@long_ffe9ea, er0
		jsr	@er0

		pop	er0
		bra	loc_08c2c

loc_08c1a:	btst	#2, @byte_ffe4c8
		beq	loc_08c2c

		bclr	#2, @byte_ffe4c8

loc_08c2c:	bclr	#7, @byte_ffe4c7
		jsr	sub_044a0

		cmp	#-1, r0h
		beq	rts_08c46

		bclr	#4, @byte_ffe4c6
		mov	#0, r0h

rts_08c46:	rts

; ----------------------------------------------

sub_08c48:	mov	#1, r0h
		rts

; ----------------------------------------------

loc_08c4c:	mov	#0, r0h
		rts

; ----------------------------------------------

sub_08c50:	mov	r0, r2
		mov	@byte_ffe4dc, r0h
		mov	#off_09222, er1
		jsr	switch_er1_r0h

		mov	#0, r0h
		rts

; ----------------------------------------------

loc_08c66:	jsr	sub_044a0

		cmp	#-1, r0h
		beq	rts_08c8a

		mov	@byte_ffe4e4, r0l
		inc	r0l
		mov	@byte_ffe4e3, r0h
		cmp	r0h, r0l
		blo	loc_08c88

		bclr	#1, @byte_ffe4c7

loc_08c88:	mov	#0, r0h

rts_08c8a:	rts

; ----------------------------------------------

sub_08c8c:	btst	#1, @byte_ffe4c8
		bne	loc_08c9a

		mov	#1, r0h
		bra	rts_08d10

loc_08c9a:	cmp	#0xfa, r0h
		bne	loc_08ce0

		bld	#3, @byte_ffe4c6
		bcs	loc_08cc8

		bist	#2, @byte_ffe4c6
		bst	#5, @byte_ffe594	; 0x35
		mov	#loc_08ab0, er0
		mov	er0, @long_ffe9fa
		bra	loc_08cde

loc_08cc8:	bst	#0, @byte_ffe4c8
		mov	#loc_08ab0, er0
		mov	er0, @long_ffe9f2

loc_08cde:	bra	loc_08cf6

loc_08ce0:	mov	#sub_08c48, er0
		mov	er0, @long_ffe9f2
		mov	er0, @long_ffe9fa

loc_08cf6:	mov	#2, r0h
		mov	r0h, @byte_ffe4d8
		jsr	sub_0a3da

		jsr	sub_0a358

		jsr	sub_0a368

		jsr	sub_0a390

		mov	#0, r0h

rts_08d10:	rts

; ----------------------------------------------

sub_08d12:	mov	@long_ffe9f6, er1
		jmp	@er1

; ----------------------------------------------

sub_08d1c:	mov	@long_ffe9fe, er1
		jmp	@er1

; ----------------------------------------------

rts_08d26:	rts

; ----------------------------------------------

sub_08d28:	stm	er0-er1, @-sp
		bset	#4, @byte_ffe4c6
		bclr	#1, @byte_ffe4c7
		bclr	#0, @byte_ffe4cb
		mov	#0, r1h
		mov	r1h, @byte_ffe4cc
		mov	r1h, @byte_ffe4d1
		ldm	@sp+, er0-er1
		rts

; ----------------------------------------------

sub_08d58:	mov	#sub_08c50, er1
		mov	er1, @long_ffe9f2
		bclr	#0, @byte_ffe4cd
		mov	#0, r1h
		mov	r1h, @byte_ffe4ce
		mov	r1h, @byte_ffe4d2
		rts

; ----------------------------------------------

sub_08d7e:	cmp	#-1, r0h
		bne	rts_08da0

		bset	#1, @byte_ffe4c8
		mov	#rts_08d26, er0
		mov	er0, @long_ffe9fe
		mov	er0, @long_ffe9f6

rts_08da0:	rts

; ----------------------------------------------

		jmp	sub_089a8

		rts

; ----------------------------------------------

sub_08da8:	btst	#3, @byte_ffe4c6
		bne	rts_08e18

		mov	@byte_ffe4d3, r0l
		cmp	#3, r0l
		bne	loc_08dc6

		mov	#task20o, r0h
		mov	#1000, r1
		jsr	schedBackTaskDelayed

loc_08dc6:	set	c
		bra	loc_08dd6

sub_08dca:	btst	#3, @byte_ffe4c6
		beq	rts_08e18

		clr	c

loc_08dd6:	bst	#3, @byte_ffe4c6
		bst	#6, @byte_ffe594	; 0x35
		bclr	#7, @byte_ffe4c6
		bclr	#6, @byte_ffe4c6
		bclr	#5, @byte_ffe4c6
		bclr	#3, @byte_ffe4c7
		mov	@byte_ffe4d3, r0l
		cmp	#1, r0l
		bne	rts_08e18

		mov	#task17o, r0h
		jsr	schedBackTask

		bra	rts_08e18

rts_08e18:	rts

; ----------------------------------------------

sub_08e1a:	push	er0
		mov	@byte_ffe4d3, r0l
		cmp	#1, r0l
		bne	loc_08e2e

		mov	#task17o, r0h
		jsr	schedBackTask

loc_08e2e:	pop	er0
		rts

; ----------------------------------------------

off_08e34:	.word 65280
		.long sub_08e88
		.word 62977
		.long sub_08e88
		.word 62721
		.long sub_08eba
		.word 62465
		.long sub_08ed6
		.word 62211
		.long sub_08f14
		.word 61953
		.long sub_08efa
		.word 61441
		.long sub_08e8e
		.word 60929
		.long sub_08e92
		.word 60416
		.long sub_08ea2
		.word 59905
		.long sub_08eae
		.word 59649
		.long rts_08f28
		.word 59395
		.long sub_08f1e
		.word 59137
		.long rts_08f28
		.word 58881
		.long rts_08f28
off_08e88:

; ----------------------------------------------

sub_08e88:	bsr	sub_08eba

		mov	#2, r0l
		bra	loc_08eb2


sub_08e8e:	mov	#4, r0l
		bra	loc_08eb2


sub_08e92:	mov	@byte_ffe4d9, r0l
		mov	r0l, @byte_ffe4da
		mov	#3, r0l
		bra	loc_08eb2


sub_08ea2:	mov	@byte_ffe4da, r0l
		cmp	#2, r0l
		bne	loc_08eb2

		bra	sub_08e88


sub_08eae:	mov	#2, r0l
		bra	loc_08eb2

loc_08eb2:	mov	r0l, @byte_ffe4d9
		rts

; ----------------------------------------------

sub_08eba:	bclr	#0, @byte_ffe4c6
		bclr	#1, @byte_ffe4c6
		mov	#task20o, r0h
		mov	#0, r1
		jsr	schedBackTaskDelayed

		rts

; ----------------------------------------------

sub_08ed6:	bset	#1, @byte_ffe4c6
		bclr	#5, @byte_ffe4c6
		bclr	#3, @byte_ffe4c7
		mov	#task20o, r0h
		mov	#1000, r1
		jsr	schedBackTaskDelayed

		rts

; ----------------------------------------------

sub_08efa:	bset	#1, @byte_ffe4c7
		mov	#1, r0l
		mov	r0l, @byte_ffe4e3
		mov	#0, r0l
		mov	r0l, @byte_ffe4e4
		rts

; ----------------------------------------------

sub_08f14:	bset	#2, @byte_ffe4c7
		rts

; ----------------------------------------------

sub_08f1e:	bset	#2, @byte_ffe4c7
		rts

; ----------------------------------------------

rts_08f28:	rts

; ----------------------------------------------

sub_08f2a:	btst	#2, @byte_ffe4c8
		beq	loc_08f76

		mov	@byte_ffe4ca, r0h
		mov	@byte_ffe4c9, r0l
		cmp	#1, r0l
		beq	loc_08f4e

		cmp	#2, r0l
		beq	loc_08f56

		cmp	#3, r0l
		beq	loc_08f5e

		bra	loc_08f6a

loc_08f4e:	cmp	#0x47, r0h
		bne	loc_08f6a

		mov	#2, r0l
		bra	loc_08f80

loc_08f56:	cmp	#0x20, r0h
		bne	loc_08f6a

		mov	#3, r0l
		bra	loc_08f80

loc_08f5e:	btst	#7, r0h
		beq	loc_08f6a

		bnot	#3, @byte_ffe4c8

loc_08f6a:	mov	#0, r0l
		bclr	#2, @byte_ffe4c8
		bra	loc_08f80

loc_08f76:	mov	#1, r0l
		bset	#2, @byte_ffe4c8

loc_08f80:	mov	r0l, @byte_ffe4c9
		rts

; ----------------------------------------------

task18:		mov	@byte_ffe4db, r0h
		beq	loc_09030:16

		cmp	#4, r0h
		bgt	loc_09030:16

		cmp	#1, r0h
		beq	loc_08fa8

		mov	@byte_ffe4d3, r0l
		cmp	r0l, r0h
		beq	loc_090ca:16

loc_08fa8:	jsr	sub_0a3ec

		bne	loc_09042:16

		jsr	sub_0a352

		jsr	sub_0a362

		jsr	sub_0a38a

		btst	#7, @byte_ffe4c6
		bne	loc_09042

		bset	#4, @byte_ffe4c7
		push	er0
		mov	#sub_08c48, er0
		mov	er0, @long_ffe9fa
		mov	er0, @long_ffe9f2
		mov	#rts_08d26, er0
		mov	er0, @long_ffe9fe
		mov	er0, @long_ffe9f6
		jsr	sub_09e0a

		jsr	sub_09b0e

		mov	#0, r0l
		mov	r0l, @byte_ffe4dc
		mov	#task19o, r0h
		jsr	schedFrontTask

		mov	#0, r0l
		mov	r0l, @byte_ffe4e2
		mov	#task20o, r0h
		jsr	schedFrontTask

		pop	er0
		mov	#off_09046, er1
		jsr	switch_er1_r0h

loc_09030:	mov	#0, r0h
		mov	r0h, @byte_ffe4db
		mov	#task18o, r0h
		jsr	schedFrontTask

		clr	c
		bra	rts_09044

loc_09042:	set	c

rts_09044:	rts


off_09046:	case 0	rts_09050 sub_09052 sub_0905e sub_0906a
		case 4	sub_090a0

; ----------------------------------------------

rts_09050:	rts

; ----------------------------------------------

sub_09052:	mov	#0, r0l
		mov	r0l, @byte_ffe4d8
		mov	#1, r0l
		bra	loc_09076

sub_0905e:	mov	#0, r0l
		mov	r0l, @byte_ffe4d7
		mov	#2, r0l
		bra	loc_09076

sub_0906a:	mov	#0, r0l
		mov	r0l, @byte_ffe4d9
		mov	#3, r0l
		bra	loc_09076

loc_09076:	mov	r0l, @byte_ffe4d5
		mov	@byte_ffe4d3, r0l
		mov	r0l, @byte_ffe4d4
		mov	#4, r0l
		mov	r0l, @byte_ffe4d3
		mov	#0, r0l
		mov	r0l, @byte_ffe4d6
		mov	#task17o, r0h
		jsr	schedBackTask

		rts

; ----------------------------------------------

sub_090a0:	bclr	#5, @byte_ffe594	; 0x35
		bclr	#6, @byte_ffe594	; 0x35
		bsr	sub_0801c:16

		mov	#task17o, r0h
		jsr	schedBackTask

		jsr	sub_0a358

		jsr	sub_0a368

		jsr	sub_0a390

		jsr	sub_0a396

loc_090ca:	bclr	#4, @byte_ffe4c7
		mov	#0, r0h
		mov	r0h, @byte_ffe56a	; 0x0b
		bra	loc_09030:16

; ----------------------------------------------

sub_090de:	mov	r0h, @byte_ffe4db
		beq	rts_090ec

		mov	#task18o, r0h
		jsr	schedBackTask

rts_090ec:	rts

; ----------------------------------------------

sub_090ee:	mov	#0, r0l
		mov	r0l, @byte_ffe4db
		mov	#task18o, r0h
		jsr	schedFrontTask

		rts

; ----------------------------------------------

sub_090fe:	bra	sub_090ee

; ----------------------------------------------

sub_09100:	btst	#2, @byte_ffe4c6
		beq	loc_0910e

		jsr	sub_09e7e

loc_0910e:	jsr	sub_09e86

		rts

; ----------------------------------------------

sub_09114:	btst	#2, @byte_ffe4c6
		beq	loc_09122

		jsr	sub_09e6e

loc_09122:	jsr	sub_09e72

		bset	#0, @byte_ffe4c7
		rts

; ----------------------------------------------

sub_09130:	btst	#2, @byte_ffe4c6
		beq	loc_0913e

		jsr	sub_09e12

loc_0913e:	jsr	sub_09e20

		rts

; ----------------------------------------------

		btst	#2, @byte_ffe4c6
		beq	loc_09152

		jsr	sub_09e5e

loc_09152:	jsr	sub_09e62

		rts

; ----------------------------------------------

		btst	#2, @byte_ffe4c6
		beq	loc_09166

		jsr	sub_09e56

loc_09166:	jsr	sub_09e5a

		rts

; ----------------------------------------------

sub_0916c:	btst	#2, @byte_ffe4c6
		beq	loc_0917a

		jsr	sub_09e5e

loc_0917a:	jsr	sub_09e62

		rts

; ----------------------------------------------

sub_09180:	btst	#2, @byte_ffe4c6
		beq	loc_0918e

		jsr	sub_09dea

loc_0918e:	jsr	sub_09df8

		mov	@byte_ffe4d3, r0h
		cmp	#3, r0h
		bne	rts_091be

		btst	#6, @byte_ffe4c7
		beq	rts_091be

		jsr	sub_0a368

		jsr	sub_0a358

		jsr	sub_0a390

		jsr	sub_0a3f8

		bclr	#6, @byte_ffe4c7

rts_091be:	rts

; ----------------------------------------------

sub_091c0:	jsr	sub_09e0a

		mov	@byte_ffe4d3, r0h
		cmp	#3, r0h
		bne	loc_091f8

		btst	#6, @byte_ffe4c7
		bne	rts_091fc

		bset	#6, @byte_ffe4c7
		jsr	sub_0a3ec

		beq	loc_091ec

		jsr	sub_0a3f2

		bra	rts_091fc

loc_091ec:	jsr	sub_0a362

		jsr	sub_0a352

		jsr	sub_0a38a

loc_091f8:	jsr	sub_09e0e

rts_091fc:	rts

; ----------------------------------------------

task19:		btst	#4, @byte_ffe4c7
		bne	rts_09220

		mov	@byte_ffe4dc, r0h
		mov	#off_09222, er1
		jsr	switch_er1_r0h

		mov	#task19o, r0h
		jsr	schedFrontTask

		clr	c

rts_09220:	rts


off_09222:	case 0	sub_0922c sub_09236 sub_09268 sub_09296
		case 4	sub_092c4

; ----------------------------------------------

sub_0922c:	mov	#task19o, r0h
		jsr	schedFrontTask

		clr	c
		rts

; ----------------------------------------------

sub_09236:	mov	#4, r0h
		mov	r0h, @byte_ffe4e1
		mov	#byte_ffe4dd, er1
		mov	er1, @long_ffea02
		mov	@byte_ffe4dd, r0h
		mov	#off_09260, er1
		stm	er0-er1, @-sp
		bra	loc_092f2:16

off_09260:	case 0	sub_092fe sub_0937a sub_09394 sub_093b8

; ----------------------------------------------

sub_09268:	mov	#2, r0h
		mov	r0h, @byte_ffe4e1
		mov	#byte_ffe4de, er1
		mov	er1, @long_ffea02
		mov	@byte_ffe4de, r0h
		mov	#off_09292, er1
		stm	er0-er1, @-sp
		bra	loc_092f2:16

off_09292:	case 0	sub_0931a sub_0937a

; ----------------------------------------------

sub_09296:	mov	#2, r0h
		mov	r0h, @byte_ffe4e1
		mov	#byte_ffe4df, er1
		mov	er1, @long_ffea02
		mov	@byte_ffe4df, r0h
		mov	#off_092c0, er1
		stm	er0-er1, @-sp
		bra	loc_092f2:16

off_092c0:	case 0	sub_09336 sub_0937a

; ----------------------------------------------

sub_092c4:	mov	#2, r0h
		mov	r0h, @byte_ffe4e1
		mov	#byte_ffe4e0, er1
		mov	er1, @long_ffea02
		mov	@byte_ffe4e0, r0h
		mov	#off_092ee, er1
		stm	er0-er1, @-sp
		bra	loc_092f2:16

off_092ee:	case 0	sub_09352 sub_0937a

loc_092f2:	ldm	@sp+, er0-er1
		jsr	switch_er1_r0h

		clr	c
		rts

; ----------------------------------------------

sub_092fe:	mov	#task19o, r0h
		mov	#2000, r1
		jsr	schedBackTaskDelayed

		mov	#sub_0944e, er0
		mov	er0, @long_ffe9ee
		mov	#-1, r0l
		bra	loc_0936e


sub_0931a:	mov	#task19o, r0h
		mov	#500, r1
		jsr	schedBackTaskDelayed

		mov	#0, er0
		mov	er0, @long_ffe9ee
		mov	#0xf6, r0l
		bra	loc_0936e


sub_09336:	mov	#task19o, r0h
		mov	#500, r1
		jsr	schedBackTaskDelayed

		mov	#sub_0944e, er0
		mov	er0, @long_ffe9ee
		mov	#0xf5, r0l
		bra	loc_0936e


sub_09352:	mov	#task19o, r0h
		mov	#500, r1
		jsr	schedBackTaskDelayed

		mov	#sub_0944a, er0
		mov	er0, @long_ffe9ee
		mov	#0xf4, r0l
		bra	loc_0936e


loc_0936e:	mov	r0l, r0h
		jsr	sub_09d3e

		bsr	sub_09430:16

		rts

; ----------------------------------------------

sub_0937a:	push	er2
		mov	#task19o, r0h
		jsr	checkSchedTask

		pop	er2
		bcs	loc_093d2

		cmp	#0xfa, r2h
		bne	loc_093dc

		bsr	sub_09430:16

		rts

; ----------------------------------------------

sub_09394:	push	er2
		mov	#task19o, r0h
		jsr	checkSchedTask

		pop	er2
		bcs	loc_093d2

		cmp	#0xaa, r2h
		bne	loc_093dc

		mov	#task19o, r0h
		mov	#10, r1
		jsr	schedBackTaskDelayed

		bsr	sub_09430:16

		rts

; ----------------------------------------------

sub_093b8:	push	er2
		mov	#task19o, r0h
		jsr	checkSchedTask

		pop	er2
		bcs	loc_093d2

		cmp	#0, r2h
		bne	loc_093dc

		bsr	sub_09430:16

		rts


loc_093d2:	bset	#5, @byte_ffe4c6
		bra	loc_093f2

loc_093dc:	bset	#3, @byte_ffe4c7
		bra	loc_093f2

loc_093e6:	mov	@long_ffe9ee, er1
		beq	loc_093f2

		jsr	@er1

loc_093f2:	jsr	sub_0a368

		jsr	sub_0a358

		jsr	sub_0a390

		bclr	#7, @byte_ffe4c6
		mov	#sub_08b28, er1
		mov	er1, @long_ffe9f2
		mov	#0, r0h
		mov	@long_ffea02, er1
		mov	r0h, @er1
		mov	r0h, @byte_ffe4dc
		mov	#task19o, r0h
		jsr	schedFrontTask

		clr	c
		rts

; ----------------------------------------------

sub_09430:	mov	@long_ffea02, er1
		mov	@er1, r0h
		inc	r0h
		mov	@byte_ffe4e1, r0l
		cmp	r0h, r0l
		beq	loc_093e6

		mov	r0h, @er1
		rts

; ----------------------------------------------

sub_0944a:	set	c
		bra	loc_09450

sub_0944e:	clr	c

loc_09450:	bst	#6, @byte_ffe4c6
		rts

; ----------------------------------------------

sub_0945a:	mov	#0, r0h
		mov	r0h, @byte_ffe4dd
		mov	r0h, @byte_ffe4de
		mov	r0h, @byte_ffe4df
		mov	r0h, @byte_ffe4e0
		mov	#0, r0l
		mov	r0l, @byte_ffe4dc
		mov	#task19o, r0h
		jsr	schedFrontTask

		rts

; ----------------------------------------------

sub_09484:	bra	sub_0945a

; ----------------------------------------------

task20:		btst	#4, @byte_ffe4c7
		bne	rts_094b2

		mov	#task20o, r0h
		jsr	checkSchedTask

		bcc	rts_094b2

		mov	@byte_ffe4e2, r0h
		mov	#off_094b4, er1
		jsr	switch_er1_r0h

		bcs	rts_094b2

		mov	#task20o, r0h
		jsr	schedFrontTask

		clr	c

rts_094b2:	rts


off_094b4:	case 0	sub_094b8 sub_094bc

; ----------------------------------------------

sub_094b8:	clr	c
		rts

; ----------------------------------------------

sub_094bc:	mov	@byte_ffe4d3, r0l
		cmp	#3, r0l
		bne	loc_09548:16

		btst	#3, @byte_ffe4c6
		beq	loc_09548

		mov	@byte_ffe4d9, r0l
		cmp	#2, r0l
		bne	loc_09548

		btst	#7, @byte_ffe4c6
		bne	loc_09548

		btst	#5, @byte_ffe4c7
		bne	loc_09548

		btst	#6, @byte_ffe4c7
		bne	loc_09548

		btst	#1, @byte_ffe4c6
		beq	loc_09512

		btst	#6, @byte_ffe4c6
		bne	loc_09548

		mov	#4, r0l
		bra	loc_0951e

loc_09512:	btst	#6, @byte_ffe4c6
		beq	loc_09548

		mov	#3, r0l

loc_0951e:	jsr	sub_0a3ec

		bne	loc_09548

		bset	#7, @byte_ffe4c6
		jsr	sub_0a362

		jsr	sub_0a352

		jsr	sub_0a38a

		mov	r0l, @byte_ffe4dc
		mov	#task19o, r0h
		jsr	schedBackTask

		clr	c
		bra	rts_0954a

loc_09548:	set	c

rts_0954a:	rts

; ----------------------------------------------

sub_0954c:	btst	#7, @byte_ffe4c6
		rts

; ----------------------------------------------

sub_09556:	bset	#5, @byte_ffe4c7
		rts

; ----------------------------------------------

sub_09560:	bclr	#5, @byte_ffe4c7
		rts

; ----------------------------------------------

		btst	#6, @byte_ffe4c6
		rts

; ----------------------------------------------

sub_09574:	mov	#0, r0l
		mov	r0l, @byte_ffe4e2
		rts

; ----------------------------------------------

rts_0957e:	rts

; ----------------------------------------------

sub_09580:	b clr	mstpcrl.mstp2		; XBS, KMIMR, KMIMRA, KMPCR (Module Stop Control Register L)
		mov	#off_09608, er1
		mov	#off_09614, er2
		mov	#off_09620, er3
		mov	#byte_09644, er4
		mov	#0, r0h

loc_0959e:	mov	@er1+, er6
		mov	@er2+, er5
		mov	@er4+, r0l
		mov	er5, @(0x0e,er6)
		mov	er6, @(8,er5)
		mov	r0h, @(3,er6)
		mov	r0l, @(4,er6)		; task21o/task22o/task23o
		push	er4
		stm	er0-er3, @-sp
		mov	@er3, er0
		bsr	sub_09648

		bsr	sub_0965e:16

		ldm	@sp+, er0-er3
		pop	er4
		adds	#4, er3
		inc	r0h
		cmp	#3, r0h
		bne	loc_0959e

		mov	#8, r0h
		mov	r0h, @byte_ffea50
		mov	r0h, @byte_ffea62
		mov	#3, r0h
		mov	r0h, @long_ffea8c+3
		mov	#0, r0h
		mov	r0h, @long_ffea80+3
		mov	r0h, @long_ffea74+3
		bsr	sub_09df8:16

		rts

; ----------------------------------------------

off_09608:	.long byte_ffea3e, byte_ffea50, byte_ffea62

off_09614:	.long long_ffea74, long_ffea8c, long_ffea80

off_09620:	.long kbcrh_0 & M24		; PS/2 Keyboard Control Register H Channel 0
		.long kbcrh_2 & M24		; PS/2 Keyboard Control Register H Channel 2
		.long kbcrh_1 & M24		; PS/2 Keyboard Control Register H Channel 1

off_0962c:	.long sub_0568e, sub_0a582, sub_0a2fe

off_09638:	.long sub_05696, sub_0a57e, sub_0a2fa

byte_09644:	.byte task21o
		.byte task22o
		.byte task23o

		.align 1, -1

; ----------------------------------------------

sub_09648:	mov	er0, @(4,er5)

loc_0964e:	bset	#7, @er0
		inc	#1, er0
		bclr	#6, @er0
		mov	#0, r0h
		mov	r0h, @er5
		rts

; ----------------------------------------------

sub_0965e:	bsr	sub_09a72:16

		mov	#0, r0h
		mov	r0h, @(1,er6)
		mov	r0h, @(0,er6)
		mov	#4, r0h
		mov	r0h, @(2,er6)
		jsr	sub_07862

		rts

; ----------------------------------------------

sub_09678:	b clr	kbcrh_0.kbioe		; Keyboard In/Out Enable (PS/2 Keyboard Control Register H Channel 0)
		b clr	kbcrh_1.kbioe		; Keyboard In/Out Enable (PS/2 Keyboard Control Register H Channel 1)
		b clr	kbcrh_2.kbioe		; Keyboard In/Out Enable (PS/2 Keyboard Control Register H Channel 2)
		rts

; ----------------------------------------------

sub_0968c:	mov	#off_09620, er1
		mov	#off_09614, er2
		mov	#3, r3h

loc_0969a:	mov	@er1+, er0
		mov	@er2+, er5
		stm	er0-er3, @-sp
		bsr	loc_0964e

		ldm	@sp+, er0-er3
		dec	r3h
		bne	loc_0969a

		mov	#off_09608, er1
		mov	#3, r3h

loc_096b8:	mov	@er1+, er6
		mov	@(2,er6), r0h
		mov	#4, r0l
		mov	r0l, @(2,er6)
		cmp	#0, r0h
		bne	loc_096d2

		bld	#6, @er6
		bist	#7, @er6

loc_096d2:	dec	r3h
		bne	loc_096b8

		rts

; ----------------------------------------------

sub_096d8:	bsr	sub_09678

		jsr	loc_0786e

		rts

; ----------------------------------------------

task21:		mov	#byte_ffea3e, er6
		bra	loc_096f6

task22:		mov	#byte_ffea50, er6
		bra	loc_096f6

task23:		mov	#byte_ffea62, er6

loc_096f6:	mov	@(2,er6), r0h
		mov	#off_09710, er1
		jsr	switch_er1_r0h

		bcs	loc_096f6

		mov	@(4,er6), r0h		; task21o/task22o/task23o
		jsr	schedFrontTask

		rts


off_09710:	case 0	sub_09726 sub_097e4 sub_0982a sub_09840
		case 4	sub_09858 sub_09956 sub_0998c sub_099e4
		case 8	sub_09b2c sub_09bb2 sub_09bb2

; ----------------------------------------------

sub_09726:	btst	#6, @er6
		bne	loc_09732

		bsr	sub_09a80:16

		bcs	loc_09742

loc_09732:	bclr	#6, @er6
		mov	#1, r0h
		mov	r0h, @(2,er6)
		set	c
		bra	rts_097e2:16

loc_09742:	mov	@(0x0e,er6), er5
		btst	#7, @er5
		bne	loc_0975c

		mov	@(4,er5), er0
		inc	#1, er0
		mov	@er0, r0h
		and	#0x0f, r0h
		beq	loc_09792

loc_0975c:	push	er6
		mov	@(4,er6), r0h		; task21o/task22o/task23o
		mov	#4, r1
		jsr	schedBackTaskDelayed

		pop	er6
		mov	er6, er3
		adds	#1, er3
		btst	#2, @er6
		beq	loc_09780

		bset	#2, @er3
		bra	loc_09784

loc_09780:	bclr	#2, @er3

loc_09784:	bclr	#3, @er3
		mov	#0x0a, r0h
		mov	r0h, @(2,er6)
		set	c
		bra	rts_097e2

loc_09792:	btst	#2, @er6
		bne	loc_097e0

		mov	@(4,er6), r0h		; task21o/task22o/task23o
		push	er6
		jsr	checkSchedTask

		pop	er6
		bcc	loc_097e0

		mov	er6, er1
		adds	#1, er1
		bclr	#3, @er1
		bset	#2, @er6
		bset	#1, @er6
		mov	@(4,er6), r0h		; task21o/task22o/task23o
		cmp	#task23o, r0h
		bne	loc_097d2

		bclr	#0, @byte_ffea98
		bclr	#1, @byte_ffea98

loc_097d2:	btst	#4, @er1
		beq	loc_097e0

		bclr	#4, @er1
		bclr	#6, @er1

loc_097e0:	clr	c

rts_097e2:	rts

; ----------------------------------------------

sub_097e4:	mov	@(0x0e,er6), er5
		mov	@(4,er5), er1
		bclr	#3, @er1
		inc	#1, er1
		mov	#255, r0l

loc_097f8:	set	i
		mov	@er1, r0h
		and	#0x0f, r0h
		cmp	#9, r0h
		bhs	loc_0980a

		bclr	#6, @er1
		clr	i
		bra	loc_09810

loc_0980a:	clr	i
		dec	r0l
		bne	loc_097f8

loc_09810:	bclr	#6, @er1
		bclr	#7, @er1
		bsr	sub_0981e

		set	c
		rts

; ----------------------------------------------

sub_0981e:	mov	@(2,er6), r0h
		inc	r0h
		mov	r0h, @(2,er6)
		rts

; ----------------------------------------------

sub_0982a:	mov	#4, r0
		mov	@word_ffe9bc, r1
		add	r0, r1
		mov	r1, @(8,er6)
		bsr	sub_0981e

		set	c
		rts

; ----------------------------------------------

sub_09840:	mov	@(8,er6), r0
		push	er6
		jsr	sub_016dc

		pop	er6
		bcc	loc_09854

		bsr	sub_0981e

loc_09854:	set	c
		rts

; ----------------------------------------------

sub_09858:	bsr	sub_09a80:16

		bcs	loc_09884

		bclr	#7, @er6
		bsr	sub_09ab0:16

		mov	er6, er3
		adds	#1, er3
		bclr	#2, @er3
		bclr	#3, @er3
		bclr	#1, @er6
		mov	#5, r0h
		mov	r0h, @(2,er6)
		bclr	#4, @er6
		set	c
		bra	rts_098ac

loc_09884:	btst	#7, @er6
		beq	loc_098aa

		bclr	#7, @er6
		btst	#4, @er6
		beq	loc_0989a

		bsr	sub_098d4:16

		bra	loc_098a6

loc_0989a:	bsr	sub_09914:16

		mov	#0, r0h
		mov	r0h, @(2,er6)
		bsr	sub_098ae

loc_098a6:	set	c
		bra	rts_098ac

loc_098aa:	clr	c

rts_098ac:	rts

; ----------------------------------------------

sub_098ae:	mov	er6, er1
		adds	#1, er1
		btst	#3, @er1
		beq	loc_098be

		mov	#3000, r1
		bra	loc_098c2

loc_098be:	mov	#50, r1

loc_098c2:	push	er6
		mov	@(4,er6), r0h		; task21o/task22o/task23o
		jsr	schedBackTaskDelayed

		pop	er6
		rts

; ----------------------------------------------

sub_098d4:	mov	@(6,er6), r0h
		mov	@(7,er6), r0l
		push	er6
		bld	#3, @er6
		bst	#5, r0l
		mov	#off_0962c, er1
		zero	er2
		mov	@(3,er6), r2l
		shll	#2, er2
		add	er2, er1
		mov	@er1, er1
		jsr	@er1

		pop	er6
		cmp	#-1, r0h
		beq	loc_0990a

		bclr	#4, @er6

loc_0990a:	cmp	#1, r0h
		bne	rts_09912

		bset	#7, @er6

rts_09912:	rts

; ----------------------------------------------

sub_09914:	mov	@(0x0e,er6), er5
		mov	@(4,er5), er2
		mov	er2, er3
		inc	#1, er3
		mov	#0, r0h
		mov	r0h, @er5
		bset	#7, @er3
		bclr	#2, @er2
		bset	#4, @er2
		bclr	#1, @er2
		bset	#6, @er3
		mov	#255, r1h
		set	i

loc_09940:	btst	#6, @er2
		bne	loc_0994a

		dec	r1h
		bne	loc_09940

loc_0994a:	bset	#3, @er2
		clr	i
		bset	#5, @er3
		rts

; ----------------------------------------------

sub_09956:	bclr	#2, @er6
		mov	@(0x0e,er6), er5
.if type1R && level < 0x01030071
		bsr	sub_09a80:16
.else
		bsr	sub_09a8a:16

		btst	#4, r0l
		beq	loc_09970

		bset	#2, @byte_ffea98
.endif

loc_09970:	mov	#0, r0l
		mov	r0l, @er5
		mov	r0h, @(1,er5)
		mov	r0l, @(2,er5)
		jsr	parity

		bist	#3, @er5
		bsr	sub_0981e:16

		set	c
		rts

; ----------------------------------------------

sub_0998c:	mov	@(4,er6), r0h		; task21o/task22o/task23o
		cmp	#task23o, r0h
		bne	loc_09998

		jsr	sub_0a232

loc_09998:	mov	@(0x0e,er6), er5
		mov	@(4,er5), er1
		mov	er1, er2
		inc	#1, er2
		set	i
		bclr	#5, @er2
		bset	#0, @er5
		clr	i
		bclr	#4, @er1
		set	i
		bset	#6, @er2
		bclr	#2, @er1
		bset	#3, @er1
		clr	i
		push	er6
		mov	@(4,er6), r0h		; task21o/task22o/task23o
		mov	#17, r1
		jsr	schedBackTaskDelayed

		pop	er6
		bsr	sub_0981e:16

		set	c
		rts

; ----------------------------------------------

sub_099e4:	mov	@(0x0e,er6), er5
		btst	#5, @er5
		beq	loc_09a18

		mov	@(4,er6), r0h		; task21o/task22o/task23o
		cmp	#task23o, r0h
		bne	loc_099fc

		jsr	sub_0a23c

loc_099fc:	push	er6
		mov	@(4,er6), r0h		; task21o/task22o/task23o
		mov	#4, r1
		jsr	schedBackTaskDelayed

		pop	er6
		bsr	sub_0981e:16

		set	c
		bra	rts_09a34

loc_09a18:	push	er6
		mov	@(4,er6), r0h		; task21o/task22o/task23o
		jsr	checkSchedTask

		pop	er6
		bcc	loc_09a32

		bsr	sub_09a96

		bsr	sub_09a3c

		set	c
		bra	rts_09a34

loc_09a32:	clr	c

rts_09a34:	rts

; ----------------------------------------------

.ifeq type1R && level < 0x01030071
sub_09a36:	mov	#0xfe00, r0
		bra	loc_09a46
.endif

sub_09a3c:	mov	#0xfe40, r0
		bra	loc_09a46

sub_09a42:	mov	#0xff40, r0

loc_09a46:	bclr	#7, @er6
		bsr	sub_09ac0

		btst	#4, @er6
		beq	loc_09a62

		mov	@(4,er6), r0h		; task21o/task22o/task23o
		cmp	#task22o, r0h
		bne	loc_09a5e

		jsr	sub_08d28

loc_09a5e:	bsr	sub_098d4:16

loc_09a62:	mov	#1, r0h
		mov	r0h, @(2,er6)
		mov	er6, er0
		adds	#1, er0
		bclr	#3, @er0
		rts

; ----------------------------------------------

sub_09a72:	mov	#0, r0
		mov	r0, @(0x0a,er6)
		mov	r0, @(0x0c,er6)
		rts

; ----------------------------------------------

sub_09a80:	mov	@(0x0a,er6), r0
		bild	#7, r0h
		mov	r0l, r0h
		rts

; ----------------------------------------------

.ifeq type1R && level < 0x01030071
sub_09a8a:	mov	@(0x0a,er6), r0
		mov	r0, r1
		mov	r1h, r0l
		mov	r1l, r0h
		rts
.endif

; ----------------------------------------------

sub_09a96:	mov	@(0x0a,er6), r0
		bld	#5, r0h
		mov	@(0x0c,er6), r1
		mov	r1, @(0x0a,er6)
		mov	#0, r1
		mov	r1, @(0x0c,er6)
		mov	r0l, r0h
		rts

; ----------------------------------------------

sub_09ab0:	mov	@(0x0a,er6), r0
		bset	#6, r0h
		mov	r0h, @(0x0a,er6)
		bild	#7, r0h
		mov	r0l, r0h
		rts

; ----------------------------------------------

sub_09ac0:	mov	er6, er3
		adds	#1, er3
		bset	#1, r0l
		btst	#1, @er6
		beq	loc_09ae6

		btst	#6, @er3
		beq	loc_09ae6

		btst	#5, @er3
		beq	loc_09ae4

		push	er6
		jsr	sub_04be0

		pop	er6

loc_09ae4:	bra	rts_09b0c

loc_09ae6:	btst	#7, r0l
		beq	loc_09af4

		mov	@(2,er6), r1h
		cmp	#9, r1h
		bne	loc_09af4

		bset	#6, r0l

loc_09af4:	mov	r0h, @(6,er6)
		bld	#1, @er6
		bst	#0, r0l
		bld	#2, @er3
		bst	#2, r0l
		mov	r0l, @(7,er6)
		bset	#4, @er6

rts_09b0c:	rts

; ----------------------------------------------

sub_09b0e:	stm	er0-er1, @-sp
		mov	#byte_ffea50, er1
		mov	#0, r0l
		mov	r0l, @(6,er1)
		mov	r0l, @(7,er1)
		bclr	#4, @er1
		ldm	@sp+, er0-er1
		rts

; ----------------------------------------------

sub_09b2c:	mov	@(0x0e,er6), er5
		btst	#7, @er5
		beq	loc_09b90

		bsr	sub_09a96:16

		mov	er6, er1
		adds	#1, er1
		cmp	#-1, r0h
		bne	loc_09b4a

		bset	#3, @er1
		bra	loc_09b4e

loc_09b4a:	bclr	#3, @er1

loc_09b4e:	mov	#off_09638, er1
		zero	er2
		mov	@(3,er6), r2l
		shll	#2, er2
		add	er2, er1
		mov	@er1, er1
		push	er6
		jsr	@er1

		pop	er6
		mov	#9, r0h
		mov	r0h, @(2,er6)
		push	er6
		mov	@(4,er6), r0h		; task21o/task22o/task23o
		mov	#26, r1
		jsr	schedBackTaskDelayed

		pop	er6
		bsr	sub_09914:16

		set	c
		bra	rts_09bb0

loc_09b90:	push	er6
		mov	@(4,er6), r0h		; task21o/task22o/task23o
		jsr	checkSchedTask

		pop	er6
		bcc	loc_09bae

		bsr	sub_09a96:16

		bsr	sub_09a3c:16

		set	c
		bra	rts_09bb0

loc_09bae:	clr	c

rts_09bb0:	rts

; ----------------------------------------------

sub_09bb2:	bclr	#2, @er6
		mov	@(0x0e,er6), er5
		btst	#7, @er5
		beq	loc_09be0

		bclr	#7, @er6
		bsr	sub_09c24

		bsr	sub_09ac0:16

		btst	#4, @er6
		beq	loc_09bd6

		bsr	sub_098d4:16

loc_09bd6:	mov	#4, r0h
		mov	r0h, @(2,er6)
		set	c
		bra	rts_09c22

loc_09be0:	push	er6
		mov	@(4,er6), r0h		; task21o/task22o/task23o
		jsr	checkSchedTask

		pop	er6
		bcc	loc_09c20

		mov	@(2,er6), r0h
		cmp	#9, r0h
		bne	loc_09c18

.ifeq type1R && level < 0x01030071
		btst	#2, @byte_ffea98
		beq	loc_09c12

		bclr	#2, @byte_ffea98
		bsr	sub_09a36:16

		bra	loc_09c1c
.endif 

loc_09c12:	bsr	sub_09a3c:16

		bra	loc_09c1c

loc_09c18:	bsr	sub_09a42:16

loc_09c1c:	set	c
		bra	rts_09c22

loc_09c20:	clr	c

rts_09c22:	rts

; ----------------------------------------------

sub_09c24:	mov	@(0x0e,er6), er5
		btst	#2, @er5
		beq	loc_09c36

		mov	#0x80, r0l
		mov	#0xff, r0h
		bra	rts_09c3c

loc_09c36:	mov	@(1,er5), r0h
		mov	#0, r0l

rts_09c3c:	rts

; ----------------------------------------------

; PS/2 Keyboard Reception Completion A

kbia:		stm	er0-er3, @-sp
		mov	#long_ffea74, er3
		bra	loc_09c60

; PS/2 Keyboard Reception Completion B

kbib:		stm	er0-er3, @-sp
		mov	#long_ffea80, er3
		bra	loc_09c60

; PS/2 Keyboard Reception Completion C

kbic:		stm	er0-er3, @-sp
		mov	#long_ffea8c, er3

loc_09c60:	mov	@(4,er3), er1
		mov	er1, er2
		inc	#1, er2
		btst	#4, @er1
		beq	loc_09cb8

		cmp	#long_ffea80, er3
		bne	loc_09c80

		bset	#1, @byte_ffea98

loc_09c80:	bclr	#3, @er1
		bld	#1, @er1
		bst	#2, @er3
		mov	@(2,er1), r0h
		mov	r0h, @(1,er3)
		bclr	#7, @er2
		bclr	#6, @er2
		bclr	#4, @er1
		bclr	#2, @er1
		bset	#7, @er3
		mov	@(8,er3), er0
		mov	@(4,er0), r0h
		jsr	schedBackTask

		bra	loc_09d22

loc_09cb8:	btst	#6, @er1
		bne	loc_09d1e

		mov	@(2,er3), r0l
		cmp	#8, r0l
		bhs	loc_09cde

		bset	#5, @er3
		bclr	#0, @er3
		mov	@(1,er3), r0h
		shlr	r0h
		bst	#5, @er2
		mov	r0h, @(1,er3)
		bra	loc_09d18

loc_09cde:	cmp	#8, r0l
		bne	loc_09cec

		bld	#3, @er3
		bst	#5, @er2
		bra	loc_09d18

loc_09cec:	cmp	#9, r0l
		bne	loc_09cf6

		bset	#5, @er2
		bra	loc_09d18

loc_09cf6:	bclr	#3, @er1
		bclr	#6, @er2
		bset	#7, @er3
		stm	er0-er1, @-sp
		mov	@(8,er3), er0
		mov	@(4,er0), r0h
		jsr	schedBackTask

		ldm	@sp+, er0-er1

loc_09d18:	inc	r0l
		mov	r0l, @(2,er3)

loc_09d1e:	bclr	#2, @er1

loc_09d22:	ldm	@sp+, er0-er3
		rte

; ----------------------------------------------

sub_09d28:
.ifeq type1R && level < 0x01030071
		mov	#0x80, r1l
.endif
		push	er6
		mov	#byte_ffea50, er6
		bra	loc_09d60


sub_09d36:
.ifeq type1R && level < 0x01030071
		cmp	#0xef, r0h
		bne	sub_09d3e

		mov	#0x90, r1l
		bra	loc_09d40
.endif

sub_09d3e:
.ifeq type1R && level < 0x01030071
		mov	#0x80, r1l
.endif

loc_09d40:	push	er6
		mov	#byte_ffea62, er6
		bset	#0, @byte_ffea98
		bra	loc_09d60


sub_09d54:
.ifeq type1R && level < 0x01030071
		mov	#0x80, r1l
.endif
		push	er6
		mov	#byte_ffea3e, er6

loc_09d60:	mov	r0h, r0l
.if type1R && level < 0x01030071
		mov	#0x80, r0h
.else
		mov	r1l, r0h
.endif
		mov	@(0x0a,er6), r1
		btst	#7, r1h
		beq	loc_09d76

		btst	#6, r1h
		beq	loc_09d76

		mov	r0, @(0x0c,er6)
		bra	loc_09d82

loc_09d76:	mov	r0, @(0x0a,er6)
		mov	#0, r1
		mov	r1, @(0x0c,er6)

loc_09d82:	mov	@(4,er6), r0h		; task21o/task22o/task23o
		jsr	schedBackTask

		pop	er6
		rts

; ----------------------------------------------

sub_09d90:	mov	#byte_ffea3e, er6
		bra	loc_09da6

		mov	#byte_ffea50, er6
		bra	loc_09da6

		mov	#byte_ffea50, er6

loc_09da6:	mov	@(2,er6), r0h
		cmp	#0, r0h
		bne	loc_09db8

		btst	#2, @er6
		beq	loc_09db8

		clr	c
		bra	rts_09dba

loc_09db8:	set	c

rts_09dba:	rts

; ----------------------------------------------

sub_09dbc:	mov	#0x80, r0h

loc_09dbe:	push	er6
		mov	#byte_ffea3e, er6

loc_09dc8:	mov	@er6, r0l
		and	#0xc0, r0l
		xor	r0h, r0l
		beq	loc_09de4

		bld	#7, r0h
		bst	#7, @er6
		bld	#6, r0h
		bst	#6, @er6
		mov	@(4,er6), r0h		; task21o/task22o/task23o
		jsr	schedBackTask

loc_09de4:	pop	er6
		rts


sub_09dea:	mov	#0x80, r0h

loc_09dec:	push	er6
		mov	#byte_ffea50, er6
		bra	loc_09dc8


sub_09df8:	mov	#0x80, r0h

loc_09dfa:	push	er6
		mov	#byte_ffea62, er6
		bra	loc_09dc8


sub_09e06:	mov	#0x40, r0h
		bra	loc_09dbe


sub_09e0a:	mov	#0x40, r0h
		bra	loc_09dec


sub_09e0e:	mov	#0x40, r0h
		bra	loc_09dfa

; ----------------------------------------------

sub_09e12:	mov	#0x40, r0h

loc_09e14:	push	er1
		mov	#long_ffea51, er1
		bra	loc_09e2c


sub_09e20:	mov	#0x40, r0h

loc_09e22:	push	er1
		mov	#long_ffea63, er1

loc_09e2c:	bld	#6, r0h
		bst	#6, @er1
		bld	#5, r0h
		bst	#5, @er1
		bld	#4, r0h
		bst	#4, @er1
		pop	er1
		rts


sub_09e44:	mov	#0x40, r0h

loc_09e46:	push	er1
		mov	#long_ffea3f, er1
		bra	loc_09e2c


sub_09e52:	mov	#0x60, r0h
		bra	loc_09e46

; ----------------------------------------------

sub_09e56:	mov	#0x60, r0h
		bra	loc_09e14

; ----------------------------------------------

sub_09e5a:	mov	#0x60, r0h
		bra	loc_09e22

; ----------------------------------------------

sub_09e5e:	mov	#0, r0h
		bra	loc_09e14

; ----------------------------------------------

sub_09e62:	mov	#0, r0h
		bra	loc_09e22

; ----------------------------------------------

sub_09e66:	mov	#0, r0h
		bra	loc_09e46

		mov	#0x50, r0h
		bra	loc_09e46

; ----------------------------------------------

sub_09e6e:	mov	#0x50, r0h
		bra	loc_09e14

; ----------------------------------------------

sub_09e72:	mov	#0x50, r0h
		bra	loc_09e22

; ----------------------------------------------

sub_09e76:	mov	#byte_ffea3e, er6
		bra	loc_09e8c

sub_09e7e:	mov	#byte_ffea50, er6
		bra	loc_09e8c

sub_09e86:	mov	#byte_ffea62, er6

loc_09e8c:	mov	@(0x0e,er6), er3
		mov	@(4,er3), er3
		mov	er3, er4
		inc	#1, er4
		bclr	#3, @er3
		bset	#6, @er4
		bset	#5, @er4
		push	er6
		mov	#0, r0
		mov	#sub_09f06, er1

loc_09eb6:	mov	er1, er2
		add	#4, er2
		inc	r0h
		jsr	@er1

		stm	er0-er3, @-sp
		jsr	delay100

		ldm	@sp+, er0-er3
		mov	#0, r0l

loc_09ed0:	jsr	@er2

		bcc	loc_09eda

		dec	r0l
		bne	loc_09ed0

		bra	loc_09ee6

loc_09eda:	add	#0x10, er1
		cmp	#4, r0h
		blo	loc_09eb6

		mov	#0, r0h

loc_09ee6:	bset	#5, @er4
		pop	er6
		push	er0
		mov	#1, r3h
		mov	r3h, @(2,er6)
		mov	@(4,er6), r0h		; task21o/task22o/task23o
		jsr	schedBackTask

		pop	er0
		rts

; ----------------------------------------------

sub_09f06:	bset	#6, @er4
		clr	c
		btst	#6, @er3
		bne	rts_09f14

		set	c

rts_09f14:	rts

; ----------------------------------------------

		bclr	#6, @er4
		clr	c
		btst	#6, @er3
		beq	rts_09f24

		set	c

rts_09f24:	rts

; ----------------------------------------------

		bset	#5, @er4
		clr	c
		btst	#5, @er3
		bne	rts_09f34

		set	c

rts_09f34:	rts

; ----------------------------------------------

		bclr	#5, @er4
		clr	c
		btst	#5, @er3
		beq	rts_09f44

		set	c

rts_09f44:	rts

; ----------------------------------------------

		mov	#byte_ffea3e, er1
		bra	loc_09f5c

		mov	#byte_ffea50, er1
		bra	loc_09f5c

sub_09f56:	mov	#byte_ffea62, er1

loc_09f5c:	mov	@(0x0e,er1), er1
		mov	r0h, @(3,er1)
		rts

; ----------------------------------------------

		mov	#byte_ffea3e, er1
		bra	loc_09f7e

		mov	#byte_ffea50, er1
		bra	loc_09f7e

		mov	#byte_ffea62, er1

loc_09f7e:	mov	@(0x0e,er1), er1
		mov	@(3,er1), r0h
		rts

; ----------------------------------------------

		mov	#byte_ffea3e, er1
		mov	#byte_ffea62, er2
		bra	loc_09fa4

		mov	#byte_ffea50, er1
		mov	#byte_ffea62, er2

loc_09fa4:	mov	@(0x0e,er1), er3
		mov	@(0x0e,er2), er4
		set	i
		mov	er4, @(0x0e,er1)
		mov	er1, @(8,er4)
		mov	er3, @(0x0e,er2)
		mov	er2, @(8,er3)
		clr	i
		mov	#1, r0h
		mov	r0h, @(2,er1)
		mov	r0h, @(2,er2)
		rts

; ----------------------------------------------

sub_09fd8:	push	er0
		mov	#byte_ffea62, er0
		btst	#2, @er0
		beq	loc_0a000

		btst	#0, @byte_ffea98
		bne	loc_0a000

		btst	#1, @byte_ffea98
		bne	loc_0a000

		clr	c
		bra	loc_0a002

loc_0a000:	set	c

loc_0a002:	pop	er0
		rts

; ----------------------------------------------

sub_0a008:	mov	#500, r1
		mov	#task24o, r0h
		jsr	schedBackTaskDelayed

		zero	er0
		mov	r0h, @byte_ffff21:8
		mov	r0h, @byte_ffff22:8
		mov	#1, r0h
		mov	r0h, @byte_ffe517
		mov	#off_0a342, er0
		mov	er0, @long_ffea9a
		rts

; ----------------------------------------------

sub_0a032:	bclr	#0, @byte_ffff21:8
		bclr	#7, @byte_ffff22:8
		bclr	#6, @byte_ffff22:8
		bclr	#5, @byte_ffff22:8
		bclr	#4, @byte_ffff22:8
		bclr	#2, @byte_ffff22:8
		bclr	#1, @byte_ffff22:8
		bclr	#0, @byte_ffff22:8
		mov	#500, r1
		mov	#task24o, r0h
		jsr	schedBackTaskDelayed

		rts

; ----------------------------------------------

rts_0a05e:	rts

; ----------------------------------------------

task24:		btst	#2, @byte_ffff22:8
		bne	loc_0a0dc

		btst	#1, @byte_ffff22:8
		bne	loc_0a0a6

		mov	#task24o, r0h
		jsr	checkSchedTask

		bcc	loc_0a0e6

		btst	#7, @byte_ffff21:8
		bne	loc_0a09c

		btst	#1, @byte_ffff21:8
		bne	loc_0a09c

		bset	#0, @byte_ffff21:8
		mov	#0xff, r0h
		btst	#4, @byte_ffff22:8
		bne	loc_0a08e

		mov	#0xf2, r0h

loc_0a08e:	jsr	sub_09d36

		mov	#0, r0h
		mov	r0h, @byte_ffe517
		bra	loc_0a0dc

loc_0a09c:	btst	#3, @byte_ffff22:8
		bne	loc_0a0dc

		bset	#1, @byte_ffff22:8

loc_0a0a6:	jsr	sub_0954c

		bne	loc_0a0f0

		jsr	sub_09fd8

		bcs	loc_0a0f0

		bclr	#1, @byte_ffff22:8
		jsr	sub_09556

		bset	#0, @byte_ffff21:8
		mov	#0xef, r0h
		jsr	sub_09d36

		mov	#4, r0h
		mov	r0h, @byte_ffe517
		mov	#off_0a342, er0
		mov	er0, @long_ffea9a
		bra	loc_0a0e6

loc_0a0dc:	mov	#task24o, r0h
		mov	#1000, r1
		jsr	schedBackTaskDelayed

loc_0a0e6:	mov	#task24o, r0h
		jsr	schedFrontTask

		clr	c
		bra	rts_0a0f2

loc_0a0f0:	set	c

rts_0a0f2:	rts


off_0a0f4:	case 0	sub_0a0fe sub_0a17c sub_0a1c8 sub_0a228
		case 4	sub_0a13c

; ----------------------------------------------

sub_0a0fe:	cmp	#0xfa, r2h
		bne	loc_0a116

		jsr	sub_09df8

		btst	#4, @byte_ffff22:8
		beq	loc_0a112

		bsr	sub_0a1b8:16

		bra	loc_0a138

loc_0a112:	mov	#2, r0h
		bra	loc_0a132

loc_0a116:	bclr	#0, @byte_ffff21:8
		bclr	#5, @byte_ffff22:8
		btst	#6, @byte_ffff22:8
		beq	loc_0a128

		bsr	sub_0a410:16

loc_0a128:	jsr	sub_09560

		bclr	#4, @byte_ffff22:8
		mov	#3, r0h

loc_0a132:	mov	r0h, @byte_ffe517

loc_0a138:	clr	c
		rts

; ----------------------------------------------

sub_0a13c:	cmp	#0xfe, r2h
		beq	loc_0a148

		cmp	#0xfc, r2h
		beq	loc_0a148

		bra	loc_0a26c:16

loc_0a148:	mov	#3, r0h
		mov	r0h, @byte_ffe517
		jsr	sub_08bba

		mov	#off_0a34a, er0
		mov	er0, @long_ffea9a
		bclr	#0, @byte_ffff21:8
		bclr	#5, @byte_ffff22:8
		btst	#6, @byte_ffff22:8
		beq	loc_0a174

		bsr	sub_0a410:16

loc_0a174:	jsr	sub_09560

		clr	c
		rts

; ----------------------------------------------

sub_0a17c:	cmp	#0xaa, r2h
		bne	loc_0a192

		mov	#task24o, r0h
		mov	#10, r1
		jsr	schedBackTaskDelayed

		jsr	sub_09df8

		bsr	sub_0a1b8

		bra	loc_0a1b4

loc_0a192:	bclr	#0, @byte_ffff21:8
		bclr	#5, @byte_ffff22:8
		btst	#6, @byte_ffff22:8
		beq	loc_0a1a4

		bsr	sub_0a410:16

loc_0a1a4:	jsr	sub_09560

		bclr	#4, @byte_ffff22:8
		mov	#3, r0h
		mov	r0h, @byte_ffe517

loc_0a1b4:	clr	c
		rts

; ----------------------------------------------

sub_0a1b8:	mov	@byte_ffe517, r0h
		inc	r0h
		mov	r0h, @byte_ffe517
		rts

; ----------------------------------------------

sub_0a1c8:	cmp	#0, r2h
		bne	loc_0a1ce

		bsr	sub_0a1f4

loc_0a1ce:	mov	#3, r0h
		mov	r0h, @byte_ffe517
		bclr	#0, @byte_ffff21:8
		bclr	#5, @byte_ffff22:8
		btst	#6, @byte_ffff22:8
		beq	loc_0a1e8

		bsr	sub_0a410:16

loc_0a1e8:	jsr	sub_09560

		bclr	#4, @byte_ffff22:8
		clr	c
		rts

; ----------------------------------------------

sub_0a1f4:	bset	#7, @byte_ffff21:8
		bset	#6, @byte_ffff21:8
		bset	#5, @byte_ffff21:8
		bclr	#4, @byte_ffff21:8
		mov	#2, r0h
		jsr	sub_09f56

		mov	#off_0a34a, er1
		mov	er1, @long_ffea9a
		jsr	sub_08da8

		jsr	sub_04576

		bcs	rts_0a226

		jsr	sub_09df8

rts_0a226:	rts

; ----------------------------------------------

sub_0a228:	clr	c
		rts

; ----------------------------------------------

sub_0a22c:	bset	#5, @byte_ffff22:8
		rts

; ----------------------------------------------

sub_0a232:	bld	#0, @byte_ffff21:8
		bst	#7, @byte_ffff22:8
		rts

; ----------------------------------------------

sub_0a23c:	bld	#0, @byte_ffff21:8
		bist	#7, @byte_ffff22:8
		rts

; ----------------------------------------------

sub_0a246:	btst	#6, r0l
		bne	loc_0a24e

		btst	#7, r0l
		beq	loc_0a250

loc_0a24e:	bra	loc_0a26c

loc_0a250:	btst	#5, @byte_ffff22:8
		beq	loc_0a268

		mov	r0, r2
		mov	@byte_ffe517, r0h
		mov	#off_0a0f4, er1
		jsr	switch_er1_r0h

loc_0a268:	mov	#1, r0h
		rts


loc_0a26c:	btst	#0, @byte_ffff21:8
		beq	loc_0a282

		btst	#7, @byte_ffff22:8
		bne	loc_0a282

		btst	#5, @byte_ffff22:8
		beq	loc_0a2f6

		bclr	#5, @byte_ffff22:8

loc_0a282:	btst	#7, @byte_ffff21:8
		beq	loc_0a2ac

		mov	#0, r0h
		jsr	sub_09f56

		btst	#6, @byte_ffff21:8
		beq	loc_0a2ac

		btst	#5, @byte_ffff21:8
		beq	loc_0a2ac

		mov	#off_0a342, er0
		mov	er0, @long_ffea9a
		jsr	sub_08dca

loc_0a2ac:	btst	#0, @byte_ffff22:8
		beq	loc_0a2ba

		jsr	sub_08e1a

		bclr	#0, @byte_ffff22:8

loc_0a2ba:	bclr	#1, @byte_ffff22:8
		bclr	#7, @byte_ffff21:8
		bclr	#6, @byte_ffff21:8
		bclr	#5, @byte_ffff21:8
		bclr	#0, @byte_ffff21:8
		bclr	#5, @byte_ffff22:8
		btst	#6, @byte_ffff22:8
		beq	loc_0a2dc

		bsr	sub_0a410:16

loc_0a2dc:	jsr	sub_09560

		bclr	#4, @byte_ffff22:8
		mov	#task24o, r0h
		mov	#1000, r1
		jsr	schedBackTaskDelayed

		mov	#3, r0h
		mov	r0h, @byte_ffe517

loc_0a2f6:	mov	#1, r0h
		rts

; ----------------------------------------------

sub_0a2fa:	mov	#4, r2l
		bra	loc_0a32e

; ----------------------------------------------

sub_0a2fe:	btst	#1, @byte_ffff21:8
		bne	loc_0a32a

		btst	#6, r0l
		beq	loc_0a30c

		bra	loc_0a26c:16

loc_0a30c:	btst	#7, @byte_ffff21:8
		beq	loc_0a32a

		btst	#3, @byte_ffff22:8
		bne	loc_0a32a

		push	er0
		mov	#task24o, r0h
		mov	#1000, r1
		jsr	schedBackTaskDelayed

		pop	er0

loc_0a32a:	mov	#0, r2l
		bra	loc_0a32e

loc_0a32e:	mov	@long_ffea9a, er1
		zero	e2
		mov	#0, r2h
		add	er2, er1
		mov	@er1, er1
		jmp	@er1

off_0a342:	.long sub_0a246, sub_0a22c

off_0a34a:	.long sub_08a9c, sub_08d12

; ----------------------------------------------

sub_0a352:	bset	#1, @byte_ffff21:8
		rts

; ----------------------------------------------

sub_0a358:	bclr	#1, @byte_ffff21:8
		bclr	#1, @byte_ffff22:8
		rts

; ----------------------------------------------

sub_0a362:	bset	#3, @byte_ffff22:8
		rts

; ----------------------------------------------

sub_0a368:	bclr	#3, @byte_ffff22:8
		bclr	#1, @byte_ffff22:8
		rts

; ----------------------------------------------

sub_0a372:	push	er1
		mov	#off_0a34a, er1
		mov	er1, @long_ffea9a
		pop	er1
		rts

; ----------------------------------------------

sub_0a38a:	bset	#2, @byte_ffff22:8
		rts

; ----------------------------------------------

sub_0a390:	bclr	#2, @byte_ffff22:8
		rts

; ----------------------------------------------

sub_0a396:	bset	#4, @byte_ffff22:8
		bra	loc_0a3a0

loc_0a39c:	bset	#0, @byte_ffff22:8

loc_0a3a0:	jsr	sub_09556

		bset	#0, @byte_ffff21:8
		mov	#0, r0h
		mov	r0h, @byte_ffe517
		mov	#off_0a342, er0
		mov	er0, @long_ffea9a
		bclr	#7, @byte_ffff21:8
		bclr	#6, @byte_ffff21:8
		bclr	#5, @byte_ffff21:8
		bclr	#4, @byte_ffff21:8
		mov	#0, r1
		mov	#task24o, r0h
		jsr	schedBackTaskDelayed

		rts

; ----------------------------------------------

sub_0a3da:	mov	#1000, r1
		mov	#task24o, r0h
		jsr	schedBackTaskDelayed

		mov	#task24o, r0h
		jsr	schedFrontTask

		rts

; ----------------------------------------------

sub_0a3ec:	btst	#0, @byte_ffff21:8
		rts

; ----------------------------------------------

sub_0a3f2:	bset	#6, @byte_ffff22:8
		rts

; ----------------------------------------------

sub_0a3f8:	push	er0
		mov	#task24o, r0h
		mov	#1000, r1
		jsr	schedBackTaskDelayed

		pop	er0
		bclr	#6, @byte_ffff22:8
		rts

; ----------------------------------------------

sub_0a410:	bsr	sub_0a362:16

		bsr	sub_0a352:16

		bsr	sub_0a38a:16

		jsr	sub_09e0e

		rts

; ----------------------------------------------

sub_0a422:	mov	#0, r0h
		mov	r0h, @byte_ffff23
		mov	#off_0a5a2, er0
		mov	er0, @long_ffea9e
		mov	#task25o, r0h
		jsr	schedFrontTask

		clr	c
		rts

; ----------------------------------------------

sub_0a442:	bra	sub_0a422

; ----------------------------------------------

rts_0a444:	rts

; ----------------------------------------------

task25:		btst	#2, @byte_ffff23
		beq	loc_0a4ba

		mov	#task25o, r0h
		jsr	checkSchedTask

		bcc	loc_0a4ba

		btst	#0, @byte_ffff23
		beq	loc_0a482

		mov	#off_0a5a2, er0
		mov	er0, @long_ffea9e
		bclr	#0, @byte_ffff23
		bclr	#2, @byte_ffff23
		bra	loc_0a4ba

loc_0a482:	btst	#1, @byte_ffff23
		bne	loc_0a4ba

		bset	#0, @byte_ffff23
		mov	#off_0a59a, er0
		mov	er0, @long_ffea9e
		mov	#-1, r0h
		jsr	sub_09d28

		mov	#0, r0h
		mov	r0h, @byte_ffe518
		mov	#task25o, r0h
		mov	#1000, r1
		jsr	schedBackTaskDelayed

loc_0a4ba:	mov	#task25o, r0h
		jsr	schedFrontTask

		clr	c
		bra	rts_0a4c6

		set	c

rts_0a4c6:	rts


off_0a4c8:	case 0	sub_0a4d0 sub_0a4e8 sub_0a50a sub_0a540

; ----------------------------------------------

sub_0a4d0:	cmp	#0xfa, r2h
		bne	loc_0a4dc

		jsr	sub_09dea

		bsr	sub_0a544

		bra	loc_0a4e4

loc_0a4dc:	mov	#3, r0h
		mov	r0h, @byte_ffe518

loc_0a4e4:	clr	c
		rts

; ----------------------------------------------

sub_0a4e8:	cmp	#0xaa, r2h
		bne	loc_0a4fe

		mov	#task25o, r0h
		mov	#10, r1
		jsr	schedBackTaskDelayed

		jsr	sub_09dea

		bsr	sub_0a544

		bra	loc_0a506

loc_0a4fe:	mov	#3, r0h
		mov	r0h, @byte_ffe518

loc_0a506:	clr	c
		rts

; ----------------------------------------------

sub_0a50a:	cmp	#0, r2h
		bne	loc_0a534

		mov	#off_0a5a2, er0
		mov	er0, @long_ffea9e
		bclr	#0, @byte_ffff23
		bclr	#2, @byte_ffff23
		bset	#1, @byte_ffff23

loc_0a534:	mov	#3, r0h
		mov	r0h, @byte_ffe518
		clr	c
		rts

; ----------------------------------------------

sub_0a540:	clr	c
		rts

; ----------------------------------------------

sub_0a544:	mov	@byte_ffe518, r0h
		inc	r0h
		mov	r0h, @byte_ffe518
		rts

; ----------------------------------------------

rts_0a554:	rts

; ----------------------------------------------

sub_0a556:	btst	#6, r0l
		bne	loc_0a55e

		btst	#7, r0l
		beq	loc_0a568

loc_0a55e:	mov	#3, r0h
		mov	r0h, @byte_ffe518
		bra	loc_0a57a

loc_0a568:	mov	r0, r2
		mov	@byte_ffe518, r0h
		mov	#off_0a4c8, er1
		jsr	switch_er1_r0h

loc_0a57a:	mov	#0, r0h
		rts

; ----------------------------------------------

sub_0a57e:	mov	#4, r2l
		bra	loc_0a586

sub_0a582:	mov	#0, r2l
		bra	loc_0a586

loc_0a586:	mov	@long_ffea9e, er1
		zero	e2
		mov	#0, r2h
		add	er2, er1
		mov	@er1, er1
		jmp	@er1

off_0a59a:	.long sub_0a556, rts_0a554

off_0a5a2:	.long sub_08aa6, sub_08d1c

; ----------------------------------------------

sub_0a5aa:	btst	#0, @byte_ffff23
		rts

; ----------------------------------------------

sub_0a5b4:	stm	er0-er1, @-sp
		bset	#2, @byte_ffff23
		bclr	#1, @byte_ffff23
		mov	#task25o, r0h
		mov	#0, r1
		jsr	schedBackTaskDelayed

		ldm	@sp+, er0-er1
		rts

; ----------------------------------------------

sub_0a5d8:	jsr	sub_0a6e6

		mov	#task26o, r0h
		mov	#3000, r1
		jsr	schedBackTaskDelayed

.if level >= 0x01000066
		bild	#0, @byte_ffe083
		bcs	loc_0a5f4

		jsr	sub_11136

.if type1R
		jsr	sub_110fa
.endif

loc_0a5f4:	bild	#1, @byte_ffe083
		bcs	loc_0a602
.endif

.if level >= 0x01000062
		jsr	sub_1114a
.endif

.if     type1R && level >= 0x01000066
		jsr	sub_110fa

loc_0a602:	mov	@byte_ffe084, r0l
		jsr	sub_10720

		mov	@byte_ffe085, r0l
		jsr	sub_10730
.elseif level >= 0x01000062
.if !type1R
loc_0a602:	bild	#4, @byte_ffe083
.endif
		bcs	rts_0a610

		jsr	sub_110fa
.endif

rts_0a610:	rts

; ----------------------------------------------

sub_0a612:	mov	@byte_ffe51a, r0h
		cmp	#1, r0h
		bne	loc_0a63e

		jsr	sub_0ac02

		mov	@byte_ffe51e, r0h
		jsr	sub_0c6c8

		mov	r0, @byte_ffeaa4
		mov	@byte_ffe51c, r0h
		cmp	#2, r0h
		bhi	loc_0a63e

		jsr	loc_07764

loc_0a63e:	bclr	#7, @byte_ffff25
.if !type1R
		btst	#0, @byte_ffff26
		beq	rts_0a668

		bclr	#0, @byte_ffff26
		bset	#4, @byte_ffff25
		jsr	sub_0a6e6

		jsr	sub_0b296
.endif

rts_0a668:	rts

; ----------------------------------------------

rts_0a66a:	rts

; ----------------------------------------------

sub_0a66c:	jsr	sub_0b50c

		rts

; ----------------------------------------------

task26:		mov	#task26o, r0h
		jsr	checkSchedTask

		bcc	loc_0a688

		jsr	sub_0a6a4

		mov	#task26o, r0h
		mov	#127, r1
		jsr	schedBackTaskDelayed

loc_0a688:	mov	#task26o, r0h
		jsr	schedFrontTask

		mov	@byte_ffe51e, r0h
		bsr	sub_0b42e:16

		cmp	#2, r0h
		bne	loc_0a6a0

		set	c
		bra	rts_0a6a2

loc_0a6a0:	clr	c

rts_0a6a2:	rts

; ----------------------------------------------

sub_0a6a4:	btst	#7, @byte_ffff24:8
		bne	rts_0a6e4

		jsr	sub_0126e

		bcc	loc_0a6b6

		jsr	sub_074d0

		bcc	loc_0a6b6

loc_0a6b6:
.if type1Y && level < 0x01020000
		bld	#2, @byte_ffe083
		bcc	0f

		mov	#0, r0h
		jsr	sub_0db7a

		bcc	0f

		bclr	#2, @byte_ffe083

0:		bld	#3, @byte_ffe083
		bcc	1f

		mov	#1, r0h
		jsr	sub_0db7a

		bcc	1f

		bclr	#3, @byte_ffe083

1:
.endif
		mov	#off_0a6f8, er0
		mov	@byte_ffe519, r1l
		mov	r1l, @byte_ffe51a
		cmp	#1, r1l
		beq	sub_0a6d4

		bclr	#2, @byte_ffff25

sub_0a6d4:	mov	#0, r1h
		shll	#2, r1
		add	r1, r0
		bcc	loc_0a6de

		inc	#1, e0

loc_0a6de:	mov	@er0, er0
		jsr	@er0

rts_0a6e4:	rts

; ----------------------------------------------

sub_0a6e6:	jsr	sub_0a7e4

		jsr	sub_0ac42

		jsr	sub_0b1ec

		jsr	sub_0b292

		rts

; ----------------------------------------------

off_0a6f8:	.long sub_0a7c4			; 0
		.long sub_0a7e8			; 1
		.long sub_0ac74			; 2
		.long sub_0b218			; 3
		.long sub_0b264			; 4
		.long sub_0a718			; 5
		.long sub_0a7c4			; 6
.if level >= 0x01000062
		.long sub_0b2a0			; 7
.endif

; ----------------------------------------------

sub_0a718:	mov	#0, r0h
		mov	r0h, @byte_ffe51b
.if level >= 0x01000066
		jsr	sub_110f0

		jsr	sub_11118

		jsr	sub_1112c

		btst	#4, @byte_ffff25
		beq	loc_0a76a

		btst	#5, @byte_ffff25
		beq	loc_0a748

		mov	#0, r0h
		jsr	sub_1110e

		bra	loc_0a74e

loc_0a748:	mov	#1, r0h
		jsr	sub_11122

loc_0a74e:	jsr	sub_0db7a

		bcs	loc_0a758

		mov	#7, r0h
		bra	loc_0a7ba

loc_0a758:	bclr	#4, @byte_ffff25
		jsr	sub_11118

		jsr	sub_1112c

		bra	loc_0a792
.endif

.if level >= 0x01000062
loc_0a76a:	btst	#3, @byte_ffff25
		beq	loc_0a792

		bclr	#3, @byte_ffff25
		jsr	sub_074d0

		bcs	loc_0a792

		mov	#-1, r0h
		jsr	sub_0db7a

		bcs	loc_0a792

		mov	#7, r0h
		jsr	sub_110e6

		bra	loc_0a7ba
.endif

loc_0a792:	jsr	sub_074d0

		mov	#0, r0l
		bist	#0, r0l
		push	er0
		mov	#-1, r0h
		jsr	sub_0db7a

		pop	er0
		bist	#1, r0l
		mov	#byte_0a7c0, er1
		add	r0l, r1l
		addx	#0, r1h
		bcc	loc_0a7b8

		inc	#1, e1

loc_0a7b8:	mov	@er1, r0h

loc_0a7ba:	jsr	loc_0b298

		rts


byte_0a7c0:	.byte 6, 0, 1, 2

; ----------------------------------------------

sub_0a7c4:	mov	#-1, r0h
		jsr	sub_0db7a

		bcc	loc_0a7d2

		jsr	sub_074d0

		bcc	rts_0a7d6

loc_0a7d2:	jsr	sub_0b296

rts_0a7d6:	rts

; ----------------------------------------------

sub_0a7d8:	mov	@byte_ffe51b, r1l
		jsr	sub_0a6d4

		rts

; ----------------------------------------------

sub_0a7e4:	jmp	loc_0ac6a

; ----------------------------------------------

sub_0a7e8:	jsr	sub_074d0

		bcc	loc_0a7f6

		mov	#-1, r0h
		jsr	sub_0db7a

		bcc	loc_0a800

loc_0a7f6:	jsr	sub_0ac42

		jsr	sub_0b296

		bra	rts_0a816

loc_0a800:	jsr	sub_0ab50

		mov	#off_0a818, er0
		jsr	sub_0a7d8

		jsr	sub_0ab06

		jsr	sub_0aaac

rts_0a816:	rts


off_0a818:	.long sub_0a84c			;  0
		.long sub_0a8a8			;  1
		.long sub_0aaa4			;  2
		.long sub_0a9da			;  3
		.long sub_0aa54			;  4
		.long sub_0aaa4			;  5
		.long sub_0aa64			;  6
		.long sub_0aa54			;  7
		.long sub_0aaa4			;  8
		.long sub_0aa8a			;  9
.if level >= 0x01000062
		.long sub_0aa54			; 10
		.long sub_0aaa4			; 11
		.long sub_0aa84			; 12
.endif

; ----------------------------------------------

sub_0a84c:
.if level >= 0x01000066
		btst	#4, @byte_ffff25
		beq	loc_0a866

		mov	#0, r0h
		btst	#5, @byte_ffff25
		bne	loc_0a864

		mov	#1, r0h

loc_0a864:	bra	loc_0a88e

loc_0a866:
.endif
		btst	#6, @byte_ffff24
		beq	loc_0a874

		mov	#0, r0h
		bra	loc_0a88e

loc_0a874:	btst	#5, @byte_ffff24
		beq	loc_0a882

		mov	#1, r0h
		bra	loc_0a88e

loc_0a882:	mov	#0, r0h
		bld	#2, @byte_ffff24
		bist	#0, r0h

loc_0a88e:	bclr	#6, @byte_ffff24
		bclr	#5, @byte_ffff24
		mov	r0h, @byte_ffe51e
		jmp	sub_0aeee

; ----------------------------------------------

sub_0a8a8:	mov	@byte_ffe51e, r0h
		jsr	sub_0c38c

		push	er0
		mov	@byte_ffe51e, r0h
		xor	#1, r0h
		jsr	sub_0c38c

		pop	er1
		cmp	#0, r1h
		bls	loc_0a90e

		cmp	#0, r0h
		bls	loc_0a90e

		mov	@byte_ffe51e, r2h
		cmp	#1, r2h
		bne	loc_0a906

.if !type1Y && level >= 0x01040000
		jsr	sub_01272
		bcc	loc_0a902
.endif

		btst	#2, @byte_ffff25
		bne	loc_0a902

		push	er0
		push	er1
		jsr	sub_074f8

		pop	er1
		pop	er0
		bcs	loc_0a902

		btst	#0, @byte_ffff24
		beq	loc_0a906

loc_0a902:	mov	#0, r0h
		bra	loc_0a90c

loc_0a906:	mov	@byte_ffe51e, r0h

loc_0a90c:	bra	loc_0a97c

loc_0a90e:	cmp	#0, r1h
		bls	loc_0a91a

		mov	@byte_ffe51e, r0h
		bra	loc_0a928

loc_0a91a:	cmp	#0, r0h
		bls	loc_0a93a

		mov	@byte_ffe51e, r0h
		xor	#1, r0h
		bra	loc_0a928

loc_0a928:	cmp	#0, r0h
		beq	loc_0a97c

		btst	#2, @byte_ffff25
		beq	loc_0a97c

		mov	#0, r0h
.if level >= 0x01000066
		bra	loc_0a97c
.endif

loc_0a93a:	zero	er0
		push	er0
		mov	#0, r0h
		jsr	sub_0db7a

		pop	er0
		bst	#0, r0l
		push	er0
		mov	#1, r0h
		jsr	sub_0db7a

		pop	er0
		bst	#1, r0l
		cmp	#0, r0l
		bne	loc_0a974

		push	er0
		jsr	sub_01276

		pop	er0
		bcs	loc_0a974

		mov	#0, r0h
		bra	loc_0a97c

loc_0a974:	mov	@(byte_0a9c6,er0), r0h

loc_0a97c:
.if level >= 0x01000066
		btst	#4, @byte_ffff25
		beq	loc_0a9a0

		mov	#0, r0l
		bld	#5, @byte_ffff25
		bist	#0, r0l
		cmp	r0l, r0h
		beq	loc_0a9a0

		bset	#6, @byte_ffff25
		bra	rts_0a9c4
.endif

loc_0a9a0:	cmp	#-1, r0h
		beq	loc_0a9bc

		mov	r0h, @byte_ffe51e
		jsr	sub_0aeaa

		jsr	sub_0aeee

		mov	@byte_ffe51e, r0h
		bsr	sub_0a9ca

		bra	rts_0a9c4

loc_0a9bc:	mov	#4, r0h
		mov	r0h, @byte_ffe51b

rts_0a9c4:	rts


byte_0a9c6:	.byte -1, 1, 0, -1

; ----------------------------------------------

sub_0a9ca:	jsr	sub_0c6c8

		mov	r0, @byte_ffeaa4
		jsr	sub_0ac02

		rts

; ----------------------------------------------

sub_0a9da:	jsr	sub_01272

.if level >= 0x01000062
		bcs	loc_0a9fc

		mov	@byte_ffe51a, r0h
		cmp	#7, r0h
		bne	loc_0a9f8

		jsr	sub_0ac42

		jsr	sub_01ede

		jsr	sub_0b296

.if level < 0x01000066
		jsr	sub_110f0
.endif

		bra	rts_0aa52

loc_0a9f8:	mov	#7, r0h
		bra	loc_0aa04

loc_0a9fc:	jsr	sub_0126e
.endif

		bcs	loc_0aa0c

		mov	#10 - 3 & (level < 0x01000062), r0h

loc_0aa04:	mov	r0h, @byte_ffe51b
		bra	rts_0aa52

loc_0aa0c:	mov	@byte_ffe51e, r0h
		cmp	#1, r0h
		bne	loc_0aa2c

		btst	#2, @byte_ffff25
		beq	loc_0aa2c

		mov	#0, r0h
		jsr	sub_0c38c

		cmp	#2, r0h
		bhi	loc_0aa4a

		bra	rts_0aa52

loc_0aa2c:	mov	@byte_ffe51e, r0h
		jsr	sub_0c38c

		cmp	#0, r0h
		bhi	rts_0aa52

		mov	@byte_ffe51e, r0h
		xor	#1, r0h
		jsr	sub_0c38c

		cmp	#2, r0h
		bls	rts_0aa52

loc_0aa4a:	mov	#1, r0h
		mov	r0h, @byte_ffe51b

rts_0aa52:	rts

; ----------------------------------------------

sub_0aa54:	jsr	sub_0b7ac

		mov	#-1, r0h
		mov	r0h, @byte_ffe51e
		jmp	sub_0aeee

; ----------------------------------------------

sub_0aa64:	jsr	sub_07238

		bcs	rts_0aa82

		mov	#0, r0h
		jsr	sub_0c38c

		cmp	#2, r0h
		bhi	loc_0aa7e

		mov	#1, r0h
		jsr	sub_0c38c

		cmp	#2, r0h
		bls	rts_0aa82

loc_0aa7e:	jsr	sub_0ac42

rts_0aa82:	rts

; ----------------------------------------------

.if level >= 0x01000062
sub_0aa84:	jsr	sub_0126e

		bra	loc_0aa8e
.endif

sub_0aa8a:	jsr	sub_01272

loc_0aa8e:	bcc	loc_0aa96

		jsr	sub_0ac42

		bra	rts_0aaa2

loc_0aa96:	jsr	sub_0abc0

		cmp	#3, r0h
		blo	rts_0aaa2

		jsr	sub_0773a

rts_0aaa2:	rts

; ----------------------------------------------

sub_0aaa4:	jsr	sub_0b90c

		jmp	sub_0aeee

; ----------------------------------------------

sub_0aaac:	mov	#0, r0h
		bsr	sub_0aaea

		push	er0
		mov	#1, r0h
		bsr	sub_0aaea

		pop	er1
.if level < 0x01000062
		add	r1h, r0h
		bpl	rts_0aae8
.else
		mov	r0h, r1l
		add	r1h, r0h
		cmp	#0, r0h
		bgt	rts_0aae8

		blt	loc_0aae4

		mov	r1, r2
		beq	rts_0aae8

		jsr	sub_01276

		bcs	rts_0aae8

		jsr	sub_02086

		cmp	#9, r0h
		beq	loc_0aae0

		cmp	#6, r0h
		bne	rts_0aae8

		mov	r2h, r1l
		mov	r2l, r1h

loc_0aae0:	cmp	r1l, r1h
		bge	rts_0aae8
.endif

loc_0aae4:	jsr	sub_017a0

rts_0aae8:	rts

; ----------------------------------------------

sub_0aaea:	jsr	sub_0c76c

		bcs	loc_0aafc

		btst	#7, r0h
		beq	loc_0aaf8

		mov	#-1, r0h
		bra	loc_0aafa

loc_0aaf8:	mov	#1, r0h

loc_0aafa:	bra	rts_0ab04

loc_0aafc:
.if level >= 0x01000062
		jsr	sub_0db7a

		bcc	loc_0aaf8
.endif

		mov	#0, r0h

rts_0ab04:	rts

; ----------------------------------------------

sub_0ab06:	mov	#-1, r0h
		jsr	sub_0c3d2

		bcs	rts_0ab4e

		bsr	sub_0abc0:16

		mov	@byte_ffe51c, r1h
		cmp	r1h, r0h
		bhs	rts_0ab4e

		push	er0
		cmp	#2, r0h
		bhi	loc_0ab2e

		cmp	#2, r1h
		bls	loc_0ab2e

		mov	#1, r0h
		jsr	sub_063a0

loc_0ab2e:	pop	er0
		mov	r0h, @byte_ffe51c
		mov	#off_0ac14, er1
		shll	#2, r0h
		add	r0h, r1l
		addx	#0, r1h
		bcc	loc_0ab48

		inc	#1, e1

loc_0ab48:	mov	@er1, er0
		jsr	@er0

rts_0ab4e:	rts

; ----------------------------------------------

sub_0ab50:	mov	#1, r0h
		jsr	sub_0c3d2

		bcs	loc_0abac

		jsr	sub_0c8fa

		bcs	loc_0abac

		mov	@byte_ffe51e, r0h
		cmp	#0, r0h
		beq	loc_0abaa

		mov	#0, r0h
		jsr	sub_0c38c

		cmp	#2, r0h
		bhi	loc_0abaa

		btst	#2, @byte_ffff25
		bne	loc_0ab92

		dec	#1, r1
		mov	r1, @word_ffeaaa
		mov	#1, r0h
		jsr	sub_063a0

		mov	#0x4e, r0h
		jsr	sub_10cc0

		bra	loc_0abaa

loc_0ab92:	mov	@word_ffeaaa, r0
		cmp	r0, r1
		bhi	loc_0abaa

		dec	#1, r1
		mov	r1, @word_ffeaaa
		mov	#0x4f, r0h
		jsr	sub_10cc0

loc_0abaa:	clr	c

loc_0abac:	bist	#2, @byte_ffff25
		rts

; ----------------------------------------------

sub_0abb6:	bld	#2, @byte_ffff25
		rts

; ----------------------------------------------

sub_0abc0:	mov	#0, r0h
		jsr	sub_0c38c

		push	er0
		mov	#1, r0h
		jsr	sub_0c38c

		pop	er1
		btst	#2, @byte_ffff25
		beq	loc_0abe8
		mov	@byte_ffe51e, r2l
		cmp	#0, r2l
		beq	loc_0abf2

loc_0abe8:	btst	#0, @byte_ffff24
		beq	loc_0abf4

loc_0abf2:	mov	#0, r0h

loc_0abf4:	cmp	r0h, r1h
		bls	loc_0abfe

		mov	r0h, r0l
		mov	r1h, r0h
		bra	rts_0ac00

loc_0abfe:	mov	r1h, r0l

rts_0ac00:	rts

; ----------------------------------------------

sub_0ac02:	mov	@word_ffe9be, r0
		add	#0x3c, r0l
		addx	#0, r0h
		mov	r0, @word_ffeaa2
		rts

; ----------------------------------------------

off_0ac14:	.long sub_0ac2e			; 0
		.long sub_0ac2e			; 1
		.long sub_0ac36			; 2
		.long sub_0ac3a			; 3
		.long rts_0ac2c			; 4
		.long rts_0ac2c			; 5

; ----------------------------------------------

rts_0ac2c:	rts

; ----------------------------------------------

sub_0ac2e:	mov	#0x22, r0h
		jsr	sub_10cc0

		bra	sub_0ac36

sub_0ac36:	jmp	loc_07764

; ----------------------------------------------

sub_0ac3a:	mov	#2, r0h
		jsr	sub_063a0

		rts

; ----------------------------------------------

sub_0ac42:	mov	#-1, r0h
		mov	r0h, @byte_ffe51c
		jsr	sub_0773a

		mov	#0, r0
		mov	r0, @word_ffeaa6
		bclr	#6, @byte_ffff24
		bclr	#5, @byte_ffff24
.ifeq type70 && level >= 0x01040000 || type76 && level >= 0x01060000
		bra	loc_0ac6a
.endif
loc_0ac6a:	mov	#0, r0h
		mov	r0h, @byte_ffe51b
		rts

; ----------------------------------------------

sub_0ac74:	jsr	sub_074d0

		bcs	loc_0ac82

		mov	#-1, r0h
		jsr	sub_0db7a

		bcc	loc_0ac8c

loc_0ac82:	jsr	sub_0b1ec

		jsr	sub_0b296

		bra	rts_0acac

loc_0ac8c:	btst	#3, @byte_ffff24
		bne	rts_0acac

.if level >= 0x01000062
.if level < 0x01000066
		btst	#0, @byte_ffe083
		bne	rts_0acac
.else
		jsr	sub_0b5e4

		bcs	loc_0aca2

		jsr	sub_0b1ec

		bra	rts_0acac
.endif
.endif

loc_0aca2:	mov	#off_0acae, er0
		jsr	sub_0a7d8

rts_0acac:	rts


off_0acae:	.long sub_0ad06			;  0
		.long sub_0b10e			;  1
		.long sub_0ad1c			;  2
		.long sub_0aede			;  3
		.long sub_0aefe			;  4
		.long sub_0ad82			;  5
		.long sub_0aede			;  6
		.long sub_0ad9e			;  7
		.long sub_0ad56			;  8
		.long sub_0aff0			;  9
		.long sub_0aa54			; 10
		.long sub_0affc			; 11
		.long sub_0aebe			; 12
		.long sub_0af2c			; 13
		.long sub_0b008			; 14
		.long sub_0aede			; 15
		.long sub_0aefe			; 16
		.long sub_0af0e			; 17
		.long sub_0b01a			; 18
.ifeq type1R && level < 0x01030069
		.long sub_0aecc			; 19
		.long sub_0aefe			; 20
		.long sub_0b13c			; 21
.endif

; ----------------------------------------------

sub_0ad06:	mov	#0, r0h
		bld	#1, @byte_ffff24
		bst	#0, r0h
		mov	r0h, @byte_ffe51e

loc_0ad18:	jmp	sub_0aeee

; ----------------------------------------------

sub_0ad1c:	mov	@byte_ffe51e, r0h
.if level >= 0x01000066
		bne	loc_0ad30

		bld	#0, @byte_ffe083
		bcs	loc_0ad46

		bra	loc_0ad3a

loc_0ad30:	bld	#1, @byte_ffe083
		bcs	loc_0ad46

loc_0ad3a:	mov	@byte_ffe51e, r0h
.endif
		jsr	sub_0db7a

		bcc	loc_0ad50

loc_0ad46:	mov	#8, r0h
		mov	r0h, @byte_ffe51b
		bra	rts_0ad54

loc_0ad50:	jsr	sub_0aeee

rts_0ad54:	rts

; ----------------------------------------------

sub_0ad56:	mov	@byte_ffe51e, r0h
		xor	#1, r0h
		cmp	#1, r0h
		bne	loc_0ad6e

		btst	#0, @byte_ffff24
		beq	loc_0ad6e

		mov	#0, r0h

loc_0ad6e:	mov	r0h, @byte_ffe51e
		mov	#1, r0h
		mov	r0h, @byte_ffe51b
		rts

; ----------------------------------------------

		mov	#1, r0h
		bra	loc_0ad18

; ----------------------------------------------

sub_0ad82:	mov	@byte_ffe51e, r0h
		jsr	sub_0c42c

		bcs	loc_0ad94

		jsr	sub_0aeee

		bra	rts_0ad9c

loc_0ad94:	mov	#0x0e, r0h
		mov	r0h, @byte_ffe51b

rts_0ad9c:	rts

; ----------------------------------------------

sub_0ad9e:	jsr	sub_0b1bc

		bcs	loc_0ae04

		cmp	#0, r0h
		bne	loc_0ae04

.if level >= 0x01000066
		mov	@byte_ffe51e, r0l
		mov	#byte_ffe084, er2
		extu	r0
		extu	er0
		add	er0, er2
		mov	@er2, r1l
.if type1R
		cmp	#0, r1l
		beq	0f

		mov	r0l, r0h
.else
		add	#2, er2
		mov	@er2, r1h
.endif
		push	er1
.if !type1R
		mov	r0l, r0h
.endif
		jsr	sub_0c460

		pop	er1
.if level < 0x01020000 || type1R && level >= 0x01030000
		bcs	rts_0ae22
.else
		bcs	loc_0adfa
.endif

.if type1R
		cmp	r1l, r0h
		bls	0f

		mov	#0x08, r0h
		mov	r0h, @byte_ffe51b
		bra	rts_0ae22

0:
.else
		cmp	#0, r1l
		beq	loc_0ade0

		bsr	sub_0ae24

		bcc	loc_0ade0

		cmp	r1l, r0h
		bhi	loc_0adfa

loc_0ade0:	cmp	#0, r1h
		beq	loc_0ade8

		cmp	r1h, r0h
		bhs	loc_0adfa

loc_0ade8:	jsr	sub_0ae5c
.endif
.endif

		mov	#0x0c, r0h
		mov	r0h, @byte_ffe51b
.if type1R
		bsr	sub_0aeaa
.else
		bsr	sub_0aeaa:16
.endif

		bra	rts_0ae22

loc_0adfa:
.if !type1R
		mov	#8, r0h
		mov	r0h, @byte_ffe51b
		bra	rts_0ae22
.endif

loc_0ae04:	mov	@byte_ffe51e, r0h
		jsr	sub_0c76c

		bcs	loc_0ae1e

		btst	#4, r0h
		beq	loc_0ae1e

		mov	#0x0e, r0h
		mov	r0h, @byte_ffe51b
		bra	rts_0ae22

loc_0ae1e:	jsr	sub_0aefe

rts_0ae22:	rts

; ----------------------------------------------

.if !type1R
sub_0ae24:	mov	@byte_ffe51e, r3l
		bne	loc_0ae36

		bild	#2, @byte_ffe083
		bra	rts_0ae3e

loc_0ae36:	bild	#3, @byte_ffe083

rts_0ae3e:	rts

; ----------------------------------------------

sub_0ae40:	mov	@byte_ffe51e, r3l
		bne	loc_0ae52

		bclr	#2, @byte_ffe083
		bra	rts_0ae5a

loc_0ae52:	bclr	#3, @byte_ffe083

rts_0ae5a:	rts

; ----------------------------------------------

sub_0ae5c:	mov	@byte_ffe51e, r3l
		bne	loc_0ae6e

		bset	#2, @byte_ffe083
		bra	rts_0ae76

loc_0ae6e:	bset	#3, @byte_ffe083

rts_0ae76:	rts

; ----------------------------------------------

sub_0ae78:	mov	@byte_ffe51e, r0l
		mov	#byte_ffe086, er2
		extu	r0
		extu	er0
		add	er0, er2
		mov	@er2, r1l
		beq	loc_0aea6

		push	er1
		mov	r0l, r0h
		jsr	sub_0c460

		pop	er1
		bcs	loc_0aea6

		cmp	r1l, r0h
		blo	loc_0aea6

		set	c
		bra	rts_0aea8

loc_0aea6:	clr	c

rts_0aea8:	rts

; ----------------------------------------------
.endif

sub_0aeaa:	mov	@byte_ffe51e, r0h
		bne	loc_0aeb8

		jsr	sub_0b7a4

		bra	rts_0aebc

loc_0aeb8:	jsr	sub_0b7a8

rts_0aebc:	rts

; ----------------------------------------------

sub_0aebe:	jsr	sub_01e92

		jsr	sub_01ecc

		jsr	sub_0b90c

		bra	sub_0aeee


.ifeq type1R && level < 0x01030069
sub_0aecc:	mov	@word_ffe9be, r0
		add	#10, r0l
		addx	#0, r0h
		mov	r0, @word_ffeaa2
		bra	sub_0aeee
.endif


sub_0aede:	mov	@word_ffe9be, r0
		add	#3, r0l
		addx	#0, r0h
		mov	r0, @word_ffeaa2
sub_0aeee:	mov	@byte_ffe51b, r0h
		inc	r0h
		mov	r0h, @byte_ffe51b
		rts

; ----------------------------------------------

sub_0aefe:	mov	@word_ffeaa2, r0
		jsr	sub_016e4

		bcc	rts_0af0c

		bsr	sub_0aeee

rts_0af0c:	rts

; ----------------------------------------------

sub_0af0e:	mov	#28800, r1
		bra	loc_0af18

		mov	#14400, r1

loc_0af18:	mov	@word_ffe9be, r0
		add	r1, r0
		mov	r0, @word_ffeaa2
		jsr	sub_0aeee

		rts

; ----------------------------------------------

sub_0af2c:	jsr	sub_0b208

		bcs	rts_0afee:16

.if !type1R
		jsr	sub_0ae78

		bcs	loc_0af44
.endif

		jsr	sub_0b1bc

		bcc	loc_0af7c

		cmp	#0, r0h
		bne	loc_0af72

.if !type1R
loc_0af44:	jsr	sub_0ae40
.endif

		jsr	sub_0b1ec

.ifeq type1R && level < 0x01030069
		mov	@byte_ffe51e, r0h
		jsr	sub_0c800

		bcs	loc_0af70

		cmp	#1, r0h
		bne	loc_0af70

		mov	@byte_ffe51e, r0h
		jsr	sub_0cc40

		bcs	loc_0af70

		mov	#0x13, r0h
		mov	r0h, @byte_ffe51b

loc_0af70:
.endif
		bra	loc_0af78

loc_0af72:	mov	#6, r0h
		jsr	sub_0b280

loc_0af78:	bra	rts_0afee:16

loc_0af7c:	jsr	sub_01276

		bcc	rts_0afee

		mov	@byte_ffe51e, r0h
		jsr	sub_0c800

		bcs	rts_0afee

		cmp	#1, r0h
		bne	rts_0afee

		mov	@byte_ffe51e, r0h
		jsr	sub_0c446

		bcs	rts_0afee

		mov	#1800, r1
		cmp	r1, r0
		ble	loc_0afb0

		bset	#7, @byte_ffff25
		bra	rts_0afee

loc_0afb0:	mov	#1000, r1
		cmp	r1, r0
		bgt	rts_0afee

		btst	#7, @byte_ffff25
		beq	rts_0afee

		mov	@byte_ffe51e, r0h
		bld	#0, r0h
		bist	#0, r0h
		push	er0
		jsr	sub_0c3d2

		pop	er0
		bcs	rts_0afee

		jsr	sub_0c35c

		btst	#2, r0h
		beq	rts_0afee

		jsr	sub_0b1ec

		mov	#8, r0h
		mov	r0h, @byte_ffe51b

rts_0afee:	rts

; ----------------------------------------------

sub_0aff0:	jsr	sub_01e9c

		jsr	sub_01ecc

		jmp	sub_0aeee

; ----------------------------------------------

sub_0affc:	jsr	sub_07238

		bcs	rts_0b006

		jsr	sub_0b1ec

rts_0b006:	rts

; ----------------------------------------------

sub_0b008:	mov	@byte_ffe51e, r0h
		jsr	sub_01eae

		jsr	sub_0b90c

		jmp	sub_0aeee

; ----------------------------------------------

sub_0b01a:	jsr	sub_0b208

		bcs	rts_0b09e

		mov	@byte_ffe51e, r0h
		jsr	sub_0db7a

		bcc	loc_0b032

		jsr	sub_0b1ec

		bra	rts_0b09e

loc_0b032:	mov	@byte_ffe51e, r0h
		jsr	sub_0c3d2

		bcc	loc_0b044

		jsr	sub_0b0b4

		bcc	loc_0b050

loc_0b044:	mov	@word_ffeaa2, r0
		jsr	sub_016e4

		bcc	loc_0b072

loc_0b050:	mov	@byte_ffe51e, r0h
		bne	loc_0b062

		bset	#0, @byte_ffe082
		bra	loc_0b06a

loc_0b062:	bset	#1, @byte_ffe082

loc_0b06a:	mov	#6, r0h
		jsr	sub_0b280

		bra	rts_0b09e

loc_0b072:	mov	@byte_ffe51e, r0h
		jsr	sub_0c76c

		bcs	rts_0b09e

		btst	#4, r0h
		bne	rts_0b09e

		mov	@byte_ffe51e, r0h
		jsr	sub_0c35c

		btst	#2, r0h
		bne	loc_0b096

		jsr	sub_0b1ec

		bra	rts_0b09e

loc_0b096:	mov	#6, r0h
		mov	r0h, @byte_ffe51b

rts_0b09e:	rts

; ----------------------------------------------

sub_0b0a0:	cmp	#1, r0h
		bne	loc_0b0ac

		mov	@word_ffec58, r0
		bra	rts_0b0b2

loc_0b0ac:	mov	@word_ffec56, r0

rts_0b0b2:	rts

; ----------------------------------------------

sub_0b0b4:	mov	@byte_ffe51e, r0h
		jsr	sub_0b0a0

		mov	#0x1eb, r1
		cmp	r1, r0
		bls	loc_0b102

		btst	#4, @byte_ffff24
		bne	loc_0b0ee

		mov	@tick, r0
		mov	#1000, r1
		add	r1, r0
		mov	r0, @word_ffeaa8
		bset	#4, @byte_ffff24
		set	c
		bra	loc_0b100

loc_0b0ee:	mov	@word_ffeaa8, r0
		jsr	cmpTick

		bcc	loc_0b0fe

		clr	c
		bra	loc_0b100

loc_0b0fe:	set	c

loc_0b100:	bra	rts_0b10c

loc_0b102:	bclr	#4, @byte_ffff24
		set	c

rts_0b10c:	rts

; ----------------------------------------------

sub_0b10e:	mov	#1, r0h
		jsr	sub_0c3d2

		bcs	loc_0b134

		jsr	sub_074f8

		bcs	loc_0b126

		btst	#0, @byte_ffff24
		beq	loc_0b12e

loc_0b126:	mov	#0, r0h
		jsr	sub_0c3d2

		bcc	loc_0b134

loc_0b12e:	jsr	sub_0b7a8

		bra	loc_0b138

loc_0b134:	jsr	sub_0b7a4

loc_0b138:	jmp	sub_0aeee

; ----------------------------------------------

.ifeq type1R && level < 0x01030069
sub_0b13c:	mov	@byte_ffe51e, r0h
		jsr	sub_0cbfc

		bcs	loc_0b18a

		bsr	sub_0b190

		mov	r0h, r4h
		mov	r1, r0
		bsr	sub_0b190

		or	r0h, r4h
		mov	r2, r0
		bsr	sub_0b190

		or	r0h, r4h
		mov	r3, r0
		bsr	sub_0b190

		or	r0h, r4h
		cmp	#3, r4h
		bne	loc_0b184

		mov	@byte_ffe51e, r0h
		bne	loc_0b174

		bset	#0, @byte_ffe082
		bra	loc_0b17c

loc_0b174:	bset	#1, @byte_ffe082

loc_0b17c:	mov	#6, r0h
		jsr	sub_0b280

		bra	loc_0b188

loc_0b184:	jsr	sub_0b1ec

loc_0b188:	bra	rts_0b18e

loc_0b18a:	jsr	sub_0b1ec

rts_0b18e:	rts

; ----------------------------------------------

sub_0b190:	push	r1
		mov	#1000, r1
		cmp	r1, r0
		bls	loc_0b1b6

		mov	#0xff0, r1
		cmp	r1, r0
		bhs	loc_0b1a6

		mov	#1, r0h
		bra	loc_0b1b4

loc_0b1a6:	mov	#0x1072, r1
		cmp	r1, r0
		bls	loc_0b1b2

		mov	#2, r0h
		bra	loc_0b1b4

loc_0b1b2:	mov	#0, r0h

loc_0b1b4:	bra	loc_0b1b8

loc_0b1b6:	mov	#0, r0h

loc_0b1b8:	pop	r1
		rts

; ----------------------------------------------
.endif

sub_0b1bc:	mov	@byte_ffe51e, r0h
		jsr	sub_0c35c

		mov	r0h, r0l
		btst	#0, r0h
		beq	loc_0b1dc

		push	er0
		jsr	sub_0b280

		pop	er0
		set	c
		bra	rts_0b1ea

loc_0b1dc:	btst	#2, r0h
		beq	loc_0b1e6

		mov	#0, r0h
		clr	c
		bra	rts_0b1ea

loc_0b1e6:	mov	#0, r0h
		set	c

rts_0b1ea:	rts

; ----------------------------------------------

sub_0b1ec:	jsr	sub_01e9c

		jsr	sub_01ecc

		bclr	#4, @byte_ffff24
		bclr	#7, @byte_ffff25
.if !type1Y && level >= 0x01040000
		mov	#0, r0h
		jsr	sub_0c38c

		cmp	#0, r0h
		beq	loc_0b00a

		jsr	sub_0b7a4

loc_0b00a:
.endif
		jmp	loc_0ac6a

; ----------------------------------------------

sub_0b208:	jsr	sub_07238

		bcc	rts_0b216

		mov	#9, r0h
		mov	r0h, @byte_ffe51b

rts_0b216:	rts

; ----------------------------------------------

sub_0b218:	jsr	sub_074d0

		bcc	loc_0b222

		bsr	sub_0b232

		bcs	loc_0b22c

loc_0b222:	jsr	sub_0b296

		jsr	sub_0773a

		bra	rts_0b230

loc_0b22c:	jsr	loc_07764

rts_0b230:	rts

; ----------------------------------------------

sub_0b232:	mov	#0, r0h
		bsr	sub_0b23e

		bcc	rts_0b23c

		mov	#1, r0h
		bsr	sub_0b23e

rts_0b23c:	rts

; ----------------------------------------------

sub_0b23e:	push	er0
		jsr	sub_0db7a

		pop	er0
		bcs	loc_0b260

		jsr	sub_0c38c

		cmp	#3, r0h
		bls	loc_0b258

		clr	c
		bra	loc_0b25e

loc_0b258:	jsr	sub_0b90c

		set	c

loc_0b25e:	bra	rts_0b262

loc_0b260:	set	c

rts_0b262:	rts

; ----------------------------------------------

sub_0b264:	jsr	sub_074d0

		bcs	loc_0b276

		mov	@byte_ffe51e, r0h
		jsr	sub_0db7a

		bcc	rts_0b27e

loc_0b276:	jsr	sub_0b296

		jsr	sub_0b292

rts_0b27e:	rts

; ----------------------------------------------

sub_0b280:	mov	r0h, @byte_ffe51d
		jsr	sub_0b1ec

		mov	#4, r0h
		jsr	loc_0b298

		rts

; ----------------------------------------------

sub_0b292:
.if type1R && level < 0x01030069
		bclr	#0, @byte_ffff25
		bclr	#1, @byte_ffff25
.endif
		jmp	loc_0ac6a

; ----------------------------------------------

sub_0b296:	mov	#5, r0h

loc_0b298:	mov	r0h, @byte_ffe519
		rts

; ----------------------------------------------

sub_0b2a0:
.if level >= 0x01000062
.if level >= 0x01000066
		btst	#4, @byte_ffff25
		beq	loc_0b30c

		btst	#6, @byte_ffff25
		beq	loc_0b2be

		bclr	#6, @byte_ffff25
		bra	loc_0b328

loc_0b2be:	mov	#0, r0h
		btst	#5, @byte_ffff25
		bne	loc_0b2cc

		mov	#1, r0h

loc_0b2cc:	jsr	sub_0db7a

		bcs	loc_0b328

		bld	#2, @byte_ffff25
		band	#0, r0h
		bcs	loc_0b328

		bld	#0, @byte_ffff24
		band	#0, r0h
		bcs	loc_0b328

		jsr	sub_074f8

		band	#0, r0h
		bcs	loc_0b328

		jsr	sub_0c38c

		cmp	#0, r0h
		bls	loc_0b328

.if !type1R
		jsr	sub_01272

		bcs	loc_0b30a

		bset	#0, @byte_ffff26
		bra	loc_0b328

loc_0b30a:
.endif
		bra	loc_0b33e

loc_0b30c:
.endif
		jsr	sub_074d0

		bcs	loc_0b328

		jsr	sub_01276

		bcs	loc_0b328

		mov	#-1, r0h
		jsr	sub_0db7a

		bcs	loc_0b328

		jsr	sub_0abc0

		cmp	#0, r0h
		bhi	loc_0b33e

loc_0b328:
.if level >= 0x01000066
		bclr	#4, @byte_ffff25
.endif
		jsr	sub_0ac42

		jsr	sub_01ede

		jsr	sub_0b296

.if level < 0x01000066
		jsr	sub_110f0
.endif

		bra	rts_0b354

loc_0b33e:	mov	@byte_ffe51b, r0h
		bne	loc_0b34a

		jsr	sub_01ed6

loc_0b34a:	mov	#off_0a818, er0
		jsr	sub_0a7d8

rts_0b354:	rts

; ----------------------------------------------

sub_0b356:	cmp	#1, r0l
		bne	loc_0b362

		jsr	sub_0b5fe

.if level < 0x01000066
		bra	rts_0b42c
.else
		jmp	rts_0b42c
.endif

loc_0b362:	cmp	#2, r0l
		bne	loc_0b382

.if level >= 0x01000066
		jsr	sub_0b5b8

		jsr	sub_0b5c6

.if !type1R
		bset	#4, @byte_ffe083
		jsr	sub_110fa
.endif
.endif

		jsr	sub_0b5d4

.if level < 0x01000066
		bra	rts_0b42c
.else
		jmp	rts_0b42c
.endif

loc_0b382:	cmp	#3, r0l
		bne	loc_0b3a2

.if level < 0x01000066
		mov	@byte_ffe51a, r0h
		cmp	#7, r0h
		bne	rts_0b42c

.else
		bclr	#4, @byte_ffff25
.endif
		jsr	sub_0ac42

		jsr	sub_01ede

		jsr	sub_0b296

.if level < 0x01000066
		jsr	sub_110f0

		bra	rts_0b42c
.else
		jsr	sub_0a6e6

		jmp	rts_0b42c
.endif

loc_0b3a2:	cmp	#4, r0l
		bne	loc_0b3ca

.if level >= 0x01000066
		bclr	#4, @byte_ffff25
		bclr	#5, @byte_ffff25
		bset	#3, @byte_ffff25

loc_0b3be:
.endif
		jsr	sub_0a6e6

.if level < 0x01000066
		bset	#3, @byte_ffff25
.endif
		jsr	sub_0b296

.if level >= 0x01000066
		jmp	rts_0b42c
.endif

loc_0b3ca:
.if level >= 0x01000066
		cmp	#7, r0l
		bne	loc_0b3e8

		bset	#4, @byte_ffff25
		bset	#5, @byte_ffff25
		bclr	#3, @byte_ffff25
		bra	loc_0b3be

loc_0b3e8:	cmp	#8, r0l
		bne	loc_0b406

		bset	#4, @byte_ffff25
		bclr	#3, @byte_ffff25
		bclr	#5, @byte_ffff25
		bra	loc_0b3be

loc_0b406:	cmp	#5, r0l
		bne	loc_0b414

		jsr	sub_0b5b8

		jsr	sub_0b5d4

		bra	rts_0b42c

loc_0b414:	cmp	#6, r0l
		bne	loc_0b422

		jsr	sub_0b5c6

		jsr	sub_0b5d4

		bra	rts_0b42c

loc_0b422:
.endif
		cmp	#0x10, r0l
		bne	rts_0b42c

		jsr	sub_0ea1c

.if !type1R
		bra	rts_0b42c
.endif

rts_0b42c:	rts
.endif

; ----------------------------------------------

sub_0b42e:	mov	@byte_ffe51e, r0l
		bmi	loc_0b43a

		cmp	r0l, r0h
		bne	loc_0b478

loc_0b43a:	push	er0
		mov	@byte_ffe51a, r0h
		mov	#word_0b498, er1
		mov	#num_0b498, r0l
		mov	#0, r3h

loc_0b44e:	mov	@er1+, r2
		cmp	r2h, r0h
		bne	loc_0b458

		mov	r2l, r3h
		bra	loc_0b45c

loc_0b458:	dec	r0l
		bne	loc_0b44e

loc_0b45c:	cmp	#2, r0h
		bne	loc_0b46c

		mov	@byte_ffe51b, r0l
		cmp	#0x0c, r0l
		bhi	loc_0b46c

		mov	#0, r3h

loc_0b46c:	pop	er0
		mov	@byte_ffe51c, r1h
		bra	loc_0b47a

loc_0b478:	mov	#0, r3h

loc_0b47a:	push	er3
		jsr	sub_0c38c

		pop	er3
		mov	r0h, r1h
		mov	r3h, r0h
		mov	@byte_ffe51c, r0l
		add	#0xfe, r0l
		bpl	rts_0b496

		mov	#0, r0l

rts_0b496:	rts


word_0b498:	.word 0x000, 0x101, 0x202, 0x301, 0x400
.if level >= 0x01000062
		.word 0x701
.endif
	num_0b498 = (. - word_0b498) / 2

; ----------------------------------------------

rts_0b4a4:	rts

; ----------------------------------------------

sub_0b4a6:
.ifeq type1R && level < 0x01030069
		push	r0
		jsr	sub_0db7a

		pop	r0
		bcc	rts_0b4d6

		cmp	#0, r0h
		bne	loc_0b4c6

		bclr	#0, @byte_ffe082

.if !type1R && level >= 0x01020000
		bclr	#2, @byte_ffe083
.endif

		bra	rts_0b4d6

loc_0b4c6:	bclr	#1, @byte_ffe082

.if !type1R && level >= 0x01020000
		bclr	#3, @byte_ffe083
.endif

rts_0b4d6:	rts
.endif

; ----------------------------------------------

sub_0b4d8:	mov	@byte_ffe51a, r0h
		cmp	#1, r0h
.if level >= 0x01000066
		beq	loc_0b4f0

		cmp	#7, r0h
		bne	rts_0b50a

		btst	#4, @byte_ffff25
.endif
		bne	rts_0b50a

loc_0b4f0:	mov	#0, r0h
		jsr	sub_0c3d2

		bcs	rts_0b50a

		mov	#1, r0h
		jsr	sub_0c3d2

		bcs	rts_0b50a

		jsr	sub_01272

		bcc	rts_0b50a

		jsr	sub_0ac42

rts_0b50a:	rts

; ----------------------------------------------

sub_0b50c:	clr	c
		bra	loc_0b512

sub_0b510:	set	c

loc_0b512:	bxor	#0, @byte_ffff24
		bcc	rts_0b544

		bld	#0, @byte_ffff24
		bist	#0, @byte_ffff24
		mov	#0, r0h
		jsr	sub_0c3d2

		bcs	rts_0b544

		mov	#1, r0h
		jsr	sub_0c3d2

		bcs	rts_0b544

		jsr	sub_0ac42

		jsr	sub_0b1ec

rts_0b544:	rts

; ----------------------------------------------

		bild	#0, @byte_ffff24
		rts

; ----------------------------------------------

		mov	#0, r0h
		bld	#1, @byte_ffff24
		bist	#4, r0h
		bst	#5, r0h
		bld	#2, @byte_ffff24
		bst	#0, r0h
		bist	#1, r0h
		rts

; ----------------------------------------------

		bld	#5, r0h
		bst	#1, @byte_ffff24
		bld	#0, r0h
		bst	#2, @byte_ffff24
		rts

; ----------------------------------------------

sub_0b582:	bld	#3, @byte_ffff24
		bcs	rts_0b5a2

		bset	#3, @byte_ffff24
		mov	@byte_ffe51a, r0h
		cmp	#2, r0h
		bne	rts_0b5a2

		jsr	sub_0b1ec

rts_0b5a2:	rts

; ----------------------------------------------

sub_0b5a4:	bclr	#3, @byte_ffff24
		rts

; ----------------------------------------------

		bild	#3, @byte_ffff24
		rts

; ----------------------------------------------

.if level >= 0x01000066
sub_0b5b8:	bset	#0, @byte_ffe083
		jsr	sub_11136

.if type1R
		jsr	sub_110fa
.endif

		rts

; ----------------------------------------------

sub_0b5c6:	bset	#1, @byte_ffe083
		jsr	sub_1114a

.if type1R
		jsr	sub_110fa
.endif

		rts
.endif

; ----------------------------------------------

.if level >= 0x01000062
sub_0b5d4:
.if level < 0x01000066
		bld	#0, @byte_ffe083
		bcs	rts_0b5e2

		bset	#0, @byte_ffe083
		jsr	sub_110fa
.endif

		mov	@byte_ffe51a, r0h
		cmp	#2, r0h
		bne	rts_0b5e2

		jsr	sub_0b1ec

rts_0b5e2:	rts

; ----------------------------------------------

.if level < 0x01000066
sub_0b5fe:	btst	#0, @byte_ffe083
		beq	rts_0af04

		bclr	#0, @byte_ffe083
		jsr	sub_11104

rts_0af04:	rts

; ----------------------------------------------

sub_1114a:	bild	#0, @byte_ffe083
		rts
.endif

; ----------------------------------------------

.if level >= 0x01000066
sub_0b5e4:	set	c
		btst	#0, @byte_ffe083
		beq	rts_0b5fc

		btst	#1, @byte_ffe083
		beq	rts_0b5fc

		clr	c

rts_0b5fc:	rts

; ----------------------------------------------

sub_0b5fe:	bclr	#0, @byte_ffe083
		bclr	#1, @byte_ffe083
		jsr	sub_11140

		jsr	sub_11154

		jsr	sub_11104

		rts

; ----------------------------------------------

sub_0b61c:
.if !type1R
		bld	#2, @byte_ffe562	; 0x03
		bcs	loc_0b62a

		bsr	sub_0b62e

		bra	rts_0b62c

loc_0b62a:	bsr	sub_0b674

rts_0b62c:	rts
.endif

; ----------------------------------------------

sub_0b62e:	bld	#7, r0l
		bcc	rts_0b672

		and	#0x7f, r0l
		cmp	#0x64, r0l
		bhi	rts_0b672

		cmp	#0, r0h
		bne	loc_0b64c

.if !type1R && level >= 0x01020000
		bclr	#2, @byte_ffe083
		mov	r0l, @byte_ffe084
		bra	loc_0b65a

loc_0b64c:	bclr	#3, @byte_ffe083
		mov	r0l, @byte_ffe085

loc_0b65a:	mov	@byte_ffe51a, r0l
		cmp	#2, r0l
		bne	rts_0b672

		mov	@byte_ffe51e, r1h
		cmp	r0h, r1h
.else
		mov	r0l, @byte_ffe084
		mov	@byte_ffe51a, r0h
		cmp	#2, r0h
		bne	rts_0b5c0

		mov	@byte_ffe51e, r0h
		cmp	#0, r0h
		bne	rts_0b5c0

		jsr	sub_0b1ec

rts_0b5c0:
.if type1R
		jsr	sub_1070c
.endif

		bra	rts_0b672

loc_0b64c:	mov	r0l, @byte_ffe085
		mov	@byte_ffe51a, r0h
		cmp	#2, r0h
		bne	rts_0b5c0

		mov	@byte_ffe51e, r0h
		cmp	#1, r0h
.endif

		bne	1f

		jsr	sub_0b1ec

1:
.if type1R && level >= 0x01000066
		jsr	sub_10716
.endif

rts_0b672:	rts

; ----------------------------------------------

.ifeq type1R && level >= 0x01000066
sub_0b674:	bld	#7, r0l
		bcc	rts_0b690

		and	#0x7f, r0l
		cmp	#0x64, r0l
		bhi	rts_0b690

		cmp	#0, r0h
		bne	loc_0b68a

		mov	r0l, @byte_ffe086
		bra	rts_0b690

loc_0b68a:	mov	r0l, @byte_ffe087

rts_0b690:	rts

; ----------------------------------------------

ret24:		bld	#2, @byte_ffe562	; 0x03
		bcs	loc_0b6a4

		mov	@byte_ffe084, r0h
		bra	rts_0b6aa

loc_0b6a4:	mov	@byte_ffe086, r0h

rts_0b6aa:	rts

; ----------------------------------------------

ret25:		bld	#2, @byte_ffe562	; 0x03
		bcs	loc_0b6be

		mov	@byte_ffe085, r0h
		bra	rts_0b6c4

loc_0b6be:	mov	@byte_ffe087, r0h

rts_0b6c4:	rts
.endif
.endif
.endif

; ----------------------------------------------

sub_0b6c6:	mov	@byte_ffe51a, r0l
		cmp	#1, r0l
		bne	rts_0b710

		mov	@byte_ffe51e, r0l
		cmp	r0h, r0l
		beq	rts_0b710

		cmp	#1, r0h
		bhi	rts_0b710

		push	er0
		jsr	sub_0ac42

		pop	er0
		cmp	#0, r0h
		bne	loc_0b700

		bset	#6, @byte_ffff24
		bclr	#5, @byte_ffff24
		bra	rts_0b710

loc_0b700:	bset	#5, @byte_ffff24
		bclr	#6, @byte_ffff24

rts_0b710:	rts

; ----------------------------------------------

sub_0b712:
.ifeq type1R && level < 0x01030069
		push	er0
		mov	@byte_ffe082, r0l
.endif
		cmp	#0, r0h
		bne	loc_0b724

.if type1R && level < 0x01030069
		bild	#0, @byte_ffe082
.else
		bild	#0, r0l
.endif
		bra	loc_0b72e

loc_0b724:	cmp	#1, r0h
		bne	loc_0b72c

.if type1R && level < 0x01030069
		bild	#1, @byte_ffe082
.else
		bild	#1, r0l
.endif
		bra	loc_0b72e

loc_0b72c:	set	c

loc_0b72e:
.ifeq type1R && level < 0x01030069
		pop	er0
.endif
		rts

; ----------------------------------------------

.if level >= 0x01000062
sub_0b734:	cmp	#-1, r0
		beq	loc_0b73c

		shll	r0

loc_0b73c:	mov	r0, @word_ffe088
		mov	#task27o, r0h
		mov	#30000, r1
		jsr	schedBackTaskDelayed

		mov	#task27o, r0h
		jsr	schedBackTask

		rts

; ----------------------------------------------

task27:		mov	@word_ffe088, r1
		cmp	#0, r1
		beq	loc_0b78c

		mov	#task27o, r0h
		jsr	checkSchedTask

		bcc	loc_0b79a

		mov	#task27o, r0h
		mov	#30000, r1
		jsr	schedBackTaskDelayed

		mov	@word_ffe088, r1
		cmp	#-1, r1
		beq	loc_0b790

		dec	#1, r1
		mov	r1, @word_ffe088
		cmp	#0, r1
		bhi	loc_0b79a

loc_0b78c:	jsr	sub_0b5fe

loc_0b790:	mov	#task27o, r0h
		jsr	schedFrontTask

		clr	c
		bra	rts_0b7a2

loc_0b79a:	mov	#task27o, r0h
		jsr	schedFrontTask

		set	c

rts_0b7a2:	rts
.endif

; ----------------------------------------------

sub_0b7a4:	mov	#0, r0h
		bra	loc_0b7ae

sub_0b7a8:	mov	#4, r0h
		bra	loc_0b7ae

sub_0b7ac:	mov	#2, r0h

loc_0b7ae:	mov	r0h, @byte_ffe51f
		mov	#task28o, r0h
		jsr	schedBackTask

		bset	#7, @byte_ffff24:8
		rts

; ----------------------------------------------

sub_0b7c0:	mov	#2, r0h
		mov	r0h, @byte_ffe51f
		inc	r0h
		mov	r0h, @byte_ffff27
		bset	#7, @byte_ffff24:8
		rts

; ----------------------------------------------

task28:		mov	@byte_ffe51f, r0h
		mov	@byte_ffff27, r0l
		cmp	r0h, r0l
		beq	loc_0b826

		push	er0
		mov	#task28o, r0h
		jsr	checkSchedTask

		pop	er0
		bcc	loc_0b822

		cmp	r0l, r0h
		blo	loc_0b7fe

		inc	r0l
		bra	loc_0b800

loc_0b7fe:	dec	r0l

loc_0b800:	mov	r0l, @byte_ffff27
		mov	#0, r0h
		mov	#0, e0
		mov	@(byte_0b838,er0), r0h
		jsr	sub_02018

		mov	#task28o, r0h
		mov	#20, r1
		jsr	schedBackTaskDelayed

loc_0b822:	set	c
		bra	loc_0b82c

loc_0b826:	bclr	#7, @byte_ffff24:8
		clr	c

loc_0b82c:	stc	ccr, r5h
		mov	#task28o, r0h
		jsr	schedFrontTask

		ldc	r5h, ccr
		rts


byte_0b838:	.byte 9, 8, 0, 2, 6, 0

; ----------------------------------------------

sub_0b83e:	mov	@off_00474, er0
		mov	er0, @long_ffebe4
		mov	#0, r0h
		mov	r0h, @byte_ffe520
		mov	r0h, @byte_ffeaac
		mov	r0h, @byte_ffeaad
		mov	r0h, @byte_ffeb46
		mov	r0h, @byte_ffeb47
		mov	#byte_ffeaac, er2
		bset	#2, @er2
		mov	#0x24, r0h
		mov	r0h, @byte_ffeaaf
		mov	#0x25, r0h
		mov	r0h, @byte_ffeb49
		mov	#-1, r0
		mov	r0, @byte_ffebe8
		mov	#-1, r0
		mov	r0, @word_ffeab4
		mov	r0, @word_ffeb4e
		jsr	sub_0cc8c

		jsr	sub_0c1f8

		mov	#2880, r0
		mov	r0, @byte_ffebf4
		rts

; ----------------------------------------------

sub_0b8b6:	btst	#4, @er4
		beq	rts_0b8e4

		mov	@(0x20,er4), r0
		mov	@(6,er4), r1
		cmp	r0, r1
		bls	loc_0b8cc

		sub	r0, r1
		bra	loc_0b8d0

loc_0b8cc:	sub	r1, r0
		mov	r0, r1

loc_0b8d0:	mov	@byte_ffebe8, r0
		cmp	r0, r1
		bls	rts_0b8e4

		mov	@(0x20,er4), r0
		mov	r0, @(6,er4)
		bsr	sub_0b8e6

rts_0b8e4:	rts

; ----------------------------------------------

sub_0b8e6:	push	er4
		mov	@(3,er4), r0h
		jsr	sub_10cc0

		pop	er4
		rts

; ----------------------------------------------

sub_0b8f8:	mov	#byte_ffeaac, er4
		bsr	sub_0c8e6:16

		mov	#byte_ffeb46, er4
		bsr	sub_0c8e6:16

sub_0b90c:	jsr	sub_0c378

		mov	@byte_ffe520, r0h
		cmp	#0x1e, r0h
		blo	loc_0b91e

		jsr	sub_0c1b8

loc_0b91e:	jsr	sub_0c1f8

		rts

; ----------------------------------------------

task29:		mov	@long_ffebec, er4
		mov	@byte_ffe520, r0h
		mov	#off_0b942, er1
		jsr	switch_er1_r0h

		bld	#6, @byte_ffff28:8
		rts


off_0b942:	case  0 sub_0bc82 sub_0bcb6 sub_0bf1a sub_0bd3c
		case  4 sub_0be0a sub_0be38 sub_0bd34 sub_0bf34
		case  8 sub_0bd3c sub_0bf6e sub_0be38 sub_0bf66
		case 12 sub_0bd3c sub_0bfa4 sub_0be38 sub_0bfc8
		case 16 sub_0bfa4 sub_0bf66 sub_0bd3c sub_0bfa4
		case 20 sub_0be38 sub_0bf2c sub_0bd3c sub_0be0a
		case 24 sub_0be38 sub_0bea4 sub_0c088 sub_0c20c
		case 28 sub_0bc94 sub_0c15a sub_0c1ce sub_0c0cc
		case 32 sub_0c12a sub_0c1bc sub_0c0c2 sub_0c12a
		case 36 sub_0c150 sub_0c070 sub_0c0a8 sub_0c0b8

word_0b992:	.word 0x1a09
		.long NULL
		.word 0x36
		.word 0
		.word 0x109
		.long NULL
		.word 0x0c
		.word 0
		.word 0x209
		.long NULL
		.word 0x0e
		.word 0
		.word 0x409
		.long NULL
		.word 0x12
		.word 0
		.word 0x388
		.long NULL
		.word 0x8000
		.word 0
		.word 0x309
		.long NULL
		.word 0x10
		.word 0
		.word 0x1809
		.long NULL
		.word 0x32
		.word 0
		.word 0x1909
		.long NULL
		.word 0x34
		.word 0
		.word 0x1b09
		.long NULL
		.word 0x38
		.word 0
		.word 0x1c09
		.long NULL
		.word 0x3a
		.word 0
		.word 0x200b
		.long sub_0baec
		.word 0x3c
		.word 0x10
		.word 0x210b
		.long sub_0baec
		.word 0x4c
		.word 0x10
		.word 0x220b
		.long sub_0baec
		.word 0x5c
		.word 4
		.word 0x1509
		.long NULL
		.word 0x2c
		.word 0
		.word 0
		.word 0

word_0ba22:	.word 0x2f0b
.if type1R && level < 0x01030071
		.long sub_0baec
.else
		.long sub_0bb3c
.endif
		.word 0x70 - 0x10 & -(type1R && level < 0x01030069)
		.word 0x10
		.long NULL

word_0ba30:	.word 0x3f09
		.long NULL
		.word 0x90 - 0x20 & -(type1R && level < 0x01030069)
		.word 0
		.word 0
		.word 0

word_0ba3e:	.word 9
.if type1R
		.long NULL
.else
		.long sub_0ca36
.endif
		.word 0x0a
		.long 0x809
		.long NULL
		.long 0x140000
		.word 0x909
		.long NULL
		.word 0x16
		.long 0xf09
		.long NULL
		.long 0x200000
		.word 0x1009
		.long NULL
		.word 0x22
		.long 0xa09
		.long NULL
		.long 0x180000
		.word 0x1409
		.long NULL
		.word 0x2a
		.long 0xb09
		.long sub_0bb7e
		.long 0x1a0000
		.word 0x1309
		.long sub_0bc60
		.word 0x28
		.long 0x1209
		.long sub_0bbb4
		.long 0x260000
		.word 0x1109
		.long NULL
		.word 0x24
		.long 0x1609
.if type1R
		.long NULL
.else
		.long sub_0ca10
.endif
		.long 0x2e0000
		.word 0x1709
.if type1R
		.long NULL
.else
		.long sub_0ca52
.endif
		.word 0x30
		.long 0xc09
		.long NULL
		.long 0x1c0000
		.word 0xd09
		.long NULL
		.word 0x1e
.if type1R && level < 0x01030069
		.long 0
.else
		.long 0x230b
		.long sub_0baec
		.long 0x600010
		.word 0x300b
.if type1R && level >= 0x01030069 && level < 0x01030071
		.long sub_0baec
.else
		.long sub_0bb32
.endif
		.word 0x80
		.long 0x100000
.endif
		.word 0

; ----------------------------------------------

sub_0baec:	mov	@i2cBuf02, r0h
		mov	@long_ffebf0, er3
		mov	@(6,er3), r1
		mov	#0, e1
		add	er4, er1
		mov	#byte_ffebf6, er2
		mov	@(9,er3), r0l
		cmp	r0l, r0h
		bls	loc_0bb14

		mov	r0l, r0h

loc_0bb14:	mov	@er2, r3h
		mov	r3h, @er1
		adds	#1, er1
		adds	#1, er2
		dec	r0l
		dec	r0h
		bne	loc_0bb14

		mov	#0, r3h

loc_0bb24:	cmp	#0, r0l
		beq	rts_0bb30

		mov	r3h, @er1
		adds	#1, er1
		dec	r0l
		bra	loc_0bb24

rts_0bb30:	rts

; ----------------------------------------------

.ifeq type1R && level < 0x01030071
sub_0bb32:	btst	#0, @er4
		beq	rts_0bb3a

		bsr	sub_0baec

rts_0bb3a:	rts

; ----------------------------------------------

sub_0bb3c:	bsr	sub_0baec

		mov	#long_00b42, er1
		mov	@(0x71,er4), r2h
		mov	@(0x72,er4), r2l
		mov	@(0x73,er4), r0h
		mov	@(0x74,er4), r0l
		mov	r2, e0

loc_0bb56:	mov	@er1+, er2
		beq	loc_0bb64

		cmp	er2, er0
		bne	loc_0bb56

		clr	c
		bra	loc_0bb66

loc_0bb64:	set	c

loc_0bb66:	bst	#0, @er4
		rts

; ----------------------------------------------

sub_0bb6c:
.if level >= 0x01050000
		push	er4
.endif
		jsr	sub_0c378

		btst	#0, @er4
.if level >= 0x01050000
		pop	er4
.endif
		rts
.endif

; ----------------------------------------------

sub_0bb7e:	bsr	sub_0c87e:16

		mov	@(0x94 - 0x20 & -(type1R && level < 0x01030069),er4), er1
		mov	e1, r0
		btst	#5, r0h
		bne	loc_0bba2

		exts	e1
		mov	r0h, r2l
		and	#0x1f, r2l
		beq	loc_0bb9e

		mov	#0, r2h
		divxs	r2, er1
		bra	loc_0bba0

loc_0bb9e:	zero	r1

loc_0bba0:	bra	loc_0bbae

loc_0bba2:	mov	@byte_ffebf6, r1l
		mov	@byte_ffebf7, r1h

loc_0bbae:	mov	r1, @(0x1a,er4)
		rts

; ----------------------------------------------

sub_0bbb4:	mov	#0, r3
		mov	@(0x94 - 0x20 & -(type1R && level < 0x01030069),er4), er1
		mov	e1, r0
		btst	#7, r0h
		beq	loc_0bc10

		mov	@(0x1a,er4), r1
		bpl	loc_0bbf2

		beq	loc_0bbf2

		neg	r1
		mov	@(0x10,er4), r0h
		btst	#7, r0h
		beq	loc_0bbe2

		mov	@(0x16,er4), r2
		mulxu	r2, er1
		mov	#10000, r2
		divxu	r2, er1

loc_0bbe2:	mov	r1, r3
		mov	@(0x20,er4), r2
		mov	#60, r0
		mulxu	r0, er2
		divxu	r1, er2
		bra	loc_0bbf6

loc_0bbf2:	mov	#-1, r2

loc_0bbf6:	mov	@(0x94 - 0x20 & -(type1R && level < 0x01030069),er4), er1
		mov	e1, r0
		btst	#5, r0h
		beq	loc_0bc0e

		mov	@byte_ffebf6, r2l
		mov	@byte_ffebf7, r2h

loc_0bc0e:	bra	loc_0bc14

loc_0bc10:	mov	#-1, r2

loc_0bc14:	cmp	#-1, r2
		beq	loc_0bc24

		cmp	#2880, r2
		bls	loc_0bc24

		mov	#2880, r2

loc_0bc24:	mov	r2, @(0x26,er4)
		mov	r2, @(0x98 - 0x20 & -(type1R && level < 0x01030069),er4)
		cmp	#0, r3
		beq	rts_0bc5e

		mov	r3, r1
		mov	#byte_ffeb46, er3
		cmp	#byte_ffeaac, er4
		beq	loc_0bc48

		mov	#byte_ffeaac, er3

loc_0bc48:	btst	#4, @er3
		beq	rts_0bc5e

		mov	@(0x20,er3), r2
		mov	#0x3c, r0
		mulxu	r0, er2
		divxu	r1, er2
		mov	r2, @(0x98 - 0x20 & -(type1R && level < 0x01030069),er3)

rts_0bc5e:	rts

; ----------------------------------------------

sub_0bc60:	mov	@byte_ffebf6, r1l
		mov	@byte_ffebf7, r1h
		cmp	#-1, r1
		beq	loc_0bc7c

		cmp	#2880, r1
		bls	loc_0bc7c

		mov	#2880, r1

loc_0bc7c:	mov	r1, @(0x28,er4)
		rts

; ----------------------------------------------

sub_0bc82:	mov	#byte_ffeaac, er0
		mov	er0, @long_ffebec
		jmp	sub_0c0d8

; ----------------------------------------------

sub_0bc94:	btst	#2, @er4
		beq	loc_0bcb0

		mov	#byte_ffeb46, er0
		mov	er0, @long_ffebec
		mov	#1, r0h
		jsr	sub_0c152

		bra	rts_0bcb4

loc_0bcb0:	jsr	sub_0c0d8

rts_0bcb4:	rts

; ----------------------------------------------

sub_0bcb6:	push	er4
		mov	#0, r0h
		bild	#2, @er4
		bst	#0, r0h
		jsr	sub_0db7a

		pop	er4
		bcs	loc_0bd2a

		btst	#5, @er4
		bne	loc_0bce4

		push	er4
		mov	@(0x92 - 0x20 & -(type1R && level < 0x01030069),er4), r0
		jsr	sub_016e4

		pop	er4
		bcc	loc_0bd2a

loc_0bce4:	btst	#4, @er4
		beq	loc_0bcfe

		btst	#5, @er4
		beq	loc_0bcf6

		jsr	sub_0c0d8

		bra	loc_0bcfc

loc_0bcf6:	mov	#0x15, r0h
		jsr	sub_0c152

loc_0bcfc:	bra	loc_0bd28

loc_0bcfe:	bclr	#6, @er4
		mov	#0, r0
		mov	r0, @(0x36,er4)
		mov	#0x10, r1h
		mov	er4, er2
		add	#0x70 - 0x10 & -(type1R && level < 0x01030069), er2

loc_0bd14:	mov	r0h, @er2
		adds	#1, er2
		dec	r1h
		bne	loc_0bd14

		mov	#0, r0
		mov	r0, @(0x90 - 0x20 & -(type1R && level < 0x01030069),er4)
		jsr	sub_0c0d8

loc_0bd28:	bra	rts_0bd32

loc_0bd2a:	mov	#0x1b, r0h
		jsr	sub_0c152

		set	c

rts_0bd32:	rts

; ----------------------------------------------

sub_0bd34:	bclr	#5, @er4
		jmp	sub_0c0d8

; ----------------------------------------------

sub_0bd3c:	push	er4
		btst	#2, @er4
		beq	loc_0bd4a

		mov	#1, r2h
		bra	loc_0bd4c

loc_0bd4a:	mov	#2, r2h

loc_0bd4c:	mov	@long_ffebf0, er5
		mov	@er5, r6
		push	er6
		mov	#0, r2l
		mov	@(0x37,er4), r6h
		and	#0xf0, r6h
		cmp	#0x30, r6h
		bne	loc_0bd68

		mov	#1, r2l

loc_0bd68:	pop	er6
.ifeq type1R && level < 0x01030071
		cmp	#0x300b, r6
		bne	loc_0bd88

		btst	#0, @er4
		bne	loc_0bd88

		mov	@byte_ffe520, r0h
		inc	r0h
		mov	r0h, @byte_ffe520
		bra	loc_0be02
.endif

loc_0bd88:	mov	r6h, r4h
		mov	r6l, r3h
		and	#0x1f, r3h
		btst	#7, r6l
		beq	loc_0bda2

		mov	@(6,er5), r6
		mov	r6l, @byte_ffebf6
		mov	r6h, @byte_ffebf7

loc_0bda2:	mov	#i2cBuf, er6
		btst	#7, @er6		; i2c00o
		bne	loc_0bdfe

		mov	r3h, @(i2c03o:16,er6)
		mov	#0x16, r5h
		mov	r5h, @(i2c05o:16,er6)
		mov	r4h, @(i2c06o:16,er6)
		mov	#byte_ffebf6, er5
		mov	er5, @(i2c08o:16,er6)
		mov	#0x18, r5h
		mov	r5h, @(i2c02o:16,er6)
		mov	#0, er5
		mov	er5, @(i2c12o:16,er6)
		mov	#200, r5h
		mov	r5h, @(i2c20o:16,er6)
		cmp	#0, r2l
		beq	loc_0bde6

		bset	#4, r2h

loc_0bde6:	mov	r2h, @(i2c00o:16,er6)
.if level >= 0x01000062
		mov	#0, r2h
		mov	r2h, @(i2c01o:16,er6)
.endif
		mov	er6, er0
		mov	#0, r1h
		mov	r1h, @(i2c04o:16,er0)
		jsr	enqueueI2Ccmd

		bra	loc_0be02

loc_0bdfe:	mov	#0x1a, r0h
		set	c

loc_0be02:	pop	er4
		bra	sub_0c0d8:16

; ----------------------------------------------

sub_0be0a:	btst	#6, @i2cBuf00
		beq	rts_0be36

		mov	@i2cBuf04, r0h
		cmp	#0, r0h
		beq	loc_0be32

		jsr	sub_0c0f8

		bcc	loc_0be28

		mov	#0x1b, r0h
		bra	loc_0be2a

loc_0be28:	mov	#0x22, r0h

loc_0be2a:	jsr	sub_0c152

		clr	c
		bra	rts_0be36

loc_0be32:	jsr	sub_0c0d8

rts_0be36:	rts

; ----------------------------------------------

sub_0be38:	mov	@long_ffebf0, er3
		mov	@er3, r0
		btst	#7, r0l
		bne	loc_0be74

		mov	@(2,er3), er0
		beq	loc_0be52

		jsr	@er0

		bra	loc_0be74

loc_0be52:	mov	@(6,er3), r0
		beq	loc_0be74

		mov	#0, e0
		add	er4, er0
		mov	@byte_ffebf6, r1l
		mov	@byte_ffebf7, r1h
		set	i
		mov	r1h, @er0
		mov	r1l, @(1,er0)
		clr	i

loc_0be74:	mov	@long_ffebf0, er3
		add	#0x0a, er3
		mov	@er3, r0
		bne	loc_0be8c

		jsr	sub_0c0d8

		bra	loc_0bea0

loc_0be8c:	mov	er3, @long_ffebf0
		mov	@byte_ffe520, r0h
		add	#0xfe, r0h
		jsr	sub_0c152

loc_0bea0:	clr	c
		rts

; ----------------------------------------------

sub_0bea4:	bclr	#7, @er4
		btst	#4, @er4
		bne	loc_0bef8

		bset	#4, @er4
		push	er4
		mov	#0, r0h
		bld	#2, @er4
		bist	#0, r0h
		jsr	rts_0b4a4

		pop	er4
		jsr	sub_0c344

		mov	@(0x20,er4), r0
		mov	r0, @(6,er4)
		jsr	sub_0c794

		push	er4
		jsr	sub_0b4d8

		jsr	sub_0d8d6

		pop	er4
		jsr	sub_0c602

		mov	r0h, @(4,er4)
		mov	@(0x20,er4), r0
		mov	r0, @(6,er4)
		bra	loc_0bf04

loc_0bef8:	jsr	sub_0c32e

		jsr	sub_0c798

		bsr	sub_0b8b6:16

loc_0bf04:	mov	@(0x22,er4), r1
		mov	@(0x20,er4), r0
		bsr	sub_0c48a:16

		mov	r0, @(0x1e,er4)
		jsr	sub_0c0d8

		rts

; ----------------------------------------------

sub_0bf1a:	mov	#word_0b992, er0

loc_0bf20:	mov	er0, @long_ffebf0
		jmp	sub_0c0d8


sub_0bf2c:	mov	#word_0ba3e, er0
		bra	loc_0bf20

; ----------------------------------------------

sub_0bf34:	mov	@(0x37,er4), r0h
		and	#0xf0, r0h
		cmp	#0x30, r0h
		bne	loc_0bf5e

		mov	@(0x4c,er4), r0h
		mov	@(0x4d,er4), r0l
		mov	@(0x4e,er4), r1h
		cmp	#0x49, r0h
		bne	loc_0bf5e

		cmp	#0x42, r0l
		bne	loc_0bf5e

		cmp	#0x4d, r1h
		bne	loc_0bf5e

		mov	#word_0ba22, er0
		bra	loc_0bf20

loc_0bf5e:	mov	#0x15, r0h
		jsr	sub_0c152

		rts

; ----------------------------------------------

sub_0bf66:	mov	#word_0ba30, er0
		bra	loc_0bf20

; ----------------------------------------------

sub_0bf6e:	btst	#6, @i2cBuf00
		beq	rts_0bfa2

		mov	@i2cBuf04, r0h
		cmp	#0, r0h
		beq	loc_0bf9a

		cmp	#0x1f, r0h
		bne	loc_0bf8c

		jsr	sub_0c0f8

		bcc	loc_0bf90

loc_0bf8c:	mov	#0x1b, r0h
		bra	loc_0bf92

loc_0bf90:	mov	#0x22, r0h

loc_0bf92:	jsr	sub_0c152

		clr	c
		bra	rts_0bfa2

loc_0bf9a:	bset	#6, @er4
		jsr	sub_0c0d8

rts_0bfa2:	rts

; ----------------------------------------------

sub_0bfa4:	btst	#6, @i2cBuf00
		beq	rts_0bfc6

		mov	@i2cBuf04, r0h
		cmp	#0, r0h
		beq	loc_0bfc2

		mov	#0x15, r0h
		jsr	sub_0c152

		clr	c
		bra	rts_0bfc6

loc_0bfc2:	jsr	sub_0c0d8

rts_0bfc6:	rts

; ----------------------------------------------

sub_0bfc8:	mov	@(0x90 - 0x20 & -(type1R && level < 0x01030069),er4), r0
		bne	loc_0bfec

		push	er4
		jsr	sub_06db2

		pop	er4
		bcs	loc_0bfec

		push	er4
		bsr	sub_0bff6

		pop	er4
		jsr	sub_0c0d8

		bra	loc_0bff2

loc_0bfec:	mov	#0x15, r0h
		jsr	sub_0c152

loc_0bff2:	set	c
		rts

; ----------------------------------------------

sub_0bff6:	btst	#2, @er4
		beq	loc_0c000

		mov	#1, r2h
		bra	loc_0c002

loc_0c000:	mov	#2, r2h

loc_0c002:	mov	r0l, @byte_ffebf6
		mov	r0h, @byte_ffebf7
		mov	#i2cBuf, er6
		btst	#7, @er6		; i2c00o
		bne	loc_0c06a

		mov	#8, r5h
		mov	r5h, @(i2c03o:16,er6)
		mov	#0x16, r5h
		mov	r5h, @(i2c05o:16,er6)
		mov	#0x3f, r5h
		mov	r5h, @(i2c06o:16,er6)
		mov	#byte_ffebf6, er5
		mov	er5, @(i2c08o:16,er6)
		mov	#0x18, r5h
		mov	r5h, @(i2c02o:16,er6)
		mov	#0, er5
		mov	er5, @(i2c12o:16,er6)
		mov	#200, r5h
		mov	r5h, @(i2c20o:16,er6)
		bset	#4, r2h
		mov	r2h, @(i2c00o:16,er6)
.if level >= 0x01000062
		mov	#0, r2h
		mov	r2h, @(i2c01o:16,er6)
.endif
		mov	er6, er0
		mov	#0, r1h
		mov	r1h, @(i2c04o:16,er0)
		jsr	enqueueI2Ccmd

		bra	rts_0c06e

loc_0c06a:	mov	#0x1a, r0h
		set	c

rts_0c06e:	rts

; ----------------------------------------------

sub_0c070:	push	er4
		mov	#0, r0
.if level >= 0x01000062
		bsr	sub_0bff6:16
.else
		bsr	sub_0bff6
.endif

		pop	er4
		jsr	sub_0c0d8

		set	c
		rts

; ----------------------------------------------

sub_0c088:	btst	#4, @er4
		beq	loc_0c0a0

		btst	#3, @er4
		beq	loc_0c0a0

		bclr	#3, @er4
		mov	#0x25, r0h
		jsr	sub_0c152

		bra	loc_0c0a4

loc_0c0a0:	jsr	sub_0c0d8

loc_0c0a4:	set	c
		rts

; ----------------------------------------------

sub_0c0a8:	btst	#6, @i2cBuf00
		beq	rts_0c0b6

		jsr	sub_0c0d8

rts_0c0b6:	rts

; ----------------------------------------------

sub_0c0b8:	mov	#0x11, r0h
		jsr	sub_0c152

		set	c
		rts

; ----------------------------------------------

sub_0c0c2:	bset	#6, @byte_ffff28:8
		mov	#30, r1
		bra	loc_0c0d6

sub_0c0cc:	mov	#2000, r1
		bra	loc_0c0d6

		mov	#4000, r1

loc_0c0d6:	bsr	sub_0c0e8

; ----------------------------------------------

sub_0c0d8:	mov	@byte_ffe520, r0h
		inc	r0h
		mov	r0h, @byte_ffe520
		rts

; ----------------------------------------------

sub_0c0e8:	push	er4
		mov	#task29o, r0h
		jsr	schedBackTaskDelayed

		pop	er4
		rts

; ----------------------------------------------

sub_0c0f8:	mov	@(1,er4), r0l
		inc	r0l
		mov	r0l, @(1,er4)
		cmp	#4, r0l
		blo	loc_0c11a

		push	er4
		jsr	sub_0c410

		pop	er4
		bset	#7, @er4
		set	c
		bra	rts_0c128

loc_0c11a:	cmp	#0x18, r0h
		bne	loc_0c126

		bset	#7, @er4
		set	c
		bra	rts_0c128

loc_0c126:	clr	c

rts_0c128:	rts

; ----------------------------------------------

sub_0c12a:	push	er4
		mov	#task29o, r0h
		jsr	checkSchedTask

		pop	er4
		bcc	loc_0c140

		jsr	sub_0c0d8

		bra	rts_0c14e

loc_0c140:	push	er4
		mov	#task29o, r0h
		jsr	schedFrontTask

		pop	er4

rts_0c14e:	rts

; ----------------------------------------------

sub_0c150:	mov	#1, r0h

; ----------------------------------------------

sub_0c152:	mov	r0h, @byte_ffe520
		rts

; ----------------------------------------------

sub_0c15a:	bsr	sub_0c1b8

		push	er4
		jsr	sub_01276

		bcc	loc_0c1ae

		jsr	sub_074d0

		bcc	loc_0c1ae

		mov	#byte_ffeaac, er4
		jsr	sub_0c2ee

		push	er0
		mov	#byte_ffeb46, er4
		jsr	sub_0c2ee

		pop	er1
		cmp	r1h, r0h
		bhs	loc_0c18e

		mov	r1h, r0h

loc_0c18e:	cmp	#3, r0h
		bhi	loc_0c198

		mov	#0x3c, r0
		bra	loc_0c19c

loc_0c198:	mov	#3600, r0

loc_0c19c:	mov	@word_ffe9be, r1
		add	r1, r0
		mov	r0, @word_ffebea
		mov	#0x1e, r0h
		bra	loc_0c1b0

loc_0c1ae:	mov	#0x1f, r0h

loc_0c1b0:	bsr	sub_0c152

		pop	er4
		rts

; ----------------------------------------------

sub_0c1b8:	bclr	#6, @byte_ffff28:8

sub_0c1bc:	mov	#0, r0h
		mov	r0h, @byte_ffeaad
		mov	r0h, @byte_ffeb47
		bsr	sub_0c152

		rts

; ----------------------------------------------

sub_0c1ce:	push	er4
		mov	@word_ffebea, r0
		jsr	sub_016e4

		bcs	loc_0c1ea

		jsr	sub_074d0

		bcc	loc_0c1ea

		jsr	sub_07238

		bcc	loc_0c1f2

loc_0c1ea:	mov	@sp, er4		; pop+push er4
		jsr	sub_0c0d8

loc_0c1f2:	pop	er4
		rts

; ----------------------------------------------

sub_0c1f8:	mov	@word_ffe9be, r0
		mov	r0, @word_ffeb3e
		mov	r0, @word_ffebd8
		rts

; ----------------------------------------------

sub_0c20c:	btst	#4, @er4
.if type1R
		beq	loc_0c29c
.else
		beq	loc_0c29c:16

		btst	#0, @byte_ffe10a
		beq	loc_0c22a

		bclr	#0, @byte_ffe10a
		jsr	sub_0cb0a
.endif

loc_0c22a:	push	er4
		mov	@(0x92 - 0x20 & -(type1R && level < 0x01030069),er4), r0
		jsr	sub_016e4

		pop	er4
		bcc	loc_0c29a

		push	er4
		mov	#0, r0h
		bld	#2, @er4
		bist	#0, r0h
		jsr	sub_0b42e

		pop	er4
		cmp	#0, r0h
		bne	loc_0c28a

		bsr	sub_0c2aa

		bcc	loc_0c25e

		mov	#0, r0
		bra	loc_0c288

loc_0c25e:	mov	#0, r0
		mov	r0, @(0x1a,er4)
		mov	r0, @(0x18,er4)
		jsr	sub_0c53a

		bld	#2, r0h
		bor	#4, r0l
		bcc	loc_0c27a

		mov	#0x78, r0
		bra	loc_0c288

loc_0c27a:	btst	#4, r0h
		beq	loc_0c284

		mov	#1, r0
		bra	loc_0c288

loc_0c284:	mov	#5400, r0

loc_0c288:	bra	loc_0c28e

loc_0c28a:	mov	#0, r0

loc_0c28e:	mov	@word_ffe9be, r1
		add	r1, r0
		mov	r0, @(0x92 - 0x20 & -(type1R && level < 0x01030069),er4)

loc_0c29a:	bra	loc_0c2a6

loc_0c29c:	mov	@word_ffe9be, r0
		mov	r0, @(0x92 - 0x20 & -(type1R && level < 0x01030069),er4)

loc_0c2a6:	jmp	sub_0c0d8

; ----------------------------------------------

sub_0c2aa:	mov	@(0x1a,er4), r0
		mov	#0x14, r1
		cmp	r1, r0
		bgt	loc_0c2ea

		mov	#0xffec, r1
		cmp	r1, r0
		ble	loc_0c2ea

		mov	@(0x26,er4), r0
		mov	#-1, r1
		cmp	r1, r0
		bne	loc_0c2ea

		mov	@(0x28,er4), r0
		cmp	r1, r0
		bne	loc_0c2ea

		mov	@(0x18,er4), r0
		mov	#0x32, r1
		cmp	r1, r0
		bgt	loc_0c2ea

		mov	#0xff9c, r1
		cmp	r1, r0
		ble	loc_0c2ea

		clr	c
		bra	rts_0c2ec

loc_0c2ea:	set	c

rts_0c2ec:	rts

; ----------------------------------------------

sub_0c2ee:	mov	@(0x22,er4), r1
		mov	@(0x20,er4), r0
		jsr	sub_0c48a

		mov	@(0x20,er4), r1
		mov	@long_ffebe4, er2
		mov	@er2, r3h
		adds	#2, er2
		mov	#0, r3l

loc_0c30c:	mov	@er2+, er5
		cmp	#-1, e5
		beq	loc_0c31a

		cmp	e5, r1
		bls	loc_0c32a

loc_0c31a:	cmp	#-1, r5
		beq	loc_0c324

		cmp	r5, r0
		bls	loc_0c32a

loc_0c324:	inc	r3l
		dec	r3h
		bne	loc_0c30c

loc_0c32a:	mov	r3l, r0h
		rts

; ----------------------------------------------

sub_0c32e:	jsr	sub_0c2ee

		mov	@(2,er4), r0l
		cmp	r0h, r0l
		beq	rts_0c342

		mov	r0h, @(2,er4)
		jsr	sub_0b8e6

rts_0c342:	rts

; ----------------------------------------------

sub_0c344:	mov	#-1, r0h
		mov	r0h, @(2,er4)
		bra	sub_0c32e

; ----------------------------------------------

		push	er4
		jsr	sub_0c378

		bsr	sub_0c344

		pop	er4
		rts

; ----------------------------------------------

sub_0c35c:	push	er0
		jsr	sub_0db7a

		pop	er0
		bcs	loc_0c374

		jsr	sub_0c378

		jsr	sub_0c53a

		bra	rts_0c376

loc_0c374:	zero	r0

rts_0c376:	rts

; ----------------------------------------------

sub_0c378:	cmp	#1, r0h
		beq	loc_0c384

		mov	#byte_ffeaac, er4
		bra	rts_0c38a

loc_0c384:	mov	#byte_ffeb46, er4

rts_0c38a:	rts

; ----------------------------------------------

sub_0c38c:	push	er4
		push	er1
		bsr	sub_0c378

		bild	#4, @er4
		bcs	loc_0c3c2

		mov	@(2,er4), r0l
		cmp	#4, r0l
		bls	loc_0c3bc

		mov	@long_ffebe4, er4
		mov	@er4, r0h
		dec	r0h
		cmp	r0h, r0l
		blo	loc_0c3b8

		mov	#5, r0h
		bra	loc_0c3ba

loc_0c3b8:	mov	#4, r0h

loc_0c3ba:	bra	loc_0c3be

loc_0c3bc:	mov	r0l, r0h

loc_0c3be:	clr	c
		bra	loc_0c3c8

loc_0c3c2:	mov	#0, r0h
		mov	r0h, r0l
		set	c

loc_0c3c8:	pop	er1
		pop	er4
		rts

; ----------------------------------------------

sub_0c3d2:	cmp	#-1, r0h
		bne	loc_0c3e8

		mov	@byte_ffeaac, r0h
		bild	#4, r0h
		mov	@byte_ffeb46, r0h
		biand	#4, r0h
		bra	rts_0c3fe

loc_0c3e8:	cmp	#1, r0h
		bne	loc_0c3f6

		mov	@byte_ffeb46, r0h
		bild	#4, r0h
		bra	rts_0c3fe

loc_0c3f6:	mov	@byte_ffeaac, r0h
		bild	#4, r0h

rts_0c3fe:	rts

; ----------------------------------------------

sub_0c400:	push	er4
		jsr	sub_0c378

		bsr	sub_0c410

		pop	er4
		rts

; ----------------------------------------------

sub_0c410:	bclr	#7, @er4
		bld	#4, @er4
		bclr	#4, @er4
		bcc	rts_0c42a

		mov	#0, r0h
		bld	#2, @er4
		bist	#0, r0h
		jsr	rts_0b4a4
rts_0c42a:	rts

; ----------------------------------------------

sub_0c42c:	push	er4
		jsr	sub_0c378

		bild	#4, @er4
		bcs	loc_0c440

		jsr	sub_0c5e0

		clr	c

loc_0c440:	pop	er4
		rts

; ----------------------------------------------

sub_0c446:	push	er4
		jsr	sub_0c378

		bild	#4, @er4
		bcs	loc_0c45a

		mov	@(0x1a,er4), r0
		clr	c

loc_0c45a:	pop	er4
		rts

; ----------------------------------------------

sub_0c460:	jsr	sub_0c378

		btst	#4, @er4
		beq	loc_0c478

		mov	@(0x22,er4), r1
		mov	@(0x20,er4), r0
		bsr	sub_0c47e

		clr	c
		bra	rts_0c47c

loc_0c478:	mov	#0, r0h
		set	c

rts_0c47c:	rts

; ----------------------------------------------

sub_0c47e:	bsr	sub_0c48a

		mov	r0l, r0h
		cmp	#100, r0h
		bls	rts_0c488

		mov	#100, r0h

rts_0c488:	rts

; ----------------------------------------------

sub_0c48a:	mov	#100, r2
		mulxu	r2, er0
		divxu	r1, er0
		mov	e0, r2
		beq	rts_0c498

		inc	#1, r0

rts_0c498:	rts

; ----------------------------------------------

sub_0c49a:	push	er6
		mov	#0x20, r5h
		mov	#0, r0
		mov	r0, r4
		mov	r0, r6

loc_0c4a8:	shll	r2l
		rotxl	r2h
		rotxl	r3l
		rotxl	r3h
		rotxl	r4l
		rotxl	r4h
		shll	r0l
		rotxl	r0h
		rotxl	r6l
		rotxl	r6h
		cmp	r1, r4
		blo	loc_0c4c4

		sub	r1, r4
		bset	#0, r0l

loc_0c4c4:	dec	r5h
		bne	loc_0c4a8

		mov	#0, r2
		cmp	r6, r2
		mov	r6, r1
		pop	er6
		rts

; ----------------------------------------------

		mov	#60, r1h
		bra	loc_0c4dc

		mov	#100, r1h

loc_0c4dc:	mov	r0l, r2l
		mulxu	r1h, r2
		mov	r0h, r3l
		mulxu	r1h, r3
		add	r3l, r2h
		addx	#0, r3h
		mov	r3h, r3l
		mov	#0, r3h
		rts

; ----------------------------------------------

sub_0c4ee:	mulxu	r1, er0
		mov	e0, r1
		rts

; ----------------------------------------------

		bsr	sub_0c4fc

		jsr	sub_0c47e

		rts

; ----------------------------------------------

sub_0c4fc:	mov	#byte_ffeaac, er0
		btst	#4, @er0
		beq	loc_0c516

		mov	@word_ffeace, r1
		mov	@word_ffeacc, r0
		bra	loc_0c51c

loc_0c516:	mov	#0, r1
		mov	r1, r0

loc_0c51c:	mov	#byte_ffeb46, er2
		btst	#4, @er2
		beq	rts_0c538

		mov	@word_ffeb68, r2
		add	r2, r1
		mov	@word_ffeacc, r2
		add	r2, r0

rts_0c538:	rts

; ----------------------------------------------

sub_0c53a:	mov	#0, r0
		push	er1
		push	er2
		push	er3
		btst	#4, @er4
		beq	loc_0c5b0

		mov	@(0x2e,er4), r1
		bld	#7, r1h
		bor	#6, r1h
		bor	#4, r1h
		bcs	loc_0c576

		btst	#6, @er4
		beq	loc_0c576

		mov	@(0x2a,er4), r2
		beq	loc_0c576

		mov	#500, r3
		cmp	r3, r2
		blo	loc_0c574

		bset	#2, r0h
		bra	loc_0c576

loc_0c574:	bset	#4, r0l

loc_0c576:	bld	#4, r1h
		bst	#4, r0h
		bld	#3, r1h
		bst	#7, r0l
		btst	#6, @er4
		beq	loc_0c5ac

		mov	@(0x0a,er4), r1
		bld	#1, r1l
		bst	#5, r0h
		bld	#0, r1l
		bst	#0, r0h
.ifeq type1R && level < 0x01030069
		push	er4
		push	r0
		mov	#0, r0h
		bld	#2, @er4
		bist	#0, r0h
		jsr	sub_0b712

		pop	r0
		biand	#0, r0h
		bist	#0, r0h
		pop	er4
.endif

loc_0c5ac:	clr	c
		bra	loc_0c5d2

loc_0c5b0:	btst	#7, @er4
		beq	loc_0c5cc

		mov	#0, r0h
		bld	#2, @er4
		bist	#0, r0h
		jsr	sub_0b712

		mov	#0, r0
		bist	#0, r0h
		clr	c
		bra	loc_0c5d2

loc_0c5cc:	mov	#0, r0
		set	c

loc_0c5d2:	pop	er3
		pop	er2
		pop	er1
		rts

; ----------------------------------------------

sub_0c5e0:	mov	@(0x16,er4), r0
		mov	#0x0a, r1
		mov	#0, e0
		divxu	r1, er0
		rts

; ----------------------------------------------

sub_0c5f0:	mov	@(0x14,er4), r0
		mov	#2730, r1
		sub	r1, r0
		mov	#10, r1h
		divxu	r1h, r0
		mov	r0l, r0h
		rts

; ----------------------------------------------

sub_0c602:	mov	#0x5c, er0
		add	er4, er0
		push	er4
		push	er0
		mov	#off_0c65a, er1

loc_0c618:	mov	@er1, er2
		bne	loc_0c622

		mov	#0, r0h
		bra	loc_0c650

loc_0c622:	mov	@(4,er1), r3l
		mov	@sp, er0		; pop+push er0

loc_0c62a:	mov	@er2+, r4h
		mov	@er0+, r4l
		cmp	#0x61, r4l
		blo	loc_0c638

		cmp	#0x7a, r4l
		bhi	loc_0c638

		add	#0xe0, r4l

loc_0c638:	cmp	r4h, r4l
		bne	loc_0c640

		dec	r3l
		bne	loc_0c62a

loc_0c640:	bne	loc_0c648

		mov	@(5,er1), r0h
		bra	loc_0c650

loc_0c648:	add	#6, er1
		bra	loc_0c618

loc_0c650:	pop	er4
		pop	er4
		rts


off_0c65a:	.long nimh			; "NIMH"
		.word 1024
		.long lion			; "LION"
		.word 1025
		.long lip_			; "LIP"
		.word 771
		.long pbac			; "PBAC"
		.word 1028
		.long nicd			; "NICD"
		.word 1029
		.long nizn			; "NIZN"
		.word 1030
		.long ram_			; "RAM"
		.word 775
		.long znar			; "ZNAR"
		.word 1032
		.long NULL

nimh:		.ascii "NIMH"
lion:		.ascii "LION"
pbac:		.ascii "PBAC"
nicd:		.ascii "NICD"
nizn:		.ascii "NIZN"
ram_:		.ascii "RAM"
znar:		.ascii "ZNAR"
lip_:		.ascii "LIP"

; ----------------------------------------------

sub_0c6ac:	mov	@byte_ffebf4, r0
		rts

; ----------------------------------------------

sub_0c6b4:	mov	#0x8000, r1
		cmp	r1, r0
		blo	loc_0c6c0

		mov	#0x7fff, r0

loc_0c6c0:	mov	r0, @byte_ffebf4
		rts

; ----------------------------------------------

sub_0c6c8:	jsr	sub_0c378

		bild	#4, @er4
		bcs	loc_0c6d8

		mov	@(0x20,er4), r0
		bra	rts_0c6dc

loc_0c6d8:	mov	#0, r0

rts_0c6dc:	rts

; ----------------------------------------------

		mov	#0, r0h
		bsr	sub_0c6fc

		push	er0
		mov	#1, r0h
		bsr	sub_0c6fc

		pop	er1
		shll	r0h
		shll	r0h
		shll	r0h
		shll	r0h
		or	r1h, r0h
		clr	c
		rts

; ----------------------------------------------

sub_0c6fc:	push	er0
		jsr	sub_0c378

		bild	#4, @er4
		biand	#7, @er4
		pop	er0
		bcs	loc_0c72a

		jsr	sub_0b42e

		and	#3, r0h
		mov	#byte_0c72e, er1
		add	r0h, r1l
		addx	#0, r1h
		bcc	loc_0c726

		inc	#1, e1

loc_0c726:	mov	@er1, r0h
		bra	rts_0c72c

loc_0c72a:	mov	#0, r0h

rts_0c72c:	rts


byte_0c72e:	.byte 5, 7, 13, 5

; ----------------------------------------------

		mov	r0h, r2h
		mov	r0l, r0h
		mov	r2h, r0l
		rts

; ----------------------------------------------

		jsr	sub_0c378

		jsr	sub_0c53a

		rts

; ----------------------------------------------

loc_0c744:	push	er1
		jsr	sub_0c378

		pop	er1
		btst	#4, @er4
		beq	loc_0c75c

		jsr	@er1

		clr	c
		bra	rts_0c762

loc_0c75c:	mov	#-1, r0
		set	c

rts_0c762:	rts


sub_0c764:	mov	#sub_0c5f0, er1
		bra	loc_0c744

; ----------------------------------------------

sub_0c76c:	jsr	sub_0c378

		btst	#4, @er4
		beq	loc_0c780

		jsr	sub_0c53a

		mov	r0l, r0h
		clr	c
		bra	rts_0c782

loc_0c780:	set	c

rts_0c782:	rts


loc_0c784:	push	er1
		jsr	sub_0c378

		pop	er1
		mov	r1, @(8,er4)

sub_0c794:	mov	#-1, r0h
		bra	loc_0c79a

sub_0c798:	mov	#0, r0h

loc_0c79a:	btst	#4, @er4
		beq	rts_0c7dc

		mov	@(0x20,er4), r1
		mov	@(8,er4), r2
		mov	#-1, r3
		cmp	r2, r3
		beq	rts_0c7dc

		cmp	r2, r1
		bhs	loc_0c7b8

		set	c
		bra	loc_0c7ba

loc_0c7b8:	clr	c

loc_0c7ba:	bxor	#1, @er4
		bcc	rts_0c7dc

		bld	#1, @er4
		bist	#1, @er4
		cmp	#0, r0h
		bne	rts_0c7dc

		push	er4
		mov	@(3,er4), r0h
		jsr	sub_10cc0

		pop	er4

rts_0c7dc:	rts

; ----------------------------------------------

sub_0c7de:	push	er4
		jsr	sub_0c378

		bild	#4, @er4
		bcs	loc_0c7f4

		mov	@(0x18,er4), r0
		clr	c
		bra	loc_0c7fa

loc_0c7f4:	mov	#0, r0
		set	c

loc_0c7fa:	pop	er4
		rts

; ----------------------------------------------

sub_0c800:	push	er4
		jsr	sub_0c378

		bild	#4, @er4
		bcs	loc_0c812

		mov	@(4,er4), r0h

loc_0c812:	pop	er4
		rts

; ----------------------------------------------

sub_0c818:	push	er4
		push	er0
		jsr	sub_0c378

		pop	er0
		btst	#4, @er4
		beq	loc_0c836

		bset	#3, @er4
		jsr	sub_0b90c

loc_0c836:	pop	er4
		rts

; ----------------------------------------------

sub_0c83c:	push	er4
		mov	#0, r0h
		bsr	sub_0c84e

		mov	#1, r0h
		bsr	sub_0c84e

		pop	er4
		rts

; ----------------------------------------------

sub_0c84e:	push	er0
		jsr	sub_0c378

		pop	er0
		btst	#4, @er4
		beq	rts_0c868

		bset	#5, @er4
		jsr	sub_0b90c

rts_0c868:	rts

; ----------------------------------------------

sub_0c86a:	push	er1
		mov	@long_ffebe4, er1
		mov	@er1, r0h
		pop	er1
		rts

; ----------------------------------------------

sub_0c87e:	push	er4
		mov	#0, r0h
		bld	#2, @er4
		bist	#0, r0h
		jsr	sub_0b42e

		pop	er4
		cmp	#1, r0h
		bne	loc_0c89a

		mov	#0x80, r0h
		bra	loc_0c8a4

loc_0c89a:	cmp	#2, r0h
		bne	loc_0c8a2

		mov	#0x40, r0h
		bra	loc_0c8a4

loc_0c8a2:	mov	#0, r0h

loc_0c8a4:	mov	@(0x94 - 0x20 & -(type1R && level < 0x01030069),er4), er1
		mov	e1, r2
		mov	r2h, r2l
		and	#0xc0, r2l
		cmp	r2l, r0h
		beq	loc_0c8c2

		zero	er1
		mov	#0, r0l
		mov	r0, e1
		mov	er1, @(0x94 - 0x20 & -(type1R && level < 0x01030069),er4)

loc_0c8c2:	cmp	#0, r0h
		beq	rts_0c8e4

		mov	e1, r2
		btst	#5, r2h
		bne	rts_0c8e4

		exts	e1
		mov	@(0x18,er4), r3
		exts	er3
		add	er3, er1
		inc	r2h
		mov	e1, r3
		mov	r2h, r3h
		mov	r3, e1
		mov	er1, @(0x94 - 0x20 & -(type1R && level < 0x01030069),er4)

rts_0c8e4:	rts

; ----------------------------------------------

sub_0c8e6:	mov	@(0x94 - 0x20 & -(type1R && level < 0x01030069),er4), er1
		and	#0xc000, e1
		zero	r1
		mov	er1, @(0x94 - 0x20 & -(type1R && level < 0x01030069),er4)
		rts

; ----------------------------------------------

sub_0c8fa:	mov	#sanyo_03, er3		; "SANYO" "03"
		bsr	sub_0c9ce:16

		bcc	loc_0c91e

		mov	#panasonic_03, er3	; "Panasonic" "03"
		bsr	sub_0c9ce:16

		bcc	loc_0c91e

		mov	#sony_03, er3		; "SONY" "03"
		bsr	sub_0c9ce:16

		bcs	loc_0c932

loc_0c91e:	mov	#byte_ffeb46, er0
		mov	@(0x0b,er0), r2l
		btst	#7, r2l
		beq	loc_0c98a

		mov	@(0x1e,er0), r1
		bra	loc_0c986

loc_0c932:	mov	#byte_ffeb82 - 0x3c, er0
		mov	#sanyo, er3		; "SANYO"
		mov	#0, r1l

loc_0c940:	mov	@(0x3c,er0), r2l
		mov	@er3, r2h
		cmp	r2l, r2h
		bne	loc_0c98a

		inc	r0l
		inc	r3l
		inc	r1l
		cmp	#0x10, r1l
		blo	loc_0c940

		mov	#byte_ffeb46, er4
		jsr	sub_0c5f0

		mov	@word_ffebe2, r2
		bne	loc_0c968

		mov	#0x37, r2l

loc_0c968:	cmp	r2l, r0h
		blo	loc_0c98a

		mov	#byte_ffeb64 - 0x1e, er0
		mov	@(0x1e,er0), r1
		mov	@word_ffebe0, r2
		bne	loc_0c982

		mov	#0x14, r2

loc_0c982:	cmp	r2, r1
		bhi	loc_0c98a

loc_0c986:	clr	c
		bra	rts_0c98c

loc_0c98a:	set	c

rts_0c98c:	rts


sanyo:		.asciz "SANYO" "\0\0\0\0\0\0\0\0\0"
sanyo_03:	.asciz "SANYO" "03"  "\0\0\0\0\0\0"
panasonic_03:	.asciz "Panasonic" "03"      "\0\0"
sony_03:	.asciz "SONY" "03" "\0\0\0\0\0\0\0"

; ----------------------------------------------

sub_0c9ce:	mov	#byte_ffeb82 - 0x3c, er0
		mov	#0, r1l

loc_0c9d6:	mov	@(0x3c,er0), r2l
		mov	@er3, r2h
		cmp	r2l, r2h
		bne	loc_0c9ee

		inc	r0l
		inc	r3l
		inc	r1l
		cmp	#0x10, r1l
		blo	loc_0c9d6

		clr	c
		bra	loc_0c9ee

loc_0c9ee:	set	c
		rts

; ----------------------------------------------

sub_0c9f2:	push	er1
		mov	r0, r1
		extu	r0
		mov	r0, @word_ffebe0
		mov	r1h, r0l
		extu	r0
		mov	r0, @word_ffebe2
		pop	er1
		rts

; ----------------------------------------------

.if !type1R
sub_0ca10:	mov	@byte_ffebf6, r1l
		mov	@byte_ffebf7, r1h
		btst	#3, r1h
		beq	loc_0ca26

		mov	#5, r0l
		jsr	sub_0ca94

loc_0ca26:	btst	#4, r1h
		beq	loc_0ca30

		mov	#4, r0l
		jsr	sub_0ca94

loc_0ca30:	mov	r1, @(0x2e,er4)
		rts

; ----------------------------------------------

sub_0ca36:	mov	@byte_ffebf6, r1l
		mov	@byte_ffebf7, r1h
		btst	#1, r1l
		beq	loc_0ca4c

		mov	#6, r0l
		jsr	sub_0ca94

loc_0ca4c:	mov	r1, @(0x0a,er4)
		rts

; ----------------------------------------------

sub_0ca52:	mov	@byte_ffebf6, r1l
		mov	@byte_ffebf7, r1h
		btst	#0, @byte_ffe10a
		bne	loc_0ca8e

		mov	#long_ffe0fa, er2
		btst	#2, @er4
		beq	loc_0ca7a

		mov	#long_ffe0ea, er2

loc_0ca7a:	mov	@(0x0e,er2), r0l
		mov	@(0x0f,er2), r0h
		cmp	r0, r1
		beq	loc_0ca8e

		bset	#0, @byte_ffe10a

loc_0ca8e:	mov	r1, @(0x30,er4)
		rts

; ----------------------------------------------

sub_0ca94:	push	r1
		push	er4
		bsr	sub_0cb60:16

		mov	r0l, @(1,er2)
		mov	r1l, @(9,er2)
		stm	er0-er2, @-sp
		bsr	sub_0c5f0:16

		mov	r0h, @(0x0c,er2)
		mov	@(0x16,er4), r1
		mov	r1l, @(0x0d,er2)
		mov	r1h, @(0x0e,er2)
		mov	@(0x20,er4), r1
		mov	r1l, @(0x0a,er2)
		mov	r1h, @(0x0b,er2)
		mov	#0x0f, r0h
		mov	r0h, @(0,er2)
		mov	er2, er6
		jsr	sub_06cc6

		mov	r0l, @(2,er6)
		mov	r0h, @(3,er6)
		mov	r1h, @(4,er6)
		mov	r1l, @(5,er6)
		mov	r2h, @(6,er6)
		mov	r2l, @(7,er6)
		mov	r3h, @(8,er6)
		bsr	sub_0cbc2:16

		mov	r5l, @(0x0f,er6)
		ldm	@sp+, er0-er2
		jsr	sub_14e8a

		pop	er4
		pop	r1
		rts

; ----------------------------------------------

sub_0cb0a:	push	er4
		mov	#0x22, r0l
		bsr	sub_0cb60

		mov	r0l, @(1,er2)
		mov	r1l, @(2,er2)
		mov	#0x0f, r0l
		mov	r0l, @(0,er2)
		mov	#0x72, er3
		add	er4, er3
		mov	er2, er5
		mov	er2, er6
		add	#0x0c, er6

loc_0cb32:	mov	@er3+, r0l
		mov	r0l, @(3,er5)
		add	#1, er5
		cmp	er6, er5
		blo	loc_0cb32

		mov	@(0x90,er4), r0
		mov	r0l, @(0x0c,er4)
		mov	r0h, @(0x0d,er4)
		mov	@(0x30,er4), r0
		mov	r0l, @(0x0e,er4)
		mov	r0h, @(0x0f,er4)
		pop	er4
		rts

; ----------------------------------------------

sub_0cb60:	mov	#byte_0cb9a, er3

loc_0cb66:	mov	@(0,er3), r0h
		cmp	r0h, r0l
		bne	loc_0cb8a

		cmp	#byte_ffeaac, er4
		bne	loc_0cb80

		mov	@(2,er3), er2
		mov	#0, r1l
		bra	rts_0cb98

loc_0cb80:	mov	@(6,er3), er2
		mov	#1, r1l
		bra	rts_0cb98

loc_0cb8a:	add	#10, er3
		cmp	#byte_0cbc2, er3
		blo	loc_0cb66

rts_0cb98:	rts


byte_0cb9a:	.byte 0x04, 0xff, 0x00, 0xff, 0xe0, 0x8a, 0x00, 0xff
		.byte 0xe0, 0x9a, 0x05, 0xff, 0x00, 0xff, 0xe0, 0xaa
		.byte 0x00, 0xff, 0xe0, 0xba, 0x06, 0xff, 0x00, 0xff
		.byte 0xe0, 0xca, 0x00, 0xff, 0xe0, 0xda, 0x22, 0xff
		.byte 0x00, 0xff, 0xe0, 0xea, 0x00, 0xff, 0xe0, 0xfa
byte_0cbc2:

; ----------------------------------------------

sub_0cbc2:	push	er2
		mov	@(9,er6), r5l
		cmp	#0, r5l
		bne	loc_0cbd2

		mov	#0, r0h
		bra	loc_0cbd4

loc_0cbd2:	mov	#1, r0h

loc_0cbd4:	push	r0
		jsr	sub_0c3d2

		pop	r0
		bcs	loc_0cbea

		jsr	sub_0b42e

		shll	#2, r0h
		shll	r0h
		or	r0h, r5l
		bra	loc_0cbec

loc_0cbea:	or	#0x18, r5l

loc_0cbec:	pop	er2
		rts

; ----------------------------------------------

sub_0cbf2:	bset	#0, @byte_ffe10a
		rts
.endif

; ----------------------------------------------

.ifeq type1R && level < 0x01030069
sub_0cbfc:	push	er4
		jsr	sub_0c378

		bild	#4, @er4
		bcs	loc_0cc2e

		mov	@(0x64,er4), r3l
		mov	@(0x65,er4), r3h
		mov	@(0x66,er4), r2l
		mov	@(0x67,er4), r2h
		mov	@(0x68,er4), r1l
		mov	@(0x69,er4), r1h
		mov	@(0x6a,er4), r0l
		mov	@(0x6b,er4), r0h
		clr	c
		bra	loc_0cc3a

loc_0cc2e:	mov	#0, r0
		mov	r0, r1
		mov	r0, r2
		mov	r0, r3
		set	c

loc_0cc3a:	pop	er4
		rts

; ----------------------------------------------

sub_0cc40:	push	er4
		jsr	sub_0c378

		bild	#4, @er4
		bcs	loc_0cc7a

		mov	#panasonic, er1		; "PANASONIC"

loc_0cc54:	mov	@er1+, r0h
		mov	@(0x3c,er4), r0l
		inc	#1, er4
		cmp	#0x61, r0l
		blo	loc_0cc66

		cmp	#0x7a, r0l
		bhi	loc_0cc66

		add	#0xe0, r0l

loc_0cc66:	cmp	r0h, r0l
		beq	loc_0cc6e

		set	c
		bra	loc_0cc78

loc_0cc6e:	cmp	#0, r0h
		bne	loc_0cc76

		clr	c
		bra	loc_0cc78

loc_0cc76:	bra	loc_0cc54

loc_0cc78:	bra	loc_0cc7c

loc_0cc7a:	set	c

loc_0cc7c:	pop	er4
		rts


panasonic:	.asciz "PANASONIC"

; ----------------------------------------------
.endif

sub_0cc8c:	mov	#0x1000, r0
		mov	r0, @word_ffec24
		mov	#0, r0
		mov	r0, @word_ffec26
		rts

; ----------------------------------------------

sub_0cca2:	cmp	#1, r0h
		beq	loc_0ccae

		mov	#byte_ffeaac, er4
		bra	rts_0ccb4

loc_0ccae:	mov	#byte_ffeb46, er4

rts_0ccb4:	rts

; ----------------------------------------------

sub_0ccb6:	cmp	#0x16, r0h
		bne	loc_0ccbe

		bsr	sub_0ccce

		bra	rts_0cccc

loc_0ccbe:	cmp	#0x14, r0h
		bne	loc_0ccc8

		jsr	sub_0d300

		bra	rts_0cccc

loc_0ccc8:	jsr	sub_0d1ce

rts_0cccc:	rts

; ----------------------------------------------

sub_0ccce:	mov	@word_ffec24, r3
		mov	#7, r4h
		mov	#4, r4l

loc_0ccd8:	btst	r4h, r3h
		bne	loc_0cce2

		dec	r4h
		dec	r4l
		bne	loc_0ccd8

loc_0cce2:	add	#-4, r4h
		bmi	loc_0cd0e

		cmp	#2, r4h
		bhs	loc_0cd0e

		push	er0
		push	er1
		push	er2
		mov	r4h, r0h
		jsr	sub_0cca2

		pop	er2
		pop	er1
		pop	er0
		btst	#4, @er4
		bne	loc_0cd12

loc_0cd0e:	jmp	loc_0cdba

loc_0cd12:	mov	#byte_0cf8e, er3
		cmp	#0x40, r1h
		bhi	loc_0cdb4:16

		mov	r1h, r5h
		shll	r5h
		add	r5h, r3l
		addx	#0, r3h
		bcc	loc_0cd2a

		inc	#1, e3

loc_0cd2a:	mov	@er3+, r6h
		mov	@er3+, r6l
		cmp	r0l, r6h
		beq	loc_0cd36

		cmp	r0l, r6l
		bne	loc_0cdb4

loc_0cd36:	mov	#word_0d00e, er3
		add	r5h, r3l
		addx	#0, r3h
		bcc	loc_0cd44

		inc	#1, e3

loc_0cd44:	mov	@er3, r3
		beq	loc_0cd92

		mov	#0, e3
		add	er4, er3
		cmp	#9, r0l
		bne	loc_0cd62

		mov	@er3+, r5l
		mov	@er3, r5h
		mov	r5h, @er2
		adds	#1, er2
		mov	r5l, @er2
		mov	#0, r0h
		mov	#0, r0l
		bra	loc_0cd90

loc_0cd62:	cmp	#0x0b, r0l
		bne	loc_0cd8c

		mov	#byte_0d08e, er5
		add	r1h, r5l
		addx	#0, r5h
		bcc	loc_0cd74

		inc	#1, e5

loc_0cd74:	mov	@er5, r5h
		mov	#0, r5l

loc_0cd78:	mov	@er3+, r6h
		beq	loc_0cd86

		mov	r6h, @er2
		adds	#1, er2
		inc	r5l
		dec	r5h
		bne	loc_0cd78

loc_0cd86:	mov	#0, r0h
		mov	r5l, r0l
		bra	loc_0cd90

loc_0cd8c:	mov	#0x12, r0h
		mov	#0, r0l

loc_0cd90:	bra	loc_0cdb2

loc_0cd92:	mov	r1h, r5l
		mov	#0, r5h
		shll	#2, r5
		mov	#off_0d0ce, er3
		add	r5, r3
		bcc	loc_0cda4

		inc	#1, e3

loc_0cda4:	mov	@er3, er3
		beq	loc_0cdae

		jsr	@er3

		bra	loc_0cdb2

loc_0cdae:	mov	#0x12, r0h
		mov	#0, r0l

loc_0cdb2:	bra	loc_0cdb8

loc_0cdb4:	mov	#0x12, r0h
		mov	#0, r0l

loc_0cdb8:	bra	rts_0cdbe

loc_0cdba:	mov	#0x10, r0h
		mov	#0, r0l

rts_0cdbe:	rts

; ----------------------------------------------

sub_0cdc0:	mov	#0x0c, r3

loc_0cdc4:	mov	#0, e3
		add	er4, er3
		cmp	#9, r0l
		bne	loc_0cdd8

		mov	@er3, r0
		mov	r0l, @er2
		adds	#1, er2
		mov	r0h, @er2
		bra	loc_0cde0

loc_0cdd8:	mov	@er2, r0l
		adds	#1, er2
		mov	@er2, r0h
		mov	r0, @er3

loc_0cde0:	mov	#0, r0h
		mov	#0, r0l
		rts


sub_0cde6:	mov	#0x0e, r3
		bra	loc_0cdc4

sub_0cdec:	mov	#0x12, r3
		bra	loc_0cdc4

; ----------------------------------------------

sub_0cdf2:	push	er2
		mov	@(0x12,er4), r1
		mov	@(0x22,er4), r2
		mov	@(0x20,er4), r0
		sub	r0, r2
		mov	r1, r0
		bmi	loc_0ce42

loc_0ce08:	beq	loc_0ce42

		mov	r2, r4
		beq	loc_0ce3c

		mov	#0, r3l
		mov	#6, r3h

loc_0ce12:	shll	r2l
		rotxl	r2h
		rotxl	r3l
		dec	r3h
		bne	loc_0ce12

		mov	#0, r5l
		shll	r4l
		rotxl	r4h
		rotxl	r5l
		shll	r4l
		rotxl	r4h
		rotxl	r5l
		sub	r4, r2
		subx	r5l, r3l
		mov	#0, r3h
		jsr	sub_0c49a

		bcc	loc_0ce3a

		mov	#-1, r0

loc_0ce3a:	bra	loc_0ce40

loc_0ce3c:	mov	#0, r0

loc_0ce40:	bra	loc_0ce46

loc_0ce42:	mov	#-1, r0

loc_0ce46:	pop	er2
		mov	r0l, @er2
		adds	#1, er2
		mov	r0h, @er2
		mov	#0, r0h
		mov	#0, r0l
		rts

; ----------------------------------------------

sub_0ce56:	push	er2
		mov	@(0x12,er4), r0
		bpl	loc_0ce68

		mov	#0, r1
		sub	r0, r1
		bra	loc_0ce6c

loc_0ce68:	mov	#0, r1

loc_0ce6c:	mov	@(0x20,er4), r2
		mov	r1, r0
		bra	loc_0ce08

; ----------------------------------------------

sub_0ce74:	push	er2
		mov	@(0x12,er4), r0
		bmi	loc_0ce86

		mov	#1, r0
		jmp	loc_0cf0e

loc_0ce86:	mov	@(0x18,er4), r0
		bpl	loc_0ce92

		not	r0h
		not	r0l
		inc	#1, r0

loc_0ce92:	push	er4
		mov	@(0x16,er4), r1
		jsr	sub_0c4ee

		mov	r0, r2
		mov	r1, r3
		mov	#10000, r1
		jsr	sub_0c49a

		pop	er4
		mov	@(0x12,er4), r1
		not	r1h
		not	r1l
		inc	#1, r1
		mov	@(0x18,er4), r2
		bpl	loc_0cec8

		add	r1, r0
		mov	#0, r1
		addx	#0, r1l
		bra	loc_0ced8

loc_0cec8:	sub	r0, r1
		mov	r1, r0
		bpl	loc_0ced4

		mov	#-1, r1
		bra	loc_0ced8

loc_0ced4:	mov	#0, r1

loc_0ced8:	mov	r1, r2
		bmi	loc_0cf0a

		push	er4
		mov	r0, r2
		mov	r1, r3
		mov	#0x168, r1
		jsr	sub_0c49a

		mov	r4, r1
		beq	loc_0cef2

		inc	#1, r0

loc_0cef2:	pop	er4
		mov	@(0x20,er4), r1
		cmp	r0, r1
		blo	loc_0cf04

		mov	#1, r0
		bra	loc_0cf08

loc_0cf04:	mov	#0, r0

loc_0cf08:	bra	loc_0cf0e

loc_0cf0a:	mov	#1, r0

loc_0cf0e:	pop	er2
		mov	r0l, @er2
		mov	r0h, @(1,er2)
		mov	#0, r0h
		mov	#0, r0l
		rts

; ----------------------------------------------

sub_0cf1e:	mov	@(0x22,er4), r1

loc_0cf22:	mov	@(0x20,er4), r0
		push	er2
		jsr	sub_0c48a

		pop	er2
		mov	r0l, @er2
		adds	#1, er2
		mov	r0h, @er2
		mov	#0, r0h
		mov	#0, r0l
		rts

; ----------------------------------------------

sub_0cf3e:	mov	@(0x32,er4), r1
		bra	loc_0cf22

sub_0cf44:	mov	#0, r0h
		mov	#0, r0l
		rts

; ----------------------------------------------

sub_0cf4a:	push	er2
		bsr	sub_0cf60

		pop	er2
		mov	r0l, @er2
		adds	#1, er2
		mov	r0h, @er2
		mov	#0, r0h
		mov	#0, r0l
		rts

; ----------------------------------------------

sub_0cf60:	mov	@(0x2e,er4), r0
		mov	@(0x0c,er4), r1
		beq	loc_0cf72

		mov	@(0x20,er4), r2
		cmp	r1, r2
		blo	loc_0cf76

loc_0cf72:	bclr	#1, r0h
		bra	loc_0cf78

loc_0cf76:	bset	#1, r0h

loc_0cf78:	mov	@(0x0e,er4), r1
		beq	loc_0cf86

		mov	@(0x26,er4), r2
		cmp	r1, r2
		blo	loc_0cf8a

loc_0cf86:	bclr	#0, r0h
		bra	rts_0cf8c

loc_0cf8a:	bset	#0, r0h

rts_0cf8c:	rts

; ----------------------------------------------

byte_0cf8e:	.byte 0,  9, 8,  9, 8,  9, 0,  9, 8, 9, 0, 9, 0, 9, 0,  9
		.byte 0,  9, 0,  9, 0,  9, 0,  9, 0, 9, 0, 9, 0, 9, 0,  9
		.byte 0,  9, 0,  9, 0,  9, 0,  9, 0, 9, 0, 9, 0, 9, 0,  9
		.byte 0,  9, 0,  9, 0,  9, 0,  9, 0, 9, 0, 0, 0, 0, 0,  0
		.byte 0, 11, 0, 11, 0, 11, 0, 11, 0, 0, 0, 0, 0, 0, 0,  0
		.byte 0,  0, 0,  0, 0,  0, 0,  0, 0, 0, 0, 0, 0, 0, 0, 11
		.byte 0,  0, 0,  0, 0,  0, 0,  0, 0, 0, 0, 0, 0, 0, 0,  0
		.byte 0,  0, 0,  0, 0,  0, 0,  0, 0, 0, 0, 0, 0, 0, 0,  9

word_0d00e:	.word 10,  0,  0, 16,  0,  0, 0,  0, 20, 22, 24, 26, 28, 30, 0,  32
		.word 34, 36, 38, 40, 42, 44, 0, 48, 50, 52, 54, 56, 58,  0, 0,   0
.if type1R && level < 0x01030069
		.word 60, 76, 92,  0,  0,  0, 0,  0,  0,  0,  0,  0,  0,  0, 0,  96
		.word  0,  0,  0,  0,  0,  0, 0,  0,  0,  0,  0,  0,  0,  0, 0, 112
.else
		.word 60, 76, 92, 96,  0,  0, 0,  0,  0,  0,  0,  0,  0,  0, 0, 112
		.word  0,  0,  0,  0,  0,  0, 0,  0,  0,  0,  0,  0,  0,  0, 0, 144
.endif

byte_0d08e:	.byte  2,  2, 2,  2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,  2
		.byte  2,  2, 2,  2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0,  0
.if type1R && level < 0x01030069
		.byte 16, 16, 4,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16
.else
		.byte 16, 16, 4, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16
.endif
		.byte  0, 0,  0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  2

off_0d0ce:	.long NULL			;  0
		.long sub_0cdc0			;  1
		.long sub_0cde6			;  2
		.long NULL			;  3
		.long sub_0cdec			;  4
		.long sub_0cdf2			;  5
		.long sub_0ce56			;  6
		.long sub_0ce74			;  7
		.long NULL			;  8
		.long NULL			;  9
		.long NULL			; 10
		.long NULL			; 11
		.long NULL			; 12
		.long sub_0cf1e			; 13
		.long sub_0cf3e			; 14
		.long NULL			; 15
		.long NULL			; 16
		.long NULL			; 17
		.long NULL			; 18
		.long NULL			; 19
		.long NULL			; 20
		.long NULL			; 21
		.long sub_0cf4a			; 22
		.long NULL			; 23
		.long NULL			; 24
		.long NULL			; 25
		.long NULL			; 26
		.long NULL			; 27
		.long NULL			; 28
		.long NULL			; 29
		.long NULL			; 30
		.long NULL			; 31
		.long NULL			; 32
		.long NULL			; 33
		.long NULL			; 34
.if type1R && level < 0x01030069
		.long sub_0cf44			; 35
.else
		.long NULL			; 35
.endif
		.long NULL			; 36
		.long NULL			; 37
		.long NULL			; 38
		.long NULL			; 39
		.long NULL			; 40
		.long NULL			; 41
		.long NULL			; 42
		.long NULL			; 43
		.long NULL			; 44
		.long NULL			; 45
		.long NULL			; 46
		.long NULL			; 47
		.long NULL			; 48
		.long NULL			; 49
		.long NULL			; 50
		.long NULL			; 51
		.long NULL			; 52
		.long NULL			; 53
		.long NULL			; 54
		.long NULL			; 55
		.long NULL			; 56
		.long NULL			; 57
		.long NULL			; 58
		.long NULL			; 59
		.long NULL			; 60
		.long NULL			; 61
		.long NULL			; 62
		.long NULL			; 63

; ----------------------------------------------

sub_0d1ce:	mov	#off_0d1fe, er3
		mov	#0x17, r4h

loc_0d1d6:	cmp	#9, r0l
		beq	loc_0d1de

		cmp	#8, r0l
		bne	loc_0d1f8

loc_0d1de:	cmp	r4h, r1h
		bhs	loc_0d1f8

		mov	r1h, r1l
		mov	#0, r1h
		mov	#0, e1
		shll	#2, er1
		add	er1, er3
		mov	@er3, er3
		beq	loc_0d1f8

		jsr	@er3

		bra	rts_0d1fc

loc_0d1f8:	mov	#0x12, r0h
		mov	#0, r0l

rts_0d1fc:	rts


off_0d1fe:	.long NULL			;  0
		.long NULL			;  1
		.long NULL			;  2
		.long NULL			;  3
		.long NULL			;  4
		.long NULL			;  5
		.long NULL			;  6
		.long NULL			;  7
		.long NULL			;  8
		.long NULL			;  9
		.long NULL			; 10
		.long NULL			; 11
		.long NULL			; 12
		.long NULL			; 13
		.long NULL			; 14
		.long NULL			; 15
		.long NULL			; 16
		.long sub_0d2e6			; 17
		.long sub_0d26a			; 18
		.long sub_0d294			; 19
		.long sub_0d25a			; 20
		.long sub_0d25a			; 21
		.long sub_0d25a			; 22

; ----------------------------------------------

sub_0d25a:	cmp	#8, r0l
		bne	loc_0d264

		mov	#0, r0h
		mov	#0, r0l
		bra	rts_0d268

loc_0d264:	mov	#0x12, r0h
		mov	#0, r0l

rts_0d268:	rts

; ----------------------------------------------

sub_0d26a:	cmp	#8, r0l
		bne	loc_0d28e

		mov	@er2, r0l
		mov	@(1,er2), r0h
		mov	r0, @word_ffec26
		btst	#0, r0l
		beq	loc_0d284

		jsr	sub_0b582

		bra	loc_0d288

loc_0d284:	jsr	sub_0b5a4

loc_0d288:	mov	#0, r0h
		mov	#0, r0l
		bra	rts_0d292

loc_0d28e:	mov	#0x12, r0h
		mov	#0, r0l

rts_0d292:	rts

; ----------------------------------------------

sub_0d294:	cmp	#9, r0l
		bne	loc_0d2e0

		push	er2
		mov	@word_ffec26, r0
		mov	#0, r1
		bld	#0, r0l
		bst	#0, r1l
		bld	#1, r0l
		bst	#1, r1l
		bset	#4, r1l
		bset	#5, r1l
		push	er1
		mov	#-1, r0h
		jsr	sub_0c3d2

		pop	er1
		bist	#6, r1h
		push	er1
		jsr	sub_074d0

		pop	er1
		bist	#7, r1h
		pop	er2
		mov	r1l, @er2
		mov	r1h, @(1,er2)
		mov	#0, r0h
		mov	#0, r0l
		bra	rts_0d2e4

loc_0d2e0:	mov	#0x12, r0h
		mov	#0, r0l

rts_0d2e4:	rts

; ----------------------------------------------

sub_0d2e6:	cmp	#9, r0l
		bne	loc_0d2fa

		mov	#2, r0l
		mov	#0, r0h
		mov	r0l, @er2
		mov	r0h, @(1,er2)
		mov	#0, r0h
		mov	#0, r0l
		bra	rts_0d2fe

loc_0d2fa:	mov	#0x12, r0h
		mov	#0, r0l

rts_0d2fe:	rts

; ----------------------------------------------

sub_0d300:	mov	#off_0d30c, er3
		mov	#5, r4h
		jmp	loc_0d1d6

off_0d30c:	.long NULL			; 0
		.long sub_0d320			; 1
		.long NULL			; 2
		.long NULL			; 3
		.long sub_0d422			; 4

; ----------------------------------------------

sub_0d320:	cmp	#9, r0l
		beq	loc_0d328

		jmp	loc_0d3c0

loc_0d328:	push	er2
		mov	#0, r0
		push	er0
		mov	#0, r0h
		jsr	sub_0d3e4

		pop	er1
		or	r0h, r1h
		or	r0l, r1l
		push	er1
		mov	#1, r0h
		jsr	sub_0d3e4

		pop	er1
		or	r0h, r1h
		or	r0l, r1l
		mov	r1l, r0h
		beq	loc_0d37a

		and	#0xf0, r0h
		bne	loc_0d37a

		mov	@word_ffec24+1, r0l
		shlr	r0l
		shlr	r0l
		shlr	r0l
		shlr	r0l
		and	r1l, r0l
		bne	loc_0d370

		mov	r1l, r0l

loc_0d370:	btst	#0, r0l
		beq	loc_0d378

		bset	#4, r1l
		bra	loc_0d37a

loc_0d378:	bset	#5, r1l

loc_0d37a:	mov	@word_ffec24, r0
		and	#0xf0, r0h
		or	r0h, r1h
		push	er1
		jsr	sub_074d0

		pop	er1
		bcs	loc_0d3b4

		mov	r1l, r0h
		xor	#0xf0, r1l
		push	er1
		mov	#0, r0h
		jsr	sub_0b42e

		cmp	#2, r0h
		beq	loc_0d3aa

		mov	#1, r0h
		jsr	sub_0b42e

loc_0d3aa:	pop	er1
		cmp	#2, r0h
		bne	loc_0d3b4

		xor	#0x0f, r1h

loc_0d3b4:	pop	er2
		mov	r1l, @er2
		mov	r1h, @(1,er2)
		bra	loc_0d3de

loc_0d3c0:	mov	@er2, r0l
		mov	@(1,er2), r0h
		mov	r0, @word_ffec24
		and	#0x0f, r0h
		beq	loc_0d3de

		cmp	#3, r0h
		bhs	loc_0d3de

		bld	#1, r0h
		mov	#0, r0h
		bst	#0, r0h
		jsr	sub_0b6c6

loc_0d3de:	mov	#0, r0h
		mov	#0, r0l
		rts

; ----------------------------------------------

sub_0d3e4:	push	er0
		jsr	sub_0cca2

		bld	#4, @er4
		pop	er1
		bcc	loc_0d41c

		push	er1
		mov	r1h, r0h
		jsr	sub_0b42e

		pop	er1
		mov	#0, r2
		bset	r1h, r2l
		cmp	#1, r0h
		bne	loc_0d410

		bset	r1h, r2h

loc_0d410:	cmp	#2, r0h
		bne	loc_0d418

		add	#4, r1h
		bset	r1h, r2l

loc_0d418:	mov	r2, r0
		bra	rts_0d420

loc_0d41c:	mov	#0, r0

rts_0d420:	rts

; ----------------------------------------------

sub_0d422:	cmp	#9, r0l
		bne	loc_0d436

		mov	#1, r0h
		mov	#0x13, r0l
		mov	r0l, @er2
		mov	r0h, @(1,er2)
		mov	#0, r0h
		mov	#0, r0l
		bra	rts_0d43a

loc_0d436:	mov	#0x12, r0h
		mov	#0, r0l

rts_0d43a:	rts

; ----------------------------------------------

init_adc:	b clr	mstpcrh.mstp9		; A/D (Module Stop Control Register H)
		mov	#0, r0h
.if level < 0x01000063
		mov	r0h, @byte_ffe521
		mov	r0h, @byte_ffe522
.endif
		mov	r0h, @byte_ffff29
.if level < 0x01000063
		mov	r0h, @byte_ffff26
.endif
		jsr	clear_ADvals

		rts

; ----------------------------------------------

rts_0d44e:	rts

; ----------------------------------------------

.if level >= 0x01000063
task30:		mov	@byte_ffff29, r0l
		and	#0x0f, r0l
		beq	loc_0d484

		mov	#0, r0h
		jsr	sub_0d52c

		bcc	loc_0d484

		jsr	sub_0d54a

		b set	adcsr.scan		; Scan Mode (A/D Control/Status Register)
		b clr	adcsr.ch2		; Channel Select 2 (A/D Control/Status Register)
		b set	adcsr.ch1		; Channel Select 1 (A/D Control/Status Register)
		b set	adcsr.ch0		; Channel Select 0 (A/D Control/Status Register)
		b set	adcsr.adst		; A/D Start (A/D Control/Status Register)
		mov	#adcVals0, er5
		jsr	sub_0d4c0

loc_0d484:	mov	@byte_ffff29, r0l
		and	#0x30, r0l
		beq	loc_0d4bc

		shlr	#2, r0l
		shlr	#2, r0l
		mov	#1, r0h
		jsr	sub_0d52c

		bcc	loc_0d4bc

		jsr	sub_0d54a

		b set	adcsr.scan		; Scan Mode (A/D Control/Status Register)
		b set	adcsr.ch2		; Channel Select 2 (A/D Control/Status Register)
		b clr	adcsr.ch1		; Channel Select 1 (A/D Control/Status Register)
		b set	adcsr.ch0		; Channel Select 0 (A/D Control/Status Register)
		b set	adcsr.adst		; A/D Start (A/D Control/Status Register)
		mov	#adcVals1, er5
		jsr	sub_0d4c0

loc_0d4bc:	clr	c
		rts

; ----------------------------------------------

sub_0d4c0:	b tst	adcsr.adf		; A/D End Flag (A/D Control/Status Register)
		nop
		beq	sub_0d4c0

		b clr	adcsr.adst		; A/D Start (A/D Control/Status Register)
		b clr	adcsr.adf		; A/D End Flag (A/D Control/Status Register)
		mov	r0l, r4l
		zero	r4h
		mov	#addrah & M24, er0	; A/D Data Register AH
		zero	er1
		add	er5, er1

loc_0d4e0:	mov	@er0+, r3l
		mov	@er0+, r3h
		shal	r3l
		rotxl	r3h
		bst	#0, r3l
		shal	r3l
		rotxl	r3h
		bst	#0, r3l
		mov	@er1, er2
		beq	loc_0d4fc

		btst	r4h, r4l
		beq	loc_0d4fc

		jsr	@er2

loc_0d4fc:	add	#4, er1
		inc	r4h
		cmp	#4, r4h
		blo	loc_0d4e0

		rts

; ----------------------------------------------
.else

task30:		mov	@byte_ffe521, r0h
		mov	#off_0c678, er1
		jmp	switch_er1_r0h

off_0c678:	case 0	sub_0c682 sub_0c69e sub_0c6da sub_0c71c
		case 4	sub_0c740

; ----------------------------------------------

sub_0c682:	mov	#byte_0c698, er0
		mov	er0, @long_ffe982
		jsr	sub_0c78c

		jmp	sub_0c7da

byte_0c698:	.byte 0, 2, 1, 3, 4, 5
byte_0c69e:

; ----------------------------------------------

sub_0c69e:	b clr	adcsr.adst		; A/D Start (A/D Control/Status Register)
		b clr	adcsr.adf		; A/D End Flag (A/D Control/Status Register)
		mov	@long_ffe982, er0
		mov	@er0, r0h
		btst	r0h, @byte_ffff29
		beq	sub_0c71c

		jsr	sub_0d52c

		bcc	sub_0c71c

		bset	r0h, @byte_ffff26
		jsr	sub_0d54a

		mov	r0h, @byte_ffe522
		bset	#5, r0h
		mov	r0h, @adcsr:8		; A/D Control/Status Register
		jmp	sub_0c7c8

; ----------------------------------------------

sub_0c6da:	mov	@adcsr:8, r0l		; A/D Control/Status Register
		btst	#7, r0l			; A/D End Flag
		beq	loc_0c7d6:16

		and	#3, r0l			; Channel Select 0/1
		shll	r0l
		mov	#addrah & M24, er1	; A/D Data Register AH
		add	r0l, r1l
		addx	#0, r1h
		bcc	loc_0c6f4

		inc	#1, e1

loc_0c6f4:	mov	@er1+, r0l
		mov	@er1, r0h
		shal	r0l
		rotxl	r0h
		bst	#0, r0l
		shal	r0l
		rotxl	r0h
		bst	#0, r0l
		mov	@byte_ffe522, r1l
		extu	r1
		extu	er1
		shll	er1
		mov	r0, @(word_ffec28,er1)
		jmp	sub_0c7c8

; ----------------------------------------------

sub_0c71c:	mov	@long_ffe982, er0
		inc	#1, er0
		cmp	#byte_0c69e, er0
		blt	loc_0c732

		mov	#4, r0h
		bra	loc_0c73c

loc_0c732:	mov	er0, @long_ffe982
		mov	#1, r0h

loc_0c73c:	jmp	loc_0c7d0

; ----------------------------------------------

sub_0c740:	zero	er0
		zero	er1

loc_0c748:	cmp	#8, r0l
		bge	loc_0c786

		btst	r0l, @byte_ffff26
		beq	loc_0c782

		bclr	r0l, @byte_ffff26
		mov	r0l, r1l
		shll	#2, er1
		mov	@(adcVals0,er1), er2
		beq	loc_0c782

		shlr	er1
		mov	@(word_ffec28,er1), r3
		stm	er0-er1, @-sp
		jsr	@er2

		ldm	@sp+, er0-er1

loc_0c782:	inc	r0l
		bra	loc_0c748

loc_0c786:	mov	#0, r0h
		jmp	loc_0c7e2

; ----------------------------------------------

sub_0c78c:	mov	#0, r0
		mov	#8, r1l
		zero	er2

loc_0c796:	mov	r0, @(word_ffec28,er2)
		inc	#2, er2
		dec	r1l
		bne	loc_0c796
		rts
.endif

; ----------------------------------------------

clear_ADvals:	mov	#0, er0
		mov	#8, r1l
		zero	er2

loc_0d516:	_mov	er0, adcVals0,er2
		add	#4, er2
		dec	r1l
		bne	loc_0d516

		rts

; ----------------------------------------------

.if level < 0x01000063
sub_0c7c8:	mov	@byte_ffe521, r0h
		inc	r0h

loc_0c7d0:	mov	r0h, @byte_ffe521

loc_0c7d6:	set	c
		rts

; ----------------------------------------------

sub_0c7da:	mov	@byte_ffe521, r0h
		inc	r0h

loc_0c7e2:	mov	r0h, @byte_ffe521
		clr	c
		rts
.endif

; ----------------------------------------------

sub_0d52c:	stm	er0-er1, @-sp
.if level < 0x01000063
		cmp	#5, r0h
		bne	sub_0d530

		bld	#4, @byte_ffff26
		bra	loc_0d544
.endif

sub_0d530:	mov	r0h, r1l
		extu	r1
		extu	er1
		shll	er1
		mov	@(word_ffec48,er1), r0
		jsr	cmpTick

loc_0d544:	ldm	@sp+, er0-er1
		rts

; ----------------------------------------------

sub_0d54a:	stm	er0-er1, @-sp
		mov	r0h, r0l
		extu	r0
		extu	er0
		shll	er0
		mov	@(word_ffec4c,er0), r1
		mov	@tick, e1
		add	r1, e1
		mov	e1, @(word_ffec48,er0)
		ldm	@sp+, er0-er1
		rts

; ----------------------------------------------

sub_0d574:	bset	r0h, @byte_ffff29
.if level < 0x01000063
		bclr	r0h, @byte_ffff26
.endif
		rts

; ----------------------------------------------

sub_0d57e:	bclr	r0h, @byte_ffff29
		rts

; ----------------------------------------------

sub_0d588:	push	er0
		mov	r0h, r0l
		extu	r0
		extu	er0
		shll	#2, er0
		_mov	er1, adcVals0,er0
		pop	er0
		rts

; ----------------------------------------------

sub_0d5a4:	stm	er0-er1, @-sp
		mov	r0h, r0l
		extu	r0
		extu	er0
		shll	er0
		mov	r1, @(word_ffec4c,er0)
		mov	@tick, e1
		add	r1, e1
		mov	e1, @(word_ffec48,er0)
		ldm	@sp+, er0-er1
		rts

; ----------------------------------------------

sub_0d5ce:	mov	#task31o, r0h
		mov	#249, r1
		jsr	schedBackTaskDelayed

		bclr	#3, @byte_ffff2a:8
		rts

; ----------------------------------------------

sub_0d5de:	bsr	sub_0d5ce

		bset	#3, @byte_ffff2a:8
		rts

; ----------------------------------------------

sub_0d5e6:	bsr	sub_0d5f6

		mov	r0h, r0l
		shll	#2, r0l
		shll	#2, r0l
		or	r0l, r0h
		jsr	sub_10f42

		rts

; ----------------------------------------------

sub_0d5f6:	zero	er2
		jsr	sub_0c86a

		mov	r0h, r2l
		dec	r2l
		mov	@(byte_0d78a,er2), r0h
		rts

; ----------------------------------------------

task31_3:	bsr	task31_1_2

		bld	#3, @byte_ffff2a:8
		rts

; ----------------------------------------------

task31_1_2:	mov	#task31o, r0h
		jsr	checkSchedTask

		bcc	loc_0d624

		bsr	sub_0d5ce

		bsr	sub_0d62e

		jsr	sub_0d7c2

loc_0d624:	mov	#task31o, r0h
		jsr	schedFrontTask

		clr	c
		rts

; ----------------------------------------------

sub_0d62e:	sub	#8, sp
		mov	#0, r0h
		mov	sp, er6
		adds	#2, er6
		mov	er6, @(4,sp)

loc_0d640:	mov	r0h, @sp
		bsr	sub_0d726:16

		mov	@(4,sp), er6
		mov	r0h, @er6
		adds	#1, er6
		mov	er6, @(4,sp)
		mov	r0h, r0l
		mov	@sp, r0h
		jsr	sub_10e2e

.if level >= 0x01000062 && level < 0x01000063
		jsr	sub_1333a
.endif

		mov	@sp, r0h
		inc	r0h
		cmp	#1, r0h
		bls	loc_0d640

		mov	@(2,sp), r0
		add	#8, sp
		bld	#7, r0h
		bor	#7, r0l
		bcs	loc_0d67a

		mov	#0, r0h
		bra	loc_0d6f8

loc_0d67a:	btst	#7, r0h
		bne	loc_0d682

		mov	r0l, r0h
		bra	loc_0d69a

loc_0d682:	btst	#7, r0l
		bne	loc_0d68a

		mov	r0h, r0l
		bra	loc_0d69a

loc_0d68a:	mov	r0, r1
		and	#0xf0f, r1
		cmp	r1h, r1l
		bls	loc_0d69a

		mov	r0h, r1h
		mov	r0l, r0h
		mov	r1h, r0l

loc_0d69a:	mov	r0, r1
		and	#0xf0f, r1
		cmp	#0x0f, r1h
		bne	loc_0d6a6

		mov	#0, r1h

loc_0d6a6:	cmp	#0x0f, r1l
		bne	loc_0d6ac

		mov	#0, r1l

loc_0d6ac:	bld	#5, r0h
		bor	#5, r0l
		bcc	loc_0d6cc

		stm	er0-er1, @-sp
		bsr	sub_0d5f6:16

		mov	r0h, r2h
		ldm	@sp+, er0-er1
		cmp	r2h, r1l
		blo	loc_0d6c8

		mov	#4, r0h
		bra	loc_0d6ca

loc_0d6c8:	mov	#2, r0h

loc_0d6ca:	bra	loc_0d6f8

loc_0d6cc:
.ifeq type1R && level < 0x01030069
		bld	#4, r0h
		bor	#4, r0l
		bcs	loc_0d6f2
.endif

		push	er1
		jsr	sub_074d0

		bcc	loc_0d6e6

		jsr	sub_01276

		bcc	loc_0d6e6

		mov	#0, r0h
		bra	loc_0d6f4

loc_0d6e6:	mov	@sp, er1		; pop+push er1
		cmp	#1, r1h
		bls	loc_0d6f2

		mov	#3, r0h
		bra	loc_0d6f4

loc_0d6f2:	mov	#1, r0h

loc_0d6f4:	pop	er1

loc_0d6f8:	mov	@byte_ffe3d6, r0l
		cmp	r0h, r0l
		beq	rts_0d724

		mov	r0h, @byte_ffe3d6
		mov	#4, r0h
		jsr	sub_068e6

		mov	#5, r0h
		jsr	sub_068e6

		mov	@byte_ffe3d6, r0h
		mov	#off_0d79a, er1
		jsr	switch_er1_r0h

rts_0d724:	rts

; ----------------------------------------------

sub_0d726:	push	er0
		jsr	sub_0b42e

		cmp	#1, r0h
		bne	loc_0d736

		mov	#0xc0, r1h
		bra	loc_0d740

loc_0d736:	cmp	#2, r0h
		bne	loc_0d73e

		mov	#0xa0, r1h
		bra	loc_0d740

loc_0d73e:	mov	#0x80, r1h

loc_0d740:	mov	@sp, er0		; pop+push er0
		push	er1
		jsr	sub_0c35c

		pop	er1
		bcs	loc_0d780

		bld	#0, r0h
		bst	#4, r1h
		mov	@sp, er0		; pop+push er0
		push	er1
		jsr	sub_0c38c

		pop	er1
		bcs	loc_0d77c

		zero	er2
		mov	r0l, r2l
		and	#0x0f, r2l
		mov	@(byte_0d78a,er2), r0l
		or	r0l, r1h
		bra	loc_0d77e

loc_0d77c:	or	#0x0f, r1h

loc_0d77e:	bra	loc_0d782

loc_0d780:	mov	#0, r1h

loc_0d782:	mov	r1h, r0h
		pop	er1
		rts


byte_0d78a:	.byte 0, 0, 1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13

off_0d79a:	case 0	rts_0d7a4 sub_0d7a6 sub_0d7ae sub_0d7b6
		case 4	sub_0d7bc

; ----------------------------------------------

rts_0d7a4:	rts

; ----------------------------------------------

sub_0d7a6:	mov	#4, r0h
		jsr	sub_0693c

		rts

; ----------------------------------------------

sub_0d7ae:	mov	#4, r0h
		jsr	sub_068e2

		rts

; ----------------------------------------------

sub_0d7b6:	mov	#5, r0h
		jmp	sub_068e2

; ----------------------------------------------

sub_0d7bc:	mov	#5, r0h
		jmp	loc_06956

; ----------------------------------------------

sub_0d7c2:	mov	#byte_0d85a, er3
		mov	#2, r4h
		mov	#long_ffec52, er5

loc_0d7d0:	mov	@(0,er3), r0h
		mov	#9, r0l
		mov	@(1,er3), r1h
		mov	#2, r1l
		push	er3
		push	er4
		push	er5
		push	er0
		mov	sp, er2
		adds	#2, er2
		jsr	sub_0ccb6

		pop	er1
		pop	er5
		pop	er4
		pop	er3
		cmp	#0, r0h
		bne	loc_0d84a

		mov	@er5, r0
		xor	r1h, r0h
		xor	r1l, r0l
		mov	@(2,er3), r2h
		mov	@(3,er3), r2l
		and	r2h, r0h
		bne	loc_0d81e

		and	r2l, r0l
		beq	loc_0d84a

loc_0d81e:	mov	@(0,er3), r0h
		push	er3
		push	er4
		push	er5
		push	er1
		jsr	sub_10fc0

		pop	er1
		pop	er5
		pop	er4
		pop	er3
		bcs	loc_0d84a

		mov	r1, @er5

loc_0d84a:	add	#4, er3
		adds	#2, er5
		dec	r4h
		bne	loc_0d7d0:16

		rts


byte_0d85a:	.byte 0x12, 0x13, 0x00, 0xc0, 0x14, 0x01, 0xff, 0x0f

; ----------------------------------------------

sub_0d862:	bset	#3, @byte_ffff2a:8
		rts

; ----------------------------------------------

sub_0d868:	b clr	mstpcrh.mstp9		; A/D (Module Stop Control Register H)
		mov	#0, r0h
		mov	r0h, @byte_ffe3d7
		setOutL 4 5			; Pin P45/TMRI1/HIRQ12/CSYNCI

		mov	#task32o, r0h
		mov	#300, r1
		jsr	schedBackTaskDelayed

		mov	#-1, r0h
		mov	r0h, @byte_ffe525
		mov	#-1, r0
		mov	r0, @word_ffec5a
		mov	r0, @word_ffec5c
		mov	#0, r0h

loc_0d8a8:	mov	#sub_0de34, er1
		jsr	sub_0d588
.if level < 0x01000063
		mov	#2, r1
		jsr	sub_0d5a4
.endif

		inc	r0h
		cmp	#4, r0h
		blo	loc_0d8a8

.if level >= 0x01000063
		mov	#0, r0h
		mov	#2, r1
		jsr	sub_0d5a4
.endif

		rts

; ----------------------------------------------

sub_0d8c4:	mov	@byte_ffe3d7, r0h
		cmp	#6, r0h
		bne	sub_0d8d6

		mov	#5, r0h
		mov	r0h, @byte_ffe3d7

sub_0d8d6:	mov	@byte_ffe3d7, r0h
		cmp	#0x0c, r0h
		blo	rts_0d8ea

		mov	#task32o, r0h
		mov	#0, r1
		jsr	schedBackTaskDelayed

rts_0d8ea:	rts

; ----------------------------------------------

task32:		mov	@byte_ffe3d7, r0h
		mov	#off_0d8fc, er1
		jmp	switch_er1_r0h


off_0d8fc:	case  0 sub_0d944 sub_0d91a sub_0da22 sub_0d944
		case  4 sub_0da2e sub_0da48 sub_0d99c sub_0dad6
		case  8 sub_0d98a sub_0d9d8 sub_0daf0 sub_0db3a
		case 12 sub_0d9ee sub_0d95c sub_0d97a

; ----------------------------------------------

sub_0d91a:	mov	@byte_ffe525, r0h
		cmp	#-1, r0h
		beq	loc_0d938

		mov	#0, r0h
		jsr	sub_0b42e

		cmp	#2, r0h
		beq	loc_0d938

		mov	#1, r0h
		jsr	sub_0b42e

		cmp	#2, r0h
		bne	loc_0d940

loc_0d938:	b set	p45dr			; Pin P45/TMRI1/HIRQ12/CSYNCI (Port 4 Data Register)
		bra	sub_0d9dc:16

loc_0d940:	mov	#4, r0h
		bra	sub_0d970

; ----------------------------------------------

sub_0d944:	mov	#task32o, r0h
		jsr	checkSchedTask

		bcc	loc_0d952

		bsr	sub_0d9dc:16

		bra	rts_0d95a

loc_0d952:	mov	#task32o, r0h
		jsr	schedFrontTask

		set	c

rts_0d95a:	rts

; ----------------------------------------------

sub_0d95c:	mov	#task32o, r0h
		jsr	checkSchedTask

		bcs	loc_0d96e

		mov	#task32o, r0h
		jsr	schedFrontTask

		clr	c
		bra	rts_0d978

loc_0d96e:	mov	#1, r0h

; ----------------------------------------------

sub_0d970:	mov	r0h, @byte_ffe3d7
		set	c

rts_0d978:	rts

; ----------------------------------------------

sub_0d97a:	jsr	sub_074d0

		bcs	loc_0d986

		mov	#1, r0h
		bsr	sub_0d970

		bra	rts_0d988

loc_0d986:	bsr	sub_0d95c

rts_0d988:	rts

; ----------------------------------------------

sub_0d98a:	mov	#byte_ffe523, er0
		mov	@er0, r1h
		dec	r1h
		mov	r1h, @er0
		beq	sub_0d9dc

		mov	#5, r0h
		bra	sub_0d970

; ----------------------------------------------

sub_0d99c:	mov	@word_ffec62, r0
		mov	@word_ffec60, r1
		mov	@word_ffec5e, r2
		sub	r1, r0
		sub	r2, r0
		shar	r0h
		rotxr	r0l
		shar	r0h
		rotxr	r0l
		shar	r0h
		rotxr	r0l
		mov	@byte_ffe523, r1l
		shll	r1l
		mov	#word_ffec5e, er2
		sub	r1l, r2l
		subx	#0, r2h
		bcc	loc_0d9d4

		dec	#1, e2

loc_0d9d4:	mov	r0, @er2
		bra	sub_0d9dc

sub_0d9d8:	b clr	p45dr			; Pin P45/TMRI1/HIRQ12/CSYNCI (Port 4 Data Register)

sub_0d9dc:	mov	@byte_ffe3d7, r0h
		inc	r0h
		mov	r0h, @byte_ffe3d7
		set	c
		rts

; ----------------------------------------------

sub_0d9ee:	jsr	sub_01276

		bcs	loc_0d9fa

		mov	#250, r1
		bra	loc_0da0a

loc_0d9fa:	jsr	sub_074d0

		bcs	loc_0da06

		mov	#2000, r1
		bra	loc_0da0a

loc_0da06:	mov	#10000, r1

loc_0da0a:	mov	#task32o, r0h
		jsr	schedBackTaskDelayed

		jsr	sub_074d0

		bcs	loc_0da1a

		bsr	sub_0d9dc

		bra	rts_0da20

loc_0da1a:	mov	#0x0e, r0h
		bsr	sub_0d970:16

rts_0da20:	rts

; ----------------------------------------------

sub_0da22:	mov	#task32o, r0h
		mov	#2, r1
		jsr	schedBackTaskDelayed

		bra	sub_0d9dc

; ----------------------------------------------

sub_0da2e:	mov	#byte_0dad2, er0
		mov	er0, @long_ffec64
		mov	#4, r1h
		mov	r1h, @byte_ffe523
		bsr	sub_0daa4

		bra	sub_0d9dc

; ----------------------------------------------

sub_0da48:	mov	@byte_ffe525, r0h
		cmp	#-1, r0h
		beq	loc_0da7e

		mov	@long_ffec64, er0
		mov	@er0, r0h
		cmp	#0, r0h
		bne	loc_0da72

		mov	#0, r0h

loc_0da62:	jsr	sub_0b42e

		cmp	#2, r0h
		beq	loc_0da70

		mov	#7, r0h
		jmp	sub_0d970

loc_0da70:	bra	loc_0da7e

loc_0da72:	cmp	#2, r0h
		bne	loc_0da7a

		mov	#1, r0h
		bra	loc_0da62

loc_0da7a:	b clr	p45dr			; Pin P45/TMRI1/HIRQ12/CSYNCI (Port 4 Data Register)

loc_0da7e:	mov	@long_ffec64, er0
		mov	@er0, r0h
		jsr	sub_0d574

		mov	@byte_ffe525, r0l
		bset	r0h, r0l
		mov	r0l, @byte_ffe525
		mov	#task32o, r0h
		jsr	schedFrontTask

		jmp	sub_0d9dc

; ----------------------------------------------

sub_0daa4:	mov	#0x0a, r0h
		mov	r0h, @byte_ffe524
		mov	#0, r0
		mov	r0, @word_ffec60
		mov	#0x7fff, r0
		mov	r0, @word_ffec5e
		mov	#0, r0
		mov	r0, @word_ffec62
		mov	r0l, @byte_ffe526
		rts

; ----------------------------------------------

byte_0dad2:	.byte 0, 2, 1, 3

; ----------------------------------------------

sub_0dad6:	mov	@long_ffec64, er0
		adds	#1, er0
		mov	er0, @long_ffec64
		jsr	sub_0daa4

		jmp	sub_0d9dc

; ----------------------------------------------

sub_0daf0:	jsr	sub_074d0

		bcc	loc_0db2e

		jsr	sub_01272

		bcc	loc_0db2e

		mov	#-1, r0h
		jsr	sub_0db7a

		bcs	loc_0db2e

		mov	#0x51, r0
		mov	@byte_ffe525, r2h
		btst	#0, r2h
		beq	loc_0db1c

		mov	@word_ffec56, r1
		cmp	r0, r1
		bhs	loc_0db2e

loc_0db1c:	btst	#2, r2h
		beq	loc_0db2e

		mov	@word_ffec58, r1
		cmp	r0, r1
		bhs	loc_0db2e

		jsr	sub_017a0

loc_0db2e:	mov	#0, r0h
		mov	r0h, @byte_ffe525
		jmp	sub_0d9dc

; ----------------------------------------------

sub_0db3a:	mov	#0, r0h
		bsr	sub_0db46

		mov	#1, r0h
		bsr	sub_0db46

		jmp	sub_0d9dc

; ----------------------------------------------

sub_0db46:	push	er0
		bsr	sub_0db7a

		bcc	loc_0db54

		jsr	sub_0c400

		set	c

loc_0db54:	pop	er0
		btst	r0h, @byte_ffff2b:8
		stc	ccr, r0l
		bld	#0, r0l
		bxor	#2, r0l
		bcc	rts_0db78

		bnot	r0h, @byte_ffff2b:8
.ifeq type1R && level < 0x01030069
		push	r0
.endif
		jsr	sub_0b90c

.ifeq type1R && level < 0x01030069
		pop	r0
		jsr	sub_0b4a6

.if !type1R
		jsr	sub_0cbf2
.endif
.endif

rts_0db78:	rts

; ----------------------------------------------

sub_0db7a:	push	er0
		bsr	sub_0dbb2

		pop	er0
		bcs	loc_0db8a

		set	c
		bra	rts_0dbb0

loc_0db8a:	cmp	#0, r0h
		bne	loc_0db96

		mov	@word_ffec5a, r1
		bra	loc_0dbaa

loc_0db96:	cmp	#-1, r0h
		bne	loc_0dba4

		mov	#0, r0h
		bsr	sub_0db7a

		bcc	rts_0dbb0

		mov	#1, r0h
		bra	sub_0db7a

loc_0dba4:	mov	@word_ffec5c, r1

loc_0dbaa:	mov	#880, r2
		cmp	r1, r2

rts_0dbb0:	rts

; ----------------------------------------------

sub_0dbb2:	jsr	sub_0126e

		bcc	loc_0dbbe

		jsr	sub_074d0

		bcc	loc_0dbbe

loc_0dbbe:	set	c
		rts

; ----------------------------------------------

sub_0dbc2:	cmp	#1, r0h
		beq	loc_0dbce

		mov	@word_ffec5a, r0
		bra	loc_0dbd4

loc_0dbce:	mov	@word_ffec5c, r0

loc_0dbd4:	mov	#word_0dc10, er1
		mov	@er1, e0
		cmp	e0, r0
		bhs	rts_0dc0e

		mov	#word_0de30, er3

loc_0dbe6:	mov	er3, er2
		sub	er1, er2
		shlr	#2, er2
		shlr	er2
		bcc	loc_0dbf2

		inc	#1, er2

loc_0dbf2:	shll	#2, er2
		add	er1, er2
		cmp	er3, er2
		bne	loc_0dc00

		mov	@(2,er1), r0
		bra	rts_0dc0e

loc_0dc00:	mov	@er2, e0
		cmp	e0, r0
		bhi	loc_0dc0a

		mov	er2, er1
		bra	loc_0dc0c

loc_0dc0a:	mov	er2, er3

loc_0dc0c:	bra	loc_0dbe6

rts_0dc0e:	rts


word_0dc10:	.word 917, -15
		.word 912, -14
		.word 908, -13
		.word 903, -12
		.word 898, -11
		.word 893, -10
		.word 888,  -9
		.word 882,  -8
		.word 877,  -7
		.word 871,  -6
		.word 865,  -5
		.word 859,  -4
		.word 853,  -3
		.word 847,  -2
		.word 840,  -1
		.word 834,   0
		.word 827,   1
		.word 820,   2
		.word 813,   3
		.word 806,   4
		.word 799,   5
		.word 791,   6
		.word 784,   7
		.word 776,   8
		.word 768,   9
		.word 761,  10
		.word 753,  11
		.word 745,  12
		.word 736,  13
		.word 728,  14
		.word 719,  15
		.word 711,  16
		.word 702,  17
		.word 694,  18
		.word 685,  19
		.word 676,  20
		.word 667,  21
		.word 659,  22
		.word 650,  23
		.word 640,  24
		.word 632,  25
		.word 622,  26
		.word 613,  27
		.word 604,  28
		.word 595,  29
		.word 586,  30
		.word 577,  31
		.word 568,  32
		.word 558,  33
		.word 549,  34
		.word 540,  35
		.word 531,  36
		.word 522,  37
		.word 513,  38
		.word 504,  39
		.word 495,  40
		.word 487,  41
		.word 478,  42
		.word 469,  43
		.word 461,  44
		.word 452,  45
		.word 444,  46
		.word 435,  47
		.word 427,  48
		.word 419,  49
		.word 411,  50
		.word 403,  51
		.word 395,  52
		.word 387,  53
		.word 379,  54
		.word 371,  55
		.word 364,  56
		.word 356,  57
		.word 349,  58
		.word 342,  59
		.word 335,  60
		.word 328,  61
		.word 321,  62
		.word 314,  63
		.word 307,  64
		.word 301,  65
		.word 295,  66
		.word 288,  67
		.word 282,  68
		.word 276,  69
		.word 270,  70
		.word 264,  71
		.word 258,  72
		.word 253,  73
		.word 247,  74
		.word 242,  75
		.word 237,  76
		.word 231,  77
		.word 226,  78
		.word 221,  79
		.word 216,  80
		.word 212,  81
		.word 207,  82
		.word 202,  83
		.word 198,  84
		.word 193,  85
		.word 189,  86
		.word 185,  87
		.word 181,  88
		.word 177,  89
		.word 173,  90
		.word 169,  91
		.word 166,  92
		.word 162,  93
		.word 158,  94
		.word 155,  95
		.word 151,  96
		.word 148,  97
		.word 144,  98
		.word 141,  99
		.word 138, 100
		.word 135, 101
		.word 132, 102
		.word 129, 103
		.word 126, 104
		.word 124, 105
		.word 121, 106
		.word 118, 107
		.word 116, 108
		.word 113, 109
		.word 111, 110
		.word 110, 111
		.word 108, 112
		.word 106, 113
		.word 103, 114
		.word 101, 115
		.word  99, 116
		.word  97, 117
		.word  95, 118
		.word  93, 119
		.word  91, 120

word_0de30:	.word  82, 125

; ----------------------------------------------

sub_0de34:	stm	er0-er2, @-sp
		mov	@word_ffec60, r1
		cmp	r1, r3
		ble	loc_0de48

		mov	r3, @word_ffec60

loc_0de48:	mov	@word_ffec5e, r1
		cmp	r1, r3
		bge	loc_0de58

		mov	r3, @word_ffec5e

loc_0de58:	mov	@word_ffec62, r1
		add	r3, r1
		mov	r1, @word_ffec62
		mov	@byte_ffe526, r0l
		inc	r0l
		mov	r0l, @byte_ffe526
		mov	@byte_ffe524, r0h
		cmp	r0h, r0l
		blo	loc_0de92

		mov	@long_ffec64, er0
		mov	@er0, r0h
		jsr	sub_0d57e

		mov	#task32o, r0h
		jsr	schedBackTask

loc_0de92:	ldm	@sp+, er0-er2
		rts

; ----------------------------------------------

rts_0de98:	rts

; ----------------------------------------------

sub_0de9a:	b set	icrc.icrc1		; LPCH (Interrupt Control Register C)
		b ld	pc2pin			; Pin PC2 (Port C Input Data Register)
		bst	#0, @byte_ffff2d:8
		bst	#5, @byte_ffe593	; 0x34
		b ld	pc3pin			; Pin PC3 (Port C Input Data Register)
		bst	#3, @byte_ffff2d:8
.if !type1R
		bst	#6, @byte_ffe56d	; 0x0e
.endif
		setOutH c 2			; Pin PC2
		setOutL c 3			; Pin PC3
.if !type1R
		mov	#task33o, r0h
		jsr	schedFrontTask
.endif

		mov	#0, r0h
		mov	r0h, @byte_ffff2c
		mov	r0h, @byte_ffe554
		mov	r0h, @byte_ffe555
		jsr	sub_0e12e

		mov	#4, r0h
		mov	#sub_0e216, er1
		jsr	sub_0d588

		mov	#5, r0h
		mov	#sub_0e234, er1
		jsr	sub_0d588

.if type1R
		mov	#task33o, r0h
		jsr	schedFrontTask
.endif

		rts

; ----------------------------------------------

task33_2_3:
.if level >= 0x01000062
		clr	c
		rts
.endif

; ----------------------------------------------

task33_1:
.if level >= 0x01000062
		btst	#6, @byte_ffff2d
		beq	loc_0df40

		mov	#task33o, r0h
		jsr	checkSchedTask

		bcc	loc_0e0e4:16

		jsr	sub_0e12e

		bclr	#6, @byte_ffff2d
.endif

loc_0df40:	btst	#1, @byte_ffff2d:8
		beq	loc_0df4a

		jsr	sub_0e2f8

loc_0df4a:	btst	#0, @byte_ffff2c:8
		beq	loc_0e0e4:16

		mov	@byte_ffe52a, r0l
		mov	@byte_ffe530, r2l
		shlr	r0l
		cmp	r2l, r0l
		blo	loc_0e0e4:16

		mov	@byte_ffe527, r0l
		shlr	r0l
		cmp	r2l, r0l
		blo	loc_0e0e4:16

		bset	#2, @byte_ffff2d:8
		btst	#6, @byte_ffff2c:8
		beq	loc_0df96

		mov	@tick, r0
		mov	r0l, @twr1		; LPC Bidirectional Data Register 1
		mov	r0h, @twr2		; LPC Bidirectional Data Register 2
		bclr	#6, @byte_ffff2c:8
		bset	#7, @byte_ffff2c:8
		bra	loc_0dfce

loc_0df96:	btst	#7, @byte_ffff2c:8
		beq	loc_0dfce

		mov	@byte_ffe556, r0l
		inc	r0l
		cmp	#100, r0l
		blo	loc_0dfc8

		mov	@tick, r0
		mov	r0l, @twr3		; LPC Bidirectional Data Register 3
		mov	r0h, @twr4		; LPC Bidirectional Data Register 4
		mov	#0, r0l
		mov	r0l, @twr15		; LPC Bidirectional Data Register 15
		b set	hicr_2.ibfie3		; IDR3 & TWR Receive Completion Interrupt Enable (LPC Host Interface Control Register 2)
		bclr	#7, @byte_ffff2c:8
		mov	#0, r0l

loc_0dfc8:	mov	r0l, @byte_ffe556

loc_0dfce:	zero	er0
		zero	er1

loc_0dfd6:	mov	@(word_ffec68,er0), e1
		add	e1, r1
		add	#2, er0
		dec	r2l
		bne	loc_0dfd6

.if level < 0x01000062
		mov	@byte_ffe530, r2l
		extu	r2
		extu	er1
		divxu	r2, er1
		set	i
		mov	@byte_ffe529, r0l
		cmp	#10, r0l
		blo	loc_0d2ba

		mov	@word_ffec8a, er0
		mov	er0, @word_ffec88
		mov	@word_ffec8e, er0
		mov	er0, @word_ffec8c
		mov	#8, r0l

loc_0d2ba:	extu	r0
		extu	er0
		mov	r1, @(word_ffec88, er0)
		add	#2, r0l
		mov	r0l, @byte_ffe529
		clr	i
.endif
		jsr	sub_0e176

		mov	@byte_ffe530, r2l
.if level >= 0x01000062
		extu	r2
		extu	er1
		divxu	r2, er1
		btst	#7, @byte_ffff2d:8
		beq	loc_0e00e

		mov	@word_ffecf0, r1
		inc	#1, r1
		mov	r1, @word_ffecf0

loc_0e00e:	mov	r1, @long_ffecca+0x1e
		mov	@byte_ffe530, r2l
.endif
		zero	er0
		zero	er1

loc_0e022:	mov	@(word_ffeca8,er0), e1
		add	e1, r1
		add	#2, er0
		dec	r2l
		bne	loc_0e022

.if level >= 0x01000062
		jsr	sub_0e18e
.endif

		mov	@byte_ffe530, r2l
		extu	r2
		extu	er1
		divxu	r2, er1
.if level < 0x01000062
		set	i
		mov	@byte_ffe52c, r0l
		cmp	#0x0a, r0l
		blo	1f

		mov	@long_ffecca, er0
		mov	er0, @word_ffecc8
		mov	@word_ffecce, er0
		mov	er0, @word_ffeccc
		mov	#8, r0l

1:		extu	r0
		extu	er0
		mov	r1, @(word_ffecc8, er0)

		add	#2, r0l
		mov	r0l, @byte_ffe52c

		clr	i
		jsr	sub_0e18e
		btst	#1, @byte_ffff2c:8
		beq	loc_0e0e4
		set	i
		mov	@byte_ffe52f, r0l

		cmp	#5, r0l
		bhs	loc_0e0e2
		inc	r0l
.else
		btst	#7, @byte_ffff2d:8
		beq	loc_0e05a

		mov	@word_ffecf2, r1
		inc	#1, r1
		mov	r1, @word_ffecf2

loc_0e05a:	mov	r1, @word_ffecea
		set	i
		btst	#1, @byte_ffff2c:8
		beq	loc_0e0e2:16

		mov	@byte_ffe528, r0l
		extu	r0
		extu	er0
		mov	@long_ffecca+0x1e, r1
		mov	r1, @(word_ffec88,er0)
		add	#2, r0l
		cmp	#0x12, r0l
		blo	loc_0e08a

		mov	#0, r0l

loc_0e08a:	mov	r0l, @byte_ffe528
		mov	@byte_ffe52b, r0l
		extu	r0
		extu	er0
		mov	@word_ffecea, r1
		mov	r1, @(word_ffecc8,er0)
		add	#2, r0l
		cmp	#0x12, r0l
		blo	loc_0e0b0

		mov	#0, r0l

loc_0e0b0:	mov	r0l, @byte_ffe52b
		mov	@byte_ffe52f, r0l
		inc	r0l
		cmp	#9, r0l
		blo	loc_0e0dc

		mov	@byte_ffe528, r0l
		mov	r0l, @byte_ffe529
		mov	@byte_ffe52b, r0l
		mov	r0l, @byte_ffe52c
		mov	#9, r0l
.endif

loc_0e0dc:	mov	r0l, @byte_ffe52f

loc_0e0e2:	clr	i

loc_0e0e4:	bclr	#2, @byte_ffff2d:8
		clr	c
		rts

; ----------------------------------------------

.if !type1R
		mov	#0, r1l
		mov	#0x20, r1h

loc_0e0f0:	shll	er0
		addx	#0, r1l
		dec	r1h
		bne	loc_0e0f0

		rts
.endif

; ----------------------------------------------

sub_0e0fa:
.if level >= 0x01000062
		b set	pc2odr			; Pin PC2 (Port C Output Data Register)
.endif
		rts

; ----------------------------------------------

sub_0e102:
.if level >= 0x01000062
		bld	#5, @byte_ffff2d
		bcc	loc_0e128

		b clr	pc2odr			; Pin PC2 (Port C Output Data Register)
		jsr	sub_0e12e

		mov	#task33o, r0h
		mov	#10, r1
		jsr	schedBackTaskDelayed

		bset	#6, @byte_ffff2d

loc_0e128:	set	c
.endif
		rts

; ----------------------------------------------

rts_0e12c:	rts

; ----------------------------------------------

sub_0e12e:	bclr	#1, @byte_ffff2c:8
		bclr	#3, @byte_ffff2c:8
.if level >= 0x01000062
		bclr	#0, @byte_ffff2e:8
		bclr	#1, @byte_ffff2e:8
.endif
		mov	#0, r0h
		mov	r0h, @byte_ffe527
.if level >= 0x01000062
		mov	r0h, @byte_ffe528
.endif
		mov	r0h, @byte_ffe529
.if level >= 0x01000062
		mov	r0h, @byte_ffe52a
.endif
		mov	r0h, @byte_ffe52b
		mov	r0h, @byte_ffe52c
		mov	r0h, @byte_ffe52f
		mov	r0h, @byte_ffe52d
		jsr	sub_048e4

		rts

; ----------------------------------------------

.if level < 0x01000062
sub_0d3a8:	stm	er0-er1, @-sp
		mov	#byte_ffe529, er0
		mov	#word_ffec88, er1
		bsr	sub_0e1a6

		ldm	@sp+, er0-er1
		rts
.endif

; ----------------------------------------------

sub_0e176:	stm	er0-er1, @-sp
		mov	#byte_ffe527, er0
		mov	#word_ffec68, er1
		bsr	sub_0e1a6

		ldm	@sp+, er0-er1
		rts

; ----------------------------------------------

.if level < 0x01000062
sub_0d3d8:	stm	er0-er1, @-sp
		mov	#byte_ffe52c, er0
		mov	#word_ffecc8, er1
		bsr	sub_0e1a6

		ldm	@sp+, er0-er1
		rts
.endif

; ----------------------------------------------

sub_0e18e:	stm	er0-er1, @-sp
		mov	#byte_ffe52a, er0
		mov	#word_ffeca8, er1
		bsr	sub_0e1a6

		ldm	@sp+, er0-er1
		rts

; ----------------------------------------------

sub_0e1a6:	push	er0
		mov	@er0, r2l
		zero	r2h
		mov	er1, er0
		add	#2, er0

loc_0e1b6:	mov	@er0, e2
		mov	e2, @er1
		add	#2, er0
		add	#2, er1
		add	#2, r2h
		cmp	r2l, r2h
		blo	loc_0e1b6

		subx	#2, r2l
		pop	er0
		mov	r2l, @er0
		rts

; ----------------------------------------------

sub_0e1d6:	push	er0
		bcc	loc_0e1ec

		bclr	#3, @byte_ffff2c:8
		mov	r0l, @byte_ffe52d
		bset	#1, @byte_ffff2c:8
		bra	loc_0e208

loc_0e1ec:	btst	#1, @byte_ffff2c:8
		beq	loc_0e208

		btst	#3, @byte_ffff2c:8
		bne	loc_0e208

		mov	@byte_ffe52e, r0l
		inc	r0l
		cmp	#0x0a, r0l
		bls	loc_0e20a

		bset	#3, @byte_ffff2c:8

loc_0e208:	mov	#0, r0l

loc_0e20a:	mov	r0l, @byte_ffe52e
		pop	er0
		rts

; ----------------------------------------------

sub_0e216:	stm	er0-er2, @-sp
		btst	#0, @byte_ffff2c:8
		beq	loc_0e22e

		mov	#byte_ffe527, er0
		mov	#word_ffec68, er1
		bsr	sub_0e252

loc_0e22e:	ldm	@sp+, er0-er2
		rts

; ----------------------------------------------

sub_0e234:	stm	er0-er2, @-sp
		btst	#0, @byte_ffff2c:8
		beq	loc_0e24c

		mov	#byte_ffe52a, er0
		mov	#word_ffeca8, er1
		bsr	sub_0e252

loc_0e24c:	ldm	@sp+, er0-er2
		rts

; ----------------------------------------------

sub_0e252:	mov	@er0, r2l
		extu	r2
		extu	er2
		add	er1, er2
		mov	r3, @er2
		mov	@er0, r2l
		add	#2, r2l
		cmp	#0x20, r2l
		blo	loc_0e268

		bsr	sub_0e1a6:16

loc_0e268:	mov	r2l, @er0
		rts

; ----------------------------------------------

sub_0e26c:	btst	#1, @byte_ffff2d:8
		bne	loc_0e278

		btst	#4, @byte_ffff2d:8
		beq	loc_0e27c

loc_0e278:	mov	#6, r0h
		bra	loc_0e2f2

loc_0e27c:	mov	@twr1, r1l		; LPC Bidirectional Data Register 1
		mov	@twr2, r1h		; LPC Bidirectional Data Register 2
		cmp	#0, r1
		bne	loc_0e292

		mov	#task33o, r0h
		jsr	schedFrontTask

		bra	loc_0e2d0

loc_0e292:	cmp	#500, r1
		bls	loc_0e29c

		mov	#3, r0h
		bra	loc_0e2f2

loc_0e29c:	mov	r1, @byte_ffecee
		mov	@twr3, r0h		; LPC Bidirectional Data Register 3
		beq	loc_0e2b4

		cmp	#8, r0h
		bhi	loc_0e2b4

		mov	r0h, @byte_ffe531
		bra	loc_0e2b8

loc_0e2b4:	mov	#3, r0h
		bra	loc_0e2f2

loc_0e2b8:	mov	#9 - 4 & (level < 0x01000062), r0h
		mov	r0h, @byte_ffe533
		bra	loc_0e2c6

		mov	#3, r0h
		bra	loc_0e2f2

loc_0e2c6:	mov	#task33o, r0h
		jsr	schedBackTask

		bset	#1, @byte_ffff2d:8

loc_0e2d0:	mov	#4, r0h
		jsr	sub_0d57e

		mov	#5, r0h
		jsr	sub_0d57e

		bclr	#0, @byte_ffff2c:8
		mov	#0, r0h
.if level >= 0x01000062
		mov	#0, r0
		mov	r0, @word_ffecf0
		mov	r0, @word_ffecf2
.endif

loc_0e2f2:	mov	r0h, @twr15		; LPC Bidirectional Data Register 15
		rts

; ----------------------------------------------

sub_0e2f8:	mov	@byte_ffecee, r1
		mov	r1, @word_ffecec
		mov	#1000, er0
		divxu	r1, er0
		mov	r0, r1
.if level < 0x01000063
		mov	#4, r0h
		jsr	sub_0d5a4

		mov	#5, r0h
.else
		mov	#1, r0h
.endif
		jsr	sub_0d5a4

		mov	@byte_ffe531, r0h
		mov	r0h, @byte_ffe530
		mov	#4, r0h
		jsr	sub_0d574

		mov	#5, r0h
		jsr	sub_0d574

		mov	@byte_ffe533, r0h
		mov	r0h, @byte_ffe532
		jsr	sub_0e12e

		bset	#0, @byte_ffff2c:8
		bclr	#1, @byte_ffff2d:8
		rts

; ----------------------------------------------

sub_0e346:	btst	#4, @byte_ffff2d:8
		bne	loc_0e44e:16

		bld	#0, @byte_ffff2c:8
		band	#1, @byte_ffff2c:8
		bcc	loc_0e44e:16

		jsr	sub_0e45a

		mov	@byte_ffe52f, r0l
		beq	loc_0e44e:16

		cmp	#2, r0l
		blo	loc_0e376

		mov	#2, r0h
		mov	r0h, @twr1		; LPC Bidirectional Data Register 1
		subx	#2, r0l
		bra	loc_0e37c

loc_0e376:	mov	r0l, @twr1		; LPC Bidirectional Data Register 1
		mov	#0, r0l

loc_0e37c:	mov	r0l, @twr12		; LPC Bidirectional Data Register 12
		mov	r0l, @byte_ffe52f
		mov	@byte_ffe52d, r0h
		mov	@twr1, r0l		; LPC Bidirectional Data Register 1
		mov	#twr2 & M24, er1	; LPC Bidirectional Data Register 2
.if level < 0x01000062
		zero	er2
.endif

loc_0e396:
.if level >= 0x01000062
		mov	@byte_ffe529, r2l
		extu	r2
		extu	er2
.endif
		mov	@(word_ffec88,er2), r3
		mov	r3l, @er1
		add	#1, er1
		mov	r3h, @er1
		add	#1, er1
.if level >= 0x01000062
		add	#2, r2l
		cmp	#0x12, r2l
		blo	loc_0e3c0

		mov	#0, r2l

loc_0e3c0:	mov	r2l, @byte_ffe529
		mov	@byte_ffe52c, r2l
		extu	r2
		extu	er2
.endif
		mov	@(word_ffecc8,er2), r3
		mov	r3l, @er1
		add	#1, er1
		mov	r3h, @er1
		add	#1, er1
		mov	r0h, @er1
		add	#1, er1
.if level < 0x01000062
		add	#2, er2
.else
		add	#2, r2l
		cmp	#0x12, r2l
		blo	loc_0e3f8

		mov	#0, r2l

loc_0e3f8:	mov	r2l, @byte_ffe52c
.endif
		dec	r0l
		bne	loc_0e396

.if level < 0x01000062
		mov	@twr1, r0l		; LPC Bidirectional Data Register 1
		beq	2f

1:		jsr	sub_0d3a8

		jsr	sub_0d3d8

		dec	r0l
		bne	1b

2:
.endif
		jsr	sub_074bc

		bst	#7, @twr13		; LPC Bidirectional Data Register 13
		jsr	sub_048d0

		bst	#6, @twr13		; LPC Bidirectional Data Register 13
		jsr	sub_048da

		bst	#5, @twr13		; LPC Bidirectional Data Register 13
		jsr	sub_048fa

.if level >= 0x01000062
		bld	#0, @byte_ffff2e:8
		bst	#4, @twr13		; LPC Bidirectional Data Register 13
		bld	#1, @byte_ffff2e:8
		bst	#3, @twr13		; LPC Bidirectional Data Register 13
		bclr	#0, @byte_ffff2e:8
		bclr	#1, @byte_ffff2e:8
.endif
		btst	#3, @byte_ffff2c:8
		beq	loc_0e44a

		mov	#5, r0h
		bra	loc_0e454

loc_0e44a:	mov	#0, r0h
		bra	loc_0e454

loc_0e44e:	mov	#0, r0h
		mov	r0h, @twr1		; LPC Bidirectional Data Register 1

loc_0e454:	mov	r0h, @twr15		; LPC Bidirectional Data Register 15
		rts

; ----------------------------------------------

sub_0e45a:	mov	#twr1 & M24, er0	; LPC Bidirectional Data Register 1
		mov	#0, r1l
		mov	#0x0e, r1h

loc_0e464:	mov	r1l, @er0
		inc	#1, er0
		dec	r1h
		bne	loc_0e464

		rts

; ----------------------------------------------

sub_0e46e:	mov	#0, r0l
		btst	#0, @byte_ffff2d:8
		beq	loc_0e480

		mov	#1, r0l
		btst	#3, @byte_ffff2d:8
		bne	loc_0e480

		mov	#3, r0l

loc_0e480:	mov	r0l, @twr1		; LPC Bidirectional Data Register 1
		mov	#3, r0l
		mov	r0l, @twr2		; LPC Bidirectional Data Register 2
		mov	#0, r0l
		mov	r0l, @twr3		; LPC Bidirectional Data Register 3
		mov	r0l, @twr4		; LPC Bidirectional Data Register 4
		mov	#0, r0l
		mov	r0l, @twr15		; LPC Bidirectional Data Register 15
		rts

; ----------------------------------------------

sub_0e49c:	mov	@twr1, r0l		; LPC Bidirectional Data Register 1
		beq	loc_0e4a6

		clr	c
		bra	loc_0e4a8

loc_0e4a6:	set	c

loc_0e4a8:	b st	pc2odr			; Pin PC2 (Port C Output Data Register)
.if level >= 0x01000062
		bist	#5, @byte_ffff2d
.endif
		mov	#0, r0l
		mov	r0l, @twr15		; LPC Bidirectional Data Register 15
		rts

; ----------------------------------------------

sub_0e4be:	btst	#2, @byte_ffff2c:8
		bne	loc_0e4c8

		mov	#4, r0l
		bra	loc_0e516

loc_0e4c8:	mov	@byte_ffe554, r0l
		extu	r0
		extu	er0
		mov	#0, r2l
		mov	@byte_ffe555, r2h
		mov	#twr2 & M24, er1	; LPC Bidirectional Data Register 2

loc_0e4e0:	mov	@(byte_ffe534,er0), r3l
		mov	r3l, @er1
		inc	r2l
		inc	#1, er1
		inc	#1, er0
		cmp	r2h, r0l
		bhs	loc_0e4fc

		cmp	#twr12 & M24, er1	; LPC Bidirectional Data Register 12
		blo	loc_0e4e0

loc_0e4fc:	mov	r2l, @twr1		; LPC Bidirectional Data Register 1
		mov	r0l, @byte_ffe554
		sub	r0l, r2h
		mov	r2h, @twr12		; LPC Bidirectional Data Register 12
		bne	loc_0e514

		mov	r2h, @byte_ffe554

loc_0e514:	mov	#0, r0l

loc_0e516:	mov	r0l, @twr15		; LPC Bidirectional Data Register 15
		rts

; ----------------------------------------------

sub_0e51c:	bclr	#2, @byte_ffff2c:8
		mov	@byte_ffe554, r0l
		extu	r0
		extu	er0
		mov	@twr1, r2l		; LPC Bidirectional Data Register 1
		mov	#twr2 & M24, er1	; LPC Bidirectional Data Register 2

loc_0e534:	mov	@er1, r3l
		mov	r3l, @(byte_ffe534,er0)
		inc	#1, er1
		inc	#1, er0
		cmp	#0x20, er0
		blo	loc_0e550

		mov	#0, er0

loc_0e550:	dec	r2l
		bne	loc_0e534

		mov	@twr12, r1l		; LPC Bidirectional Data Register 12
		bne	loc_0e566

		mov	r0l, @byte_ffe555
		mov	r1l, r0l
		bset	#2, @byte_ffff2c:8

loc_0e566:	mov	r0l, @byte_ffe554
		mov	#0, r0l
		mov	r0l, @twr15		; LPC Bidirectional Data Register 15
		rts

; ----------------------------------------------

sub_0e574:	mov	@twr1, r0l		; LPC Bidirectional Data Register 1
		cmp	#0x80, r0l
		blo	loc_0e598

		cmp	#0x80 + num_0e5a0 - 1, r0l
		bhi	loc_0e598

		and	#0x0f, r0l
		shll	#2, r0l
		extu	r0
		extu	er0
		mov	@(off_0e5a0,er0), er0
		jsr	@er0

		mov	#0, r0l
		bra	loc_0e59a

loc_0e598:	mov	#3, r0l

loc_0e59a:	mov	r0l, @twr15		; LPC Bidirectional Data Register 15
		rts


off_0e5a0:	.long rts_0e5b0, sub_0e5b2, sub_0e5c6
.if level >= 0x01000062
		.long sub_0e5fe
.endif
	num_0e5a0 = (. - off_0e5a0) / 4

; ----------------------------------------------

rts_0e5b0:	rts

; ----------------------------------------------

sub_0e5b2:	mov	#0, r0l
		mov	r0l, @twr1		; LPC Bidirectional Data Register 1
		mov	#(num_0e5a0 - 1) << 5, r0l
		mov	r0l, @twr2		; LPC Bidirectional Data Register 2
		mov	#0, r0l
		mov	r0l, @twr3		; LPC Bidirectional Data Register 3
		rts

; ----------------------------------------------

sub_0e5c6:	zero	r0
		bld	#0, @byte_ffff2c:8
		bst	#0, r0l
		bld	#1, @byte_ffff2d:8
		bst	#1, r0l
		bld	#2, @byte_ffff2d:8
		bst	#2, r0l
		bld	#4, @byte_ffff2d:8
		bst	#3, r0l
		mov	r0l, @twr1		; LPC Bidirectional Data Register 1
		mov	@word_ffecec, r0
		mov	r0l, @twr2		; LPC Bidirectional Data Register 2
		mov	r0h, @twr3		; LPC Bidirectional Data Register 3
		mov	@byte_ffe530, r0l
		mov	r0l, @twr4		; LPC Bidirectional Data Register 4
		rts

; ----------------------------------------------

.if level >= 0x01000062
sub_0e5fe:	mov	@twr2, r0l		; LPC Bidirectional Data Register 2
		cmp	#1, r0l
		bist	#7, @byte_ffff2d:8
		rts
.endif

; ----------------------------------------------

sub_0e60a:	bset	#6, @byte_ffff2c:8
		rts

; ----------------------------------------------

sub_0e610:	bld	#0, @byte_ffff2d:8
		rts

; ----------------------------------------------

.if level >= 0x01000062
enterStandby1:	bset	#0, @byte_ffff2e:8
		rts

; ----------------------------------------------

enterHibernation1:
		bset	#1, @byte_ffff2e:8
		rts
.endif

; ----------------------------------------------

rts_0e622:	rts

; ----------------------------------------------

sub_0e624:
.if level < 0x01000062
		bset	#5, @byte_ffff2c:8
.endif
		mov	#0, r0h
.if level < 0x01000062
		mov	r0h, @byte_ffe558
.endif
		mov	r0h, @byte_ffe557
		rts

; ----------------------------------------------

task34_1:
.if level >= 0x01000062
		btst	#5, @byte_ffff2c:8
		beq	loc_0e644

		mov	@word_ffed10, r0
		jsr	sub_016e4

		bcc	loc_0e644

		jsr	sub_0e920
.endif

loc_0e644:	mov	@byte_ffe557, r0h
		mov	#off_0e660, er1
		jsr	switch_er1_r0h

		bcs	rts_0e65e

		mov	#task34o, r0h
		jsr	schedFrontTask

		clr	c

rts_0e65e:	rts


off_0e660:	case  0 sub_0e694 sub_0e6b4 sub_0e870 sub_0e890
.if level < 0x01000062
		case  4 sub_0e8a0 sub_0e8b8 sub_0e8f0 sub_0e8b4
		case  8 sub_0e8d8 sub_0e934 sub_0e96c sub_0e890
		case 12 sub_0e8b4 sub_0e8d8 sub_0e984 sub_0e8b4
		case 16 sub_0e8d8 sub_0da0a sub_0e9bc sub_0e890
		case 20 sub_0e8b4 sub_0e8d8 sub_0da90 sub_0e9d4
.else
		case  4 sub_0e8a0 sub_0e70c sub_0e8b4 sub_0e8d8
		case  8 sub_0e734 sub_0e7d6 sub_0e8f0 sub_0e70c
		case 12 sub_0e8b4 sub_0e8d8 sub_0e734 sub_0e7d6
		case 16 sub_0e934 sub_0e96c sub_0e890 sub_0e70c
		case 20 sub_0e8b4 sub_0e8d8 sub_0e734 sub_0e7d6
		case 24 sub_0e984 sub_0e9d4
.endif

; ----------------------------------------------

sub_0e694:	btst	#5, @byte_ffff2c:8
		beq	loc_0e6a0

		bsr	sub_0e6a4

		set	c
		bra	rts_0e6a2

loc_0e6a0:	clr	c

rts_0e6a2:	rts

; ----------------------------------------------

sub_0e6a4:	mov	@byte_ffe557, r0h
		inc	r0h
		mov	r0h, @byte_ffe557
		rts

; ----------------------------------------------

sub_0e6b4:	bclr	#0, @byte_ffff2c:8
		jsr	sub_0e12e

loc_0e6bc:	mov	#2, r1
.if level < 0x01000063
		mov	#4, r0h
		jsr	sub_0d5a4

		mov	#5, r0h
.else
		mov	#1, r0h
.endif
		jsr	sub_0d5a4

		mov	#4, r0h
		jsr	sub_0d57e

		mov	#5, r0h
		jsr	sub_0d57e

		bsr	sub_0e6a4

		set	c
		rts

; ----------------------------------------------

.if level >= 0x01000062
sub_0e6d8:	mov	#0, r0h
		mov	r0h, @byte_ffe527
		mov	r0h, @byte_ffe528
		mov	r0h, @byte_ffe529
		mov	r0h, @byte_ffe52a
		mov	r0h, @byte_ffe52b
		mov	r0h, @byte_ffe52c
		mov	r0h, @byte_ffe52f
		mov	r0h, @byte_ffe52d
		bra	loc_0e6bc

; ----------------------------------------------

sub_0e70c:	mov	#long_ffecf8, er0
		mov	#byte_ffe558, er1
		jsr	sub_0e7f2

		mov	#long_ffed02, er0
		mov	#byte_ffe559, er1
		jsr	sub_0e7f2

		bsr	sub_0e6a4:16

		set	c
		rts

; ----------------------------------------------

sub_0e734:	mov	@byte_ffe529, r2l
		extu	r2
		extu	er2
		mov	@(word_ffec88,er2), r1
		add	#2, r2l
		cmp	#0x12, r2l
		blo	loc_0e74e

		mov	#0, r2l

loc_0e74e:	mov	r2l, @byte_ffe529
		mov	#long_ffecf8, er0
		mov	#byte_ffe558, er2
		jsr	sub_0e858

		mov	@byte_ffe52c, r2l
		extu	r2
		extu	er2
		mov	@(word_ffecc8,er2), r1
		add	#2, r2l
		cmp	#0x12, r2l
		blo	loc_0e77e

		mov	#0, r2l

loc_0e77e:	mov	r2l, @byte_ffe52c
		mov	#long_ffed02, er0
		mov	#byte_ffe559, er2
		jsr	sub_0e858

		bsr	sub_0e6a4:16

		mov	#long_ffecf8, er0
		jsr	sub_0e810

		bcs	loc_0e7c8

		mov	r1, @word_ffed0c
		mov	#long_ffed02, er0
		jsr	sub_0e810

		bcs	loc_0e7c8

		mov	r1, @word_ffed0e
		bsr	sub_0e6a4:16

		mov	#task34o, r0h
		mov	#0, r1
		bra	loc_0e7ce

loc_0e7c8:	mov	#task34o, r0h
		mov	#200, r1

loc_0e7ce:	jsr	schedBackTaskDelayed

		set	c
		rts

; ----------------------------------------------

sub_0e7d6:	mov	#task34o, r0h
		jsr	checkSchedTask

		bcc	rts_0e7f0

		mov	@byte_ffe557, r0h
		mov	#3, r0l
		sub	r0l, r0h
		mov	r0h, @byte_ffe557
		set	c

rts_0e7f0:	rts

; ----------------------------------------------

sub_0e7f2:	mov	#0, r2
		mov	r2l, @er1
		mov	#0, r1l

loc_0e7fa:	mov	r2, @er0
		add	#2, er0
		inc	r1l
		cmp	#4, r1l
		blo	loc_0e7fa

		mov	#-1, r2
		mov	r2, @er0
		rts

; ----------------------------------------------

sub_0e810:	mov	#0, r3l
		mov	@er0, r1
		mov	r1, r2
		mov	r1, e2
		add	#2, er0
		inc	r3l

loc_0e820:	mov	@er0, r1
		cmp	r2, r1
		blo	loc_0e82a

		mov	r1, r2
		bra	loc_0e830

loc_0e82a:	cmp	e2, r1
		bhi	loc_0e830

		mov	r1, e2

loc_0e830:	add	#2, er0
		inc	r3l
		cmp	#5, r3l
		blo	loc_0e820

		mov	er2, er3
		mov	e2, r1
		extu	er1
		extu	er2
		add	er2, er1
		shlr	er1
		sub	e3, r3
		cmp	#4, r3
		bls	loc_0e854

		set	c
		bra	rts_0e856

loc_0e854:	clr	c

rts_0e856:	rts

; ----------------------------------------------

sub_0e858:	mov	@er2, r3l
		extu	r3
		extu	er3
		add	er3, er0
		add	er3, er0
		mov	r1, @er0
		inc	r3l
		cmp	#5, r3l
		blo	loc_0e86c

		mov	#0, r3l

loc_0e86c:	mov	r3l, @er2
		rts
.endif

; ----------------------------------------------

sub_0e870:	b clr	pc2odr			; Pin PC2 (Port C Output Data Register)
.if level >= 0x01000062
		bset	#5, @byte_ffff2d
.endif
		mov	#task34o, r0h
		mov	#10, r1
		jsr	schedBackTaskDelayed

.if level < 0x01000062
		bsr	sub_0e6a4
.else
		bsr	sub_0e6a4:16
.endif

		set	c
		rts

; ----------------------------------------------

sub_0e890:	mov	#task34o, r0h
		jsr	checkSchedTask

		bcc	rts_0e89e

.if level < 0x01000062
		bsr	sub_0e6a4
.else
		bsr	sub_0e6a4:16
.endif

		set	c

rts_0e89e:	rts

; ----------------------------------------------

sub_0e8a0:	mov	#11 - 4 & (level < 0x01000062), r0h
		btst	#3, @byte_ffff2d:8
		bne	loc_0e8aa

		mov	#5, r0h

loc_0e8aa:	mov	r0h, @byte_ffe557
		set	c
		rts

; ----------------------------------------------

sub_0e8b4:	mov	#5 - 4 & (level < 0x01000062), r0h
		bra	loc_0e8ba

sub_0e8b8:	mov	#10, r0h

loc_0e8ba:	mov	r0h, @byte_ffe530
		mov	#4, r0h
		jsr	sub_0d574

		mov	#5, r0h
		jsr	sub_0d574

		bset	#0, @byte_ffff2c:8
		bsr	sub_0e6a4:16

		set	c
		rts

; ----------------------------------------------

sub_0e8d8:
.if level < 0x01000062
		mov	@byte_ffe529, r0l
		beq	loc_0e8ec

		mov	@byte_ffe52c, r0l
		beq	loc_0e8ec

		bsr	sub_0e6b4:16
.else
		mov	@byte_ffe52f, r0l
		beq	loc_0e8ec

		dec	r0l
		mov	r0l, @byte_ffe52f
		bsr	sub_0e6d8:16
.endif

loc_0e8ec:	set	c
		rts

; ----------------------------------------------

sub_0e8f0:
.if level < 0x01000062
		mov	@byte_ffe529, r0l
		beq	loc_0e930

		mov	@byte_ffe52c, r0l
		beq	loc_0e930

		mov	@word_ffec88, r0
		cmp	#0x3a2, r0
		bhi	sub_0e920

		mov	@word_ffecc8, r0
		cmp	#0x3a2, r0
		bls	loc_0e924
.else
		mov	@word_ffed0c, r0
		cmp	#0x26c, r0
		bhi	sub_0e920

		cmp	#0x9b, r0
		blo	sub_0e920

		mov	@word_ffed0e, r0
		cmp	#0x26c, r0
		bhi	sub_0e920

		cmp	#0x9b, r0
		blo	sub_0e920

		mov	#0x19, r0h
		mov	r0h, @byte_ffe557
		set	c
		rts
.endif


sub_0e920:	bset	#4, @byte_ffff2c:8

loc_0e924:	bsr	sub_0e6b4:16

		mov	#0x19 - 2 & (level < 0x01000062), r0h
		mov	r0h, @byte_ffe557

loc_0e930:	set	c
		rts

; ----------------------------------------------

sub_0e934:
.if level < 0x01000062
		mov	@word_ffec88, r0
		mov	r0, @word_ffecf0
		mov	@word_ffecc8, r0
		mov	r0, @word_ffecf2
.else
		mov	@word_ffed0c, r0
		mov	r0, @word_ffecf4
		cmp	#0x39b, r0
		bhi	sub_0e920

		cmp	#0x64, r0
		blo	sub_0e920

		mov	@word_ffed0e, r0
		mov	r0, @word_ffecf6
		cmp	#0x39b, r0
		bhi	sub_0e920

		cmp	#0x64, r0
		blo	sub_0e920
.endif

		bsr	sub_0e6a4:16

		set	c
		rts

; ----------------------------------------------

sub_0e96c:	b set	pc3odr			; Pin PC3 (Port C Output Data Register)
		mov	#task34o, r0h
		mov	#5, r1
		jsr	schedBackTaskDelayed

		bsr	sub_0e6a4:16

		set	c
		rts

; ----------------------------------------------

sub_0e984:
.if level < 0x01000062
		mov	@word_ffecf0, r0
		mov	@word_ffec88, r1
		mov	r1, @word_ffed0c
.else
		mov	@word_ffecf4, r0
		mov	@word_ffed0c, r1
.endif
		sub	r0, r1
		bcs	sub_0e920

		cmp	#20 - 10 & (level < 0x01000062), r1
		blo	sub_0e920

.if level < 0x01000062
		mov	r1, @word_ffecf4
		mov	@word_ffecf2, r0
		mov	@word_ffecc8, r1
		mov	r1, @word_ffed0e
.else
		mov	@word_ffecf6, r0
		mov	@word_ffed0e, r1
.endif
		sub	r0, r1
		bcs	sub_0e920:16

		cmp	#20 - 10 & (level < 0x01000062), r1
		blo	sub_0e920:16

.if level < 0x01000062
		mov	r1, @word_ffecf6
.endif
		bsr	sub_0e6a4:16

		set	c
		rts

; ----------------------------------------------

.if level < 0x01000062
sub_0da0a:	mov	#word_ffec88, er0
		mov	#word_ffed0c, er1
		bsr	sub_0da5a

		bcs	sub_0e920:16

		mov	#word_ffecc8, er0
		mov	#word_ffed0e, er1
		bsr	sub_0da5a

		bcs	sub_0e920:16

		mov	@byte_ffe558, r0l
		inc	r0l
		cmp	#10, r0l
		bhs	loc_0da4a

		mov	r0l, @byte_ffe558
		mov	#15, r0h
		mov	r0h, @byte_ffe557
		bra	loc_0da56

loc_0da4a:	mov	#0, r0h
		mov	r0h, @byte_ffe558
		bsr	sub_0e6a4:16

loc_0da56:	set	c
		rts

; ----------------------------------------------

sub_0da5a:	mov	@er0, r2
		mov	@er1, r3
		add	#10, r3
		cmp	r3, r2
		bhi	loc_0da74

		sub	#20, r3
		cmp	r3, r2
		blo	loc_0da74

		mov	r2, @er1
		clr	c
		bra	loc_0da76

loc_0da74:	set	c

loc_0da76:	rts
.endif

; ----------------------------------------------

sub_0e9bc:	b clr	pc3odr			; Pin PC3 (Port C Output Data Register)
		mov	#task34o, r0h
		mov	#5, r1
		jsr	schedBackTaskDelayed

		bsr	sub_0e6a4:16

		set	c
		rts

; ----------------------------------------------

.if level < 0x01000062
sub_0da90:	mov	@word_ffed0c, r0
		mov	@word_ffecf4, r1
		sub	r1, r0
		mov	@word_ffec88, r1
		add	#10, r0
		cmp	r0, r1
		bhi	sub_0e920:16

		sub	#20, r0
		cmp	r0, r1
		blo	sub_0e920:16

		mov	@word_ffed0e, r0
		mov	@word_ffecf6, r1
		sub	r1, r0
		mov	@word_ffecc8, r1
		add	#10, r0
		cmp	r0, r1
		bhi	sub_0e920:16

		sub	#20, r0
		cmp	r0, r1
		blo	sub_0e920:16

		bra	sub_0dae2

sub_0dae2:	bsr	sub_0e6a4:16

		set	c
		rts
.endif

; ----------------------------------------------

sub_0e9d4:	btst	#5, @byte_ffff2c:8
		beq	loc_0e9f8

.if level < 0x01000062
		btst	#4, @byte_ffff2c:8
		beq	0f

		bset	#2, @byte_ffe56d

0:
.else
		bld	#4, @byte_ffff2c:8
		bst	#2, @byte_ffe56d	; 0x0e
.endif
		bclr	#5, @byte_ffff2c:8
		b set	pc2odr			; Pin PC2 (Port C Output Data Register)
.if level >= 0x01000062
		bclr	#5, @byte_ffff2d
.endif

loc_0e9f8:
.if level >= 0x01000062
		bclr	#5, @byte_ffe56d	; 0x0e
.endif
		bclr	#4, @byte_ffff2d:8
.if level >= 0x01000062
		b clr	pc3odr			; Pin PC3 (Port C Output Data Register)
.endif
		mov	#0, r0h
		mov	r0h, @byte_ffe557
		clr	c
		rts

; ----------------------------------------------

rts_0ea16:	rts

; ----------------------------------------------

task34_2_3:	clr	c
		rts

; ----------------------------------------------

.if level >= 0x01000062
sub_0ea1c:	btst	#1, @byte_ffff2d:8
		bne	rts_0ea5a

		btst	#4, @byte_ffff2d:8
		bne	rts_0ea5a

		bset	#5, @byte_ffff2c:8
		mov	@word_ffe9be, r0
		add	#0x1e, r0
		mov	r0, @word_ffed10
		mov	#0, r0h
		mov	r0h, @byte_ffe557
		bset	#4, @byte_ffff2d:8
		bset	#5, @byte_ffe56d	; 0x0e
		bclr	#4, @byte_ffff2c:8
		mov	#task34o, r0h
		jsr	schedBackTask

rts_0ea5a:	rts
.endif

; ----------------------------------------------

.if !type1R
		bild	#4, @byte_ffff2d:8
		rts
.endif

; ----------------------------------------------

sub_0ea62:	mov	@twr1, r0h		; LPC Bidirectional Data Register 1
		beq	loc_0ea7a

		cmp	#1, r0h
		beq	loc_0ea70

		mov	#3, r0h
		bra	loc_0eaaa

loc_0ea70:	btst	#4, @byte_ffff2c:8
		beq	loc_0eaa8

		mov	#1, r0h
		bra	loc_0eaaa

loc_0ea7a:	btst	#1, @byte_ffff2d:8
		bne	loc_0ea86

		btst	#4, @byte_ffff2d:8
		beq	loc_0ea8a

loc_0ea86:	mov	#6, r0h
		bra	loc_0eaaa

loc_0ea8a:	bset	#4, @byte_ffff2d:8
.if level >= 0x01000062
		bset	#5, @byte_ffe56d	; 0x0e
.endif
		bclr	#4, @byte_ffff2c:8
		mov	#1, r0h
		mov	r0h, @byte_ffe557
		mov	#task34o, r0h
		jsr	schedBackTask

loc_0eaa8:	mov	#0, r0h

loc_0eaaa:	mov	r0h, @twr15		; LPC Bidirectional Data Register 15
		rts

; ----------------------------------------------

sub_0eab0:
.if level >= 0x01000062
		mov	@twr1, r0h		; LPC Bidirectional Data Register 1
		beq	loc_0eac2

		cmp	#1, r0h
		bhi	loc_0eaca

		b set	pc3odr			; Pin PC3 (Port C Output Data Register)
		bra	loc_0eace

loc_0eac2:	b clr	pc3odr			; Pin PC3 (Port C Output Data Register)
		bra	loc_0eace

loc_0eaca:	mov	#3, r0h
		bra	loc_0ead0

loc_0eace:	mov	#0, r0h

loc_0ead0:	mov	r0h, @twr15		; LPC Bidirectional Data Register 15
		rts
.endif

; ----------------------------------------------

sleep:		set	i
		bsr	setWaitTime		; 13.1 ms @ 10 MHz

.if type1R
		bsr	setupSleep
.else
		bsr	setupSleep:16

		b set	iscrh.irq7sca		; IRQ7 Sense Control A (IRQ Sense Control Register H)
		b clr	isr.irq7f		; IRQ7 Flag (IRQ Status Register)
		b set	ier.irq7e		; IRQ7 Enable (Interrupt Enable Register)
		b set	iscrh.irq6sca		; IRQ6 Sense Control A (IRQ Sense Control Register H)
		b clr	isr.irq6f		; IRQ6 Flag (IRQ Status Register)
		b set	ier.irq6e		; IRQ6 Enable (Interrupt Enable Register)
		bclr	#1, @byte_ffe55a
		bclr	#2, @byte_ffe55a
.endif
		clr	i
		sleep
.if !type1R
		set	i
		bsr	sub_0ec3a:16

		clr	i
.endif
		b clr	lpwrcr.excle		; Subclock Input Enable (Low-Power Control Register)
		b clr	lpwrcr.dton		; Direct Transfer On Flag (Low-Power Control Register)
		b clr	lpwrcr.lson		; Low-Speed On Flag (Low-Power Control Register)
		b clr	sbycr.ssby		; Software Standby (Standby Control Register)
		rts

; ----------------------------------------------

sub_0eb2c:	mov	#0, r1l
		mov	r1l, @byte_ffe55a
		b set	lpwrcr.excle		; Subclock Input Enable (Low-Power Control Register)
		mov	@wtcsr_1:8, r1l		; WDT_1 Watchdog Timer Control & Status Register
		bclr	#6, r1l
		bset	#5, r1l
		bset	#4, r1l
		bclr	#2, r1l
		bclr	#1, r1l
		bclr	#0, r1l
		mov	#0xa5, r1h		; tcsr write
		mov	r1, @wtcsr_1		; WDT_1 Watchdog Timer Control & Status Register
		rts

; ----------------------------------------------

sub_0eb4e:	bld	#0, @byte_ffe55a
		rts

; ----------------------------------------------

; 13.1 ms @ 10 MHz

setWaitTime:	b set	sbycr.sts2		; Standby Timer Select 2 (Standby Control Register)
		b clr	sbycr.sts1		; Standby Timer Select 1 (Standby Control Register)
		b clr	sbycr.sts0		; Standby Timer Select 0 (Standby Control Register)
		rts

; ----------------------------------------------

setupSleep:	b clr	ier.irq0e		; IRQ0 Enable (Interrupt Enable Register)
		mov	@wtcsr_1:8, r1l		; WDT_1 Watchdog Timer Control & Status Register
		bclr	#6, r1l
		bset	#5, r1l
		bset	#2, r1l
		bclr	#1, r1l
		bclr	#0, r1l
		mov	#0xa5, r1h		; tcsr write
		mov	r1, @wtcsr_1		; WDT_1 Watchdog Timer Control & Status Register
		mov	#0x19, r0h		; watch mode: 4 excle=1, 3 ssby=1, 2 dton=0, 1 lson=0, 0 pss=1
		bra	loc_0eb92

		b set	iscrl.irq0sca		; IRQ0 Sense Control A (IRQ Sense Control Register L)
		b clr	iscrl.irq0scb		; IRQ0 Sense Control B (IRQ Sense Control Register L)
		b set	ier.irq0e		; IRQ0 Enable (Interrupt Enable Register)
		mov	#0x08, r0h		; standby mode: 4 excle=0, 3 ssby=1, 2 dton=0, 1 lson=0, 0 pss=0

loc_0eb92:	bld	#4, r0h
		b st	lpwrcr.excle		; Subclock Input Enable (Low-Power Control Register)
		bld	#3, r0h
		b st	sbycr.ssby		; Software Standby (Standby Control Register)
		bld	#2, r0h
		b st	lpwrcr.dton		; Direct Transfer On Flag (Low-Power Control Register)
		bld	#1, r0h
		b st	lpwrcr.lson		; Low-Speed On Flag (Low-Power Control Register)
		mov	@wtcsr_1:8, r1l		; WDT_1 Watchdog Timer Control & Status Register
		bld	#0, r0h
		bst	#4, r1l			; pss
		mov	#0xa5, r1h		; tcsr write
		mov	r1, @wtcsr_1		; WDT_1 Watchdog Timer Control & Status Register
		rts

; ----------------------------------------------

.if type1R
; WDT_1 Watchdog Interval Timer

wovi1:		stm	er0-er1, @-sp
		mov	@wtcsr_1:8, r0l		; WDT_1 Watchdog Timer Control & Status Register
		bclr	#5, r0l
		bclr	#7, r0l
		mov	#0xa5, r0h		; tcsr write
		mov	r0, @wtcsr_1		; WDT_1 Watchdog Timer Control & Status Register
		btst	#0, @byte_ffe55a
		bne	0f

		bset	#0, @byte_ffe55a
		bra	1f

0:		mov	#263, r0
		mov	@tick, r1
		add	r1, r0
		mov	r0, @tick

1:		ldm	@sp+, er0-er1
		rte
.endif

; ----------------------------------------------

; External Interrupt Request 0

irq0:		stm	er0-er1, @-sp
		mov	#250, r0
		mov	@tick, r1
		add	r1, r0
		mov	r0, @tick
		ldm	@sp+, er0-er1
		rte

; ----------------------------------------------

.if !type1R
; WDT_1 Watchdog Interval Timer

wovi1:		stm	er0-er1, @-sp
		btst	#0, @byte_ffe55a
		bne	loc_0ebea

		bset	#0, @byte_ffe55a

loc_0ebea:	bset	#1, @byte_ffe55a
		mov	@wtcsr_1:8, r0l		; WDT_1 Watchdog Timer Control & Status Register
		bclr	#5, r0l
		bclr	#7, r0l
		mov	#0xa5, r0h		; tcsr write
		mov	r0, @wtcsr_1		; WDT_1 Watchdog Timer Control & Status Register
		ldm	@sp+, er0-er1
		rte

; ----------------------------------------------

; External Interrupt Request 6/7

irq6_irq7:	stm	er0-er1, @-sp
		btst	#2, @byte_ffe55a
		bne	loc_0ec34

		bset	#2, @byte_ffe55a
		jsr	sub_01272

		bcs	loc_0ec24

		jsr	sub_01430

loc_0ec24:	mov	@wtcnt_1:8, r0l		; WDT_1 Watchdog Timer Counter
		mov	r0l, @byte_ffe55b
		b clr	ier.irq7e		; IRQ7 Enable (Interrupt Enable Register)
		b clr	ier.irq6e		; IRQ6 Enable (Interrupt Enable Register)

loc_0ec34:	ldm	@sp+, er0-er1
		rte

; ----------------------------------------------

sub_0ec3a:	mov	#263, r2
		btst	#1, @byte_ffe55a
		bne	loc_0ec60

		mov	@byte_ffe55b, r0l
		beq	loc_0ec60

		mov	r0l, r2l
		mov	#97, r1l
		mulxu	r1l, r2
		mov	#100, r1l
		divxu	r1l, r2
		extu	r2
		add	#13, r2

loc_0ec60:	mov	@tick, r1
		add	r1, r2
		mov	r2, @tick
		rts
.endif

; ----------------------------------------------

		rts
		rts
		rts
		rts
		rts
		rts
		rts

; ----------------------------------------------

sub_0ec7e:
.if !type1R
		jsr	sub_0ec84

		rts

; ----------------------------------------------

sub_0ec84:	bcc	rts_0ecbe

		mov	#0x23, r0l
		mov	#byte_ffe10b, er2
		stm	er0-er2, @-sp
		mov	r0l, @(1,er2)
		mov	#4, r0h
		mov	r0h, @(0,er2)
		bsr	sub_0ecc0

		mov	r0l, @(2,er2)
		mov	@(3,er2), r0l
		mov	@(4,er2), r0h
		add	#1, r0
		mov	r0l, @(3,er2)
		mov	r0h, @(4,er2)
		ldm	@sp+, er0-er2
		jsr	sub_14e8a

rts_0ecbe:	rts

; ----------------------------------------------

sub_0ecc0:	mov	#2, r0l
		bld	#5, @byte_ffff02
		bst	#0, r0l
		rts
.endif

; ----------------------------------------------

sub_0ecce:
.if !type1R
		mov	#byte_ffe10b, er2
		mov	#0, r0
		mov	r0l, @(3,er2)
		mov	r0h, @(4,er2)
.endif
		rts

; ----------------------------------------------

		rts
		rts

; ----------------------------------------------

init_i2c:
.if !type1R
		setOutH 4 7			; Pin P47/PWX1
.endif
		zero	er0
		b clr	mstpcrl.mstp4		; IIC_0 (Module Stop Control Register L)
		b clr	mstpcrl.mstp3		; IIC_1 (Module Stop Control Register L)
		b set	stcr.iice		; I2C Master Enable (Serial Timer Control Register)
		mov	r0h, @iccr_0:8		; IIC_0 I2C Bus Control Register
		set	i
		b set	iccr_0.ice		; I2C Bus Interface Enable (IIC_0 I2C Bus Control Register)
		mov	@icmr_0:8, r1h		; IIC_0 I2C Bus Mode Register
		and	#0xc7, r1h
		or	#0x38, r1h
		b set	stcr.iicx0		; I2C Transfer Rate Select 0 (Serial Timer Control Register)
		mov	r1h, @icmr_0:8		; IIC_0 I2C Bus Mode Register
		clr	i
		mov	r0h, @iccr_1:8		; IIC_1 I2C Bus Control Register
		set	i
		b set	iccr_1.ice		; I2C Bus Interface Enable (IIC_1 I2C Bus Control Register)
		mov	@icmr_1:8, r1h		; IIC_1 I2C Bus Mode Register
		and	#0xc7, r1h
		or	#0x38, r1h
		b set	stcr.iicx1		; I2C Transfer Rate Select 1 (Serial Timer Control Register)
		mov	r1h, @icmr_1:8		; IIC_1 I2C Bus Mode Register
		clr	i
		mov	#-1, r0h
		mov	r0h, @i2c_0+6:16	; i2c_0 state
		mov	r0h, @i2c_1+6:16	; i2c_1 state
		mov	#0, er0
		mov	r0h, @i2c_0+2:16	; i2c_0 state2
		mov	r0h, @i2c_1+2:16	; i2c_1 state2
		mov	er0, @i2c_0+14:16	; i2c_0 cmd buf
		mov	er0, @i2c_1+14:16	; i2c_1 cmd buf
		mov	#do_i2c_0o, r0h
		mov	r0h, @i2c_0+4		; i2c_0
		mov	#do_i2c_1o, r0h
		mov	r0h, @i2c_1+4		; i2c_1
		b clr	iccr_0.ice		; I2C Bus Interface Enable (IIC_0 I2C Bus Control Register)
		b clr	iccr_1.ice		; I2C Bus Interface Enable (IIC_1 I2C Bus Control Register)
		rts

; ----------------------------------------------

rts_0ed70:	rts

; ----------------------------------------------

do_i2c_0:	mov	#i2c_0, er3
		mov	#iccr_0 & M24, er4	; IIC_0 I2C Bus Control Register
		mov	#icsr_0 & M24, er5	; IIC_0 I2C Bus Status Register
		bra	do_i2c_loop

do_i2c_1:	mov	#i2c_1, er3
		mov	#iccr_1 & M24, er4	; IIC_1 I2C Bus Control Register
		mov	#icsr_1 & M24, er5	; IIC_1 I2C Bus Status Register

do_i2c_loop:	mov	@(2,er3), r0h		; i2c state2
		mov	#off_0edb6, er1
		jsr	switch_er1_r0h

		bcs	do_i2c_loop

		mov	@(2,er3), r0h		; i2c state2
		bne	1f

		clr	c
		bra	rts_0edb4

1:		set	c
rts_0edb4:	rts


off_0edb6:	case  0 i2c_case0  i2c_case1     i2c_case2     i2c_case3
		case  4 i2c_case4  i2c_case5     i2c_case6     i2c_case7
		case  8 i2c_case8  i2c_case9     i2c_case10    i2c_case11
		case 12 i2c_case12 i2c_case13_14 i2c_case13_14 i2c_case15
		case 16 i2c_case16

; ----------------------------------------------

i2c_case0:	mov	@(0x0e,er3), er0	; cmd buf pointer
		beq	loc_0ede8

		bsr	incrState2:16

		set	c
		bra	rts_0edfe

loc_0ede8:
.if !type1R
		cmp	#i2c_0, er3
		bne	1f

0:		b set	p47dr			; Pin P47/PWX1 (Port 4 Data Register)

1:
.endif
		mov	@(4,er3), r0h		; do_i2c_0o/do_i2c_1o
		jsr	schedFrontTask

		clr	c

rts_0edfe:	rts

; ----------------------------------------------

i2c_case1:	mov	@(0x0e,er3), er0	; cmd buf pointer
		mov	@er0, r0h
		and	#3, r0h
		mov	@(3,er3), r0l
		cmp	r0h, r0l
		beq	loc_0ee38

		mov	r0h, @(3,er3)
		push	er3
		push	er4
		push	er5
		jsr	sub_02006

		pop	er5
		pop	er4
		pop	er3
		bsr	incrState2:16

		bra	loc_0ee3e

loc_0ee38:	mov	#4, r0h			; state2 = 4
		mov	r0h, @(2,er3)

loc_0ee3e:
.if !type1R
		cmp	#i2c_0, er3
		bne	1f

0:		b clr	p47dr			; Pin P47/PWX1 (Port 4 Data Register)

1:
.endif
		set	c
		rts

; ----------------------------------------------

i2c_case4:	mov	#8, r0h
		mov	r0h, @(1,er3)
		bsr	incrState2:16

		set	c
		rts

; ----------------------------------------------

i2c_case9:	mov	@(0x0e,er3), er2	; cmd buf pointer
		mov	@(i2c20o:16,er2), r1l
		extu	r1
		bra	loc_0ee74

i2c_case5:	mov	#50, r1
		bra	loc_0ee74

i2c_case2:	mov	#20, r1

loc_0ee74:	mov	@(4,er3), r0h		; do_i2c_0o/do_i2c_1o
		push	er3
		stm	er4-er5, @-sp
		jsr	schedBackTaskDelayed

		ldm	@sp+, er4-er5
		pop	er3
		bsr	incrState2:16

		set	c
		rts

; ----------------------------------------------

i2c_case3:	mov	@(4,er3), r0h		; do_i2c_0o/do_i2c_1o
		push	er3
		stm	er4-er5, @-sp
		jsr	checkSchedTask

		ldm	@sp+, er4-er5
		pop	er3
		bcc	loc_0eeb6

		bsr	incrState2:16

		set	c
		bra	rts_0eec0

loc_0eeb6:	mov	@(4,er3), r0h		; do_i2c_0o/do_i2c_1o
		jsr	schedFrontTask

		clr	c

rts_0eec0:	rts

; ----------------------------------------------

i2c_case6:	bset	#7, @er4		; iccr.ice (I2C Bus Control Register: I2C Bus Interface Enable)
		btst	#2, @er4		; iccr.bbsy (I2C Bus Control Register: Bus Busy)
		beq	notBusy

		mov	@(4,er3), r0h		; do_i2c_0o/do_i2c_1o
		push	er3
		stm	er4-er5, @-sp
		jsr	checkSchedTask

		ldm	@sp+, er4-er5
		pop	er3
		bcc	loc_0ef0a

		cmp	#iccr_0 & M24, er4	; IIC_0 I2C Bus Control Register
		bne	1f

0:		b tst	p97dr			; Pin P97/SDA0 (Port 9 Data Register)
		bra	loc_0eef8

1:		b tst	p42dr			; Pin P42/TMRI0/SCK2/SDA1 (Port 4 Data Register)

loc_0eef8:	bne	loc_0ef04

		mov	#12, r0h
		mov	r0h, @(2,er3)		; state2 = 12
		clr	c
		bra	loc_0ef08

loc_0ef04:	bsr	incrState2:16

loc_0ef08:	bra	loc_0ef0c

loc_0ef0a:	clr	c

loc_0ef0c:	bra	rts_0ef14

notBusy:	bsr	incrState2:16

		set	c

rts_0ef14:	rts

; ----------------------------------------------

i2c_case7:	mov	@(0x0e,er3), er2	; cmd buf pointer
		zero	er0
.if level < 0x01000062
		mov	@(2,er2), r0l
		and	#0x0f, r0l
.else
		mov	@(3,er2), r0l
		mov	@(1,er2), r1l
		btst	#7, r1l
		beq	loc_0ef34

		mov	#stateTab2, er1
		bra	loc_0ef3a
.endif

loc_0ef34:	mov	#stateTab1, er1

.if level >= 0x01000062
loc_0ef3a:	and	#0x0f, r0l
.endif
		add	er0, er1
		mov	@er1, r0h
		bmi	loc_0efb4

		mov	r0h, @(6,er3)
		mov	#0, r0h
		mov	r0h, @er3
		bld	#4, @er2
		bst	#6, @er3
		bld	#3, @er2
		bst	#5, @er3
		btst	#5, @er3
		bne	loc_0ef78

		btst	#6, @er3
		beq	loc_0ef78

		mov	@(0x0e,er3), er0	; cmd buf pointer
		mov	@(i2c02o:16,er0), r1h
		bsr	sub_0f30e:16

		mov	r0h, @(8,er3)

loc_0ef78:	mov	@(0x0e,er3), er2	; cmd buf pointer
		mov	#0, r0h
		mov	r0h, @(5,er3)
		mov	r0h, @(9,er3)
		mov	@(0x0e,er3), er2	; cmd buf pointer
		mov	@(i2c05o:16,er2), r0h
		mov	@(i2c02o:16,er2), r0h
		mov	r0h, @(7,er3)
		mov	#0, r0h
		mov	r0h, @(i2c04o:16,er2)
		mov	@(i2c08o:16,er2), er1
		mov	er1, @(0x0a,er3)
		bsr	incrState2:16

		set	c
		bra	rts_0efc2

loc_0efb4:	mov	#0x19, r0h
		bsr	sub_0f0c2:16

		mov	#0, r0h
		mov	r0h, @(2,er3)		; state2 = 0
		clr	c

rts_0efc2:	rts


stateTab1:	.byte -1			;  0
		.byte -1			;  1
		.byte 29			;  2
		.byte 31			;  3
		.byte 23			;  4
		.byte 26			;  5
		.byte 13			;  6
		.byte 17			;  7
		.byte 13			;  8
		.byte 17			;  9
		.byte  0			; 10
		.byte  5			; 11
		.byte -1			; 12
		.byte -1			; 13
		.byte 13			; 14
		.byte 17			; 15

.if level >= 0x01000062
stateTab2:	.byte -1			;  0
		.byte -1			;  1
		.byte -1			;  2
		.byte -1			;  3
		.byte -1			;  4
		.byte -1			;  5
		.byte -1			;  6
		.byte -1			;  7
		.byte -1			;  8
		.byte 33			;  9
		.byte -1			; 10
		.byte -1			; 11
		.byte -1			; 12
		.byte -1			; 13
		.byte -1			; 14
		.byte -1			; 15
.endif

; ----------------------------------------------

; setup master transmit mode, enable interrupts

i2c_case8:	mov	er4, er0
		add	#7, er0			; icmr (I2C Bus Mode Register)
		bclr	#6, @er0		; icmr.wait (I2C Bus Mode Register: Wait Insertion Bit)
		bset	#3, @er4		; iccr.acke (I2C Bus Control Register: Acknowledge Bit Decision and Selection)
		set	i
		mov	@er4, r0h		; iccr (I2C Bus Control Register)
		bset	#5, r0h			; iccr.mst Set Master Mode
		bset	#4, r0h			; iccr.trs Set Transmit Mode
		mov	r0h, @er4		; iccr (I2C Bus Control Register)
		clr	i
		set	i
		bclr	#1, @er4		; iccr.iric (I2C Bus Interface Interrupt Request Flag)
		bset	#6, @er4		; iccr.ieic (I2C Bus Interface Interrupt Enable)
		bset	#4, @er3
		mov	@er4, r0h		; iccr (I2C Bus Control Register)
		bset	#2, r0h			; iccr.bbsy (Bus Busy)
		bclr	#0, r0h			; iccr.scp (Start/Stop Condition Prohibit): Issue Start & Restart Condition
		mov	r0h, @er4		; iccr (I2C Bus Control Register)
		clr	i
		bsr	incrState2:16

		set	c
		rts

; ----------------------------------------------

i2c_case10:	mov	@(6,er3), r0h
		bpl	loc_0f090

		btst	#7, @er3
		bne	loc_0f084

		btst	#6, @er3
		beq	loc_0f07a

		btst	#5, @er3
		beq	loc_0f07a

		mov	@(0x0e,er3), er0	; cmd buf pointer
		mov	@(7,er3), r1h
		bsr	sub_0f30e:16

		mov	@(8,er3), r0l
		cmp	r0h, r0l
		beq	loc_0f070

		mov	@(1,er3), r0h
		bne	loc_0f05e

		mov	#0x1f, r0h
		bsr	sub_0f0c2

		bsr	incrState2:16

		bra	loc_0f06e

loc_0f05e:	dec	r0h
		mov	r0h, @(1,er3)
		bsr	i2c_case11:16		; reset I2C bus

		mov	#5, r0h
		mov	r0h, @(2,er3)		; state2 = 5

loc_0f06e:	bra	loc_0f078

loc_0f070:	mov	#0, r0h
		bsr	sub_0f0c2

		bsr	incrState2:16

loc_0f078:	bra	loc_0f082

loc_0f07a:	mov	#0, r0h
		bsr	sub_0f0c2

		bsr	incrState2:16

loc_0f082:	bra	loc_0f08e

loc_0f084:	mov	@(9,er3), r0h
		bsr	sub_0f0c2

		bsr	incrState2:16

loc_0f08e:	bra	loc_0f0be

loc_0f090:	mov	@(4,er3), r0h		; do_i2c_0o/do_i2c_1o
		push	er3
		stm	er4-er5, @-sp
		jsr	checkSchedTask

		ldm	@sp+, er4-er5
		pop	er3
		bcc	loc_0f0b6

		mov	#0x18, r0h
		bsr	sub_0f0c2

		mov	#16, r0h
		mov	r0h, @(2,er3)		; state2 = 16
		bra	loc_0f0be

loc_0f0b6:	mov	@(4,er3), r0h		; do_i2c_0o/do_i2c_1o
		jsr	schedFrontTask

loc_0f0be:	clr	c
		rts

; ----------------------------------------------

sub_0f0c2:	bsr	sub_0f4de:16

		mov	@(0x0e,er3), er2	; cmd buf pointer
		mov	r0h, @(i2c04o:16,er2)
		cmp	#0, r0h
		bne	loc_0f0e4

		mov	@(i2c03o:16,er2), r0l
		cmp	#0x0b, r0l
		bne	loc_0f0e4

		mov	@(7,er3), r0l
		mov	r0l, @(i2c02o:16,er2)

loc_0f0e4:	mov	@(i2c16o:16,er2), er6
		mov	er6, @(0x0e,er3)	; cmd buf pointer
		zero	er6
		mov	er6, @(i2c16o:16,er2)
		bclr	#7, @er2
		bset	#6, @er2
		mov	@(i2c12o:16,er2), er6
		beq	rts_0f12c

		mov	@(i2c02o:16,er2), r0l
		mov	@(i2c04o:16,er2), r0h
		beq	loc_0f118

		set	c
		bra	loc_0f11a

loc_0f118:	clr	c

loc_0f11a:	stm	er2-er3, @-sp
		stm	er4-er5, @-sp
		jsr	@er6

		ldm	@sp+, er4-er5
		ldm	@sp+, er2-er3

rts_0f12c:	rts

; ----------------------------------------------

; Reset I2C Bus

i2c_case11:	bclr	#6, @er4		; iccr.ieic (I2C Bus Interface Interrupt Enable)
		bsr	waitClkLowMax50:16

		set	i
		mov	@er4, r0h		; iccr (I2C Bus Control Register)
		and	#~0b00000101, r0h	; clear Start/Stop Condition Prohibit & Bus Busy
		or	# 0b00110000, r0h	; set Master Transmit Mode
		mov	r0h, @er4		; iccr (I2C Bus Control Register)
		clr	i
		mov	#0, r0h
		mov	r0h, @er5		; icsr (I2C Bus Status Register)
		mov	r0h, @(2,er3)		; state2 = 0
		rts

; ----------------------------------------------

incrState2:	mov	@(2,er3), r0h		; state2
		inc	r0h
		mov	r0h, @(2,er3)		; state2
		rts

; ----------------------------------------------

; SMBus Slave/I2C Receive?

i2c_case12:	bclr	#7, @er4		; iccr.ice (I2C Bus Control Register: I2C Bus Interface Enable)
		push	er3
		stm	er4-er5, @-sp
		cmp	#iccr_0 & M24, er4	; IIC_0 I2C Bus Control Register
		bne	1f

0:		setInH	5 2			; Pin P52/SCK0/SCL0
		bra	loc_0f192

1:		setInH	8 6			; Pin P86/-IRQ5/SCK1/SCL1

loc_0f192:	ldm	@sp+, er4-er5
		pop	er3
		mov	#0x1c, r0h
		mov	r0h, @(5,er3)
		bsr	incrState2

		set	c
		rts

; ----------------------------------------------

; setClockIO

i2c_case13_14:	cmp	#iccr_0 & M24, er4	; IIC_0 I2C Bus Control Register
		bne	1f

0:		b ild	p52dr			; Pin P52/SCK0/SCL0 (Port 5 Data Register)
		bcs	clockLow_0

		push	er0
		stc	ccr, r0l
		set	i
		b clr	p52dr			; Pin P52/SCK0/SCL0 (Port 5 Data Register)
		mov	@P5DDRcopy, r0h
		bset	#2, r0h			; p52ddr = 1
		mov	r0h, @P5DDRcopy
		mov	r0h, @p5ddr:8		; Port 5 Data Direction Register
		ldc	r0l, ccr
		pop	er0
		bra	loc_0f1f6

clockLow_0:	push	er0
		stc	ccr, r0l
		set	i
		mov	@P5DDRcopy, r0h
		bclr	#2, r0h			; p52ddr = 0
		mov	r0h, @P5DDRcopy
		mov	r0h, @p5ddr:8		; Port 5 Data Direction Register
		ldc	r0l, ccr
		pop	er0

loc_0f1f6:	bra	loc_0f240

1:		b ild	p86dr			; Pin P86/-IRQ5/SCK1/SCL1 (Port 8 Data Register)
		bcs	clockLow_1

		push	er0
		stc	ccr, r0l
		set	i
		b clr	p86dr			; Pin P86/-IRQ5/SCK1/SCL1 (Port 8 Data Register)
		mov	@P8DDRcopy, r0h
		bset	#6, r0h			; p86ddr = 1
		mov	r0h, @P8DDRcopy
		mov	r0h, @p8ddr:8		; Port 8 Data Direction Register
		ldc	r0l, ccr
		pop	er0
		bra	loc_0f240

clockLow_1:	push	er0
		stc	ccr, r0l
		set	i
		mov	@P8DDRcopy, r0h
		bclr	#6, r0h			; p86ddr = 0
		mov	r0h, @P8DDRcopy
		mov	r0h, @p8ddr:8		; Port 8 Data Direction Register
		ldc	r0l, ccr
		pop	er0

loc_0f240:	bsr	incrState2:16

		clr	c
		rts

; ----------------------------------------------

i2c_case15:	cmp	#iccr_0 & M24, er4	; IIC_0 I2C Bus Control Register
		bne	1f

0:		b tst	p97dr			; Pin P97/SDA0 (Port 9 Data Register)
		bra	loc_0f25a

1:
.ifndef FIX
		b tst	p97dr			; Pin P97/SDA0 (Port 9 Data Register)
.else
		b tst	p42dr			; Pin P42/TMRI0/SCK2/SDA1 (Port 4 Data Register)
.endif

loc_0f25a:	beq	dataLow

		mov	#4, r0h
		mov	r0h, @(2,er3)		; state2 = 4
		bsr	setClockIn

		clr	c
		bra	rts_0f29a

dataLow:	mov	@(5,er3), r0h
		dec	r0h
		mov	r0h, @(5,er3)
		bne	loc_0f292

		bsr	setClockIn

		mov	@(0x0e,er3), er1	; cmd buf pointer
		mov	@(i2c08o:16,er1), er1
		mov	#0x13, r0h
		bsr	sub_0f0c2:16

		mov	#0, r0h
		mov	r0h, @(2,er3)		; state2 = 0
		clr	c
		bra	rts_0f29a

loc_0f292:	mov	#13, r0h
		mov	r0h, @(2,er3)		; state2 = 13
		set	c

rts_0f29a:	rts

; ----------------------------------------------

setClockIn:	push	er3
		push	er4
		push	er5
		cmp	#iccr_0 & M24, er4	; IIC_0 I2C Bus Control Register
		bne	1f

0:		setInH	5 2			; Pin P52/SCK0/SCL0
		bra	loc_0f2d6

1:		setInH	8 6			; Pin P86/-IRQ5/SCK1/SCL1

loc_0f2d6:	pop	er5
		pop	er4
		pop	er3
		rts

; ----------------------------------------------

; Hard Reset I2C Bus

i2c_case16:	bclr	#7, @er4		; iccr.ice (I2C Bus Control Register: I2C Bus Interface Enable)
		bset	#7, @er4		; iccr.ice (I2C Bus Control Register: I2C Bus Interface Enable)
		bsr	i2c_case11:16		; reset I2C bus

		push	er3
		stm	er4-er5, @-sp
		jsr	delay50

		ldm	@sp+, er4-er5
		pop	er3
		bclr	#7, @er4		; iccr.ice (I2C Bus Control Register: I2C Bus Interface Enable)
		bset	#7, @er4		; iccr.ice (I2C Bus Control Register: I2C Bus Interface Enable)
		rts

; ----------------------------------------------

sub_0f30e:	mov	er0, er2
		mov	#0, r0h
		mov	@(i2c03o:16,er2), r0l
		cmp	#11, r0l
		beq	loc_0f31e

		mov	@(i2c02o:16,er2), r1h

loc_0f31e:	push	er1
		mov	@(i2c03o:16,er2), r0l
		cmp	#7, r0l
		beq	loc_0f346

		cmp	#6, r0l
		beq	loc_0f346

		cmp	#9, r0l
		beq	loc_0f346

		cmp	#8, r0l
		beq	loc_0f346

		cmp	#15, r0l
		beq	loc_0f346

		cmp	#14, r0l
		beq	loc_0f346

		cmp	#10, r0l
		beq	loc_0f346

		cmp	#11, r0l
		bne	loc_0f364

loc_0f346:	mov	@(i2c05o:16,er2), r0l
		bclr	#0, r0l
		bsr	sub_0f3a4

		mov	@(i2c06o:16,er2), r0l
		bsr	sub_0f3a4

		btst	#3, @er2
		beq	loc_0f362

		mov	@(i2c05o:16,er2), r0l
		bset	#0, r0l
		bsr	sub_0f3a4

loc_0f362:	bra	loc_0f370

loc_0f364:	mov	@(i2c05o:16,er2), r0l
		bld	#3, @er2
		bst	#0, r0l
		bsr	sub_0f3a4

loc_0f370:	mov	@(i2c03o:16,er2), r0l
		cmp	#10, r0l
		beq	loc_0f37c

		cmp	#11, r0l
		bne	loc_0f384

loc_0f37c:	mov	@sp, er1		; pop+push er1
		mov	r1h, r0l
		bsr	sub_0f3a4

loc_0f384:	mov	@(i2c08o:16,er2), er1
		mov	@sp, er2		; pop+push er2

loc_0f38e:	cmp	#0, r2h
		beq	loc_0f39a

		mov	@er1+, r0l
		bsr	sub_0f3a4

		dec	r2h
		bra	loc_0f38e

loc_0f39a:	mov	#0, r0l
		bsr	sub_0f3a4

		pop	er1
		rts

; ----------------------------------------------

sub_0f3a4:	push	er2
		mov	#byte_0f3c0, er2
		add	r0h, r2l
		addx	#0, r2h
		bcc	loc_0f3b6

		inc	#1, e2

loc_0f3b6:	mov	@er2, r0h
		xor	r0l, r0h
		pop	er2
		rts


byte_0f3c0:	.byte 0x00, 0x07, 0x0e, 0x09, 0x1c, 0x1b, 0x12, 0x15
		.byte 0x38, 0x3f, 0x36, 0x31, 0x24, 0x23, 0x2a, 0x2d
		.byte 0x70, 0x77, 0x7e, 0x79, 0x6c, 0x6b, 0x62, 0x65
		.byte 0x48, 0x4f, 0x46, 0x41, 0x54, 0x53, 0x5a, 0x5d
		.byte 0xe0, 0xe7, 0xee, 0xe9, 0xfc, 0xfb, 0xf2, 0xf5
		.byte 0xd8, 0xdf, 0xd6, 0xd1, 0xc4, 0xc3, 0xca, 0xcd
		.byte 0x90, 0x97, 0x9e, 0x99, 0x8c, 0x8b, 0x82, 0x85
		.byte 0xa8, 0xaf, 0xa6, 0xa1, 0xb4, 0xb3, 0xba, 0xbd
		.byte 0xc7, 0xc0, 0xc9, 0xce, 0xdb, 0xdc, 0xd5, 0xd2
		.byte 0xff, 0xf8, 0xf1, 0xf6, 0xe3, 0xe4, 0xed, 0xea
		.byte 0xb7, 0xb0, 0xb9, 0xbe, 0xab, 0xac, 0xa5, 0xa2
		.byte 0x8f, 0x88, 0x81, 0x86, 0x93, 0x94, 0x9d, 0x9a
		.byte 0x27, 0x20, 0x29, 0x2e, 0x3b, 0x3c, 0x35, 0x32
		.byte 0x1f, 0x18, 0x11, 0x16, 0x03, 0x04, 0x0d, 0x0a
		.byte 0x57, 0x50, 0x59, 0x5e, 0x4b, 0x4c, 0x45, 0x42
		.byte 0x6f, 0x68, 0x61, 0x66, 0x73, 0x74, 0x7d, 0x7a
		.byte 0x89, 0x8e, 0x87, 0x80, 0x95, 0x92, 0x9b, 0x9c
		.byte 0xb1, 0xb6, 0xbf, 0xb8, 0xad, 0xaa, 0xa3, 0xa4
		.byte 0xf9, 0xfe, 0xf7, 0xf0, 0xe5, 0xe2, 0xeb, 0xec
		.byte 0xc1, 0xc6, 0xcf, 0xc8, 0xdd, 0xda, 0xd3, 0xd4
		.byte 0x69, 0x6e, 0x67, 0x60, 0x75, 0x72, 0x7b, 0x7c
		.byte 0x51, 0x56, 0x5f, 0x58, 0x4d, 0x4a, 0x43, 0x44
		.byte 0x19, 0x1e, 0x17, 0x10, 0x05, 0x02, 0x0b, 0x0c
		.byte 0x21, 0x26, 0x2f, 0x28, 0x3d, 0x3a, 0x33, 0x34
		.byte 0x4e, 0x49, 0x40, 0x47, 0x52, 0x55, 0x5c, 0x5b
		.byte 0x76, 0x71, 0x78, 0x7f, 0x6a, 0x6d, 0x64, 0x63
		.byte 0x3e, 0x39, 0x30, 0x37, 0x22, 0x25, 0x2c, 0x2b
		.byte 0x06, 0x01, 0x08, 0x0f, 0x1a, 0x1d, 0x14, 0x13
		.byte 0xae, 0xa9, 0xa0, 0xa7, 0xb2, 0xb5, 0xbc, 0xbb
		.byte 0x96, 0x91, 0x98, 0x9f, 0x8a, 0x8d, 0x84, 0x83
		.byte 0xde, 0xd9, 0xd0, 0xd7, 0xc2, 0xc5, 0xcc, 0xcb
		.byte 0xe6, 0xe1, 0xe8, 0xef, 0xfa, 0xfd, 0xf4, 0xf3

; ----------------------------------------------

sub_0f4c0:	mov	#byte_0f3c0, er2
		mov	er0, er3
		mov	r1h, r4h
		mov	#0, r0h

loc_0f4cc:	mov	@er3+, r0l
		jsr	sub_0f3a4

		dec	r4h
		bne	loc_0f4cc

		mov	#0, r0l
		jsr	sub_0f3a4

		rts

; ----------------------------------------------

sub_0f4de:	zero	er1
		mov	r0h, r1l
		and	#0x1f, r1l
		mov	@(byte_0f500,er1), r1l
		bmi	rts_0f4fe

		add	er3, er1
		mov	@(0x12,er1), r2h
		inc	r2h
		beq	rts_0f4fe

		mov	r2h, @(0x12,er1)

rts_0f4fe:	rts


byte_0f500:	.byte -1, -1, -1, -1, -1, -1, -1, 0, -1, -1, -1, -1, -1, -1, -1, -1
		.byte  1,  2,  3,  4, -1, -1, -1, 5,  6,  7,  8, -1, -1, -1, -1,  9

; ----------------------------------------------

; IIC_0 Transmission/Reception Completion

iici0:		b clr	iccr_0.ieic		; I2C Bus Interface Interrupt Enable (IIC_0 I2C Bus Control Register)
		clr	i
		stm	er0-er3, @-sp
.if level < 0x01000062
		stm	er4-er5, @-sp
.else
		stm	er4-er6, @-sp
.endif
		mov	#i2c_0, er3
		mov	#iccr_0 & M24, er4	; IIC_0 I2C Bus Control Register
		mov	#icsr_0 & M24, er5	; IIC_0 I2C Bus Status Register
.if level >= 0x01000062
		mov	#icxr_0 & M24, er6	; IIC_0 I2C Bus Extended Control Register
.endif
		bra	loc_0f56e


; IIC_1 Transmission/Reception Completion

iici1:		b clr	iccr_1.ieic		; I2C Bus Interface Interrupt Enable (IIC_1 I2C Bus Control Register)
		clr	i
		stm	er0-er3, @-sp
.if level < 0x01000062
		stm	er4-er5, @-sp
.else
		stm	er4-er6, @-sp
.endif
		mov	#i2c_1, er3
		mov	#iccr_1 & M24, er4	; IIC_1 I2C Bus Control Register
		mov	#icsr_1 & M24, er5	; IIC_1 I2C Bus Status Register
.if level >= 0x01000062
		mov	#icxr_1 & M24, er6	; IIC_1 I2C Bus Extended Control Register
.endif

loc_0f56e:	mov	@er5, r0h		; icsr (I2C Bus Status Register)
		btst	#3, r0h			; al (I2C Bus Status Register: Arbitration Lost Flag)
		beq	loc_0f584

		mov	#0x1a, r0h
		mov	r0h, @(9,er3)
		bset	#7, @er3
		bsr	i2c_handler4:16		; state 4  - 16  - 25 30 32  -	error

		bra	loc_0f5b4

loc_0f584:	bld	#0, r0h			; ackb (I2C Bus Status Register: Acknowledge Bit)
		band	#4, @er4		; iccr.trs (I2C Bus Control Register: Transmit/Receive Select)

		bcc	loc_0f5a2

		btst	#4, @er3
		bne	loc_0f5a2

		mov	#0x10, r0h
		mov	r0h, @(9,er3)
		bset	#7, @er3
		bsr	i2c_handler4:16		; state 4  - 16  - 25 30 32  -	error

		bra	loc_0f5b4

loc_0f5a2:	bclr	#4, @er3
		mov	@(6,er3), r0h		; i2c state
		mov	#off_0f5be, er1
		jsr	switch_er1_r0h

loc_0f5b4:
.if level < 0x01000062
		ldm	@sp+, er4-er5
.else
		ldm	@sp+, er4-er6
.endif
		ldm	@sp+, er0-er3
		rte

; er3[6]
; state  0  5 13 17 23 29  - 33  transmit er3[0xe][5] & ~1 (write)
; state  1  6 14 18  -  -  - 34  transmit er3[0xe][6]
; state  2  -  -  -  -  -  -  -  transmit er3[7]
; state  3  - 15  - 24  -  -  -  transmit er3[0xa][er3[5]++] if er3[5] < er3[7], else er3[8] if er3[0] & 1<<6
; state  4  - 16  - 25 30 32  -  --> state -1 error
; state  -  7  - 19  -  -  - 35  wait for clock low
; state  -  8  - 20 26 31  - 36  transmit er3[0xe][5] | 1 (read)
; state  -  9  -  -  -  -  -  -  receive er3[0xa][0]
; state  - 10  -  -  -  -  -  -  er3[7] = er3[0xa][0] if er3[0xa][0] > er3[7]
; state  - 11  - 21 27  -  -  -  receive er3[0xa][er3[5]++] if er3[5] < er3[7]
; state  - 12  - 22 28  -  -  -
; state  -  -  -  -  -  -  - 37  receive er3[0xa][er3[5]++]

off_0f5be:	case  0 i2c_handler0  i2c_handler1  i2c_handler2  i2c_handler3
		case  4 i2c_handler4  i2c_handler0  i2c_handler1  i2c_handler7
		case  8 i2c_handler8  i2c_handler9  i2c_handler10 i2c_handler11
		case 12 i2c_handler12 i2c_handler0  i2c_handler1  i2c_handler3
		case 16 i2c_handler4  i2c_handler0  i2c_handler1  i2c_handler7
		case 20 i2c_handler8  i2c_handler11 i2c_handler12 i2c_handler0
		case 24 i2c_handler3  i2c_handler4  i2c_handler8  i2c_handler11
		case 28 i2c_handler12 i2c_handler0  i2c_handler4  i2c_handler8
		case 32 i2c_handler4
.if level >= 0x01000062
		case 33 i2c_handler0  i2c_handler1  i2c_handler7  i2c_handler8
		case 37 i2c_handler37
.endif

; ----------------------------------------------

; state 0  5 13 17 23 29  - 33	transmit er3[0xe][5] & ~1 (write)

i2c_handler0:	clr	c

loc_0f60c:	mov	@(0x0e,er3), er0
		mov	@(i2c05o:16,er0), r0h
		bst	#0, r0h
		push	er0
		bsr	incrState:16

		pop	er0

transmitByte:	set	i
		mov	r0h, @(6,er4)		; icdr (I2C Bus Data Register)
		bclr	#1, @er4		; iccr.iric (I2C Bus Interface Interrupt Request Flag)
		bset	#6, @er4		; iccr.ieic (I2C Bus Interface Interrupt Enable)
		rts


; state -  8  - 20 26 31  - 36	transmit er3[0xe][5] | 1 (read)

i2c_handler8:	set	c
		bra	loc_0f60c

; ----------------------------------------------

; state 1  6 14 18  -  -  - 34	transmit er3[0xe][6]

i2c_handler1:	bsr	incrState:16

		mov	@(0x0e,er3), er0
		mov	@(i2c06o:16,er0), r0h
		bra	transmitByte

; ----------------------------------------------

; state 2  -  -  -  -  -  -  -	transmit er3[7]

i2c_handler2:	bsr	incrState:16

		mov	@(7,er3), r0h
		bra	transmitByte

; ----------------------------------------------

; state 3  - 15  - 24  -  -  -	transmit er3[0xa][er3[5]++] if er3[5] < er3[7], else er3[8] if er3[0] & 1<<6, else handler4

i2c_handler3:	zero	er0
		mov	@(5,er3), r0l
		mov	@(7,er3), r1h
		cmp	r0l, r1h
		bhi	loc_0f678

		btst	#6, @er3
		beq	loc_0f674

		bsr	incrState:16

		mov	@(8,er3), r0h
		bsr	transmitByte

		bra	loc_0f676

loc_0f674:	bsr	i2c_handler4		; state 4  - 16  - 25 30 32  -	error

loc_0f676:	bra	rts_0f68a

loc_0f678:	mov	@(0x0a,er3), er1
		add	er0, er1
		mov	@er1, r0h
		inc	r0l
		mov	r0l, @(5,er3)
		bsr	transmitByte

rts_0f68a:	rts

; ----------------------------------------------

; state 4  - 16  - 25 30 32  -	error

i2c_handler4:	mov	#-1, r0h
		mov	r0h, @(6,er3)
		mov	@(4,er3), r0h		; do_i2c_0o/do_i2c_1o
		jsr	schedBackTask

		rts

; ----------------------------------------------

; state -  9  -  -  -  -  -  -	receive er3[0xa][0]

i2c_handler9:	mov	@(7,er3), r0l
		inc	r0l
		btst	#6, @er3
		beq	loc_0f6aa

		inc	r0l

loc_0f6aa:	mov	#0, r0h
		bsr	maybeRead_r0h

		bcs	rts_0f6ca

		bsr	incrState:16

		mov	@(0x0a,er3), er1
		set	i
		bclr	#1, @er4		; iccr.iric (I2C Bus Interface Interrupt Request Flag)
		bset	#6, @er4		; iccr.ieic (I2C Bus Interface Interrupt Enable)
		mov	@(6,er4), r0h		; icdr (I2C Bus Data Register)
		mov	r0h, @er1

rts_0f6ca:	rts

; ----------------------------------------------

maybeRead_r0h:	btst	#2, @er3
		bne	loc_0f6d8

		btst	#4, @er4		; iccr.trs (Transmit/Receive Select)
		bne	read

loc_0f6d8:	inc	r0h
		cmp	r0h, r0l
		bhi	loc_0f6fe

		btst	#3, @er3
		bne	loc_0f6f2

		bset	#2, @er3
		bset	#0, @er5		; icsr.ackb (I2C Bus Status Register: Acknowledge Bit)
		bset	#4, @er4		; iccr.trs (Transmit/Receive Select: Transmit)
		bra	loc_0f6fe

loc_0f6f2:	mov	er4, er2
		add	#7, er2			; icmr (I2C Bus Mode Register)
		bclr	#6, @er2		; icmr.wait (I2C Bus Mode Register: Wait Insertion Bit)

loc_0f6fe:	bild	#3, @er3
		bst	#3, @er3
		bcc	loc_0f712

		set	i
		bclr	#1, @er4		; iccr.iric (I2C Bus Interface Interrupt Request Flag)
		bset	#6, @er4		; iccr.ieic (I2C Bus Interface Interrupt Enable)

loc_0f712:	bra	rts_0f744

read:		mov	er4, er2
		add	#7, er2			; icmr (I2C Bus Mode Register)
		bset	#6, @er2		; icmr.wait (I2C Bus Mode Register: Wait Insertion Bit)
		bclr	#3, @er3
		bclr	#2, @er3
		bclr	#0, @er5		; icsr.ackb (I2C Bus Status Register: Acknowledge Bit)
		bclr	#4, @er4		; iccr.trs (Transmit/Receive Select: Receive)
		set	i
		bclr	#1, @er4		; iccr.iric (I2C Bus Interface Interrupt Request Flag)
		bset	#6, @er4		; iccr.ieic (I2C Bus Interface Interrupt Enable)
		bclr	#4, @er4		; iccr.trs (Transmit/Receive Select: Receive)
		mov	@(6,er4), r0h		; icdr (I2C Bus Data Register)
		set	c

rts_0f744:	rts

; ----------------------------------------------

; state - 10  -  -  -  -  -  -	er3[7] = er3[0xa][0] if er3[0xa][0] > er3[7]

i2c_handler10:	bsr	incrState:16

		mov	@(0x0a,er3), er1
		mov	@er1, r0h
		mov	@(7,er3), r0l
		cmp	r0h, r0l
		bls	loc_0f75e

		mov	r0h, @(7,er3)

loc_0f75e:	bra	i2c_handler11

; state - 11  - 21 27  -  -  -	receive er3[0xa][er3[5]++] if er3[5] < er3[7]

i2c_handler11:	mov	@(5,er3), r0h
		mov	@(7,er3), r0l
		push	er0
		btst	#6, @er3
		beq	loc_0f774

		inc	r0l

loc_0f774:	push	er0
		bsr	maybeRead_r0h:16

		pop	er0
		pop	er1
		bcs	rts_0f7c4

		inc	r0h
		mov	r0h, @(5,er3)
		push	er1
		cmp	r0h, r0l
		bhi	loc_0f79a

		bsr	i2c_handler4:16		; state 4  - 16  - 25 30 32  -	error

		bra	loc_0f7a2

loc_0f79a:	cmp	r0h, r1l
		bhi	loc_0f7a2

		bsr	incrState:16

loc_0f7a2:	pop	er1
		zero	er0
		mov	r1h, r0l
		mov	@(0x0a,er3), er1
		add	er0, er1
		set	i
		bclr	#1, @er4		; iccr.iric (I2C Bus Interface Interrupt Request Flag)
		bset	#6, @er4		; iccr.ieic (I2C Bus Interface Interrupt Enable)
		mov	@(6,er4), r0h		; icdr (I2C Bus Data Register)
		mov	r0h, @er1

rts_0f7c4:	rts

; ----------------------------------------------

; state -  -  -  -  -  -  - 37	receive er3[0xa][er3[5]++]

.if level >= 0x01000062
i2c_handler37:	btst	#4, @er4		; iccr.trs (Transmit/Receive Select)
		beq	receive

		mov	er4, er2
		add	#7, er2			; icmr (I2C Bus Mode Register)
		bclr	#6, @er2		; icmr.wait (I2C Bus Mode Register: Wait Insertion Bit)
		bclr	#4, @er4		; iccr.trs (Transmit/Receive Select: Receive)
		bclr	#0, @er5		; icsr.ackb (I2C Bus Status Register: Acknowledge Bit)
		bset	#6, @er6		; icxr.hnds (I2C Bus Extended Control Register: Handshake Receive Operation Select: Disable Continuous Receive Operation)
		set	i
		bset	#6, @er4		; iccr.ieic (I2C Bus Interface Interrupt Enable)
		bclr	#1, @er4		; iccr.iric (I2C Bus Interface Interrupt Request Flag)
		mov	@(6,er4), r0h		; icdr (I2C Bus Data Register)
		bra	rts_0f82e

receive:	mov	@(5,er3), r0l
		cmp	#1, r0l
		bhs	notFirstByte		; iccr.trs (Transmit/Receive Select: Transmit)

		bset	#0, @er5		; icsr.ackb (I2C Bus Status Register: Acknowledge Bit)
		bsr	nextStore

		set	i
		bset	#6, @er4		; iccr.ieic (I2C Bus Interface Interrupt Enable)
		bclr	#1, @er4		; iccr.iric (I2C Bus Interface Interrupt Request Flag)
		mov	@(6,er4), r0l		; icdr (I2C Bus Data Register)
		mov	r0l, @er1
		bra	rts_0f82e

notFirstByte:	bset	#4, @er4		; iccr.trs (Transmit/Receive Select: Transmit)
		bclr	#6, @er6		; icxr.hnds (I2C Bus Extended Control Register: Handshake Receive Operation Select: Enable Continuous Receive Operation)
		bsr	i2c_handler4:16		; state 4  - 16  - 25 30 32  -	error

		bsr	nextStore

		set	i
		bclr	#1, @er4		; iccr.iric (I2C Bus Interface Interrupt Request Flag)
		mov	@(6,er4), r0l		; icdr (I2C Bus Data Register)
		mov	r0l, @er1

rts_0f82e:	rts

; ----------------------------------------------

; er1 = er3[0xa][er3[5]++]

nextStore:	mov	@(0x0a,er3), er1
		mov	@(5,er3), r0l
		extu	r0
		extu	er0
		add	er0, er1
		inc	r0l
		mov	r0l, @(5,er3)
		rts
.endif

; ----------------------------------------------

; state - 12  - 22 28  -  -  -

i2c_handler12:	mov	#1, r0
		bsr	maybeRead_r0h:16

		bcs	rts_0f864

		bsr	i2c_handler4:16		; state 4  - 16  - 25 30 32  -	error

		set	i
		bclr	#1, @er4		; iccr.iric (I2C Bus Interface Interrupt Request Flag)
		mov	@(6,er4), r0h		; icdr (I2C Bus Data Register)
		mov	r0h, @(8,er3)

rts_0f864:	rts

; ----------------------------------------------

incrState:	mov	@(6,er3), r0h
		inc	r0h
		mov	r0h, @(6,er3)
		rts

; ----------------------------------------------

; state -  7  - 19  -  -  - 35	wait for clock low

i2c_handler7:	bsr	incrState

		bset	#4, @er3
		bsr	waitClkLowMax50

		set	i
		bclr	#1, @er4		; iccr.iric (I2C Bus Interface Interrupt Request Flag)
		bset	#6, @er4		; iccr.ieic (I2C Bus Interface Interrupt Enable)
		mov	@er4, r0h		; iicr (I2C Bus Control Register)
		bset	#2, r0h			; iicr.bbsy (Bus Busy)
		bclr	#0, r0h			; iicr.scp (Start/Stop Condition Prohibit: Issue Start And Restart Condition)
		mov	r0h, @er4		; iicr (I2C Bus Control Register)
		rts

; ----------------------------------------------

waitClkLowMax50:mov	#50, r0h

poll:		cmp	#iccr_0 & M24, er4	; IIC_0 I2C Bus Control Register
		bne	1f

0:		b tst	p52dr			; Pin P52/SCK0/SCL0 (Port 5 Data Register)
		bra	loc_0f8a2

1:		b tst	p86dr			; Pin P86/-IRQ5/SCK1/SCL1 (Port 8 Data Register)

loc_0f8a2:	beq	rts_0f8a8

		dec	r0h
		bne	poll

rts_0f8a8:	rts

; ----------------------------------------------

enqueueI2Ccmd:	mov	@(i2c03o:16,er0), r3h
		cmp	#0x10, r3h
		bhs	loc_0f962:16

		mov	#byte_0f97c, er5
		zero	er6
		mov	r3h, r6l
		add	er6, er5
		mov	@er5, r4l
		btst	#7, r4l
		beq	loc_0f962:16

		btst	#2, @er0
		beq	0f

1:		mov	#i2c_1, er5
		bclr	#2, @er0
		bclr	#1, @er0
		bclr	#0, @er0
		bra	loc_0f8ea

0:		mov	#i2c_0, er5

loc_0f8ea:	btst	#7, @er0
		bne	found

		mov	er5, er1
		add	#-2 & (level >= 0x01000062), er1

next:		mov	@(i2c16o:16,er1), er2
		beq	notFound

		mov	er2, er1
		cmp	er0, er1
		bne	next

notFound:	cmp	er0, er1
		beq	found

		bset	#7, @er0
		bclr	#6, @er0
		mov	@(i2c02o:16,er0), r2l
		bld	#6, r4l
		bst	#3, @er0
		btst	#5, r4l
		beq	loc_0f924

		mov	r2l, r4l
		bra	loc_0f926

loc_0f924:	and	#0x0f, r4l

loc_0f926:	cmp	r4l, r2l
		blo	loc_0f956

		mov	r4l, @(i2c02o:16,er0)
		mov	@(i2c05o:16,er0), r3l
		bclr	#0, r3l
		mov	r3l, @(i2c05o:16,er0)
		mov	er0, @(i2c16o:16,er1)
		zero	er6
		mov	er6, @(i2c16o:16,er0)
		mov	@(4,er5), r0h
		jsr	schedBackTask

		mov	#0, r0h
		clr	c
		bra	loc_0f95a

loc_0f956:	mov	#0x19, r3h
		bsr	sub_0f968

loc_0f95a:	bra	loc_0f960

found:		mov	#0x1a, r3h
		bsr	sub_0f968

loc_0f960:	bra	rts_0f966

loc_0f962:	mov	#0x19, r3h
		bsr	sub_0f968

rts_0f966:	rts

; ----------------------------------------------

sub_0f968:	btst	#7, @er0
		beq	loc_0f976

		mov	r3h, @(i2c04o:16,er0)
		bset	#6, @er0

loc_0f976:	mov	r3h, r0h
		set	c
		rts

; ----------------------------------------------

byte_0f97c:	.byte 0x00, 0x00, 0x80, 0xc0
		.byte 0x81, 0xc1, 0x81, 0xc1
		.byte 0x82, 0xc2, 0xa0, 0xe0
		.byte 0x00, 0x00, 0xa0, 0xe0

; ----------------------------------------------

sub_0f98c:	mov	#1000, r0
		mov	r0, @word_ffed5c
		mov	#15, r0
		mov	r0, @word_ffed58
		mov	#100, r0
		mov	r0, @word_ffed5a
		mov	#5000, r0
		mov	r0, @word_ffed5e
		mov	#1, r0h
		mov	r0h, @byte_ffe55d
		b clr	iscrl.irq2sca		; IRQ2 Sense Control A (IRQ Sense Control Register L)
		b set	iscrl.irq2scb		; IRQ2 Sense Control B (IRQ Sense Control Register L)

rts_0f9c8:	rts

; ----------------------------------------------

sub_0f9ca:	mov	#0, r0h
		mov	r0h, @byte_ffe55c
		rts

; ----------------------------------------------

task37:		mov	@byte_ffe55c, r0h
		shll	#2, r0h
		mov	#off_0f9f0, er1
		add	r0h, r1l
		addx	#0, r1h
		bcc	loc_0f9ea

		inc	#1, e1

loc_0f9ea:	mov	@er1, er0
		jmp	@er0

off_0f9f0:	.long sub_0fa98			;  0
		.long sub_0fa20			;  1
		.long sub_0fa32			;  2
		.long sub_0fa44			;  3
		.long sub_0fa58			;  4
		.long sub_0fa64			;  5
		.long sub_0fabe			;  6
		.long sub_0fa92			;  7
		.long sub_0fa20			;  8
		.long sub_0fb2e			;  9
		.long sub_0fb3a			; 10
		.long sub_0fb4e			; 11

; ----------------------------------------------

sub_0fa20:	mov	@word_ffed56, r0
		jsr	cmpTick

		bcs	sub_0faac:16

		bra	loc_0faba:16

; ----------------------------------------------

sub_0fa32:	mov	#0, r0h
		mov	r0h, @byte_ffe55e
		bclr	#7, @byte_ffff2f:8
		b set	ier.irq2e		; IRQ2 Enable (Interrupt Enable Register)
		bra	sub_0faac

; ----------------------------------------------

sub_0fa44:	btst	#7, @byte_ffff2f:8
		beq	loc_0fa50

		bsr	sub_0faac

		set	c
		bra	rts_0fa56

loc_0fa50:	mov	#task37o, r0h
		jsr	schedFrontTask

rts_0fa56:	rts

; ----------------------------------------------

sub_0fa58:	mov	@word_ffed5e, r1
		bsr	sub_0fa9e

		set	c
		rts

; ----------------------------------------------

sub_0fa64:	b tst	p90dr			; Pin P90/-IRQ2/-ADTRG/-ECS2 (Port 9 Data Register)
		beq	loc_0fa80

		mov	@word_ffed56, r0
		jsr	cmpTick

		bcc	loc_0fa7e

		mov	#2, r0h
		mov	r0h, @byte_ffe55c

loc_0fa7e:	bra	loc_0fa8e

loc_0fa80:	bsr	sub_0faac

		mov	@tick, r0
		mov	r0, @word_ffed56

loc_0fa8e:	set	c
		rts

; ----------------------------------------------

sub_0fa92:	mov	#2000, r1
		bra	sub_0fa9e

sub_0fa98:	mov	@word_ffed5c, r1

sub_0fa9e:	mov	@tick, r0
		add	r1, r0
		mov	r0, @word_ffed56

sub_0faac:	mov	@byte_ffe55c, r0h
		inc	r0h
		mov	r0h, @byte_ffe55c

loc_0faba:	clr	c
		rts

; ----------------------------------------------

sub_0fabe:	b tst	p90dr			; Pin P90/-IRQ2/-ADTRG/-ECS2 (Port 9 Data Register)
		beq	loc_0fb0e

		mov	@word_ffed56, r0
		jsr	cmpTick

		mov	@word_ffed58, r1
		cmp	r1, r0
		blo	loc_0fb04

		mov	@byte_ffe55e, r0h
		inc	r0h
		mov	r0h, @byte_ffe55e
		mov	@byte_ffe55d, r0l
		cmp	r0l, r0h
		blo	loc_0fafa

		mov	#0x3c, r0h
		jsr	sub_10cc0

		bsr	sub_0faac

		bra	loc_0fb02

loc_0fafa:	mov	#4, r0h
		mov	r0h, @byte_ffe55c

loc_0fb02:	bra	loc_0fb0c

loc_0fb04:	mov	#0x0a, r0h
		mov	r0h, @byte_ffe55c

loc_0fb0c:	bra	loc_0fb2a

loc_0fb0e:	mov	@word_ffed56, r0
		jsr	cmpTick

		mov	@word_ffed5a, r1
		cmp	r1, r0
		blo	loc_0fb2a

		mov	#0x3c, r0h
		jsr	sub_10cc0

		bsr	sub_0faac

loc_0fb2a:	set	c
		rts

; ----------------------------------------------

sub_0fb2e:	mov	#2, r0h
		mov	r0h, @byte_ffe55c
		set	c
		rts

; ----------------------------------------------

sub_0fb3a:	bclr	#7, @byte_ffff2f:8
		b set	ier.irq2e		; IRQ2 Enable (Interrupt Enable Register)
		mov	#1000, r1
		jsr	sub_0fa9e

		set	c
		rts

; ----------------------------------------------

sub_0fb4e:	btst	#7, @byte_ffff2f:8
		beq	loc_0fb5e

		mov	#4, r0h
		mov	r0h, @byte_ffe55c
		bra	loc_0fb72

loc_0fb5e:	mov	@word_ffed56, r0
		jsr	cmpTick

		bcc	loc_0fb72

		mov	#2, r0h
		mov	r0h, @byte_ffe55c

loc_0fb72:	set	c
		rts

; ----------------------------------------------

; External Interrupt Request 2

irq2:		b clr	ier.irq2e		; IRQ2 Enable (Interrupt Enable Register)
		clr	i
		bsr	sub_0fb80

		rte

; ----------------------------------------------

sub_0fb80:	bset	#7, @byte_ffff2f:8
		stm	er0-er3, @-sp
		mov	#task37o, r0h
		jsr	schedBackTask

		ldm	@sp+, er0-er3
		rts

; ----------------------------------------------

init_dac:	b clr	mstpcrh.mstp10		; D/A (Module Stop Control Register H)
		mov	@dacTabsPtr, er0
		mov	er0, @curDacTabsPtr
		mov	#dacVals, er2
		mov	#2, r3h

loc_0fbb0:	mov	#0, r0h
		mov	r0h, @(1,er2)
		mov	#-1, r0h
		mov	r0h, @(0,er2)
		add	#2, er2
		dec	r3h
		bne	loc_0fbb0

		mov	#0, r0h
		mov	r0h, @dadr0:8		; D/A Data Register 0
		b set	dacr.daoe0		; D/A Output Enable 0 (D/A Control Register)
		rts

; ----------------------------------------------

sub_0fbd0:	mov	#0, r0h
		mov	r0h, @dadr1:8		; D/A Data Register 1
		b set	dacr.daoe1		; D/A Output Enable 1 (D/A Control Register)
		mov	#brightnessTab1, er0
		bsr	sub_0fd64:16

		rts

; ----------------------------------------------

sub_0fbe4:	mov	#dacVals, er2
		mov	#2, r3h

loc_0fbec:	mov	@(0,er2), r0h
		cmp	#-1, r0h
		beq	loc_0fbfa

		mov	#0xfe, r0h
		mov	r0h, @(0,er2)

loc_0fbfa:	add	#2, er2
		dec	r3h
		bne	loc_0fbec

		rts

; ----------------------------------------------

sub_0fc06:	b clr	dacr.daoe0		; D/A Output Enable 0 (D/A Control Register)
		b clr	dacr.daoe1		; D/A Output Enable 1 (D/A Control Register)
		rts

; ----------------------------------------------

task38:		mov	#0, r0h
		mov	#0, r0l

loc_0fc14:	push	er0
		bsr	get8x_AB_

		bcs	loc_0fc38

		mov	@(0,er0), r3h
		cmp	#-1, r3h
		beq	loc_0fc38

		mov	@(1,er0), r3l
		cmp	r3h, r3l
		beq	loc_0fc38

		pop	er4
		mov	#-1, r4l
		push	er4
		jsr	@er2

loc_0fc38:	pop	er0
		inc	r0h
		cmp	#2, r0h
		blo	loc_0fc14

		cmp	#0, r0l
		bne	loc_0fc4c

		mov	#task38o, r0h
		jsr	schedFrontTask

loc_0fc4c:	clr	c
		rts

; ----------------------------------------------

get8x_AB_:	cmp	#2, r0h
		bhs	tooLarge			; >= 2

		mov	#2, r1l
		mulxu	r0h, r1
		mov	#0, e1
		mov	#dacVals, er2
		add	er1, er2
		push	er2
		zero	er2
		mov	r0h, r2l
		shll	#2, r2l
		shll	r2l
		mov	@curDacTabsPtr, er1
		add	er2, er1
		stm	er0-er1, @-sp
		jsr	sub_074d0

		ldm	@sp+, er0-er1
		bcc	loc_0fc92

		btst	r0h, @byte_ffff30:8
		bne	loc_0fc92

		adds	#4, er1

loc_0fc92:	mov	@er1, er1
		beq	loc_0fcb0

		mov	#off_0fcbc, er3
		shlr	er2
		add	er3, er2
		mov	@er2, er2
		beq	loc_0fcac

		clr	c
		bra	loc_0fcae

loc_0fcac:	set	c

loc_0fcae:	bra	loc_0fcb2

loc_0fcb0:	set	c

loc_0fcb2:	pop	er0
		bra	rts_0fcba

tooLarge:	set	c

rts_0fcba:	rts


off_0fcbc:	.long sub_0fccc, sub_0fd42, NULL, NULL

; ----------------------------------------------

sub_0fccc:	push	er0
		bsr	sub_0fd1c

		pop	er1
		bcs	rts_0fd1a

		btst	#7, @byte_ffff30:8
		beq	loc_0fce0

		mov	#0, r0h

loc_0fce0:	mov	r0h, @dadr0:8		; D/A Data Register 0
		b set	dacr.daoe0		; D/A Output Enable 0 (D/A Control Register)
		push	er1
		cmp	#0, r0h
		bne	loc_0fcf4

		jsr	sub_0676e

		bra	loc_0fcf8

loc_0fcf4:	jsr	sub_06792

loc_0fcf8:	btst	#6, @byte_ffff30:8
		beq	loc_0fd08

		bclr	#6, @byte_ffff30:8
		mov	#0x0b, r0h
		jsr	sub_063a0

loc_0fd08:	pop	er1
		mov	@(0,er1), r0h
		bld	#7, @byte_ffff30:8
		bst	#6, r0h
		jsr	sub_10f26

rts_0fd1a:	rts

; ----------------------------------------------

sub_0fd1c:	mov	@(1,er0), r2l
		mov	@er1+, r2h
		beq	loc_0fd3e

		dec	r2h
		cmp	r2h, r2l
		bls	loc_0fd2c

		mov	r2h, r2l

loc_0fd2c:	mov	r2l, @(0,er0)
		mov	#0, r2h
		mov	#0, e2
		add	er2, er1
		mov	@er1, r0h
		clr	c
		bra	rts_0fd40

loc_0fd3e:	set	c

rts_0fd40:	rts

; ----------------------------------------------

sub_0fd42:	push	er0
		bsr	sub_0fd1c

		pop	er1
		bcs	rts_0fd62

		mov	r0h, @dadr1:8		; D/A Data Register 1
		b set	dacr.daoe1		; D/A Output Enable 1 (D/A Control Register)
		mov	@(0,er1), r0h
		bld	#1, @byte_ffff30:8
		bst	#5, r0h
		jsr	sub_10f3a

rts_0fd62:	rts

; ----------------------------------------------

sub_0fd64:	mov	#curBrightnessTab, er1
		mov	#0, r2h

loc_0fd6c:	mov	@er0, r2l
		mov	r2l, @er1
		inc	#1, er0
		inc	#1, er1
		inc	r2h
		cmp	#9 * 2, r2h
		blo	loc_0fd6c

		rts

; ----------------------------------------------

dacUp:		mov	#1, r0l
		bra	loc_0fd82

dacDown:	mov	#-1, r0l

loc_0fd82:	push	er0
		bsr	get8x_AB_:16

		pop	er2
		bcs	rts_0fdd2

		mov	@(1,er0), r3l
		cmp	#-1, r2l
		bne	loc_0fda0

		cmp	#0, r3l
		beq	loc_0fd9e

		dec	r3l

loc_0fd9e:	bra	loc_0fdaa

loc_0fda0:	inc	r3l
		mov	@er1, r3h
		cmp	r3l, r3h
		bhi	loc_0fdaa

		dec	r3l

loc_0fdaa:	cmp	#dacVals, er0
		bne	loc_0fdc2

		bset	#6, @byte_ffff30:8
		btst	#7, @byte_ffff30:8
		beq	loc_0fdc2

		bclr	#7, @byte_ffff30:8
		bra	loc_0fdc6

loc_0fdc2:	mov	r3l, @(1,er0)

loc_0fdc6:	mov	#0xfe, r2l
		mov	r2l, @(0,er0)
		mov	#task38o, r0h
		jsr	schedBackTask

rts_0fdd2:	rts

; ----------------------------------------------

loc_0fdd4:	and	#0x1f, r0h
		push	er0
		jsr	get8x_AB_

		pop	er2
		bcs	rts_0fe26

		mov	r2l, r3l
		and	#0x1f, r3l
		mov	r3l, @(1,er0)
		cmp	#0, r2h
		bne	loc_0fdfa

		bld	#6, r2l
		bst	#7, @byte_ffff30:8
		bclr	#6, @byte_ffff30:8

loc_0fdfa:	mov	#0xfe, r3h
		mov	r3h, @(0,er0)
		btst	r2h, @byte_ffff30:8
		beq	loc_0fe14

		btst	#5, r2l
		bne	loc_0fe12

		bclr	r2h, @byte_ffff30:8
		jsr	sub_0fe38

loc_0fe12:	bra	loc_0fe20

loc_0fe14:	btst	#5, r2l
		beq	loc_0fe20

		bset	r2h, @byte_ffff30:8
		jsr	sub_0fe38

loc_0fe20:	mov	#task38o, r0h
		jsr	schedBackTask

rts_0fe26:	rts

; ----------------------------------------------

		bsr	get8x_AB_:16

		bcs	loc_0fe32

		mov	@(0,er0), r0h

loc_0fe32:
.if !type1R
		btst	#7, @byte_ffff30:8
.endif
		rts

; ----------------------------------------------

sub_0fe38:	mov	#0, r0h

loc_0fe3a:	push	er0
		bsr	get8x_AB_:16

		bcs	loc_0fe4a

		mov	#0xfe, r2l
		mov	r2l, @(0,er0)

loc_0fe4a:	pop	er0
		inc	r0h
		cmp	#2, r0h
		blo	loc_0fe3a

		mov	#task38o, r0h
		jsr	schedBackTask

		rts

; ----------------------------------------------

sub_0fe5c:	jsr	sub_0126e

		bcc	rts_0fe66

		b set	dacr.daoe0		; D/A Output Enable 0 (D/A Control Register)

rts_0fe66:	rts

; ----------------------------------------------

sub_0fe68:	jsr	sub_01272

		bcs	rts_0fe72

		b clr	dacr.daoe0		; D/A Output Enable 0 (D/A Control Register)

rts_0fe72:	rts

; ----------------------------------------------

volumeMute:	btst	#7, @byte_ffff30:8
		bne	rts_0fe8c

		bset	#7, @byte_ffff30:8
		mov	#0xfe, r0h
		mov	r0h, @dacVals
		mov	#task38o, r0h
		jsr	schedBackTask

rts_0fe8c:	rts

; ----------------------------------------------

sub_0fe8e:	mov	@dacVals, r0h
		cmp	#-1, r0h
		bne	rts_0fe9c

		mov	#0x80, r0h
		mov	r0h, @dadr0:8		; D/A Data Register 0

rts_0fe9c:	rts

; ----------------------------------------------

get8x_ab:	bsr	get8x_AB_:16

		mov	@er1, r0h
		dec	r0h
		rts

; ----------------------------------------------

sub_0fea8:	mov	r0h, r3h
		and	#0x3f, r3h
		cmp	#2, r3h
		bhs	rts_0ff64:16

		stm	er0-er1, @-sp
		mov	@curDacTabsPtr, er2
		cmp	#RAM & M24, er2
		bhs	noalloc

		mov	#4 * 4, r0
		jsr	malloc

		bcs	noalloc

		mov	@curDacTabsPtr, er1
		mov	er0, @curDacTabsPtr
		mov	#4, r2h

loc_0fee2:	mov	@er1+, er3
		mov	er3, @er0
		adds	#4, er0
		dec	r2h
		bne	loc_0fee2

		clr	c

noalloc:	ldm	@sp+, er0-er1
		bcs	rts_0ff64

		zero	er3
		mov	r0h, r3l
		and	#0x1f, r3l
		shll	#2, r3
		shll	r3
		btst	#6, r0h
		beq	loc_0ff0a

		adds	#4, er3

loc_0ff0a:	mov	@curDacTabsPtr, er4
		add	er4, er3
		mov	@er3, er2
		cmp	#RAM & M24, er2
		blo	loc_0ff26

		mov	@er2, r4h
		cmp	r0l, r4h
		bhs	loc_0ff42

loc_0ff26:	push	er3
		stm	er0-er1, @-sp
		mov	#0, r0h
		inc	r0l
		jsr	malloc

		mov	er0, er2
		ldm	@sp+, er0-er1
		pop	er3
		bra	loc_0ff44

loc_0ff42:	clr	c

loc_0ff44:	bcs	rts_0ff64

		push	er2
		mov	r0l, @er2
		adds	#1, er2

loc_0ff4e:	mov	@er1+, r0h
		mov	r0h, @er2
		adds	#1, er2
		dec	r0l
		bne	loc_0ff4e

		pop	er2
		mov	er2, @er3
		bsr	sub_0fe38:16

rts_0ff64:	rts

; ----------------------------------------------

sub_0ff66:	mov	r0h, r2l
		shlr	#2, r2l
		shlr	#2, r2l
		shlr	#2, r2l
		and	#0x3f, r0h
		cmp	#5, r0h
		bhs	rts_0ff88

		mov	r0h, r0l
		shll	#2, r0l
		extu	r0
		extu	er0
		mov	@(off_0ff8a,er0), er1
		jsr	@er1

rts_0ff88:	rts


off_0ff8a:	.long rts_0ffdc			; 0
		.long sub_0ff9e			; 1
		.long rts_0ffdc			; 2
		.long rts_0ffdc			; 3
		.long rts_0ffdc			; 4

; ----------------------------------------------

sub_0ff9e:	cmp	#num_brightnessTabs, r2l
		bhs	rts_0ffca

		shll	#2, r2l
		extu	r2
		extu	er2
		mov	@(brightnessTabs,er2), er0
		bsr	sub_0fd64:16

		mov	#1, r0h
		bsr	get8x_AB_:16

		bcs	rts_0ffca

		mov	#0xfe, r1h
		mov	r1h, @(0,er0)
		mov	#task38o, r0h
		jsr	schedBackTask

rts_0ffca:	rts


brightnessTabs:	.long brightnessTab1, brightnessTab2, brightnessTab3, brightnessTab1

; ----------------------------------------------

rts_0ffdc:	rts

; ----------------------------------------------

enableLPC2:	b clr	mstpcrl.mstp0		; LPC, WUEMRB (Module Stop Control Register L)
		b set	hicr_0.lpc2e		; LPC Channel 2 Enable (0x62/0x66) (LPC Host Interface Control Register 0)
		mov	#0, r0h
		mov	r0h, @ibfi2Flags:8
		mov	r0h, @byte_ffe63f
		mov	r0h, @byte_ffe640
		mov	r0h, @byte_ffe641
		mov	#0, r0h
		mov	r0h, @str2		; LPC Status Register 2 (0x66)
		b set	hicr_2.ibfie2		; IDR2 Receive Completion Interrupt Enable (LPC Host Interface Control Register 2)
		mov	#0x55, r0h
		mov	r0h, @odr2		; LPC Output Data Register 2 (0x62)
		jsr	sub_072be

		mov	r0h, @byte_ffe59b	; 0x3c
		jsr	sub_127cc

		mov	r0h, @byte_ffe5e5	; 0x86
		mov	r0l, @byte_ffe5e6	; 0x87
		rts

; ----------------------------------------------

task40:		set	i
		btst	#2, @ibfi2Flags:8
		beq	loc_1005e

		bclr	#5, @ibfi2Flags:8	; 5 cmd recvd
		bclr	#2, @ibfi2Flags:8
		b set	str2.burst		; Burst Mode For Polled Command Processing (LPC Status Register 2 (0x66))
		mov	#0x90, r0h
		mov	r0h, @odr2		; LPC Output Data Register 2 (0x62)
		clr	i
		jsr	lowPulsePB1

		mov	@word_ffe9bc, r0
		add	#0x0b, r0
		mov	r0, @word_ffed74

loc_1005e:	clr	i
		btst	#5, @ibfi2Flags:8	; 5 cmd recvd
		beq	loc_100c6

		btst	#7, @execFlags:8
		beq	loc_10082

		bclr	#7, @execFlags:8
		mov	#off_10c02, er0
		mov	er0, @long_ffed6c
		bset	#5, @execFlags:8

loc_10082:	btst	#6, @execFlags:8
		beq	loc_1009e

		bclr	#6, @execFlags:8
		mov	#off_10c3a, er0
		mov	er0, @long_ffed6c
		bclr	#5, @execFlags:8

loc_1009e:	mov	@long_ffed6c, er0
		beq	loc_100c6

		jsr	sub_10b86

		bcs	loc_100c6

		bclr	#5, @ibfi2Flags:8	; 5 cmd recvd
		mov	#0, er0
		mov	er0, @long_ffed6c
		b set	hicr_2.ibfie2		; IDR2 Receive Completion Interrupt Enable (LPC Host Interface Control Register 2)

loc_100c6:	b tst	str2.burst		; Burst Mode For Polled Command Processing (LPC Status Register 2 (0x66))
		beq	loc_100f4

		mov	@word_ffed74, r0
		jsr	sub_016dc

		bcc	loc_100f2

		set	i
		b tst	str2.burst		; Burst Mode For Polled Command Processing (LPC Status Register 2 (0x66))
		beq	loc_100f0

		b clr	str2.burst		; Burst Mode For Polled Command Processing (LPC Status Register 2 (0x66))
		clr	i
		jsr	lowPulsePB1

loc_100f0:	clr	i

loc_100f2:	bra	loc_10100

loc_100f4:	btst	#5, @ibfi2Flags:8	; 5 cmd recvd
		bne	loc_10100

		mov	#task40o, r0h
		jsr	schedFrontTask

loc_10100:	mov	#0, r0h
		mov	r0h, @cntr20
		btst	#0, @execFlags:8
		beq	loc_1011c

		set	i
		bclr	#0, @execFlags:8
		b set	hicr_2.ibfie2		; IDR2 Receive Completion Interrupt Enable (LPC Host Interface Control Register 2)
		clr	i

loc_1011c:	clr	c
		rts

; ----------------------------------------------

task41:		btst	#4, @execFlags:8
		beq	loc_1013c

		btst	#2, @execFlags:8
		beq	loc_1013a

		mov	#0x2f, r0h
		jsr	sub_10cc0

		jsr	sub_101f4

		jsr	sub_10222

loc_1013a:	bra	loc_10158

loc_1013c:	mov	@word_ffed72, r0
		beq	loc_10158

		mov	@word_ffed70, r0
		jsr	sub_016e4

		bcc	loc_10158

		mov	#0x2e, r0h
		jsr	sub_10cc0

		bsr	sub_101ce

loc_10158:	bclr	#2, @execFlags:8
		btst	#4, @execFlags:8
		bne	loc_1016c

		mov	#task41o, r0h
		mov	#1000, r1
		jsr	schedBackTaskDelayed

loc_1016c:	mov	#task41o, r0h
		jsr	schedFrontTask

		clr	c
		rts

; ----------------------------------------------

task39_1:	btst	#5, @ibfi2Flags:8	; 5 cmd recvd
		bne	loc_101a6

		b tst	str2.burst		; Burst Mode For Polled Command Processing (LPC Status Register 2 (0x66))
		bne	loc_101a6

		mov	@byte_ffe641, r0h
		bne	loc_101a6

		jsr	sub_10db8

		bcs	loc_101a6

		set	i
		mov	r0h, @byte_ffe641
		b set	str2.sci_evt		; SCI Event Pending (LPC Status Register 2 (0x66))
		clr	i
		jsr	lowPulsePB1

loc_101a6:	jsr	sub_102ee

		mov	@byte_ffe63f, r0h
		mov	@byte_ffe640, r0l
		cmp	r0h, r0l
		bne	loc_101ca

		mov	#task39o, r0h
		mov	#10, r1
		jsr	schedBackTaskDelayed

		mov	#task39o, r0h
		jsr	schedFrontTask

loc_101ca:	clr	c
		rts

; ----------------------------------------------

sub_101ce:	btst	#4, @execFlags:8
		bne	rts_101f2

		mov	@byte_ffe560, r0h	; 0x01
		btst	#3, r0h
		beq	loc_101e6

		jsr	sub_04720

		jsr	sub_07e32

loc_101e6:	bset	#4, @execFlags:8
		bset	#3, @byte_ffe593	; 0x34

rts_101f2:	rts

; ----------------------------------------------

sub_101f4:	btst	#4, @execFlags:8
		beq	rts_10220

		jsr	sub_0472a

		jsr	sub_07e38

		jsr	sub_10222

		bclr	#4, @execFlags:8
		btst	#3, @execFlags:8
		beq	loc_10218

		jsr	sub_04b70

		bclr	#3, @execFlags:8

loc_10218:	bclr	#3, @byte_ffe593	; 0x34

rts_10220:	rts

; ----------------------------------------------

sub_10222:	mov	@word_ffed72, r0
		mov	@word_ffe9be, r1
		add	r1, r0
		mov	r0, @word_ffed70
		rts

; ----------------------------------------------

sub_10238:	mov	#byte_ffe591, er1	; 0x32
		mov	@long_ffed7a, er2
		mov	@er2+, r3h

loc_10248:	mov	@er1, r4l
		beq	loc_10284

		mov	#0, r3l

loc_1024e:	btst	r3l, r4l
		beq	loc_10276

		mov	@er2, r4h
		cmp	r4h, r0h
		bne	loc_10276

		set	i
		mov	@(byte_ffe5ad - byte_ffe591:16,er1), r4h
		bset	r3l, r4h
		mov	r4h, @(byte_ffe5ad - byte_ffe591:16,er1)
		mov	r4h, @(byte_ffe595 - byte_ffe591:16,er1)
		clr	i
		mov	r4h, @(byte_ffe112 - byte_ffe591,er1)
		bsr	sub_10296

		bra	rts_10294

loc_10276:	adds	#1, er2
		dec	r3h
		beq	loc_10282

		inc	r3l
		cmp	#7, r3l
		bls	loc_1024e

loc_10282:	bra	loc_1028c

loc_10284:	add	#0xf8, r3h
		add	#8, er2

loc_1028c:	adds	#1, er1
		mov	r3h, r3l
		beq	rts_10294

		bpl	loc_10248

rts_10294:	rts

; ----------------------------------------------

sub_10296:	set	i
		mov	@byte_ffe5ad, r0h	; 0x4e
		bne	loc_102a8

		mov	@byte_ffe5ae, r0h	; 0x4f
		beq	loc_102cc

loc_102a8:	push	er0
		stc	ccr, r0l
		set	i
		b clr	pb0odr			; Pin PB0/-WUE0/HIRQ3/-LSMI (Port B Output Data Register)
		mov	@PBDDRcopy, r0h
		bset	#0, r0h
		mov	r0h, @PBDDRcopy
		mov	r0h, @pbddr:8		; Port B Data Direction Register
		ldc	r0l, ccr
		pop	er0
		bra	loc_102ea

loc_102cc:	push	er0
		stc	ccr, r0l
		set	i
		mov	@PBDDRcopy, r0h
		bclr	#0, r0h
		mov	r0h, @PBDDRcopy
		mov	r0h, @pbddr:8		; Port B Data Direction Register
		ldc	r0l, ccr
		pop	er0

loc_102ea:	clr	i
		rts

; ----------------------------------------------
sub_102ee:
.if type1R
		set	i
		bild	#0, @p8dr:8
		mov	@byte_ffe591, r0h
		band	#0, r0h
		mov	@byte_ffe5ad, r1h
		bst	#0, r1h
		mov	r1h, @byte_ffe5ad
		mov	r1h, @byte_ffe595
		clr	i
		mov	r1h, @byte_ffe112
.endif
		jsr	sub_10296

		rts

; ----------------------------------------------

ckFlashStatus:	set	i
		b set	stcr.flshe		; Flash Memory Control Register Enable (Serial Timer Control Register)
		mov	@flmcr1:8, r0h		; Flash Memory Control Register 1
		mov	@flmcr2:8, r0l		; Flash Memory Control Register 2
		b clr	stcr.flshe		; Flash Memory Control Register Enable (Serial Timer Control Register)
		clr	i
		mov	r0, r1
		bclr	#7, r1h			; clear Flash Write Enable
		mov	r1, r2
		bne	flashActivity

		btst	#7, r0h			; Flash Write Enable
		beq	noFlashActivity

		mov	#3, r0h
		bra	writeEnabledNotActive

noFlashActivity:mov	#4, r0h

writeEnabledNotActive:
		bra	rts_1031a

flashActivity:	mov	#0, r0h

rts_1031a:	rts

; ----------------------------------------------

sub_1031c:	b set	hicr_0.lpc2e		; LPC Channel 2 Enable (0x62/0x66) (LPC Host Interface Control Register 0)
		b set	hicr_2.ibfie2		; IDR2 Receive Completion Interrupt Enable (LPC Host Interface Control Register 2)
		jsr	sub_10dec

		mov	#0, r0h
		mov	r0h, @byte_ffe641
		jsr	sub_11012

		jsr	sub_10222

		rts

; ----------------------------------------------

task39_2:	jsr	sub_10db8

		cmp	#0, r0h
		beq	loc_10358

		mov	r0h, @byte_ffe59b	; 0x3c
		cmp	#0x22, r0h
		bne	loc_10354

		jsr	sub_0773a

loc_10354:	jsr	sub_077fc

loc_10358:	jsr	sub_102ee

		clr	c
		rts

; ----------------------------------------------

sub_10360:	b clr	hicr_2.ibfie2		; IDR2 Receive Completion Interrupt Enable (LPC Host Interface Control Register 2)
		mov	#0, r0h
		mov	r0h, @byte_ffe59b	; 0x3c
		jsr	sub_10dec

		setInH	b 1			; Pin PB1/-WUE1/HIRQ4/LSCI
		setInH	b 0			; Pin PB0/-WUE0/HIRQ3/-LSMI

		b clr	hicr_0.lpc2e		; LPC Channel 2 Enable (0x62/0x66) (LPC Host Interface Control Register 0)
		rts

; ----------------------------------------------

sub_1039e:	bsr	sub_10360

		mov	#0, r0h
		set	i
		mov	r0h, @byte_ffe112
		mov	r0h, @byte_ffe113
		mov	r0h, @byte_ffe5ad	; 0x4e
		mov	r0h, @byte_ffe5ae	; 0x4f
		mov	r0h, @byte_ffe595	; 0x36
		mov	r0h, @byte_ffe596	; 0x37
		clr	i
		mov	@byte_ffe110, r0h
		mov	r0h, @byte_ffe591	; 0x32
		mov	@byte_ffe111, r0h
		mov	r0h, @byte_ffe592	; 0x33
		rts

; ----------------------------------------------

getFlashStatus: mov	@off_00470, er0
		mov	er0, @long_ffed7a
		mov	@byte_ffe112, r0h
		mov	@byte_ffe113, r0l
		set	i
		mov	r0h, @byte_ffe5ad	; 0x4e
		mov	r0h, @byte_ffe595	; 0x36
		mov	r0l, @byte_ffe5ae	; 0x4f
		mov	r0l, @byte_ffe596	; 0x37
		mov	@byte_ffe110, r0h
		mov	r0h, @byte_ffe591	; 0x32
		mov	@byte_ffe111, r0h
		mov	r0h, @byte_ffe592	; 0x33
		clr	i
		bsr	ckFlashStatus:16

		mov	r0h, @byte0xD0		; flash status
		rts

; ----------------------------------------------

; 0x06 r; w sets bit #1 of 0x34
; 0x0C r; w special
; 0x2F r/w fan ctrl/status
; 0x30 r/w volume
; 0x31 r/w LCD brightness
; 0x3B r 7 !P74PIN, 6 PD5PIN, 5 PD6PIN, 4 PD2PIN, 3 ?, 2 PC4PIN, 1 P13DR, 0 !PC5PIN
; 0x51 r; w can only clear bit #6
; 0x54 r/w year LSB
; 0x55 r/w year MSB
; 0x56 r/w month
; 0x57 r/w day
; 0x58 r/w hour
; 0x59 r/w minute
; 0x5A r/w second
; 0x78 r/w CPU temperature
; 0x79 r/w APS temperature
; 0x7A r/w CardBus temperature
; 0x7B r/w GPU temperature
; 0x7C r/w BAT temperature
; 0x7D r/w  ?  temperature
; 0x7E r/w BAT temperature
; 0x7F r/w  ?  temperature
; 0x84 r special (cache MSB)/w fan speed LSB
; 0x85 r special cached/w fan speed MSB
; 0x8C r; w special
; 0x92 w I/O register address MSB
; 0x93 w I/O register address LSB
; 0x94 r/? I/O register data (PIN register)
; 0x95 r/? I/O register data (copy of DDR)
; 0xBx r/w own (RAM)
; 0xC0 r/w BUS temperature
; 0xC1 r/w PCI temperature
; 0xC2 r/w PWR temperature
; 0xC3 r/w  ?  temperature
; 0xC4 r/w  ?  temperature
; 0xC5 r/w  ?  temperature
; 0xC6 r/w  ?  temperature
; 0xC7 r/w  ?  temperature
; 0xC8 r/w tab sel 0x[012]x, 0xF[01]
; 0xD0 r (RAM)
; 0xDx r (ROM)
; 0xE8 r version major << 4 (0x10)
; 0xE9 r version minor << 4 (0x40)
; 0xEA r machine type       (0x4A)
; 0xEE r (RAM)
; 0xEx r (ROM)
; 0xF0-0xF7 r build id (e.g. "1YHT28WW")
; 0xF8-0xFB r build timestamp #1 (seconds since somewhere in 1999?)
; 0xFC-0xFF r build timestamp #2 (seconds since somewhere in 1999?)

; LPC IDR2 Reception Completion (0x62/0x66)

ibfi2:		b clr	hicr_2.ibfie2		; IDR2 Receive Completion Interrupt Enable (LPC Host Interface Control Register 2)
		clr	i
		stm	er0-er3, @-sp
		b tst	str2.c_d2		; Command/-Data (0x66/0x62) (LPC Status Register 2 (0x66))
		beq	getData

		bclr	#2, @ibfi2Flags:8
		mov	@idr2, r0h		; LPC Input Data Register 2 (0x62/0x66)

		mov	r0h, r0l
		shlr	r0l
		shlr	r0l
		and	#0x3c, r0l
		mov	#cmdTab, er1		; r0l: read byte, r0h: byte #
		add	r0l, r1l
		addx	#0, r1h
		bcc	loc_10472

		inc	#1, e1

loc_10472:	mov	@er1, er1
		beq	invalidCmd

		mov	r0h, r0l
		shll	r0l
		shll	r0l
		and	#0x3c, r0l
		add	r0l, r1l
		addx	#0, r1h
		bcc	loc_10488

		inc	#1, e1

loc_10488:	mov	@er1, er1
		beq	invalidCmd

		mov	#0, r0h
		mov	r0h, @dataCtr
		mov	er1, @cmdPtr
		bset	#5, @ibfi2Flags:8	; 5 cmd recvd
		jsr	@er1

		bra	loc_104aa

invalidCmd:	mov	#0, r0h
		clr	c

loc_104aa:	bra	done1

getData:	btst	#5, @ibfi2Flags:8	; 5 cmd recvd
		beq	invalidData

		mov	@dataCtr, r0h
		inc	r0h
		mov	r0h, @dataCtr
		mov	@cmdPtr, er1
		mov	@idr2, r0l		; LPC Input Data Register 2 (0x62/0x66)

		jsr	@er1

		bra	done1

invalidData:	mov	@idr2, r0l		; LPC Input Data Register 2 (0x62/0x66)

		clr	c
		mov	#0, r0h			; re-enable interrupt

done1:		bcs	noErr1

		push	er0
		bsr	lowPulsePB1

		pop	er0

noErr1:		btst	#5, @ibfi2Flags:8	; 5 cmd recvd
		bne	loc_1050a

		b tst	str2.burst		; Burst Mode For Polled Command Processing (LPC Status Register 2 (0x66))
		bne	loc_1050a

		mov	@cntr20, r0l
		inc	r0l
		mov	r0l, @cntr20
		cmp	#0x20, r0l
		blo	loc_1050a

		mov	#1, r0h
		bset	#0, @execFlags:8

loc_1050a:	push	er0
		mov	#task40o, r0h
		jsr	schedBackTask

		pop	er0
		cmp	#0, r0h
		bne	loc_1052a

		ldm	@sp+, er0-er3
		set	i
		b set	hicr_2.ibfie2		; IDR2 Receive Completion Interrupt Enable (LPC Host Interface Control Register 2)
		bra	rts_1052e

loc_1052a:	ldm	@sp+, er0-er3

rts_1052e:	rte

; ----------------------------------------------

lowPulsePB1:	btst	#6, @ibfi2Flags:8
		bne	rts_10584

		set	i
		push	er0
		stc	ccr, r0l
		set	i
		b clr	pb1odr			; Pin PB1/-WUE1/HIRQ4/LSCI (Port B Output Data Register)
		mov	@PBDDRcopy, r0h
		bset	#1, r0h
		mov	r0h, @PBDDRcopy
		mov	r0h, @pbddr:8		; Port B Data Direction Register
		ldc	r0l, ccr
		pop	er0
		mov	#16, r1h		; 16 * 5 states @ 10 MHz = 8 탎

lowDelay:	nop
		nop
		dec	r1h
		bne	lowDelay

		push	er0
		stc	ccr, r0l
		set	i
		mov	@PBDDRcopy, r0h
		bclr	#1, r0h
		mov	r0h, @PBDDRcopy
		mov	r0h, @pbddr:8		; Port B Data Direction Register
		ldc	r0l, ccr
		pop	er0
		clr	i

rts_10584:	rts

; ----------------------------------------------

cmdTab:		.long NULL			;  0 ;  r0l: read byte, r0h: byte #
		.long NULL			;  1
		.long NULL			;  2
		.long NULL			;  3
		.long NULL			;  4
		.long NULL			;  5
		.long NULL			;  6
		.long NULL			;  7
		.long cmd8x			;  8
		.long NULL			;  9
		.long NULL			; 10
		.long NULL			; 11
		.long cmdCx			; 12
		.long cmdDx			; 13
		.long NULL			; 14
		.long NULL			; 15

cmd8x:		.long cmd80read			;  0 ;  ACPI commands
		.long cmd81write		;  1
		.long cmd82burstEnable		;  2
		.long cmd83burstDisable		;  3
		.long cmd84query		;  4
		.long NULL			;  5
		.long NULL			;  6
		.long NULL			;  7
		.long NULL			;  8
		.long NULL			;  9
		.long NULL			; 10
		.long NULL			; 11
		.long NULL			; 12
		.long NULL			; 13
		.long NULL			; 14
		.long NULL			; 15

cmdCx:		.long NULL			;  0
		.long NULL			;  1
		.long NULL			;  2
		.long NULL			;  3
		.long NULL			;  4
		.long NULL			;  5
		.long NULL			;  6
		.long NULL			;  7
		.long NULL			;  8
		.long NULL			;  9
		.long NULL			; 10
		.long NULL			; 11
		.long NULL			; 12
		.long NULL			; 13
		.long NULL			; 14
		.long cmdCFexec			; 15

cmdDx:		.long cmdD0			;  0
		.long cmdD1			;  1
		.long cmdD2			;  2
		.long cmdD3			;  3
		.long cmdD4			;  4
		.long cmdD5			;  5
		.long NULL			;  6
		.long NULL			;  7
		.long NULL			;  8
		.long NULL			;  9
		.long NULL			; 10
		.long NULL			; 11
		.long NULL			; 12
		.long NULL			; 13
		.long NULL			; 14
		.long NULL			; 15

; ----------------------------------------------

cmdD5:		mov	@byte_ffe644, r0h
		mov	r0h, @odr2		; LPC Output Data Register 2 (0x62)
		bclr	#5, @ibfi2Flags:8	; 5 cmd recvd
		clr	c
		mov	#0, r0h
		rts

; ----------------------------------------------

cmdD4:		cmp	#0, r0h
		beq	cmd

		mov	#0, r0h
		push	er0
		bsr	readByte

		mov	r0h, @byte_ffe644
		pop	er0
		adds	#1, er0
		mov	#1, r0h

cmd:		bra	cmd80read


cmd80read:	cmp	#0, r0h
		beq	cmdByte

		mov	#0, r0h
		bsr	readByte

		mov	r0h, @odr2		; LPC Output Data Register 2 (0x62)
		bclr	#5, @ibfi2Flags:8	; 5 cmd recvd

cmdByte:	clr	c
		mov	#0, r0h
		rts

; ----------------------------------------------

; r0: 0x00xx offset

readByte:	zero	er1
		mov	r0, r1
		shlr	#2, r1
		shlr	r1
		and	#~1, r1l
		add	#readTab, er1
		mov	@er1, r2
		exts	er2
		add	er2, er1
		jmp	@er1

readTab:	case  0 retDefault retDefault retDefault retDefault
		case  4 retDefault retDefault retDefault retDefault
		case  8 ret8x_4ab  retDefault retAx      retBDEFx
.if type1R
		case 12 retBDEFx
.else
		case 12 retDefault
.endif
		case 13 retBDEFx   retBDEFx   retBDEFx

; ----------------------------------------------

retDefault:	mov	#0x0a, r1
		cmp	r1, r0
		bne	loc_10714

		jsr	ret0A

		bra	rts_10778

loc_10714:	mov	#0, e0
		cmp	#0x4e, r0
		beq	ret4x_ef

		cmp	#0x4f, r0
		bne	loc_10754

ret4x_ef:	mov	@(dataTab,er0), r1h
		mov	#0, r1l
		mov	r1l, @(dataTab,er0)
		mov	r1l, @(byte_ffe595 - 0x4e,er0)
		mov	r1l, @(byte_ffe112 - 0x4e,er0)
		push	er1
		jsr	sub_102ee

		pop	er0
		bra	rts_10778

loc_10754:
.if !type1R
		mov	#0x24, r1
		cmp	r1, r0
		bne	loc_10762

		jsr	ret24

		bra	rts_10778

loc_10762:	mov	#0x25, r1
		cmp	r1, r0
		bne	loc_10770

		jsr	ret25

		bra	rts_10778
.endif

loc_10770:	mov	@(dataTab,er0), r0h

rts_10778:	rts

; ----------------------------------------------

ret8x_4ab:	cmp	#0x84, r0		; fan speed LSB
		bne	loc_10790

		mov	#0, r0h
		jsr	getFanSpeed

		mov	r0h, @byte_ffe5e4	; 0x85 fan speed MSB
		mov	r0l, r0h
		bra	rts_107ac

loc_10790:	cmp	#0x8a, r0
		bne	loc_1079a

		mov	#0, r0h
		bra	loc_107a2

loc_1079a:	cmp	#0x8b, r0
		bne	loc_107a8

		mov	#1, r0h

loc_107a2:	jsr	get8x_ab

		bra	rts_107ac

loc_107a8:	bra	retDefault:16

rts_107ac:	rts

; ----------------------------------------------

retAx:		mov	@byte_ffe5e0, r1h	; 0x81
		mov	@byte_ffe644, r1l
		mov	@long_ffed76, er2
.if type1R
		bsr	sub_10878
.else
		bsr	sub_10878:16
.endif

		mov	r1l, @byte_ffe644
		mov	er2, @long_ffed76
		rts

; ----------------------------------------------

sub_107d6:	push	er0
		mov	r1h, r0h
		and	#0x0f, r0h
		jsr	sub_137aa

		pop	er1
		bcs	loc_107f4

		and	#0x0f, r1
		exts	er1
		add	er1, er0
		mov	@er0, r0h
		bra	rts_107f6

loc_107f4:	mov	#0, r0h

rts_107f6:	rts

; ----------------------------------------------

.if !type1R
sub_107f8:	and	#0x0f, r0
		extu	er0
		cmp	#0x30, r1h
		bne	loc_1080e

		mov	#long_ffe801, er2
		add	er0, er2
		mov	@er2, r0h
		bra	rts_10830

loc_1080e:	cmp	#0x31, r1h
		bne	loc_1081e

		mov	#long_ffe7f1, er2
		add	er0, er2
		mov	@er2, r0h
		bra	rts_10830

loc_1081e:	cmp	#0x32, r1h
		bne	loc_1082e

		mov	#long_ffe823, er2
		add	er0, er2
		mov	@er2, r0h
		bra	rts_10830

loc_1082e:	mov	#0, r0h

rts_10830:	rts

; ----------------------------------------------

sub_10832:	cmp	#0x40, r1h
		bne	loc_10860

		and	#0x0f, r0
		cmp	#4, r0l
		bhs	loc_10860

		push	r0
		and	#0x0e, r0
		extu	er0
		shll	er0
		mov	@(off_10864,er0), er2
		jsr	@er2

		pop	r0
		mov	r1l, r0h
		btst	#0, r0l
		bne	rts_10862

		mov	r1h, r0h
		bra	rts_10862

loc_10860:	mov	#0, r0h

rts_10862:	rts


off_10864:	.long sub_1086c, sub_10872

; ----------------------------------------------

sub_1086c:	mov	#0, r1
		rts

; ----------------------------------------------

sub_10872:	mov	#1, r1
		rts
.endif

; ----------------------------------------------

sub_10878:	stm	er4-er5, @-sp
		mov	r1h, r5h
		and	#0xf0 - 0x10 & type1R, r5h
		cmp	#0x20, r5h
		bne	loc_1089c

		push	er1
		push	er2
.if type1R
		bsr	sub_107d6
.else
		bsr	sub_107d6:16
.endif

		pop	er1
		pop	er2
		bra	loc_1096c:16

loc_1089c:
.if !type1R
		cmp	#0x30, r5h
		bne	loc_108b8

		push	er1
		push	er2
		bsr	sub_107f8:16

		pop	er1
		pop	er2
		bra	loc_1096c:16

loc_108b8:	cmp	#0x40, r5h
		bne	loc_108d4

		push	er1
		push	er2
		bsr	sub_10832:16

		pop	er1
		pop	er2
		bra	loc_1096c:16
.endif

loc_108d4:	btst	#4, r1h
		bne	loc_108e0

		mov	#byte_ffeaac, er5
		bra	loc_108e6

loc_108e0:	mov	#byte_ffeb46, er5

loc_108e6:	btst	#4, @er5
		beq	loc_10964:16

		zero	e0
		zero	er3
		mov	r1h, r3l
		and	#0x0f, r3l
		cmp	#8, r3l
		bhs	loc_10960

		shll	r3l
		add	#word_10972, er3
		mov	@er3, r4
		cmp	#-1, r4
		beq	loc_10960

		btst	#7, r4h
		beq	loc_1092a

		bclr	#7, r4h
		and	#0x0f, r0
		cmp	r4h, r0l
		blo	loc_1091e

		mov	#0, r0h
		bra	loc_10928

loc_1091e:	mov	#0, r4h
		exts	er4
		add	er0, er4
		add	er5, er4
		mov	@er4, r0h

loc_10928:	bra	loc_1095e

loc_1092a:	exts	er4
		add	er4, er3
		mov	er0, er4
		and	#0x0e, r4
		add	er4, er3
		mov	@er3, r4
		cmp	#-1, r4
		beq	loc_1095c

		exts	er4
		add	er5, er4
		btst	#0, r0l
		beq	loc_10952

		cmp	er4, er2
		bne	loc_1094e

		mov	r1l, r0h
		bra	loc_10950

loc_1094e:	mov	@er4, r0

loc_10950:	bra	loc_1095a

loc_10952:	mov	@er4, r0
		mov	r0h, r1l
		mov	r0l, r0h
		mov	er4, er2

loc_1095a:	bra	loc_1095e

loc_1095c:	mov	#0, r0h

loc_1095e:	bra	loc_10962

loc_10960:	mov	#0, r0h

loc_10962:	bra	loc_1096c

loc_10964:	mov	#0, r0h
		mov	#-1, er2

loc_1096c:	ldm	@sp+, er4-er5
		rts


word_10972:	.word 0x0010			;  0
		.word 0x001e			;  1
		.word 0x002c			;  2
		.word     -1			;  3
		.word 0x845c			;  4
		.word 0x903c			;  5
		.word 0x904c			;  6
		.word 0x9070 - 0x10 & -(type1R && level < 0x01030069)	;  7
		.word 0x0020			;  8
		.word 0x0022			;  9
		.word 0x0098 - 0x20 & -(type1R && level < 0x01030069)	; 10
		.word 0x001e			; 11
		.word 0x001a			; 12
		.word 0x0016			; 13
		.word 0x0028			; 14
		.word 0x002e			; 15
		.word 0x0010			; 16
		.word 0x000a			; 17
		.word 0x0030			; 18
		.word 0x0018			; 19
		.word 0x0014			; 20
		.word 0x0024			; 21
		.word     -1			; 22
		.word     -1			; 23
		.word 0x0032			; 24
		.word 0x0034			; 25
		.word 0x0090 - 0x20 & -(type1R && level < 0x01030069)	; 26
		.word 0x0036			; 27
		.word 0x0038			; 28
		.word 0x003a			; 29
		.word 0x001c			; 30
		.word     -1			; 31

		.word 0

; ----------------------------------------------

retBDEFx:	mov	#off_109d6, er1
.if !type1R
		cmp	#0xd0, r0
		blo	loc_109c4

		sub	#0x10, r0
.endif

loc_109c4:	sub	#0xb0, r0
		shll	#2, r0
		zero	e0
		add	er0, er1
		mov	@er1, er0
		mov	@er0, r0h
		rts


off_109d6:	.long byte0xB0+ 0, byte0xB0+ 1, byte0xB0+ 2, byte0xB0+ 3
		.long byte0xB0+ 4, byte0xB0+ 5, byte0xB0+ 6, byte0xB0+ 7
		.long byte0xB0+ 8, byte0xB0+ 9, byte0xB0+10, byte0xB0+11
		.long byte0xB0+12, byte0xB0+13, byte0xB0+14, byte0xB0+15
.if type1R
		.long byteZero
.else
		.long byte0xD0
.endif
		.long           byteZero, byteZero, byteZero
		.long byteZero, byteZero, byteZero, byteZero
		.long byteZero, byteZero, byteZero, byteZero
		.long byteZero, byteZero, byteZero, byteZero
.if type1R
		.long byte0xD0
.else
		.long byteZero
.endif
		.long           byteZero, byteZero, byteZero
		.long byteZero, byteZero, byteZero, byteZero
.if type1R
		.long byteZero, byteZero, byteZero, byteZero
		.long byteZero, byteZero, byteZero, byteZero
		.long byteZero, byteZero, byteZero, byteZero
		.long byteZero, byteZero, byteZero, byteZero
.endif
		.long byte0xE8			; version major
		.long byte0xE8+1		; version minor
		.long byte0xE8+2		; machine id
		.long byte0xEB
		.long byte0xEC
		.long byte0xEC+1
		.long byte0xEE
		.long byte0xEF
		.long byte0xF0			; build id (e.g. .ascii "1YHT28WW")
		.long byte0xF0+1		; build id
		.long byte0xF0+2		; build id
		.long byte0xF0+3		; build id
		.long byte0xF0+4		; build id
		.long byte0xF0+5		; build id
		.long byte0xF0+6		; build id
		.long byte0xF0+7		; build id
		.long byte0xF8			; build timestamp #1
		.long byte0xF8+1		; build timestamp #1
		.long byte0xF8+2		; build timestamp #1
		.long byte0xF8+3		; build timestamp #1
		.long byte0xFC			; build timestamp #2
		.long byte0xFC+1		; build timestamp #2
		.long byte0xFC+2		; build timestamp #2
		.long byte0xFC+3		; build timestamp #2

byteZero:	.byte 0x00

		.fill 3

byte0xEC:
.if     type1R && level >= 0x01030069
		.byte 0x24, 0x0e
.elseif type1R
		.byte 0x24, 0x06
.elseif level >= 0x01050000
		.byte 0xa4, 0x2e
.else
		.byte 0x24, 0x2e
.endif

; ----------------------------------------------

; write

cmd81write:	cmp	#1, r0h
		bne	loc_10ae8

		mov	r0l, @writeOffset
		bra	loc_10af8

loc_10ae8:	cmp	#2, r0h
		bne	loc_10af8

		mov	@writeOffset, r1l
		bsr	jWriteByte

		bclr	#5, @ibfi2Flags:8	; 5 cmd recvd

loc_10af8:	clr	c
		mov	#0, r0h
		rts

; ----------------------------------------------

jWriteByte:	jsr	writeByte

		rts

; ----------------------------------------------

cmd82burstEnable:
		bset	#2, @ibfi2Flags:8
		set	c
		mov	#0, r0h
		rts

; ----------------------------------------------

cmd83burstDisable:
		b clr	str2.burst		; Burst Mode For Polled Command Processing (LPC Status Register 2 (0x66))
		bclr	#5, @ibfi2Flags:8	; 5 cmd recvd
		clr	c
		mov	#0, r0h
		rts

; ----------------------------------------------

cmd84query:	mov	@byte_ffe641, r0h
		mov	r0h, @odr2		; LPC Output Data Register 2 (0x62)
		mov	#0, r0h
		mov	r0h, @byte_ffe641
.if type1R
		b clr	str2.smi_evt		; SMI Event Pending (LPC Status Register 2 (0x66))
.endif
		b clr	str2.sci_evt		; SCI Event Pending (LPC Status Register 2 (0x66))
		bclr	#5, @ibfi2Flags:8	; 5 cmd recvd
		clr	c
		mov	#0, r0h
		rts

; ----------------------------------------------

cmdD0:		bset	#7, @execFlags:8
		set	c
		mov	#1, r0h
		rts

; ----------------------------------------------

cmdD1:		bset	#6, @execFlags:8
		clr	c
		mov	#1, r0h
		rts

; ----------------------------------------------

cmdD2:		bset	#6, @ibfi2Flags:8
		bclr	#5, @ibfi2Flags:8	; 5 cmd recvd
		clr	c
		mov	#0, r0h
		rts

; ----------------------------------------------

cmdD3:		bclr	#5, @ibfi2Flags:8	; 5 cmd recvd
		bld	#6, @ibfi2Flags:8
		bclr	#6, @ibfi2Flags:8
		mov	#0, r0h
		rts

; ----------------------------------------------

cmdCFexec:	jsr	sub_12826

		bcs	loc_10b7c

		jmp	sub_11092

loc_10b7c:	bclr	#5, @ibfi2Flags:8	; 5 cmd recvd
		clr	c
		mov	#0, r0h
		rts

; ----------------------------------------------

sub_10b86:	mov	@tick, r1
		add	#10, r1l
		addx	#0, r1h

loc_10b90:	mov	@str2, r0h		; LPC Status Register 2 (0x66)
		btst	#1, r0h
		beq	loc_10ba0

		btst	#3, r0h
		beq	loc_10ba0

		clr	c
		bra	loc_10bdc

loc_10ba0:	push	er1
		btst	#5, @execFlags:8
		beq	loc_10bbe

		btst	#0, r0h
		bne	loc_10bba

		bsr	sub_10bf0

		bcc	loc_10bb8

		jsr	lowPulsePB1

		set	c

loc_10bb8:	bra	loc_10bbc

loc_10bba:	set	c

loc_10bbc:	bra	loc_10bd8

loc_10bbe:	btst	#1, r0h
		beq	loc_10bd6

		mov	@idr2, r0h		; LPC Input Data Register 2 (0x62/0x66)

		push	er0
		jsr	lowPulsePB1

		pop	er0
		bsr	sub_10c1a

		bra	loc_10bd8

loc_10bd6:	set	c

loc_10bd8:	pop	er1

loc_10bdc:	bcc	rts_10bee

		push	er1
		mov	r1, r0
		jsr	cmpTick

		pop	er1
		bcc	loc_10b90

rts_10bee:	rts

; ----------------------------------------------

sub_10bf0:	jsr	sub_10c68

		bcs	loc_10bfe

		mov	r0h, @odr2		; LPC Output Data Register 2 (0x62)
		set	c
		bra	rts_10c00

loc_10bfe:	clr	c

rts_10c00:	rts

; ----------------------------------------------

off_10c02:	.long sub_10c9e			; 0
		.long sub_03abe			; 1
		.long sub_03ac8			; 2
		.long sub_045f2			; 3
		.long sub_04608			; 4
		.long NULL			; 5

; ----------------------------------------------

sub_10c1a:	bsr	sub_10c52

		bcs	loc_10c22

		set	c
		bra	rts_10c38

loc_10c22:	jsr	sub_01818

		jsr	sub_04cb6

		jsr	sub_03924

		bld	#1, r0h
		bst	#0, r0h
		jsr	sub_02128

		clr	c

rts_10c38:	rts

; ----------------------------------------------

off_10c3a:	.long sub_10cbc			; 0
		.long sub_03acc			; 1
		.long sub_03ad6			; 2
		.long sub_0460c			; 3
		.long sub_04616			; 4
		.long NULL			; 5

; ----------------------------------------------

sub_10c52:	bsr	sub_10c68

		bcs	rts_10c66

		mov	@long_ffed6c, er2
		mov	@er2, er3
		bne	rts_10c66

		set	c

rts_10c66:	rts

; ----------------------------------------------

sub_10c68:	mov	@long_ffed6c, er2
		beq	loc_10c9a

		mov	@er2, er3
		beq	loc_10c9a

		push	er1
		jsr	@er3

		pop	er1
		bcc	loc_10c96

		mov	@long_ffed6c, er2
		adds	#4, er2
		mov	er2, @long_ffed6c

loc_10c96:	clr	c
		bra	rts_10c9c

loc_10c9a:	set	c

rts_10c9c:	rts

; ----------------------------------------------

sub_10c9e:	push	er1
		jsr	sub_03ab4

		mov	r0h, r2h
		push	er2
		jsr	sub_045e8

		pop	er2
		add	r0h, r2h
		mov	r2, r0
		pop	er1

sub_10cbc:	set	c
		rts

; ----------------------------------------------

sub_10cc0:	cmp	#0x7f, r0h
		bhi	loc_10d56:16

		cmp	#0, r0h
		beq	loc_10d56:16

		push	er0
		jsr	sub_0126e

		pop	er0
		bcs	loc_10ce0

		jsr	sub_10238

		bra	loc_10d56

loc_10ce0:	jsr	sub_10d88

		mov	@dataTab, r0l
		btst	#1, r0l
		beq	loc_10d3e

		mov	@byte_ffe594, r0l	; 0x35
		btst	#3, r0l
		bne	loc_10d3e

		push	er0
		jsr	sub_10238

		pop	er0
		bsr	sub_10d5e

		bcs	loc_10d3e

		mov	@byte_ffe63f, r1h
		mov	@byte_ffe640, r1l
		mov	#byte_ffe62f, er2
		add	r1h, r2l
		addx	#0, r2h
		bcc	loc_10d22

		inc	#1, e2

loc_10d22:	mov	r0h, @er2
		inc	r1h
		and	#0x0f, r1h
		cmp	r1h, r1l
		bne	loc_10d30

		inc	r1l
		and	#0x0f, r1l

loc_10d30:	mov	r1h, @byte_ffe63f
		mov	r1l, @byte_ffe640
		bra	loc_10d56

loc_10d3e:	mov	@dataTab, r0l
		btst	#1, r0l
		bne	loc_10d56

		cmp	#0x28, r0h
		bne	loc_10d56

		jsr	sub_01276

		bcs	loc_10d56

		jsr	sub_017a0

loc_10d56:	mov	#task39o, r0h
		jsr	schedBackTask

		rts

; ----------------------------------------------

sub_10d5e:	bclr	#7, r0h
		mov	r0h, r0l
		mov	r0h, r1l
		and	#7, r0l
		shlr	r1l
		shlr	r1l
		shlr	r1l
		mov	#byte_ffe56f, er2	; 0x10
		add	r1l, r2l
		addx	#0, r2h
		bcc	loc_10d7a

		inc	#1, e2

loc_10d7a:	btst	r0l, @er2
		beq	loc_10d84

		clr	c
		bra	rts_10d86

loc_10d84:	set	c

rts_10d86:	rts

; ----------------------------------------------

sub_10d88:	cmp	#0x33, r0h
		beq	loc_10da4

		cmp	#0x39, r0h
		beq	loc_10da4

		cmp	#0x30, r0h
		beq	loc_10da4

		cmp	#0x10, r0h
		blo	rts_10db6

		cmp	#0x1f, r0h
		bls	loc_10da4

		cmp	#0x60, r0h
		blo	rts_10db6

		cmp	#0x6f, r0h
		bhi	rts_10db6

loc_10da4:	push	er0
		mov	#task41o, r0h
		jsr	schedBackTask

		pop	er0
		bset	#2, @execFlags:8

rts_10db6:	rts

; ----------------------------------------------

sub_10db8:	mov	@byte_ffe63f, r1h
		mov	@byte_ffe640, r1l
		cmp	r1h, r1l
		beq	loc_10de6

		mov	#byte_ffe62f, er2
		add	r1l, r2l
		addx	#0, r2h
		bcc	loc_10dd6

		inc	#1, e2

loc_10dd6:	mov	@er2, r0h
		inc	r1l
		and	#0x0f, r1l
		mov	r1l, @byte_ffe640
		clr	c
		bra	rts_10dea

loc_10de6:	set	c
		mov	#0, r0h

rts_10dea:	rts

; ----------------------------------------------

sub_10dec:	mov	@byte_ffe63f, r0h
		mov	r0h, @byte_ffe640
		rts

; ----------------------------------------------

sub_10dfa:	mov	r0l, @byte_ffe5a5	; 0x46
		mov	r0h, @byte_ffe5a6	; 0x47
		mov	e0, r0
		mov	r0l, @byte_ffe5a7	; 0x48
		mov	r0h, @byte_ffe5a8	; 0x49
		rts

; ----------------------------------------------

sub_10e16:	mov	@byte_ffe57f, r0l	; 0x20
		cmp	r0h, r0l
		beq	rts_10e2c

		mov	r0h, @byte_ffe57f	; 0x20
		mov	#0x40, r0h
		jsr	sub_10cc0

rts_10e2c:	rts

; ----------------------------------------------

sub_10e2e:	cmp	#0, r0h
		bne	loc_10e3c

		mov	#byte_ffe597, er1	; 0x38
		mov	#0x4a, r0h
		bra	loc_10e44

loc_10e3c:	mov	#byte_ffe598, er1	; 0x39
		mov	#0x4c, r0h

loc_10e44:	mov	@er1, r2h
		xor	r0l, r2h
		beq	rts_10e56

		mov	r0l, @er1
		btst	#7, r2h
		bne	loc_10e52

		inc	r0h

loc_10e52:	jsr	sub_10cc0

rts_10e56:	rts

; ----------------------------------------------

sub_10e58:	jmp	sub_10222

; ----------------------------------------------

rts_10e5c:	rts

; ----------------------------------------------

sub_10e5e:	set	c
		bra	loc_10e64

loc_10e62:	clr	c

loc_10e64:	bst	#0, @byte_ffe593	; 0x34
		rts

; ----------------------------------------------

sub_10e6e:	set	c
		bra	loc_10e74

sub_10e72:	clr	c

loc_10e74:	bst	#1, @byte_ffe593	; 0x34
		rts

; ----------------------------------------------

sub_10e7e:	set	c

loc_10e80:	stc	ccr, r1h
		cmp	#2, r0h
		bhs	rts_10ea0

		mov	#4, r0l
		add	r0l, r0h
		ldc	r1h, ccr
		bcs	loc_10e98

		bclr	r0h, @byte_ffe593	; 0x34
		bra	rts_10ea0

loc_10e98:	bset	r0h, @byte_ffe593	; 0x34

rts_10ea0:	rts


		clr	c
		bra	loc_10e80

; ----------------------------------------------

sub_10ea6:	cmp	#2, r0h
		bhs	rts_10eb6

		mov	#4, r0l
		add	r0l, r0h
		bset	r0h, @byte_ffe594	; 0x35

rts_10eb6:	rts

; ----------------------------------------------

getFanCtrl:	mov	@fanCtrl, r0h		; 0x2f fan ctrl/status
		rts

; ----------------------------------------------

setFanCtrl:	cmp	#0, r0h
		bne	rts_10eca

		mov	r0l, @fanCtrl		; 0x2f fan ctrl/status

rts_10eca:	rts

; ----------------------------------------------

sub_10ecc:	bset	#2, @byte_ffe594	; 0x35
		rts

; ----------------------------------------------

rts_10ed6:	rts

; ----------------------------------------------

sub_10ed8:	mov	r0h, @byte_ffe568	; 0x09
		rts

; ----------------------------------------------

sub_10ee0:	cmp	#0x10, r0h
		bhi	loc_10ee8

		add	#0x0f, r0h
		bra	loc_10eea

loc_10ee8:	add	#0x4f, r0h

loc_10eea:	jmp	sub_10cc0

; ----------------------------------------------

rts_10eee:	rts

; ----------------------------------------------

sub_10ef0:	bset	#0, @byte_ffe594	; 0x35
		bclr	#1, @byte_ffe594	; 0x35
		rts

; ----------------------------------------------

sub_10f02:	bclr	#0, @byte_ffe594	; 0x35
		bset	#1, @byte_ffe594	; 0x35
		rts

; ----------------------------------------------

sub_10f14:	bclr	#0, @byte_ffe594	; 0x35
		bclr	#1, @byte_ffe594	; 0x35
		rts

; ----------------------------------------------

sub_10f26:	mov	#byte_ffe58f, er1	; 0x30 volume

loc_10f2c:	set	i
		btst	#7, @er1
		bne	loc_10f36

		mov	r0h, @er1

loc_10f36:	clr	i
		rts


sub_10f3a:	mov	#byte_ffe590, er1	; 0x31 LCD brightness
		bra	loc_10f2c

; ----------------------------------------------

sub_10f42:	mov	r0h, @byte0xEE
		rts

; ----------------------------------------------

sub_10f4a:	mov	#byte_ffe593, er0	; 0x34
		bcc	loc_10f58

		bset	#7, @er0
		bra	rts_10f5c

loc_10f58:	bclr	#7, @er0

rts_10f5c:	rts

; ----------------------------------------------

; r0h: 0..f r0l: temperature

storeTemperat:
.if !type1R
		stm	er0-er2, @-sp
		cmp	#0x0f, r0h
		bhi	loc_10f84
.endif

		cmp	#7, r0h
		bhi	loc_10f72

.if type1R
		push	er1
		zero	er1
		mov	r0h, r1l
		add	#byte_ffe5d7, er1	; 0x78 temperature
		mov	r0l, @er1
		pop	er1
.else
		mov	#byte_ffe5d7, er2	; 0x78 temperature
		bra	loc_10f7a
.endif

loc_10f72:
.if !type1R
		mov	#byte_ffe61f, er2	; 0xc0 temperature
		and	#~8, r0h		; &= 7

loc_10f7a:	zero	er1
		mov	r0h, r1l
		add	er2, er1
		mov	r0l, @er1

loc_10f84:	ldm	@sp+, er0-er2
.endif
		rts

; ----------------------------------------------

setPINcopy:	stc	ccr, r0l
		cmp	#8, r0h
		bhs	rts_10fa4

		mov	#byte_ffe59a, er1	; 0x3b 7 !p74pin, 6 pd5pin, 5 pd6pin, 4 pd2pin, 3 ?, 2 pc4pin, 1 p13dr, 0 !pc5pin
		ldc	r0l, ccr
		bcc	loc_10fa0

		bset	r0h, @er1
		bra	rts_10fa4

loc_10fa0:	bclr	r0h, @er1

rts_10fa4:	rts

; ----------------------------------------------

getPINcopy:	cmp	#8, r0h
		bhs	loc_10fbc

		btst	r0h, @byte_ffe59a	; 0x3b 7 !p74pin, 6 pd5pin, 5 pd6pin, 4 pd2pin, 3 ?, 2 pc4pin, 1 p13dr, 0 !pc5pin
		beq	loc_10fb8

		set	c
		bra	loc_10fba

loc_10fb8:	clr	c

loc_10fba:	bra	rts_10fbe

loc_10fbc:	clr	c

rts_10fbe:	rts

; ----------------------------------------------

sub_10fc0:	mov	#byte_ffe5b0, er2	; 0x51
		bld	#6, @er2
		bcs	rts_10fea

		mov	r0h, @byte_ffe5d4	; 0x75
		mov	r1h, @byte_ffe5d5	; 0x76
		mov	r1l, @byte_ffe5d6	; 0x77
		bset	#6, @er2
		mov	#0x35, r0h
		jsr	sub_10cc0

		clr	c

rts_10fea:	rts

; ----------------------------------------------

sub_10fec:	bst	#6, @byte_ffe593	; 0x34
		rts

; ----------------------------------------------

sub_10ff6:	mov	r0, @word_ffed72
		jsr	sub_10222

		rts

; ----------------------------------------------

sub_11002:	mov	r0h, @byte_ffe110
		rts

; ----------------------------------------------

sub_1100a:	mov	r0h, @byte_ffe111
		rts

; ----------------------------------------------

sub_11012:	bclr	#3, @execFlags:8
		bsr	sub_11020

		jmp	sub_04bb8

; ----------------------------------------------

sub_1101c:	jmp	sub_101ce

; ----------------------------------------------

sub_11020:	jmp	sub_101f4

; ----------------------------------------------

sub_11024:	jmp	sub_04b70

; ----------------------------------------------

sub_11028:	jsr	sub_04bb8

		bset	#3, @execFlags:8
		bra	sub_1101c

; ----------------------------------------------

sub_11032:	cmp	#0x0f, r1h
		bls	loc_11038

		mov	#0x0f, r1h

loc_11038:	mov	@long_ffed7a, er2
		cmp	#RAM & M24, er2
		blo	loc_11050

		mov	@er2, r1l
		dec	r1l
		cmp	r1l, r1h
		bls	loc_11066

loc_11050:	stm	er0-er1, @-sp
		mov	r1h, r0l
		mov	#0, r0h
		inc	#1, r0
		jsr	malloc

		mov	er0, er2
		ldm	@sp+, er0-er1
		bra	loc_11068

loc_11066:	clr	c

loc_11068:	bcs	rts_11090

		push	er2
		inc	r1h
		mov	r1h, @er2
		adds	#1, er2
		mov	#0, r3h

loc_11076:	mov	r3h, @er2
		dec	r1h
		beq	loc_11082

		adds	#1, er2
		mov	@er0+, r3h
		bra	loc_11076

loc_11082:	pop	er2
		mov	er2, @long_ffed7a
		clr	c

rts_11090:	rts

; ----------------------------------------------

sub_11092:	set	i

loc_11094:	b tst	str2.obf2		; Output Buffer Full (LPC Status Register 2 (0x66))
		bne	loc_11094

		mov	#0x88, r0h
		mov	r0h, @odr2		; LPC Output Data Register 2 (0x62)

loc_110a2:	b tst	str2.obf2		; Output Buffer Full (LPC Status Register 2 (0x66))
		bne	loc_110a2

loc_110aa:	bsr	sub_110cc

		cmp	#0x55, r0h
		bne	loc_110aa

		bsr	sub_110cc

		mov	r0h, r3h
		bsr	sub_110cc

		mov	r0h, r3l
		mov	#exec, er2

loc_110be:	bsr	sub_110cc

		mov	r0h, @er2
		adds	#1, er2
		dec	#1, r3
		bne	loc_110be

		jmp	exec

; ----------------------------------------------

sub_110cc:	b tst	str2.ibf2		; Input Buffer Full (LPC Status Register 2 (0x66))
		beq	sub_110cc

		mov	@idr2, r0h		; LPC Input Data Register 2 (0x62/0x66)

		rts

; ----------------------------------------------

sub_110da:	jsr	sub_06762

		mov	r0h, @byte_ffe567	; 0x08
		rts

; ----------------------------------------------

.if level >= 0x01000062
sub_110e6:	bset	#4, @byte_ffe56d	; 0x0e
		rts

; ----------------------------------------------

sub_110f0:	bclr	#4, @byte_ffe56d	; 0x0e
		rts

; ----------------------------------------------

sub_110fa:	bset	#3, @byte_ffe56d	; 0x0e
		rts

; ----------------------------------------------

sub_11104:	bclr	#3, @byte_ffe56d	; 0x0e
		rts

; ----------------------------------------------

.if level >= 0x01000066
sub_1110e:	bset	#2, @byte_ffe56e	; 0x0f
		rts

; ----------------------------------------------

sub_11118:	bclr	#2, @byte_ffe56e	; 0x0f
		rts

; ----------------------------------------------

sub_11122:	bset	#3, @byte_ffe56e	; 0x0f
		rts

; ----------------------------------------------

sub_1112c:	bclr	#3, @byte_ffe56e	; 0x0f
		rts

; ----------------------------------------------

sub_11136:	bset	#0, @byte_ffe56e	; 0x0f
		rts

; ----------------------------------------------

sub_11140:	bclr	#0, @byte_ffe56e	; 0x0f
		rts

; ----------------------------------------------

sub_1114a:	bset	#1, @byte_ffe56e	; 0x0f
		rts

; ----------------------------------------------

sub_11154:	bclr	#1, @byte_ffe56e	; 0x0f
		rts

; ----------------------------------------------

.if type1R
sub_1070c:	bclr	#7, @byte_ffe583	; 0x24
		rts

; ----------------------------------------------

sub_10716:	bclr	#7, @byte_ffe584	; 0x25
		rts

; ----------------------------------------------

sub_10720:	mov	r0l, @byte_ffe583	; 0x24
		bclr	#7, @byte_ffe583	; 0x24
		rts

; ----------------------------------------------

sub_10730:	mov	r0l, @byte_ffe584	; 0x25
		bclr	#7, @byte_ffe584	; 0x25
		rts

; ----------------------------------------------

.else
		shll	#2, r0l
		shll	#2, r0l
		mov	@byte_ffe56e, r0h	; 0x0f
		mov	#0x70, r1l
		not	r1l
		and	r1l, r0h
		or	r0l, r0h
		mov	r0h, @byte_ffe56e	; 0x0f
		rts
.endif
.endif
.endif

; ----------------------------------------------

enableLPC3:	b clr	mstpcrl.mstp0		; LPC, WUEMRB (Module Stop Control Register L)
		mov	#0x1600, r0
		mov	r0h, @ladr3h		; LPC Channel 3 Address Register H
		mov	r0l, @ladr3l		; LPC Channel 3 Address Register L
		mov	#-1, r0h
		mov	r0h, @byte_ffe64a
		rts

; ----------------------------------------------

sub_11192:	bsr	sub_111cc

		rts

; ----------------------------------------------

sub_11196:	btst	#7, @byte_ffff45:8
		beq	rts_1119e

		bsr	sub_111a0

rts_1119e:	rts

; ----------------------------------------------

sub_111a0:	b set	hicr_0.lpc3e		; LPC Channel 3 Enable (LADR3) (LPC Host Interface Control Register 0)
		mov	#0, r0h
		mov	r0h, @str3		; LPC Status Register 3
		mov	#-1, r0h
		mov	r0h, @byte_ffe64a
		bclr	#6, @byte_ffff45:8
		b set	hicr_2.ibfie3		; IDR3 & TWR Receive Completion Interrupt Enable (LPC Host Interface Control Register 2)
		b set	ladr3l.twre		; Bidirectional Data Register Enable (LPC Channel 3 Address Register L)
		bset	#2, @ladr3l		; LPC Channel 3 Address Register L
		rts

; ----------------------------------------------

sub_111cc:	b clr	hicr_2.ibfie3		; IDR3 & TWR Receive Completion Interrupt Enable (LPC Host Interface Control Register 2)
		bclr	#2, @ladr3l		; LPC Channel 3 Address Register L
		b clr	ladr3l.twre		; Bidirectional Data Register Enable (LPC Channel 3 Address Register L)
		b clr	hicr_0.lpc3e		; LPC Channel 3 Enable (LADR3) (LPC Host Interface Control Register 0)
		rts

; ----------------------------------------------

task42:		btst	#7, @byte_ffff45:8
		beq	loc_11208

		mov	#-1, r0h
		mov	r0h, @byte_ffe64a
		btst	#6, @byte_ffff45:8
		beq	loc_11208

		set	i
		bclr	#6, @byte_ffff45:8
		b set	hicr_2.ibfie3		; IDR3 & TWR Receive Completion Interrupt Enable (LPC Host Interface Control Register 2)
		clr	i

loc_11208:	mov	#task42o, r0h
		jsr	schedFrontTask

		clr	c
		rts

; ----------------------------------------------

; LPC IDR3 Reception Completion

ibfi3:		b clr	hicr_2.ibfie3		; IDR3 & TWR Receive Completion Interrupt Enable (LPC Host Interface Control Register 2)
		clr	i
		stm	er0-er3, @-sp
		b tst	str3.ibf3a		; Input Buffer Full (LPC Status Register 3)
		beq	loc_1122a

		bsr	sub_1124e

		bra	loc_11236

loc_1122a:	b tst	str3.ibf3b		; Bidirectional Data Register Input Buffer Full (LPC Status Register 3)
		beq	loc_11236

		bsr	sub_11366:16

loc_11236:	cmp	#0, r0h
		bne	loc_11248

		ldm	@sp+, er0-er3
		set	i
		b set	hicr_2.ibfie3		; IDR3 & TWR Receive Completion Interrupt Enable (LPC Host Interface Control Register 2)
		bra	rts_1124c

loc_11248:	ldm	@sp+, er0-er3

rts_1124c:	rte

; ----------------------------------------------

sub_1124e:	b tst	str3.c_d3		; Command/-Data (LPC Status Register 3)
		beq	loc_1128c

		mov	@idr3, r0h		; LPC Input Data Register 3
		mov	#sub_112e8, er1
		cmp	#0x80, r0h
		beq	loc_1126e

		mov	#sub_1133a, er1
		cmp	#0x81, r0h
		bne	loc_11286

loc_1126e:	mov	#0, r0h
		mov	r0h, @byte_ffe649
		mov	er1, @long_ffed7e
		bset	#4, @byte_ffff45:8
		jsr	@er1

		bra	loc_1128a

loc_11286:	bclr	#4, @byte_ffff45:8

loc_1128a:	bra	loc_112ae

loc_1128c:	btst	#4, @byte_ffff45:8
		beq	loc_112ae

		mov	@byte_ffe649, r0h
		inc	r0h
		mov	r0h, @byte_ffe649
		mov	@long_ffed7e, er1
		mov	@idr3, r0l		; LPC Input Data Register 3
		jsr	@er1

loc_112ae:	mov	#0, r0h
		btst	#4, @byte_ffff45:8
		bne	loc_112ba

		bsr	sub_112be

		bra	rts_112bc

loc_112ba:	mov	#0, r0h

rts_112bc:	rts

; ----------------------------------------------

sub_112be:	mov	@byte_ffe64a, r0l
		inc	r0l
		mov	r0l, @byte_ffe64a
		bne	loc_112d8

		mov	#task42o, r0h
		jsr	schedBackTask

		mov	#0, r0h
		bra	rts_112e6

loc_112d8:	cmp	#0x20, r0l
		blo	loc_112e4

		bset	#6, @byte_ffff45:8
		mov	#1, r0h
		bra	rts_112e6

loc_112e4:	mov	#0, r0h

rts_112e6:	rts

; ----------------------------------------------

sub_112e8:	cmp	#0, r0h
		beq	loc_11336

		mov	#0, r0h
		cmp	#0x81, r0l
		bne	loc_112fa

		mov	@byte_ffe64b, r0h
		bra	loc_1132e

loc_112fa:	mov	r0l, r1h
		and	#0xf0, r1h
		cmp	#0xa0, r1h
		bne	loc_1132a

		mov	@byte_ffe64b, r1h
		mov	@byte_ffe64c, r1l
		mov	@long_ffed82, er2
		jsr	sub_10878

		mov	r1l, @byte_ffe64c
		mov	er2, @long_ffed82
		bra	loc_1132e

loc_1132a:	jsr	readByte

loc_1132e:	mov	r0h, @odr3		; LPC Output Data Register 3
		bclr	#4, @byte_ffff45:8

loc_11336:	mov	#0, r0h
		rts

; ----------------------------------------------

sub_1133a:	cmp	#1, r0h
		bne	loc_11346

		mov	r0l, @byte_ffe648
		bra	rts_11364

loc_11346:	cmp	#2, r0h
		bne	rts_11364

		mov	@byte_ffe648, r1l
		cmp	#0x81, r1l
		bne	loc_1135c

		mov	r0l, @byte_ffe64b
		bra	loc_11360

loc_1135c:	jsr	writeByte

loc_11360:	bclr	#4, @byte_ffff45:8

rts_11364:	rts

; ----------------------------------------------

sub_11366:	zero	er1
		mov	@twr0mw, r1l		; LPC Bidirectional Data Register 0MW
		cmp	#0x20, r1l
		bhs	loc_11384

		cmp	#0x10, r1l
		blo	loc_11398

		jsr	sub_0e610

		bcc	loc_11384

		jsr	sub_1167a

		bra	rts_11444:16

loc_11384:	mov	@twr15, r0l		; LPC Bidirectional Data Register 15

loc_11388:	b tst	str3.mwmf		; Master Write Mode Flag (LPC Status Register 3)
		bne	loc_11388

		mov	r1l, @twr0sw		; LPC Bidirectional Data Register 0SW
		bra	loc_11434:16

loc_11398:	jsr	sub_074d0

		mov	#0, r2h
		bist	#7, r2h
		bld	#7, @byte_ffe597	; 0x38
		bst	#6, r2h
		bld	#7, @byte_ffe598	; 0x39
		bst	#5, r2h
		mov	@twr15, r0h		; LPC Bidirectional Data Register 15
		mov	r2h, @twr0sw		; LPC Bidirectional Data Register 0SW
		b tst	str3.swmf		; Slave Write Mode Flag (LPC Status Register 3)
		beq	loc_11440

		shll	r1l
		add	#off_11446, er1
		mov	@er1, r2
		beq	loc_11434

		exts	er2
		add	er2, er1
		cmp	#1, r0h
		bne	loc_113e6

		mov	#byte_ffeb46, er3
		mov	@byte_ffe598, r0l	; 0x39
		bra	loc_113f2

loc_113e6:	mov	#byte_ffeaac, er3
		mov	@byte_ffe597, r0l	; 0x38

loc_113f2:	mov	#0, r0h
		bld	#5, r0l
		bst	#5, r0h
		bld	#6, r0l
		bst	#4, r0h
		bld	#4, r0l
		bst	#1, r0h
		bild	#7, r0l
		bst	#7, r0l
		and	#0x8f, r0l
		bne	loc_1140a

		bset	#3, r0h

loc_1140a:	push	er1
		mov	@twr15, r1h		; LPC Bidirectional Data Register 15
		cmp	#1, r1h
		bne	loc_1141c

		jsr	sub_0abb6

		bst	#0, r0h

loc_1141c:	pop	er1
		push	er1
		mov	@(0x10,er3), r1h
		bild	#7, r1h
		bst	#2, r0h
		pop	er1
		jsr	@er1

		bra	loc_11440

loc_11434:	mov	#0, r0h
		mov	r0h, @twr1		; LPC Bidirectional Data Register 1
		mov	#0x80, r0h
		mov	r0h, @twr15		; LPC Bidirectional Data Register 15

loc_11440:	bsr	sub_112be:16

rts_11444:	rts


off_11446:	case  0
.ifeq type1R && level < 0x01030069
		case  0 sub_114c0
.endif
		case  1 sub_114ee sub_11532 sub_1153a
		case  4 sub_11552 sub_11596 sub_115a0
		case  7 sub_115aa sub_11542 sub_1154a
.ifeq type1R && level < 0x01030069
		case 10 sub_115b4 sub_115f4
.endif
		case 16 sub_1163e sub_11644 sub_1164a sub_11650
		case 20 sub_11656 sub_1165c sub_11662 sub_11668
.if level >= 0x01000062
		case 24 sub_11674
.endif
		case 32

; ----------------------------------------------

		rts

; ----------------------------------------------

word_11488:	.word 0x10, 0x14, 0x16, 0x18, 0x1a, 0x1e, 0x20, 0
word_11498:	.word 0x22, 0x24, 0x98 - 0x20 & -(type1R && level < 0x01030069), 0x28, 0x2e, 0x30, 0
word_114a6:	.word 0x32, 0x34, 0x36, 0x38, 0x3a, 0
word_114b2:	.word 0x90 - 0x20 & -(type1R && level < 0x01030069), 0
word_114b6:	.word 0x0a, 0x1c, 0x2a, 0x2c, 0

; ----------------------------------------------

.ifeq type1R && level < 0x01030069
sub_114c0:	mov	#0x80, r0h
		mov	r0h, @twr1		; LPC Bidirectional Data Register 1
		mov	#1, r0h
		mov	r0h, @twr2		; LPC Bidirectional Data Register 2
		mov	#0, r0h
		mov	r0h, @twr3		; LPC Bidirectional Data Register 3
		mov	#0, r0h
		bset	#7, r0h
		mov	r0h, @twr4		; LPC Bidirectional Data Register 4
		mov	#0, r0h
		mov	#0x0b, r0l
		mov	#twr5 & M24, er1	; LPC Bidirectional Data Register 5

loc_114e4:	mov	r0h, @er1
		inc	#1, er1
		dec	r0l
		bne	loc_114e4

		rts
.endif

; ----------------------------------------------

sub_114ee:	mov	#word_11488, er1

loc_114f4:	btst	#4, @er3
		beq	loc_11528

		or	#0xc0, r0h
		mov	r0h, @twr1		; LPC Bidirectional Data Register 1
		mov	#twr2 & M24, er2	; LPC Bidirectional Data Register 2

loc_11506:	mov	@er1+, r0
		beq	loc_1151a

		zero	e0
		add	er3, er0
		mov	@er0, r0
		mov	r0l, @er2
		adds	#1, er2
		mov	r0h, @er2
		adds	#1, er2
		bra	loc_11506

loc_1151a:	cmp	#twr15 & M24, er2	; LPC Bidirectional Data Register 15
		bhi	loc_11526

		mov	r0h, @twr15		; LPC Bidirectional Data Register 15

loc_11526:	bra	rts_11530

loc_11528:	mov	r0h, @twr1		; LPC Bidirectional Data Register 1
		mov	r0h, @twr15		; LPC Bidirectional Data Register 15

rts_11530:	rts


sub_11532:	mov	#word_11498, er1
		bra	loc_114f4

sub_1153a:	mov	#word_114a6, er1
		bra	loc_114f4

sub_11542:	mov	#word_114b2, er1
		bra	loc_114f4

sub_1154a:	mov	#word_114b6, er1
		bra	loc_114f4

; ----------------------------------------------

sub_11552:	mov	#0x3c, r1
		mov	#0x10, e0

loc_1155a:	btst	#4, @er3
		beq	loc_1158c

		or	#0xc0, r0h
		mov	r0h, @twr1		; LPC Bidirectional Data Register 1
		zero	e1
		add	er3, er1
		mov	#twr2 & M24, er2	; LPC Bidirectional Data Register 2
		mov	#0x0e, r0h

loc_11572:	mov	@er1, r0l
		beq	loc_11578

		adds	#1, er1

loc_11578:	cmp	#0, e0
		bhi	loc_11580

		mov	#0, r0l

loc_11580:	mov	r0l, @er2
		adds	#1, er2
		dec	#1, e0
		dec	r0h
		bne	loc_11572

		bra	rts_11594

loc_1158c:	mov	r0h, @twr1		; LPC Bidirectional Data Register 1
		mov	r0h, @twr15		; LPC Bidirectional Data Register 15

rts_11594:	rts


sub_11596:	mov	#0x4c, r1
		mov	#0x10, e0
		bra	loc_1155a

sub_115a0:	mov	#0x5c, r1
		mov	#4, e0
		bra	loc_1155a

sub_115aa:	mov	#0x70 - 0x10 & -(type1R && level < 0x01030069), r1
		mov	#0x10, e0
		bra	loc_1155a

; ----------------------------------------------

.ifeq type1R && level < 0x01030069
sub_115b4:	mov	#0x60, r1
		mov	#0x10, e0

loc_115bc:	btst	#4, @er3
		beq	loc_115ea

		or	#0xc0, r0h
		mov	r0h, @twr1		; LPC Bidirectional Data Register 1
		zero	e1
		add	er3, er1
		mov	#twr2 & M24, er2	; LPC Bidirectional Data Register 2
		mov	#0x0e, r0h

loc_115d4:	mov	@er1+, r0l
		cmp	#0, e0
		bhi	loc_115de

		mov	#0, r0l

loc_115de:	mov	r0l, @er2
		adds	#1, er2
		dec	#1, e0
		dec	r0h
		bne	loc_115d4

		bra	rts_115f2

loc_115ea:	mov	r0h, @twr1		; LPC Bidirectional Data Register 1
		mov	r0h, @twr15		; LPC Bidirectional Data Register 15

rts_115f2:	rts

; ----------------------------------------------

sub_115f4:
.ifeq type1R && level < 0x01030071
		mov	@twr15, r0h		; LPC Bidirectional Data Register 15
		jsr	sub_0bb6c

		beq	loc_11434:16
.endif

		mov	#0x80, r1
		mov	#0x10, e0
		bra	loc_115bc
.endif

		or	#0xc0, r0h
		mov	r0h, @twr1		; LPC Bidirectional Data Register 1
		mov	#0, r0h
		mov	#twr2 & M24, er1	; LPC Bidirectional Data Register 2

loc_11618:	push	er0
		push	er1
		jsr	sub_13780

		pop	er1
		mov	r0h, @er1
		adds	#1, er1
		pop	er0
		inc	r0h
		cmp	#8, r0h
		bne	loc_11618

		mov	#0, r0h
		mov	r0h, @twr15		; LPC Bidirectional Data Register 15
		rts

; ----------------------------------------------

sub_1163e:	jsr	sub_0e26c

		rts

; ----------------------------------------------

sub_11644:	jsr	sub_0e346

		rts

; ----------------------------------------------

sub_1164a:	jsr	sub_0ea62

		rts

; ----------------------------------------------

sub_11650:	jsr	sub_0e46e

		rts

; ----------------------------------------------

sub_11656:	jsr	sub_0e49c

		rts

; ----------------------------------------------

sub_1165c:	jsr	sub_0e4be

		rts

; ----------------------------------------------

sub_11662:	jsr	sub_0e51c

		rts

; ----------------------------------------------

sub_11668:	jsr	sub_0e574

		rts

; ----------------------------------------------

		jsr	sub_0e60a

		rts

; ----------------------------------------------

.if level >= 0x01000062
sub_11674:	jsr	sub_0eab0

		rts
.endif

; ----------------------------------------------

sub_1167a:	mov	@twr15, r0l		; LPC Bidirectional Data Register 15

loc_1167e:	b tst	str3.mwmf		; Master Write Mode Flag (LPC Status Register 3)
		bne	loc_1167e

		mov	r1l, @twr0sw		; LPC Bidirectional Data Register 0SW
		shll	r1l
		add	#off_11446, er1
		mov	@er1, r2
		beq	loc_11434:16

		exts	er2
		add	er2, er1
		jsr	@er1

		mov	#0, r0h
		rts

; ----------------------------------------------

sub_116a2:	btst	#7, @byte_ffff45:8
		bne	rts_116b0

		bset	#7, @byte_ffff45:8
		bsr	sub_111a0:16

rts_116b0:	rts

; ----------------------------------------------

sub_116b2:	btst	#7, @byte_ffff45:8
		beq	rts_116c0

		bclr	#7, @byte_ffff45:8
		bsr	sub_111cc:16

rts_116c0:	rts

; ----------------------------------------------

sub_116c2:	mov	#0, r0h
		mov	r0h, @byte_ffff46:8
		mov	r0h, @byte_ffe67a
		rts

; ----------------------------------------------

task43:		btst	#3, @byte_ffff46:8
		beq	loc_11736

		bclr	#3, @byte_ffff46:8
		mov	#num_ffe64d, r0h
		mov	#byte_ffe64d, er1
		mov	#off_1179c, er2
		mov	#dataTab, er4

loc_116ec:	mov	@er1, r0l
		beq	loc_11724

		mov	#0, r3h

loc_116f2:	btst	r3h, @er1
		beq	loc_11718

		bclr	r3h, @er1
		mov	@er2, r5
		beq	loc_11718

		stm	er0-er3, @-sp
		push	er4
		exts	er5
		add	er2, er5
		mov	@er4, r0h
		jsr	@er5

		pop	er4
		ldm	@sp+, er0-er3

loc_11718:	adds	#2, er2
		adds	#1, er4
		inc	r3h
		cmp	#7, r3h
		bls	loc_116f2

		bra	loc_11730

loc_11724:	add	#0x10, er2
		add	#8, er4

loc_11730:	adds	#1, er1
		dec	r0h
		bne	loc_116ec

loc_11736:	mov	#task43o, r0h
		jsr	schedFrontTask

		clr	c
		rts

; ----------------------------------------------

task44:		btst	#0, @byte_ffff46:8
		beq	loc_11792

		mov	@word_ffed86, r0
		mov	@byte_ffe5ab, r1h	; 0x4c
		bmi	loc_1175a

		jsr	cmpTick

		bra	loc_1175e

loc_1175a:	jsr	sub_016e4

loc_1175e:	bcc	loc_1176c

		mov	#0x34, r0h
		jsr	sub_10cc0

		bclr	#0, @byte_ffff46:8
		bra	loc_11792

loc_1176c:	mov	#-1, r2
		sub	r0, r2
		mov	@byte_ffe5ab, r1h	; 0x4c
		bpl	loc_1178a

		cmp	#20, r2
		bls	loc_11784

		mov	#20, r2

loc_11784:	mov	#1000, r0
		mulxu	r0, er2

loc_1178a:	mov	r2, r1
		mov	#task44o, r0h
		jsr	schedBackTaskDelayed

loc_11792:	mov	#task44o, r0h
		jsr	schedFrontTask

		clr	c
		rts

; ----------------------------------------------

off_1179c:	case   0  sub_119bc sub_11a42 sub_11a8c
.if !type1R
		case   3  sub_11ad6
.endif
		case   4  sub_11bb4 sub_11bb4 sub_11c4c
		case   8  sub_11bc4 sub_1199c sub_119a0 sub_119b4
		case  12  sub_11db6 sub_119b8
.if level >= 0x01000062
		case  34  sub_12160 sub_12172
.endif
.if level >= 0x01000066
		case  36  sub_12186 sub_12194
.endif
		case  40  sub_11e20 sub_11e5e sub_11e12 sub_11e3a
		case  44  .         sub_11e46 .         sub_11e54
		case  48  sub_11ea2 sub_11eac sub_119ac sub_119b0
		case  58  sub_11b20 sub_11b6a .         sub_11bce
		case  74  sub_12046 .         sub_11c6a
		case  80  sub_11cac
		case 128  sub_11ec2 .         sub_119a8 sub_119a4
		case 136  sub_11f06
		case 144  sub_12502
.if !type1R
		case 200  sub_121a2
.endif
		case 256

; ----------------------------------------------

sub_1199c:	jmp	sub_0335a

; ----------------------------------------------

sub_119a0:	jmp	sub_048c4

; ----------------------------------------------

sub_119a4:	jmp	sub_0346a

; ----------------------------------------------

sub_119a8:	jmp	sub_07e3e

; ----------------------------------------------

sub_119ac:	jmp	sub_11002

; ----------------------------------------------

sub_119b0:	jmp	sub_1100a

; ----------------------------------------------

sub_119b4:	jmp	sub_090de

; ----------------------------------------------

sub_119b8:	jmp	sub_0ff66

; ----------------------------------------------

sub_119bc:	mov	#off_119f0, er1

loc_119c2:	mov	#0, r0l

loc_119c4:	btst	r0l, r0h
		beq	loc_119ce

		mov	@er1, er2
		bra	loc_119d4

loc_119ce:	mov	@(4,er1), er2

loc_119d4:	mov	er2, er3
		beq	loc_119e2

		stm	er0-er1, @-sp
		jsr	@er2

		ldm	@sp+, er0-er1

loc_119e2:	add	#8, er1
		inc	r0l
		cmp	#8, r0l
		blo	loc_119c4

		rts


off_119f0:	.long sub_147da			;  0
		.long sub_147d4			;  1
		.long NULL			;  2
		.long NULL			;  3
		.long sub_07a30			;  4
		.long sub_07a36			;  5
		.long sub_07cd8			;  6
		.long sub_07ce8			;  7
		.long sub_11a30			;  8
		.long sub_11a38			;  9
		.long sub_116a2			; 10
		.long sub_116b2			; 11
		.long NULL			; 12
		.long NULL			; 13
		.long sub_13734			; 14
		.long sub_13758			; 15

; ----------------------------------------------

sub_11a30:	mov	#2, r0h
		jsr	sub_02a00

		rts

; ----------------------------------------------

sub_11a38:	jsr	sub_033ba

		jsr	sub_0335a

		rts

; ----------------------------------------------

sub_11a42:	mov	#off_11a4c, er1
		bra	loc_119c2:16

off_11a4c:	.long sub_02078			;  0
		.long sub_0207e			;  1
.if type70
		.long NULL			;  2
		.long NULL			;  3
.else
		.long sub_0203c			;  2
		.long sub_02036			;  3
.endif
		.long sub_0729a			;  4
		.long sub_072a0			;  5
		.long NULL			;  6
		.long NULL			;  7
		.long sub_07268			;  8
		.long sub_07262			;  9
		.long sub_147e0			; 10
		.long sub_147e6			; 11
.if type70
		.long NULL			; 12
		.long NULL			; 13
.else
		.long sub_02048			; 12
		.long sub_02042			; 13
.endif
		.long sub_07dd6			; 14
		.long sub_07ddc			; 15

; ----------------------------------------------

sub_11a8c:	mov	#off_11a96, er1
		bra	loc_119c2:16

off_11a96:	.long NULL			;  0
		.long NULL			;  1
		.long NULL			;  2
		.long NULL			;  3
		.long NULL			;  4
		.long NULL			;  5
		.long NULL			;  6
		.long NULL			;  7
		.long NULL			;  8
		.long NULL			;  9
.if type1R
		.long NULL			; 10
		.long NULL			; 11
		.long NULL			; 12
		.long NULL			; 13
.else
		.long sub_02af6			; 10
		.long sub_02b00			; 11
		.long sub_02b0a			; 12
		.long sub_02b14			; 13
.endif
		.long sub_034d8			; 14
		.long sub_034dc			; 15

; ----------------------------------------------

.if !type1R
sub_11ad6:	mov	#off_11ae0, er1
		bra	loc_119c2:16

off_11ae0:	.long sub_14f64			;  0
		.long sub_14f7c			;  1
		.long sub_14f86			;  2
		.long sub_14f9a			;  3
		.long NULL			;  4
		.long NULL			;  5
		.long NULL			;  6
		.long NULL			;  7
		.long NULL			;  8
		.long NULL			;  9
		.long NULL			; 10
		.long NULL			; 11
		.long NULL			; 12
		.long NULL			; 13
		.long NULL			; 14
		.long NULL			; 15
.endif

; ----------------------------------------------

sub_11b20:	mov	#off_11b2a, er1
		bra	loc_119c2:16

off_11b2a:	.long sub_06774			;  0
		.long sub_06798			;  1
		.long NULL			;  2
		.long NULL			;  3
		.long sub_017a0			;  4
		.long NULL			;  5
		.long NULL			;  6
		.long NULL			;  7
		.long NULL			;  8
		.long NULL			;  9
		.long NULL			; 10
		.long NULL			; 11
		.long NULL			; 12
		.long NULL			; 13
		.long sub_0b510			; 14
		.long sub_0b50c			; 15

; ----------------------------------------------

sub_11b6a:	mov	#off_11b74, er1
		jmp	loc_119c2

off_11b74:	.long sub_01f22			;  0
		.long sub_01f2a			;  1
		.long lightOn			;  2
		.long lightOff			;  3
		.long sub_01f60			;  4
		.long sub_01f68			;  5
		.long rts_01f70			;  6
		.long rts_01f70			;  7
		.long sub_01f38			;  8
		.long sub_01f46			;  9
		.long sub_01f72			; 10
		.long sub_01f7a			; 11
		.long sub_01f82			; 12
		.long sub_01fa4			; 13
		.long sub_01fba			; 14
		.long sub_01fc2			; 15

; ----------------------------------------------

sub_11bb4:	mov	@byte_ffe563, r0h	; 0x04
		mov	@byte_ffe564, r0l	; 0x05
		jmp	loc_0673e

; ----------------------------------------------

sub_11bc4:	mov	@byte_ffe567, r0h	; 0x08
		jmp	loc_06756

; ----------------------------------------------

sub_11bce:	mov	#byte_ffe59d, er1	; 0x3e
		mov	@byte_ffe59c, r0h	; 0x3d
		mov	r0h, r0l
		and	#0x0f, r0h
		and	#0x70, r0l
		cmp	#0, r0l
		bne	loc_11bea

		jsr	sub_12786

		bra	loc_11c28

loc_11bea:	cmp	#0x40, r0l
		bne	loc_11c06

		jsr	sub_126fc

		bsr	sub_11c38

		jsr	sub_127cc

		mov	r0h, @byte_ffe5e5	; 0x86
		mov	r0l, @byte_ffe5e6	; 0x87
		bra	loc_11c28

loc_11c06:	cmp	#0x50, r0l
		bne	loc_11c28

		cmp	#0, r0h
		bne	loc_11c14

		jsr	sub_127ba

		bra	loc_11c26

loc_11c14:	cmp	#1, r0h
		bne	loc_11c1e

		jsr	sub_1280a

		bra	loc_11c26

loc_11c1e:	cmp	#0x0f, r0h
		bne	loc_11c26

		jsr	sub_12814

loc_11c26:	bsr	sub_11c38

loc_11c28:	mov	#0x36, r0h
		jsr	sub_10cc0

		bclr	#7, @byte_ffe59c	; 0x3d
		rts

; ----------------------------------------------

sub_11c38:	mov	#byte_ffe59d, er1	; 0x3e
		mov	#0, r0h
		mov	#8, r0l

loc_11c42:	mov	r0h, @er1
		adds	#1, er1
		dec	r0l
		bne	loc_11c42

		rts

; ----------------------------------------------

sub_11c4c:	cmp	#0, r0h
		bne	loc_11c56

		jsr	sub_06578

		bra	loc_11c60

loc_11c56:	mov	@byte_ffe566, r0l	; 0x07
		jsr	sub_0654a

loc_11c60:	mov	#0, r0h
		mov	r0h, @byte_ffe565	; 0x06
		rts

; ----------------------------------------------

sub_11c6a:	mov	@byte_ffe5ab, r0h	; 0x4c
		mov	@byte_ffe5ac, r0l	; 0x4d
		mov	r0, r1
		beq	loc_11ca6

		bclr	#7, r1h
		mov	r1, r2
		beq	loc_11ca6

		btst	#7, r0h
		beq	loc_11c8c

		mov	@word_ffe9be, r0
		bra	loc_11c92

loc_11c8c:	mov	@tick, r0

loc_11c92:	add	r1, r0
		mov	r0, @word_ffed86
		bset	#0, @byte_ffff46:8
		mov	#task44o, r0h
		jsr	schedBackTask

		bra	rts_11caa

loc_11ca6:	bclr	#0, @byte_ffff46:8

rts_11caa:	rts

; ----------------------------------------------

sub_11cac:	mov	@byte_ffe5b1, r1h	; 0x52
		cmp	#2, r1h
		bne	loc_11cee

		mov	@byte_ffe5b2, r0l	; 0x53
		mov	@byte_ffe5d3, r1h	; 0x74
		mov	#yearL, er2		; 0x54
		jsr	sub_121b6

loc_11ccc:
.if !type1R
		mov	r0l, @byte_ffe5d3	; 0x74
.endif
		cmp	#0, r0h
		bne	loc_11cd6

.if type1R
		mov	r0l, @byte_ffe5d3	; 0x74
.endif
loc_11cd6:	bset	#7, r0h
		jsr	sub_12028

		mov	#0, r0h
		mov	r0h, @byte_ffe5af	; 0x50
		mov	#0x35, r0h
		jsr	sub_10cc0

		bra	rts_11db4:16

loc_11cee:	mov	@byte_ffe5b1, r0l	; 0x52
		cmp	#0x12, r0l
		beq	loc_11d00

		cmp	#0x14, r0l
		beq	loc_11d00

		cmp	#0x16, r0l
		bne	loc_11d22

loc_11d00:	mov	r0l, r0h
		mov	@byte_ffe5af, r0l	; 0x50
		mov	@byte_ffe5b2, r1h	; 0x53
		mov	@byte_ffe5d3, r1l	; 0x74
		mov	#yearL, er2		; 0x54
		jsr	sub_0ccb6

		bra	loc_11ccc:16

loc_11d22:	mov	@byte_ffe5d3, r2l	; 0x74
		mov	@byte_ffe5af, r3h	; 0x50
		cmp	#0x0a, r3h
		beq	loc_11d34

		mov	#0x20, r2l

loc_11d34:	mov	#0, r2h
		btst	#1, @byte_ffe599	; 0x3a
		beq	loc_11d42

		mov	#4, r2h

loc_11d42:	mov	#byte_ffed88, er6
		btst	#7, @er6		; i2c00o
		bne	loc_11da6

		mov	@byte_ffe5af, r5h	; 0x50
		mov	r5h, @(i2c03o:16,er6)
		mov	@byte_ffe5b1, r5h	; 0x52
		mov	r5h, @(i2c05o:16,er6)
		mov	@byte_ffe5b2, r5h	; 0x53
		mov	r5h, @(i2c06o:16,er6)
		mov	#yearL, er5		; 0x54
		mov	er5, @(i2c08o:16,er6)
		mov	r2l, @(i2c02o:16,er6)
		mov	#loc_11ccc, er5
		mov	er5, @(i2c12o:16,er6)
		mov	#200, r5h
		mov	r5h, @(i2c20o:16,er6)
		mov	r2h, @(i2c00o:16,er6)
.if level >= 0x01000062
		mov	#0, r2h
		mov	r2h, @(i2c01o:16,er6)
.endif
		mov	er6, er0
		mov	#0, r1h
		mov	r1h, @(i2c04o:16,er0)
		jsr	enqueueI2Ccmd

		bra	loc_11daa

loc_11da6:	mov	#0x1a, r0h
		set	c

loc_11daa:	bcs	loc_11ccc:16

		mov	#0, r0h
		jsr	sub_12028

rts_11db4:	rts

; ----------------------------------------------

sub_11db6:	bsr	sub_1211a:16

		bcs	rts_11dc0

		bsr	sub_11dc2

		bra	sub_11db6

rts_11dc0:	rts

; ----------------------------------------------

sub_11dc2:	zero	er1
		mov	r0h, r1l
		and	#0x0f, r1l
		mov	@(byte_11e02,er1), r0l
		cmp	#-1, r0l
		beq	rts_11df0

		zero	er1
		mov	r0h, r1l
		shlr	#2, r1l
		shlr	#2, r1l
		and	#0x0c, r1l
		mov	@(off_11df2,er1), er1
		mov	r0l, r0h
		jsr	@er1

rts_11df0:	rts


off_11df2:	.long sub_068e6, sub_068e6, sub_068e2, sub_0693c

byte_11e02:	.byte 0, 4, 5, -1, 3, -1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1

; ----------------------------------------------

sub_11e12:	jsr	sub_10cc0

		mov	#0, r0h
		mov	r0h, @byte_ffe589	; 0x2a
		rts

; ----------------------------------------------

sub_11e20:	jsr	delay50

		jsr	delay25

		mov	@byte_ffe587, r0h	; 0x28
		jsr	sub_07278

		mov	r0h, @byte_ffe587	; 0x28
		rts

; ----------------------------------------------

sub_11e3a:	mov	@byte_ffe58b, r0l	; 0x2c
		mov	r0, r1
		mov	#0, r0h
		bra	loc_11e50

sub_11e46:	mov	@byte_ffe58d, r0l	; 0x2e
		mov	r0, r1
		mov	#1, r0h

loc_11e50:	jmp	loc_0c784

; ----------------------------------------------

sub_11e54:	mov	r0h, r0l
		mov	#0, r0h
		jsr	confSpeedMode

		rts

; ----------------------------------------------

sub_11e5e:	cmp	#0x10, r0h
		bhs	loc_11e78

		mov	#off_11e82, er1
		shll	#2, r0h
		add	r0h, r1l
		addx	#0, r1h
		bcc	loc_11e72

		inc	#1, e1

loc_11e72:	mov	@er1, er0
		jsr	@er0

loc_11e78:	mov	#0, r0h
		mov	r0h, @byte_ffe588	; 0x29
		rts


off_11e82:	.long rts_11edc			; 0
		.long sub_11012			; 1
		.long sub_1101c			; 2
		.long sub_11020			; 3
		.long sub_11024			; 4
		.long sub_11028			; 5
		.long sub_04b9a			; 6
		.long sub_04bb8			; 7

; ----------------------------------------------

sub_11ea2:	mov	#0, r0h
		mov	#byte_ffe58f, er1	; 0x30 volume
		bra	loc_11eb4

sub_11eac:	mov	#1, r0h
		mov	#byte_ffe590, er1	; 0x31 LCD brightness

loc_11eb4:	set	i
		mov	@er1, r0l
		bclr	#7, @er1
		clr	i
		jmp	loc_0fdd4

; ----------------------------------------------

sub_11ec2:	cmp	#3, r0h
		bhs	rts_11edc

		mov	#off_11ede, er1
		shll	#2, r0h
		add	r0h, r1l
		addx	#0, r1h
		bcc	loc_11ed6

		inc	#1, e1

loc_11ed6:	mov	@er1, er0
		jsr	@er0

rts_11edc:	rts


off_11ede:	.long rts_11edc, sub_11eea, sub_11eee

; ----------------------------------------------

sub_11eea:	clr	c
		bra	loc_11ef0

sub_11eee:	set	c

loc_11ef0:	bst	#3, @byte_ffe594	; 0x35
		jsr	sub_10dec

		mov	#0, r0h
		mov	r0h, @byte_ffe5df	; 0x80
		rts

; ----------------------------------------------

sub_11f06:	mov	#0, r0l
		mov	r0l, @byte_ffe668
		mov	r0l, @byte_ffe669

sub_11f14:	mov	@byte_ffe5e7, r0h	; 0x88
		btst	#4, r0h
		beq	loc_11f22

		mov	#0x0e, r2h
		bra	loc_11f24

loc_11f22:	mov	#0x0f, r2h

loc_11f24:	mov	r0h, r2l
		and	#0x0f, r2l
		beq	loc_11f8c

		mov	#byte_ffed9e, er6
		btst	#7, @er6		; i2c00o
		bne	loc_11f86

		mov	r2h, @(i2c03o:16,er6)
		mov	#0xa2, r5h
		mov	r5h, @(i2c05o:16,er6)
		mov	@byte_ffe5e8, r5h	; 0x89
		mov	r5h, @(i2c06o:16,er6)
		mov	#byte0xB0, er5
		mov	er5, @(i2c08o:16,er6)
		mov	r2l, @(i2c02o:16,er6)
		mov	#loc_11f90, er5
		mov	er5, @(i2c12o:16,er6)
		mov	#200, r5h
		mov	r5h, @(i2c20o:16,er6)
		mov	#0, r5h
		mov	r5h, @(i2c00o:16,er6)
.if level >= 0x01000062
		mov	#0, r5h
		mov	r5h, @(i2c01o:16,er6)
.endif
		mov	er6, er0
		mov	#0, r1h
		mov	r1h, @(i2c04o:16,er0)
		jsr	enqueueI2Ccmd

		bra	loc_11f8a

loc_11f86:	mov	#0x1a, r0h
		set	c

loc_11f8a:	bra	rts_11f8e

loc_11f8c:	bsr	sub_1200a

rts_11f8e:	rts


loc_11f90:	cmp	#0, r0h
		bne	loc_11fea

		mov	@byte_ffe5e7, r1h	; 0x88
		btst	#4, r1h
		bne	loc_11fe6

		mov	#byte0xB0, er0
		and	#0x0f, r1h
		jsr	sub_0f4c0

		mov	@byte_ffe668, r0l
		bne	loc_11fbc

		mov	r0h, @byte_ffe667
		inc	r0l
		bra	loc_11fd2

loc_11fbc:	mov	@byte_ffe667, r1h
		cmp	r0h, r1h
		bne	loc_11fca

		inc	r0l
		bra	loc_11fd2

loc_11fca:	mov	r0h, @byte_ffe667
		mov	#1, r0l

loc_11fd2:	mov	r0l, @byte_ffe668
		cmp	#3, r0l
		bls	loc_11fe0

		bsr	sub_12006

		bra	loc_11fe4

loc_11fe0:	bsr	sub_11f14:16

loc_11fe4:	bra	loc_11fe8

loc_11fe6:	bsr	sub_12006

loc_11fe8:	bra	rts_12004

loc_11fea:	mov	@byte_ffe669, r0h
		cmp	#8, r0h
		blo	loc_11ff8

		bsr	sub_1200a

		bra	rts_12004

loc_11ff8:	inc	r0h
		mov	r0h, @byte_ffe669
		bsr	sub_11f14:16

rts_12004:	rts

; ----------------------------------------------

sub_12006:	mov	#0x80, r0h
		bra	loc_12012

sub_1200a:	mov	r0h, @byte0xB0
		mov	#0xc0, r0h

loc_12012:	set	i
		mov	@byte_ffe5e7, r0l	; 0x88
		and	#0xc0, r0l
		or	r0h, r0l
		mov	r0l, @byte_ffe5e7	; 0x88
		clr	i
		rts

; ----------------------------------------------

sub_12028:	push	er0
		set	i
		mov	@byte_ffe5b0, r0l	; 0x51
		bld	#6, r0l
		bst	#6, r0h
		mov	r0h, @byte_ffe5b0	; 0x51
		clr	i
		pop	er0
		rts

; ----------------------------------------------

sub_12046:	mov	@byte_ffe5a9, r0h	; 0x4a
		mov	@byte_ffe5aa, r0l	; 0x4b
		bclr	#7, r0h
		jsr	sub_10ff6

		rts

; ----------------------------------------------

writeByte:	cmp	#0x51, r1l
		bne	loc_1206c

		bld	#6, r0l
		bcs	loc_1206a

		bclr	#6, @byte_ffe5b0	; 0x51

loc_1206a:	bra	rts_120de

loc_1206c:
.if type1R
		cmp	#0xa0, r1l
		bhs	loc_10d76
.else
		cmp	#0xb0, r1l
		blo	loc_12086

		cmp	#0xc0, r1l
		bhs	loc_12086

		zero	er2
		mov	r1l, r2l
		and	#0x0f, r2l
		mov	r0l, @(byte0xB0,er2)
		bra	rts_120de

loc_12086:	cmp	#0xd0, r1l
		bhs	rts_120de
.endif

		cmp	#0x0c, r1l
		bne	loc_1209c

		push	er1
		mov	r0l, r0h
		bsr	sto0C

		pop	er1
		bra	loc_120c0

loc_1209c:	cmp	#6, r1l
		bne	loc_120a8

		bset	#1, @byte_ffe593	; 0x34

loc_120a8:
.if level >= 0x01030000
		cmp	#0x8c, r1l
		bne	1f

		jsr	sto8C

		bra	rts_120de

1:
.endif
		zero	er2
		mov	r1l, r2l
		mov	r0l, @(dataTab,er2)

loc_120c0:	mov	r1l, r1h
		shlr	#2, r1l
		shlr	r1l
		and	#7, r1h
		mov	r1l, r2l
		add	#byte_ffe64d, er2
		bset	r1h, @er2
		bset	#3, @byte_ffff46:8
		mov	#task43o, r0h
		jsr	schedBackTask

.if type1R
		bra	rts_120de

loc_10d76:	cmp	#0xb0, r1l
		blo	rts_120de

		cmp	#0xc0, r1l
		bhs	rts_120de

		zero	er2
		mov	r1l, r2l
		and	#0x0f, r2l
		mov	r0l, @(byte0xB0,er2)
.endif

rts_120de:	rts

; ----------------------------------------------

sto0C:		stc	ccr, r3h
		set	i
		mov	@byte_ffe67a, r0l
		mov	r0l, r1h
		mov	r0l, r1l
		and	#3, r1h
		shlr	#2, r1l
		and	#3, r1l
		btst	#7, r0l
		beq	loc_120fc

		cmp	r1h, r1l
		beq	loc_12116

loc_120fc:	add	#4, r0l
		and	#0x0f, r0l
		bset	#7, r0l
		mov	r0l, @byte_ffe67a
		zero	er2
		mov	r1l, r2l
		mov	r0h, @(byte_ffe67b,er2)

loc_12116:	ldc	r3h, ccr
		rts

; ----------------------------------------------

sub_1211a:	stc	ccr, r3h
		set	i
		mov	@byte_ffe67a, r0l
		btst	#7, r0l
		beq	loc_1215a

		mov	r0l, r1h
		mov	r0l, r1l
		and	#3, r1h
		shlr	#2, r1l
		and	#3, r1l
		zero	er2
		mov	r1h, r2l
		mov	@(byte_ffe67b,er2), r0h
		inc	r1h
		and	#3, r1h
		cmp	r1h, r1l
		bne	loc_1214a

		bclr	#7, r0l

loc_1214a:	and	#0xfc, r0l
		or	r1h, r0l
		mov	r0l, @byte_ffe67a
		ldc	r3h, ccr
		clr	c
		bra	rts_1215e

loc_1215a:	ldc	r3h, ccr
		set	c

rts_1215e:	rts

; ----------------------------------------------

.if level >= 0x01000062
sub_12160:	mov	@byte_ffe580, r0l	; 0x21
		mov	@byte_ffe581, r0h	; 0x22
		jsr	sub_0b734

		rts

; ----------------------------------------------

sub_12172:	mov	@byte_ffe582, r0l	; 0x23
		jsr	sub_0b356

		mov	#0, r0l
		mov	r0l, @byte_ffe582	; 0x23
		rts

; ----------------------------------------------

.if level >= 0x01000066
sub_12186:	mov	@byte_ffe583, r0l	; 0x24
		mov	#0, r0h
		jsr	sub_0b61c

		rts

; ----------------------------------------------

sub_12194:	mov	@byte_ffe584, r0l	; 0x25
		mov	#1, r0h
		jsr	sub_0b61c

		rts

; ----------------------------------------------

.if !type1R
sub_121a2:	mov	@tabSel, r0l		; 0xc8 0x, 1x, 2x, F0..F1
		jsr	setFanSpeedProfile

		mov	#0, r0l
		mov	r0l, @tabSel		; 0xc8 0x, 1x, 2x, F0..F1
		rts
.endif
.endif
.endif

; ----------------------------------------------

sub_121b6:	cmp	#0x24 - 3 & type1R, r0l
		bhs	loc_121d4

		zero	er3
		shll	r0l
		mov	r0l, r3l
		add	#off_121d8, er3
		mov	@er3, r4
		beq	loc_121d4

		exts	er4
		add	er4, er3
		jsr	@er3

		bra	rts_121d6

loc_121d4:	mov	#0, r0h

rts_121d6:	rts


off_121d8:	case  0 .         sub_12220 sub_1224c
		case  9 sub_12264 sub_12280
		case 12 sub_122a6 sub_122be sub_122d6
		case 18 sub_122f4 .         sub_123cc
		case 25 sub_1240e
		case 30 sub_124ca sub_12492 sub_12690
.if !type1R
		case 33 sub_14fb8 sub_15008 sub_1507e
.endif

; ----------------------------------------------

sub_12220:	cmp	#0x0a, r0h
		bne	loc_12248

		cmp	#1, r1h
		bls	loc_12248

		mov	r1h, r0l
		dec	r0l
		mov	@yearL, r0h		; 0x54
		mov	#yearH, er1		; 0x55
		jsr	sub_07e9a

		bcs	loc_12244

		mov	#0, r0h
		mov	#0, r0l
		bra	loc_12246

loc_12244:	mov	#0x12, r0h

loc_12246:	bra	rts_1224a

loc_12248:	mov	#0x12, r0h

rts_1224a:	rts

; ----------------------------------------------

sub_1224c:	cmp	#0x0a, r0h
		bne	loc_12260

		mov	#yearL, er0		; 0x54
		jsr	sub_137cc

		mov	#0, r0h
		mov	#0, r0l
		bra	rts_12262

loc_12260:	mov	#0x12, r0h

rts_12262:	rts

; ----------------------------------------------

sub_12264:	cmp	#0x0a, r0h
		bne	loc_1227c

		cmp	#0x10, r1h
		blo	loc_1227c

		mov	#yearL, er0		; 0x54
		jsr	sub_14768

		mov	#0, r0h
		mov	#0, r0l
		bra	rts_1227e

loc_1227c:	mov	#0x12, r0h

rts_1227e:	rts

; ----------------------------------------------

sub_12280:	cmp	#0x0a, r0h
		bne	loc_122a2

		cmp	#1, r1h
		blo	loc_122a2

		mov	@yearL, r0h		; 0x54
		mov	r1h, r0l
		dec	r0l
		mov	#yearH, er1		; 0x55
		jsr	sub_0fea8

		mov	#0, r0h
		mov	#0, r0l
		bra	rts_122a4

loc_122a2:	mov	#0x12, r0h

rts_122a4:	rts

; ----------------------------------------------

sub_122a6:	cmp	#0x0b, r0h
		bne	loc_122ba

		mov	#yearL, er0		; 0x54
		jsr	sub_14050

		mov	r0h, r0l
		mov	#0, r0h
		bra	rts_122bc

loc_122ba:	mov	#0x12, r0h

rts_122bc:	rts

; ----------------------------------------------

sub_122be:	cmp	#0x0a, r0h
		bne	loc_122d2

		mov	#yearL, er0		; 0x54
		jsr	sub_140a0

		mov	#0, r0h
		mov	#0, r0l
		bra	rts_122d4

loc_122d2:	mov	#0x12, r0h

rts_122d4:	rts

; ----------------------------------------------

sub_122d6:	cmp	#0x0a, r0h
		bne	loc_122f0

		mov	#yearL, er0		; 0x54
		jsr	sub_11032

		bcs	loc_122ec

		mov	#0, r0h
		mov	#0, r0l
		bra	loc_122ee

loc_122ec:	mov	#0x12, r0h

loc_122ee:	bra	rts_122f2

loc_122f0:	mov	#0x12, r0h

rts_122f2:	rts

; ----------------------------------------------

sub_122f4:	cmp	#0x0a, r0h
		bne	loc_12306

		mov	#off_12380, er2
		mov	#off_123a8, er3
		bra	loc_12318

loc_12306:	cmp	#0x0b, r0h
		bne	loc_1237c

		mov	#off_12384, er2
		mov	#off_123b4, er3
		mov	#0x0a, r1h

loc_12318:	mov	#yearL, er4		; 0x54
		mov	#0, r1l

loc_12320:	cmp	#0x0a, r1l
		bhs	loc_1236e

		cmp	r1l, r1h
		bls	loc_1236e

		mov	@er2, er5
		beq	loc_12358

		mov	@er3, er0
		jsr	@er0

		push	er1
		push	er2
		push	er3
		push	er4
		jsr	@er5

		pop	er4
		pop	er3
		pop	er2
		pop	er1
		bra	loc_1235a

loc_12358:	mov	#-1, r0h

loc_1235a:	mov	@(4,er3), er5
		jsr	@er5

		adds	#1, er4
		add	#8, er2
		inc	r1l
		bra	loc_12320

loc_1236e:	mov	#0, r0l
		mov	@(8,er3), er5
		jsr	@er5

		mov	#0, r0h
		bra	rts_1237e

loc_1237c:	mov	#0x12, r0h

rts_1237e:	rts


off_12380:	.long rts_072ae

off_12384:	.long sub_072b0
		.long NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL

off_123a8:	.long sub_123c0, rts_123ca, rts_123ca

off_123b4:	.long rts_123ca, sub_123c4, sub_123c8

; ----------------------------------------------

sub_123c0:	mov	@er4, r0h
		rts

; ----------------------------------------------

sub_123c4:	mov	r0h, @er4
		rts

; ----------------------------------------------

sub_123c8:	mov	r1h, r0l

; ----------------------------------------------

rts_123ca:	rts

; ----------------------------------------------

sub_123cc:	cmp	#0x0a, r0h
		bne	loc_1240a

		cmp	#1, r1h
		blo	loc_123ee

		mov	@yearL, r0h		; 0x54
		cmp	#90, r0h
		bne	loc_123ee

		mov	r1h, r0h
		dec	r0h
		mov	#yearH, er1		; 0x55
		jsr	sub_12842

		bra	clear0x54_73

loc_123ee:	jsr	sub_12838

clear0x54_73:	mov	#0, r0h
		mov	#0x20, r0l
		mov	#yearL, er1		; 0x54

loc_123fc:	mov	r0h, @er1
		adds	#1, er1
		dec	r0l
		bne	loc_123fc

		mov	#0, r0h
		mov	#0, r0l
		bra	rts_1240c

loc_1240a:	mov	#0x12, r0h

rts_1240c:	rts

; ----------------------------------------------

sub_1240e:	cmp	#0x0a, r0h
		bne	loc_1244a

		cmp	#7, r1h
		bne	loc_1244a

		mov	@yearL, r0l		; 0x54
		mov	@yearH, r0h		; 0x55
		mov	@month, r1h		; 0x56
		mov	@day, r1l		; 0x57
		mov	@hour, r2h		; 0x58
		mov	@minute, r2l		; 0x59
		mov	@second, r3h		; 0x5a
		jsr	setDate

		mov	#0, r0h
		mov	#0, r0l
		bra	rts_12490

loc_1244a:	cmp	#0x0b, r0h
		bne	loc_1248e

		jsr	sub_06cc6

		bcc	loc_1245e

		mov	#0, r0
		mov	r0, r1
		mov	r0, r2
		mov	r0, r3

loc_1245e:	mov	r0l, @yearL		; 0x54
		mov	r0h, @yearH		; 0x55
		mov	r1h, @month		; 0x56
		mov	r1l, @day		; 0x57
		mov	r2h, @hour		; 0x58
		mov	r2l, @minute		; 0x59
		mov	r3h, @second		; 0x5a
		mov	#0, r0h
		mov	#7, r0l
		bra	rts_12490

loc_1248e:	mov	#0x12, r0h

rts_12490:	rts

; ----------------------------------------------

sub_12492:	cmp	#10, r0h
		bne	loc_124be

		cmp	#8, r1h
		bne	loc_124be

		mov	#yearL, er2		; 0x54
		mov	#byte_124c2, er3

loc_124a6:	mov	@er2+, r4h
		mov	@er3+, r4l
		cmp	r4h, r4l
		bne	loc_124be

		dec	r1h
		bne	loc_124a6

		mov	#0, r0h
		jsr	sub_0c818

		mov	#1, r0h
		jsr	sub_0c818

loc_124be:	mov	#18, r0h
		rts


byte_124c2:	.byte 0x54, 0x36, 0x38, 0x2d, 0x73, 0xfc, 0x02, 0xd8

; ----------------------------------------------

sub_124ca:	cmp	#8, r0h
		bne	loc_124e4

		mov	@yearL, r0l		; 0x54
		mov	@yearH, r0h		; 0x55
		jsr	sub_0c6b4

		mov	#0, r0h
		mov	#0, r0l
		bra	rts_12500

loc_124e4:	cmp	#9, r0h
		bne	loc_124fe

		jsr	sub_0c6ac

		mov	r0l, @yearL		; 0x54
		mov	r0h, @yearH		; 0x55
		mov	#0, r0h
		mov	#0, r0l
		bra	rts_12500

loc_124fe:	mov	#18, r0h

rts_12500:	rts

; ----------------------------------------------

sub_12502:	bclr	#7, r0h
		cmp	#8, r0h
		bhs	loc_12516

		push	er0
		jsr	sub_127f8

		pop	er0
		bcs	loc_1254e

loc_12516:	cmp	#11, r0h
		bhs	loc_1254e

		shll	r0h
		mov	#off_12558, er1
		add	r0h, r1l
		addx	#0, r1h
		bcc	loc_1252a

		inc	#1, e1

loc_1252a:	mov	@er1, r0
		exts	er0
		add	er1, er0
		mov	#M24 >> 16, e1		; I/O Register Address Upper Word
		mov	@byte_ffe5f1, r1h	; 0x92 I/O register address MSB
		mov	@byte_ffe5f2, r1l	; 0x93 I/O register address LSB
		mov	@byte_ffe5f3, r2h	; 0x94 I/O register data (PIN register)
		mov	@byte_ffe5f4, r2l	; 0x95 I/O register data (copy of DDR)
		jsr	@er0

loc_1254e:	bclr	#7, @byte_ffe5ef	; 0x90

rts_12556:	rts


off_12558:	case 0	rts_12556 sub_1256e sub_1258a sub_1259e
		case 4	sub_125b2 sub_125d0 sub_125ee sub_125f2
		case 8	getPIN_DDRcopy getPIN_DDRcopy sub_1266c

; ----------------------------------------------

sub_1256e:	bsr	sub_12578

		mov	r0h, @byte_ffe5f3	; 0x94 I/O register data (PIN register)
		rts

; ----------------------------------------------

sub_12578:	mov	#RAM & M24, er0
		cmp	er0, er1
		blo	loc_12586

		mov	@er1, r0h
		bra	rts_12588

loc_12586:	mov	#0, r0h

rts_12588:	rts

; ----------------------------------------------

sub_1258a:	bsr	sub_12578

		mov	r0h, @byte_ffe5f3	; 0x94 I/O register data (PIN register)
		adds	#1, er1
		bsr	sub_12578

		mov	r0h, @byte_ffe5f4	; 0x95 I/O register data (copy of DDR)
		rts

; ----------------------------------------------

sub_1259e:	mov	@byte_ffe5f3, r0h	; 0x94 I/O register data (PIN register)

sub_125a4:	mov	#RAM & M24, er2
		cmp	er2, er1
		blo	rts_125b0

		mov	r0h, @er1

rts_125b0:	rts

; ----------------------------------------------

sub_125b2:	btst	#0, r1l
		beq	loc_125c2

		bsr	sub_1259e

		adds	#1, er1
		mov	@0x95,	r0h
		bsr	sub_125a4

		bra	rts_125ce

loc_125c2:	mov	#RAM & M24, er0
		cmp	er0, er1
		blo	rts_125ce

		mov	r2, @er1

rts_125ce:	rts

; ----------------------------------------------

sub_125d0:	mov	#byte_ffe5f3, er2	; 0x94 I/O register data (PIN register)
		mov	#8, r3h

loc_125d8:	stm	er2-er3, @-sp
		bsr	sub_12578

		ldm	@sp+, er2-er3
		mov	r0h, @er2
		adds	#1, er1
		adds	#1, er2
		dec	r3h
		bne	loc_125d8

		rts

; ----------------------------------------------

sub_125ee:	mov	#1, r0h
		bra	loc_125f4

sub_125f2:	mov	#0, r0h

loc_125f4:	mov	#RAM & M24, er3
		cmp	er3, er1
		blo	rts_1260c

		cmp	#0, r0h
		bne	loc_12608

		bclr	r2h, @er1
		bra	rts_1260c

loc_12608:	bset	r2h, @er1

rts_1260c:	rts

; ----------------------------------------------

getPIN_DDRcopy: cmp	#0x0f, r1h
		bhs	loc_1263c

		mov	#P1DDRcopy, er2
		add	r1h, r2l
		addx	#0, r2h
		bcc	loc_12620

		inc	#1, e2

loc_12620:	mov	#off_1264e, er3
		shll	r1h
		add	r1h, r3l
		addx	#0, r3h
		bcc	loc_12630

		inc	#1, e3

loc_12630:	mov	@er3, r4
		mov	#M24 >> 16, e4		; I/O Register Address Upper Word
		mov	@er4, r0h
		mov	@er2, r0l
		bra	loc_12640

loc_1263c:	mov	#-1, r0

loc_12640:	mov	r0h, @byte_ffe5f3	; 0x94 I/O register data (PIN register)
		mov	r0l, @byte_ffe5f4	; 0x95 I/O register data (copy of DDR)
		rts


off_1264e:	.word p1dr			; Port 1 Data Register
		.word p2dr			; Port 2 Data Register
		.word p3dr			; Port 3 Data Register
		.word p4dr			; Port 4 Data Register
		.word p5dr			; Port 5 Data Register
		.word p6dr			; Port 6 Data Register
		.word p7pin			; Port 7 Input Data Register
		.word p8dr			; Port 8 Data Register
		.word p9dr			; Port 9 Data Register
		.word papin			; Port A Input Data Register
		.word pbpin			; Port B Input Data Register
		.word pcpin			; Port C Input Data Register
		.word pdpin			; Port D Input Data Register
		.word pepin			; Port E Input Data Register
		.word pfpin			; Port F Input Data Register

; ----------------------------------------------

sub_1266c:	cmp	#0x400, r1
		blo	loc_12680

		cmp	#0x1000, r1
		bhs	loc_12680

		bclr	#0, r1l
		zero	e1
		mov	@er1, r0
		bra	loc_12682

loc_12680:	zero	r0

loc_12682:	mov	r0h, @byte_ffe5f3	; 0x94 I/O register data (PIN register)
		mov	r0l, @byte_ffe5f4	; 0x95 I/O register data (copy of DDR)
		rts

; ----------------------------------------------

sub_12690:	mov	@yearL, r0l		; 0x54
		mov	@yearH, r0h		; 0x55
		jsr	sub_0c9f2

		mov	#0, r0h
		mov	#0, r0l
		rts

; ----------------------------------------------

		mov	#0x80, r0h
		mov	#0, r0l
		mov	#byte_ffe114, er1

loc_126b0:	mov	r0l, @er1
		adds	#1, er1
		dec	r0h
		bne	loc_126b0

		rts

; ----------------------------------------------

; check for debug build id and timestamp

sub_126ba:	mov	#0, r0l
		mov	r0l, @byte_ffff47
		mov	#byte0xF8, er1		; build timestamp #1
		mov	@byte0xF8+2, r1h	; build timestamp #1
		mov	@byte0xF8+3, r1l	; build timestamp #1
		mov	#byte_ffe11c, er2
		mov	#8, r0h

loc_126dc:	mov	@er1+, r0l
		beq	loc_126dc

		mov	r0l, @er2
		adds	#1, er2
		dec	r0h
		bne	loc_126dc

		mov	@byte0xF0+4, r0h	; build id (e.g. .ascii "1YHT28WW")
		cmp	#'?, r0h
		bne	rts_126fa

		bset	#6, @byte_ffff47	; # of build id starts with "?"

rts_126fa:	rts

; ----------------------------------------------

sub_126fc:	cmp	#0, r0h
		bne	loc_1271c

		mov	@byte_ffe114, r2h
		beq	loc_1271c

		mov	#byte_ffe114, er0
		bsr	cmpBuildId

		bcs	loc_1271a

		bclr	#7, @byte_ffff47

loc_1271a:	bra	rts_12762

loc_1271c:	btst	#7, @byte_ffff47
		bne	rts_12762

		cmp	#0x10, r0h
		bhs	rts_12762

		cmp	#1, r0h
		bne	loc_12742

		mov	#byte_ffe11c, er0
		bsr	cmpBuildId

		bcs	loc_12740

		bset	#6, @byte_ffff47	; 6 build id contains "?"

loc_12740:	bra	rts_12762

loc_12742:	shll	r0h
		shll	r0h
		shll	r0h
		mov	#byte_ffe114, er2
		add	r0h, r2l
		addx	#0, r2h
		bcc	loc_12756

		inc	#1, e2

loc_12756:	mov	#8, r0h

loc_12758:	mov	@er1+, r0l
		mov	r0l, @er2
		adds	#1, er2
		dec	r0h
		bne	loc_12758

rts_12762:	rts

; ----------------------------------------------

cmpBuildId:	mov	#8, r2h

loc_12766:	mov	@er0+, r2l
		mov	@er1+, r3h
		cmp	r2l, r3h
		bne	loc_1277a

		cmp	#0, r3h
		bne	loc_12776

		mov	#0, r2h
		bra	loc_1277a

loc_12776:	dec	r2h
		bne	loc_12766

loc_1277a:	cmp	#0, r2h
		bne	loc_12782

		clr	c
		bra	rts_12784

loc_12782:	set	c

rts_12784:	rts

; ----------------------------------------------

sub_12786:	btst	#7, @byte_ffff47
		bne	rts_127b8

		cmp	#1, r0h
		bls	rts_127b8

		cmp	#0x10, r0h
		bhs	rts_127b8

		shll	r0h
		shll	r0h
		shll	r0h
		mov	#byte_ffe114, er2
		add	r0h, r2l
		addx	#0, r2h
		bcc	loc_127ac

		inc	#1, e2

loc_127ac:	mov	#8, r0h

loc_127ae:	mov	@er2+, r0l
		mov	r0l, @er1
		adds	#1, er1
		dec	r0h
		bne	loc_127ae

rts_127b8:	rts

; ----------------------------------------------

sub_127ba:	mov	@byte_ffe114, r0h
		beq	rts_127ca

		bset	#7, @byte_ffff47

rts_127ca:	rts

; ----------------------------------------------

sub_127cc:	mov	#byte_ffe18c, er1
		zero	r0

loc_127d4:	mov	@er1, r2h
		beq	loc_127dc

		set	c
		bra	loc_127de

loc_127dc:	clr	c

loc_127de:	rotxl	r0
		cmp	#byte_ffe114, er1
		beq	loc_127f0

		sub	#8, er1
		bra	loc_127d4

loc_127f0:	mov	r0h, r2h
		mov	r0l, r0h
		mov	r2h, r0l
		rts

; ----------------------------------------------

sub_127f8:	bild	#6, @byte_ffff47	; 6 build id contains "?"
		bor	#5, @byte_ffff47
		rts

; ----------------------------------------------

sub_1280a:	bset	#5, @byte_ffff47
		rts

; ----------------------------------------------

sub_12814:	bclr	#4, @byte_ffff47
		bset	#3, @byte_ffff47
		rts

; ----------------------------------------------

sub_12826:	bild	#4, @byte_ffff47
		bor	#5, @byte_ffff47
		rts

; ----------------------------------------------

sub_12838:	bclr	#4, @byte_ffff47
		rts

; ----------------------------------------------

sub_12842:	btst	#3, @byte_ffff47
		bne	rts_1287c

		cmp	#4, r0h
		bne	loc_1286c

		mov	#off_1287e, er2

loc_12856:	mov	@er1+, r3h
		mov	@er2+, r3l
		cmp	r3h, r3l
		bne	loc_1286c

		dec	r0h
		bne	loc_12856

		bset	#4, @byte_ffff47
		bra	rts_1287c

loc_1286c:	bclr	#4, @byte_ffff47
		bset	#3, @byte_ffff47

rts_1287c:	rts


off_1287e:	.byte 0x84, 0x65, 0x60, 0x47

; ----------------------------------------------

sub_12882:	mov	#0, r0h
		mov	r0h, @byte_ffe67f
		mov	r0h, @byte_ffe680
		rts

; ----------------------------------------------

sub_12892:	push	er0
		jsr	sub_0459e

		pop	er1
		mov	r1l, r0l
		btst	#1, r0l
		bne	loc_128ba

		push	er0
		jsr	sub_0539e

		pop	er0
		bcc	loc_128ba

		mov	#1, r0l
		jsr	sub_02a5e

		bra	loc_128bc

loc_128ba:	mov	#0, r0l

loc_128bc:	mov	r0l, r3h
		cmp	#0, r0h
		beq	loc_1293e

		cmp	#0x80, r0h
		bhs	loc_1293e

		cmp	#0x2a, r0h
		beq	loc_1293e

		cmp	#0x36, r0h
		beq	loc_1293e

		cmp	#0x1d, r0h
		beq	loc_1293e

		cmp	#0x38, r0h
		beq	loc_1293e

		push	er0
		push	er3
		mov	@byte_ffe67f, r0l
		jsr	sub_1298e

		mov	#0x10, r1h
		mov	#long_ffe681, er2
		bsr	sub_12942

		mov	r0l, @byte_ffe67f
		mov	r0h, r1h
		pop	er3
		pop	er0
		push	er1
		mov	@byte_ffe680, r0l
		jsr	sub_1299a

		mov	#0x10, r1h
		mov	#long_ffe681, er2
		bsr	sub_12942

		mov	r0l, @byte_ffe680
		pop	er1
		cmp	#0, r0h
		beq	loc_1292c

		cmp	#0, r1h
		bne	loc_12930

loc_1292c:	mov	#0, r0h
		bra	loc_1293a

loc_12930:	cmp	#1, r0h
		bne	loc_12938

		cmp	#1, r1h
		beq	loc_1293a

loc_12938:	mov	#-1, r0h

loc_1293a:	clr	c
		bra	rts_12940

loc_1293e:	set	c

rts_12940:	rts

; ----------------------------------------------

sub_12942:	add	r0l, r2l
		addx	#0, r2h
		bcc	loc_1294a

		inc	#1, e2

loc_1294a:	cmp	#0x1c, r0h
		bne	loc_1296c

		cmp	#-1, r0l
		beq	loc_12962

		cmp	#0, r0l
		beq	loc_12962

		cmp	r1h, r0l
		beq	loc_12966

		mov	@er2, r1l
		beq	loc_12966

		cmp	#0x1c, r1l
		beq	loc_12966

loc_12962:	mov	#1, r0h
		bra	loc_12968

loc_12966:	mov	#0, r0h

loc_12968:	mov	#0, r0l
		bra	rts_1298c

loc_1296c:	cmp	#-1, r0l
		beq	loc_1298a

		cmp	r1h, r0l
		bhs	loc_12988

		mov	@er2, r1l
		beq	loc_12988

		cmp	r1l, r0h
		beq	loc_12984

		cmp	#0, r3h
		beq	loc_12988

		cmp	r3h, r1l
		bne	loc_12988

loc_12984:	inc	r0l
		bra	loc_1298a

loc_12988:	mov	#-1, r0l

loc_1298a:	mov	#-1, r0h

rts_1298c:	rts

; ----------------------------------------------

sub_1298e:	stm	er0-er2, @-sp
		mov	#long_ffe124, er0
		bra	loc_129a4

sub_1299a:	stm	er0-er2, @-sp
		mov	#long_ffe12c, er0

loc_129a4:	mov	#long_ffe681, er2
		bsr	sub_129c0

		add	#0x28, er0
		mov	#long_ffe689, er2
		bsr	sub_129c0

		ldm	@sp+, er0-er2
		rts

; ----------------------------------------------

sub_129c0:	mov	#0, r1h

loc_129c2:	mov	@er0, r1l
		mov	r1l, @er2
		add	#1, er0
		add	#1, er2
		inc	r1h
		cmp	#8, r1h
		blo	loc_129c2

		rts

; ----------------------------------------------

.if !type1R
		cmp	#0x0f, r0l
		bhi	loc_12a2c

		cmp	#1, r0h
		bhi	loc_12a2c

		push	er1
		push	er2
		mov	#long_ffe124, er2
		mov	#0, er1
		cmp	#0, r0h
		beq	loc_12a00

		mov	#8, er1

loc_12a00:	add	er1, er2
		mov	#0, er1
		cmp	#7, r0l
		bls	loc_12a12

		mov	#0x30, er1

loc_12a12:	add	er1, er2
		mov	r0l, r1l
		and	#7, r1l
		extu	r1
		extu	er1
		add	er1, er2
		mov	@er2, r0h
		pop	er2
		pop	er1
		clr	c
		bra	rts_12a2e

loc_12a2c:	set	c

rts_12a2e:	rts
.endif

; ----------------------------------------------

sub_12a30:
.if level >= 0x01040000 && type1Y
		mov	#0, r0l
		mov	r0l, @byte_ffe7ed
.endif

sub_12a38:	bsr	sub_137f8:16

.if type1R
		b ild	p64dr			; Pin P64/FTIC/-KIN4/CIN4/CLAMPO (Port 6 Data Register)
		bst	#4,@byte_ffff48:8
.if level >= 0x01030000
		mov	#0, r0l
		mov	r0l, @byte_ffe7ed
.endif
.else
		bsr	sub_138b2:16

.if level >= 0x01030000 && (level < 0x01040000 || !type1Y)
		mov	#0, r0l
		mov	r0l, @byte_ffe7ed
.endif
.endif

sub_12a40:	mov	#0, r0h
		mov	#0x10 - 8 & type1R, r0l
		mov	#byte_ffe69c, er1

loc_12a4a:	mov	r0h, @(2,er1)
		add	#4, er1
		dec	r0l
		bne	loc_12a4a

		mov	r0h, @byte_ffe691
		mov	r0h, @temperState
		mov	r0h, @temperActive7x	; temperature sensor 0x78..0x7f enabled
.if !type1R
		mov	r0h, @temperActiveCx	; temperature sensor 0xc0..0xc7 enabled
.endif
		jsr	sub_10e16

		bset	#6, @byte_ffff48:8
		rts

; ----------------------------------------------

sub_12a7a:	bsr	sub_12a40

		mov	#0, r0h
		mov	r0h, @temperState
		rts

; ----------------------------------------------

.if level >= 0x01030000
		.c = 0
.else
		.c = 4
.endif

task46:		mov	@temperState, r0h
		cmp	#11-.c, r0h
		blo	loc_12a9a

		btst	#7, @byte_ffff48
		beq	loc_12aa6

loc_12a9a:	mov	#off_12ade, er1
		jsr	switch_er1_r0h

		bra	rts_12adc

loc_12aa6:
.if level >= 0x01030000
.if type1R
		btst	#3, @byte_ffff48:8
.else
		btst	#1, @byte_ffff48:8
.endif
		beq	loc_12ad4

.if type1R
		bclr	#3, @byte_ffff48:8
		btst	#2, @byte_ffff48:8
.else
		bclr	#1, @byte_ffff48:8
		btst	#0, @byte_ffff48:8
.endif
		beq	loc_12abe

		bset	#7, @byte_ffff48

loc_12abe:	mov	@byte_ffe5eb, r0h	; 0x8c
		mov	r0h, @byte_ffe7ed
		mov	#4, r0h
		mov	r0h, @temperState
		bra	loc_12a9a

loc_12ad4:
.endif
		mov	#task46o, r0h
		jsr	schedFrontTask

		clr	c

rts_12adc:	rts

; ----------------------------------------------

off_12ade:	case  0     sub_12b14 sub_12b40 sub_12b54 sub_12b78
.if level >= 0x01030000
		case  4     sub_12b92 sub_12c2e sub_12c8a sub_12d04
.endif
		case  8-.c  sub_12d68 sub_12d7e sub_12e72 sub_12b60
		case 12-.c  sub_12b78 sub_13416 sub_13486 sub_12ee2
		case 16-.c  sub_12b4e sub_12fc0 sub_13108 sub_136ca
		case 20-.c  sub_132fa sub_13342 sub_12b66 sub_12b78
		case 24-.c  sub_13358 sub_12b4e sub_133c8

; ----------------------------------------------

sub_12b14:
.if type1R
		mov	#0, r0h
.else
		mov	#0, r0
.endif
		mov	r0h, @temperIdx
		mov	r0h, @byte_ffe6dc
		mov	r0h, @byte_ffedb4
.if !type1R
		mov	r0h, @byte_ffedb5
.endif
		bclr	#7, @byte_ffe594	; 0x35
		bsr	incTstate:16

		set	c
		rts

; ----------------------------------------------

sub_12b40:	b tst	pb3pin			; Pin PB3/-WUE3/-CS4 (Port B Input Data Register)
		beq	loc_12b4a

		bsr	incTstate:16

loc_12b4a:	set	c
		rts

; ----------------------------------------------

sub_12b4e:	mov	#4000, r1
		bra	loc_12b6a

sub_12b54:	mov	#1000, r1
		bra	loc_12b6a

.if !type1R
		mov	#251, r1
		bra	loc_12b6a
.endif

sub_12b60:	mov	#126 + 125 & type1R, r1
		bra	loc_12b6a

sub_12b66:	mov	#62 + 64 & type1R, r1
loc_12b6a:	mov	#task46o, r0h
		jsr	schedBackTaskDelayed

		bsr	incTstate:16

		set	c
		rts

; ----------------------------------------------

sub_12b78:	mov	#task46o, r0h
		jsr	checkSchedTask

		bcc	loc_12b88

		bsr	incTstate:16

		set	c
		bra	rts_12b90

loc_12b88:	mov	#task46o, r0h
		jsr	schedFrontTask

		clr	c

rts_12b90:	rts

; ----------------------------------------------

.if level >= 0x01030000
sub_12b92:	mov	#0, r0h
		bsr	sub_12f7e:16

		mov	@(2,er0), r2l
		mov	@(0,er0), r3l
		mov	#6, r3h
		mov	#0x15, r4h
		mov	#0x6e, r0h
		mov	@byte_ffe7ed, r4l
		bpl	loc_12bb6

		neg	r4l
		shlr	r4l
		sub	r4l, r0h
		bra	loc_12bba

loc_12bb6:	shlr	r4l
		add	r4l, r0h

loc_12bba:	mov	r0h, @byte_ffe69a
		mov	r0h, @byte_ffe7ee
		mov	#byte_ffedb8, er6
		btst	#7, @er6		; i2c00o
		bne	loc_12c1a

		mov	r3h, @(i2c03o:16,er6)
		mov	r3l, @(i2c05o:16,er6)
		mov	r4h, @(i2c06o:16,er6)
		mov	#byte_ffe69a, er5
		mov	er5, @(i2c08o:16,er6)
		mov	r2l, @(i2c02o:16,er6)
		mov	#loc_12c26, er5
		mov	er5, @(i2c12o:16,er6)
		mov	#50, r5h
		mov	r5h, @(i2c20o:16,er6)
		mov	#4, r5h
		mov	r5h, @(i2c00o:16,er6)
		mov	#0, r5h
		mov	r5h, @(i2c01o:16,er6)
		mov	er6, er0
		mov	#0, r1h
		mov	r1h, @(i2c04o:16,er0)
		jsr	enqueueI2Ccmd

		bra	loc_12c1e

loc_12c1a:	mov	#0x1a, r0h
		set	c

loc_12c1e:	bsr	incTstate:16

		set	c
		rts


loc_12c26:	mov	#task46o, r0h
		jsr	schedBackTask

		rts

; ----------------------------------------------

sub_12c2e:	btst	#6, @byte_ffedb8
		beq	loc_12c86

		mov	@byte_ffedbc, r0h
		cmp	#0, r0h
		bne	loc_12c50

		mov	#0, r0h
		mov	r0h, @byte_ffe69a
		bsr	incTstate:16

		bra	loc_12c86

loc_12c50:	mov	@byte_ffe6dc, r0h
		inc	r0h
		cmp	#7, r0h
		bls	loc_12c78

		bset	#0, @byte_ffedb4
.if !type1R
		mov	#0, r1l
		mov	#3, r0l
		mov	#byte_ffe1c2, er2
		jsr	sub_1350e
.endif

		bsr	incTstate:16

		bra	loc_12c86

loc_12c78:	mov	r0h, @byte_ffe6dc
		mov	#4, r0h
		mov	r0h, @temperState

loc_12c86:	set	c
		rts

; ----------------------------------------------

sub_12c8a:	mov	#0, r0h
		bsr	sub_12f7e:16

		mov	@(2,er0), r2l
		mov	@(0,er0), r3l
		mov	#7, r3h
		mov	#0x0a, r4h
		mov	#byte_ffedb8, er6
		btst	#7, @er6		; i2c00o
		bne	loc_12cf0

		mov	r3h, @(i2c03o:16,er6)
		mov	r3l, @(i2c05o:16,er6)
		mov	r4h, @(i2c06o:16,er6)
		mov	#byte_ffe69a, er5
		mov	er5, @(i2c08o:16,er6)
		mov	r2l, @(i2c02o:16,er6)
		mov	#loc_12cfc, er5
		mov	er5, @(i2c12o:16,er6)
		mov	#50, r5h
		mov	r5h, @(i2c20o:16,er6)
		mov	#4, r5h
		mov	r5h, @(i2c00o:16,er6)
		mov	#0, r5h
		mov	r5h, @(i2c01o:16,er6)
		mov	er6, er0
		mov	#0, r1h
		mov	r1h, @(i2c04o:16,er0)
		jsr	enqueueI2Ccmd

		bra	loc_12cf4

loc_12cf0:	mov	#0x1a, r0h
		set	c

loc_12cf4:	bsr	incTstate:16

		set	c
		rts


loc_12cfc:	mov	#task46o, r0h
		jsr	schedBackTask

		rts

; ----------------------------------------------

sub_12d04:	btst	#6, @byte_ffedb8
		beq	loc_12d64

		mov	@byte_ffedbc, r0h
		cmp	#0, r0h
		bne	loc_12d2e

		mov	@byte_ffe69a, r0h
		mov	@byte_ffe7ee, r0l
		cmp	r0l, r0h
		bne	loc_12d2e

		bsr	incTstate:16

		bra	loc_12d64

loc_12d2e:	mov	@byte_ffe6dc, r0h
		inc	r0h
		cmp	#7, r0h
		bls	loc_12d56

		bset	#0, @byte_ffedb4
.if !type1R
		mov	#0, r1l
		mov	#3, r0l
		mov	#byte_ffe1c2, er2
		jsr	sub_1350e
.endif

		bsr	incTstate:16

		bra	loc_12d64

loc_12d56:	mov	r0h, @byte_ffe6dc
		mov	#4, r0h
		mov	r0h, @temperState

loc_12d64:	set	c
		rts
.endif

; ----------------------------------------------

sub_12d68:	mov	#0, r0h
		mov	r0h, @temperIdx
		mov	r0h, @byte_ffe6dc
		bsr	incTstate:16

		set	c
		rts

; ----------------------------------------------

sub_12d7e:	mov	@temperIdx, r0h
		cmp	#15 - 8 & type1R, r0h
		bhi	loc_12e46:16

.if !type1R
		cmp	#7, r0h
		bhi	loc_12d98
.endif

		btst	r0h, @byte_ffedb4
.if !type1R
		bra	loc_12da0

loc_12d98:	btst	r0h, @byte_ffedb5
.endif

loc_12da0:	bne	loc_12e2e:16

		bsr	sub_12f7e:16

		mov	@(2,er0), r2l
		cmp	#2, r2l
		blo	loc_12db6

		mov	#9, r3h
.if level >= 0x01000062
		mov	#1, r4l
.endif
		bra	loc_12dba

loc_12db6:	mov	#7, r3h
.if level >= 0x01000062
		mov	#0, r4l
.endif

loc_12dba:	mov	@(0,er0), r3l
.if level >= 0x01000062
		beq	loc_12e2e:16
.else
		beq	loc_12e2e
.endif

		cmp	#0x80, r3l
		beq	loc_12e2e

.if type1R
		mov	@temperIdx, r4h
		cmp	#3, r4h
		bne	loc_12dc6

		mov	#3, r4h
		btst	#4, @byte_ffff48:8
		bne	loc_12dca

		mov	#0, r4h
		bra	loc_12dca
.endif

loc_12dc6:	mov	@(1,er0), r4h

loc_12dca:	mov	#byte_ffedb8, er6
		btst	#7, @er6		; i2c00o
		bne	loc_12e24

		mov	r3h, @(i2c03o:16,er6)
		mov	r3l, @(i2c05o:16,er6)
		mov	r4h, @(i2c06o:16,er6)
		mov	#byte_ffe69a, er5
		mov	er5, @(i2c08o:16,er6)
		mov	r2l, @(i2c02o:16,er6)
		mov	#loc_12e6a, er5
		mov	er5, @(i2c12o:16,er6)
		mov	#50, r5h
		mov	r5h, @(i2c20o:16,er6)
		mov	#4, r5h
		mov	r5h, @(i2c00o:16,er6)
.if level >= 0x01000062
		mov	#0, r5h
		cmp	#0, r4l
		beq	loc_12e12

		bset	#7, r5h

loc_12e12:	mov	r5h, @(i2c01o:16,er6)
.endif
		mov	er6, er0
		mov	#0, r1h
		mov	r1h, @(i2c04o:16,er0)
		jsr	enqueueI2Ccmd

		bra	loc_12e28

loc_12e24:	mov	#0x1a, r0h
		set	c

loc_12e28:	bsr	incTstate:16

		bra	loc_12e66

loc_12e2e:	mov	@temperIdx, r0h
		inc	r0h
		mov	r0h, @temperIdx
		mov	#0, r0h
		mov	r0h, @byte_ffe6dc
		bra	loc_12e66

loc_12e46:	mov	#11-.c, r0h
		mov	r0h, @temperState
		mov	#0, r0h
.if type1R && level >= 0x01030000
		mov	#7, r0h
.endif
		mov	r0h, @temperIdx
.if type1R
		mov	@byte_ffedb4, r0h
		beq	loc_12e66
		btst	#4, @byte_ffff48:8
		bne	1f

		xor	#4, r0h
.else
		mov	@byte_ffedb4, r0
.endif
		beq	loc_12e66

1:		bset	#7, @byte_ffe594	; 0x35

loc_12e66:	set	c
		rts


loc_12e6a:	mov	#task46o, r0h
		jsr	schedBackTask

		rts

; ----------------------------------------------

sub_12e72:	btst	#6, @byte_ffedb8
		beq	loc_12ede

		mov	@byte_ffedbc, r0h
		cmp	#0, r0h
		beq	loc_12ec0

		mov	@byte_ffe6dc, r0h
		inc	r0h
		cmp	#7, r0h
		bls	loc_12ed0

		mov	@temperIdx, r0h
.if !type1R
		cmp	#7, r0h
		bhi	loc_12ea6
.endif

		bset	r0h, @byte_ffedb4
.if !type1R
		bra	loc_12eae

loc_12ea6:	bset	r0h, @byte_ffedb5

loc_12eae:	mov	@temperIdx, r1l
		mov	#3, r0l
		mov	#byte_ffe1c2, er2
		jsr	sub_1350e
.endif

loc_12ec0:	mov	@temperIdx, r0h
		inc	r0h
		mov	r0h, @temperIdx
		mov	#0, r0h

loc_12ed0:	mov	r0h, @byte_ffe6dc
		mov	#9-.c, r0h
		mov	r0h, @temperState

loc_12ede:	set	c
		rts

; ----------------------------------------------

sub_12ee2:	mov	@temperIdx, r0h
		bsr	sub_12f7e:16

		mov	@(2,er0), r2l
		cmp	#2, r2l
		blo	loc_12efa

		mov	#9, r3h
.if level >= 0x01000062
		mov	#1, r4l
.endif
		bra	loc_12efe

loc_12efa:	mov	#7, r3h
.if level >= 0x01000062
		mov	#0, r4l
.endif

loc_12efe:	mov	@(0,er0), r3l
		beq	loc_12f6a

		mov	@(1,er0), r4h
		mov	#byte_ffedb8, er6
		btst	#7, @er6		; i2c00o
		bne	loc_12f62

		mov	r3h, @(i2c03o:16,er6)
		mov	r3l, @(i2c05o:16,er6)
		mov	r4h, @(i2c06o:16,er6)
		mov	#byte_ffe69a, er5
		mov	er5, @(i2c08o:16,er6)
		mov	r2l, @(i2c02o:16,er6)
		mov	#loc_12f76, er5
		mov	er5, @(i2c12o:16,er6)
		mov	#50, r5h
		mov	r5h, @(i2c20o:16,er6)
		mov	#4, r5h
		mov	r5h, @(i2c00o:16,er6)
.if level >= 0x01000062
		mov	#0, r5h
		cmp	#0, r4l
		beq	loc_12f50

		bset	#7, r5h

loc_12f50:	mov	r5h, @(i2c01o:16,er6)
.endif
		mov	er6, er0
		mov	#0, r1h
		mov	r1h, @(i2c04o:16,er0)
		jsr	enqueueI2Ccmd

		bra	loc_12f66

loc_12f62:	mov	#0x1a, r0h
		set	c

loc_12f66:	bsr	incTstate

		bra	loc_12f72

loc_12f6a:	mov	#19-.c, r0h
		mov	r0h, @temperState

loc_12f72:	set	c
		rts


loc_12f76:	mov	#task46o, r0h
		jsr	schedBackTask

		rts

; ----------------------------------------------

sub_12f7e:	push	er0
		mov	#0x11, r1l
		mulxu	r0h, r1
		mov	#0, e1
		mov	#long_ffe6dd, er0
		add	er0, er1
		pop	er0
		push	er1
		mov	#4, r1l
		mulxu	r0h, r1
		mov	#0, e1
		mov	#byte_ffe69c, er0
		add	er0, er1
		pop	er0
		rts

; ----------------------------------------------

incTstate:	mov	@temperState, r0h
		inc	r0h
		mov	r0h, @temperState
		rts

; ----------------------------------------------

sub_12fc0:	mov	#task46o, r0h
		jsr	checkSchedTask

		bcs	loc_13082:16

		btst	#6, @byte_ffedb8
		beq	loc_130c4:16

		mov	@byte_ffedbc, r0h
		cmp	#0, r0h
		bne	loc_13082:16

		mov	@temperIdx, r0h
.if !type1R
		cmp	#7, r0h
		bhi	loc_12ff6
.endif

		bclr	r0h, @byte_ffedb4
.if !type1R
		bra	loc_12ffe

loc_12ff6:	bclr	r0h, @byte_ffedb5
.endif

loc_12ffe:	set	c
		bsr	sub_130ce:16

.if type1R
		bsr	sub_12f7e
.else
		bsr	sub_12f7e:16
.endif

		mov	@byte_ffe69a, r3h
		mov	@(2,er0), r2h
		cmp	#2, r2h
		blo	loc_1301e

		mov	@byte_ffe69b, r3l
		bra	loc_13020

loc_1301e:	mov	#0, r3l

loc_13020:	mov	@temperIdx, r2h
		beq	loc_13036

		mov	r3h, @(0,er1)
		mov	r3l, @(1,er1)
.if type1R
		bsr	incTstate
.else
		bsr	incTstate:16
.endif

		bra	loc_13080

loc_13036:
.if level >= 0x01030000
		mov	@byte_ffe7ed, r4l
		bpl	loc_13046

		neg	r4l
		shlr	r4l
		add	r4l, r3h
		bra	loc_1304a

loc_13046:	shlr	r4l
		sub	r4l, r3h

loc_1304a:
.endif
		push	er1
		push	er3
		mov	r3, r1
		jsr	sub_135c8

		pop	er3
		pop	er2
		bcs	loc_13070

		mov	r1h, @(0,er2)
		mov	r1l, @(1,er2)
		bsr	incTstate:16

		bra	loc_13080

loc_13070:	mov	r3h, @(0,er2)
		mov	r3l, @(1,er2)
		mov	#19-.c, r0h
		mov	r0h, @temperState

loc_13080:	bra	loc_130c2

loc_13082:	mov	@temperIdx, r0h
.if !type1R
		cmp	#7, r0h
		bhi	loc_13096
.endif

		bset	r0h, @byte_ffedb4
.if !type1R
		bra	loc_1309e

loc_13096:	bset	r0h, @byte_ffedb5

loc_1309e:	mov	@temperIdx, r1l
		mov	#3, r0l
		mov	#byte_ffe1c2, er2
		jsr	sub_1350e

		mov	@temperIdx, r0h
.endif
		clr	c
		bsr	sub_130ce

		mov	#19-.c, r0h
		mov	r0h, @temperState

loc_130c2:	bra	loc_130ca

loc_130c4:	mov	#task46o, r0h
		jsr	schedFrontTask

loc_130ca:	set	c
		rts

; ----------------------------------------------

sub_130ce:
.if type1R
		bcc	loc_130f4

		btst	r0h, @temperActive7x:8	; temperature sensor 0x78..0x7f enabled
		bne	loc_130f2

		bset	r0h, @temperActive7x:8	; temperature sensor 0x78..0x7f enabled
		bset	#6, @byte_ffff48:8

loc_130f2:	bra	loc_13102

loc_130f4:	btst	r0h, @temperActive7x:8	; temperature sensor 0x78..0x7f enabled
		beq	loc_13102

		bclr	r0h, @temperActive7x:8	; temperature sensor 0x78..0x7f enabled
		bset	#6, @byte_ffff48:8

loc_13102:	rts

.else
		stm	er0-er1, @-sp
		mov	#temperActive7x, er1	; temperature sensor 0x78..0x7f enabled
		btst	#3, r0h
		beq	loc_130e2

		mov	#temperActiveCx, er1	; temperature sensor 0xc0..0xc7 enabled

loc_130e2:	bcc	loc_130f4

		btst	r0h, @er1
		bne	loc_130f2

		bset	r0h, @er1
		bset	#6, @byte_ffff48:8

loc_130f2:	bra	loc_13102

loc_130f4:	btst	r0h, @er1
		beq	loc_13102

		bclr	r0h, @er1
		bset	#6, @byte_ffff48:8

loc_13102:	ldm	@sp+, er0-er1
		rts
.endif

; ----------------------------------------------

sub_13108:	mov	@temperIdx, r0h
		jsr	sub_12f7e

		stm	er0-er1, @-sp
		jsr	sub_134e6

		ldm	@sp+, er0-er1
		stm	er0-er1, @-sp
.if type1R
		bsr	sub_1328c
.else
		bsr	sub_1328c:16
.endif

		bcc	loc_1312c

		bset	#6, @byte_ffff48:8

loc_1312c:	ldm	@sp+, er0-er1
.if type1R
		bsr	sub_13268
.else
		bsr	sub_13268:16

		bsr	sub_1313e
.endif

		jsr	incTstate

		set	c
		rts

; ----------------------------------------------

.if !type1R
sub_1313e:	jsr	sub_14fae

		beq	rts_1320c:16

		mov	@temperIdx, r0h
		mov	#long_ffe212, er3
		mov	#byte_ffe1d9, er4
		mov	#byte_ffe1e5, er5
		mov	#1, r6l

loc_13160:	mov	@er3, r0l
		cmp	r0l, r0h
		bne	loc_131ee:16

		mov	@(0,er1), r2l
		btst	#2, @byte_ffff48
		beq	loc_1319c

		mov	@(9,er3), r2h
		bmi	loc_1319c

		cmp	r2h, r2l
		bls	loc_1319c

		mov	r2l, @(9,er3)
		push	er2
		mov	r6l, @(2,er5)
		mov	r2l, @(3,er5)
		mov	#0x21, r0l
		mov	er5, er2
		jsr	sub_14e8a

		pop	er2

loc_1319c:	btst	#3, @byte_ffff48
		beq	rts_1320c

		mov	@(1,er3), r2h
		cmp	r2h, r2l
		bhs	loc_131d2

		mov	@(6,er3), r2h
		cmp	r2h, r2l
		blo	loc_131d2

		mov	@(3,er3), r2h
		cmp	r2h, r2l
		blo	loc_131c2

		mov	#3, r0l
		bra	loc_131d4

loc_131c2:	mov	@(4,er3), r2h
		cmp	r2h, r2l
		blo	loc_131ce

		mov	#2, r0l
		bra	loc_131d4

loc_131ce:	mov	#1, r0l
		bra	loc_131d4

loc_131d2:	mov	#0, r0l

loc_131d4:	mov	r6l, @(2,er4)
		mov	@(3,er4), r0h
		mov	r0l, @(3,er4)
		cmp	r0h, r0l
		beq	rts_1320c

		mov	#0x20, r0l
		mov	er4, er2
		jsr	sub_14e8a

		bra	rts_1320c

loc_131ee:	inc	r6l
		add	#4, er5
		add	#4, er4
		add	#0x0a, er3
		cmp	#byte_ffe230, er3
		blo	loc_13160:16

rts_1320c:	rts

; ----------------------------------------------

sub_1320e:	mov	#byte_ffe1d9, er3

loc_13214:	mov	#3, r0l
		mov	r0l, @(0,er3)
		mov	#0x20, r0l
		mov	r0l, @(1,er3)
		mov	#0, r0l
		mov	r0l, @(3,er3)
		add	#4, er3
		cmp	#byte_ffe1e5, er3
		blo	loc_13214

		bset	#3, @byte_ffff48
		rts

; ----------------------------------------------

sub_1323e:	mov	#byte_ffe1e5, er3

loc_13244:	mov	#3, r0l
		mov	r0l, @(0,er3)
		mov	#0x21, r0l
		mov	r0l, @(1,er3)
		add	#4, er3
		cmp	#byte_ffe1f1, er3
		blo	loc_13244

		bset	#2, @byte_ffff48
		rts
.endif

; ----------------------------------------------

sub_13268:	mov	@(0,er1), r2h
		mov	@(3,er1), r2l
		sub	r2h, r2l
		bpl	loc_13276

		neg	r2l

loc_13276:	mov	@(4,er0), r3h
		beq	loc_13288

		cmp	r3h, r2l
		blo	loc_13288

		mov	r2h, @(3,er1)
		set	c
		bra	rts_1328a

loc_13288:	clr	c

rts_1328a:	rts

; ----------------------------------------------

sub_1328c:	add	#5, er0
		mov	@(0,er1), r2h
		mov	@(2,er1), r2l
		mov	#0, r3h

loc_1329c:	btst	r3h, r2l
		bne	loc_132ae

		mov	@er0, r3l
		cmp	#0x80, r3l
		beq	loc_132ac

		cmp	r3l, r2h
		ble	loc_132ac

		bset	r3h, r2l

loc_132ac:	bra	loc_132bc

loc_132ae:	mov	@(1,er0), r3l
		cmp	#0x80, r3l
		beq	loc_132bc

		cmp	r3l, r2h
		bge	loc_132bc

		bclr	r3h, r2l

loc_132bc:	adds	#2, er0
		inc	r3h
		cmp	#6, r3h
		blo	loc_1329c

		mov	@(2,er1), r3h
		cmp	r3h, r2l
		beq	loc_132f2

		mov	r2l, @(2,er1)
.if !type1R
		btst	#2, r2l
		beq	loc_132ee

		stm	er0-er3, @-sp
		mov	@temperIdx, r1l
		mov	#2, r0l
		mov	#byte_ffe1ab, er2
		jsr	sub_1350e

		ldm	@sp+, er0-er3
.endif

loc_132ee:	set	c
		bra	loc_132f4

loc_132f2:	clr	c

loc_132f4:	mov	r2l, r0h
		mov	r3h, r0l
		rts

; ----------------------------------------------

sub_132fa:	mov	@temperIdx, r0h
.if type1R && level >= 0x01030000
		dec	r0h
.else
		inc	r0h
.endif
		and	#0x0f - 8 & type1R, r0h
		mov	r0h, @temperIdx
.if type1R && level >= 0x01030000
		cmp	#7, r0h
.endif
		bne	loc_1333a

		bset	#5, @byte_ffff48:8
		btst	#6, @byte_ffff48:8
		beq	loc_1333a

		bclr	#6, @byte_ffff48:8
		bsr	sub_1366c:16

		push	er0
		or	r0l, r0h
		bsr	sub_1368e:16

		pop	er0
		and	#7, r0h
		and	#7, r0l
		shll	#2, r0h
		shll	#2, r0h
		or	r0l, r0h
		jsr	sub_10e16

loc_1333a:	bsr	incTstate:16

		set	c
		rts

; ----------------------------------------------

sub_13342:	btst	#5, @byte_ffff48:8
		beq	loc_1334c

		mov	#22-.c, r0h
		bra	loc_1334e

loc_1334c:	mov	#11-.c, r0h

loc_1334e:	mov	r0h, @temperState
		set	c
		rts

; ----------------------------------------------

sub_13358:	mov	#7, r3h
		mov	#0x9a, r3l
		mov	#4, r4h
		mov	#1, r2l
		mov	#byte_ffedb8, er6
		btst	#7, @er6		; i2c00o
		bne	loc_133b4

		mov	r3h, @(i2c03o:16,er6)
		mov	r3l, @(i2c05o:16,er6)
		mov	r4h, @(i2c06o:16,er6)
		mov	#byte_ffe69a, er5
		mov	er5, @(i2c08o:16,er6)
		mov	r2l, @(i2c02o:16,er6)
		mov	#loc_133c0, er5
		mov	er5, @(i2c12o:16,er6)
		mov	#50, r5h
		mov	r5h, @(i2c20o:16,er6)
		mov	#4, r5h
		mov	r5h, @(i2c00o:16,er6)
.if level >= 0x01000062
		mov	#0, r5h
		mov	r5h, @(i2c01o:16,er6)
.endif
		mov	er6, er0
		mov	#0, r1h
		mov	r1h, @(i2c04o:16,er0)
		jsr	enqueueI2Ccmd

		bra	loc_133b8

loc_133b4:	mov	#0x1a, r0h
		set	c

loc_133b8:	bsr	incTstate:16

		set	c
		rts


loc_133c0:	mov	#task46o, r0h
		jsr	schedBackTask

		rts

; ----------------------------------------------

sub_133c8:	mov	#task46o, r0h
		jsr	checkSchedTask

		bcs	loc_133ee

		btst	#6, @byte_ffedb8
		beq	loc_1340c

		mov	@byte_ffedbc, r0h
		cmp	#0, r0h
		bne	loc_133ee

		set	c
		mov	@byte_ffe69a, r0l
		bra	loc_133f0

loc_133ee:	clr	c

loc_133f0:	jsr	sub_0e1d6

		mov	#63 + 63 & type1R, r1
		mov	#task46o, r0h
		jsr	schedBackTaskDelayed

		mov	#12-.c, r0h
		mov	r0h, @temperState
		bclr	#5, @byte_ffff48:8
		bra	loc_13412

loc_1340c:	mov	#task46o, r0h
		jsr	schedFrontTask

loc_13412:	set	c
		rts

; ----------------------------------------------

sub_13416:	mov	@temperIdx, r0l
		mov	#0, r0h
		cmp	#4, r0l
		beq	loc_13428

		inc	r0h
		cmp	#5, r0l
		bne	loc_13468

loc_13428:	bsr	sub_13470

		cmp	#-1, r0h
		beq	loc_13452

		mov	#0, r0l
		push	er0
		mov	@temperIdx, r0h
		set	c
		bsr	sub_130ce:16

		jsr	sub_12f7e

		pop	er2
		mov	r2h, @(0,er1)
		mov	r2l, @(1,er1)
		bra	loc_1345e

loc_13452:	mov	@temperIdx, r0h
		clr	c
		bsr	sub_130ce:16

loc_1345e:	mov	#18-.c, r0h
		mov	r0h, @temperState
		bra	loc_1346c

loc_13468:	jsr	incTstate

loc_1346c:	set	c
		rts

; ----------------------------------------------

sub_13470:	jsr	sub_0db7a

		bcc	loc_1347a

		mov	#-1, r0h
		bra	rts_13484

loc_1347a:	jsr	sub_0dbc2

		mov	r0, r1
		mov	r1l, r0h
		mov	r1h, r0l

rts_13484:	rts

; ----------------------------------------------

sub_13486:	mov	@temperIdx, r0l
		mov	#0, r0h
		cmp	#6, r0l
		beq	loc_13498

		inc	r0h
		cmp	#7, r0l
		bne	loc_134de

loc_13498:	mov	#0xd4, r4h
		mov	#1, r3h
		jsr	sub_0c764

		cmp	#-1, r0h
		beq	loc_134c8

		mov	#0, r0l
		push	er0
		mov	@temperIdx, r0h
		set	c
		bsr	sub_130ce:16

		jsr	sub_12f7e

		pop	er2
		mov	r2h, @(0,er1)
		mov	r2l, @(1,er1)
		bra	loc_134d4

loc_134c8:	mov	@temperIdx, r0h
		clr	c
		bsr	sub_130ce:16

loc_134d4:	mov	#18-.c, r0h
		mov	r0h, @temperState
		bra	loc_134e2

loc_134de:	jsr	incTstate

loc_134e2:	set	c
		rts

; ----------------------------------------------

sub_134e6:	mov	@(0,er1), r2h
		mov	@(3,er0), r2l
		cmp	#0x80, r2l
		beq	rts_1350c

		cmp	r2l, r2h
		ble	rts_1350c

.if !type1R
		mov	@temperIdx, r1l
		mov	#1, r0l
		mov	#byte_ffe194, er2
		jsr	sub_1350e
.endif

		jsr	sub_017a0

rts_1350c:	rts

; ----------------------------------------------

.if !type1R
sub_1350e:	mov	#0x16, r0h
		mov	r0h, @(0,er2)
		mov	r0l, @(1,er2)
		mov	r1l, @(9,er2)
		stm	er0-er2, @-sp
		mov	er2, er6
		jsr	sub_06cc6

		mov	r0l, @(2,er6)
		mov	r0h, @(3,er6)
		mov	r1h, @(4,er6)		; task21o/task22o/task23o
		mov	r1l, @(5,er6)
		mov	r2h, @(6,er6)
		mov	r2l, @(7,er6)
		mov	r3h, @(8,er6)
		zero	er2
		add	#0x0a, er6

loc_1354c:	mov	@(byte_ffe1fe,er2), r1l
		btst	#7, r1l
		beq	loc_1355c

		bsr	sub_13582

		bra	loc_13566

loc_1355c:	mov	r1l, r0h
		shlr	#2, r0h
		shlr	r0h
		bsr	sub_13706:16

loc_13566:	mov	r0l, @er6
		inc	#1, er6
		mov	r1l, @er6
		inc	#1, er6
		add	#2, r2l
		cmp	#0x0c, r2l
		blo	loc_1354c

		bsr	sub_1358e

		mov	r5l, @er6
		ldm	@sp+, er0-er2
		jsr	sub_14e8a

		rts

; ----------------------------------------------

sub_13582:	mov	#0, r0h
		jsr	getFanSpeed

		mov	#0x64, r1h
		divxu	r1h, r0
		rts

; ----------------------------------------------

sub_1358e:	mov	#0, r5l
		jsr	sub_074d0

		bist	#7, r5l
		jsr	sub_074bc

		bst	#6, r5l
		mov	#0, r0h
		jsr	sub_0c3d2

		bcs	loc_135ae

		mov	#0, r0h
		jsr	sub_0b42e

		or	r0h, r5l
		bra	loc_135b0

loc_135ae:	or	#3, r5l

loc_135b0:	mov	#1, r0h
		jsr	sub_0c3d2

		bcs	loc_135c4

		mov	#1, r0h
		jsr	sub_0b42e

		shll	#2, r0h
		or	r0h, r5l
		bra	rts_135c6

loc_135c4:	or	#0x0c, r5l

rts_135c6:	rts
.endif

; ----------------------------------------------

sub_135c8:	mov	@byte_ffe691, r2h
		mov	r2h, r2l
		bclr	#7, r2h
		mov	r2h, r3l
		mov	#0, r3h
		mov	#0, e3
		mov	r1h, @(long_ffe692,er3)
		inc	r2h
		cmp	#6, r2h
		blo	loc_135ec

		mov	#0x80, r2h
		bra	loc_135f0

loc_135ec:	bld	#7, r2l
		bst	#7, r2h

loc_135f0:	mov	r2h, @byte_ffe691
		btst	#7, r2h
		beq	loc_1365c

		mov	#6, r2h
		mov	#0x80, r2l
		mov	#0x7f, r3l
		mov	#long_ffe692, er4
		mov	#0, r5

loc_1360a:	mov	@er4, r6l
		bmi	loc_13612

		mov	#0, r6h
		bra	loc_13614

loc_13612:	mov	#-1, r6h

loc_13614:	cmp	r6l, r2l
		bge	loc_1361a

		mov	r6l, r2l

loc_1361a:	cmp	r6l, r3l
		ble	loc_13620

		mov	r6l, r3l

loc_13620:	add	r6, r5
		adds	#1, er4
		dec	r2h
		bne	loc_1360a

		btst	#7, r2l
		beq	loc_13630

		mov	#-1, r2h
		bra	loc_13632

loc_13630:	mov	#0, r2h

loc_13632:	btst	#7, r3l
		beq	loc_1363a

		mov	#-1, r3h
		bra	loc_1363c

loc_1363a:	mov	#0, r3h

loc_1363c:	sub	r2, r5
		sub	r3, r5
		mov	#4, r2h
		btst	#7, r5h
		beq	loc_13652

		not	r5h
		not	r5l
		inc	#1, r5
		divxu	r2h, r5
		neg	r5l
		bra	loc_13654

loc_13652:	divxu	r2h, r5

loc_13654:	mov	r5l, r1h
		mov	#0, r1l
		clr	c
		bra	rts_1365e

loc_1365c:	set	c

rts_1365e:	rts

; ----------------------------------------------

		mov	#0, r0h
		mov	r0h, @temperState
		set	c
		rts

; ----------------------------------------------

sub_1366c:	mov	#byte_ffe6a0, er1
		mov	#0, r0h
		mov	#0x0f - 8 & type1R, r0l

loc_13676:	mov	@(2,er1), r2h
		or	r2h, r0h
		add	#4, er1
		dec	r0l
		bne	loc_13676

		mov	@byte_ffe69e, r0l
		rts

; ----------------------------------------------

sub_1368e:	mov	r0h, r0l
		shll	r0l
		mov	#7, r0h

loc_13694:	shll	r0l
		bcs	loc_1369c

		dec	r0h
		bne	loc_13694

loc_1369c:	add	#0xfd, r0h
		bpl	loc_136a4

		mov	#0, r0h
		bra	loc_136a4

loc_136a4:
.if type1R
		mov	@byte_ffedb4, r0l
		beq	loc_11ddc
		btst	#4, @byte_ffff48:8
		bne	loc_136b6
		xor	#4, r0l
		bne	loc_136b6

loc_11ddc:	btst	#0, @temperActive7x:8	; temperature sensor 0x78..0x7f enabled
.else
		mov	@byte_ffedb4, e0
		bne	loc_136b6

		btst	#0, @temperActive7x	; temperature sensor 0x78..0x7f enabled
.endif
		bne	loc_136c0

loc_136b6:	bset	#7, @byte_ffe594	; 0x35
		mov	#3, r0h

loc_136c0:	mov	r0h, r0l
		mov	#0, r0h
		jsr	sub_1419e

		rts

; ----------------------------------------------

sub_136ca:	mov	@temperIdx, r0h
.if !type1R
		cmp	#7, r0h
		bhi	loc_136de
.endif

		btst	r0h, @temperActive7x	; temperature sensor 0x78..0x7f enabled
.if !type1R
		bra	loc_136e6

loc_136de:	btst	r0h, @temperActiveCx	; temperature sensor 0xc0..0xc7 enabled

loc_136e6:
.endif
		beq	inactive

		jsr	sub_12f7e

		mov	@(0,er1), r0l
		bra	loc_136f4

inactive:	mov	#0x80, r0l

loc_136f4:	mov	@temperIdx, r0h
		jsr	storeTemperat		; r0h: 0..f r0l: temperature

		jsr	incTstate

		set	c
		rts

; ----------------------------------------------

.if !type1R
sub_13706:	push	er1
		cmp	#7, r0h
		bhi	loc_13718

		btst	r0h, @temperActive7x	; temperature sensor 0x78..0x7f enabled
		bra	loc_13720

loc_13718:	btst	r0h, @temperActiveCx	; temperature sensor 0xc0..0xc7 enabled

loc_13720:	beq	loc_1372c

		jsr	sub_12f7e

		mov	@(0,er1), r0l
		bra	loc_1372e

loc_1372c:	mov	#0x80, r0l

loc_1372e:	pop	er1
		rts
.endif

; ----------------------------------------------

sub_13734:
.if level >= 0x01030000
.if type1R
		btst	#3, @byte_ffff48:8
.else
		btst	#1, @byte_ffff48:8
.endif
		beq	loc_13740

.if type1R
		bset	#2, @byte_ffff48:8
.else
		bset	#0, @byte_ffff48:8
.endif
		bra	loc_13748

loc_13740:	bset	#7, @byte_ffff48

loc_13748:
.endif
		mov	#task46o, r0h
		jsr	schedBackTask

.ifeq type1R && level >= 0x01030000
		bset	#7, @byte_ffff48
.endif
		rts

; ----------------------------------------------

sub_13758:	btst	#7, @byte_ffff48
		beq	rts_1377e

		bsr	sub_12a40:16

		mov	#11-.c, r0h
		mov	r0h, @temperState
		mov	#0, r0h
		mov	#3, r0l
		jsr	sub_1419e

		bclr	#7, @byte_ffff48

rts_1377e:	rts

; ----------------------------------------------

sub_13780:	cmp	#0x0f - 8 & type1R, r0h
		bhi	loc_137a6

.if !type1R
		cmp	#7, r0h
		bhi	loc_13792
.endif

		btst	r0h, @temperActive7x	; temperature sensor 0x78..0x7f enabled
.if !type1R
		bra	loc_1379a

loc_13792:	btst	r0h, @temperActiveCx	; temperature sensor 0xc0..0xc7 enabled
.endif

loc_1379a:	beq	loc_137a6

		jsr	sub_12f7e

		mov	@(0,er1), r0h
		bra	rts_137a8

loc_137a6:	mov	#0x80, r0h

rts_137a8:	rts

; ----------------------------------------------

sub_137aa:	cmp	#0x0f - 8 & type1R, r0h
		bhi	loc_137c8

		mov	#0x11, r1l
		mulxu	r0h, r1
		mov	#0, e1
		mov	#long_ffe6dd, er0
		add	er1, er0
		add	#3, er0
		clr	c
		bra	rts_137ca

loc_137c8:	set	c

rts_137ca:	rts

; ----------------------------------------------

sub_137cc:	mov	@er0, r1l
		cmp	#0x10 - 8 & type1R, r1l
		bhs	rts_137f6:16

		cmp	#0x12, r1h
		bne	rts_137f6:16

		mov	er0, er2
		mov	@er2+, r0h
		jsr	sub_12f7e

		mov	#0x11, r3l

loc_137e4:	mov	@er2, r3h
		mov	r3h, @er0
		inc	#1, er0
		inc	#1, er2
		dec	r3l
		bne	loc_137e4

		mov	#0, r0h
		mov	r0h, @(2,er1)

rts_137f6:	rts

; ----------------------------------------------

sub_137f8:	mov	#16 - 8 & type1R, r1l
.if type1R
		mov	@off_00418, er0
.else

loc_137fa:	push	er1
		mov	#off_00418, er0
		mov	@tabSelector, r1l
		shll	#2, r1l
		extu	r1
		extu	er1
		add	er1, er0
		mov	@er0, er0
		mov	@byte_ffe7f0, r1l
		shll	#2, r1l
		extu	r1
		extu	er1
		add	er1, er0
		mov	@er0, er0
		inc	#2, er0
		pop	er1
.endif
		mov	#long_ffe6dd, er2

loc_13834:	mov	#0x11, r3l
		mov	@er0, er4

loc_1383a:	mov	@er4, r3h
		mov	r3h, @er2
		inc	#1, er4
		inc	#1, er2
		dec	r3l
		bne	loc_1383a

		add	#4, er0
		dec	r1l
		bne	loc_13834

		rts


.if !type1R
sub_13852:	mov	#0x0b, r1l
		bra	loc_137fa

; ----------------------------------------------

setFanSpeedProfile:				; 0xc8 0x, 1x, 2x, F0..F1
		mov	r0l, r0h
		and	#0xf0, r0h
		cmp	#0xf0, r0h
		beq	loc_1386c

		shlr	#2, r0h
		shlr	#2, r0h
		bsr	sub_13890

		and	#0x0f, r0l		; [0-E]0..[0-E]F
		jsr	setFanSpeedProfileB

		bra	rts_1387c

loc_1386c:	and	#0x0f, r0l		; F0..F1
		push	er0
		bsr	setTabSel

		pop	er0
		jsr	setFanSpeedProfileA

rts_1387c:	rts

; ----------------------------------------------

setTabSel:	cmp	#num_00418, r0l
		blo	loc_13884

		mov	#num_00418 - 1, r0l

loc_13884:	mov	r0l, @tabSelector
.if level >= 0x01040000
		bsr	sub_12a38:16
.else
		bsr	sub_12a30:16
.endif
		rts

; ----------------------------------------------

sub_13890:	push	er0
		cmp	#3, r0h
		blo	lessThan3

		mov	#2, r0h

lessThan3:	mov	@byte_ffe7f0, r0l
		mov	r0h, @byte_ffe7f0
		bsr	sub_13852

		bsr	sub_12a40:16

		pop	er0
		rts

; ----------------------------------------------

sub_138b2:	mov	#long_ffe7f1, er4
		mov	#long_ffe801, er5
		mov	#3, r2l
		mov	r2l, @er4
		inc	#1, er4
		cmp	#8, r2l
		bls	loc_138ca

		mov	#8, r2l

loc_138ca:	mov	#off_00418, er0
		mov	@tabSelector, r1l
		shll	#2, r1l
		extu	r1
		extu	er1
		add	er1, er0
		mov	@er0, er0

loc_138e2:	mov	@er0, er1
		mov	@er1+, r3
		mov	r3l, @er4
		inc	#1, er4
		mov	@er1, er1
		mov	@(9,er1), r3l
		mov	r3l, @er5
		inc	#1, er5
		mov	@(8,er1), r3l
		mov	r3l, @er5
		inc	#1, er5
		inc	#2, er0
		inc	#2, er0
		dec	r2l
		bne	loc_138e2

		rts
.endif

; ----------------------------------------------

.if level >= 0x01030000
sto8C:		mov	r0l, @byte_ffe5eb	; 0x8c
.if type1R
		bset	#3, @byte_ffff48:8
.else
		bset	#1, @byte_ffff48:8
.endif
		mov	#task46o, r0h
		jsr	schedBackTask

		rts
.endif

; ----------------------------------------------

initFan:	jsr	sub_14152

.if !type1R
		bsr	sub_14462:16
.endif

		mov	#0, r0h
		mov	r0h, @byte_ffe81c
		mov	r0h, @byte_ffe81b
		mov	r0h, @byte_ffe81a
		mov	#250, r0h
		mov	r0h, @byte_ffe81d
		mov	#fanState00i, r0h
		mov	r0h, @fanState
		mov	#3, r0h
		mov	r0h, @speedLevel
		mov	r0h, @manLevel
		mov	r0h, @autoLevel
		mov	#0, r0h
		mov	@fanLevelTabPtr, er1
		mov	@er1, r0l		; # of levels
		dec	r0l			; set to max
		jsr	setFanCtrl

		mov	#0, r0h
		jsr	sub_10e7e

.if type1R
		jsr	incFanState
.endif

		jsr	sub_10ecc

		bra	loc_139bc


sub_1397a:	bild	#6, @byte_ffff49	; fan off
		bcc	loc_139bc

		mov	#fanState00i, r0h
		mov	r0h, @fanState
		mov	#0, r0h
		mov	r0h, @speedLevel
		mov	r0h, @manLevel
		mov	r0h, @autoLevel
		mov	#0, r0h
		jsr	getFanCtrl

		and	#0b11000000, r0h	; keep auto-mode & free-run bits; level = 0
		mov	r0h, r0l
		mov	#0, r0h
		push	er0
		jsr	setFanCtrl

		pop	er0
		jsr	confSpeedMode

loc_139bc:	b clr	mstpcrh.mstp12		; TMR_0, TMR_1 (Module Stop Control Register H)
		mov	#0, r0h
		mov	r0h, @byte_ffe812
		mov	#-1, r0
		mov	r0, @fanSpeed
		setOutL 4 4			; Pin P44/TMO1/HIRQ1/HSYNCO

		b clr	p44dr			; Pin P44/TMO1/HIRQ1/HSYNCO (Port 4 Data Register)
		mov	#250, r0h
		mov	r0h, @tcora_1:8		; TMR_1 Time Constant Register A
		mov	#0b00001001, r0h	; clear on tcora_1 match; internal phi/2 clock
		mov	r0h, @tcr_1:8		; TMR_1 Timer Control Register
		b set	stcr.icks1		; Internal Clock Source Select 1 (Serial Timer Control Register)
		b set	tier.iciae		; Input Capture Interrupt A Enable (FRT Timer Interrupt Enable Register)
.if !type1R
		b set	tier.ovie		; Timer Overflow Interrupt Enable (FRT Timer Interrupt Enable Register)
.endif
		rts

; ----------------------------------------------

		.byte 0, 1, 1, 2, 2, 2, 3, 3	; (manual fan levels)

; ----------------------------------------------

fanTask:	mov	@fanState, r0h
		mov	#fanStateTab, er1
		jsr	switch_er1_r0h

		bcs	fanTask

		clr	c
		rts


fanStateTab:
	fanState00i =  0
	fanState01i =  1
		case  0 fanState00 fanState01 fanState02 fanState03
.if type1R
		case  4 fanState37
.endif
		case  , fanState04
.if type1R
	fanState12i =  7
		case  6 fanState39 fanState47
.else
	fanState06i =  6
	fanState12i = 12
		case  5 fanState05 fanState06 fanState07 fanState08
		case  9 fanState09 fanState10 fanState11 fanState12
		case 13 fanState13 fanState14 fanState02 fanState16
		case 17 fanState17 fanState02
.endif
	fanState19i = .case
		case  , fanState19
	fanState20i = .case
		case  , fanState11 fanState21 fanState22
.if type1R && level < 0x01030070
		case  , fanState48
.else
		case  , fanState23
.endif
		case  , fanState02 fanState04 fanState06
		case  , fanState07 fanState08 fanState11
.if type1R
		case 19 fanState09
.else
		case 30 fanState30
.endif
		case  , fanState31 fanState32
	fanState33i = .case
		case  , fanState33 fanState34 fanState35
	fanState36i = .case
		case  , fanState36 fanState37 fanState04
		case  , fanState39 fanState40
.if type1R
	fanState41i =  0
.else
	fanState41i = 41
	fanState46i = 46
		case 41 fanState41 fanState13 fanState14
		case 44 fanState39 fanState16 fanState46
.endif

; ----------------------------------------------

fanState00:	clr	c
		bsr	sub_13a8a

		mov	#0, r0h
		mov	r0h, @byte_ffe81e
.if !type1R
		clr	c
.endif
		rts

; ----------------------------------------------

fanState04:	set	c

sub_13a8a:	mov	#0, r0h			; Pin TMO1/P44 change disabled
		mov	r0h, @tcsr_1:8		; TMR_1 Timer Control/Status Register
		b st	p44dr			; Pin P44/TMO1/HIRQ1/HSYNCO (Port 4 Data Register)
		bsr	incFanState:16

.if type1R
		clr	c
.else
		set	c
.endif
		rts

; ----------------------------------------------

fanState11:	mov	#0b00001001, r0h	; Pin TMO1/P44 set to 0 if tcora_1 match, 1 if tcorb_1 match
		mov	r0h, @tcsr_1:8		; TMR_1 Timer Control/Status Register
		bsr	incFanState

		set	c
		rts

; ----------------------------------------------

fanState02:	mov	@byte_ffe812, r0l
		mov	@speedLevel, r0h
		cmp	r0h, r0l
		beq	loc_13aec

		mov	r0h, @byte_ffe812
		bne	loc_13ac0

		mov	#fanState41i, r0l
		bra	loc_13ad4

loc_13ac0:	cmp	#0, r0l
		bne	loc_13ad2

.if !type1R
		mov	#-1, r0
		mov	r0, @fanSpeed
.endif
		mov	#4, r0l
		bra	loc_13ad4

loc_13ad2:	mov	#fanState12i, r0l

loc_13ad4:	mov	r0l, @fanState
		mov	#0, r0h
		mov	r0h, @byte_ffe816
.if type1R
		mov	#-1, r0
		mov	r0, @fanSpeed
.else
		mov	r0h, @byte_ffe817
.endif
		set	c
		bra	rts_13b02

loc_13aec:	mov	#fanTasko, r0h
		jsr	checkSchedTask

		bcc	loc_13afa

		bsr	incFanState

		set	c
		bra	rts_13b02

loc_13afa:	mov	#fanTasko, r0h
		jsr	schedFrontTask

		clr	c

rts_13b02:	rts


; ----------------------------------------------

		mov	#2000, r1

schedFanTask:	mov	#fanTasko, r0h
		jsr	schedBackTaskDelayed

		bsr	incFanState

		set	c
		rts

; ----------------------------------------------

incFanState:	mov	@fanState, r0h
		inc	r0h
		mov	r0h, @fanState
		rts

; ----------------------------------------------

		mov	#3, r1
		bra	schedFanTask

fanState37:	mov	#500, r1
		bra	schedFanTask

.if !type1R
		mov	#50, r1
		bra	schedFanTask

fanState17:	mov	#100, r1
		bra	schedFanTask
.endif

fanState48:	mov	#5000, r1
		bra	schedFanTask

		mov	#10000, r1
		bra	schedFanTask

fanState01:	mov	#30000, r1
		bra	schedFanTask

fanState21:	mov	#1000, r1
		bra	schedFanTask

.if !type1R
fanState14:	mov	@dynFanDelay, r1
		bra	schedFanTask
.endif

; ----------------------------------------------

fanState39:	mov	#fanTasko, r0h
		jsr	checkSchedTask

		bcc	loc_13b6a

		bsr	incFanState

		set	c
		bra	rts_13b72

loc_13b6a:	mov	#fanTasko, r0h
		jsr	schedFrontTask

		clr	c

rts_13b72:	rts

; ----------------------------------------------

fanState23:
.if !type1R
.ifndef FIX
		mov	@long_ffeddc, er0
.else
		mov	@long_ffeddc, er1
.endif
		inc	#2, er1
		inc	#2, er1
		mov	@er1, r1
.endif
.ifeq type1R && level < 0x01030070
		mov	@word_ffedd4, r0
.if type1R
		cmp	#3600, r0
.else
		cmp	r1, r0
.endif
		bhs	fanState48

		bra	fanState01
.endif

; ----------------------------------------------

fanState47:	bsr	sub_13ba4

		jsr	sub_141fc

		mov	#0, r0h
		mov	r0h, @byte_ffe818
		jsr	incFanState

		set	c
		rts

; ----------------------------------------------

sub_13ba4:	mov	@byte_ffe812, r0h
		bsr	sub_13c02

		mov	r0, @word_ffedd4
		mov	@byte_ffe812, r0h
		bsr	sub_13c1c

		mov	er0, er6
		mov	@er0, r0h
		bne	rts_13bca

		mov	@word_ffedd4, r0
.if !type1R
		bsr	sub_13bcc

		mov	r0h, @er6

rts_13bca:	rts
.endif

; ----------------------------------------------

sub_13bcc:	sub	#300, r0
		mov	#word_144a2, er1
		mov	@er1, r2
		cmp	r2, r0
		blo	loc_13be2

		mov	#word_144d4, er1

loc_13be2:	mov	#-1, r3

loc_13be6:	mov	@er1, r2
		cmp	r2, r0
		bhs	loc_13bfc

		mov	@(4,er1), r2
		cmp	r2, r3
		beq	loc_13bfc

		add	#4, er1
		bra	loc_13be6

loc_13bfc:	mov	@(2,er1), r0
.if type1R
		mov	r0h, @er6

rts_13bca:
.endif
		rts

; ----------------------------------------------

sub_13c02:	mov	@long_ffeddc, er1	; level pointer
		inc	#2, er1
		dec	r0h
		shll	r0h
		add	r0h, r1l
		addx	#0, r1h
		bcc	loc_13c18

		inc	#1, e1

loc_13c18:	mov	@er1, r0
		rts

; ----------------------------------------------

sub_13c1c:	dec	r0h
		mov	r0h, r0l
		exts	r0
		exts	er0
		add	#byte_ffe81a, er0
		rts

; ----------------------------------------------

fanState06:	mov	#0, r0h
		mov	r0h, @byte_ffe816
.if !type1R
		mov	r0h, @byte_ffe817
.endif
		bset	#5, @byte_ffff49
		mov	#fanTasko, r0h
		mov	#100, r1
		jsr	schedBackTaskDelayed

loc_13c4c:	jsr	incFanState

		set	c
		rts


fanState08:	bclr	#5, @byte_ffff49
		bra	loc_13c4c

; ----------------------------------------------

fanState09:
.if !type1R
		mov	#-1, r4h
		bra	loc_13c64

fanState30:	mov	#0, r4h

loc_13c64:
.endif
		mov	@byte_ffe816, r0h
		mov	#long_ffedd0, er1
		cmp	#1, r0h
		bls	loc_13cc0

		mov	@er1+, r2
		mov	@er1+, r3
		cmp	r2, r3
		blo	loc_13c8e

.if !type1R
		mov	@byte_ffe817, r0h
		beq	loc_13c8a

		mov	#-1, r3
		bra	loc_13c8c
.endif

loc_13c8a:	sub	r2, r3

loc_13c8c:	bra	loc_13ca6

loc_13c8e:
.if !type1R
		mov	@byte_ffe817, r0h
		cmp	#2, r0h
		blo	loc_13c9e

		mov	#-1, r3
		bra	loc_13ca6
.endif

loc_13c9e:	sub	r3, r2
		mov	#-1, r3
		sub	r2, r3

loc_13ca6:	mov	r3, r0
.if !type1R
		cmp	#-1, r0
		beq	loc_13cc0

		cmp	#0, r4h
		bne	loc_13cb6
.endif

		jsr	sub_1422c

loc_13cb6:	jsr	sub_13e38

		mov	r0, @fanSpeed

loc_13cc0:	jsr	incFanState

		set	c
		rts

; ----------------------------------------------

fanState32:	mov	#fanState20i, r0h
		mov	r0h, @fanState
		set	c
		rts

; ----------------------------------------------

fanState07:	mov	#fanTasko, r0h
		jsr	checkSchedTask

		bcs	loc_13ce6

		mov	@byte_ffe816, r0h
		cmp	#2, r0h
		blo	loc_13cee

loc_13ce6:	jsr	incFanState

		set	c
		bra	rts_13cf6

loc_13cee:	mov	#fanTasko, r0h
		jsr	schedFrontTask

		clr	c

rts_13cf6:	rts

; ----------------------------------------------

fanState22:	btst	#3, @byte_ffff49
		bne	loc_13d86:16

		mov	@fanSpeed, r0
		mov	#-1, r1
		cmp	r0, r1
		beq	loc_13d82

		jsr	sub_13e48

		bcc	loc_13d2a

		jsr	loc_142b6

		bcc	loc_13d26

		jsr	sub_13eb6

		mov	r0h, r2l
		bra	loc_13d28

loc_13d26:	mov	#0, r2l

loc_13d28:	bra	loc_13d38

loc_13d2a:	push	er0
		jsr	incFanState

		pop	er0
		mov	r0h, r2l

loc_13d38:	mov	r2l, r2h
		beq	loc_13d80

		mov	@byte_ffe819, r4h
		add	r2l, r4h
		bxor	#7, r2l
		bcc	loc_13d56

		btst	#7, r2l
		bne	loc_13d50

		mov	#250, r4h
		bra	loc_13d56

loc_13d50:	mov	@byte_ffe819, r4h

loc_13d56:	mov	@byte_ffe818, r0h
		cmp	r0h, r4h
		bhs	loc_13d62

		mov	r0h, r4h

loc_13d62:	mov	r4h, r0h
		jsr	sub_141fc

		push	er4
		mov	@byte_ffe812, r0h
		jsr	sub_13c1c

		pop	er4
		mov	r4h, @er0
		jsr	sub_14218

loc_13d80:	bra	loc_13d86

loc_13d82:	jsr	incFanState

loc_13d86:	jsr	incFanState

		set	c
		rts

; ----------------------------------------------

fanState03:	mov	@byte_ffe81e, r0h
		cmp	#0x0a, r0h
		bls	loc_13dac

		mov	#fanState33i, r0h
		mov	r0h, @fanState
		mov	#-1, r0
		mov	r0, @fanSpeed
		bra	loc_13dc6

loc_13dac:	mov	#0, r0
		mov	r0, @fanSpeed
		mov	#0, r0h
		mov	r0h, @byte_ffe81e
		mov	#fanState01i, r0h
		mov	r0h, @fanState

loc_13dc6:	clr	c
		rts

; ----------------------------------------------

fanState33:	bset	#6, @byte_ffff49	; 6 fan off
		mov	#0, r0h
		jsr	sub_10ea6

		mov	#0x3d, r0h
		jsr	sub_10cc0

		jsr	incFanState

		clr	c
		rts

; ----------------------------------------------

fanState34:	jsr	fanState00

		jsr	incFanState

fanState35:	clr	c
		rts

; ----------------------------------------------

fanState31:	mov	@fanSpeed, r0
		mov	#0x12c, r1
		cmp	r1, r0
		blo	loc_13e0a

		mov	@byte_ffe816, r0h
		cmp	#2, r0h
		bhs	loc_13e28

loc_13e0a:	mov	@byte_ffe819, r0h
		cmp	#250, r0h
		bhs	loc_13e1e

		mov	#fanState36i, r0h
		mov	r0h, @fanState
		bra	loc_13e26

loc_13e1e:	mov	#fanState33i, r0h
		mov	r0h, @fanState

loc_13e26:	bra	loc_13e34

loc_13e28:	bset	#7, @byte_ffff49
		jsr	incFanState

loc_13e34:	set	c
		rts

; ----------------------------------------------

sub_13e38:	mov	#0x23c, r3
		mov	#0x3460, r2
		mov	r0, r1
		jsr	sub_0c49a

		rts

; ----------------------------------------------

sub_13e48:	jsr	sub_13eb6

		bcs	loc_13e5e

		mov	#0xc8, r2
		cmp	r2, r1
		bls	loc_13e5a

		clr	c
		bra	loc_13e5c

loc_13e5a:	set	c

loc_13e5c:	bra	rts_13e60

loc_13e5e:	set	c

rts_13e60:	rts

; ----------------------------------------------

fanState19:	jsr	sub_14218

		jsr	incFanState

		set	c
		rts

; ----------------------------------------------

fanState36:	btst	#7, @byte_ffff49
		beq	loc_13e9c

		mov	@byte_ffe818, r0h
		mov	@byte_ffe819, r0l
		cmp	r0l, r0h
		bhs	loc_13e8a

		mov	r0l, r0h

loc_13e8a:	add	#1, r0h
		bcs	loc_13e92

		cmp	#250, r0h
		bls	loc_13e94

loc_13e92:	mov	#250, r0h

loc_13e94:	mov	r0h, @byte_ffe818
		bra	loc_13e9e

loc_13e9c:	mov	#250, r0h

loc_13e9e:	jsr	sub_141fc

		jsr	incFanState

		set	c
		rts

; ----------------------------------------------

fanState40:	mov	#fanState19i, r0h
		mov	r0h, @fanState
		set	c
		rts

; ----------------------------------------------

sub_13eb6:	mov	@fanSpeed, r0
		mov	#-1, r1
		cmp	r0, r1
		beq	loc_13efc

		mov	@word_ffedd4, r1
		cmp	r1, r0
		blo	loc_13eda

		mov	r0, r2
		mov	r1, r3
		mov	#word_1453e, er5
		bra	loc_13ee4

loc_13eda:	mov	r0, r3
		mov	r1, r2
		mov	#word_14522, er5

loc_13ee4:	sub	r3, r2

loc_13ee6:	mov	@er5, r4
		cmp	r4, r2
		bhs	loc_13ef2

		adds	#2, er5
		adds	#2, er5
		bra	loc_13ee6

loc_13ef2:	mov	@(3,er5), r0h
		mov	r2, r1
		clr	c
		bra	rts_13efe

loc_13efc:	set	c

rts_13efe:	rts

; ----------------------------------------------

sub_13f00:	mov	#0, r0h			; Pin TMO1/P44 change disabled
		mov	r0h, @tcsr_1:8		; TMR_1 Timer Control/Status Register
		setInL	4 4			; Pin P44/TMO1/HIRQ1/HSYNCO

		rts

; ----------------------------------------------

; FRT Input Capture A

icia:		b clr	tier.iciae		; Input Capture Interrupt A Enable (FRT Timer Interrupt Enable Register)
		clr	i
		b clr	tcsr.icfa		; Input Capture Flag A (FRT Timer Control/Status Register)
		stm	er0-er1, @-sp
		push	er2
		btst	#5, @byte_ffff49
		beq	loc_13f64

		mov	@byte_ffe816, r0h
		cmp	#2, r0h
		bhs	loc_13f5e

		mov	r0h, r0l
		shll	r0l
		mov	#long_ffedd0, er1
		add	r0l, r1l
		addx	#0, r1h
		bcc	loc_13f50

		inc	#1, e1

loc_13f50:	inc	r0h
		mov	r0h, @byte_ffe816
		mov	@icral, r0		; FRT Input Capture Register A
		mov	r0, @er1

loc_13f5e:	mov	#fanTasko, r0h
		jsr	schedBackTask

loc_13f64:	mov	@byte_ffe81e, r0h
		bmi	loc_13f74

		inc	r0h
		mov	r0h, @byte_ffe81e

loc_13f74:	pop	er2
		ldm	@sp+, er0-er1
		set	i
		b set	tier.iciae		; Input Capture Interrupt A Enable (FRT Timer Interrupt Enable Register)
		rte

; ----------------------------------------------

.if !type1R
; FRT Overflow

fovi:		b clr	tier.ovie		; Timer Overflow Interrupt Enable (FRT Timer Interrupt Enable Register)
		clr	i
		b clr	tcsr.ovf		; Timer Overflow (FRT Timer Control/Status Register)
		push	er0
		btst	#5, @byte_ffff49
		beq	loc_13fb6

		mov	@byte_ffe816, r0h
		cmp	#1, r0h
		bne	loc_13fb6

		mov	@byte_ffe817, r0h
		inc	r0h
		bmi	loc_13fb6

		mov	r0h, @byte_ffe817

loc_13fb6:	pop	er0
		set	i
		b set	tier.ovie		; Timer Overflow Interrupt Enable (FRT Timer Interrupt Enable Register)
		rte
.endif

; ----------------------------------------------

confSpeedMode:	cmp	#0, r0h
		bne	rts_14024

		bclr	#4, @byte_ffff49	; automatic speed off
		btst	#6, r0l
		beq	speedCtrlOn

		bsr	getLevel:16

		inc	r0h
		mov	r0h, @manLevel
		jsr	setLevel

		bra	rts_14024

speedCtrlOn:	btst	#7, r0l
		beq	manualSpeed

		bset	#4, @byte_ffff49	; automatic speed on
		mov	#0, r0l
		mov	r0l, @manLevel
		jsr	setLevel

		bra	rts_14024

manualSpeed:	mov	@fanLevelTabPtr, er1
		mov	@er1+, r2h		; # of levels
		dec	r2h			; max value
		cmp	r2h, r0l
		bls	loc_14010

		mov	r2h, r0l		; limit to max value

loc_14010:	add	r0l, r1l
		addx	#0, r1h
		bcc	loc_14018

		inc	#1, e1

loc_14018:	mov	@er1, r0l
		mov	r0l, @manLevel
		jsr	setLevel

rts_14024:	rts

; ----------------------------------------------

getFanSpeed:	cmp	#0, r0h
		bne	invalidR0h

		mov	@byte_ffe812, r0l
		beq	fanIsOff

		btst	#6, @byte_ffff49	; fan off
		beq	loc_14042

fanIsOff:	mov	#0, r0
		bra	loc_14048

loc_14042:	mov	@fanSpeed, r0

loc_14048:	bra	rts_1404e

invalidR0h:	mov	#-1, r0

rts_1404e:	rts

; ----------------------------------------------

sub_14050:	push	er0
		mov	@fanLevelTabPtr, er1
		mov	@er1+, r2h		; # of levels

loc_1405e:	mov	@er1, r2l
		mov	r2l, @er0
		adds	#1, er0
		adds	#1, er1
		dec	r2h
		bne	loc_1405e

		push	er0
		bsr	getLevel:16

		mov	r0h, r2h
		pop	er0
		mov	r2h, @er0
		adds	#1, er0
		mov	@long_ffeddc, er1	; level pointer
		inc	#2, er1

loc_14086:	mov	@er1, r3
		mov	r3l, @er0
		mov	r3h, @(1,er0)
		adds	#2, er0
		adds	#2, er1
		dec	r2h
		bne	loc_14086

		pop	er1
		sub	er1, er0
		mov	r0l, r0h
		rts

; ----------------------------------------------

sub_140a0:	mov	@fanLevelTabPtr, er2
		zero	er3
		mov	@er2+, r3l		; # of levels
		cmp	r3l, r1h
		blo	rts_1414c:16

		add	er3, er0
		sub	r3l, r1h
		push	er0
		bsr	getLevel:16

		mov	r0h, r3h
		mov	r0h, r3l
		pop	er0
		shll	r3l
		inc	r3l
		cmp	r3l, r1h
		blo	rts_1414c

		mov	@er0+, r1l		; count
		cmp	r3h, r1l
		bne	rts_1414c

		mov	#600, r2
		mov	er0, er5

loc_140dc:	mov	@er5+, r4l		; data
		mov	@er5+, r4h
		cmp	r2, r4
		blo	loc_140e8

		dec	r1l
		bne	loc_140dc

loc_140e8:	bcs	rts_1414c

		push	er0
		bsr	sub_1414e

		pop	er0
		bcs	rts_1414c

		mov	@long_ffeddc, er1	; level pointer
		mov	@er1, r2h
		dec	r2h
		adds	#2, er1

loc_14104:	mov	@er0+, r3l
		mov	@er0+, r3h
		mov	r3, @er1
		adds	#2, er1
		dec	r2h
		bne	loc_14104

		mov	#0, r1h
		mov	r1h, @byte_ffe81a
		mov	r1h, @byte_ffe81b
		mov	r1h, @byte_ffe81c
		mov	@fanState, r0h
		cmp	#fanState00i, r0h
		bls	rts_1414c

		mov	#fanState00i, r0h
		mov	r0h, @fanState
		mov	#0, r0h
		mov	r0h, @byte_ffe812
		mov	#0, r0h
		jsr	getFanCtrl

		mov	r0h, r0l
		mov	#0, r0h
		jsr	confSpeedMode

rts_1414c:	rts

; ----------------------------------------------

sub_1414e:	clr	c
		rts

; ----------------------------------------------

sub_14152:	mov	#long_ffede0, er0
		mov	er0, @long_ffeddc	; level pointer
.if type1R
		mov	@off_00450, er1
.else
		mov	#off_00450, er1
		mov	@fanSpeedProfileA, r2l
		shll	#2, r2l
		extu	r2
		extu	er2
		add	er2, er1
		mov	@er1, er1
		mov	@fanSpeedProfileB, r2l
		shll	#2, r2l
		extu	r2
		extu	er2
		add	er2, er1
		mov	@er1, er1
.endif
		zero	r2l

loc_1418c:	mov	@er1, r2h
		mov	r2h, @er0
		inc	r2l
		cmp	#10, r2l
		bhs	rts_1419c

		inc	#1, er0
		inc	#1, er1
		bra	loc_1418c

rts_1419c:	rts

; ----------------------------------------------

sub_1419e:	bsr	getLevel

		cmp	r0h, r0l
		bls	loc_141a6

		mov	r0h, r0l

loc_141a6:	mov	r0l, @autoLevel

setLevel:	btst	#4, @byte_ffff49	; automatic speed
		beq	manSpeed

		mov	@autoLevel, r0h
.if type1R && level >= 0x01030000
		mov	@byte_ffe812, r0l
		cmp	r0l, r0h
		bls	0f

		bsr	sub_131cc

		cmp	r1l, r1h
		bhs	0f

		push	er0
		jsr	sub_13c1c

		mov	r1l, @er0
		pop	er0

0:
.endif
		bra	loc_141c4

manSpeed:	mov	@manLevel, r0h

loc_141c4:	mov	r0h, @speedLevel
		mov	#fanTasko, r0h
		jsr	schedBackTask

		rts

; ----------------------------------------------

getLevel:	push	er1
		mov	@long_ffeddc, er1	; level pointer
		mov	@er1, r0h
		dec	r0h
		pop	er1
		rts

; ----------------------------------------------

.if type1R && level >= 0x01030000
sub_131cc:	push	er0
		mov	r0, r1
		jsr	sub_13c1c

		mov	@er0, r1h
		mov	r1l, r0h
		jsr	sub_13c1c

		mov	@er0, r1l
		pop	er0
		rts
.endif

; ----------------------------------------------

		bset	#3, @byte_ffff49
		rts

; ----------------------------------------------

		bclr	#3, @byte_ffff49
		rts

; ----------------------------------------------

sub_141fc:	mov	r0h, @byte_ffe819
		cmp	#250, r0h
		bhs	loc_1420e

		mov	#250, r0l
		sub	r0h, r0l
		mov	r0l, @tcorb_1:8		; TMR_1 Time Constant Register B
		bra	rts_14216

loc_1420e:	b set	p44dr			; Pin P44/TMO1/HIRQ1/HSYNCO (Port 4 Data Register)
		mov	#0, r0h			; Pin TMO1/P44 change disabled
		mov	r0h, @tcsr_1:8		; TMR_1 Timer Control/Status Register

rts_14216:	rts

; ----------------------------------------------

sub_14218:	mov	#0, r0h
		mov	r0h, @byte_ffe833
		mov	#-1, r0
		mov	r0, @word_ffedfe
		rts

; ----------------------------------------------

sub_1422c:	mov	@byte_ffe833, r1h
		mov	r1h, r1l
		bclr	#7, r1l
		mov	#long_ffedf2, er2
		shll	r1l
		add	r1l, r2l
		addx	#0, r2h
		bcc	loc_14246

		inc	#1, e2

loc_14246:	mov	r0, @er2
		mov	r1h, r1l
		bclr	#7, r1l
		inc	r1l
		cmp	#6, r1l
		bne	loc_14256

		mov	#0x80, r1l
		bra	loc_1425a

loc_14256:	bld	#7, r1h
		bst	#7, r1l

loc_1425a:	mov	r1l, @byte_ffe833
		btst	#7, r1l
		beq	loc_14266

		mov	#6, r1l

loc_14266:	push	er1
		mov	#0, r2
		mov	r2, r3
		mov	#0, r4
		mov	#-1, r5
		mov	#0, r1h
		mov	#long_ffedf2, er6

loc_14280:	mov	@er6+, r0
		add	r0, r2
		addx	#0, r3l
		cmp	r4, r0
		bls	loc_1428c

		mov	r0, r4

loc_1428c:	cmp	r5, r0
		bhs	loc_14292

		mov	r0, r5

loc_14292:	dec	r1l
		bne	loc_14280

		pop	er1
		cmp	#4, r1l
		blo	loc_142aa

		sub	r4, r2
		subx	#0, r3l
		sub	r5, r2
		subx	#0, r3l
		dec	r1l
		dec	r1l

loc_142aa:	mov	#0, r1h
		jsr	sub_0c49a

		mov	r0, @word_ffedfe

loc_142b6:	mov	@word_ffedfe, r0
		mov	@byte_ffe833, r1h
		bld	#7, r1h
		bcc	rts_142c8

		mov	#6, r1h

rts_142c8:	rts

; ----------------------------------------------

.if !type1R
fanState10:	mov	@byte_ffe81e, r0h
		cmp	#4, r0h
		bls	loc_142f8

		mov	@fanSpeed, r0
		cmp	#-1, r0
		beq	loc_142f8

		cmp	#2500, r0
		blo	loc_142f8

		mov	#2500, r0
		jsr	sub_13bcc

		jsr	sub_141fc

		jsr	incFanState

		bra	loc_14316


loc_142f8:	mov	@word_ffedda, r0
		jsr	cmpTick

		bcc	loc_1430e

		mov	#fanState33i, r0h
		mov	r0h, @fanState
		bra	loc_14316


loc_1430e:	mov	#fanState06i, r0h
		mov	r0h, @fanState

loc_14316:	set	c
		rts

; ----------------------------------------------

fanState05:	mov	@tick, r0
		mov	#1000, r1
		add	r1, r0
		mov	r0, @word_ffedda
		jsr	incFanState

		rts

; ----------------------------------------------

fanState12:	jsr	sub_13ba4

		mov	r0h, @byte_ffe820
		jsr	incFanState

		set	c
		rts

; ----------------------------------------------

fanState16:	mov	@byte_ffe819, r0h
		mov	@byte_ffe820, r0l
		cmp	r0h, r0l
		bne	loc_1435a

		jsr	incFanState

		bra	loc_1437a


loc_1435a:	mov	@byte_ffe819, r0h
		mov	@byte_ffe81f, r0l
		add	r0l, r0h
		jsr	sub_141fc

		mov	@fanState, r0h
		add	#-2, r0h
		mov	r0h, @fanState

loc_1437a:	set	c
		rts

; ----------------------------------------------

fanState46:	mov	#fanState00i, r0h
		mov	r0h, @fanState
		set	c
		rts

; ----------------------------------------------

		mov	#fanState41i, r0h
		mov	r0h, @fanState
		set	c
		rts

; ----------------------------------------------

fanState13:	mov	@fanSpeed, r0
		mov	@word_ffedd4, r1
		cmp	r0, r1
		bhs	loc_143ac

		sub	r1, r0
		mov	r0, r1
		bra	loc_143ae

loc_143ac:	sub	r0, r1

loc_143ae:	mov	#1000, r0
		mulxu	r0, er1
		mov	@word_ffedd6, r0
		bne	loc_143c0

		mov	#250, r0

loc_143c0:	divxu	r0, er1
		mov	@byte_ffe819, r2l
		mov	@byte_ffe820, r3l
		cmp	r2l, r3l
		bhs	loc_143da

		sub	r3l, r2l
		mov	r2l, r3l
		mov	#-1, r0h
		bra	loc_143de

loc_143da:	sub	r2l, r3l
		mov	#1, r0h

loc_143de:	mov	r0h, @byte_ffe81f
		extu	r3
		extu	er1
		divxs	r3, er1
		cmp	#10, r1
		bhs	loc_143f6

		mov	#10, r1

loc_143f6:	mov	r1, @dynFanDelay
		jsr	incFanState

		set	c
		rts

; ----------------------------------------------

fanState41:	mov	@fanSpeed, r0
		cmp	#2500, r0
		blo	loc_1442a

		mov	#2500, r0
		mov	r0, @word_ffedd4
		jsr	sub_13bcc

		mov	r0h, @byte_ffe820
		jsr	incFanState

		bra	loc_14432

loc_1442a:	mov	#fanState46i, r0h
		mov	r0h, @fanState

loc_14432:	set	c
		rts

; ----------------------------------------------

		mov	r0, @word_ffedd6
		rts

; ----------------------------------------------

setFanSpeedProfileA:
		cmp	#num_00450, r0l
		blo	loc_14444

		mov	#num_00450 - 1, r0l	; max profile #

loc_14444:	mov	r0l, @fanSpeedProfileA
		bsr	initFan:16

		rts

; ----------------------------------------------

setFanSpeedProfileB:
		cmp	#num_5, r0l
		blo	loc_14456

		mov	#num_5 - 1, r0l		; max profile #

loc_14456:	mov	r0l, @fanSpeedProfileB
		jsr	sub_14152

		rts

; ----------------------------------------------

sub_14462:	mov	#long_ffe823, er3
		mov	#3, r2l
		mov	r2l, @er3
		inc	#1, er3
		cmp	#15, r2l
		bls	loc_14474

		mov	#15, r2l

loc_14474:	mov	#off_00450, er0
		mov	@fanSpeedProfileA, r1l
		shlr	#2, r1l
		extu	r1
		extu	er1
		add	er1, er0
		mov	@er0, er0

loc_1448c:	mov	@er0, er1
		inc	#1, er1
		mov	@er1, r2h
		mov	r2h, @er3
		inc	#1, er3
		inc	#2, er0
		inc	#2, er0
		dec	r2l
		bne	loc_1448c

		rts
.endif

; ----------------------------------------------

word_144a2:
.if     type1R && level >= 0x01030000
		.word 0x12b5, 0xf000
		.word 0x122f, 0xe600
		.word 0x1193, 0xdc00
		.word 0x10e7, 0xd200
		.word 0x1048, 0xc800
		.word 0x0f82, 0xbe00
		.word 0x0ed6, 0xb400
		.word 0x0e1e, 0xaa00
		.word 0x0d59, 0xa000
		.word 0x0c9e, 0x9600
		.word 0x0bc5, 0x8c00
		.word 0x0ae6, 0x8200
		.word 0x0a16, 0x7800
		.word 0x0937, 0x6e00
		.word 0x0860, 0x6400
		.word 0x0754, 0x5a00
		.word 0x069f, 0x5000
		.word 0x05bd, 0x4600
.elseif type1R
		.word 0x12c0, 0xa600
		.word 0x11f8, 0x9c00
		.word 0x1130, 0x9400
		.word 0x1068, 0x8b00
		.word 0x0fa0, 0x8200
		.word 0x0ed8, 0x7600
		.word 0x0e10, 0x6b00
		.word 0x0d48, 0x5e00
		.word 0x0c80, 0x5300
		.word 0x0bb8, 0x4400
		.word 0x0af0, 0x3300
		.word 0x0a28, 0x2000
.else
		.word 0x149b, 0xf000
		.word 0x10d3, 0xe600
		.word 0x0f2b, 0xdc00
		.word 0x0e46, 0xd200
		.word 0x0d43, 0xc800
		.word 0x0c39, 0xbe00
		.word 0x0ad2, 0xb400
		.word 0x0996, 0xaa00
		.word 0x0829, 0xa000
		.word 0x06d6, 0x9600
		.word 0x0657, 0x8c00
		.word 0x05b4, 0x8200
.endif
		.word -1

word_144d4:	.word 0x1770, 0xe105
		.word 0x16a8, 0xd505
		.word 0x15e0, 0xc805
		.word 0x1518, 0xbc05
		.word 0x1450, 0xae05
		.word 0x1388, 0xa305
		.word 0x12c0, 0x9505
		.word 0x11f8, 0x8a05
		.word 0x1130, 0x7f05
		.word 0x1068, 0x7605
		.word 0x0fa0, 0x6c05
		.word 0x0ed8, 0x6305
		.word 0x0e10, 0x5805
		.word 0x0d48, 0x5005
		.word 0x0c80, 0x4a05
		.word 0x0bb8, 0x4005
		.word 0x0af0, 0x3805
		.word 0x0a28, 0x3305
		.word 0x0960, 0x2a05
		.word -1

word_14522:	.word 1000,  25
		.word  500,  10
		.word  200,   5
		.word  150,   3
		.word  100,   2
		.word   50,   1
		.word    0,   0

word_1453e:	.word  500, -10 - 20 & type1R
		.word  400,  -8 - 14 & type1R
		.word  300,  -7 - 11 & type1R
		.word  200,  -6 -  9 & type1R
		.word  100,  -4 -  6 & type1R
		.word   75,  -3 -  2 & type1R
		.word   50,  -2
		.word    0,  -1

; ----------------------------------------------

sub_1455e:	mov	#-1, r0h
		mov	r0h, @byte_ffe834
		mov	#0, r0h
		mov	r0h, @byte_ffff4a
		jsr	sub_147ec

		rts

; ----------------------------------------------

sub_14574:	bclr	#7, @byte_ffff4a:8
		jsr	sub_147b4

		bcs	loc_145a8

		jsr	sub_14820

		mov	r0h, @byte_ffe835
		jsr	sub_14742

		btst	#1, r0h
		beq	loc_14594

		mov	#1, r0h
		bra	loc_1459e

loc_14594:	btst	#3, r0h
		bne	loc_1459c

		mov	#1, r0h
		bra	loc_1459e

loc_1459c:	mov	#3, r0h

loc_1459e:	mov	r0h, @byte_ffe834
		jsr	sub_14652

loc_145a8:	jsr	sub_147ec

		rts

; ----------------------------------------------

task48_2:	jsr	sub_147b4

		bcs	loc_1461c

		mov	@byte_ffe834, r0h
		cmp	#2, r0h
		beq	loc_1461c

		mov	#1, r0h
		jsr	sub_0db7a

		bcs	loc_145f4

		mov	#1, r0h
		jsr	sub_0b42e

		cmp	#1, r0h
		bne	loc_145f4

		mov	#0, r0h
		jsr	sub_0c3d2

		bcs	loc_145ec

		mov	#0, r0h
		jsr	sub_0b42e

		cmp	#1, r0h
		bne	loc_145ec

		mov	#0, r0h
		jsr	sub_0c35c

		btst	#6, r0h
		beq	loc_145f4

loc_145ec:	bset	#7, @byte_ffff4a:8
		mov	#3, r0h
		bra	loc_14608

loc_145f4:	btst	#7, @byte_ffff4a:8
		beq	loc_14602

		mov	#1, r0h
		bclr	#7, @byte_ffff4a:8
		bra	loc_14608

loc_14602:	mov	@byte_ffe834, r0h

loc_14608:	mov	@byte_ffe834, r0l
		cmp	r0h, r0l
		beq	loc_1461c

		mov	r0h, @byte_ffe834
		jsr	sub_14652

loc_1461c:	clr	c
		rts

; ----------------------------------------------

task48_3:	jsr	sub_147ec

		rts

; ----------------------------------------------

sub_14626:	mov	#3, r0h
		jsr	sub_068e6

sub_1462c:	jsr	sub_06416

		cmp	#0x0f, r0h
		bne	rts_14638

		jsr	sub_0633a

rts_14638:	rts

; ----------------------------------------------

sub_1463a:	mov	#3, r0h
		jsr	sub_0693c

		mov	#0x0f, r0h
		mov	#8, r0l
		jsr	sub_0638c

		rts

; ----------------------------------------------

sub_1464a:	mov	#3, r0h
		jsr	sub_068e6

		bra	sub_1462c

; ----------------------------------------------

sub_14652:	jsr	sub_14820

		jsr	sub_14742

		mov	@byte_ffe834, r0l
		cmp	#2, r0l
		beq	loc_14670

		cmp	#1, r0l
		bne	loc_1467a

		btst	#3, r0h
		beq	loc_1467a

		btst	#0, r0h
		bne	loc_1467a

loc_14670:	jsr	sub_1463a

		jsr	loc_0778c

		bra	loc_14690

loc_1467a:	cmp	#3, r0l
		bne	loc_14688

		mov	#3, r0h
		jsr	sub_068e2

		bsr	sub_1462c

		bra	loc_1468c

loc_14688:	jsr	sub_14626

loc_1468c:	jsr	loc_0775c

loc_14690:	clr	c
		rts

; ----------------------------------------------

sub_14694:	mov	@byte_ffe834, r0h
		cmp	#0, r0h
		bne	loc_146a2

		mov	#1, r0h
		bra	loc_146be

loc_146a2:	cmp	#2, r0h
		beq	loc_146aa

		cmp	#3, r0h
		bne	loc_146be

loc_146aa:	jsr	sub_14820

		mov	@byte_ffe835, r0l
		cmp	r0h, r0l
		beq	loc_146bc

		mov	#2, r0h
		bra	loc_146be

loc_146bc:	mov	#3, r0h

loc_146be:	mov	r0h, @byte_ffe834
		bra	sub_14652

; ----------------------------------------------

sub_146c6:	jsr	sub_14820

		jsr	sub_14742

		btst	#3, r0h
		bne	loc_146e0

		mov	#1, r0h
		jsr	sub_0db7a

		bcc	loc_146e0

		jsr	sub_14626

		bra	rts_146f4

loc_146e0:	mov	@byte_ffe834, r0h
		cmp	#3, r0h
		bne	loc_146f0

		jsr	sub_1463a

		bra	rts_146f4

loc_146f0:	jsr	sub_1464a

rts_146f4:	rts

; ----------------------------------------------

sub_146f6:	jsr	sub_147b4

		bcs	rts_14708

		jsr	sub_06416

		cmp	#0x0f, r0h
		bne	rts_14708

		jsr	sub_0633a

rts_14708:	rts

; ----------------------------------------------

sub_1470a:	mov	#sub_14652, er0
		bra	loc_14720

sub_14712:	mov	#sub_146c6, er0
		bra	loc_14720

sub_1471a:	mov	#sub_14694, er0

loc_14720:	jsr	sub_147ec

		push	er0
		jsr	sub_01272

		pop	er0
		bcs	rts_14740

		b ild	pb6pin			; Pin PB6/-WUE6 (Port B Input Data Register)
		bcc	rts_14740

		jsr	sub_147b4

		bcs	rts_14740

		jmp	@er0

rts_14740:	rts

; ----------------------------------------------

sub_14742:	mov	r0h, r0l
		shlr	r0l
		mov	#long_ffe836, er1
		add	r0l, r1l
		addx	#0, r1h
		bcc	loc_14754

		inc	#1, e1

loc_14754:	mov	@er1, r0l
		btst	#0, r0h
		beq	loc_14762

		shlr	r0l
		shlr	r0l
		shlr	r0l
		shlr	r0l

loc_14762:	mov	r0l, r0h
		and	#0x0f, r0h
		rts

; ----------------------------------------------

sub_14768:	mov	#0x10, r1l
		mov	#long_ffe836, er2

loc_14770:	cmp	#0, r1h
		beq	loc_147aa

		cmp	#0, r1l
		beq	loc_147aa

		mov	@er0+, r3h
		mov	@er2, r3l
		bld	#7, r3h
		bst	#3, r3h
		and	#0x0f, r3h
		btst	#0, r1l
		bne	loc_1478c

		and	#0xf0, r3l
		or	r3h, r3l
		bra	loc_14798

loc_1478c:	shll	r3h
		shll	r3h
		shll	r3h
		shll	r3h
		and	#0x0f, r3l
		or	r3h, r3l

loc_14798:	mov	r3l, @er2
		bld	#0, r1l
		addx	#0, r2l
		addx	#0, r2h
		bcc	loc_147a4

		inc	#1, e2

loc_147a4:	dec	r1h
		dec	r1l
		bra	loc_14770

loc_147aa:	mov	#0, r0h
		mov	r0h, @byte_ffe834
		rts

; ----------------------------------------------

sub_147b4:	push	er0
		btst	#6, @byte_ffff4a:8
		bne	loc_147cc

		mov	@byte_ffe834, r0h
		cmp	#-1, r0h
		beq	loc_147cc

		clr	c
		bra	loc_147ce

loc_147cc:	set	c

loc_147ce:	pop	er0
		rts

; ----------------------------------------------

sub_147d4:	bclr	#6, @byte_ffff4a:8
		rts

; ----------------------------------------------

sub_147da:	bset	#6, @byte_ffff4a:8
		rts

; ----------------------------------------------

sub_147e0:	bset	#5, @byte_ffff4a:8
		rts

; ----------------------------------------------

sub_147e6:	bclr	#5, @byte_ffff4a:8
		rts

; ----------------------------------------------

sub_147ec:	push	er0
.if !type70
		jsr	sub_074f8

		bcs	loc_14808

		btst	#5, @byte_ffff4a:8
		bne	loc_1480c

		b ild	p74pin			; Pin P74/AN4 (Port 7 Input Data Register)
		bcc	loc_14808

		jsr	sub_074d0

		bcc	loc_1480c
.endif

loc_14808:
.if level < 0x01000062
		b set	pd7odr			; Pin PD7 (Port D Output Data Register)
.endif
		clr	c
		bra	loc_1480e

loc_1480c:
.if level < 0x01000062
		b clr	pd7odr			; Pin PD7 (Port D Output Data Register)
.endif
		set	c

loc_1480e:	mov	#7, r0h
		jsr	setPINcopy

		pop	er0
		clr	c
		rts

; ----------------------------------------------

byte_1481c:	.byte 3, 15, 6, 15

; ----------------------------------------------

sub_14820:	push	er1
		jsr	sub_07292

		and	#3, r0h
		zero	er1
		mov	r0h, r1l
		add	#byte_1481c, er1
		mov	@er1, r0h
		pop	er1
		rts

; ----------------------------------------------

.if level < 0x01000062
		rts
		rts
.else

; ----------------------------------------------

sub_1483e:	mov	#0, r0h
		mov	r0h, @byte_ffff4c
		bset	#2, r0h
		mov	r0h, @byte_ffff4b
		mov	@tick, r0
		mov	r0, @word_ffee00
		mov	#2000, r1
		add	r1, r0
		mov	r0, @word_ffee04
		clr	c
		jsr	sub_10f4a

		rts

; ----------------------------------------------

task49:		btst	#2, @byte_ffff4b
		beq	loc_14894

		mov	@word_ffee04, r0
		jsr	cmpTick

		bcc	loc_14894

		bclr	#2, @byte_ffff4b
		bsr	loc_1491a:16

		jsr	loc_14944

loc_14894:	mov	@word_ffee00, r0
		jsr	cmpTick

		bcc	loc_148d0

		mov	#0, r0h
		mov	#1, r0l
		mov	#byte_ffee06, er1
		jsr	sub_149ae

		mov	#1, r0h
		mov	#0, r0l
		mov	#byte_ffee08, er1
		jsr	sub_149ae

		mov	#2000, r0
		mov	@tick, r1
		add	r1, r0
		mov	r0, @word_ffee00
		bsr	loc_14944

loc_148d0:	clr	c
		rts

; ----------------------------------------------

sub_148d4:	bcc	loc_148f8

		bclr	#2, @byte_ffff4c
		mov	@tick, r0
		add	#10000, r0
		mov	r0, @word_ffee04
		bset	#2, @byte_ffff4b
		bra	loc_14918

loc_148f8:	bclr	#2, @byte_ffff4c
		bclr	#1, @byte_ffff4c
		bclr	#0, @byte_ffff4c
		bclr	#2, @byte_ffff4b

loc_14918:	bra	loc_14944

loc_1491a:	jsr	sub_074d0

		bcs	loc_1493a

		jsr	sub_074ee

		bcs	loc_14930

		bset	#2, @byte_ffff4c
		bra	loc_14938

loc_14930:	bclr	#2, @byte_ffff4c

loc_14938:	bra	rts_14942

loc_1493a:	bclr	#2, @byte_ffff4c

rts_14942:	rts


loc_14944:	btst	#7, @byte_ffff4b
		beq	loc_14962

		mov	@word_ffee02, r0
		jsr	sub_016e4

		bcc	rts_149ac

		bclr	#7, @byte_ffff4b

loc_14962:	mov	@byte_ffff4c, r0h
		bld	#2, r0h
.if level < 0x01000063
		bor	#3, r0h
.endif
		bor	#1, r0h
		bor	#0, r0h
		bxor	#7, r0h
		bcc	rts_149ac

		bild	#7, r0h
		bst	#7, @byte_ffff4c
		bcc	loc_1499a

		mov	@word_ffe9be, r0
		add	#0x3c, r0
		mov	r0, @word_ffee02
		bset	#7, @byte_ffff4b
		mov	#0x48, r0h
		bra	loc_1499c

loc_1499a:	mov	#0x49, r0h

loc_1499c:	jsr	sub_10cc0

		bld	#7, @byte_ffff4c
		jsr	sub_10f4a

rts_149ac:	rts

; ----------------------------------------------

.if level < 0x01000063
sub_1333a:	mov	#0, r0h
		jsr	sub_0c38c

		push	er0
		mov	#1, r0h
		jsr	sub_0c38c

		pop	er1
		cmp	r0h, r1h
		bls	0f

		mov	r1h, r0h
0:		cmp	#3, r0h
		bhi	2f

		btst	#3, @byte_ffff4b
		beq	1f

		mov	@word_ffeb7c, r0
		jsr	cmpTick

		bcc	3f

		bclr	#3, @byte_ffff4b
		bset	#3, @byte_ffff4c
		bra	3f

1:		mov	@tick, r0
		add	#10000, r0
		mov	r0, @word_ffeb7c
		bset	#3, @byte_ffff4b
		bra	3f

2:		bclr	#3, @byte_ffff4c
3:		rts
.endif

; ----------------------------------------------

sub_149ae:	push	er1
		push	er0
		jsr	sub_074d0

		bcs	loc_14a1a

		jsr	sub_0c7de

		mov	#0xff9c, r1
		cmp	r1, r0
		bgt	loc_14a1a

		mov	@sp, er0		; pop+push er0
		btst	r0l, @byte_ffff4b
		beq	loc_149fa

		mov	@(4,sp), er1
		mov	@er1, r0
		jsr	sub_016e4

		bcc	loc_149f8

		mov	@sp, er0		; pop+push er0
		bset	r0l, @byte_ffff4c
		bclr	r0l, @byte_ffff4b

loc_149f8:	bra	loc_14a18

loc_149fa:	mov	@word_ffe9be, r0
		add	#0x14, r0l
		addx	#0, r0h
		mov	@(4,sp), er1
		mov	r0, @er1
		mov	@sp, er0		; pop+push er0
		bset	r0l, @byte_ffff4b

loc_14a18:	bra	loc_14a2e

loc_14a1a:	mov	@sp, er0		; pop+push er0
		bclr	r0l, @byte_ffff4c
		bclr	r0l, @byte_ffff4b

loc_14a2e:	pop	er1
		pop	er0
		rts

; ----------------------------------------------

sub_14a38:	btst	#2, @byte_ffff4b
		bne	rts_14a56

		bset	#2, @byte_ffff4b
		mov	@tick, r0
		mov	r0, @word_ffee04

rts_14a56:	rts

; ----------------------------------------------

.if !type1R
.if !type70

setupP46DDRout: setOutH 4 6			; Pin P46/PWX0

		mov	#0, r0l
		mov	r0l, @byte_ffe840
		mov	r0l, @byte_ffe83e
		mov	r0l, @byte_ffe83f
		rts

; ----------------------------------------------

sub_14a7e:	b set	p46dr			; Pin P46/PWX0 (Port 4 Data Register)
		rts

; ----------------------------------------------

task50:		mov	@byte_ffe83e, r0h
		mov	#off_14aa0, er1
		jsr	switch_er1_r0h

		bcs	rts_14a9e

		mov	#task50o, r0h
		jsr	schedFrontTask

		clr	c

rts_14a9e:	rts


off_14aa0:	case  0 sub_14aba sub_14ac8 sub_14ada sub_14aee
		case  4 sub_14b5e sub_14bec sub_14c7c sub_14cd6
		case  8 sub_14c7c sub_14c8e sub_14c04 sub_14cfa
		case 12 sub_14d52

; ----------------------------------------------

sub_14aba:	b tst	pb3pin			; Pin PB3/-WUE3/-CS4 (Port B Input Data Register)
		beq	loc_14ac4

		bsr	sub_14d74:16

loc_14ac4:	set	c
		rts

; ----------------------------------------------

sub_14ac8:	mov	#1000, r1
		mov	#task50o, r0h
		jsr	schedBackTaskDelayed

		bsr	sub_14d74:16

		set	c
		rts

; ----------------------------------------------

sub_14ada:	mov	#task50o, r0h
		jsr	checkSchedTask

		bcc	loc_14aea

		bsr	sub_14d74:16

		set	c
		bra	rts_14aec

loc_14aea:	clr	c

rts_14aec:	rts

; ----------------------------------------------

sub_14aee:	mov	#byte_ffee0a, er6
		btst	#7, @er6		; i2c00o
		bne	loc_14b4a

		mov	#0x0b, r5h
		mov	r5h, @(i2c03o:16,er6)
		mov	#0xd2, r5h
		mov	r5h, @(i2c05o:16,er6)
		mov	#0, r5h
		mov	r5h, @(i2c06o:16,er6)
		mov	#byte_ffe841, er5
		mov	er5, @(i2c08o:16,er6)
		mov	#5, r5h
		mov	r5h, @(i2c02o:16,er6)
		mov	#loc_14b56, er5
		mov	er5, @(i2c12o:16,er6)
		mov	#50, r5h
		mov	r5h, @(i2c20o:16,er6)
		mov	#3, r5h
		mov	r5h, @(i2c00o:16,er6)
		mov	#0, r5h
		mov	r5h, @(i2c01o:16,er6)
		mov	er6, er0
		mov	#0, r1h
		mov	r1h, @(i2c04o:16,er0)
		jsr	enqueueI2Ccmd

		bra	loc_14b4e

loc_14b4a:	mov	#0x1a, r0h
		set	c

loc_14b4e:	bsr	sub_14d74:16

		clr	c
		rts


loc_14b56:	mov	#task50o, r0h
		jsr	schedBackTask

		rts

; ----------------------------------------------

sub_14b5e:	btst	#6, @byte_ffee0a
		beq	loc_14bde

		mov	@byte_ffee0e, r0h
		cmp	#0, r0h
		bne	loc_14bba

		zero	er0
		zero	er1

loc_14b7a:	mov	@(byte_ffe841,er0), r2l
		mov	@(byte_14be2,er1), r2h
		and	r2h, r2l
		add	#1, er1
		mov	@(byte_14be2,er1), r2h
		or	r2h, r2l
		mov	r2l, @(byte_ffe841,er0)
		add	#1, er0
		add	#1, er1
		cmp	#0x0a, r1l
		blo	loc_14b7a

		bsr	sub_14d74:16

		bra	loc_14bde

loc_14bba:	mov	@byte_ffe840, r0h
		inc	r0h
		cmp	#7, r0h
		bls	loc_14bd0

		bset	#0, @byte_ffe83f
		bra	loc_14bde

loc_14bd0:	mov	r0h, @byte_ffe840
		mov	#3, r0h
		mov	r0h, @byte_ffe83e

loc_14bde:	set	c
		rts


byte_14be2:	.byte 0x9f, 0x00, 0xbe, 0x01, 0xff, 0x00, 0xff, 0x00, 0xfd, 0x00

; ----------------------------------------------

sub_14bec:	jsr	sub_0752a

		bcs	loc_14bf8

		bsr	sub_14d74:16

		bra	loc_14c00

loc_14bf8:	mov	#0x0a, r0h
		mov	r0h, @byte_ffe83e

loc_14c00:	set	c
		rts

; ----------------------------------------------

sub_14c04:	mov	#0, r0l
		mov	r0l, @byte_ffe840
		mov	#byte_ffee0a, er6
		btst	#7, @er6		; i2c00o
		bne	loc_14c68

		mov	#0x0a, r5h
		mov	r5h, @(i2c03o:16,er6)
		mov	#0xd2, r5h
		mov	r5h, @(i2c05o:16,er6)
		mov	#0, r5h
		mov	r5h, @(i2c06o:16,er6)
		mov	#byte_ffe841, er5
		mov	er5, @(i2c08o:16,er6)
		mov	#5, r5h
		mov	r5h, @(i2c02o:16,er6)
		mov	#loc_14c74, er5
		mov	er5, @(i2c12o:16,er6)
		mov	#50, r5h
		mov	r5h, @(i2c20o:16,er6)
		mov	#3, r5h
		mov	r5h, @(i2c00o:16,er6)
		mov	#0, r5h
		mov	r5h, @(i2c01o:16,er6)
		mov	er6, er0
		mov	#0, r1h
		mov	r1h, @(i2c04o:16,er0)
		jsr	enqueueI2Ccmd

		bra	loc_14c6c

loc_14c68:	mov	#0x1a, r0h
		set	c

loc_14c6c:	bsr	sub_14d74:16

		clr	c
		rts


loc_14c74:	mov	#task50o, r0h
		jsr	schedBackTask

		rts

; ----------------------------------------------

sub_14c7c:	mov	#task50o, r0h
		mov	#80, r1
		jsr	schedBackTaskDelayed

		bsr	sub_14d74:16

		clr	c
		rts

; ----------------------------------------------

sub_14c8e:	mov	#task50o, r0h
		jsr	checkSchedTask

		bcc	loc_14cd2

		jsr	sub_07520

		bcs	loc_14cb0

		btst	#5, @byte_ffe841
		bne	loc_14cca

		bset	#5, @byte_ffe841
		bra	loc_14cc2

loc_14cb0:	btst	#5, @byte_ffe841
		beq	loc_14cca

		bclr	#5, @byte_ffe841

loc_14cc2:	bsr	sub_14d74:16

		set	c
		bra	rts_14cd4

loc_14cca:	mov	#8, r0h
		mov	r0h, @byte_ffe83e

loc_14cd2:	clr	c

rts_14cd4:	rts

; ----------------------------------------------

sub_14cd6:	mov	#task50o, r0h
		jsr	checkSchedTask

		bcc	loc_14cf6

		jsr	sub_07520

		bist	#5, @byte_ffe841
		mov	#0x0a, r0h
		mov	r0h, @byte_ffe83e
		set	c
		bra	rts_14cf8

loc_14cf6:	clr	c

rts_14cf8:	rts

; ----------------------------------------------

sub_14cfa:	btst	#6, @byte_ffee0a
		beq	loc_14d4e

		mov	@byte_ffee0e, r0h
		cmp	#0, r0h
		beq	loc_14d3c

		mov	@byte_ffe840, r0h
		inc	r0h
		cmp	#7, r0h
		bhi	loc_14d2a

		mov	r0h, @byte_ffe840
		mov	#0x0a, r0h
		mov	r0h, @byte_ffe83e
		bra	loc_14d4e

loc_14d2a:	bset	#0, @byte_ffe83f
		mov	#8, r0h
		mov	r0h, @byte_ffe83e
		bra	loc_14d4a

loc_14d3c:	bsr	sub_14d74:16

		mov	#task50o, r0h
		mov	#10, r1
		jsr	schedBackTaskDelayed

loc_14d4a:	clr	c
		bra	rts_14d50

loc_14d4e:	set	c

rts_14d50:	rts

; ----------------------------------------------

sub_14d52:	mov	#task50o, r0h
		jsr	checkSchedTask

		bcc	loc_14d70

		btst	#5, @byte_ffe841
		beq	loc_14d68

		b clr	p46dr			; Pin P46/PWX0 (Port 4 Data Register)

loc_14d68:	mov	#8, r0h
		mov	r0h, @byte_ffe83e

loc_14d70:	clr	c
		rts

; ----------------------------------------------

sub_14d74:	mov	@byte_ffe83e, r0h
		inc	r0h
		mov	r0h, @byte_ffe83e
		rts

; ----------------------------------------------

sub_14d84:	mov	#task50o, r0h
		jsr	schedBackTask

		rts
.endif

; ----------------------------------------------

off_14d8c:	.byte  1, 3
		.long NULL
		.byte  2, 3
		.long NULL
		.byte  3, 3
		.long NULL
		.byte 32, 0
		.long NULL
		.byte 33, 0
		.long NULL
		.byte 33, 0
		.long NULL
		.byte  4, 3
		.long NULL
		.byte  5, 3
		.long NULL
		.byte  6, 3
		.long NULL
		.byte 34, 0
		.long NULL
		.byte 35, 0
		.long sub_0ecce
off_14dce:

; ----------------------------------------------

sub_14dce:	bclr	#0, @byte_ffe1f1
		bclr	#1, @byte_ffe1f1

sub_14dde:	btst	#3, @byte_ffe1f1
		beq	rts_14df0

		bclr	#2, @byte_ffe1f1

rts_14df0:	rts

; ----------------------------------------------

task51:		mov	@byte_ffe1fc, r0l
		beq	loc_14e06

		btst	#2, @byte_ffe1f1
		bne	loc_14e06

		bsr	sub_14e10

loc_14e06:	mov	#task51o, r0h
		jsr	schedFrontTask

		clr	c
		rts

; ----------------------------------------------

sub_14e10:	mov	@byte_ffe1fb, r0l
		extu	r0
		extu	er0
		mov	@(byte_ffe1f2,er0), r1l
		mov	#off_14d8c, er0

loc_14e28:	mov	@er0, r1h
		cmp	r1h, r1l
		bne	loc_14e70

		mov	@(1,er0), r2l
		btst	#0, r2l
		beq	loc_14e4e

		btst	#0, @byte_ffe1f1
		beq	loc_14e7e

		b set	str2.smi_evt		; SMI Event Pending (LPC Status Register 2 (0x66))
		b set	sirqcr0.smie2		; Host SMI Interrupt Enable 2 (LPC SERIRQ Control Register 0)
		bra	loc_14e5e

loc_14e4e:	btst	#1, @byte_ffe1f1
		beq	loc_14e7e

		mov	#0x75, r0h
		jsr	sub_10cc0

loc_14e5e:	bset	#2, @byte_ffe1f1
		bset	#3, @byte_ffe1f1
		bra	loc_14e7e

loc_14e70:	add	#6, er0
		cmp	#off_14dce, er0
		blo	loc_14e28

loc_14e7e:	clr	c
		rts

; ----------------------------------------------

sub_14e82:	b set	sirqcr0.iedir		; Interrupt Enable Direct Mode (LPC SERIRQ Control Register 0)
		rts

; ----------------------------------------------

sub_14e8a:	stm	er0-er2, @-sp
		mov	#off_14d8c, er1

loc_14e94:	mov	@er1, r0h
		cmp	r0h, r0l
		beq	loc_14eaa

		add	#6, er1
		cmp	#off_14dce, er1
		blo	loc_14e94

		bra	loc_14f1c

loc_14eaa:	mov	@(1,er1), r0h
		btst	#0, r0h
		beq	loc_14ebc

		btst	#0, @byte_ffe1f1
		bne	loc_14ec6

loc_14ebc:	btst	#1, @byte_ffe1f1
		beq	loc_14f1c

loc_14ec6:	mov	@byte_ffe1fc, r1l
		beq	loc_14ed6

		cmp	#8, r1l
		bhs	loc_14f20

		bsr	sub_14f28

		bcs	loc_14f20

loc_14ed6:	inc	r1l
		mov	r1l, @byte_ffe1fc
		mov	@byte_ffe1fa, r1l
		extu	r1
		extu	er1
		mov	r0l, @(byte_ffe1f2,er1)
		mov	r1l, r0l
		shll	#2, r0l
		extu	r0
		extu	er0
		_mov	er2, long_ffe231,er0
		inc	r1l
		cmp	#8, r1l
		blo	loc_14f0a

		mov	#0, r1l

loc_14f0a:	mov	r1l, @byte_ffe1fa
		jsr	sub_01276

		bcs	loc_14f1c

		mov	#task51o, r0h
		jsr	schedBackTask

loc_14f1c:	clr	c
		bra	loc_14f22

loc_14f20:	set	c

loc_14f22:	ldm	@sp+, er0-er2
		rts

; ----------------------------------------------

sub_14f28:	stm	er0-er3, @-sp
		mov	@byte_ffe1fb, r3l
		shll	#2, r3l
		extu	r3
		extu	er3

loc_14f38:	mov	@(long_ffe231,er3), er0
		cmp	er0, er2
		beq	loc_14f5c

		dec	r1l
		beq	loc_14f58

		add	#4, er3
		cmp	#0x20, r3l
		blo	loc_14f38

		mov	#0, r3l
		bra	loc_14f38

loc_14f58:	clr	c
		bra	loc_14f5e

loc_14f5c:	set	c

loc_14f5e:	ldm	@sp+, er0-er3
		rts

; ----------------------------------------------

sub_14f64:	btst	#0, @byte_ffe1f1
		bne	rts_14f7a

		bsr	sub_14e82:16

		bset	#0, @byte_ffe1f1

rts_14f7a:	rts

; ----------------------------------------------

sub_14f7c:	bclr	#0, @byte_ffe1f1
		rts

; ----------------------------------------------

sub_14f86:	btst	#1, @byte_ffe1f1
		bne	rts_14f98

		bset	#1, @byte_ffe1f1

rts_14f98:	rts

; ----------------------------------------------

sub_14f9a:	bclr	#1, @byte_ffe1f1
		rts

; ----------------------------------------------

		btst	#0, @byte_ffe1f1
		rts

; ----------------------------------------------

sub_14fae:	btst	#1, @byte_ffe1f1
		rts

; ----------------------------------------------

sub_14fb8:	mov	@byte_ffe1fc, r0l
		beq	loc_15002

		b clr	sirqcr0.smie2		; Host SMI Interrupt Enable 2 (LPC SERIRQ Control Register 0)
		b clr	str2.smi_evt		; SMI Event Pending (LPC Status Register 2 (0x66))
		mov	@byte_ffe1fb, r3l
		shll	#2, r3l
		extu	r3
		extu	er3
		mov	@(long_ffe231,er3), er4
		mov	@er4+, r3l
		mov	r3l, r0l
		mov	r3l, r3h

loc_14fe8:	mov	@er4+, r3l
		mov	r3l, @er2
		add	#1, er2
		dec	r3h
		bne	loc_14fe8

		bclr	#3, @byte_ffe1f1
		mov	#0, r0h
		bra	rts_15006

loc_15002:	mov	#1, r0l
		mov	#0x12, r0h

rts_15006:	rts

; ----------------------------------------------

sub_15008:	mov	@byte_ffe1fb, r3l
		extu	r3
		extu	er3
		mov	@(byte_ffe1f2,er3), r1l
		inc	r3l
		cmp	#8, r3l
		blo	loc_15022

		mov	#0, r3l

loc_15022:	mov	r3l, @byte_ffe1fb
		mov	@byte_ffe1fc, r3l
		dec	r3l
		mov	r3l, @byte_ffe1fc
		beq	loc_15046

		stm	er0-er2, @-sp
		mov	#task51o, r0h
		jsr	schedBackTask

		ldm	@sp+, er0-er2

loc_15046:	mov	@er2, r0l
		bsr	sub_15056

		bclr	#2, @byte_ffe1f1
		mov	#0, r0h
		rts

; ----------------------------------------------

sub_15056:	mov	#off_14d8c, er0

loc_1505c:	mov	@er0, r1h
		cmp	r1h, r1l
		bne	loc_1506e

		mov	@(2,er0), er2
		beq	loc_1506e

		jsr	@er2

		bra	rts_1507c

loc_1506e:	add	#6, er0
		cmp	#off_14dce, er0
		blo	loc_1505c

rts_1507c:	rts

; ----------------------------------------------

sub_1507e:	mov	@er2+, r0l
		dec	r1h
		cmp	#0x40, r0l
		bne	loc_15094

		mov	#byte_ffe1fd, er3
		bsr	sub_150ae

		jsr	sub_1323e

		bra	loc_150a6

loc_15094:	cmp	#0x41, r0l
		bne	loc_150aa

		mov	#long_ffe209, er3
		bsr	sub_150ae

		bsr	sub_150be

		jsr	sub_1320e

loc_150a6:	mov	#0, r0h
		bra	rts_150ac

loc_150aa:	mov	#0x12, r0h

rts_150ac:	rts

; ----------------------------------------------

sub_150ae:	mov	@er2+, r0l
		mov	r0l, @er3
		add	#1, er3
		dec	r1h
		bne	sub_150ae

		rts

; ----------------------------------------------

sub_150be:	mov	#long_ffe209, er3
		mov	#long_ffe212, er4

loc_150ca:	mov	@er3, r0h
		mov	r0h, @er4
		jsr	sub_12f7e

		mov	@(9,er0), r0l
		mov	r0l, @(1,er4)
		mov	@(2,er3), r0h
		mov	r0h, @(6,er4)
		mov	r0h, @(7,er4)
		mov	r0, r1
		sub	r1h, r1l
		extu	r1
		mov	#3, r0h
		divxu	r0h, r1
		sub	r1l, r0l
		mov	r0l, @(2,er4)
		mov	r0l, @(3,er4)
		sub	r1l, r0l
		mov	r0l, @(4,er4)
		mov	r0l, @(5,er4)
		mov	@(1,er3), r0l
		mov	r0l, @(9,er4)
		add	#0x0a, er4
		add	#3, er3
		cmp	#long_ffe212, er3
		blo	loc_150ca

		rts
.endif
.endif

; ----------------------------------------------

taskSeq0Init:	.long sub_01542		; 00
		.long setWaitTime1	; 04
		.long initPorts1	; 08
		.long sub_02de2		; 0c
		.long sub_04c4e		; 10
		.long sub_0570c		; 14
		.long enableTMR_01XY	; 18
		.long sub_06fe2		; 1c
		.long sub_0a5d8		; 20
.if level >= 0x01000062
		.long task27		; 24
.endif
		.long sub_0b7c0		; 28
		.long sub_0b83e		; 2c
		.long init_adc		; 30
		.long sub_0d5ce		; 34
		.long sub_0d868		; 38
		.long rts_0de98		; 3c
		.long rts_0e622		; 40
		.long init_i2c		; 44
		.long sub_0f9ca		; 48
		.long init_dac		; 4c
		.long getFlashStatus	; 50


taskSeq1InitA:	.long initPorts2	; 00
		.long sub_02e72		; 04
		.long enableLPC1	; 08
		.long sub_0490c		; 0c
		.long enableTMR_01	; 10
		.long sub_067b0		; 14
		.long jSetupTMR_XY	; 18
		.long sub_072ea		; 1c
		.long sub_075c6		; 20
		.long sub_07802		; 24
		.long sub_07a46		; 28
.if level >= 0x01000062
		.long sub_07f58		; 2c
.endif
		.long sub_0801c		; 30
		.long sub_090ee		; 34
		.long sub_0945a		; 38
		.long sub_09574		; 3c
		.long sub_09580		; 40
		.long sub_0a008		; 44
		.long sub_0a422		; 48
		.long sub_0d5e6		; 4c
		.long sub_0de9a		; 50
		.long sub_0e624		; 54
		.long sub_0f98c		; 58
		.long sub_0fbd0		; 5c
		.long enableLPC2	; 60
		.long enableLPC3	; 64
		.long sub_116c2		; 68
		.long sub_126ba		; 6c
		.long sub_12a30		; 70
		.long initFan		; 74
		.long sub_1455e		; 78
.if level >= 0x01000062
		.long sub_1483e		; 7c
.endif
.if !type1R
.if !type70
		.long setupP46DDRout	; 80
.endif
		.long sub_14dce		; 84
.endif


taskSeq1:
	task00o   = . - taskSeq1
		.long task00		; 00
	task01o   = . - taskSeq1
		.long NULL		; 04
	task02o   = . - taskSeq1
		.long task02_1_2	; 08
	task03o   = . - taskSeq1
		.long task03		; 0c
	task04o   = . - taskSeq1
		.long task04		; 10
	task05o   = . - taskSeq1
		.long task05		; 14
	task06o   = . - taskSeq1
		.long task06_1		; 18
	task07o   = . - taskSeq1
		.long task07		; 1c
	task08o   = . - taskSeq1
		.long task08		; 20
	task09o   = . - taskSeq1
		.long task09		; 24
	task10o   = . - taskSeq1
		.long task10		; 28
	task11o   = . - taskSeq1
		.long task11		; 2c
	task12o   = . - taskSeq1
		.long task12		; 30
	task13o   = . - taskSeq1
		.long task13		; 34
	task14o   = . - taskSeq1
		.long task14		; 38
	task15o   = . - taskSeq1
		.long task15		; 3c
.if level >= 0x01000062
	task16o   = . - taskSeq1
		.long task16		; 40
.endif
	task17o   = . - taskSeq1
		.long task17		; 44
	task18o   = . - taskSeq1
		.long task18		; 48
	task19o   = . - taskSeq1
		.long task19		; 4c
	task20o   = . - taskSeq1
		.long task20		; 50
	task21o   = . - taskSeq1
		.long task21		; 54
	task22o   = . - taskSeq1
		.long task22		; 58
	task23o   = . - taskSeq1
		.long task23		; 5c
	task24o   = . - taskSeq1
		.long task24		; 60
	task25o   = . - taskSeq1
		.long task25		; 64
	task26o   = . - taskSeq1
		.long task26		; 68
.if level >= 0x01000062
	task27o   = . - taskSeq1
		.long task27		; 6c
.endif
	task28o   = . - taskSeq1
		.long task28		; 70
	task29o   = . - taskSeq1
		.long task29		; 74
	task30o   = . - taskSeq1
		.long task30		; 78
	task31o   = . - taskSeq1
		.long task31_1_2	; 7c
	task32o   = . - taskSeq1
		.long task32		; 80
	task33o   = . - taskSeq1
		.long task33_1		; 84
	task34o   = . - taskSeq1
		.long task34_1		; 88
	do_i2c_0o = . - taskSeq1
		.long do_i2c_0		; 8c
	do_i2c_1o = . - taskSeq1
		.long do_i2c_1		; 90
	task37o   = . - taskSeq1
		.long task37		; 94
	task38o   = . - taskSeq1
		.long task38		; 98
	task39o   = . - taskSeq1
		.long task39_1		; 9c
	task40o   = . - taskSeq1
		.long task40		; a0
	task41o   = . - taskSeq1
		.long task41		; a4
	task42o   = . - taskSeq1
		.long task42		; a8
	task43o   = . - taskSeq1
		.long task43		; ac
	task44o   = . - taskSeq1
		.long task44		; b0
		.long NULL		; b4
	task46o   = . - taskSeq1
		.long task46		; b8
	fanTasko  = . - taskSeq1
		.long fanTask		; bc
	task48o   = . - taskSeq1
		.long NULL		; c0
.if level >= 0x01000062
	task49o   = . - taskSeq1
		.long task49		; c4
.endif
.if !type1R
.if !type70
	task50o = . - taskSeq1
		.long task50		; c8
.endif
	task51o = . - taskSeq1
		.long task51		; cc
.endif


taskSeq2Init:	.long sub_01dac		; 00
		.long sub_0328c		; 04
		.long sub_03b76		; 08
		.long rts_04abc		; 0c
		.long sub_04cb0		; 10
		.long sub_05760		; 14
		.long sub_062b6		; 18
		.long sub_06a1c		; 1c
		.long sub_0704a		; 20
		.long sub_07700		; 24
		.long sub_07a82		; 28
.if level >= 0x01000062
		.long sub_07fbe		; 2c
.endif
		.long rts_0885c		; 30
		.long sub_09678		; 34
		.long rts_0a05e		; 38
		.long rts_0a444		; 3c
		.long rts_0a66a		; 40
		.long sub_0b90c		; 44
		.long rts_0d44e		; 48
		.long sub_0d8c4		; 4c
		.long sub_0e0fa		; 50
		.long rts_0ea16		; 54
		.long rts_0ed70		; 58
		.long sub_0f9ca		; 5c
		.long sub_0fc06		; 60
		.long sub_10360		; 64
		.long sub_11192		; 68
		.long sub_13f00		; 6c
		.long sub_14574		; 70
.if !type70 && !type1R
		.long sub_14a7e		; 74
.endif


taskSeq2:	.long task00		; 00
		.long NULL		; 04
		.long task02_1_2	; 08
		.long NULL		; 0c
		.long NULL		; 10
		.long NULL		; 14
		.long task06_2		; 18
		.long NULL		; 1c
		.long task08		; 20
		.long task09		; 24
		.long task10		; 28
		.long task11		; 2c
		.long task12_2		; 30
		.long task13		; 34
		.long NULL		; 38
		.long NULL		; 3c
.if level >= 0x01000062
		.long NULL		; 40
.endif
		.long NULL		; 44
		.long NULL		; 48
		.long NULL		; 4c
		.long NULL		; 50
		.long NULL		; 54
		.long NULL		; 58
		.long NULL		; 5c
		.long NULL		; 60
		.long NULL		; 64
		.long task26		; 68
.if level >= 0x01000062
		.long task27		; 6c
.endif
		.long task28		; 70
		.long task29		; 74
		.long task30		; 78
		.long task31_1_2	; 7c
		.long task32		; 80
		.long task33_2_3	; 84
		.long task34_2_3	; 88
		.long do_i2c_0		; 8c
		.long do_i2c_1		; 90
		.long task37		; 94
		.long NULL		; 98
		.long task39_2		; 9c
		.long NULL		; a0
		.long NULL		; a4
		.long NULL		; a8
		.long NULL		; ac
		.long task44		; b0
		.long NULL		; b4
		.long NULL		; b8
		.long NULL		; bc
		.long task48_2		; c0
.if level >= 0x01000062
		.long NULL		; c4
.endif
.if !type1R
.if !type70
		.long NULL		; c8
.endif
		.long NULL		; cc
.endif


taskSeq1InitB:	.long sub_01bee		; 00
		.long sub_032b6		; 04
		.long sub_03bae		; 08
		.long sub_04abe		; 0c
		.long sub_04c9c		; 10
		.long sub_05768		; 14
		.long sub_0634e		; 18
		.long sub_06a38		; 1c
		.long sub_07306		; 20
		.long sub_07726		; 24
		.long sub_0885e		; 28
		.long sub_090fe		; 2c
		.long sub_09484		; 30
		.long rts_0957e		; 34
		.long sub_0968c		; 38
		.long sub_0a032		; 3c
		.long sub_0a442		; 40
		.long sub_0a612		; 44
		.long sub_0b8f8		; 48
		.long rts_0d44e		; 4c
		.long sub_0d8c4		; 50
		.long sub_0e102		; 54
		.long rts_0ea16		; 58
		.long rts_0ed70		; 5c
		.long rts_0f9c8		; 60
		.long sub_0fbe4		; 64
		.long sub_1031c		; 68
		.long sub_11196		; 6c
		.long sub_12a7a		; 70
		.long sub_1397a		; 74
		.long sub_146f6		; 78
.if level >= 0x01000062
		.long sub_1483e		; 7c
.endif
.if !type1R
.if !type70
		.long setupP46DDRout	; 80
.endif
		.long sub_14dde		; 84
.endif


taskSeq3Init:	.long sub_01730		; 00
		.long sub_01d40		; 04
		.long sub_0328c		; 08
		.long sub_03b76		; 0c
		.long rts_04abc		; 10
		.long sub_06368		; 14
		.long sub_067dc		; 18
		.long sub_06a3e		; 1c
		.long sub_0731a		; 20
		.long rts_07738		; 24
		.long sub_07a82		; 28
.if level >= 0x01000062
		.long sub_07fc4		; 2c
.endif
		.long sub_096d8		; 30
		.long sub_0a66c		; 34
		.long rts_0d44e		; 38
		.long sub_0d5de		; 3c
		.long sub_0d8c4		; 40
		.long rts_0e12c		; 44
		.long rts_0ea16		; 48
		.long rts_0ed70		; 4c
		.long sub_0fc06		; 50
		.long sub_1039e		; 54
		.long sub_11192		; 58
		.long sub_13f00		; 5c
.if !type70 && !type1R
		.long sub_14a7e		; 60
.endif


taskSeq3:	.long task00		; 00
		.long task01		; 04
		.long task02_3		; 08
		.long NULL		; 0c
		.long NULL		; 10
		.long NULL		; 14
		.long NULL		; 18
		.long NULL		; 1c
		.long NULL		; 20
		.long task09		; 24
		.long task10		; 28
		.long task11		; 2c
		.long NULL		; 30
		.long task13		; 34
		.long NULL		; 38
		.long NULL		; 3c
.if level >= 0x01000062
		.long NULL		; 40
.endif
		.long NULL		; 44
		.long NULL		; 48
		.long NULL		; 4c
		.long NULL		; 50
		.long NULL		; 54
		.long NULL		; 58
		.long NULL		; 5c
		.long NULL		; 60
		.long NULL		; 64
		.long task26		; 68
.if level >= 0x01000062
		.long task27		; 6c
.endif
		.long task28		; 70
		.long task29		; 74
		.long task30		; 78
		.long task31_3		; 7c
		.long task32		; 80
		.long task33_2_3	; 84
		.long task34_2_3	; 88
		.long do_i2c_0		; 8c
		.long do_i2c_1		; 90
		.long NULL		; 94
		.long NULL		; 98
		.long NULL		; 9c
		.long NULL		; a0
		.long NULL		; a4
		.long NULL		; a8
		.long NULL		; ac
		.long NULL		; b0
		.long NULL		; b4
		.long NULL		; b8
		.long NULL		; bc
		.long task48_3		; c0
.if level >= 0x01000062
		.long NULL		; c4
.endif
.if !type1R
.if !type70
		.long NULL		; c8
.endif
		.long NULL		; cc
.endif


taskSeqSleep:	.long sub_016b6		; before & after sleep


taskSeqsEnd:

; ----------------------------------------------

		.org ROMend - 2, -1
chksum3:	.word checksum3			; checksum #3 (0x001000..0x01fffd)

; ==============================================

		.section .bss			; RAM
	exec = . + 0x0380			; 0xffe400

byte_ffe080:	.space 2			; # of build id (e.g. .ascii "28")
.ifeq type1R && level < 0x01030069
byte_ffe082:	.space 1
.endif
.if level >= 0x01000062
byte_ffe083:	.space 1
.if level >= 0x01000066
byte_ffe084:	.space 1
byte_ffe085:	.space 1
.if !type1R
byte_ffe086:	.space 1
byte_ffe087:	.space 1
.endif
.endif
		.align 1
word_ffe088:	.space 2
.if !type1R
		.space 0x60
long_ffe0ea:	.space 0x10
long_ffe0fa:	.space 0x10
byte_ffe10a:	.space 1
byte_ffe10b:	.space 5
.endif
.endif
byte_ffe110:	.space 1
byte_ffe111:	.space 1
byte_ffe112:	.space 1
byte_ffe113:	.space 1
byte_ffe114:	.space 8
byte_ffe11c:	.space 8
long_ffe124:	.space 8
long_ffe12c:	.space 0x60
byte_ffe18c:	.space 8
.if !type1R
byte_ffe194:	.space 0x17
byte_ffe1ab:	.space 0x17
byte_ffe1c2:	.space 0x17
byte_ffe1d9:	.space 0x0c
byte_ffe1e5:	.space 0x0c
byte_ffe1f1:	.space 1
byte_ffe1f2:	.space 8
byte_ffe1fa:	.space 1
byte_ffe1fb:	.space 1
byte_ffe1fc:	.space 1
byte_ffe1fd:	.space 1
byte_ffe1fe:	.space 0x0b
long_ffe209:	.space 9
long_ffe212:	.space 0x1e
byte_ffe230:	.space 1
long_ffe231:	.space 4
.endif
		.align 1
stackTop:	.space 0x11c - 0x1c & type1R
stack:
taskSeqOffset:	.space 1
P1DDRcopy:	.space 1
P2DDRcopy:	.space 1
P3DDRcopy:	.space 1
P4DDRcopy:	.space 1
P5DDRcopy:	.space 1
P6DDRcopy:	.space 1
P7DDRcopy:	.space 1
P8DDRcopy:	.space 1
P9DDRcopy:	.space 1
PADDRcopy:	.space 1
PBDDRcopy:	.space 1
PCDDRcopy:	.space 1
PDDDRcopy:	.space 1
PEDDRcopy:	.space 1
PFDDRcopy:	.space 1
taskQueueIdx:	.space 1
taskQueue:	.space 0x40
byte_ffe3a3:	.space 1
byte_ffe3a4:	.space 0x40
byte_ffe3e4:	.space 1
byte_ffe3e5:	.space 0x10
byte_ffe3f5:	.space 1
byte_ffe3f6:	.space 8
byte_ffe3fe:	.space 1
byte_ffe3ff:	.space 1
byte_ffe400:	.space 1
byte_ffe401:	.space 1
curScanLine:	.space 1
.if !type1R
byte_ffe403:	.space 1
.endif
byte_ffe404:	.space 4
byte_ffe408:	.space 1
byte_ffe409:	.space 1
byte_ffe40a:	.space 1
byte_ffe40b:	.space 1
byte_ffe40c:	.space 1
byte_ffe40d:	.space 0x11
byte_ffe41e:	.space 1
byte_ffe41f:	.space 1
byte_ffe420:	.space 1
byte_ffe421:	.space 1
byte_ffe422:	.space 1
byte_ffe423:	.space 1
byte_ffe424:	.space 1
typematic:	.space 1
byte_ffe426:	.space 1
byte_ffe427:	.space 0x28
byte_ffe44f:	.space 0x28
byte_ffe477:	.space 1
byte_ffe478:	.space 1
byte_ffe479:	.space 1
byte_ffe47a:	.space 1
byte_ffe47b:	.space 0x12
byte_ffe48d:	.space 1
byte_ffe48e:	.space 2
byte_ffe490:	.space 1
byte_ffe491:	.space 8
byte_ffe499:	.space 1
byte_ffe49a:	.space 1
byte_ffe49b:	.space 0x0f
byte_ffe4aa:	.space 1
byte_ffe4ab:	.space 1
byte_ffe4ac:	.space 1
byte_ffe4ad:	.space 1
byte_ffe4ae:	.space 1
byte_ffe4af:	.space 1
byte_ffe4b0:	.space 1
byte_ffe4b1:	.space 1
byte_ffe4b2:	.space 1
byte_ffe4b3:	.space 1
byte_ffe4b4:	.space 1
byte_ffe4b5:	.space 1
byte_ffe4b6:	.space 1
byte_ffe4b7:	.space 1
byte_ffe4b8:	.space 2
byte_ffe4ba:	.space 1
byte_ffe4bb:	.space 1
byte_ffe4bc:	.space 1
byte_ffe4bd:	.space 1
byte_ffe4be:	.space 1
byte_ffe4bf:	.space 1
byte_ffe4c0:	.space 1
byte_ffe4c1:	.space 1
byte_ffe4c2:	.space 1
byte_ffe4c3:	.space 1
byte_ffe4c4:	.space 1
byte_ffe4c5:	.space 1
byte_ffe4c6:	.space 1
byte_ffe4c7:	.space 1
byte_ffe4c8:	.space 1
byte_ffe4c9:	.space 1
byte_ffe4ca:	.space 1
byte_ffe4cb:	.space 1
byte_ffe4cc:	.space 1
byte_ffe4cd:	.space 1
byte_ffe4ce:	.space 1
byte_ffe4cf:	.space 1
byte_ffe4d0:	.space 1
byte_ffe4d1:	.space 1
byte_ffe4d2:	.space 1
byte_ffe4d3:	.space 1
byte_ffe4d4:	.space 1
byte_ffe4d5:	.space 1
byte_ffe4d6:	.space 1
byte_ffe4d7:	.space 1
byte_ffe4d8:	.space 1
byte_ffe4d9:	.space 1
byte_ffe4da:	.space 1
byte_ffe4db:	.space 1
byte_ffe4dc:	.space 1
byte_ffe4dd:	.space 1
byte_ffe4de:	.space 1
byte_ffe4df:	.space 1
byte_ffe4e0:	.space 1
byte_ffe4e1:	.space 1
byte_ffe4e2:	.space 1
byte_ffe4e3:	.space 1
byte_ffe4e4:	.space 1
byte_ffe4e5:	.space 0x30
byte_ffe515:	.space 2
byte_ffe517:	.space 1
byte_ffe518:	.space 1
byte_ffe519:	.space 1
byte_ffe51a:	.space 1
byte_ffe51b:	.space 1
byte_ffe51c:	.space 1
byte_ffe51d:	.space 1
byte_ffe51e:	.space 1
byte_ffe51f:	.space 1
byte_ffe520:	.space 1
.if level < 0x01000063
byte_ffe521:	.space 1
byte_ffe522:	.space 1
byte_ffe3d6:	.space 1
byte_ffe3d7:	.space 1
.else
byte_ffe521:
byte_ffe3d6:	.space 1
byte_ffe522:
byte_ffe3d7:	.space 1
.endif
byte_ffe523:	.space 1
byte_ffe524:	.space 1
byte_ffe525:	.space 1
byte_ffe526:	.space 1
byte_ffe527:	.space 1
.if level >= 0x01000062
byte_ffe528:	.space 1
.endif
byte_ffe529:	.space 1
byte_ffe52a:
.if level >= 0x01000062
		.space 1
.endif
byte_ffe52b:	.space 1
byte_ffe52c:	.space 1
byte_ffe52d:	.space 1
byte_ffe52e:	.space 1
byte_ffe52f:	.space 1
byte_ffe530:	.space 1
byte_ffe531:	.space 1
byte_ffe532:	.space 1
byte_ffe533:	.space 1
byte_ffe534:	.space 0x20
byte_ffe554:	.space 1
byte_ffe555:	.space 1
byte_ffe556:	.space 1
byte_ffe557:	.space 1
byte_ffe558:	.space 1
.if level >= 0x01000062
byte_ffe559:	.space 1
.endif
byte_ffe55a:	.space 1
.if !type1R
byte_ffe55b:	.space 1
.endif
byte_ffe55c:	.space 1
byte_ffe55d:	.space 1
byte_ffe55e:	.space 1
dataTab:	.space 1			; 0x00
byte_ffe560:	.space 1			; 0x01
		.space 1			; 0x02
byte_ffe562:	.space 1			; 0x03
byte_ffe563:	.space 1			; 0x04
byte_ffe564:	.space 1			; 0x05
byte_ffe565:	.space 1			; 0x06
byte_ffe566:	.space 1			; 0x07
byte_ffe567:	.space 1			; 0x08
byte_ffe568:	.space 1			; 0x09
		.space 1			; 0x0a
byte_ffe56a:	.space 1			; 0x0b
		.space 1			; 0x0c
		.space 1			; 0x0d
byte_ffe56d:	.space 1			; 0x0e
byte_ffe56e:	.space 1			; 0x0f
byte_ffe56f:	.space 0x10			; 0x10
byte_ffe57f:	.space 1			; 0x20
byte_ffe580:	.space 1			; 0x21
byte_ffe581:	.space 1			; 0x22
byte_ffe582:	.space 1			; 0x23
byte_ffe583:	.space 1			; 0x24
byte_ffe584:	.space 1			; 0x25
		.space 1			; 0x26
byte_ffe586:	.space 1			; 0x27
byte_ffe587:	.space 1			; 0x28
byte_ffe588:	.space 1			; 0x29
byte_ffe589:	.space 1			; 0x2a
		.space 1			; 0x2b
byte_ffe58b:	.space 1			; 0x2c
		.space 1			; 0x2d
byte_ffe58d:	.space 1			; 0x2e
fanCtrl:	.space 1			; 0x2f fan ctrl/status
byte_ffe58f:	.space 1			; 0x30 volume
byte_ffe590:	.space 1			; 0x31 LCD brightness
byte_ffe591:	.space 1			; 0x32
byte_ffe592:	.space 1			; 0x33
byte_ffe593:	.space 1			; 0x34
byte_ffe594:	.space 1			; 0x35
byte_ffe595:	.space 1			; 0x36
byte_ffe596:	.space 1			; 0x37
byte_ffe597:	.space 1			; 0x38
byte_ffe598:	.space 1			; 0x39
byte_ffe599:	.space 1			; 0x3a
byte_ffe59a:	.space 1			; 0x3b 7 !p74pin, 6 pd5pin, 5 pd6pin, 4 pd2pin, 3 ?, 2 pc4pin, 1 p13dr, 0 !pc5pin
byte_ffe59b:	.space 1			; 0x3c
byte_ffe59c:	.space 1			; 0x3d
byte_ffe59d:	.space 1			; 0x3e
		.space 1			; 0x3f
		.space 1			; 0x40
		.space 1			; 0x41
		.space 1			; 0x42
		.space 1			; 0x43
		.space 1			; 0x44
		.space 1			; 0x45
byte_ffe5a5:	.space 1			; 0x46
byte_ffe5a6:	.space 1			; 0x47
byte_ffe5a7:	.space 1			; 0x48
byte_ffe5a8:	.space 1			; 0x49
byte_ffe5a9:	.space 1			; 0x4a
byte_ffe5aa:	.space 1			; 0x4b
byte_ffe5ab:	.space 1			; 0x4c
byte_ffe5ac:	.space 1			; 0x4d
byte_ffe5ad:	.space 1			; 0x4e
byte_ffe5ae:	.space 1			; 0x4f
byte_ffe5af:	.space 1			; 0x50
byte_ffe5b0:	.space 1			; 0x51
byte_ffe5b1:	.space 1			; 0x52
byte_ffe5b2:	.space 1			; 0x53
yearL:		.space 1			; 0x54
yearH:		.space 1			; 0x55
month:		.space 1			; 0x56
day:		.space 1			; 0x57
hour:		.space 1			; 0x58
minute:		.space 1			; 0x59
second:		.space 1			; 0x5a
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 0x10			; 0x60
		.space 1			; 0x70
		.space 1
		.space 1
		.space 1
byte_ffe5d3:	.space 1			; 0x74
byte_ffe5d4:	.space 1			; 0x75
byte_ffe5d5:	.space 1			; 0x76
byte_ffe5d6:	.space 1			; 0x77
byte_ffe5d7:	.space 1			; 0x78 temperature
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
byte_ffe5df:	.space 1			; 0x80
byte_ffe5e0:	.space 1			; 0x81
		.space 1			; 0x82
		.space 1			; 0x83
		.space 1			; 0x84 fan speed LSB
byte_ffe5e4:	.space 1			; 0x85 fan speed MSB
byte_ffe5e5:	.space 1			; 0x86
byte_ffe5e6:	.space 1			; 0x87
byte_ffe5e7:	.space 1			; 0x88
byte_ffe5e8:	.space 1			; 0x89
		.space 1			; 0x8a
		.space 1			; 0x8b
byte_ffe5eb:	.space 1			; 0x8c
		.space 1			; 0x8d
byte_ffe5ed:	.space 1			; 0x8e
		.space 1			; 0x8f
byte_ffe5ef:	.space 1			; 0x90
		.space 1			; 0x91
byte_ffe5f1:	.space 1			; 0x92 I/O register address MSB
byte_ffe5f2:	.space 1			; 0x93 I/O register address LSB
byte_ffe5f3:	.space 1			; 0x94 I/O register data (PIN register)
byte_ffe5f4:	.space 1			; 0x95 I/O register data (copy of DDR)
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
.if !type1R
		.space 0x10			; 0xa0
		.space 0x10			; 0xb0
byte_ffe61f:	.space 0x08			; 0xc0 temperature
tabSel:		.space 0x08			; 0xc8 0x, 1x, 2x, F0..F1
.endif
byte_ffe62f:	.space 0x10			; 0xd0
byte_ffe63f:	.space 1
byte_ffe640:	.space 1
byte_ffe641:	.space 1
writeOffset:	.space 1
dataCtr:	.space 1
byte_ffe644:	.space 1
cntr20:		.space 1
byte0xEE:	.space 1
byte0xD0:	.space 1			; flash status
byte_ffe648:	.space 1
byte_ffe649:	.space 1
byte_ffe64a:	.space 1
byte_ffe64b:	.space 1
byte_ffe64c:	.space 1
byte_ffe64d:	.space 20
.if !type1R
		.space 6
.endif
	num_ffe64d = . - byte_ffe64d
byte_ffe667:	.space 1
byte_ffe668:	.space 1
byte_ffe669:	.space 1
byte0xB0:	.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
byte_ffe67a:	.space 1
byte_ffe67b:	.space 1
		.space 3
byte_ffe67f:	.space 1
byte_ffe680:	.space 1
long_ffe681:	.space 8
long_ffe689:	.space 8
byte_ffe691:	.space 1
long_ffe692:	.space 6
temperState:	.space 1
temperIdx:	.space 1			; 0..f
byte_ffe69a:	.space 1
byte_ffe69b:	.space 1
byte_ffe69c:	.space 2
byte_ffe69e:	.space 2
byte_ffe6a0:	.space 0x1c
.if !type1R
		.space 0x20
.endif
byte_ffe6dc:	.space 1
.if type1R
byte_ffedb4:	.space 1
.endif
long_ffe6dd:	.space 0x88
.if !type1R
		.space 0x88
.endif
.if level >= 0x01030000
byte_ffe7ed:	.space 1
byte_ffe7ee:	.space 1
.endif
.if !type1R
tabSelector:	.space 1			; 0..1
byte_ffe7f0:	.space 1
long_ffe7f1:	.space 0x10
long_ffe801:	.space 0x10
.endif
fanState:	.space 1
byte_ffe812:	.space 1
speedLevel:	.space 1
manLevel:	.space 1
autoLevel:	.space 1
byte_ffe816:	.space 1
.if !type1R
byte_ffe817:	.space 1
.endif
byte_ffe818:	.space 1
byte_ffe819:	.space 1
byte_ffe81a:	.space 1
byte_ffe81b:	.space 1
byte_ffe81c:	.space 1
byte_ffe81d:	.space 1
byte_ffe81e:	.space 1
.if !type1R
byte_ffe81f:	.space 1
byte_ffe820:	.space 1
fanSpeedProfileA:
		.space 1
fanSpeedProfileB:
		.space 1
long_ffe823:	.space 0x10
.endif
byte_ffe833:	.space 1
byte_ffe834:	.space 1
byte_ffe835:	.space 1
long_ffe836:	.space 4
.if !type70
		.space 4
.endif
.if     level < 0x01000062
		.space 1
.elseif !type1R
byte_ffe83e:	.space 1
byte_ffe83f:	.space 1
byte_ffe840:	.space 1
byte_ffe841:	.space 1
.if !type70
		.space 8
.endif
.endif
		.align 1
hook:		.space 6			; initially contains 0x5470 (rts)
backTaskReadyBitVec:
		.space 8
frontTaskReadyBitVec:
		.space 8
taskEnabledBitVec:
		.space 8
long_ffe868:	.space 4
long_ffe86c:	.space 4
word_ffe870:	.space 2
word_ffe872:	.space 2
		.space 0x80
tick:		.space 2
tock:		.space 2
long_ffe8f8:	.space 4
long_ffe8fc:	.space 4
ramFreeLevel:	.space 4
long_ffe904:	.space 4
long_ffe908:	.space 4
long_ffe90c:	.space 4
long_ffe910:	.space 4
word_ffe914:	.space 2
curScanRead:	.space 0x10
		.space 2
word_ffe928:	.space 2
prePrevScanRead:.space 0x10
byte_ffe93a:	.space 2
prevScanRead:	.space 0x10
byte_ffe94c:	.space 2
typematicDelay: .space 2
typematicIntvl:	.space 2
word_ffe952:	.space 2
word_ffe954:	.space 2
word_ffe956:	.space 4
long_ffe95a:	.space 4
long_ffe95e:	.space 4
long_ffe962:	.space 0x0c
byte_ffe96e:	.space 1
byte_ffe96f:	.space 1
word_ffe970:	.space 2
word_ffe972:	.space 2
long_ffe974:	.space 4
long_ffe978:	.space 4
long_ffe97c:	.space 4
long_ffe980:	.space 4
long_ffe984:	.space 4
long_ffe988:	.space 4
long_ffe98c:	.space 6
long_ffe992:	.space 4
word_ffe996:	.space 2
word_ffe998:	.space 2
word_ffe99a:	.space 2
word_ffe99c:	.space 2
word_ffe99e:	.space 2
word_ffe9a0:	.space 2
word_ffe9a2:	.space 2
long_ffe9a4:	.space 4
long_ffe9a8:	.space 0x10
word_ffe9b8:	.space 1
word_ffe9b9:	.space 1
word_ffe9ba:	.space 2
word_ffe9bc:	.space 2
word_ffe9be:	.space 2
internalDateH:	.space 2
internalDateL:	.space 2
word_ffe9c4:	.space 2
word_ffe9c6:	.space 2
byte_ffe9c8:	.space 1
byte_ffe9c9:	.space 1
byte_ffe9ca:	.space 1
byte_ffe9cb:	.space 1
long_ffe9cc:	.space 4
long_ffe9d0:	.space 4
long_ffe9d4:	.space 4
long_ffe9d8:	.space 4
long_ffe9dc:	.space 4
long_ffe9e0:	.space 4
.if level >= 0x01000062
word_ffe9e4:	.space 2
word_ffe9e6:	.space 2
.endif
word_ffe9e8:	.space 2
long_ffe9ea:	.space 4
long_ffe9ee:	.space 4
long_ffe9f2:	.space 4
long_ffe9f6:	.space 4
long_ffe9fa:	.space 4
long_ffe9fe:	.space 4
long_ffea02:	.space 4
word_ffea06:	.space 0x18
word_ffea1e:	.space 0x18
word_ffea36:	.space 8
byte_ffea3e:	.space 1
long_ffea3f:	.space 0x11
byte_ffea50:	.space 1
long_ffea51:	.space 0x11
byte_ffea62:	.space 1
long_ffea63:	.space 0x11
long_ffea74:	.space 0x0c
long_ffea80:	.space 0x0c
long_ffea8c:	.space 0x0c
byte_ffea98:	.space 2
long_ffea9a:	.space 4
long_ffea9e:	.space 4
word_ffeaa2:	.space 2
byte_ffeaa4:	.space 2
word_ffeaa6:	.space 2
word_ffeaa8:	.space 2
word_ffeaaa:	.space 2
byte_ffeaac:	.space 1
byte_ffeaad:	.space 2
byte_ffeaaf:	.space 5
word_ffeab4:	.space 0x18
word_ffeacc:	.space 2
word_ffeace:	.space 0x50
.ifeq type1R && level < 0x01030069
		.space 0x20
.endif
word_ffeb3e:	.space 8
byte_ffeb46:	.space 1
byte_ffeb47:	.space 2
byte_ffeb49:	.space 5
word_ffeb4e:	.space 0x16
byte_ffeb64:	.space 4
word_ffeb68:	.space 0x1a
byte_ffeb82:	.space 0x36
.ifeq type1R && level < 0x01030069
		.space 0x20
.endif
word_ffebd8:	.space 8
word_ffebe0:	.space 2
word_ffebe2:	.space 2
long_ffebe4:	.space 4
byte_ffebe8:	.space 2
word_ffebea:	.space 2
long_ffebec:	.space 4
long_ffebf0:	.space 4
byte_ffebf4:	.space 2
byte_ffebf6:	.space 1
byte_ffebf7:	.space 0x17
i2cBuf:
i2cBuf00:
	i2c00o = . - i2cBuf
		.space 1
.if level >= 0x01000062
	i2c01o = . - i2cBuf
		.space 1
.endif
i2cBuf02:
	i2c02o = . - i2cBuf
		.space 1
	i2c03o = . - i2cBuf
		.space 1
i2cBuf04:
	i2c04o = . - i2cBuf
		.space 1
	i2c05o = . - i2cBuf
		.space 1
	i2c06o = . - i2cBuf
		.space 1
.if level >= 0x01000062
	i2c07o = . - i2cBuf
		.space 1
.endif
	i2c08o = . - i2cBuf
		.space 4
	i2c12o = . - i2cBuf
		.space 4
	i2c16o = . - i2cBuf
		.space 4
	i2c20o = . - i2cBuf
		.space 2
word_ffec24:	.space 2
word_ffec26:	.space 2
.if level < 0x01000063
word_ffec28:	.space 0x10
long_ffe982:	.space 0x04
.endif
adcVals0:	.space 0x10
adcVals1:	.space 0x10
word_ffec48:	.space 4
.if level < 0x01000063
		.space 0x0c
.endif
word_ffec4c:	.space 6
.if level < 0x01000063
		.space 0x0c
.endif
long_ffec52:	.space 4
word_ffec56:	.space 2
word_ffec58:	.space 2
word_ffec5a:	.space 2
word_ffec5c:	.space 2
word_ffec5e:	.space 2
word_ffec60:	.space 2
word_ffec62:	.space 2
long_ffec64:	.space 4
word_ffec68:	.space 0x20
word_ffec88:	.space 2
.if level < 0x01000062
word_ffec8a:	.space 2
word_ffec8c:	.space 2
word_ffec8e:	.space 2
.else
		.space 6
.endif
		.space 0x18
word_ffeca8:	.space 0x20
word_ffecc8:	.space 2
long_ffecca:	.space 2
.if level < 0x01000062
word_ffeccc:	.space 2
word_ffecce:	.space 2
.else
		.space 0x08
.endif
		.space 0x16
word_ffecea:	.space 2
word_ffecec:	.space 2
byte_ffecee:	.space 2
word_ffecf0:	.space 2
word_ffecf2:	.space 2
word_ffecf4:	.space 2
word_ffecf6:	.space 2
.if level >= 0x01000062
long_ffecf8:	.space 0x0a
long_ffed02:	.space 0x0a
.endif
word_ffed0c:	.space 2
word_ffed0e:	.space 2
.if level >= 0x01000062
word_ffed10:	.space 2
.endif
i2c_0:		.space 1			; i2c_0 flags
		.space 1
		.space 1			; i2c_0 state2
		.space 1
		.space 1			; i2c_0; initially 0x8c
		.space 1
		.space 1			; i2c_0 state
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1			; i2c_0 cmd buf
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
i2c_1:		.space 1			; i2c_1 flags
		.space 1
		.space 1			; i2c_1 state2
		.space 1
		.space 1			; i2c_1; initially 0x90
		.space 1
		.space 1			; i2c_1 state
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1			; i2c_1 cmd buf
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
		.space 1
word_ffed56:	.space 2
word_ffed58:	.space 2
word_ffed5a:	.space 2
word_ffed5c:	.space 2
word_ffed5e:	.space 2
curDacTabsPtr:	.space 4
dacVals:	.space 4
cmdPtr:		.space 4
long_ffed6c:	.space 4
word_ffed70:	.space 2
word_ffed72:	.space 2
word_ffed74:	.space 2
long_ffed76:	.space 4
long_ffed7a:	.space 4
long_ffed7e:	.space 4
long_ffed82:	.space 4
word_ffed86:	.space 2
byte_ffed88:	.space 0x14
.if level >= 0x01000062
		.space 2
.endif
byte_ffed9e:	.space 0x14
.if level < 0x01000062
byte_ffedb8:	.space 3
byte_ffedbc:	.space 0x0f
.endif
		.space 2
.if !type1R
byte_ffedb4:	.space 1
byte_ffedb5:	.space 1
temperActive7x:	.space 1			; temperature sensor 0x78..0x7f enabled
temperActiveCx:	.space 1			; temperature sensor 0xc0..0xc7 enabled
.endif
.if level >= 0x01000062
byte_ffedb8:	.space 4
byte_ffedbc:	.space 0x12
.endif
fanSpeed:	.space 2			; fan speed
long_ffedd0:	.space 4
word_ffedd4:	.space 2
.if !type1R
word_ffedd6:	.space 2
dynFanDelay:	.space 2
word_ffedda:	.space 2
.endif
long_ffeddc:	.space 4			; level pointer
long_ffede0:	.space 0x12
long_ffedf2:	.space 0x0c
word_ffedfe:	.space 2
.if level >= 0x01000062
word_ffee00:	.space 2
word_ffee02:	.space 2
.if level < 0x01000063
word_ffeb7c:	.space 2
.endif
word_ffee04:	.space 2
byte_ffee06:	.space 2
byte_ffee08:	.space 2
.if !type1R && !type70
byte_ffee0a:	.space 4
byte_ffee0e:	.space 0x12
.endif
.endif
ramFreeArea:

; ==============================================

		.offset RAM8 & M24		; 8-bit addressable RAM
byte_ffff00:	.space 1
byte_ffff01:	.space 1
byte_ffff02:	.space 1
byte_ffff03:	.space 1
byte_ffff04:	.space 1
byte_ffff05:	.space 1
byte_ffff06:	.space 1
byte_ffff07:	.space 1
byte_ffff08:	.space 1
byte_ffff09:	.space 1
byte_ffff0a:	.space 1
byte_ffff0b:	.space 1
byte_ffff0c:	.space 1
byte_ffff0d:	.space 1
byte_ffff0e:	.space 1
byte_ffff0f:	.space 1
byte_ffff10:	.space 1
byte_ffff11:	.space 1
byte_ffff12:	.space 1
byte_ffff13:	.space 1
byte_ffff14:	.space 1
byte_ffff15:	.space 1
byte_ffff16:	.space 1
byte_ffff17:	.space 1
.if !type1R
		.space 1
.endif
byte_ffff19:	.space 1
byte_ffff1a:	.space 1
byte_ffff1b:	.space 1
byte_ffff1c:	.space 1
byte_ffff1d:	.space 1
byte_ffff1e:	.space 1
byte_ffff1f:	.space 1
byte_ffff20:	.space 1
byte_ffff21:	.space 1
byte_ffff22:	.space 1
byte_ffff23:	.space 1
byte_ffff24:	.space 1
.if type1R && level < 0x01030069
byte_ffe082:
.endif
byte_ffff25:	.space 1
.if !type1R
byte_ffff26:	.space 1
.endif
byte_ffff27:	.space 1
byte_ffff28:	.space 1
byte_ffff29:	.space 1
.if level < 0x01000063
byte_ffff26:	.space 1
.endif
byte_ffff2a:	.space 1
byte_ffff2b:	.space 1
byte_ffff2c:	.space 1
byte_ffff2d:	.space 1
.if level >= 0x01000062
byte_ffff2e:	.space 1
.endif
byte_ffff2f:	.space 1
byte_ffff30:	.space 1
curBrightnessTab:
		.space 9 * 2
ibfi2Flags:	.space 1			; 5 cmd recvd
execFlags:	.space 1
byte_ffff45:	.space 1
byte_ffff46:	.space 1
byte_ffff47:	.space 1			; 6 build id contains "?"
byte_ffff48:	.space 1
.if type1R
temperActive7x:	.space 1			; temperature sensor 0x78..0x7f enabled
.endif
byte_ffff49:	.space 1			; 6 fan off, 4 automatic speed
byte_ffff4a:	.space 1
.if level >= 0x01000062
byte_ffff4b:	.space 1
byte_ffff4c:	.space 1
.endif


; ===========================================================
