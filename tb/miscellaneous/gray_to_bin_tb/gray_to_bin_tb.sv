////////////////////////////////////////////////////////////////////////////////////////////////////
//
//    Author      : Razu
//
//    Email       : engr.razu.ahamed@gmail.com
//
//    module      : gray_to_bin_tb;
//
//    Description : It's verify gray to binary converter Module
//
////////////////////////////////////////////////////////////////////////////////////////////////////

module gray_to_bin_tb;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // IMPORTS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  `include "vip/tb_ess.sv"

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // LOCALPARAMS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  localparam int DataWidth = 11;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////


  logic [DataWidth-1:0] data_in_i;
  logic [DataWidth-1:0] data_out_o;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // RTLS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  gray_to_bin #(
      .DataWidth(DataWidth)
  ) gray_to_bin_dut (
      .data_in_i (data_in_i),
      .data_out_o(data_out_o)
  );

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // METHODS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  function automatic logic [DataWidth-1:0] data_out_gray_to_bin(logic [DataWidth-1:0] data_in);
    data_out_gray_to_bin[DataWidth-1] = data_in[DataWidth-1];
    for (int i = DataWidth - 2; i >= 0; i--) begin
      data_out_gray_to_bin[i] = data_out_gray_to_bin[i+1] ^ data_in[i];
    end
  endfunction

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // PROCEDURALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  initial begin

    static int fail = 0;
    static int pass = 0;

    for (int i = 0; i < 2 ** DataWidth; i++) begin
      data_in_i <= $urandom;
      #1;
      if (data_out_o !== data_out_gray_to_bin(data_in_i)) fail++;
      else pass++;
    end

    result_print(!fail, $sformatf("data conversion %0d/%0d", pass, pass+fail));

    $finish;

  end

endmodule
