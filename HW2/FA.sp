*********************************************
.inc '90nm_bulk.l'
*********************************************
.SUBCKT Inv DVDD GND In Out
*.PININFO DVDD:I GND:I In:I Out:O
MN1 Out In GND GND NMOS l=0.1u w=0.25u m=1
MP1 Out In DVDD DVDD PMOS l=0.1u w=0.5u m=1
.ENDS
*********************************************
.SUBCKT Xor DVDD GND In In1 In2 Out
*.PININFO DVDD:I GND:I In:I In1:I In2:I Out:O
MN1 Out In1 In GND NMOS l=0.1u w=0.25u m=1
MN2 Out In  In1 GND NMOS l=0.1u w=0.25u m=1
MP1 Out In2 In DVDD PMOS l=0.1u w=0.5u m=1
MP2 Out In  In2 DVDD PMOS l=0.1u w=0.5u m=1
.ENDS
*********************************************
.SUBCKT Strange DVDD GND In1 In2 In3 Out
*.PININFO DVDD:I GND:I In1:I In2:I In3:I Out:O
MN1 X   In2 GND  GND NMOS l=0.1u w=0.25u m=1
MN2 Out In1 X    GND NMOS l=0.1u w=0.25u m=1
MN3 Y   In1 GND  GND NMOS l=0.1u w=0.25u m=1
MN4 Y   In2 GND  GND NMOS l=0.1u w=0.25u m=1
MN5 Out In3 Y    GND NMOS l=0.1u w=0.25u m=1
MP1 Z   In2 DVDD DVDD PMOS l=0.1u w=0.5u m=1
MP2 Out In1 Z    DVDD PMOS l=0.1u w=0.5u m=1
MP3 W   In1 DVDD DVDD PMOS l=0.1u w=0.5u m=1
MP4 W   In2 DVDD DVDD PMOS l=0.1u w=0.5u m=1
MP5 Out In3 W    DVDD PMOS l=0.1u w=0.5u m=1
.ENDS
*********************************************
Vdd DVDD    0   1.8
Vss GND     0   0

Vin A    0   pulse (0 1.8 0 50n 50n 0.2u 0.5u)
V1  B	   0   pulse (0 1.8 0 50n 50n 0.4u 0.9u)
V2  CI   0   pulse (0 1.8 0 50n 50n 0.8u 1.7u)


x0 DVDD     GND A  invA     Inv
x1 DVDD     GND CI  invCI     Inv
x2 DVDD     GND B  invA  A  net1     Xor
x3 DVDD     GND net1  CI  invCI  net2     Xor
x4 DVDD     GND net2  S     Inv
x5 DVDD     GND A B CI  net3     Strange
x6 DVDD     GND net3  CO     Inv



.tran 10n 2.4u
.op
.option post
.end