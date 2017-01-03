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
	
	wire b01,b02,b03,b04,b05,b06b,b16b,b26b,b36b,b46b,b56b,b12,b13,b14,b15,b25,b35,b45,b23,b24,b34;
	wire [21:0] B0;
	wire [50:0] NUM00,NUM0,NUM1,NUM2,NUM3,NUM4,NUM5;
	wire [50:0] n0,n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,n14,n15,n16,n17,n18,n19,n20,nn;
	
	AN2 ng0(b01,B[0],B[1],n0); ND2 ng5(b06b,B[0],B[6],n5);
	AN2 ng1(b02,B[0],B[2],n1); ND2 ng6(b16b,B[1],B[6],n6);
	AN2 ng2(b03,B[0],B[3],n2); ND2 ng7(b26b,B[2],B[6],n7);
	AN2 ng3(b04,B[0],B[4],n3); ND2 ng8(b36b,B[3],B[6],n8);
	AN2 ng4(b05,B[0],B[5],n4); ND2 ng9(b46b,B[4],B[6],n9);
							  ND2 ng10(b56b,B[5],B[6],n10);
	AN2 ng11(b12,B[1],B[2],n11); AN2 ng15(b25,B[2],B[5],n15);
	AN2 ng12(b13,B[1],B[3],n12); AN2 ng16(b35,B[3],B[5],n16);
	AN2 ng13(b14,B[1],B[4],n13); AN2 ng17(b45,B[4],B[5],n17);
	AN2 ng14(b15,B[1],B[5],n14);
	AN2 ng18(b23,B[2],B[3],n18);
	AN2 ng19(b24,B[2],B[4],n19);
	AN2 ng20(b34,B[3],B[4],n20);
	assign NUM1 = n0+n1+n2+n3+n4+n5+n6+n7+n8+n9+n10+n11+n12+n13+n14+n15+n16+n17+n18+n19+n20;
	
	wire [5:0] a0,a1,a2,a3,a33;
	wire [13:0] co0,co1,co2,s0,s1,s2;
	ppac pp1(A,C,a0,a1,a2,a3,a33,NUM1);
	wire [50:0] N0,N1,N2,N3,N4,N5,N6,N7,N8,N9,N10,D0,D1,D2,D3,D4,D5,D6,U0,U1,U2;
	
	FA1 f0(co0[3],s0[2],b01,B[1],a0[0],N0);			FA1 d0(co1[5],s1[4],a0[2],a1[1],a2[0],D0); 	FA1 u0(co2[7],s2[6],a2[2],a3[1],a3[0],U0);
	FA1 f1(co0[4],s0[3],b02,a0[1],a1[0],N1);		FA1 d1(co1[6],s1[5],a1[2],a2[1],a3[0],D1); 	FA1 u1(co2[8],s2[7],a3[2],a3[1],a33[0],U1); 
	FA1 f2(co0[5],s0[4],b03,b12,B[2],N2);			FA1 d2(co1[7],s1[6],B[3],a0[4],a1[3],D2); 	FA1 u2(co2[9],s2[8],a3[3],a3[2],a33[1],U2); 
	FA1 f3(co0[6],s0[5],b04,b13,a0[3],N3);			FA1 d3(co1[8],s1[7],a0[5],a1[4],a2[3],D3);  
	FA1 f4(co0[7],s0[6],b05,b14,b23,N4);			FA1 d4(co1[9],s1[8],B[4],a1[5],a2[4],D4); 
	FA1 f5(co0[8],s0[7],b06b,b15,b24,N5);			FA1 d5(co1[10],s1[9],a3[4],a3[3],a33[2],D5);
	FA1 f6(co0[9],s0[8],b16b,b25,b34,N6);			FA1 d6(co1[11],s1[10],a3[5],a3[4],a33[3],D6);
	FA1 f7(co0[10],s0[9],b26b,b35,a2[5],N7);
	FA1 f8(co0[11],s0[10],b36b,b45,B[5],N8);
	FA1 f9(co0[12],s0[11],b46b,a3[5],a33[4],N9);
	FA1 f10(co0[13],s0[12],b56b,B[6],a33[5],N10);
	
	assign NUM2 = N0+N1+N2+N3+N4+N5+N6+N7+N8+N9+N10+D0+D1+D2+D3+D4+D5+D6+U0+U1+U2;
	wire [14:0] s,co;
	AN2 nn1(s0[0],B[0],1'b1,NUM0);
	IV i0(s0[1],1'b1,n0);
	wallace w1(s0,s1,s2,co0,co1,co2,s,co,NUM3);
	
	//wire [14:0] ss,cco;
	//register r1(s,co,ss,cco,clk,rst,NUM5);
	
	wire [14:0] D00;
	CPA c0(s,co,D00,clk,rst,NUM4);
	registerD r2(D00,D,clk,rst);
	
	assign DOQE_ppl_num = NUM0+NUM1+NUM2+NUM3+NUM4+NUM5;
endmodule

module registerD(d0,d,clk,rst);
	input [14:0] d0;
	//input [50:0] n0;
	input clk,rst;
	output [14:0] d;
	//output [50:0] n;
	wire [50:0]n0,n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,n14;
	
	FD2 fd0(d[0],d0[0],clk,rst,n0);
	FD2 fd1(d[1],d0[1],clk,rst,n1);
	FD2 fd2(d[2],d0[2],clk,rst,n2);
	FD2 fd3(d[3],d0[3],clk,rst,n3);
	FD2 fd4(d[4],d0[4],clk,rst,n4);
	FD2 fd5(d[5],d0[5],clk,rst,n5);
	FD2 fd6(d[6],d0[6],clk,rst,n6);
	FD2 fd7(d[7],d0[7],clk,rst,n7);
	FD2 fd8(d[8],d0[8],clk,rst,n8);
	FD2 fd9(d[9],d0[9],clk,rst,n9);
	FD2 fd10(d[10],d0[10],clk,rst,n10);
	FD2 fd11(d[11],d0[11],clk,rst,n11);
	FD2 fd12(d[12],d0[12],clk,rst,n12);
	FD2 fd13(d[13],d0[13],clk,rst,n13);
	FD2 fd14(d[14],d0[14],clk,rst,n14);

endmodule

module 	register(d,co,s,s1,D,CO,S,S1,clk,rst,NUM);
	input [6:0] d,s,s1;
	input co;
	input clk,rst;
	output [6:0] D,S,S1;
	output CO;
	output [50:0] NUM;
	
	wire [50:0]n0,n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,n14,n01,n02,n03,n04,n05,n06,n07,n08,n09,n010,n011,n012,n013,n014,n015;
	FD2 fd0(S[0],s[0],clk,rst,n0);
	FD2 fd1(S[1],s[1],clk,rst,n1);
	FD2 fd2(S[2],s[2],clk,rst,n2);
	FD2 fd3(S[3],s[3],clk,rst,n3);
	FD2 fd4(S[4],s[4],clk,rst,n4);
	FD2 fd5(S[5],s[5],clk,rst,n5);
	FD2 fd6(S[6],s[6],clk,rst,n6);
	
	FD2 fd7(CO,co,clk,rst,n7);
	
	FD2 fd8(D[0],d[0],clk,rst,n8);
	FD2 fd9(D[1],d[1],clk,rst,n9);
	FD2 fd10(D[2],d[2],clk,rst,n10);
	FD2 fd11(D[3],d[3],clk,rst,n11);
	FD2 fd12(D[4],d[4],clk,rst,n12);
	FD2 fd13(D[5],d[5],clk,rst,n13);
	FD2 fd00(D[6],d[6],clk,rst,n01);
	
	FD2 fd07(S1[0],s1[0],clk,rst,n08);
	FD2 fd01(S1[1],s1[1],clk,rst,n02);
	FD2 fd02(S1[2],s1[2],clk,rst,n03);
	FD2 fd03(S1[3],s1[3],clk,rst,n04);
	FD2 fd04(S1[4],s1[4],clk,rst,n05);
	FD2 fd05(S1[5],s1[5],clk,rst,n06);
	FD2 fd06(S1[6],s1[6],clk,rst,n07);
	
	assign NUM = n0+n1+n2+n3+n4+n5+n6+n7+n8+n9+n10+n11+n12+n13+n14+n01+n02+n03+n04+n05+n06+n07+n08+n09+n010+n011+n012+n013+n014+n015;

endmodule

module CPA(s,s1,d,clk,rst,NUM);
	input [14:0] s,s1;
	input clk,rst;
	output[14:0] d;
	output[50:0] NUM;
	
	wire [50:0] n00,n0,n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,N1;
	wire [15:0] cout;
	wire [6:0] dd;
	
	AN2 A0(dd[0],s[0],1'b1,n0);
	AN2 A1(dd[1],s[1],1'b1,n00);
	AN2 a0(dd[2],s[2],1'b1,n1);
	AN2 a1(dd[3],s[3],1'b1,n2);
	AN2 a2(dd[4],s[4],1'b1,n3);
	HA1 f0(cout[6],dd[5],s[5],s1[5],n4);
	FA1 f1(cout[7],dd[6],s[6],s1[6],cout[6],n5);
	///////////////////////////////////////////////////////register
	wire [6:0] ss,ss1;
	wire coutt;
	register r1(dd[6:0],cout[7],s[13:7],s1[13:7],d[6:0],coutt,ss,ss1,clk,rst,N1);
	
	FA1 f2(cout[8],d[7],ss[0],ss1[0],coutt,n6);
	FA1 f3(cout[9],d[8],ss[1],ss1[1],cout[8],n7);
	HA1 f4(cout[10],d[9],ss[2],cout[9],n8);
	FA1 f5(cout[11],d[10],ss[3],ss1[3],cout[10],n9);
	FA1 f6(cout[12],d[11],ss[4],ss1[4],cout[11],n10);
	FA1 f7(cout[13],d[12],ss[5],ss1[5],cout[12],n11);
	FA1 f8(cout[14],d[13],ss[6],ss1[6],cout[13],n12);
	AN2 a3(d[14],d[13],1'b1,n13);

	assign NUM = n00+n0+n1+n2+n3+n4+n5+n6+n7+n8+n9+n10+n11+n12+n13;
	
endmodule

module wallace(s0,s1,s2,co0,co1,co2,s,co,NUM);
	input [13:0] s0,s1,s2,co0,co1,co2;
	output[14:0] s,co;
	output[50:0] NUM;
	
	//second layer
	wire [13:0] ss0,ss1,cco0,cco1;
	wire [50:0] n0,n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,d0,d1,d2,d3,d4;
	wire [50:0] N1;
	HA1 f0(cco0[3],s[2],s0[2],1'b1,n0);
	FA1 f1(cco0[4],ss0[3],s0[3],co0[3],1'b1,n1);
	FA1 f2(cco0[5],ss0[4],s0[4],s1[4],co0[4],n2);
	FA1 f3(cco0[6],ss0[5],s0[5],s1[5],co0[5],n3);
	FA1 f4(cco0[7],ss0[6],s0[6],s1[6],s2[6],n4);
	FA1 f5(cco0[8],ss0[7],s0[7],s1[7],s2[7],n5);
	FA1 f6(cco0[9],ss0[8],s0[8],s1[8],s2[8],n6);
	FA1 f7(cco0[10],ss0[9],s0[9],s1[9],co0[9],n7);
	FA1 f8(cco0[11],ss0[10],s0[10],s1[10],co0[10],n8);
	FA1 f9(cco0[12],ss0[11],s0[11],co0[11],co1[11],n9);
	HA1 f10(cco0[13],ss0[12],s0[12],co0[12],n10);
	
	HA1 h0(cco1[6],ss1[5],co1[5],1'b1,d0);
	FA1 h1(cco1[7],ss1[6],co0[6],co1[6],1'b1,d1);
	FA1 h2(cco1[8],ss1[7],co0[7],co1[7],co2[7],d2);
	FA1 h3(cco1[9],ss1[8],co0[8],co1[8],co2[8],d3);
	HA1 h4(cco1[10],ss1[9],co1[9],co2[9],d4);
	assign N1 = n0+n1+n2+n3+n4+n5+n6+n7+n8+n9+n10+d0+d1+d2+d3+d4;
	//third layer
	wire [13:0] sss0,sss1,ccco0,ccco1;
	wire [50:0] k0,k1,k2,k3,k4,k5,k6,k7,k8,k9,k10;
	HA1 b0(ccco0[4],s[3],ss0[3],cco0[3],k0);
	FA1 b1(ccco0[5],sss0[4],ss0[4],cco0[4],1'b1,k1);
	FA1 b2(ccco0[6],sss0[5],ss0[5],ss1[5],cco0[5],k2);
	FA1 b3(ccco0[7],sss0[6],ss0[6],ss1[6],cco0[6],k3);
	FA1 b4(ccco0[8],sss0[7],ss0[7],ss1[7],cco0[7],k4);
	FA1 b5(ccco0[9],sss0[8],ss0[8],ss1[8],cco0[8],k5);
	FA1 b6(ccco0[10],sss0[9],ss0[9],ss1[9],cco0[9],k6);
	FA1 b7(ccco0[11],sss0[10],ss0[10],cco0[10],cco1[10],k7);
	HA1 b8(ccco0[12],sss0[11],ss0[11],cco0[11],k8);
	HA1 b9(ccco0[13],sss0[12],ss0[12],cco0[12],k9);
	HA1 c0(ccco1[9],sss1[8],cco1[8],1'b1,k10);
	//forth layer
	wire [13:0] ssss,cccco;
	wire [50:0] x0,x1,x2,x3,x4,x5,x6,x7,x8;
	HA1 dd0(co[5],s[4],sss0[4],ccco0[4],x0);
	HA1 dd1(co[6],s[5],sss0[5],ccco0[5],x1);
	FA1 dd2(co[7],s[6],sss0[6],ccco0[6],cco1[6],x2);
	FA1 dd3(co[8],s[7],sss0[7],ccco0[7],cco1[7],x3);
	FA1 dd4(cccco[9],s[8],sss0[8],sss1[8],ccco0[8],x4);
	FA1 dd5(cccco[10],ssss[9],sss0[9],ccco0[9],ccco1[9],x5);
	FA1 dd6(cccco[11],ssss[10],sss0[10],ccco0[10],co1[10],x6);
	HA1 dd7(cccco[12],ssss[11],sss0[11],ccco0[11],x7);
	HA1 dd8(cccco[13],ssss[12],sss0[12],ccco0[12],x8);
	//final layer
	wire [50:0] d40,d41,d42,d43,d44,d45,d46,d47,d48,d49,d50,d51,d52,d53,d54,d55;
	wire [6:0] temp;
	FA1 e0(co[10],s[9],ssss[9],cccco[9],cco1[9],d40);
	HA1 e1(co[11],s[10],ssss[10],cccco[10],d41);
	HA1 e2(temp[2],s[11],ssss[11],cccco[11],d42);  //temp[2] == co[12]
	HA1 e3(temp[0],temp[1],ssss[12],cccco[12],d43);  //temp[1] == s[12]
	
	AN2 i4(temp[3],temp[1],temp[2],d46);
	EO e4(s[12],temp[3],temp[1],d47);
	EO e5(co[12],temp[3],temp[2],d53);
	
	EO e6(s[13],temp[3],temp[1],d44);
	EO e7(co[13],temp[3],temp[2],d45);

	AN2 a4(s[0],s0[0],1'b1,d48);
	AN2 a5(s[1],s0[1],1'b1,d49);
	IV  i0(co[9],1'b1,d50);
	IV  i1(co[0],1'b1,d51);
	IV  i2(co[1],1'b1,d52);
	
	assign NUM = N1+k0+k1+k2+k3+k4+k5+k6+k7+k8+k9+k10+x0+x1+x2+x3+x4+x5+x6+x7+x8+d40+d41+d42+d43+d44+d45+d46+d47+d48+d49;
endmodule

module ppac(A,C,a0,a1,a2,a3,a33,NUM);
	input [3:0] A;
	input [5:0] C;
	output [5:0] a0,a1,a2,a3,a33;
	output [50:0] NUM;
	
	wire [50:0] n0,n1,n2,n3,n4,n5;
	wire [50:0] N0,N1,N2,N3,N4,N5;
	wire [50:0] nn0,nn1,nn2,nn3,nn4,nn5;
	wire [50:0] n00,n01,n02,n03,n04,n05;
	wire [50:0] k0,k1,k2,k3,k4,k5;
	
	ND2 ng0(a0[0],A[0],C[0],n0);
	ND2 ng1(a0[1],A[0],C[1],n1);
	ND2 ng2(a0[2],A[0],C[2],n2);
	ND2 ng3(a0[3],A[0],C[3],n3);
	ND2 ng4(a0[4],A[0],C[4],n4);
	AN2 ng5(a0[5],A[0],C[5],n5);
	
	ND2 Ng0(a1[0],A[1],C[0],N0);
	ND2 Ng1(a1[1],A[1],C[1],N1);
	ND2 Ng2(a1[2],A[1],C[2],N2);
	ND2 Ng3(a1[3],A[1],C[3],N3);
	ND2 Ng4(a1[4],A[1],C[4],N4);
	AN2 Ng5(a1[5],A[1],C[5],N5);
	
	ND2 nng0(a2[0],A[2],C[0],nn0);
	ND2 nng1(a2[1],A[2],C[1],nn1);
	ND2 nng2(a2[2],A[2],C[2],nn2);
	ND2 nng3(a2[3],A[2],C[3],nn3);
	ND2 nng4(a2[4],A[2],C[4],nn4);
	AN2 nng5(a2[5],A[2],C[5],nn5);
	
	ND2 ng00(a3[0],A[3],C[0],n00);
	ND2 ng01(a3[1],A[3],C[1],n01);
	ND2 ng02(a3[2],A[3],C[2],n02);
	ND2 ng03(a3[3],A[3],C[3],n03);
	ND2 ng04(a3[4],A[3],C[4],n04);
	AN2 ng05(a3[5],A[3],C[5],n05);
	
	IV no0(a33[0],a3[0],k0);
	IV no1(a33[1],a3[1],k1);
	IV no2(a33[2],a3[2],k2);
	IV no3(a33[3],a3[3],k3);
	IV no4(a33[4],a3[4],k4);
	IV no5(a33[5],a3[5],k5);
	
	assign NUM = n0+n1+n2+n3+n4+n5+N0+N1+N2+N3+N4+N5+nn0+nn1+nn2+nn3+nn4+nn5+n00+n01+n02+n03+n04+n05+k0+k1+k2+k3+k4+k5;
endmodule























