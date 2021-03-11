
`timescale 1 ns / 1 ns

module mux
(
  input  logic       clk    ,
  input  logic [3:0] in1    ,
  input  logic [3:0] in2    ,
  input  logic [3:0] in3    ,
  input  logic       sel1   ,
  input  logic       sel2   ,
  input  logic       sel3   ,
  output logic [3:0] mux_op  
) ;

    always @(posedge clk)
      if (sel1 == 1)
        mux_op <= in1 ;
      else
        if (sel2 == 1)
          mux_op <= in2 ;
        else
          if (sel3 == 1)
            mux_op <= in3 ;
    
//Assertions
    
    property SELECT_1;
        @(posedge clk) 
            (sel1 == 1'b1) |=> (mux_op == in1);
    endproperty
    
    property SELECT_2_a;
        @(posedge clk) 
            (sel2 == 1'b1) |=> (mux_op == in2);
    endproperty
    
    property SELECT_2_b;
        @(posedge clk) 
            ((sel1 == 1'b0) && (sel2 == 1'b1)) |=> (mux_op == in2);
    endproperty
    
    property SELECT_3_a;
        @(posedge clk) 
            (sel3 == 1'b1) |=> (mux_op == in3);
    endproperty
    
    property SELECT_3_b;
        @(posedge clk) 
            ((sel1 == 1'b0) && (sel2 == 1'b0) && (sel3 == 1'b1)) |=> (mux_op == in3);
    endproperty

    A1   : assert property (SELECT_1);
    A2_a : assert property (SELECT_2_a);
    A2_b : assert property (SELECT_2_b);
    A3_a : assert property (SELECT_3_a);
    A3_b : assert property (SELECT_3_b);

endmodule
