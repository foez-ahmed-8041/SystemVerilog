////////////////////////////////////////////////////////////////////////////////////////////////////
//
//    Author      : Foez Ahmed
//
//    Email       : foez.official@gmail.com
//
//    module      : ...
//
//    Description : ...
//
////////////////////////////////////////////////////////////////////////////////////////////////////

module ff_back_to_back #(
    parameter int NumStages = 4
) (
    input  logic clk_i,
    input  logic arst_ni,
    input  logic en_i,
    input  logic d_i,
    output logic q_o
);

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  logic [NumStages-1:0] mem;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // ASSIGNMENTS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  assign q_o = mem[NumStages-1];

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SEQUENCIALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  always_ff @(posedge clk_i or negedge arst_ni) begin
    if (~arst_ni) begin
      mem <= '0;
    end else begin
      if (en_i) begin
        mem <= {mem[NumStages-2:0], d_i};
      end
    end
  end

endmodule
