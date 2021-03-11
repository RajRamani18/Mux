
`timescale 1 ns / 1 ns

module mux_tb ;

  parameter PERIOD = 10 ;

  logic        clk    ;
  logic [3:0]  in1    ;
  logic [3:0]  in2    ;
  logic [3:0]  in3    ;
  logic [2:0]  sel    ;
  logic [3:0]  mux_op ;


  mux mux_dut
  (
    .clk    ( clk    ),
    .in1    ( in1    ),
    .in2    ( in2    ),
    .in3    ( in3    ),
    .sel1   ( sel[0] ),
    .sel2   ( sel[1] ),
    .sel3   ( sel[2] ),
    .mux_op ( mux_op )
  ) ;

  always
    begin
      clk <= 0 ;
      #(PERIOD/2);
      clk <= 1 ;
      #(PERIOD/2);
    end

  initial
    begin : TEST
      @(posedge clk);
      #(PERIOD/4); // Keep changes away from clock edges
      in1 <= 4'b0001 ;
      in2 <= 4'b0010 ;
      in3 <= 4'b0100 ;

      $display ("Starting 1st set of test vectors.");

      for (int i=0; i<=2; i++)
        begin
          sel <= 1<<i ;
          #(PERIOD) ;
        end

      $display ("Finished 1st set of test vectors.");

      $display ("Starting 2nd set of test vectors.");

      for (int i=0; i<=7; i++)
        begin
          sel <= i ;
          #(PERIOD) ;
        end

      $display ("Finished 2nd set of test vectors.");

      $stop ;
    end
   
endmodule
