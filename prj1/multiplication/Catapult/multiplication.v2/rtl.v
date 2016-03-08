// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   al3515@EEWS104A-002
//  Generated date: Tue Mar 08 15:03:53 2016
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    multiplication_core
// ------------------------------------------------------------------


module multiplication_core (
  clk, en, arst_n, input_a_rsc_mgc_in_wire_d, input_b_rsc_mgc_in_wire_d, output_rsc_mgc_out_stdreg_d
);
  input clk;
  input en;
  input arst_n;
  input [39:0] input_a_rsc_mgc_in_wire_d;
  input [39:0] input_b_rsc_mgc_in_wire_d;
  output [39:0] output_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations
  wire [2:0] MAC_acc_4_tmp;
  wire [3:0] nl_MAC_acc_4_tmp;
  wire and_dcpl;
  wire and_dcpl_1;
  wire and_dcpl_2;
  wire or_dcpl_7;
  wire or_dcpl_10;
  reg exit_MAC_lpi;
  reg [7:0] io_read_output_rsc_d_sdt_sg4_lpi_dfm;
  reg [7:0] io_read_output_rsc_d_sdt_sg3_lpi_dfm;
  reg [7:0] io_read_output_rsc_d_sdt_sg2_lpi_dfm;
  reg [7:0] io_read_output_rsc_d_sdt_sg1_lpi_dfm;
  reg [7:0] io_read_output_rsc_d_sdt_1_lpi_dfm;
  reg [2:0] i_1_sva_1;
  wire [7:0] MAC_mul_cmx_sva;
  wire [15:0] nl_MAC_mul_cmx_sva;
  wire [2:0] i_1_lpi_dfm;

  wire[7:0] MAC_mux_nl;
  wire[7:0] MAC_mux_7_nl;

  // Interconnect Declarations for Component Instantiations 
  assign output_rsc_mgc_out_stdreg_d = {io_read_output_rsc_d_sdt_sg4_lpi_dfm , io_read_output_rsc_d_sdt_sg3_lpi_dfm
      , io_read_output_rsc_d_sdt_sg2_lpi_dfm , io_read_output_rsc_d_sdt_sg1_lpi_dfm
      , io_read_output_rsc_d_sdt_1_lpi_dfm};
  assign MAC_mux_nl = MUX_v_8_8_2({(input_a_rsc_mgc_in_wire_d[7:0]) , (input_a_rsc_mgc_in_wire_d[15:8])
      , (input_a_rsc_mgc_in_wire_d[23:16]) , (input_a_rsc_mgc_in_wire_d[31:24]) ,
      (input_a_rsc_mgc_in_wire_d[39:32]) , 8'b0 , 8'b0 , 8'b0}, i_1_lpi_dfm);
  assign MAC_mux_7_nl = MUX_v_8_8_2({(input_b_rsc_mgc_in_wire_d[7:0]) , (input_b_rsc_mgc_in_wire_d[15:8])
      , (input_b_rsc_mgc_in_wire_d[23:16]) , (input_b_rsc_mgc_in_wire_d[31:24]) ,
      (input_b_rsc_mgc_in_wire_d[39:32]) , 8'b0 , 8'b0 , 8'b0}, i_1_lpi_dfm);
  assign nl_MAC_mul_cmx_sva = (MAC_mux_nl) * (MAC_mux_7_nl);
  assign MAC_mul_cmx_sva = nl_MAC_mul_cmx_sva[7:0];
  assign i_1_lpi_dfm = i_1_sva_1 & (signext_3_1(~ exit_MAC_lpi));
  assign nl_MAC_acc_4_tmp = i_1_lpi_dfm + 3'b1;
  assign MAC_acc_4_tmp = nl_MAC_acc_4_tmp[2:0];
  assign and_dcpl = (~ exit_MAC_lpi) & (i_1_sva_1[1]);
  assign and_dcpl_1 = (~ exit_MAC_lpi) & (i_1_sva_1[0]);
  assign and_dcpl_2 = (~ exit_MAC_lpi) & (i_1_sva_1[2]);
  assign or_dcpl_7 = and_dcpl_2 | exit_MAC_lpi;
  assign or_dcpl_10 = and_dcpl_1 | and_dcpl_2;
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      io_read_output_rsc_d_sdt_sg4_lpi_dfm <= 8'b0;
      io_read_output_rsc_d_sdt_sg3_lpi_dfm <= 8'b0;
      io_read_output_rsc_d_sdt_sg2_lpi_dfm <= 8'b0;
      io_read_output_rsc_d_sdt_sg1_lpi_dfm <= 8'b0;
      io_read_output_rsc_d_sdt_1_lpi_dfm <= 8'b0;
      i_1_sva_1 <= 3'b0;
      exit_MAC_lpi <= 1'b1;
    end
    else begin
      if ( en ) begin
        io_read_output_rsc_d_sdt_sg4_lpi_dfm <= MUX_v_8_2_2({MAC_mul_cmx_sva , io_read_output_rsc_d_sdt_sg4_lpi_dfm},
            and_dcpl_1 | exit_MAC_lpi | and_dcpl | (~ (i_1_sva_1[2])));
        io_read_output_rsc_d_sdt_sg3_lpi_dfm <= MUX_v_8_2_2({MAC_mul_cmx_sva , io_read_output_rsc_d_sdt_sg3_lpi_dfm},
            or_dcpl_7 | (~ (i_1_sva_1[0])) | exit_MAC_lpi | (~ (i_1_sva_1[1])));
        io_read_output_rsc_d_sdt_sg2_lpi_dfm <= MUX_v_8_2_2({MAC_mul_cmx_sva , io_read_output_rsc_d_sdt_sg2_lpi_dfm},
            or_dcpl_10 | exit_MAC_lpi | (~ (i_1_sva_1[1])));
        io_read_output_rsc_d_sdt_sg1_lpi_dfm <= MUX_v_8_2_2({MAC_mul_cmx_sva , io_read_output_rsc_d_sdt_sg1_lpi_dfm},
            or_dcpl_7 | and_dcpl | (~ (i_1_sva_1[0])));
        io_read_output_rsc_d_sdt_1_lpi_dfm <= MUX_v_8_2_2({MAC_mul_cmx_sva , io_read_output_rsc_d_sdt_1_lpi_dfm},
            or_dcpl_10 | and_dcpl);
        i_1_sva_1 <= MAC_acc_4_tmp;
        exit_MAC_lpi <= ~ (readslicef_3_1_2((MAC_acc_4_tmp + 3'b11)));
      end
    end
  end

  function [7:0] MUX_v_8_8_2;
    input [63:0] inputs;
    input [2:0] sel;
    reg [7:0] result;
  begin
    case (sel)
      3'b000 : begin
        result = inputs[63:56];
      end
      3'b001 : begin
        result = inputs[55:48];
      end
      3'b010 : begin
        result = inputs[47:40];
      end
      3'b011 : begin
        result = inputs[39:32];
      end
      3'b100 : begin
        result = inputs[31:24];
      end
      3'b101 : begin
        result = inputs[23:16];
      end
      3'b110 : begin
        result = inputs[15:8];
      end
      3'b111 : begin
        result = inputs[7:0];
      end
      default : begin
        result = inputs[63:56];
      end
    endcase
    MUX_v_8_8_2 = result;
  end
  endfunction


  function [2:0] signext_3_1;
    input [0:0] vector;
  begin
    signext_3_1= {{2{vector[0]}}, vector};
  end
  endfunction


  function [7:0] MUX_v_8_2_2;
    input [15:0] inputs;
    input [0:0] sel;
    reg [7:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[15:8];
      end
      1'b1 : begin
        result = inputs[7:0];
      end
      default : begin
        result = inputs[15:8];
      end
    endcase
    MUX_v_8_2_2 = result;
  end
  endfunction


  function [0:0] readslicef_3_1_2;
    input [2:0] vector;
    reg [2:0] tmp;
  begin
    tmp = vector >> 2;
    readslicef_3_1_2 = tmp[0:0];
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    multiplication
//  Generated from file(s):
//    2) $PROJECT_HOME/../multiplication_source/multiplication.cpp
// ------------------------------------------------------------------


module multiplication (
  input_a_rsc_z, input_b_rsc_z, output_rsc_z, clk, en, arst_n
);
  input [39:0] input_a_rsc_z;
  input [39:0] input_b_rsc_z;
  output [39:0] output_rsc_z;
  input clk;
  input en;
  input arst_n;


  // Interconnect Declarations
  wire [39:0] input_a_rsc_mgc_in_wire_d;
  wire [39:0] input_b_rsc_mgc_in_wire_d;
  wire [39:0] output_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations for Component Instantiations 
  mgc_in_wire #(.rscid(1),
  .width(40)) input_a_rsc_mgc_in_wire (
      .d(input_a_rsc_mgc_in_wire_d),
      .z(input_a_rsc_z)
    );
  mgc_in_wire #(.rscid(2),
  .width(40)) input_b_rsc_mgc_in_wire (
      .d(input_b_rsc_mgc_in_wire_d),
      .z(input_b_rsc_z)
    );
  mgc_out_stdreg #(.rscid(3),
  .width(40)) output_rsc_mgc_out_stdreg (
      .d(output_rsc_mgc_out_stdreg_d),
      .z(output_rsc_z)
    );
  multiplication_core multiplication_core_inst (
      .clk(clk),
      .en(en),
      .arst_n(arst_n),
      .input_a_rsc_mgc_in_wire_d(input_a_rsc_mgc_in_wire_d),
      .input_b_rsc_mgc_in_wire_d(input_b_rsc_mgc_in_wire_d),
      .output_rsc_mgc_out_stdreg_d(output_rsc_mgc_out_stdreg_d)
    );
endmodule



