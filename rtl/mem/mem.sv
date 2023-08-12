// A simple memory block.
// ### Author : Foez Ahmed (foez.official@gmail.com)

module mem #(
    parameter int ELEM_WIDTH = 8,  // Memory element width
    parameter int DEPTH      = 7   // Memory depth
) (
    input logic clk_i,   // Global clock
    input logic arst_ni, // Asynchronous reset

    input logic                     we_i,     // Write enable
    input logic [$clog2(DEPTH)-1:0] waddr_i,  // Write address
    input logic [   ELEM_WIDTH-1:0] wdata_i,  // write data

    input  logic [$clog2(DEPTH)-1:0] raddr_i, // Read address
    output logic [   ELEM_WIDTH-1:0] rdata_o  // Read data
);

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  logic [DEPTH-1:0] demux_we;  // Demux for write enable
  logic [DEPTH-1:0][ELEM_WIDTH-1:0] reg_mux_in;  // Mux in from memory elements

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-RTLS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  demux #(
      .NUM_ELEM(DEPTH)
  ) u_demux (
      .s_i(waddr_i),
      .i_i(we_i),
      .o_o(demux_we)
  );

  for (genvar i = 0; i < DEPTH; i++) begin : g_reg_array
    register #(
        .ELEM_WIDTH (ELEM_WIDTH),
        .RESET_VALUE('0)
    ) register_dut (
        .clk_i  (clk_i),
        .arst_ni(arst_ni),
        .en_i   (demux_we[i]),
        .d_i    (wdata_i),
        .q_o    (reg_mux_in[i])
    );
  end

  mux #(
      .ELEM_WIDTH(ELEM_WIDTH),
      .NUM_ELEM  (DEPTH)
  ) u_mux (
      .s_i(raddr_i),
      .i_i(reg_mux_in),
      .o_o(rdata_o)
  );

endmodule
