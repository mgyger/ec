OUTPUT_FORMAT(binary)		/* Only .text Segment (Otherwise coff-h8300) */
OUTPUT_ARCH(h8300s)		/* H8S/2600 Series in Advanced Mode */

SECTIONS {
    .text 0 : { *(.text) }	/* Internal Flash Memory Start */
    .bss 0xffe080 : { *(.bss) }	/* Low Internal RAM Start */
}
