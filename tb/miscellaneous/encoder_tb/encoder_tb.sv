module encoder_tb;

  //`define ENABLE_DUMPFILE
  //`define DEBUG ;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-IMPORTS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // bring in the testbench essentials functions and macros
  `include "vip/tb_ess.sv"

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-LOCALPARAMS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  localparam int NumWire = 8;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  reg  [        NumWire-1:0] d_i;
  wire [$clog2(NumWire)-1:0] addr_o;
  wire                       addr_valid_o;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-ASSIGNMENTS
  //////////////////////////////////////////////////////////////////////////////////////////////////



  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-RTLS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  encoder #(
      .NUM_WIRE(NumWire)
  ) encoder_dut (
      .d_i(d_i),
      .addr_o(addr_o),
      .addr_valid_o(addr_valid_o)
  );


  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-PROCEDURALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  initial begin
    int pass = 0;
    int pass_valid = 0;
    int pass_addr_o = 0;
    // check :
    // valid check: if one d_i is high then addr_valid otherwise invalid
    // do an OR operation for the d_i index value if that particular index is high ---> result will be equal to add_o then PASS otherwise FAIL
    for (int i = 0; i < 2**NumWire; i++) begin
      int or_ = 0;
      d_i <= $urandom;
      #5;
      foreach (d_i[i]) begin
`ifdef DEBUG
        $display("d_i index =%0d", i);
`endif  //DEBUG
        if (d_i[i]) begin
          or_ |= i;
`ifdef DEBUG
          $display("d_i[%0d]=%0d", i, d_i[i]);
`endif  //DEBUG
        end
      end
      #20;
`ifdef DEBUG  // print or_
      $display("or_=%0d", or_);
`endif  //DEBUG
      if (or_ == addr_o) begin
        pass_addr_o = 1;
`ifdef DEBUG  //PASS print
        $display("PASS");
`endif  //DEBUG
      end
      if (or_ > 0) begin  // addr_valid_o check---->logic update --> index 0 | 0 => 0
        pass_valid = 1;
      end
`ifdef DEBUG
      $display("valid= %0d -------addr_valid_o=%0d", valid, addr_valid_o);
`endif  //DEBUG
      if (pass_valid == pass_addr_o) pass++;
    end
    #10;
    //$display("PASS=%0d",pass);
    if (pass == 2**NumWire) begin
      pass = 1;
    end
    else begin
      pass = 0;
    end
    result_print(pass, "Encoder Test");

    $finish;

  end
endmodule
