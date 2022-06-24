//adder for 32 bits
module ADD_4 //(x,y,cin,sum);
  ( input [31:0] x,
    input [31:0] y,
    input c_in, 
  output  c_out,
  output [31:0] sum);
  
  
   //always @ (x or y or c_in) begin
    assign {c_out, sum} = x + y + c_in;
  
endmodule
//multiplier for 2 bits
module MUL_4( input [1:0] x, y,
             output [1:0] cout, z );
  assign {cout, z} = x * y;
endmodule
//multiplier for 32 bits
module MUL_32( input [31:0] x, y,
              output [31:0] cout, z );
  assign {cout, z} = x * y;
endmodule
//fused multiply add for 32 bits
module FMA_32( input [31:0] x,y,z,
              output [31:0] out );
  wire [31:0] p_co,prod;
  wire s_co, s_cin;
  assign s_cin = 0;
  
  MUL_32 m(x,y,p_co,prod);
  ADD_4  s(prod,z,s_cin,s_co,out);
  
endmodule
//an example
//module full_adder(carry,sum,x,y,z);

	//input  x,y,z;
	//output wire carry,sum;
	//assign {carry,sum}=x+y+z;
//endmodule


  
           
//horner's algorithm

module Horn_32(input [31:0] x1,x2,x3,
               input [31:0] y1,y2,y3,
               input [31:0] z0,
               output [31:0] out);
  
  //reg [31:0] coeff;
  wire [31:0] z1,z2;
 // integer i;
  
  //assign z0 =0;
  //assign z1 = x1*y1;
  //assign z2 = z1 + x2*y2;
 // assign out = z2 + x3*y3;
    
  FMA_32 t1(x1,y1,z0,z1);
  FMA_32 t2(x2,y2,z1,z2);
  FMA_32 t3(x3,y3,z2,out);
  
  //always@(coeff)begin
  //  for ( i=1; i<=32;i++)
  //   out(32-i) = out*()+coeff[i];
 // end
  
           
endmodule 



//test_bench for the FMA and horner's algorithm...

module full_adder_test();

    //reg [31:0] x,y,z, sum,temp_v;
  //reg [31:0] x,y,z,prod,temp_v;
  reg [31:0] x1,x2,x3,y1,y2,y3,z0,out;
	//reg cout, cin,temp;
  
  //ADD_4 m1(x,y,cin,temp, temp_v );
 // ADD_4 m2(temp_v,z,temp,cout,sum);
  //FMA_32 p1(x,y,z,prod);
  
  Horn_32 p1(x1,x2,x3,y1,y2,y3,z2,out);
	initial begin
      $dumpfile("dump.vcd"); $dumpvars;

      // x=4'h0;   y=4'h0;   cin=4'h0;
     // #5 x = 4'h0; y = 4'h1; cin=4'h0;
     // #5 x = 4'ha; y = 4'h3; cin=4'h0;
     // #5 x = 4'ha; y = 4'h9; cin=4'h0;
     // #5 x = 32'hffffffff; y = 4'ha; cin = 0;
     // #20 x = 0; y = 0; cin = 0;
      
      //x=0;y=0;z=0;
     // #5 x=32'h000000ff; y=32'h00000ff0; z=32'h00000400;
      //#20 x = 0;
      
      x1=0;x2=0;x3=0; y1=0;y2=0;y3=0;z0=0;
      #5 x1 = 32'h00000005; x2=32'h00000080; x3 = 32'h000003ff; y1=32'h00000006; y2=32'h00001000; 		             y3=32'h000000005; z0=32'h0;
      #20 x1 = 32'd1; y1=32'd8; 


	end

endmodule
