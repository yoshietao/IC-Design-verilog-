module CPA77(A,B,O,NUM);
	input [12:0] A,B;
	output [13:0] S;
	output [50:0] NUM;
	
	wire [13:0] co;
	HA1 f1(co[0],S[0],A[0],B[0],n1);
	FA1 f2(co[1],S[1],A[1],B[1],co[0],n2);
	FA1 f3(co[2],S[2],A[2],B[2],co[1],n3);
	FA1 f4(co[3],S[3],A[3],B[3],co[2],n4);
	////////////
	wire [13:0] co1,co2,s1,s2;
	FA1 f5(co1[4],S1[4],A[4],B[4],co[3],n5);
	FA1 f6(co1[5],S1[5],A[5],B[5],co[4],n6);
	FA1 f7(co1[6],S1[6],A[6],B[6],co[5],n7);
	FA1 f8(co1[7],S1[7],A[7],B[7],co[6],n8);
	

endmodule