Source Equivalent for ThinkPad Embedded Controller Firmware
===========================================================

This package contains source code to produce several embedded
controller firmware versions for several ThinkPad T4x/p and
R5x/p types.

File h8s2161.h contains register definitions for the H8S/2161BV
controller, file h8s2161.x instructions for the GNU linker, and
file ec.s the actual assembler source code. File ec.html is an
HTML+JavaScript version of ec.s, converted using the xref Perl
script (use F2 & F8 to turn on & off features). File cksums.c
contains a C program to calculate the three internal checksums
of the flash memory image.

File names 1yhj06 and $0197000.fl2 below are specific to firmware
version 1.06 for T43/p 26xx types and can be substituted with
the appropriate names for other firmware levels and types; e.g.
70hj05 and $0199000.fl2, or 76hj06 and $019f000.fl2. However,
most symbol names in ec.s are based on the addresses of firmware
version 1.05 for T43/p 26xx machine types.


Creating a Flash Memory Image
-----------------------------

Compile & link cksums binary once:

    cc -O -s -ocksums cksums.c
or
    gcc -O -s -ocksums cksums.c
or
    cl cksums.c

Assemble & link flash memory image using H8 Binutils:

    h8300-coff-as -oec.o ec.s
    h8300-coff-ld -Th8s2161.x -oec.bin ec.o
or
    h8300-coff-gcc -nostdlib -Th8s2161.x -oec.bin ec.s

Verify flash memory internal checksums:

    cksums ec.bin

Adjust checksums in ec.s and repeat assemble & link step.

Convert to s-record format:

    h8300-coff-objcopy -Ibinary -Osrec --srec-l 32 ec.bin ec.mot


Flashing a Flash Memory Image (Windows)
---------------------------------------

Extract original flash utilities:

    winrar x 1yhj06us.exe 1yhj06us\
or
    7z x 1yhj06us.exe -o1yhj06us

Copy flash memory image to virtual floppy disk image:

    vfd o 1yhj06us\1yhj06us.img
    xcopy ec.mot a:\$0197000.fl2 /r
    vfd u
    vfd r

Start flash process (version downgrade might be needed first):

    cd 1yhj06us
    ectluptp -n


Flashing a Flash Memory Image (Linux/Solaris)
---------------------------------------------

Extract original flash utilities:

    cabextract -Ld1yhj06us 1yhj06us.exe
or
    7z x 1yhj06us.exe -o1yhj06us
    mv 1yhj06us/1YHJ06US.IMG 1yhj06us/1yhj06us.img

Copy flash memory image to virtual floppy disk image (Linux):

    mount -oloop 1yhj06us/1yhj06us.img /mnt
    cp -f ec.mot /mnt/\$0197000.FL2
    umount /mnt

Copy flash memory image to virtual floppy disk image (Solaris):

    mount -Fpcfs `lofiadm -a"\`pwd\`/1yhj06us/1yhj06us.img"` /mnt
    cp -f ec.mot /mnt/\$0197000.FL2
    umount /mnt
    lofiadm -d"`pwd`/1yhj06us/1yhj06us.img"

Create a bootable ISO image:

    mkisofs -oec.iso -b1yhj06us.img 1yhj06us/1yhj06us.img

Burn the ISO image to CD-R(W), DVD+/-R(W) or DVD-RAM and boot from it.

To use instead a USB memory stick that has a bootable and working DOS
already installed on it, copy all files except ibmio.com, ibmdos.com,
config.sys and command.com from 1yhj06us.img to the memory stick,
copy from 1yhj06us.img the file command.com renamed as flash.com to
the memory stick, and create a file named autoexec.bat that contains
the single command flash.com. Reboot or hibernate and then press F12.


Inspecting a Flash Memory Image
-------------------------------

Hex dump:

    od -Ax -tx1 ec.bin
or
    od -Ax -vtx1 ec.bin

Compare hex dump files:

    diff -u original.hex new.hex

Link with symbols included:

    h8300-coff-ld -Th8s2161.x --of coff-h8300 -oec ec.o

Disassemble:

    h8300-coff-objdump -dz ec
or
    h8300-coff-objdump -Dmh8300s --start 0x1000 ec.mot
or
    h8300-coff-objdump -Dmh8300s -bbinary --start 0x1000 ec.bin


List symbols:

    h8300-coff-nm -n ec


Checking the MD5 Message Digest of the Original Flash Memory Images
-------------------------------------------------------------------

Convert image from s-record format to binary format if necessary
(substitute ec.mot with a:\$0197000.fl2, /mnt/\$0197000.fl2, etc.):

    h8300-coff-objcopy -Isrec -Obinary ec.mot ec.bin

Compute digest:

    md5sum ec.bin
or
    gmd5sum ec.bin
or
    md5 ec.bin
or
    digest -amd5 ec.bin


Creating All Flash Memory Image Versions (Cygwin/Linux/Solaris)
---------------------------------------------------------------

Create all flash memory images, their hex dumps,
and verify their checksums and MD5 digests:

    for i in 1R/15 1R/62 1R/63 1R/66 1R/68 1R/69 1R/70 1R/71 1Y/24 1Y/26 1Y/27 \
             1Y/28 1Y/29 70/24 70/26 70/27 70/28 76/12 76/14 76/15 76/16
    do type=`dirname $i` id=`basename $i` && name=${type}HT${id}WW &&
       h8300-coff-as --defsym type$type=1 --defsym id=$id -oec.o ec.s >ec.md5 &&
       head -1 ec.md5 >&2 &&
       h8300-coff-ld -Th8s2161.x -o$name.bin ec.o &&
       od -Ax -tx1 -v $name.bin >$name.hex &&
       cksums $name.bin >/dev/null &&
       md5sum -c ec.md5 <$name.bin >/dev/null
    done
    rm ec.md5 ec.o


Creating an Individual Source File for Each Version
---------------------------------------------------

Create individual source files with conditional code sections removed:

    perl splitec ec.s


Updating the HTML Listing
-------------------------

    perl xref ec.s h8s2161.h >ec.html


Resources
---------

Renesas H8S/2600 Series Programming Manual
http://documentation.renesas.com/eng/products/mpumcu/rej09b0139_h8s2600.pdf

Renesas H8S/2140B Group Hardware Manual
http://documentation.renesas.com/eng/products/mpumcu/rej09b0300_2140bhm.pdf

Renesas H8S Series Technical Q&A Application Note
http://documentation.renesas.com/eng/products/mpumcu/apn/rej05b0397_h8s2655.pdf

GNU Binutils 2.16.1 (and before) for H8 (as, ld, objcopy, objdump)
http://ftp.gnu.org/gnu/binutils/  (configure --t=h8300-coff) or
http://mes.sourceforge.jp/mes/download.html  (Yukio Mituiwa's MESGCC HMS) or
http://kpitgnutools.com  (KPIT GNU Tools: GNUH8 Tool Chain COFF Format)

GNU Coreutils (md5sum)
http://ftp.gnu.org/gnu/coreutils/

Ken Kato's Virtual Floppy Drive
http://chitchat.at.infoseek.co.jp/vmware/vfd.html

Alexander Roshal's WinRAR
http://rarlab.com/download.htm

Stuart Caie's cabextract
http://www.kyz.uklinux.net/cabextract.php

Igor Pavlov's 7-Zip
http://7-zip.org

Lenovo Embedded Controller Firmware T40/p; T41/p; T42/p; R50/p; R51 1829..1831, 1836 (1R)
http://ftp.software.ibm.com/ibmdl/pub/pc/pccbbs/mobiles/1rhj10u2.txt
http://ftp.software.ibm.com/ibmdl/pub/pc/pccbbs/mobiles/1rhj10u2.exe
http://lenovo.com/think/support/site.wss/MIGR-50279.html
Lenovo Embedded Controller Firmware R50e, R51 2883, 2887..2889, 2894..2895 (1V)
http://ftp.software.ibm.com/ibmdl/pub/pc/pccbbs/mobiles/1vhj05us.txt
http://ftp.software.ibm.com/ibmdl/pub/pc/pccbbs/mobiles/1vhj05us.exe
http://lenovo.com/think/support/site.wss/MIGR-54996.html
Lenovo Embedded Controller Firmware T43/p 2668..2669, 2678..2679, 2686..2687 (1Y)
http://ftp.software.ibm.com/ibmdl/pub/pc/pccbbs/mobiles/1yhj06us.txt
http://ftp.software.ibm.com/ibmdl/pub/pc/pccbbs/mobiles/1yhj06us.exe
http://lenovo.com/think/support/site.wss/MIGR-59120.html
Lenovo Embedded Controller Firmware T43 1871..1876; R52 1858..1863, 1958 (70)
http://ftp.software.ibm.com/ibmdl/pub/pc/pccbbs/mobiles/70hj05us.txt
http://ftp.software.ibm.com/ibmdl/pub/pc/pccbbs/mobiles/70hj05us.exe
http://lenovo.com/think/support/site.wss/MIGR-59439.html
Lenovo Embedded Controller Firmware R52 1846..1850, 1870 (76)
http://ftp.software.ibm.com/ibmdl/pub/pc/pccbbs/mobiles/76hj06us.txt
http://ftp.software.ibm.com/ibmdl/pub/pc/pccbbs/mobiles/76hj06us.exe
http://lenovo.com/think/support/site.wss/MIGR-59184.html

Maxim MAX1989 Data Sheet
http://pdfserv.maxim-ic.com/en/ds/MAX1668-MAX1989.pdf

Maxim MAX1540ETJ Data Sheet
http://pdfserv.maxim-ic.com/en/ds/MAX1540A-MAX1541.pdf

Maxim Application Note 476: Comparing the I2C Bus to the SMBus
http://pdfserv.maxim-ic.com/en/an/AN476.pdf

Advanced Configuration & Power Interface Specification
http://acpi.info/spec.htm


History
-------

2006-02-17 ec-00: added 1Y 24..27 (1.01/1.03/1.04)
2006-02-20 ec-01: added 1Y 28 (1.05)
2006-02-24 ec-02: added 70 26 (1.03)
2006-03-06 ec-03: added xref (HTML version)
2006-04-07 ec-04: added some comments
2006-04-17 ec-05: added 70 27 (1.04)
2006-06-10 ec-06: added 70 28 (1.05)
                  added 1Y 29 (1.06)
2006-07-23 ec-07: added 70 24 (1.01)
                  added MD5 checksums
                  fixed sub_0ecce reloc
2006-07-25 ec-08: added 76 12/14..16 (1.02/1.04/1.05/1.06)
2006-08-19 ec-09: added & removed 1R 15 (1.02)
2006-09-06 ec-10: added 1R 62/63/66/68..71 (2.03/2.04/3.00a/3.01a/3.02/3.03/3.04)
2006-09-06 ec-11: fixed byte_ffe0c4 = byte_ffe112-0x4e reloc
2006-09-12 ec-12: added 1R 15 (1.02)
2006-09-17 ec-13: fixed exec = 0xffe400
2006-09-20 ec-14: misc changes
2006-09-24 ec-15: fan states label/comment changes
2007-07-30 ec-16: changed macros for broken binutils > 2.16.1 (ELF still broken)
2007-08-08 ec-17: misc changes in xref, changed file order, added splitec script
2008-06-11 ec-18: added adjustment to text size change in xref

