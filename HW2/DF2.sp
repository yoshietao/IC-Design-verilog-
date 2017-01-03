*********************************************
.inc '90nm_bulk.l'
.SUBCKT Inv DVDD GND In Out
*.PININFO DVDD:I GND:I In:I Out:O
MN1 Out In GND GND NMOS l=0.1u w=0.25u m=1
MP1 Out In DVDD DVDD PMOS l=0.1u w=0.5u m=1
.ENDS
*********************************************
.SUBCKT Nand DVDD GND In1 In2 Out
*.PININFO DVDD:I GND:I In1:I In2:I Out:O
MN1 X 	In1 GND GND NMOS l=0.1u w=0.25u m=1
MN2 Out In2 X   GND NMOS l=0.1u w=0.25u m=1
MP1 Out In1 DVDD DVDD PMOS l=0.1u w=0.5u m=1
MP2 Out In2 DVDD DVDD PMOS l=0.1u w=0.5u m=1
.ENDS
*********************************************
.SUBCKT Invv DVDD GND In Out
*.PININFO DVDD:I GND:I In:I Out:O
MN1 Out In GND GND NMOS l=0.1u w=0.25u m=1
MP1 Out In DVDD DVDD PMOS l=0.1u w=0.5u m=1
MP2 Out In DVDD DVDD PMOS l=0.1u w=0.5u m=1
.ENDS
*********************************************
.SUBCKT PTL DVDD GND In In1 In2 Out
*.PININFO DVDD:I GND:I In In1:I In2:I Out:O
MN1 Out In1 In GND NMOS l=0.1u w=0.25u m=1
MP1 Out In2 In DVDD PMOS l=0.1u w=0.5u m=1
.ENDS
*********************************************
.SUBCKT CLKInv DVDD GND In1 In2 In3 Out
*.PININFO DVDD:I GND:I In1:I In2:I In3 Out:O
MN1 x  	In1 GND GND NMOS l=0.1u w=0.25u m=1
MN2 Out In2 x 	 GND NMOS l=0.1u w=0.25u m=1
MP1 y   In1 DVDD DVDD PMOS l=0.1u w=0.5u m=1
MP2 Out In3 y    DVDD PMOS l=0.1u w=0.5u m=1
.ENDS
*********************************************
Vdd DVDD    0   1.8
Vss GND     0   0

Vin D      0   pulse (0 1.8 100n 50n 50n 0.45u 1u)
V1 CLK	   0   pulse (0 1.8 0.2u 50n 50n 0.2u 0.5u)
V2 RST    0   pulse (0 1.8 0 50n 50n 0.9u 2u)

x0 DVDD     GND CLK  invclk     Inv
x1 DVDD     GND RST net3  net1     Nand
x2 DVDD     GND net1 CLK invclk  net2     PTL
x3 DVDD     GND D invclk CLK net2     CLKInv
x4 DVDD     GND net2  net3     Inv
x5 DVDD     GND net3 CLK invclk net4    PTL
x6 DVDD     GND net4  RST net5     Nand
x7 DVDD     GND net5  invclk CLK net4     CLKInv
x8 DVDD     GND net5  out     Invv

.tran 10n 2.1u
.op
.option post
.end




