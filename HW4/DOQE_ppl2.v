`timescale 1ns/1ps
module DOQE_ppl(clk,rst,A,B,C,D,DOQE_ppl_num);
// DO NOT CHANGE !
	input		clk;
	input		rst;
	input		[3:0]	A;
	input		[6:0]	B;
	input   	[5:0] 	C;
	output		[14:0]	D;
    output  	[50:0]  DOQE_ppl_num;	
  // Write your design here
	wire [6:0] pp0,pp1;
	wire [7:0] pp70,pp71,pp72,pp73;
	wire [5:0] ADD;
	wire [50:0] NUM0,NUM1,NUM2,NUM3;
	wire [13:0] P0,P1;
	wire [10:0] s,co;
	MBoothEncoder46 b0(A,C,pp0,pp1,ADD[1:0],NUM0);
	MBoothEncoder77 b1(B,pp70,pp71,pp72,pp73,ADD[5:2],NUM1);
	wallacetree77 w0(pp70,pp71,pp72,pp73,ADD[5:2],P0,P1,NUM2);
	wallacetree46 w1(pp0,pp1,ADD[1:0],s,co,NUM3);
	
	
	
endmodule

module MBoothEncoder46 (A,C,pp0,pp1,ADD,NUM);
	input		[3:0] A;
	input		[5:0] C;
	parameter 	size = 10'd50; 
	output		[size:0] NUM;
	output		[1:0] ADD;
	output		[6:0] pp0,pp1;								//partial product
	////////////////////////////////////////////// Booth features(single,double,negative) of layers 1,2,3	
	wire [1:0] single,double,neg;
	wire [size:0] NUM460,NUM461,NUM0,NUM1;
	SDN sdn4(A[1],A[0],0,single[0],double[0],neg[0],NUM460);
	SDN sdn5(A[3],A[2],A[1],single[1],double[1],neg[1],NUM461);
	
	BoothSelector46 b0(single[0],double[0],neg[0],C,pp0,ADD[0],NUM0);
	BoothSelector46 b1(single[1],double[1],neg[1],C,pp1,ADD[1],NUM1);

	assign NUM = NUM460+NUM461+NUM0+NUM1;
endmodule

module MBoothEncoder77(B,pp70,pp71,pp72,pp73,ADD,NUM);
	input [6:0] B;
	output [7:0] pp70,pp71,pp72,pp73;
	output [3:0] ADD;
	parameter 	size = 10'd50; 
	output		[size:0] NUM;
	
	wire [3:0] sin,dou,nega;
	SDN sdn0(B[1],B[0],0,sin[0],dou[0],nega[0],NUM0); // single double negative
	SDN sdn1(B[3],B[2],B[1],sin[1],dou[1],nega[1],NUM1);
	SDN sdn2(B[5],B[4],B[3],sin[2],dou[2],nega[2],NUM2);
	SDN sdn3(B[6],B[6],B[5],sin[3],dou[3],nega[3],NUM3);  //extend 1 bit to do sdn! Do not place zero!
	//module BoothSelector77(S,D,N,Y,PP,ADD,NUM):
	BoothSelector77 b0(sin[0],dou[0],nega[0],B,pp70,ADD[0],NUM4);
	BoothSelector77 b1(sin[1],dou[1],nega[1],B,pp71,ADD[1],NUM5);
	BoothSelector77 b2(sin[2],dou[2],nega[2],B,pp72,ADD[2],NUM6);
	BoothSelector77 b3(sin[3],dou[3],nega[3],B,pp73,ADD[3],NUM7);
	
endmodule

module SDN(b2,b1,b0,S,D,N,NUM);
	input b0,b1,b2;
	output S,D,N;
	output NUM;
	wire SDNUM0;
	wire n0,n1,n2,nd0,nd1;

	EO SDNe0(S,b0,b1,SDNUM0);
	
	IV SDNi0(n0,b0,SDNUM1);
	IV SDNi1(n1,b1,SDNUM2);
	IV SDNi2(n2,b2,SDNUM3);
	
	ND3 SDNd0(nd0,b0,b1,n2,SDNUM4);
	ND3 SDNd1(nd1,n0,n1,b2,SDNUM5);
	ND2 SDNd2(D,nd0,nd1,SDNUM6);
	
	AN2 SDNa0(N,1,b2,SDNUM7);
	assign NUM = SDNUM0+SDNUM1+SDNUM2+SDNUM3+SDNUM4+SDNUM5+SDNUM6+SDNUM7;
endmodule

module BoothSelector77(S,D,N,Y,PP,ADD,NUM);
	input S,D,N;
	input [6:0] Y;
	output [7:0] PP;
	output ADD;
	parameter	size = 10'd50; 
	output	[size:0] NUM;
	
	wire [size:0] n0,n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,nn0,nn1,nn2,nn3,nn4,nn5,nn6,nn7,nnn0,nnn1,nnn2,nnn3,nnn4,nnn5,nnn6,nnn7,nnnn0,no0,no1,no2,no3,nan;
	wire [7:0] tempsin,tempdou,tempor;
	AN2 an0(tempsin[0],Y[0],S,n0);
	AN2 an1(tempsin[1],Y[1],S,n1);
	AN2 an2(tempsin[2],Y[2],S,n2);
	AN2 an3(tempsin[3],Y[3],S,n3);
	AN2 an4(tempsin[4],Y[4],S,n4);
	AN2 an5(tempsin[5],Y[5],S,n5);
	AN2 an6(tempsin[6],Y[6],S,n6);

	AN2 an7(tempdou[1],Y[0],D,n7);
	AN2 an8(tempdou[2],Y[1],D,n8);
	AN2 an9(tempdou[3],Y[2],D,n9);
	AN2 an10(tempdou[4],Y[3],D,n10);
	AN2 an11(tempdou[5],Y[4],D,n11);
	AN2 an12(tempdou[6],Y[5],D,n12);	
	AN2 an13(tempdou[7],Y[6],D,n13);	
	
	OR2 or0(tempor[0],tempsin[0],0,nn0);
	OR2 or1(tempor[1],tempsin[1],tempdou[1],nn1);
	OR2 or2(tempor[2],tempsin[2],tempdou[2],nn2);
	OR2 or3(tempor[3],tempsin[3],tempdou[3],nn3);
	OR2 or4(tempor[4],tempsin[4],tempdou[4],nn4);
	OR2 or5(tempor[5],tempsin[5],tempdou[5],nn5);
	OR2 or6(tempor[6],tempsin[6],tempdou[6],nn6);
	OR2 or7(tempor[7],0,tempdou[7],nn7);
	
	wire temp0,temp1,temp2,temp3,temp4; //000000 detect
	NR3 n0(temp0,Y[0],Y[1],Y[2],no0);
	NR4 n1(temp1,Y[3],Y[4],Y[5],Y[6],no1);
	ND2 n2(temp2,temp1,temp0,no2);
	AN2 n3(temp3,N,temp2,no3);
	
	EO	ee0(PP[0],tempor[0],temp3,nnn0);
	EO	ee1(PP[1],tempor[1],temp3,nnn1);
	EO	ee2(PP[2],tempor[2],temp3,nnn2);
	EO	ee3(PP[3],tempor[3],temp3,nnn3);
	EO	ee4(PP[4],tempor[4],temp3,nnn4);
	EO	ee5(PP[5],tempor[5],temp3,nnn5);
	EO	ee6(PP[6],tempor[6],temp3,nnn6);
	EO	ee7(PP[7],tempor[7],temp3,nnn7);
	
	EO ex1(temp4,Y[6],N,nnnn0);
	AN2 n4(ADD,temp3,temp4,nan);
	assign NUM=n0+n1+n2+n3+n4+n5+n6+n7+n8+n9+n10+n11+n12+n13+nn0+nn1+nn2+nn3+nn4+nn5+nn6+nn7+nnn0+nnn1+nnn2+nnn3+nnn4+nnn5+nnn6+nnn7+nnnn0+no0+no1+no2+no3+nan;
	
endmodule

module BoothSelector46(S,D,N,Y,PP,ADD,NUM);
	input	S,D,N;
	input	[5:0] Y;
	output	[6:0] PP;
	output	ADD;
	parameter	size = 10'd50; 
	output	[size:0] NUM;
	
	wire [size:0] n0,n1,n2,n3,n4,n5,n7,n8,n9,n10,n11,n12,nn0,nn1,nn2,nn3,nn4,nn5,nn6,nnn0,nnn1,nnn2,nnn3,nnn4,nnn5,nnn6,nnnn0,no0,no1,no2,no3,nan;
	wire [6:0] tempsin,tempdou,tempor;
	AN2 an0(tempsin[0],Y[0],S,n0);
	AN2 an1(tempsin[1],Y[1],S,n1);
	AN2 an2(tempsin[2],Y[2],S,n2);
	AN2 an3(tempsin[3],Y[3],S,n3);
	AN2 an4(tempsin[4],Y[4],S,n4);
	AN2 an5(tempsin[5],Y[5],S,n5);

	AN2 an7(tempdou[0],Y[0],D,n7);
	AN2 an8(tempdou[1],Y[1],D,n8);
	AN2 an9(tempdou[2],Y[2],D,n9);
	AN2 an10(tempdou[3],Y[3],D,n10);
	AN2 an11(tempdou[4],Y[4],D,n11);
	AN2 an12(tempdou[5],Y[5],D,n12);	
	
	OR2 or0(tempor[0],tempsin[0],0,nn0);
	OR2 or1(tempor[1],tempsin[1],tempdou[0],nn1);
	OR2 or2(tempor[2],tempsin[2],tempdou[1],nn2);
	OR2 or3(tempor[3],tempsin[3],tempdou[2],nn3);
	OR2 or4(tempor[4],tempsin[4],tempdou[3],nn4);
	OR2 or5(tempor[5],tempsin[5],tempdou[4],nn5);
	OR2 or6(tempor[6],tempsin[6],tempdou[5],nn6);
	
	wire temp0,temp1,temp2,temp3,temp4; //000000 detect
	NR3 n0(temp0,Y[0],Y[1],Y[2],no0);
	NR3 n1(temp1,Y[3],Y[4],Y[5],no1);
	ND2 n2(temp2,temp1,temp0,no2);
	AN2 n3(temp3,N,temp2,no3);
	
	EO	ee0(PP[0],tempor[0],temp3,nnn0);
	EO	ee1(PP[1],tempor[1],temp3,nnn1);
	EO	ee2(PP[2],tempor[2],temp3,nnn2);
	EO	ee3(PP[3],tempor[3],temp3,nnn3);
	EO	ee4(PP[4],tempor[4],temp3,nnn4);
	EO	ee5(PP[5],tempor[5],temp3,nnn5);
	EO	ee6(PP[6],tempor[6],temp3,nnn6);
	
	EO ex1(temp4,Y[5],N,nnnn0);
	AN2 n4(ADD,temp3,temp4,nan);
	
	assign NUM = n0+n1+n2+n3+n4+n5+n7+n8+n9+n10+n11+n12+nn0+nn1+nn2+nn3+nn4+nn5+nn6+nnn0+nnn1+nnn2+nnn3+nnn4+nnn5+nnn6+nnnn0+no0+no1+no2+no3+nan;
	
endmodule

module wallacetree77(pp0,pp1,pp2,pp3,ADD,s2,co2,NUM);
	input [7:0] pp0,pp1,pp2,pp3;
	input [3:0] ADD;
	output [13:0] s2,co2;
	output
	
	////first layer
	wire [12:0] co0,s0;
	HA1 h0(co0[1],s0[0],pp0[0],ADD[0],n0);
	FA1 h1(co0[3],s0[2],pp0[2],pp1[0],ADD[1],n1);
	HA1 h2(co0[4],s0[3],pp0[3],pp1[1],n2);
	FA1 h3(co0[5],s0[4],pp0[4],pp1[2],pp2[0],n3);
	FA1 h4(co0[6],s0[5],pp0[5],pp1[3],pp2[1],n4);
	FA1 h5(co0[7],s0[6],pp0[6],pp1[4],pp2[2],n5);
	FA1 h6(co0[8],s0[7],pp0[7],pp1[5],pp2[3],n6);
	FA1 h7(co0[9],s0[8],pp3[2],pp1[6],pp2[4],n7);
	FA1 h8(co0[10],s0[9],pp3[3],pp1[7],pp2[5],n8);
	FA1 h9(co0[11],s0[10],pp1[7],pp3[4],pp2[6],n9);
	FA1 h10(co0[12],s0[11],pp1[7],pp3[5],pp2[7],n10);
	FA1 h11(co0[13],s0[12],pp1[7],pp3[6],pp2[7],n8);
	////second layer
	wire [12:0] co1,s1;
	HA1 hh0(co1[2],s1[1],pp0[1],co0[1],nn0);
	HA1 hh1(co1[4],s1[3],s0[3],co0[3],nn1);
	FA1 hh2(co1[5],s1[4],s0[4],co0[4],ADD[2],nn2);
	HA1 hh3(co1[6],s1[5],s0[5],co0[5],nn3);
	FA1 hh4(co1[7],s1[6],s0[6],pp3[0],ADD[3],nn4);
	FA1 hh5(co1[8],s1[7],s0[7],pp3[1],co0[7],nn5);
	
	FA1 hh6(co1[9],s1[8],s0[8],co0[8],pp0[7],nn6);
	FA1 hh7(co1[10],s1[9],s0[9],co0[9],pp0[7],nn7);
	FA1 hh8(co1[11],s1[10],s0[10],co0[10],pp0[7],nn8);
	FA1 hh9(co1[12],s1[11],s0[11],co0[11],pp0[7],nn9);
	FA1 hh10(co1[13],s1[12],pp3[6],co0[12],pp0[7],nn10);
	////third layer
	wire [12:0] co2,s2;
	HA1 f0(co2[3],s2[2],s1[2],co1[2],nn0);
	HA1 f1(co2[5],s2[4],s1[4],co1[4],nn0);
	HA1 f2(co2[6],s2[5],s1[5],co1[5],nn0);
	FA1 f3(co2[7],s2[6],s1[6],co1[6],co0[6],nn2);
	HA1 f4(co2[8],s2[7],s1[7],co1[7],nn0);
	HA1 f5(co2[9],s2[8],s1[8],co1[8],nn0);
	HA1 f6(co2[10],s2[9],s1[9],co1[9],nn0);
	HA1 f7(co2[11],s2[10],s1[10],co1[10],nn0);
	HA1 f8(co2[12],s2[11],s1[11],co1[11],nn0);
	HA1 f9(co2[13],s2[12],s1[12],co1[12],nn0);
	///total
	AN2 a0(s2[0],s0[0],1,N0);
	AN2 a1(s2[1],s1[1],1,N1);
	AN2 a2(s2[3],s1[3],1,N2);
	
	ND2 a3(co2[0],1,1,N2);///////////reduce?
	ND2 a4(co2[1],1,1,N2);
	ND2 a5(co2[2],1,1,N2);
	ND2 a6(co2[4],1,1,N2);
	
endmodule
/*
module signextension(pp0,pp1,pp70,pp71,pp72,pp73,ADD,PP0,PP1,PP70,PP71,PP72,PP73);
	input [6:0] pp0,pp1;
	input [7:0] pp70,pp71,pp72,pp73;
	input [5:0] ADD;
	output [10:0] PP0,PP1;
	output [12:0] PP70,PP71,PP72,PP73;
endmodule
*/
module wallacetree46(pp0,pp1,ADD,s,co,NUM);
	input [6:0] pp0,pp1;
	input [1:0] ADD;
	output [10:0] s,co;
	output [50:0] NUM;
	
	HA1 f1(co[1],s[0],pp0[0],ADD[0],n0);
	FA1 f2(co[3],s[2],pp0[2],pp1[0],ADD[1],n1);
	HA1 f3(co[4],s[3],pp0[3],pp1[1],n2);
	HA1 f4(co[5],s[4],pp0[4],pp1[2],n3);
	HA1 f5(co[6],s[5],pp0[5],pp1[3],n4);
	HA1 f6(co[7],s[6],pp0[6],pp1[4],n5);
	HA1 f7(co[8],s[7],pp0[6],pp1[5],n6);
	HA1 f8(co[9],s[8],pp0[6],pp1[6],n7);
	
	AN2 a0(co[10],1,co[8],n8);
	AN2 a1(s[9],1,s[8],n9);
	AN2 a2(s[10],1,s[8],n10);
	AN2 a3(s[1],1,pp0[1],n11);
	ND2 a4(co[0],1,1,n12);
	ND2 a5(co[2],1,1,n13);
	// remember that co[0],co[1] is not defined yet.
	//HA1 f9(co[9],s[9],pp0[6],pp1[6],n8);
	//HA1 f0(co[10],s[10],pp0[6],pp1[6],n9);
endmodule

	


