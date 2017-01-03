
module wallacetree77(pp0,pp1,pp2,pp3,ADD,P0,P1,NUM);
	input [7:0] pp0,pp1,pp2,pp3;
	input [3:0] ADD;
	output [12:0] P0,P1;
	
	////first layer
	wire [12:0] co0,s0;
	HA1 h0(co0[0],s0[0],pp0[0],ADD[0],n0);
	FA1 h1(co0[2],s0[2],pp0[2],pp1[0],ADD[1],n1);
	HA1 h2(co0[3],s0[3],pp0[3],pp1[1],n2);
	FA1 h3(co0[4],s0[4],pp0[4],pp1[2],pp2[0],n3);
	FA1 h4(co0[5],s0[5],pp0[5],pp1[3],pp2[1],n4);
	FA1 h5(co0[6],s0[6],pp0[6],pp1[4],pp2[2],n5);
	FA1 h6(co0[7],s0[7],pp0[7],pp1[5],pp2[3],n6);
	FA1 h7(co0[8],s0[8],pp3[2],pp1[6],pp2[4],n7);
	FA1 h8(co0[9],s0[9],pp3[3],pp1[7],pp2[5],n8);
	HA1 h9(co0[10],s0[10],	  pp3[4],pp2[6],n9);
	HA1 h10(co0[11],s0[11]	 ,pp3[5],pp2[7],n10);
	////second layer
	wire [12:0] co1,s1;
	HA1 hh0(co1[1],s1[1],pp0[1],co0[0],nn0);
	HA1 hh1(co1[3],s1[3],s0[3],co0[2],nn1);
	FA1 hh2(co1[4],s1[4],s0[4],co0[3],ADD[2],nn2);
	HA1 hh3(co1[5],s1[5],s0[5],co0[4],nn3);
	FA1 hh4(co1[6],s1[6],s0[6],pp3[0],ADD[3],nn4);
	FA1 hh5(co1[7],s1[7],s0[7],pp3[1],co0[6],nn5);
	HA1 hh6(co1[8],s1[8],s0[8],co0[7],nn6);
	HA1 hh7(co1[9],s1[9],s0[9],co0[8],nn7);
	HA1 hh8(co1[10],s1[10],s0[10],co0[9],nn8);
	HA1 hh9(co1[11],s1[11],s0[11],co0[10],nn9);
	HA1 hh10(co1[12],s1[12],pp3[6],co0[11],nn10);
	////third layer
	wire [12:0] co2,s2;
	HA1 f0(co2[2],s2[2],s1[2],co1[1],nn0);
	HA1 f1(co2[4],s2[4],s1[4],co1[3],nn0);
	HA1 f2(co2[5],s2[5],s1[5],co1[4],nn0);
	FA1 f3(co2[6],s2[6],s1[6],co1[5],co0[5],nn2);
	HA1 f4(co2[7],s2[7],s1[7],co1[6],nn0);
	HA1 f5(co2[8],s2[8],s1[8],co1[7],nn0);
	HA1 f6(co2[9],s2[9],s1[9],co1[8],nn0);
	HA1 f7(co2[10],s2[10],s1[10],co1[9],nn0);
	HA1 f8(co2[11],s2[11],s1[11],co1[10],nn0);
	HA1 f9(co2[12],s2[12],s1[12],co1[11],nn0);
	///total
	AN2 a0(s2[0],s0[0],1,N0);
	AN2 a1(s2[1],s1[1],1,N1);
	AN2 a2(s2[3],s1[3],1,N2);
endmodule