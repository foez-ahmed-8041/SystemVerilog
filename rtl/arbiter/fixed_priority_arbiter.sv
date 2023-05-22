////////////////////////////////////////////////////////////////////////////////////////////////////
//
//    AUTHOR      : Foez Ahmed
//    EMAIL       : foez.official@gmail.com
//
//    MODULE      : fixed_priority_arbiter
//    DESCRIPTION : general purpose fixed priority arbiter. req_i[0] has the highest priority
//
////////////////////////////////////////////////////////////////////////////////////////////////////

/*
                allow_req_i          arst_ni
                ---↓--------------------↓---
               ¦                            ¦
[NumReq] req_i →                            → [NumReq] gnt_o
               ¦   fixed_priority_arbiter   ¦
          en_i →                            ¦
               ¦                            ¦
                ----------------------------
*/

module fixed_priority_arbiter #(
    parameter int NumReq = 4
) (
    input  logic              arst_ni,
    input  logic              allow_req_i,
    input  logic              en_i,
    input  logic [NumReq-1:0] req_i,
    output logic [NumReq-1:0] gnt_o
);

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  logic [NumReq-1:0] gnt_already_found;
  logic [NumReq-1:0] latch_out;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // ASSIGNMENTS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  assign gnt_already_found[0] = ~allow_req_i;
  for (genvar i = 1; i < NumReq; i++) begin : g_gnt_found
    assign gnt_already_found[i] = gnt_already_found[i-1] | gnt_o[i-1];
  end

  for (genvar i = 0; i < NumReq; i++) begin : g_gnt
    assign gnt_o[i] = gnt_already_found[i] ? '0 : latch_out[i];
  end

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // RTLS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  latch #(
      .ElemWidth(NumReq)
  ) u_latch_req_i (
      .arst_ni(arst_ni),
      .en_i(en_i),
      .d_i (req_i),
      .q_o (latch_out)
  );

endmodule
