		.nolist
		.psize 0, 0

; Renesas H8S/2161BV Advanced Mode 2 I/O Registers
; HD64F2161BTE10, 128 KB Flash Memory, 4 KB RAM, 10 MHz
; 0.35 µm technology, typically 10000 (min. 100) rewrites

; 0x??000000..0x??01ffff  0x20000  Flash Memory
; 0x??ffe080..0x??ffefff    0xf80  RAM
; 0x??fff800..0x??fffeff    0x700  I/O Registers 3 & 2
; 0x??ffff00..0x??ffff7f     0x80  RAM
; 0x??ffff80..0x??ffffff     0x80  I/O Registers 1


		.h8300s				; H8S/2600 Series in Advanced Mode


		.macro	_mov ers, disp, erd	; Alternate Coding  mov.l ers, @(disp:32, erd)
.ifdef FIX
		mov	\ers, @(\disp:32, \erd)	; Regular Coding
.else
		.irpc	reg, \ers		; Extract Trailing Digit of Register Name
		.ers	= \reg
		.endr
		.irpc	reg, \erd		; Extract Trailing Digit of Register Name
		.erd	= \reg
		.endr
		.word	0x0100
		.long	0x78806ba0 ^ 0x00800000 | .erd << 20 | .ers
		.long	\disp
.endif
		.endm


		.macro	b instr bitaddr		; Bit Manipulation Instructions
.if \bitaddr & 0x0fffff00 == 0x0fffff00
		b\instr	#\bitaddr >> 28, @\bitaddr | 0xffffff00 :8  ; 8-bit Length
.else
		b\instr	#\bitaddr >> 28, @\bitaddr & 0x0fffffff | (\bitaddr << 4 < 0) << 28
.endif
		.endm


		.macro	reg name address	; 32-bit Sign Extension of 16-bit Address
		\name              = (\address << 16 < 0) << 16 | \address
		.endm

		.macro	bit register name bitnumber
		\register\(.)\name = \register & 0x0fffffff | \bitnumber << 28
		.endm

		.macro	pin register name bitnumber
		\register\(.)\name = \register & 0x0fffffff | \bitnumber << 28
		\name              = \register\(.)\name	; Short Form for Unique Names
		.endm


    NULL	=   0x00000000	; NULL Address
    M8		=   0x000000ff	;  8-bit Mask
    M16		=   0x0000ffff	; 16-bit Mask
    M24		=   0x00ffffff	; 24-bit Mask

    ROM		=   0x00000000	; Internal Flash Memory Start 
    ROMend	=   0x00020000	; Internal Flash Memory End 

reg RAM			0xe080	; Low  Internal RAM Start (16-bit addressable)
reg RAMend		0xf000	; Low  Internal RAM End   (16-bit addressable)
reg RAM8		0xff00	; High Internal RAM Start ( 8-bit addressable)
reg RAM8end		0xff80	; High Internal RAM End   ( 8-bit addressable)

reg pgnocr		0xfe16	; Port G Open Drain Control Register
pin pgnocr pg7nocr	7	; Pin PG7
pin pgnocr pg6nocr	6	; Pin PG6
pin pgnocr pg5nocr	5	; Pin PG5
pin pgnocr pg4nocr	4	; Pin PG4
pin pgnocr pg3nocr	3	; Pin PG3
pin pgnocr pg2nocr	2	; Pin PG2
pin pgnocr pg1nocr	1	; Pin PG1
pin pgnocr pg0nocr	0	; Pin PG0

reg penocr		0xfe18	; Port E Open Drain Control Register
pin penocr pe7nocr	7	; Pin PE7
pin penocr pe6nocr	6	; Pin PE6
pin penocr pe5nocr	5	; Pin PE5
pin penocr pe4nocr	4	; Pin PE4
pin penocr pe3nocr	3	; Pin PE3
pin penocr pe2nocr	2	; Pin PE2
pin penocr pe1nocr	1	; Pin PE1
pin penocr pe0nocr	0	; Pin PE0

reg pfnocr		0xfe19	; Port F Open Drain Control Register
pin pfnocr pf7nocr	7	; Pin PF7
pin pfnocr pf6nocr	6	; Pin PF6
pin pfnocr pf5nocr	5	; Pin PF5
pin pfnocr pf4nocr	4	; Pin PF4
pin pfnocr pf3nocr	3	; Pin PF3
pin pfnocr pf2nocr	2	; Pin PF2
pin pfnocr pf1nocr	1	; Pin PF1
pin pfnocr pf0nocr	0	; Pin PF0

reg pcnocr		0xfe1c	; Port C Open Drain Control Register
pin pcnocr pc7nocr	7	; Pin PC7
pin pcnocr pc6nocr	6	; Pin PC6
pin pcnocr pc5nocr	5	; Pin PC5
pin pcnocr pc4nocr	4	; Pin PC4
pin pcnocr pc3nocr	3	; Pin PC3
pin pcnocr pc2nocr	2	; Pin PC2
pin pcnocr pc1nocr	1	; Pin PC1
pin pcnocr pc0nocr	0	; Pin PC0

reg pdnocr		0xfe1d	; Port D Open Drain Control Register
pin pdnocr pd7nocr	7	; Pin PD7
pin pdnocr pd6nocr	6	; Pin PD6
pin pdnocr pd5nocr	5	; Pin PD5
pin pdnocr pd4nocr	4	; Pin PD4
pin pdnocr pd3nocr	3	; Pin PD3
pin pdnocr pd2nocr	2	; Pin PD2
pin pdnocr pd1nocr	1	; Pin PD1
pin pdnocr pd0nocr	0	; Pin PD0

reg twr0mw		0xfe20	; LPC Bidirectional Data Register  0MW
reg twr0sw		0xfe20	; LPC Bidirectional Data Register  0SW
reg twr1		0xfe21	; LPC Bidirectional Data Register  1
reg twr2		0xfe22	; LPC Bidirectional Data Register  2
reg twr3		0xfe23	; LPC Bidirectional Data Register  3
reg twr4		0xfe24	; LPC Bidirectional Data Register  4
reg twr5		0xfe25	; LPC Bidirectional Data Register  5
reg twr6		0xfe26	; LPC Bidirectional Data Register  6
reg twr7		0xfe27	; LPC Bidirectional Data Register  7
reg twr8		0xfe28	; LPC Bidirectional Data Register  8
reg twr9		0xfe29	; LPC Bidirectional Data Register  9
reg twr10		0xfe2a	; LPC Bidirectional Data Register 10
reg twr11		0xfe2b	; LPC Bidirectional Data Register 11
reg twr12		0xfe2c	; LPC Bidirectional Data Register 12
reg twr13		0xfe2d	; LPC Bidirectional Data Register 13
reg twr14		0xfe2e	; LPC Bidirectional Data Register 14
reg twr15		0xfe2f	; LPC Bidirectional Data Register 15

reg idr3		0xfe30	; LPC Input Data Register 3
reg odr3		0xfe31	; LPC Output Data Register 3
reg str3		0xfe32	; LPC Status Register 3
bit str3 ibf3b		7	; Bidirectional Data Register Input Buffer Full
bit str3 obf3b		6	; Bidirectional Data Register Output Buffer Full
bit str3 mwmf		5	; Master Write Mode Flag
bit str3 swmf		4	; Slave Write Mode Flag
bit str3 c_d3		3	; Command/-Data
bit str3 dbu32		2	; Defined By User
bit str3 ibf3a		1	; Input Buffer Full
bit str3 obf3a		0	; Output Buffer Full

reg ladr3h		0xfe34	; LPC Channel 3 Address Register H
reg ladr3l		0xfe35	; LPC Channel 3 Address Register L
bit ladr3l twre		0	; Bidirectional Data Register Enable

reg sirqcr0		0xfe36	; LPC SERIRQ Control Register 0
bit sirqcr0 q_c		7	; Quiet/-Continuous Mode Flag
bit sirqcr0 selreq	6	; Start Frame Initiation Request Select
bit sirqcr0 iedir	5	; Interrupt Enable Direct Mode
bit sirqcr0 smie3b	4	; Host SMI Interrupt Enable 3B
bit sirqcr0 smie3a	3	; Host SMI Interrupt Enable 3A
bit sirqcr0 smie2	2	; Host SMI Interrupt Enable 2
bit sirqcr0 irq12e1	1	; Host IRQ12 Interrupt Enable 1
bit sirqcr0 irq1e1	0	; Host IRQ1 Interrupt Enable 1

reg sirqcr1		0xfe37	; LPC SERIRQ Control Register 1
bit sirqcr1 irq11e3	7	; Host IRQ11 Interrupt Enable 3
bit sirqcr1 irq10e3	6	; Host IRQ10 Interrupt Enable 3
bit sirqcr1 irq9e3	5	; Host IRQ9 Interrupt Enable 3
bit sirqcr1 irq6e3	4	; Host IRQ6 Interrupt Enable 3
bit sirqcr1 irq11e2	3	; Host IRQ11 Interrupt Enable 2
bit sirqcr1 irq10e2	2	; Host IRQ10 Interrupt Enable 2
bit sirqcr1 irq9e2	1	; Host IRQ9 Interrupt Enable 2
bit sirqcr1 irq6e2	0	; Host IRQ6 Interrupt Enable 2

reg idr1		0xfe38	; LPC Input Data Register 1 (0x60/0x64)
reg odr1		0xfe39	; LPC Output Data Register 1 (0x60)
reg str1		0xfe3a	; LPC Status Register 1 (0x64)
bit str1 dbu17		7	; Defined By User
bit str1 smi_evt	6	; SMI Event Pending
bit str1 sci_evt	5	; SCI Event Pending
bit str1 burst		4	; Burst Mode For Polled Command Processing
bit str1 c_d1		3	; Command/-Data (0x64/0x60)
bit str1 dbu12		2	; Defined By User
bit str1 ibf1		1	; Input Buffer Full
bit str1 obf1		0	; Output Buffer Full

reg idr2		0xfe3c	; LPC Input Data Register 2 (0x62/0x66)
reg odr2		0xfe3d	; LPC Output Data Register 2 (0x62)
reg str2		0xfe3e	; LPC Status Register 2 (0x66)
bit str2 dbu27		7	; Defined By User
bit str2 smi_evt	6	; SMI Event Pending
bit str2 sci_evt	5	; SCI Event Pending
bit str2 burst		4	; Burst Mode For Polled Command Processing
bit str2 c_d2		3	; Command/-Data (0x66/0x62)
bit str2 dbu22		2	; Defined By User
bit str2 ibf2		1	; Input Buffer Full
bit str2 obf2		0	; Output Buffer Full

reg hisel		0xfe3f	; LPC Host Interface Select Register
bit hisel selstr3	7	; STR3 Register Function Select 3
bit hisel selirq11	6	; SERIRQ Output Select
bit hisel selirq10	5	; SERIRQ Output Select
bit hisel selirq9	4	; SERIRQ Output Select
bit hisel selirq6	3	; SERIRQ Output Select
bit hisel selsmi	2	; SERIRQ Output Select
bit hisel selirq12	1	; SERIRQ Output Select
bit hisel selirq1	0	; SERIRQ Output Select

reg hicr_0		0xfe40	; LPC Host Interface Control Register 0
bit hicr_0 lpc3e	7	; LPC Channel 3 Enable (LADR3)
bit hicr_0 lpc2e	6	; LPC Channel 2 Enable (0x62/0x66)
bit hicr_0 lpc1e	5	; LPC Channel 1 Enable (0x60/0x64)
bit hicr_0 fga20e	4	; Fast A20 Gate Function Enable
bit hicr_0 sdwne	3	; LPC Software Shutdown Enable
bit hicr_0 pmee		2	; PME Output Enable
bit hicr_0 lsmie	1	; LSMI Output Enable
bit hicr_0 lscie	0	; LSCI Output Enable

reg hicr_1		0xfe41	; LPC Host Interface Control Register 1
bit hicr_1 lpcbsy	7	; LPC Busy
bit hicr_1 clkreq	6	; LCLK Request
bit hicr_1 irqbsy	5	; SERIRQ Busy
bit hicr_1 lrstb	4	; LPC Software Reset Bit
bit hicr_1 sdwnb	3	; LPC Software Shutdown Bit
bit hicr_1 pmeb		2	; PME Output Bit
bit hicr_1 lsmib	1	; LSMI Output Bit
bit hicr_1 lscib	0	; LSCI Output Bit

reg hicr_2		0xfe42	; LPC Host Interface Control Register 2
bit hicr_2 ga20		7	; GA20 Pin Monitor
bit hicr_2 lrst		6	; LPC Reset Interrupt Flag
bit hicr_2 sdwn		5	; LPC Shutdown Interrupt Flag
bit hicr_2 abrt		4	; LPC Abort Interrupt Flag
bit hicr_2 ibfie3	3	; IDR3 & TWR Receive Completion Interrupt Enable
bit hicr_2 ibfie2	2	; IDR2 Receive Completion Interrupt Enable
bit hicr_2 ibfie1	1	; IDR1 Receive Completion Interrupt Enable
bit hicr_2 errie	0	; Error Interrupt Enable

reg hicr_3		0xfe43	; LPC Host Interface Control Register 3
bit hicr_3 lframe	7	; LFRAME Pin Monitor
bit hicr_3 clkrun	6	; CLKRUN Pin Monitor
bit hicr_3 serirq	5	; SERIRQ Pin Monitor
bit hicr_3 lreset	4	; LRESET Pin Monitor
bit hicr_3 lpcpd	3	; LPCPD Pin Monitor
bit hicr_3 pme		2	; PME Pin Monitor
bit hicr_3 lsmi		1	; LSMI Pin Monitor
bit hicr_3 lsci		0	; LSCI Pin Monitor

reg wuemrb		0xfe44	; Wake-Up Event Interrupt Mask Register
bit wuemrb wuemr7	7	; WUE7 Enable
bit wuemrb wuemr6	6	; WUE6 Enable
bit wuemrb wuemr5	5	; WUE5 Enable
bit wuemrb wuemr4	4	; WUE4 Enable
bit wuemrb wuemr3	3	; WUE3 Enable
bit wuemrb wuemr2	2	; WUE2 Enable
bit wuemrb wuemr1	1	; WUE1 Enable
bit wuemrb wuemr0	0	; WUE0 Enable

reg pgodr		0xfe46	; Port G Output Data Register
pin pgodr pg7odr	7	; Pin PG7
pin pgodr pg6odr	6	; Pin PG6
pin pgodr pg5odr	5	; Pin PG5
pin pgodr pg4odr	4	; Pin PG4
pin pgodr pg3odr	3	; Pin PG3
pin pgodr pg2odr	2	; Pin PG2
pin pgodr pg1odr	1	; Pin PG1
pin pgodr pg0odr	0	; Pin PG0

reg pgpin		0xfe47	; Port G Input Data Register
pin pgpin pg7pin	7	; Pin PG7
pin pgpin pg6pin	6	; Pin PG6
pin pgpin pg5pin	5	; Pin PG5
pin pgpin pg4pin	4	; Pin PG4
pin pgpin pg3pin	3	; Pin PG3
pin pgpin pg2pin	2	; Pin PG2
pin pgpin pg1pin	1	; Pin PG1
pin pgpin pg0pin	0	; Pin PG0
reg pgddr		0xfe47	; Port G Data Direction Register
pin pgddr pg7ddr	7	; Pin PG7
pin pgddr pg6ddr	6	; Pin PG6
pin pgddr pg5ddr	5	; Pin PG5
pin pgddr pg4ddr	4	; Pin PG4
pin pgddr pg3ddr	3	; Pin PG3
pin pgddr pg2ddr	2	; Pin PG2
pin pgddr pg1ddr	1	; Pin PG1
pin pgddr pg0ddr	0	; Pin PG0

reg peodr		0xfe48	; Port E Output Data Register
pin peodr pe7odr	7	; Pin PE7
pin peodr pe6odr	6	; Pin PE6
pin peodr pe5odr	5	; Pin PE5
pin peodr pe4odr	4	; Pin PE4
pin peodr pe3odr	3	; Pin PE3
pin peodr pe2odr	2	; Pin PE2
pin peodr pe1odr	1	; Pin PE1
pin peodr pe0odr	0	; Pin PE0

reg pfodr		0xfe49	; Port F Output Data Register
pin pfodr pf7odr	7	; Pin PF7
pin pfodr pf6odr	6	; Pin PF6
pin pfodr pf5odr	5	; Pin PF5
pin pfodr pf4odr	4	; Pin PF4
pin pfodr pf3odr	3	; Pin PF3
pin pfodr pf2odr	2	; Pin PF2
pin pfodr pf1odr	1	; Pin PF1
pin pfodr pf0odr	0	; Pin PF0

reg pepin		0xfe4a	; Port E Input Data Register
pin pepin pe7pin	7	; Pin PE7
pin pepin pe6pin	6	; Pin PE6
pin pepin pe5pin	5	; Pin PE5
pin pepin pe4pin	4	; Pin PE4
pin pepin pe3pin	3	; Pin PE3
pin pepin pe2pin	2	; Pin PE2
pin pepin pe1pin	1	; Pin PE1
pin pepin pe0pin	0	; Pin PE0
reg peddr		0xfe4a	; Port E Data Direction Register
pin peddr pe7ddr	7	; Pin PE7
pin peddr pe6ddr	6	; Pin PE6
pin peddr pe5ddr	5	; Pin PE5
pin peddr pe4ddr	4	; Pin PE4
pin peddr pe3ddr	3	; Pin PE3
pin peddr pe2ddr	2	; Pin PE2
pin peddr pe1ddr	1	; Pin PE1
pin peddr pe0ddr	0	; Pin PE0

reg pfpin		0xfe4b	; Port F Input Data Register
pin pfpin pf7pin	7	; Pin PF7
pin pfpin pf6pin	6	; Pin PF6
pin pfpin pf5pin	5	; Pin PF5
pin pfpin pf4pin	4	; Pin PF4
pin pfpin pf3pin	3	; Pin PF3
pin pfpin pf2pin	2	; Pin PF2
pin pfpin pf1pin	1	; Pin PF1
pin pfpin pf0pin	0	; Pin PF0
reg pfddr		0xfe4b	; Port F Data Direction Register
pin pfddr pf7ddr	7	; Pin PF7
pin pfddr pf6ddr	6	; Pin PF6
pin pfddr pf5ddr	5	; Pin PF5
pin pfddr pf4ddr	4	; Pin PF4
pin pfddr pf3ddr	3	; Pin PF3
pin pfddr pf2ddr	2	; Pin PF2
pin pfddr pf1ddr	1	; Pin PF1
pin pfddr pf0ddr	0	; Pin PF0

reg pcodr		0xfe4c	; Port C Output Data Register
pin pcodr pc7odr	7	; Pin PC7
pin pcodr pc6odr	6	; Pin PC6
pin pcodr pc5odr	5	; Pin PC5
pin pcodr pc4odr	4	; Pin PC4
pin pcodr pc3odr	3	; Pin PC3
pin pcodr pc2odr	2	; Pin PC2
pin pcodr pc1odr	1	; Pin PC1
pin pcodr pc0odr	0	; Pin PC0

reg pdodr		0xfe4d	; Port D Output Data Register
pin pdodr pd7odr	7	; Pin PD7
pin pdodr pd6odr	6	; Pin PD6
pin pdodr pd5odr	5	; Pin PD5
pin pdodr pd4odr	4	; Pin PD4
pin pdodr pd3odr	3	; Pin PD3
pin pdodr pd2odr	2	; Pin PD2
pin pdodr pd1odr	1	; Pin PD1
pin pdodr pd0odr	0	; Pin PD0

reg pcpin		0xfe4e	; Port C Input Data Register
pin pcpin pc7pin	7	; Pin PC7
pin pcpin pc6pin	6	; Pin PC6
pin pcpin pc5pin	5	; Pin PC5
pin pcpin pc4pin	4	; Pin PC4
pin pcpin pc3pin	3	; Pin PC3
pin pcpin pc2pin	2	; Pin PC2
pin pcpin pc1pin	1	; Pin PC1
pin pcpin pc0pin	0	; Pin PC0
reg pcddr		0xfe4e	; Port C Data Direction Register
pin pcddr pc7ddr	7	; Pin PC7
pin pcddr pc6ddr	6	; Pin PC6
pin pcddr pc5ddr	5	; Pin PC5
pin pcddr pc4ddr	4	; Pin PC4
pin pcddr pc3ddr	3	; Pin PC3
pin pcddr pc2ddr	2	; Pin PC2
pin pcddr pc1ddr	1	; Pin PC1
pin pcddr pc0ddr	0	; Pin PC0

reg pdpin		0xfe4f	; Port D Input Data Register
pin pdpin pd7pin	7	; Pin PD7
pin pdpin pd6pin	6	; Pin PD6
pin pdpin pd5pin	5	; Pin PD5
pin pdpin pd4pin	4	; Pin PD4
pin pdpin pd3pin	3	; Pin PD3
pin pdpin pd2pin	2	; Pin PD2
pin pdpin pd1pin	1	; Pin PD1
pin pdpin pd0pin	0	; Pin PD0
reg pdddr		0xfe4f	; Port D Data Direction Register
pin pdddr pd7ddr	7	; Pin PD7
pin pdddr pd6ddr	6	; Pin PD6
pin pdddr pd5ddr	5	; Pin PD5
pin pdddr pd4ddr	4	; Pin PD4
pin pdddr pd3ddr	3	; Pin PD3
pin pdddr pd2ddr	2	; Pin PD2
pin pdddr pd1ddr	1	; Pin PD1
pin pdddr pd0ddr	0	; Pin PD0

reg hicr2		0xfe80	; XBS Host Interface Control Register 2
bit hicr2 ibfie4	2	; Input Data Register Full Interrupt Enable 4
bit hicr2 ibfie3	1	; Input Data Register Full Interrupt Enable 3

reg idr_3		0xfe81	; XBS Input Data Register 3
reg odr_3		0xfe82	; XBS Output Data Register 3
reg str_3		0xfe83	; XBS Status Register 3
bit str_3 dbu37		7	; Defined By User
bit str_3 dbu36		6	; Defined By User
bit str_3 dbu35		5	; Defined By User
bit str_3 dbu34		4	; Defined By User
bit str_3 c_d3		3	; Command/-Data
bit str_3 dbu32		2	; Defined By User
bit str_3 ibf3		1	; Input Buffer Full
bit str_3 obf3		0	; Output Buffer Full

reg idr_4		0xfe84	; XBS Input Data Register 4
reg odr_4		0xfe85	; XBS Output Data Register 4
reg str_4		0xfe86	; XBS Status Register 4
bit str_4 dbu47		7	; Defined By User
bit str_4 dbu46		6	; Defined By User
bit str_4 dbu45		5	; Defined By User
bit str_4 dbu44		4	; Defined By User
bit str_4 c_d4		3	; Command/-Data
bit str_4 dbu42		2	; Defined By User
bit str_4 ibf4		1	; Input Buffer Full
bit str_4 obf4		0	; Output Buffer Full

reg icxr_0		0xfed4	; IIC_0 I2C Bus Extended Control Register
bit icxr_0 stopim	7	; Stop Condition Interrupt Source Mask
bit icxr_0 hnds		6	; Handshake Receive Operation Select
bit icxr_0 icdrf	5	; Receive Data Read Request Flag
bit icxr_0 icdre	4	; Transmit Data Write Request Flag
bit icxr_0 alie		3	; Arbitration Lost Interrupt Enable
bit icxr_0 alsl		2	; Arbitration Lost Condition Select
bit icxr_0 fnc1		1	; Function Restriction Bit 1
bit icxr_0 fnc0		0	; Function Restriction Bit 0

reg icxr_1		0xfed5	; IIC_1 I2C Bus Extended Control Register
bit icxr_1 stopim	7	; Stop Condition Interrupt Source Mask
bit icxr_1 hnds		6	; Handshake Receive Operation Select
bit icxr_1 icdrf	5	; Receive Data Read Request Flag
bit icxr_1 icdre	4	; Transmit Data Write Request Flag
bit icxr_1 alie		3	; Arbitration Lost Interrupt Enable
bit icxr_1 alsl		2	; Arbitration Lost Condition Select
bit icxr_1 fnc1		1	; Function Restriction Bit 1
bit icxr_1 fnc0		0	; Function Restriction Bit 0

reg kbcrh_0		0xfed8	; PS/2 Keyboard Control Register H Channel 0
bit kbcrh_0 kbioe	7	; Keyboard In/Out Enable
bit kbcrh_0 kclki	6	; Keyboard Clock In
bit kbcrh_0 kdi		5	; Keyboard Data In
bit kbcrh_0 kbfsel	4	; Keyboard Buffer Register Full Select
bit kbcrh_0 kbie	3	; Keyboard Interrupt Enable
bit kbcrh_0 kbf		2	; Keyboard Buffer Register Full
bit kbcrh_0 per		1	; Parity Error
bit kbcrh_0 kbs		0	; Keyboard Stop

reg kbcrl_0		0xfed9	; PS/2 Keyboard Control Register L Channel 0
bit kbcrl_0 kbe		7	; Keyboard Enable
bit kbcrl_0 kclko	6	; Keyboard Clock Out
bit kbcrl_0 kdo		5	; Keyboard Data Out
bit kbcrl_0 rxcr3	3	; Receive Counter 3
bit kbcrl_0 rxcr_2	2	; Receive Counter 2
bit kbcrl_0 rxcr_1	1	; Receive Counter 1
bit kbcrl_0 rxcr_0	0	; Receive Counter 0

reg kbbr_0		0xfeda	; PS/2 Keyboard Data Buffer Register Channel 0

reg kbcrh_1		0xfedc	; PS/2 Keyboard Control Register H Channel 1
bit kbcrh_1 kbioe	7	; Keyboard In/Out Enable
bit kbcrh_1 kclki	6	; Keyboard Clock In
bit kbcrh_1 kdi		5	; Keyboard Data In
bit kbcrh_1 kbfsel	4	; Keyboard Buffer Register Full Select
bit kbcrh_1 kbie	3	; Keyboard Interrupt Enable
bit kbcrh_1 kbf		2	; Keyboard Buffer Register Full
bit kbcrh_1 per		1	; Parity Error
bit kbcrh_1 kbs		0	; Keyboard Stop

reg kbcrl_1		0xfedd	; PS/2 Keyboard Control Register L Channel 1
bit kbcrl_1 kbe		7	; Keyboard Enable
bit kbcrl_1 kclko	6	; Keyboard Clock Out
bit kbcrl_1 kdo		5	; Keyboard Data Out
bit kbcrl_1 rxcr3	3	; Receive Counter 3
bit kbcrl_1 rxcr_2	2	; Receive Counter 2
bit kbcrl_1 rxcr_1	1	; Receive Counter 1
bit kbcrl_1 rxcr_0	0	; Receive Counter 0

reg kbbr_1		0xfede	; PS/2 Keyboard Data Buffer Register Channel 1

reg kbcrh_2		0xfee0	; PS/2 Keyboard Control Register H Channel 2
bit kbcrh_2 kbioe	7	; Keyboard In/Out Enable
bit kbcrh_2 kclki	6	; Keyboard Clock In
bit kbcrh_2 kdi		5	; Keyboard Data In
bit kbcrh_2 kbfsel	4	; Keyboard Buffer Register Full Select
bit kbcrh_2 kbie	3	; Keyboard Interrupt Enable
bit kbcrh_2 kbf		2	; Keyboard Buffer Register Full
bit kbcrh_2 per		1	; Parity Error
bit kbcrh_2 kbs		0	; Keyboard Stop

reg kbcrl_2		0xfee1	; PS/2 Keyboard Control Register L Channel 2
bit kbcrl_2 kbe		7	; Keyboard Enable
bit kbcrl_2 kclko	6	; Keyboard Clock Out
bit kbcrl_2 kdo		5	; Keyboard Data Out
bit kbcrl_2 rxcr3	3	; Receive Counter 3
bit kbcrl_2 rxcr_2	2	; Receive Counter 2
bit kbcrl_2 rxcr_1	1	; Receive Counter 1
bit kbcrl_2 rxcr_0	0	; Receive Counter 0

reg kbbr_2		0xfee2	; PS/2 Keyboard Data Buffer Register Channel 2

reg kbcomp		0xfee4	; Keyboard Comparator Control Register
bit kbcomp ire		7	; IrDA Enable
bit kbcomp ircks2	6	; IrDA Clock Select 2
bit kbcomp ircks1	5	; IrDA Clock Select 1
bit kbcomp ircks0	4	; IrDA Clock Select 0
bit kbcomp kbade	3	; Keyboard A/D Enable (AN6/AN7)
bit kbcomp kbch2	2	; Keyboard A/D Channel Select 2
bit kbcomp kbch1	1	; Keyboard A/D Channel Select 1
bit kbcomp kbch0	0	; Keyboard A/D Channel Select 0

reg ddcswr		0xfee6	; I2C DDC Switch Register
bit ddcswr swe		7	; IIC_0 DDC Automatic Format Mode Switch Enable
bit ddcswr sw		6	; IIC_0 DDC Format Mode Switch
bit ddcswr ie		5	; IIC_0 DDC Mode Switch Interrupt Enable Bit
bit ddcswr if		4	; IIC_0 DDC Mode Switch Interrupt Flag
bit ddcswr clr3		3	; IIC Clear 3
bit ddcswr clr2		2	; IIC Clear 2
bit ddcswr clr1		1	; IIC Clear 1
bit ddcswr clr0		0	; IIC Clear 0

reg icra		0xfee8	; Interrupt Control Register A
bit icra icra7		7	; IRQ0
bit icra icra6		6	; IRQ1
bit icra icra5		5	; IRQ2/IRQ3
bit icra icra4		4	; IRQ4/IRQ5
bit icra icra3		3	; IRQ6/IRQ7
bit icra icra2		2	; DTC
bit icra icra1		1	; WDT_0
bit icra icra0		0	; WDT_1

reg icrb		0xfee9	; Interrupt Control Register B
bit icrb icrb7		7	; A/D Converter
bit icrb icrb6		6	; FRT
bit icrb icrb3		3	; TMR_0
bit icrb icrb2		2	; TMR_1
bit icrb icrb1		1	; TMR_X , TMR_Y
bit icrb icrb0		0	; XBS/KBC

reg icrc		0xfeea	; Interrupt Control Register C
bit icrc icrc7		7	; SCI_0
bit icrc icrc6		6	; SCI_1
bit icrc icrc5		5	; SCI_2
bit icrc icrc4		4	; IIC_0
bit icrc icrc3		3	; IIC_0
bit icrc icrc1		1	; LPCH

reg isr			0xfeeb	; IRQ Status Register
bit isr irq7f		7	; IRQ7 Flag
bit isr irq6f		6	; IRQ6 Flag
bit isr irq5f		5	; IRQ5 Flag
bit isr irq4f		4	; IRQ4 Flag
bit isr irq3f		3	; IRQ3 Flag
bit isr irq2f		2	; IRQ2 Flag
bit isr irq1f		1	; IRQ1 Flag
bit isr irq0f		0	; IRQ0 Flag

reg iscrh		0xfeec	; IRQ Sense Control Register H
bit iscrh irq7scb	7	; IRQ7 Sense Control B
bit iscrh irq7sca	6	; IRQ7 Sense Control A
bit iscrh irq6scb	5	; IRQ6 Sense Control B
bit iscrh irq6sca	4	; IRQ6 Sense Control A
bit iscrh irq5scb	3	; IRQ5 Sense Control B
bit iscrh irq5sca	2	; IRQ5 Sense Control A
bit iscrh irq4scb	1	; IRQ4 Sense Control B
bit iscrh irq4sca	0	; IRQ4 Sense Control A

reg iscrl		0xfeed	; IRQ Sense Control Register L
bit iscrl irq3scb	7	; IRQ3 Sense Control B
bit iscrl irq3sca	6	; IRQ3 Sense Control A
bit iscrl irq2scb	5	; IRQ2 Sense Control B
bit iscrl irq2sca	4	; IRQ2 Sense Control A
bit iscrl irq1scb	3	; IRQ1 Sense Control B
bit iscrl irq1sca	2	; IRQ1 Sense Control A
bit iscrl irq0scb	1	; IRQ0 Sense Control B
bit iscrl irq0sca	0	; IRQ0 Sense Control A

reg dtcera		0xfeee	; DTC Enable Register A
bit dtcera dtcea7	7	; IRQ0 DTC Activation Enable
bit dtcera dtcea6	6	; IRQ1 DTC Activation Enable
bit dtcera dtcea5	5	; IRQ2 DTC Activation Enable
bit dtcera dtcea4	4	; IRQ3 DTC Activation Enable
bit dtcera dtcea3	3	; ADI DTC Activation Enable
bit dtcera dtcea2	2	; FRT ICIA DTC Activation Enable
bit dtcera dtcea1	1	; FRT ICIB DTC Activation Enable
bit dtcera dtcea0	0	; FRT OCIA DTC Activation Enable

reg dtcerb		0xfeef	; DTC Enable Register B
bit dtcerb dtceb7	7	; FRT OCIB DTC Activation Enable
bit dtcerb dtceb2	2	; TMR_0 CMIA0 DTC Activation Enable
bit dtcerb dtceb1	1	; TMR_0 CMIB0 DTC Activation Enable
bit dtcerb dtceb0	0	; TMR_1 CMIA1 DTC Activation Enable

reg dtcerc		0xfef0	; DTC Enable Register C
bit dtcerc dtcec7	7	; TMR_1 CMIB1 DTC Activation Enable
bit dtcerc dtcec6	6	; TMR_Y CMIAY DTC Activation Enable
bit dtcerc dtcec5	5	; TMR_Y CMIBY DTC Activation Enable
bit dtcerc dtcec4	4	; XBS IBF1 DTC Activation Enable
bit dtcerc dtcec3	3	; XBS IBF2 DTC Activation Enable
bit dtcerc dtcec2	2	; SCI_0 RXI0 DTC Activation Enable
bit dtcerc dtcec1	1	; SCI_0 TXI0 DTC Activation Enable
bit dtcerc dtcec0	0	; SCI_1 RXI1 DTC Activation Enable

reg dtcerd		0xfef1	; DTC Enable Register D
bit dtcerd dtced7	7	; SCI_1 TXI1 DTC Activation Enable
bit dtcerd dtced6	6	; SCI_2 RXI2 DTC Activation Enable
bit dtcerd dtced5	5	; SCI_2 TXI2 DTC Activation Enable
bit dtcerd dtced4	4	; IIC_0 IICI0 DTC Activation Enable
bit dtcerd dtced3	3	; IIC_1 IICI1 DTC Activation Enable

reg dtcere		0xfef2	; DTC Enable Register E
bit dtcere dtcee3	3	; LPC ERRI DTC Activation Enable
bit dtcere dtcee2	2	; LPC IBFI1 DTC Activation Enable
bit dtcere dtcee1	1	; LPC IBFI2 DTC Activation Enable
bit dtcere dtcee0	0	; LPC IBFI3 DTC Activation Enable

reg dtvecr		0xfef3	; DTC Vector Register
bit dtvecr swdte	7	; DTC Software Activation Enable
bit dtvecr dtvec6	6	; DTC Software Activation Vector 6
bit dtvecr dtvec5	5	; DTC Software Activation Vector 5
bit dtvecr dtvec4	4	; DTC Software Activation Vector 4
bit dtvecr dtvec3	3	; DTC Software Activation Vector 3
bit dtvecr dtvec2	2	; DTC Software Activation Vector 2
bit dtvecr dtvec1	1	; DTC Software Activation Vector 1
bit dtvecr dtvec0	0	; DTC Software Activation Vector 0

reg abrkcr		0xfef4	; Address Break Control Register
bit abrkcr cmf		7	; Condition Match Flag
bit abrkcr bie		0	; Break Interrupt Enable

reg bara		0xfef5	; Break Address Register A
reg barb		0xfef6	; Break Address Register B
reg barc		0xfef7	; Break Address Register C

reg flmcr1		0xff80	; Flash Memory Control Register 1
bit flmcr1 fwe		7	; Flash Write Enable
bit flmcr1 swe		6	; Software Write Enable
bit flmcr1 ev		3	; Erase-Verify
bit flmcr1 pv		2	; Program-Verify
bit flmcr1 e		1	; Erase
bit flmcr1 p		0	; Program

reg flmcr2		0xff81	; Flash Memory Control Register 2
bit flmcr2 fler		7	; Flash Memory Error
bit flmcr2 esu		1	; Erase Setup
bit flmcr2 psu		0	; Program Setup

reg pcsr		0xff82	; PWM Peripheral Clock Select Register
bit pcsr pwckb		2	; PWM Clock Select B
bit pcsr pwcka		1	; PWM Clock Select A
reg ebr1		0xff82	; Flash Erase Block Register 1
bit ebr1 eb9		1	; 0x018000..0x01ffff
bit ebr1 eb8		0	; 0x010000..0x017fff

reg syscr2		0xff83	; System Control Register 2
bit syscr2 kwul1	7	; Port 6 Key Wakeup Level 1
bit syscr2 kwul0	6	; Port 6 Key Wakeup Level 0
bit syscr2 p6pue	5	; Port 6 Input Pull-Up MOS Extra
bit syscr2 sde		3	; XBS Host Interface Shutdown Enable
bit syscr2 cs4e		2	; XBS CS4 Enable
bit syscr2 cs3e		1	; XBS CS3 Enable
bit syscr2 hi12e	0	; XBS Host Interface Enable Bit
reg ebr2		0xff83	; Flash Erase Block Register 2
bit ebr2 eb7		7	; 0x00e000..0x00ffff
bit ebr2 eb6		6	; 0x00c000..0x00dfff
bit ebr2 eb5		5	; 0x008000..0x00bfff
bit ebr2 eb4		4	; 0x001000..0x007fff
bit ebr2 eb3		3	; 0x000c00..0x000fff
bit ebr2 eb2		2	; 0x000800..0x000bff
bit ebr2 eb1		1	; 0x000400..0x0007ff
bit ebr2 eb0		0	; 0x000000..0x0003ff

reg sbycr		0xff84	; Standby Control Register
bit sbycr ssby		7	; Software Standby
bit sbycr sts2		6	; Standby Timer Select 2
bit sbycr sts1		5	; Standby Timer Select 1
bit sbycr sts0		4	; Standby Timer Select 0
bit sbycr sck2		2	; System Clock Select 2
bit sbycr sck1		1	; System Clock Select 1
bit sbycr sck0		0	; System Clock Select 0

reg lpwrcr		0xff85	; Low-Power Control Register
bit lpwrcr dton		7	; Direct Transfer On Flag
bit lpwrcr lson		6	; Low-Speed On Flag
bit lpwrcr nesel	5	; Noise Elimination Sampling Frequency Select
bit lpwrcr excle	4	; Subclock Input Enable

reg mstpcrh		0xff86	; Module Stop Control Register H
bit mstpcrh mstp15	7	; -
bit mstpcrh mstp14	6	; DTC
bit mstpcrh mstp13	5	; FRT
bit mstpcrh mstp12	4	; TMR_0, TMR_1
bit mstpcrh mstp11	3	; PWM, PWMX
bit mstpcrh mstp10	2	; D/A
bit mstpcrh mstp9	1	; A/D
bit mstpcrh mstp8	0	; TMR_X, TMR_Y

reg mstpcrl		0xff87	; Module Stop Control Register L
bit mstpcrl mstp7	7	; SCI_0
bit mstpcrl mstp6	6	; SCI_1
bit mstpcrl mstp5	5	; SCI_2
bit mstpcrl mstp4	4	; IIC_0
bit mstpcrl mstp3	3	; IIC_1
bit mstpcrl mstp2	2	; XBS, KMIMR, KMIMRA, KMPCR
bit mstpcrl mstp1	1	; -
bit mstpcrl mstp0	0	; LPC, WUEMRB

reg smr_1		0xff88	; SCI_1 Serial Mode Register
bit smr_1 c_a		7	; Clocked/-Asynchronous Communication Mode 
bit smr_1 chr		6	; Character Length
bit smr_1 pe		5	; Parity Enable
bit smr_1 o_e		4	; Odd/-Even Parity Mode
bit smr_1 stop		3	; Stop Bit Length
bit smr_1 mp		2	; Multiprocessor Mode
bit smr_1 cks1		1	; Clock Select 1
bit smr_1 cks0		0	; Clock Select 0
reg iccr_1		0xff88	; IIC_1 I2C Bus Control Register
bit iccr_1 ice		7	; I2C Bus Interface Enable
bit iccr_1 ieic		6	; I2C Bus Interface Interrupt Enable
bit iccr_1 mst		5	; Master/Slave Select
bit iccr_1 trs		4	; Transmit/Receive Select
bit iccr_1 acke		3	; Acknowledge Bit Decision and Selection
bit iccr_1 bbsy		2	; Bus Busy
bit iccr_1 iric		1	; I2C Bus Interface Interrupt Request Flag
bit iccr_1 scp		0	; Start Condition/Stop Condition Prohibit

reg brr_1		0xff89	; SCI_1 Bit Rate Register
reg icsr_1		0xff89	; IIC_1 I2C Bus Status Register
bit icsr_1 estp		7	; Error Stop Condition Detection Flag
bit icsr_1 stop		6	; Normal Stop Condition Detection Flag
bit icsr_1 irtr		5	; Continuous Transfer Interrupt Request Flag
bit icsr_1 aasx		4	; Second Slave Address Recognition Flag
bit icsr_1 al		3	; Arbitration Lost Flag
bit icsr_1 aas		2	; Slave Address Recognition Flag
bit icsr_1 adz		1	; General Call Address Recognition Flag
bit icsr_1 ackb		0	; Acknowledge Bit

reg scr_1		0xff8a	; SCI_1 Serial Control Register
bit scr_1 tie		7	; Transmit Interrupt Enable
bit scr_1 rie		6	; Receive Interrupt Enable
bit scr_1 te		5	; Transmit Enable
bit scr_1 re		4	; Receive Enable
bit scr_1 mpie		3	; Multiprocessor Interrupt Enable
bit scr_1 teie		2	; Transmit End Interrupt Enable
bit scr_1 cke1		1	; Clock Enable 1 (External/-Internal)
bit scr_1 cke0		0	; Clock Enable 0 (SCK Mode)

reg tdr_1		0xff8b	; SCI_1 Transmit Data Register

reg ssr_1		0xff8c	; SCI_1 Serial Status Register
bit ssr_1 tdre		7	; Transmit Data Register Empty
bit ssr_1 rdrf		6	; Receive Data Register Full
bit ssr_1 orer		5	; Overrun Error
bit ssr_1 fer		4	; Framing Error
bit ssr_1 per		3	; Parity Error
bit ssr_1 tend		2	; Transmit End
bit ssr_1 mpb		1	; Multiprocessor Bit
bit ssr_1 mpbt		0	; Multiprocessor Bit Transfer

reg rdr_1		0xff8d	; SCI_1 Receive Data Register

reg scmr_1		0xff8e	; SCI_1 Serial Interface Mode Register
bit scmr_1 sdir		3	; Data Transfer Direction
bit scmr_1 sinv		2	; Data Invert
bit scmr_1 smif		0	; Serial Communication Interface Mode Select
reg icdr_1		0xff8e	; IIC_1 I2C Bus Data Register
reg sarx_1		0xff8e	; IIC_1 I2C Second Slave Address Register
bit sarx_1 svax6	7	; Second Slave Address 6
bit sarx_1 svax5	6	; Second Slave Address 5
bit sarx_1 svax4	5	; Second Slave Address 4
bit sarx_1 svax3	4	; Second Slave Address 3
bit sarx_1 svax2	3	; Second Slave Address 2
bit sarx_1 svax1	2	; Second Slave Address 1
bit sarx_1 svax0	1	; Second Slave Address 0
bit sarx_1 fsx		0	; Format Select X

reg icmr_1		0xff8f	; IIC_1 I2C Bus Mode Register
bit icmr_1 mls		7	; _MSB-First/LSB-First Select
bit icmr_1 wait		6	; Wait Insertion Bit
bit icmr_1 cks2		5	; Transfer Clock Select 2
bit icmr_1 cks1		4	; Transfer Clock Select 1
bit icmr_1 cks0		3	; Transfer Clock Select 0
bit icmr_1 bc2		2	; Bit Counter 2
bit icmr_1 bc1		1	; Bit Counter 1
bit icmr_1 bc0		0	; Bit Counter 0
reg sar_1		0xff8f	; IIC_1 I2C Slave Address Register
bit sar_1 sva6		7	; Slave Address 6
bit sar_1 sva5		6	; Slave Address 5
bit sar_1 sva4		5	; Slave Address 4
bit sar_1 sva3		4	; Slave Address 3
bit sar_1 sva2		3	; Slave Address 2
bit sar_1 sva1		2	; Slave Address 1
bit sar_1 sva0		1	; Slave Address 0
bit sar_1 fs		0	; Format Select

reg tier		0xff90	; FRT Timer Interrupt Enable Register
bit tier iciae		7	; Input Capture Interrupt A Enable
bit tier icibe		6	; Input Capture Interrupt B Enable
bit tier icice		5	; Input Capture Interrupt C Enable
bit tier icide		4	; Input Capture Interrupt D Enable
bit tier ociae		3	; Output Compare Interrupt A Enable
bit tier ocibe		2	; Output Compare Interrupt B Enable
bit tier ovie		1	; Timer Overflow Interrupt Enable

reg tcsr		0xff91	; FRT Timer Control/Status Register
bit tcsr icfa		7	; Input Capture Flag A
bit tcsr icfb		6	; Input Capture Flag B
bit tcsr icfc		5	; Input Capture Flag C
bit tcsr icfd		4	; Input Capture Flag D
bit tcsr ocfa		3	; Output Compare Flag A
bit tcsr ocfb		2	; Output Compare Flag B
bit tcsr ovf		1	; Timer Overflow
bit tcsr cclra		0	; Counter Clear A

reg frc			0xff92	; FRT Free-Running Counter
reg ocra		0xff94	; FRT Output Compare Register A
reg ocrb		0xff94	; FRT Output Compare Register B

reg tcr			0xff96	; FRT Timer Control Register
bit tcr iedga		7	; Input Edge Select A
bit tcr iedgb		6	; Input Edge Select B
bit tcr iedgc		5	; Input Edge Select C
bit tcr iedgd		4	; Input Edge Select D
bit tcr bufea		3	; Buffer Enable A
bit tcr bufeb		2	; Buffer Enable B
bit tcr cks1		1	; Clock Select 1
bit tcr cks0		0	; Clock Select 0

reg tocr		0xff97	; FRT Timer Output Compare Control Register
bit tocr icrdms		7	; Input Capture D Mode Select
bit tocr ocrams		6	; Output Compare A Mode Select
bit tocr icrs		5	; Input Capture Register Select
bit tocr ocrs		4	; Output Compare Register Select
bit tocr oea		3	; Output Enable A
bit tocr oeb		2	; Output Enable B
bit tocr olvla		1	; Output Level A
bit tocr olvlb		0	; Output Level B

reg icral		0xff98	; FRT Input Capture Register A
reg ocrarl		0xff98	; Output Compare Register AR
reg icrbl		0xff9a	; FRT Input Capture Register B
reg ocrafl		0xff9a	; Output Compare Register AF
reg icrcl		0xff9c	; FRT Input Capture Register C
reg ocrdml		0xff9c	; Output Compare Register DM
reg icrdl		0xff9e	; FRT Input Capture Register D

reg smr_2		0xffa0	; SCI_2 Serial Mode Register
bit smr_2 c_a		7	; Clocked/-Asynchronous Communication Mode 
bit smr_2 chr		6	; Character Length
bit smr_2 pe		5	; Parity Enable
bit smr_2 o_e		4	; Odd/-Even Parity Mode
bit smr_2 stop		3	; Stop Bit Length
bit smr_2 mp		2	; Multiprocessor Mode
bit smr_2 cks1		1	; Clock Select 1
bit smr_2 cks0		0	; Clock Select 0
reg dacrx		0xffa0	; PWMX (D/A) Control Register
bit dacrx test		7	; Test Mode
bit dacrx pwme		6	; PWM Enable
bit dacrx oeb		3	; Output Enable B
bit dacrx oea		2	; Output Enable A
bit dacrx os		1	; Output Select
bit dacrx cks		0	; Clock Select
reg dadra		0xffa0	; PWMX (D/A) Data Register A
reg brr_2		0xffa1	; SCI_2 Bit Rate Register

reg scr_2		0xffa2	; SCI_2 Serial Control Register
bit scr_2 tie		7	; Transmit Interrupt Enable
bit scr_2 rie		6	; Receive Interrupt Enable
bit scr_2 te		5	; Transmit Enable
bit scr_2 re		4	; Receive Enable
bit scr_2 mpie		3	; Multiprocessor Interrupt Enable
bit scr_2 teie		2	; Transmit End Interrupt Enable
bit scr_2 cke1		1	; Clock Enable 1 (External/-Internal)
bit scr_2 cke0		0	; Clock Enable 0 (SCK Mode)

reg tdr_2		0xffa3	; SCI_2 Transmit Data Register

reg ssr_2		0xffa4	; SCI_2 Serial Status Register
bit ssr_2 tdre		7	; Transmit Data Register Empty
bit ssr_2 rdrf		6	; Receive Data Register Full
bit ssr_2 orer		5	; Overrun Error
bit ssr_2 fer		4	; Framing Error
bit ssr_2 per		3	; Parity Error
bit ssr_2 tend		2	; Transmit End
bit ssr_2 mpb		1	; Multiprocessor Bit
bit ssr_2 mpbt		0	; Multiprocessor Bit Transfer

reg rdr_2		0xffa5	; SCI_2 Receive Data Register

reg scmr_2		0xffa6	; SCI_2 Serial Interface Mode Register
bit scmr_2 sdir		3	; Data Transfer Direction
bit scmr_2 sinv		2	; Data Invert
bit scmr_2 smif		0	; Serial Communication Interface Mode Select
reg dacnth		0xffa6	; PWMX (D/A) Counter
reg dadrbh		0xffa6	; PWMX (D/A) Data Register B

reg wtcsr_0		0xffa8	; WDT_0 Watchdog Timer Control & Status Register
bit wtcsr_0 ovf		7	; Overflow Flag
bit wtcsr_0 wt_it	6	; Timer Mode Select
bit wtcsr_0 tme		5	; Timer Enable
bit wtcsr_0 rst_nmi	3	; Reset or NMI
bit wtcsr_0 cks2	2	; Clock Select 2
bit wtcsr_0 cks1	1	; Clock Select 1
bit wtcsr_0 cks0	0	; Clock Select 0

reg wtcnt_0		0xffa9	; WDT_0 Watchdog Timer Counter

reg paodr		0xffaa	; Port A Output Data Register
pin paodr pa7odr	7	; Pin PA7/-KIN15/CIN15/PS2CD
pin paodr pa6odr	6	; Pin PA6/-KIN14/CIN14/PS2CC
pin paodr pa5odr	5	; Pin PA5/-KIN13/CIN13/PS2BD
pin paodr pa4odr	4	; Pin PA4/-KIN12/CIN12/PS2BC
pin paodr pa3odr	3	; Pin PA3/-KIN11/CIN11/PS2AD
pin paodr pa2odr	2	; Pin PA2/-KIN10/CIN10/PS2AC
pin paodr pa1odr	1	; Pin PA1/-KIN9/CIN9
pin paodr pa0odr	0	; Pin PA0/-KIN8/CIN8

reg papin		0xffab	; Port A Input Data Register
pin papin pa7pin	7	; Pin PA7/-KIN15/CIN15/PS2CD
pin papin pa6pin	6	; Pin PA6/-KIN14/CIN14/PS2CC
pin papin pa5pin	5	; Pin PA5/-KIN13/CIN13/PS2BD
pin papin pa4pin	4	; Pin PA4/-KIN12/CIN12/PS2BC
pin papin pa3pin	3	; Pin PA3/-KIN11/CIN11/PS2AD
pin papin pa2pin	2	; Pin PA2/-KIN10/CIN10/PS2AC
pin papin pa1pin	1	; Pin PA1/-KIN9/CIN9
pin papin pa0pin	0	; Pin PA0/-KIN8/CIN8
reg paddr		0xffab	; Port A Data Direction Register
pin paddr pa7ddr	7	; Pin PA7/-KIN15/CIN15/PS2CD
pin paddr pa6ddr	6	; Pin PA6/-KIN14/CIN14/PS2CC
pin paddr pa5ddr	5	; Pin PA5/-KIN13/CIN13/PS2BD
pin paddr pa4ddr	4	; Pin PA4/-KIN12/CIN12/PS2BC
pin paddr pa3ddr	3	; Pin PA3/-KIN11/CIN11/PS2AD
pin paddr pa2ddr	2	; Pin PA2/-KIN10/CIN10/PS2AC
pin paddr pa1ddr	1	; Pin PA1/-KIN9/CIN9
pin paddr pa0ddr	0	; Pin PA0/-KIN8/CIN8

reg p1pcr		0xffac	; Port 1 Pull-Up MOS Control Register
pin p1pcr p17pcr	7	; Pin P17/PW7
pin p1pcr p16pcr	6	; Pin P16/PW6
pin p1pcr p15pcr	5	; Pin P15/PW5
pin p1pcr p14pcr	4	; Pin P14/PW4
pin p1pcr p13pcr	3	; Pin P13/PW3
pin p1pcr p12pcr	2	; Pin P12/PW2
pin p1pcr p11pcr	1	; Pin P11/PW1
pin p1pcr p10pcr	0	; Pin P10/PW0

reg p2pcr		0xffad	; Port 2 Pull-Up MOS Control Register
pin p2pcr p27pcr	7	; Pin P27/PW15/CBLANK
pin p2pcr p26pcr	6	; Pin P26/PW14
pin p2pcr p25pcr	5	; Pin P25/PW13
pin p2pcr p24pcr	4	; Pin P24/PW12
pin p2pcr p23pcr	3	; Pin P23/PW11
pin p2pcr p22pcr	2	; Pin P22/PW10
pin p2pcr p21pcr	1	; Pin P21/PW9
pin p2pcr p20pcr	0	; Pin P20/PW8

reg p3pcr		0xffae	; Port 3 Pull-Up MOS Control Register
pin p3pcr p37pcr	7	; Pin P37/HDB7/SERIRQ
pin p3pcr p36pcr	6	; Pin P36/HDB6/LCLK
pin p3pcr p35pcr	5	; Pin P35/HDB5/-LRESET
pin p3pcr p34pcr	4	; Pin P34/HDB4/-LFRAME
pin p3pcr p33pcr	3	; Pin P33/HDB3/LAD3
pin p3pcr p32pcr	2	; Pin P32/HDB2/LAD2
pin p3pcr p31pcr	1	; Pin P31/HDB1/LAD1
pin p3pcr p30pcr	0	; Pin P30/HDB0/LAD0

reg p1ddr		0xffb0	; Port 1 Data Direction Register
pin p1ddr p17ddr	7	; Pin P17/PW7
pin p1ddr p16ddr	6	; Pin P16/PW6
pin p1ddr p15ddr	5	; Pin P15/PW5
pin p1ddr p14ddr	4	; Pin P14/PW4
pin p1ddr p13ddr	3	; Pin P13/PW3
pin p1ddr p12ddr	2	; Pin P12/PW2
pin p1ddr p11ddr	1	; Pin P11/PW1
pin p1ddr p10ddr	0	; Pin P10/PW0

reg p2ddr		0xffb1	; Port 2 Data Direction Register
pin p2ddr p27ddr	7	; Pin P27/PW15/CBLANK
pin p2ddr p26ddr	6	; Pin P26/PW14
pin p2ddr p25ddr	5	; Pin P25/PW13
pin p2ddr p24ddr	4	; Pin P24/PW12
pin p2ddr p23ddr	3	; Pin P23/PW11
pin p2ddr p22ddr	2	; Pin P22/PW10
pin p2ddr p21ddr	1	; Pin P21/PW9
pin p2ddr p20ddr	0	; Pin P20/PW8

reg p1dr		0xffb2	; Port 1 Data Register
pin p1dr p17dr		7	; Pin P17/PW7
pin p1dr p16dr		6	; Pin P16/PW6
pin p1dr p15dr		5	; Pin P15/PW5
pin p1dr p14dr		4	; Pin P14/PW4
pin p1dr p13dr		3	; Pin P13/PW3
pin p1dr p12dr		2	; Pin P12/PW2
pin p1dr p11dr		1	; Pin P11/PW1
pin p1dr p10dr		0	; Pin P10/PW0

reg p2dr		0xffb3	; Port 2 Data Register
pin p2dr p27dr		7	; Pin P27/PW15/CBLANK
pin p2dr p26dr		6	; Pin P26/PW14
pin p2dr p25dr		5	; Pin P25/PW13
pin p2dr p24dr		4	; Pin P24/PW12
pin p2dr p23dr		3	; Pin P23/PW11
pin p2dr p22dr		2	; Pin P22/PW10
pin p2dr p21dr		1	; Pin P21/PW9
pin p2dr p20dr		0	; Pin P20/PW8

reg p3ddr		0xffb4	; Port 3 Data Direction Register
pin p3ddr p37ddr	7	; Pin P37/HDB7/SERIRQ
pin p3ddr p36ddr	6	; Pin P36/HDB6/LCLK
pin p3ddr p35ddr	5	; Pin P35/HDB5/-LRESET
pin p3ddr p34ddr	4	; Pin P34/HDB4/-LFRAME
pin p3ddr p33ddr	3	; Pin P33/HDB3/LAD3
pin p3ddr p32ddr	2	; Pin P32/HDB2/LAD2
pin p3ddr p31ddr	1	; Pin P31/HDB1/LAD1
pin p3ddr p30ddr	0	; Pin P30/HDB0/LAD0

reg p4ddr		0xffb5	; Port 4 Data Direction Register
pin p4ddr p47ddr	7	; Pin P47/PWX1
pin p4ddr p46ddr	6	; Pin P46/PWX0
pin p4ddr p45ddr	5	; Pin P45/TMRI1/HIRQ12/CSYNCI
pin p4ddr p44ddr	4	; Pin P44/TMO1/HIRQ1/HSYNCO
pin p4ddr p43ddr	3	; Pin P43/TMCI1/HIRQ11/HSYNCI
pin p4ddr p42ddr	2	; Pin P42/TMRI0/SCK2/SDA1
pin p4ddr p41ddr	1	; Pin P41/TMO0/RxD2/IrRxD
pin p4ddr p40ddr	0	; Pin P40/TMCI0/TxD2/IrTxD

reg p3dr		0xffb6	; Port 3 Data Register
pin p3dr p37dr		7	; Pin P37/HDB7/SERIRQ
pin p3dr p36dr		6	; Pin P36/HDB6/LCLK
pin p3dr p35dr		5	; Pin P35/HDB5/-LRESET
pin p3dr p34dr		4	; Pin P34/HDB4/-LFRAME
pin p3dr p33dr		3	; Pin P33/HDB3/LAD3
pin p3dr p32dr		2	; Pin P32/HDB2/LAD2
pin p3dr p31dr		1	; Pin P31/HDB1/LAD1
pin p3dr p30dr		0	; Pin P30/HDB0/LAD0

reg p4dr		0xffb7	; Port 4 Data Register
pin p4dr p47dr		7	; Pin P47/PWX1
pin p4dr p46dr		6	; Pin P46/PWX0
pin p4dr p45dr		5	; Pin P45/TMRI1/HIRQ12/CSYNCI
pin p4dr p44dr		4	; Pin P44/TMO1/HIRQ1/HSYNCO
pin p4dr p43dr		3	; Pin P43/TMCI1/HIRQ11/HSYNCI
pin p4dr p42dr		2	; Pin P42/TMRI0/SCK2/SDA1
pin p4dr p41dr		1	; Pin P41/TMO0/RxD2/IrRxD
pin p4dr p40dr		0	; Pin P40/TMCI0/TxD2/IrTxD

reg p5ddr		0xffb8	; Port 5 Data Direction Register
pin p5ddr p57ddr	7	; -
pin p5ddr p56ddr	6	; -
pin p5ddr p55ddr	5	; -
pin p5ddr p54ddr	4	; -
pin p5ddr p53ddr	3	; -
pin p5ddr p52ddr	2	; Pin P52/SCK0/SCL0
pin p5ddr p51ddr	1	; Pin P51/RxD0
pin p5ddr p50ddr	0	; Pin P50/TxD0

reg p6ddr		0xffb9	; Port 6 Data Direction Register
pin p6ddr p67ddr	7	; Pin P67/-IRQ7/TMOX/-KIN7/CIN7
pin p6ddr p66ddr	6	; Pin P66/-IRQ6/FTOB/-KIN6/CIN6
pin p6ddr p65ddr	5	; Pin P65/FTID/-KIN5/CIN5
pin p6ddr p64ddr	4	; Pin P64/FTIC/-KIN4/CIN4/CLAMPO
pin p6ddr p63ddr	3	; Pin P63/FTIB/-KIN3/CIN3/VFBACKI
pin p6ddr p62ddr	2	; Pin P62/FTIA/TMIY/-KIN2/CIN2/VSYNCI
pin p6ddr p61ddr	1	; Pin P61/FTOA/-KIN1/CIN1/VSYNCO
pin p6ddr p60ddr	0	; Pin P60/FTCI/TMIX/-KIN0/CIN0/HFBACKI

reg p5dr		0xffba	; Port 5 Data Register
pin p5dr p57dr		7	; -
pin p5dr p56dr		6	; -
pin p5dr p55dr		5	; -
pin p5dr p54dr		4	; -
pin p5dr p53dr		3	; -
pin p5dr p52dr		2	; Pin P52/SCK0/SCL0
pin p5dr p51dr		1	; Pin P51/RxD0
pin p5dr p50dr		0	; Pin P50/TxD0

reg p6dr		0xffbb	; Port 6 Data Register
pin p6dr p67dr		7	; Pin P67/-IRQ7/TMOX/-KIN7/CIN7
pin p6dr p66dr		6	; Pin P66/-IRQ6/FTOB/-KIN6/CIN6
pin p6dr p65dr		5	; Pin P65/FTID/-KIN5/CIN5
pin p6dr p64dr		4	; Pin P64/FTIC/-KIN4/CIN4/CLAMPO
pin p6dr p63dr		3	; Pin P63/FTIB/-KIN3/CIN3/VFBACKI
pin p6dr p62dr		2	; Pin P62/FTIA/TMIY/-KIN2/CIN2/VSYNCI
pin p6dr p61dr		1	; Pin P61/FTOA/-KIN1/CIN1/VSYNCO
pin p6dr p60dr		0	; Pin P60/FTCI/TMIX/-KIN0/CIN0/HFBACKI

reg pbodr		0xffbc	; Port B Output Data Register
pin pbodr pb7odr	7	; Pin PB7/-WUE7
pin pbodr pb6odr	6	; Pin PB6/-WUE6
pin pbodr pb5odr	5	; Pin PB5/-WUE5
pin pbodr pb4odr	4	; Pin PB4/-WUE4
pin pbodr pb3odr	3	; Pin PB3/-WUE3/-CS4
pin pbodr pb2odr	2	; Pin PB2/-WUE2/-CS3
pin pbodr pb1odr	1	; Pin PB1/-WUE1/HIRQ4/LSCI
pin pbodr pb0odr	0	; Pin PB0/-WUE0/HIRQ3/-LSMI

reg pbpin		0xffbd	; Port B Input Data Register
pin pbpin pb7pin	7	; Pin PB7/-WUE7
pin pbpin pb6pin	6	; Pin PB6/-WUE6
pin pbpin pb5pin	5	; Pin PB5/-WUE5
pin pbpin pb4pin	4	; Pin PB4/-WUE4
pin pbpin pb3pin	3	; Pin PB3/-WUE3/-CS4
pin pbpin pb2pin	2	; Pin PB2/-WUE2/-CS3
pin pbpin pb1pin	1	; Pin PB1/-WUE1/HIRQ4/LSCI
pin pbpin pb0pin	0	; Pin PB0/-WUE0/HIRQ3/-LSMI
reg p8ddr		0xffbd	; Port 8 Data Direction Register
pin p8ddr p87ddr	7	; -
pin p8ddr p86ddr	6	; Pin P86/-IRQ5/SCK1/SCL1
pin p8ddr p85ddr	5	; Pin P85/-IRQ4/RxD1
pin p8ddr p84ddr	4	; Pin P84/-IRQ3/TxD1
pin p8ddr p83ddr	3	; Pin P83/-LPCPD
pin p8ddr p82ddr	2	; Pin P82/HIFSD/-CLKRUN
pin p8ddr p81ddr	1	; Pin P81/-CS2/GA20
pin p8ddr p80ddr	0	; Pin P80/HA0/-PME

reg p7pin		0xffbe	; Port 7 Input Data Register
pin p7pin p77pin	7	; Pin P77/AN7/DA1
pin p7pin p76pin	6	; Pin P76/AN6/DA0
pin p7pin p75pin	5	; Pin P75/AN5
pin p7pin p74pin	4	; Pin P74/AN4
pin p7pin p73pin	3	; Pin P73/AN3
pin p7pin p72pin	2	; Pin P72/AN2
pin p7pin p71pin	1	; Pin P71/AN1
pin p7pin p70pin	0	; Pin P70/AN0
reg pbddr		0xffbe	; Port B Data Direction Register
pin pbddr pb7ddr	7	; Pin PB7/-WUE7
pin pbddr pb6ddr	6	; Pin PB6/-WUE6
pin pbddr pb5ddr	5	; Pin PB5/-WUE5
pin pbddr pb4ddr	4	; Pin PB4/-WUE4
pin pbddr pb3ddr	3	; Pin PB3/-WUE3/-CS4
pin pbddr pb2ddr	2	; Pin PB2/-WUE2/-CS3
pin pbddr pb1ddr	1	; Pin PB1/-WUE1/HIRQ4/LSCI
pin pbddr pb0ddr	0	; Pin PB0/-WUE0/HIRQ3/-LSMI

reg p8dr		0xffbf	; Port 8 Data Register
pin p8dr p87dr		7	; -
pin p8dr p86dr		6	; Pin P86/-IRQ5/SCK1/SCL1
pin p8dr p85dr		5	; Pin P85/-IRQ4/RxD1
pin p8dr p84dr		4	; Pin P84/-IRQ3/TxD1
pin p8dr p83dr		3	; Pin P83/-LPCPD
pin p8dr p82dr		2	; Pin P82/HIFSD/-CLKRUN
pin p8dr p81dr		1	; Pin P81/-CS2/GA20
pin p8dr p80dr		0	; Pin P80/HA0/-PME

reg p9ddr		0xffc0	; Port 9 Data Direction Register
pin p9ddr p97ddr	7	; Pin P97/SDA0
pin p9ddr p96ddr	6	; Pin P96/PHI/EXCL
pin p9ddr p95ddr	5	; Pin P95/-CS1
pin p9ddr p94ddr	4	; Pin P94/-IOW
pin p9ddr p93ddr	3	; Pin P93/-IOR
pin p9ddr p92ddr	2	; Pin P92/-IRQ0
pin p9ddr p91ddr	1	; Pin P91/-IRQ1
pin p9ddr p90ddr	0	; Pin P90/-IRQ2/-ADTRG/-ECS2

reg p9dr		0xffc1	; Port 9 Data Register
pin p9dr p97dr		7	; Pin P97/SDA0
pin p9dr p96dr		6	; Pin P96/PHI/EXCL
pin p9dr p95dr		5	; Pin P95/-CS1
pin p9dr p94dr		4	; Pin P94/-IOW
pin p9dr p93dr		3	; Pin P93/-IOR
pin p9dr p92dr		2	; Pin P92/-IRQ0
pin p9dr p91dr		1	; Pin P91/-IRQ1
pin p9dr p90dr		0	; Pin P90/-IRQ2/-ADTRG/-ECS2

reg ier			0xffc2	; Interrupt Enable Register
bit ier irq7e		7	; IRQ7 Enable
bit ier irq6e		6	; IRQ6 Enable
bit ier irq5e		5	; IRQ5 Enable
bit ier irq4e		4	; IRQ4 Enable
bit ier irq3e		3	; IRQ3 Enable
bit ier irq2e		2	; IRQ2 Enable
bit ier irq1e		1	; IRQ1 Enable
bit ier irq0e		0	; IRQ0 Enable

reg stcr		0xffc3	; Serial Timer Control Register
bit stcr iics		7	; I2C Extra Buffer Select
bit stcr iicx1		6	; I2C Transfer Rate Select 1
bit stcr iicx0		5	; I2C Transfer Rate Select 0
bit stcr iice		4	; I2C Master Enable
bit stcr flshe		3	; Flash Memory Control Register Enable
bit stcr icks1		1	; Internal Clock Source Select 1
bit stcr icks0		0	; Internal Clock Source Select 0

reg syscr		0xffc4	; System Control Register
bit syscr cs2e		7	; Chip Select 2 Enable
bit syscr iose		6	; IOS Enable
bit syscr intm1		5	; Interrupt Control Mode 1
bit syscr intm0		4	; Interrupt Control Mode 0
bit syscr xrst		3	; External Reset
bit syscr nmieg		2	; NMI Edge Select
bit syscr hie		1	; XBR Host Interface Enable
bit syscr rame		0	; RAM Enable

reg mdcr		0xffc5	; Mode Control Register
bit mdcr expe		7	; Extended Mode Enable
bit mdcr mds1		1	; Mode Select 1
bit mdcr mds0		0	; Mode Select 0

reg bcr			0xffc6	; Bus Control Register
bit bcr icis0		6	; Idle Cycle Insertion
bit bcr brstrm		5	; Burst ROM Enable
bit bcr brsts1		4	; Burst Cycle Select 1
bit bcr brsts0		3	; Burst Cycle Select 0
bit bcr ios1		1	; IOS Select 1
bit bcr ios0		0	; IOS Select 0

reg wscr		0xffc7	; Wait State Control Register
bit wscr abw		5	; Bus Width Control
bit wscr ast		4	; Access State Control
bit wscr wms1		3	; Wait Mode Select 1
bit wscr wms0		2	; Wait Mode Select 0
bit wscr wc1		1	; Wait Count 1
bit wscr wc0		0	; Wait Count 0

reg tcr_0		0xffc8	; TMR_0 Timer Control Register
bit tcr_0 cmieb		7	; Compare-Match Interrupt Enable B
bit tcr_0 cmiea		6	; Compare-Match Interrupt Enable A
bit tcr_0 ovie		5	; Timer Overflow Interrupt Enable
bit tcr_0 cclr1		4	; Counter Clear 1
bit tcr_0 cclr0		3	; Counter Clear 0
bit tcr_0 cks2		2	; Clock Select 2
bit tcr_0 cks1		1	; Clock Select 1
bit tcr_0 cks0		0	; Clock Select 0

reg tcr_1		0xffc9	; TMR_1 Timer Control Register
bit tcr_1 cmieb		7	; Compare-Match Interrupt Enable B
bit tcr_1 cmiea		6	; Compare-Match Interrupt Enable A
bit tcr_1 ovie		5	; Timer Overflow Interrupt Enable
bit tcr_1 cclr1		4	; Counter Clear 1
bit tcr_1 cclr0		3	; Counter Clear 0
bit tcr_1 cks2		2	; Clock Select 2
bit tcr_1 cks1		1	; Clock Select 1
bit tcr_1 cks0		0	; Clock Select 0

reg tcsr_0		0xffca	; TMR_0 Timer Control/Status Register
bit tcsr_0 cmfb		7	; Compare-Match Flag B
bit tcsr_0 cmfa		6	; Compare-Match Flag A
bit tcsr_0 ovf		5	; Timer Overflow Flag
bit tcsr_0 adte		4	; A/D Trigger Enable
bit tcsr_0 os3		3	; Output Select 3
bit tcsr_0 os2		2	; Output Select 2
bit tcsr_0 os1		1	; Output Select 1
bit tcsr_0 os0		0	; Output Select 0

reg tcsr_1		0xffcb	; TMR_1 Timer Control/Status Register
bit tcsr_1 cmfb		7	; Compare-Match Flag B
bit tcsr_1 cmfa		6	; Compare-Match Flag A
bit tcsr_1 ovf		5	; Timer Overflow Flag
bit tcsr_1 os3		3	; Output Select 3
bit tcsr_1 os2		2	; Output Select 2
bit tcsr_1 os1		1	; Output Select 1
bit tcsr_1 os0		0	; Output Select 0

reg tcora_0		0xffcc	; TMR_0 Time Constant Register A
reg tcora_1		0xffcd	; TMR_1 Time Constant Register A
reg tcorb_0		0xffce	; TMR_0 Time Constant Register B
reg tcorb_1		0xffcf	; TMR_1 Time Constant Register B
reg tcnt_0		0xffd0	; TMR_0 Timer Counter
reg tcnt_1		0xffd1	; TMR_1 Timer Counter

reg pwoerb		0xffd2	; PWM Output Enable Register B
bit pwoerb oe15		7	; Output Enable 15
bit pwoerb oe14		6	; Output Enable 14
bit pwoerb oe13		5	; Output Enable 13
bit pwoerb oe12		4	; Output Enable 12
bit pwoerb oe11		3	; Output Enable 11
bit pwoerb oe10		2	; Output Enable 10
bit pwoerb oe9		1	; Output Enable 9
bit pwoerb oe8		0	; Output Enable 8

reg pwoera		0xffd3	; PWM Output Enable Register A
bit pwoera oe7		7	; Output Enable 7
bit pwoera oe6		6	; Output Enable 6
bit pwoera oe5		5	; Output Enable 5
bit pwoera oe4		4	; Output Enable 4
bit pwoera oe3		3	; Output Enable 3
bit pwoera oe2		2	; Output Enable 2
bit pwoera oe1		1	; Output Enable 1
bit pwoera oe0		0	; Output Enable 0

reg pwdprb		0xffd4	; PWM Data Polarity Register B
bit pwdprb os15		7	; Output Select 15
bit pwdprb os14		6	; Output Select 14
bit pwdprb os13		5	; Output Select 13
bit pwdprb os12		4	; Output Select 12
bit pwdprb os11		3	; Output Select 11
bit pwdprb os10		2	; Output Select 10
bit pwdprb os9		1	; Output Select 9
bit pwdprb os8		0	; Output Select 8

reg pwdpra		0xffd5	; PWM Data Polarity Register A
bit pwdpra os7		7	; Output Select 7
bit pwdpra os6		6	; Output Select 6
bit pwdpra os5		5	; Output Select 5
bit pwdpra os4		4	; Output Select 4
bit pwdpra os3		3	; Output Select 3
bit pwdpra os2		2	; Output Select 2
bit pwdpra os1		1	; Output Select 1
bit pwdpra os0		0	; Output Select 0

reg pwsl		0xffd6	; PWM Register Select
bit pwsl pwcke		7	; PWM Clock Enable
bit pwsl pwcks		6	; PWM Clock Select
bit pwsl rs3		3	; Register Select 3
bit pwsl rs2		2	; Register Select 2
bit pwsl rs1		1	; Register Select 1
bit pwsl rs0		0	; Register Select 0

reg pwdr		0xffd7	; PWM Data Registers PWDR0..PWDR15

reg smr_0		0xffd8	; SCI_0 Serial Mode Register
bit smr_0 c_a		7	; Clocked/-Asynchronous Communication Mode 
bit smr_0 chr		6	; Character Length
bit smr_0 pe		5	; Parity Enable
bit smr_0 o_e		4	; Odd/-Even Parity Mode
bit smr_0 stop		3	; Stop Bit Length
bit smr_0 mp		2	; Multiprocessor Mode
bit smr_0 cks1		1	; Clock Select 1
bit smr_0 cks0		0	; Clock Select 0
reg iccr_0		0xffd8	; IIC_0 I2C Bus Control Register
bit iccr_0 ice		7	; I2C Bus Interface Enable
bit iccr_0 ieic		6	; I2C Bus Interface Interrupt Enable
bit iccr_0 mst		5	; Master/Slave Select
bit iccr_0 trs		4	; Transmit/Receive Select
bit iccr_0 acke		3	; Acknowledge Bit Decision and Selection
bit iccr_0 bbsy		2	; Bus Busy
bit iccr_0 iric		1	; I2C Bus Interface Interrupt Request Flag
bit iccr_0 scp		0	; Start Condition/Stop Condition Prohibit

reg brr_0		0xffd9	; SCI_0 Bit Rate Register
reg icsr_0		0xffd9	; IIC_0 I2C Bus Status Register
bit icsr_0 estp		7	; Error Stop Condition Detection Flag
bit icsr_0 stop		6	; Normal Stop Condition Detection Flag
bit icsr_0 irtr		5	; Continuous Transfer Interrupt Request Flag
bit icsr_0 aasx		4	; Second Slave Address Recognition Flag
bit icsr_0 al		3	; Arbitration Lost Flag
bit icsr_0 aas		2	; Slave Address Recognition Flag
bit icsr_0 adz		1	; General Call Address Recognition Flag
bit icsr_0 ackb		0	; Acknowledge Bit

reg scr_0		0xffda	; SCI_0 Serial Control Register
bit scr_0 tie		7	; Transmit Interrupt Enable
bit scr_0 rie		6	; Receive Interrupt Enable
bit scr_0 te		5	; Transmit Enable
bit scr_0 re		4	; Receive Enable
bit scr_0 mpie		3	; Multiprocessor Interrupt Enable
bit scr_0 teie		2	; Transmit End Interrupt Enable
bit scr_0 cke1		1	; Clock Enable 1 (External/-Internal)
bit scr_0 cke0		0	; Clock Enable 0 (SCK Mode)

reg tdr_0		0xffdb	; SCI_0 Transmit Data Register

reg ssr_0		0xffdc	; SCI_0 Serial Status Register
bit ssr_0 tdre		7	; Transmit Data Register Empty
bit ssr_0 rdrf		6	; Receive Data Register Full
bit ssr_0 orer		5	; Overrun Error
bit ssr_0 fer		4	; Framing Error
bit ssr_0 per		3	; Parity Error
bit ssr_0 tend		2	; Transmit End
bit ssr_0 mpb		1	; Multiprocessor Bit
bit ssr_0 mpbt		0	; Multiprocessor Bit Transfer

reg rdr_0		0xffdd	; SCI_0 Receive Data Register

reg scmr_0		0xffde	; SCI_0 Serial Interface Mode Register
bit scmr_0 sdir		3	; Data Transfer Direction
bit scmr_0 sinv		2	; Data Invert
bit scmr_0 smif		0	; Serial Communication Interface Mode Select
reg icdr_0		0xffde	; IIC_0 I2C Bus Data Register
reg sarx_0		0xffde	; IIC_0 I2C Second Slave Address Register
bit sarx_0 svax6	7	; Second Slave Address 6
bit sarx_0 svax5	6	; Second Slave Address 5
bit sarx_0 svax4	5	; Second Slave Address 4
bit sarx_0 svax3	4	; Second Slave Address 3
bit sarx_0 svax2	3	; Second Slave Address 2
bit sarx_0 svax1	2	; Second Slave Address 1
bit sarx_0 svax0	1	; Second Slave Address 0
bit sarx_0 fsx		0	; Format Select X

reg icmr_0		0xffdf	; IIC_0 I2C Bus Mode Register
bit icmr_0 mls		7	; -MSB-First/LSB-First Select
bit icmr_0 wait		6	; Wait Insertion Bit
bit icmr_0 cks2		5	; Transfer Clock Select 2
bit icmr_0 cks1		4	; Transfer Clock Select 1
bit icmr_0 cks0		3	; Transfer Clock Select 0
bit icmr_0 bc2		2	; Bit Counter 2
bit icmr_0 bc1		1	; Bit Counter 1
bit icmr_0 bc0		0	; Bit Counter 0
reg sar_0		0xffdf	; IIC_0 I2C Slave Address Register
bit sar_0 sva6		7	; Slave Address 6
bit sar_0 sva5		6	; Slave Address 5
bit sar_0 sva4		5	; Slave Address 4
bit sar_0 sva3		4	; Slave Address 3
bit sar_0 sva2		3	; Slave Address 2
bit sar_0 sva1		2	; Slave Address 1
bit sar_0 sva0		1	; Slave Address 0
bit sar_0 fs		0	; Format Select

reg addrah		0xffe0	; A/D Data Register AH
reg addral		0xffe1	; A/D Data Register AL
reg addrbh		0xffe2	; A/D Data Register BH
reg addrbl		0xffe3	; A/D Data Register BL
reg addrch		0xffe4	; A/D Data Register CH
reg addrcl		0xffe5	; A/D Data Register CL
reg addrdh		0xffe6	; A/D Data Register DH
reg addrdl		0xffe7	; A/D Data Register DL

reg adcsr		0xffe8	; A/D Control/Status Register
bit adcsr adf		7	; A/D End Flag
bit adcsr adie		6	; A/D Interrupt Enable
bit adcsr adst		5	; A/D Start
bit adcsr scan		4	; Scan Mode
bit adcsr cks		3	; Clock Select
bit adcsr ch2		2	; Channel Select 2
bit adcsr ch1		1	; Channel Select 1
bit adcsr ch0		0	; Channel Select 0

reg adcr		0xffe9	; A/D Control Register
bit adcr trgs1		7	; Timer Trigger Select 1
bit adcr trgs0		6	; Timer Trigger Select 0

reg wtcsr_1		0xffea	; WDT_1 Watchdog Timer Control & Status Register
bit wtcsr_1 ovf		7	; Overflow Flag
bit wtcsr_1 wt_it	6	; Timer Mode Select
bit wtcsr_1 tme		5	; Timer Enable
bit wtcsr_1 pss		4	; Prescaler Select
bit wtcsr_1 rst_nmi	3	; Reset or NMI
bit wtcsr_1 cks2	2	; Clock Select 2
bit wtcsr_1 cks1	1	; Clock Select 1
bit wtcsr_1 cks0	0	; Clock Select 0

reg wtcnt_1		0xffeb	; WDT_1 Watchdog Timer Counter

reg hicr		0xfff0	; XBS Host Interface Control Register
bit hicr ibfie2		2	; Input Data Register Full Interrupt Enable 2
bit hicr ibfie1		1	; Input Data Register Full Interrupt Enable 1
bit hicr fga20e		0	; Fast A20 Gate Function Enable
reg tcr_x		0xfff0	; TMR_X Timer Control Register
bit tcr_x cmieb		7	; Compare-Match Interrupt Enable B
bit tcr_x cmiea		6	; Compare-Match Interrupt Enable A
bit tcr_x ovie		5	; Timer Overflow Interrupt Enable
bit tcr_x cclr1		4	; Counter Clear 1
bit tcr_x cclr0		3	; Counter Clear 0
bit tcr_x cks2		2	; Clock Select 2
bit tcr_x cks1		1	; Clock Select 1
bit tcr_x cks0		0	; Clock Select 0
reg tcr_y		0xfff0	; TMR_Y Timer Control Register
bit tcr_y cmieb		7	; Compare-Match Interrupt Enable B
bit tcr_y cmiea		6	; Compare-Match Interrupt Enable A
bit tcr_y ovie		5	; Timer Overflow Interrupt Enable
bit tcr_y cclr1		4	; Counter Clear 1
bit tcr_y cclr0		3	; Counter Clear 0
bit tcr_y cks2		2	; Clock Select 2
bit tcr_y cks1		1	; Clock Select 1
bit tcr_y cks0		0	; Clock Select 0

reg kmimr		0xfff1	; Keyboard Matrix Interrupt Mask Register L
bit kmimr kmimr7	7	; -KIN7 Enable
bit kmimr kmimr6	6	; -KIN6 Enable
bit kmimr kmimr5	5	; -KIN5 Enable
bit kmimr kmimr4	4	; -KIN4 Enable
bit kmimr kmimr3	3	; -KIN3 Enable
bit kmimr kmimr2	2	; -KIN2 Enable
bit kmimr kmimr1	1	; -KIN1 Enable
bit kmimr kmimr0	0	; -KIN0 Enable
reg tcsr_x		0xfff1	; TMR_X Timer Control/Status Registers
bit tcsr_x cmfb		7	; Compare-Match Flag B
bit tcsr_x cmfa		6	; Compare-Match Flag A
bit tcsr_x ovf		5	; Timer Overflow Flag
bit tcsr_x icf		4	; Input Capture Flag
bit tcsr_x os3		3	; Output Select 3
bit tcsr_x os2		2	; Output Select 2
bit tcsr_x os1		1	; Output Select 1
bit tcsr_x os0		0	; Output Select 0
reg tcsr_y		0xfff1	; TMR_Y Timer Control/Status Registers
bit tcsr_y cmfb		7	; Compare-Match Flag B
bit tcsr_y cmfa		6	; Compare-Match Flag A
bit tcsr_y ovf		5	; Timer Overflow Flag
bit tcsr_y icie		4	; Input Capture Interrupt Enable
bit tcsr_y os3		3	; Output Select 3
bit tcsr_y os2		2	; Output Select 2
bit tcsr_y os1		1	; Output Select 1
bit tcsr_y os0		0	; Output Select 0

reg kmpcr		0xfff2	; Port 6 Pull-Up MOS Control Register
pin kmpcr km7pcr	7	; Pin P67/-IRQ7/TMOX/-KIN7/CIN7
pin kmpcr km6pcr	6	; Pin P66/-IRQ6/FTOB/-KIN6/CIN6
pin kmpcr km5pcr	5	; Pin P65/FTID/-KIN5/CIN5
pin kmpcr km4pcr	4	; Pin P64/FTIC/-KIN4/CIN4/CLAMPO
pin kmpcr km3pcr	3	; Pin P63/FTIB/-KIN3/CIN3/VFBACKI
pin kmpcr km2pcr	2	; Pin P62/FTIA/TMIY/-KIN2/CIN2/VSYNCI
pin kmpcr km1pcr	1	; Pin P61/FTOA/-KIN1/CIN1/VSYNCO
pin kmpcr km0pcr	0	; Pin P60/FTCI/TMIX/-KIN0/CIN0/HFBACKI
reg ticrr		0xfff2	; TMR_X Input Capture Register R
reg tcora_y		0xfff2	; TMR_Y Time Constant Register A

reg kmimra		0xfff3	; Keyboard Matrix Interrupt Mask Register H
bit kmimra kmimr15	7	; -KIN15 Enable
bit kmimra kmimr14	6	; -KIN14 Enable
bit kmimra kmimr13	5	; -KIN13 Enable
bit kmimra kmimr12	4	; -KIN12 Enable
bit kmimra kmimr11	3	; -KIN11 Enable
bit kmimra kmimr10	2	; -KIN10 Enable
bit kmimra kmimr9	1	; -KIN9 Enable
bit kmimra kmimr8	0	; -KIN8 Enable
reg ticrf		0xfff3	; TMR_X Input Capture Register F
reg tcorb_y		0xfff3	; TMR_Y Time Constant Register B

reg idr_1		0xfff4	; XBS Input Data Register 1
reg tcnt_x		0xfff4	; TMR_X Timer Counter
reg tcnt_y		0xfff4	; TMR_Y Timer Counter

reg odr_1		0xfff5	; XBS Output Data Register 1
reg tcorc		0xfff5	; TMR_X Time Constant Register C
reg tisr		0xfff5	; TMR_Y Timer Input Select Register
bit tisr is		0	; Input Select

reg str_1		0xfff6	; XBS Status Register 1
bit str_1 dbu17		7	; Defined By User
bit str_1 dbu16		6	; Defined By User
bit str_1 dbu15		5	; Defined By User
bit str_1 dbu14		4	; Defined By User
bit str_1 c_d1		3	; Command/-Data
bit str_1 dbu12		2	; Defined By User
bit str_1 ibf1		1	; Input Buffer Full
bit str_1 obf1		0	; Output Buffer Full
reg tcora_x		0xfff6	; TMR_X Time Constant Register A
reg tcorb_x		0xfff7	; TMR_X Time Constant Register B

reg dadr0		0xfff8	; D/A Data Register 0
reg dadr1		0xfff9	; D/A Data Register 1

reg dacr		0xfffa	; D/A Control Register
bit dacr daoe1		7	; D/A Output Enable 1
bit dacr daoe0		6	; D/A Output Enable 0
bit dacr dae		5	; D/A Enable

reg idr_2		0xfffc	; XBS Input Data Register 2
reg tconri		0xfffc	; Timer Connection Register I
bit tconri simod1	7	; Input Synchronization Mode Select 1
bit tconri simod0	6	; Input Synchronization Mode Select 0
bit tconri scone	5	; Synchronization Signal Connection Enable
bit tconri icst		4	; Input Capture Start Bit
bit tconri hfinv	3	; Input Spare Horizontal Synchronization Signal Inversion
bit tconri vfinv	2	; Input Spare Vertical Synchronization Signal Inversion
bit tconri hiinv	1	; Input Horizontal & Composite Synchronization Signal Inversion
bit tconri viinv	0	; Input Vertical Synchronization Signal Inversion

reg odr_2		0xfffd	; XBS Output Data Register 2
reg tconro		0xfffd	; Timer Connection Register O
bit tconro hoe		7	; Horizontal Synchronization Signal Output Enable
bit tconro voe		6	; Vertical Synchronization Signal Output Enable
bit tconro cloe		5	; Clamp Waveform Output Enable
bit tconro cboe		4	; Blanking Waveform Output Enable
bit tconro hoinv	3	; Output Horizontal Synchronization Signal Inversion
bit tconro voinv	2	; Output Vertical Synchronization Signal Inversion
bit tconro cloinv	1	; Output Clamp Waveform Signal Inversion
bit tconro cboinv	0	; Output Blanking Waveform Signal Inversion

reg str_2		0xfffe	; XBS Status Register 2
bit str_2 dbu27		7	; Defined By User
bit str_2 dbu26		6	; Defined By User
bit str_2 dbu25		5	; Defined By User
bit str_2 dbu24		4	; Defined By User
bit str_2 c_d2		3	; Command/-Data
bit str_2 dbu22		2	; Defined By User
bit str_2 ibf2		1	; Input Buffer Full
bit str_2 obf2		0	; Output Buffer Full
reg tconrs		0xfffe	; Timer Connection Register S
bit tconrs tmrx_y	7	; TMR_X/TMR_Y Access Select
bit tconrs isgene	6	; Internal Synchronization Signal
bit tconrs homod1	5	; Horizontal Synchronization Output Mode Select 1
bit tconrs homod0	4	; Horizontal Synchronization Output Mode Select 0
bit tconrs vomod1	3	; Vertical Synchronization Output Mode Select 1
bit tconrs vomod0	2	; Vertical Synchronization Output Mode Select 0
bit tconrs clmod1	1	; Clamp Waveform Mode Select 1
bit tconrs clmod0	0	; Clamp Waveform Mode Select 0

reg sedgr		0xffff	; Timer Edge Sense Register
bit sedgr vedg		7	; VSYNCI Edge
bit sedgr hedg		6	; HSYNCI Edge
bit sedgr cedg		5	; CSYNCI Edge
bit sedgr hfedg		4	; HFBACKI Edge
bit sedgr vfedg		3	; VFBACKI Edge
bit sedgr preqf		2	; Pre-Equalization Flag
bit sedgr ihi		1	; IHI Signal Level
bit sedgr ivi		0	; IVI Signal Level

		.purgem reg
		.purgem bit
		.purgem pin

.list
