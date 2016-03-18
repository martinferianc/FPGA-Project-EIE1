
//------> ./rtl_mgc_ioport.v 
//------------------------------------------------------------------
//                M G C _ I O P O R T _ C O M P S
//------------------------------------------------------------------

//------------------------------------------------------------------
//                       M O D U L E S
//------------------------------------------------------------------

//------------------------------------------------------------------
//-- INPUT ENTITIES
//------------------------------------------------------------------

module mgc_in_wire (d, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output [width-1:0] d;
  input  [width-1:0] z;

  wire   [width-1:0] d;

  assign d = z;

endmodule

//------------------------------------------------------------------

module mgc_in_wire_en (ld, d, lz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input              ld;
  output [width-1:0] d;
  output             lz;
  input  [width-1:0] z;

  wire   [width-1:0] d;
  wire               lz;

  assign d = z;
  assign lz = ld;

endmodule

//------------------------------------------------------------------

module mgc_in_wire_wait (ld, vd, d, lz, vz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input              ld;
  output             vd;
  output [width-1:0] d;
  output             lz;
  input              vz;
  input  [width-1:0] z;

  wire               vd;
  wire   [width-1:0] d;
  wire               lz;

  assign d = z;
  assign lz = ld;
  assign vd = vz;

endmodule
//------------------------------------------------------------------

module mgc_chan_in (ld, vd, d, lz, vz, z, size, req_size, sizez, sizelz);

  parameter integer rscid = 1;
  parameter integer width = 8;
  parameter integer sz_width = 8;

  input              ld;
  output             vd;
  output [width-1:0] d;
  output             lz;
  input              vz;
  input  [width-1:0] z;
  output [sz_width-1:0] size;
  input              req_size;
  input  [sz_width-1:0] sizez;
  output             sizelz;


  wire               vd;
  wire   [width-1:0] d;
  wire               lz;
  wire   [sz_width-1:0] size;
  wire               sizelz;

  assign d = z;
  assign lz = ld;
  assign vd = vz;
  assign size = sizez;
  assign sizelz = req_size;

endmodule


//------------------------------------------------------------------
//-- OUTPUT ENTITIES
//------------------------------------------------------------------

module mgc_out_stdreg (d, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input    [width-1:0] d;
  output   [width-1:0] z;

  wire     [width-1:0] z;

  assign z = d;

endmodule

//------------------------------------------------------------------

module mgc_out_stdreg_en (ld, d, lz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input              ld;
  input  [width-1:0] d;
  output             lz;
  output [width-1:0] z;

  wire               lz;
  wire   [width-1:0] z;

  assign z = d;
  assign lz = ld;

endmodule

//------------------------------------------------------------------

module mgc_out_stdreg_wait (ld, vd, d, lz, vz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input              ld;
  output             vd;
  input  [width-1:0] d;
  output             lz;
  input              vz;
  output [width-1:0] z;

  wire               vd;
  wire               lz;
  wire   [width-1:0] z;

  assign z = d;
  assign lz = ld;
  assign vd = vz;

endmodule

//------------------------------------------------------------------

module mgc_out_prereg_en (ld, d, lz, z);

    parameter integer rscid = 1;
    parameter integer width = 8;

    input              ld;
    input  [width-1:0] d;
    output             lz;
    output [width-1:0] z;

    wire               lz;
    wire   [width-1:0] z;

    assign z = d;
    assign lz = ld;

endmodule

//------------------------------------------------------------------
//-- INOUT ENTITIES
//------------------------------------------------------------------

module mgc_inout_stdreg_en (ldin, din, ldout, dout, lzin, lzout, z);

    parameter integer rscid = 1;
    parameter integer width = 8;

    input              ldin;
    output [width-1:0] din;
    input              ldout;
    input  [width-1:0] dout;
    output             lzin;
    output             lzout;
    inout  [width-1:0] z;

    wire   [width-1:0] din;
    wire               lzin;
    wire               lzout;
    wire   [width-1:0] z;

    assign lzin = ldin;
    assign din = ldin ? z : {width{1'bz}};
    assign lzout = ldout;
    assign z = ldout ? dout : {width{1'bz}};

endmodule

//------------------------------------------------------------------
module hid_tribuf( I_SIG, ENABLE, O_SIG);
  parameter integer width = 8;

  input [width-1:0] I_SIG;
  input ENABLE;
  inout [width-1:0] O_SIG;

  assign O_SIG = (ENABLE) ? I_SIG : { width{1'bz}};

endmodule
//------------------------------------------------------------------

module mgc_inout_stdreg_wait (ldin, vdin, din, ldout, vdout, dout, lzin, vzin, lzout, vzout, z);

    parameter integer rscid = 1;
    parameter integer width = 8;

    input              ldin;
    output             vdin;
    output [width-1:0] din;
    input              ldout;
    output             vdout;
    input  [width-1:0] dout;
    output             lzin;
    input              vzin;
    output             lzout;
    input              vzout;
    inout  [width-1:0] z;

    wire               vdin;
    wire   [width-1:0] din;
    wire               vdout;
    wire               lzin;
    wire               lzout;
    wire   [width-1:0] z;
    wire   ldout_and_vzout;

    assign lzin = ldin;
    assign vdin = vzin;
    assign din = ldin ? z : {width{1'bz}};
    assign lzout = ldout;
    assign vdout = vzout ;
    assign ldout_and_vzout = ldout && vzout ;

    hid_tribuf #(width) tb( .I_SIG(dout),
                            .ENABLE(ldout_and_vzout),
                            .O_SIG(z) );

endmodule

//------------------------------------------------------------------

module mgc_inout_buf_wait (clk, en, arst, srst, ldin, vdin, din, ldout, vdout, dout, lzin, vzin, lzout, vzout, z);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter         ph_clk  =  1'b1; // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   =  1'b1; // clock enable polarity
    parameter         ph_arst =  1'b1; // async reset polarity
    parameter         ph_srst =  1'b1; // sync reset polarity

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ldin;
    output             vdin;
    output [width-1:0] din;
    input              ldout;
    output             vdout;
    input  [width-1:0] dout;
    output             lzin;
    input              vzin;
    output             lzout;
    input              vzout;
    inout  [width-1:0] z;

    wire               lzout_buf;
    wire               vzout_buf;
    wire   [width-1:0] z_buf;
    wire               vdin;
    wire   [width-1:0] din;
    wire               vdout;
    wire               lzin;
    wire               lzout;
    wire   [width-1:0] z;

    assign lzin = ldin;
    assign vdin = vzin;
    assign din = ldin ? z : {width{1'bz}};
    assign lzout = lzout_buf & ~ldin;
    assign vzout_buf = vzout & ~ldin;
    hid_tribuf #(width) tb( .I_SIG(z_buf),
                            .ENABLE((lzout_buf && (!ldin) && vzout) ),
                            .O_SIG(z)  );

    mgc_out_buf_wait
    #(
        .rscid   (rscid),
        .width   (width),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst)
    )
    BUFF
    (
        .clk     (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (ldout),
        .vd      (vdout),
        .d       (dout),
        .lz      (lzout_buf),
        .vz      (vzout_buf),
        .z       (z_buf)
    );


endmodule

module mgc_inout_fifo_wait (clk, en, arst, srst, ldin, vdin, din, ldout, vdout, dout, lzin, vzin, lzout, vzout, z);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter integer fifo_sz = 8; // fifo depth
    parameter         ph_clk  = 1'b1;  // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   = 1'b1;  // clock enable polarity
    parameter         ph_arst = 1'b1;  // async reset polarity
    parameter         ph_srst = 1'b1;  // sync reset polarity
    parameter integer ph_log2 = 3;     // log2(fifo_sz)
    parameter integer pwropt  = 0;     // pwropt

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ldin;
    output             vdin;
    output [width-1:0] din;
    input              ldout;
    output             vdout;
    input  [width-1:0] dout;
    output             lzin;
    input              vzin;
    output             lzout;
    input              vzout;
    inout  [width-1:0] z;

    wire               lzout_buf;
    wire               vzout_buf;
    wire   [width-1:0] z_buf;
    wire               comb;
    wire               vdin;
    wire   [width-1:0] din;
    wire               vdout;
    wire               lzin;
    wire               lzout;
    wire   [width-1:0] z;

    assign lzin = ldin;
    assign vdin = vzin;
    assign din = ldin ? z : {width{1'bz}};
    assign lzout = lzout_buf & ~ldin;
    assign vzout_buf = vzout & ~ldin;
    assign comb = (lzout_buf && (!ldin) && vzout);

    hid_tribuf #(width) tb2( .I_SIG(z_buf), .ENABLE(comb), .O_SIG(z)  );

    mgc_out_fifo_wait
    #(
        .rscid   (rscid),
        .width   (width),
        .fifo_sz (fifo_sz),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst),
        .ph_log2 (ph_log2),
        .pwropt  (pwropt)
    )
    FIFO
    (
        .clk   (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (ldout),
        .vd      (vdout),
        .d       (dout),
        .lz      (lzout_buf),
        .vz      (vzout_buf),
        .z       (z_buf)
    );

endmodule

//------------------------------------------------------------------
//-- I/O SYNCHRONIZATION ENTITIES
//------------------------------------------------------------------

module mgc_io_sync (ld, lz);

    input  ld;
    output lz;

    assign lz = ld;

endmodule

module mgc_bsync_rdy (rd, rz);

    parameter integer rscid   = 0; // resource ID
    parameter ready = 1;
    parameter valid = 0;

    input  rd;
    output rz;

    wire   rz;

    assign rz = rd;

endmodule

module mgc_bsync_vld (vd, vz);

    parameter integer rscid   = 0; // resource ID
    parameter ready = 0;
    parameter valid = 1;

    output vd;
    input  vz;

    wire   vd;

    assign vd = vz;

endmodule

module mgc_bsync_rv (rd, vd, rz, vz);

    parameter integer rscid   = 0; // resource ID
    parameter ready = 1;
    parameter valid = 1;

    input  rd;
    output vd;
    output rz;
    input  vz;

    wire   vd;
    wire   rz;

    assign rz = rd;
    assign vd = vz;

endmodule

//------------------------------------------------------------------

module mgc_sync (ldin, vdin, ldout, vdout);

  input  ldin;
  output vdin;
  input  ldout;
  output vdout;

  wire   vdin;
  wire   vdout;

  assign vdin = ldout;
  assign vdout = ldin;

endmodule

///////////////////////////////////////////////////////////////////////////////
// dummy function used to preserve funccalls for modulario
// it looks like a memory read to the caller
///////////////////////////////////////////////////////////////////////////////
module funccall_inout (d, ad, bd, z, az, bz);

  parameter integer ram_id = 1;
  parameter integer width = 8;
  parameter integer addr_width = 8;

  output [width-1:0]       d;
  input  [addr_width-1:0]  ad;
  input                    bd;
  input  [width-1:0]       z;
  output [addr_width-1:0]  az;
  output                   bz;

  wire   [width-1:0]       d;
  wire   [addr_width-1:0]  az;
  wire                     bz;

  assign d  = z;
  assign az = ad;
  assign bz = bd;

endmodule


///////////////////////////////////////////////////////////////////////////////
// inlinable modular io not otherwise found in mgc_ioport
///////////////////////////////////////////////////////////////////////////////

module modulario_en_in (vd, d, vz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output             vd;
  output [width-1:0] d;
  input              vz;
  input  [width-1:0] z;

  wire   [width-1:0] d;
  wire               vd;

  assign d = z;
  assign vd = vz;

endmodule

//------> ./rtl_mgc_ioport_v2001.v 
//------------------------------------------------------------------

module mgc_out_reg_pos (clk, en, arst, srst, ld, d, lz, z);

    parameter integer rscid   = 1;
    parameter integer width   = 8;
    parameter         ph_en   =  1'b1;
    parameter         ph_arst =  1'b1;
    parameter         ph_srst =  1'b1;

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ld;
    input  [width-1:0] d;
    output             lz;
    output [width-1:0] z;

    reg                lz;
    reg    [width-1:0] z;

    generate
    if (ph_arst == 1'b0)
    begin: NEG_ARST
        always @(posedge clk or negedge arst)
        if (arst == 1'b0)
        begin: B1
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (srst == ph_srst)
        begin: B2
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (en == ph_en)
        begin: B3
            lz <= ld;
            z  <= (ld) ? d : z;
        end
    end
    else
    begin: POS_ARST
        always @(posedge clk or posedge arst)
        if (arst == 1'b1)
        begin: B1
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (srst == ph_srst)
        begin: B2
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (en == ph_en)
        begin: B3
            lz <= ld;
            z  <= (ld) ? d : z;
        end
    end
    endgenerate

endmodule

//------------------------------------------------------------------

module mgc_out_reg_neg (clk, en, arst, srst, ld, d, lz, z);

    parameter integer rscid   = 1;
    parameter integer width   = 8;
    parameter         ph_en   =  1'b1;
    parameter         ph_arst =  1'b1;
    parameter         ph_srst =  1'b1;

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ld;
    input  [width-1:0] d;
    output             lz;
    output [width-1:0] z;

    reg                lz;
    reg    [width-1:0] z;

    generate
    if (ph_arst == 1'b0)
    begin: NEG_ARST
        always @(negedge clk or negedge arst)
        if (arst == 1'b0)
        begin: B1
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (srst == ph_srst)
        begin: B2
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (en == ph_en)
        begin: B3
            lz <= ld;
            z  <= (ld) ? d : z;
        end
    end
    else
    begin: POS_ARST
        always @(negedge clk or posedge arst)
        if (arst == 1'b1)
        begin: B1
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (srst == ph_srst)
        begin: B2
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (en == ph_en)
        begin: B3
            lz <= ld;
            z  <= (ld) ? d : z;
        end
    end
    endgenerate

endmodule

//------------------------------------------------------------------

module mgc_out_reg (clk, en, arst, srst, ld, d, lz, z); // Not Supported

    parameter integer rscid   = 1;
    parameter integer width   = 8;
    parameter         ph_clk  =  1'b1;
    parameter         ph_en   =  1'b1;
    parameter         ph_arst =  1'b1;
    parameter         ph_srst =  1'b1;

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ld;
    input  [width-1:0] d;
    output             lz;
    output [width-1:0] z;


    generate
    if (ph_clk == 1'b0)
    begin: NEG_EDGE

        mgc_out_reg_neg
        #(
            .rscid   (rscid),
            .width   (width),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
        )
        mgc_out_reg_neg_inst
        (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (ld),
            .d       (d),
            .lz      (lz),
            .z       (z)
        );

    end
    else
    begin: POS_EDGE

        mgc_out_reg_pos
        #(
            .rscid   (rscid),
            .width   (width),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
        )
        mgc_out_reg_pos_inst
        (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (ld),
            .d       (d),
            .lz      (lz),
            .z       (z)
        );

    end
    endgenerate

endmodule




//------------------------------------------------------------------

module mgc_out_buf_wait (clk, en, arst, srst, ld, vd, d, vz, lz, z); // Not supported

    parameter integer rscid   = 1;
    parameter integer width   = 8;
    parameter         ph_clk  =  1'b1;
    parameter         ph_en   =  1'b1;
    parameter         ph_arst =  1'b1;
    parameter         ph_srst =  1'b1;

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ld;
    output             vd;
    input  [width-1:0] d;
    output             lz;
    input              vz;
    output [width-1:0] z;

    wire               filled;
    wire               filled_next;
    wire   [width-1:0] abuf;
    wire               lbuf;


    assign filled_next = (filled & (~vz)) | (filled & ld) | (ld & (~vz));

    assign lbuf = ld & ~(filled ^ vz);

    assign vd = vz | ~filled;

    assign lz = ld | filled;

    assign z = (filled) ? abuf : d;

    wire dummy;
    wire dummy_bufreg_lz;

    // Output registers:
    mgc_out_reg
    #(
        .rscid   (rscid),
        .width   (1'b1),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst)
    )
    STATREG
    (
        .clk     (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (filled_next),
        .d       (1'b0),       // input d is unused
        .lz      (filled),
        .z       (dummy)            // output z is unused
    );

    mgc_out_reg
    #(
        .rscid   (rscid),
        .width   (width),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst)
    )
    BUFREG
    (
        .clk     (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (lbuf),
        .d       (d),
        .lz      (dummy_bufreg_lz),
        .z       (abuf)
    );

endmodule

//------------------------------------------------------------------

module mgc_out_fifo_wait (clk, en, arst, srst, ld, vd, d, lz, vz,  z);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter integer fifo_sz = 8; // fifo depth
    parameter         ph_clk  = 1'b1; // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   = 1'b1; // clock enable polarity
    parameter         ph_arst = 1'b1; // async reset polarity
    parameter         ph_srst = 1'b1; // sync reset polarity
    parameter integer ph_log2 = 3; // log2(fifo_sz)
    parameter integer pwropt  = 0; // pwropt


    input                 clk;
    input                 en;
    input                 arst;
    input                 srst;
    input                 ld;    // load data
    output                vd;    // fifo full active low
    input     [width-1:0] d;
    output                lz;    // fifo ready to send
    input                 vz;    // dest ready for data
    output    [width-1:0] z;

    wire    [31:0]      size;


      // Output registers:
 mgc_out_fifo_wait_core#(
        .rscid   (rscid),
        .width   (width),
        .sz_width (32),
        .fifo_sz (fifo_sz),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst),
        .ph_log2 (ph_log2),
        .pwropt  (pwropt)
        ) CORE (
        .clk (clk),
        .en (en),
        .arst (arst),
        .srst (srst),
        .ld (ld),
        .vd (vd),
        .d (d),
        .lz (lz),
        .vz (vz),
        .z (z),
        .size (size)
        );

endmodule



module mgc_out_fifo_wait_core (clk, en, arst, srst, ld, vd, d, lz, vz,  z, size);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter integer sz_width = 8; // size of port for elements in fifo
    parameter integer fifo_sz = 8; // fifo depth
    parameter         ph_clk  =  1'b1; // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   =  1'b1; // clock enable polarity
    parameter         ph_arst =  1'b1; // async reset polarity
    parameter         ph_srst =  1'b1; // sync reset polarity
    parameter integer ph_log2 = 3; // log2(fifo_sz)
    parameter integer pwropt  = 0; // pwropt

   localparam integer  fifo_b = width * fifo_sz;

    input                 clk;
    input                 en;
    input                 arst;
    input                 srst;
    input                 ld;    // load data
    output                vd;    // fifo full active low
    input     [width-1:0] d;
    output                lz;    // fifo ready to send
    input                 vz;    // dest ready for data
    output    [width-1:0] z;
    output    [sz_width-1:0]      size;

    reg      [( (fifo_sz > 0) ? fifo_sz : 1)-1:0] stat_pre;
    wire     [( (fifo_sz > 0) ? fifo_sz : 1)-1:0] stat;
    reg      [( (fifo_b > 0) ? fifo_b : 1)-1:0] buff_pre;
    wire     [( (fifo_b > 0) ? fifo_b : 1)-1:0] buff;
    reg      [( (fifo_sz > 0) ? fifo_sz : 1)-1:0] en_l;
    reg      [(((fifo_sz > 0) ? fifo_sz : 1)-1)/8:0] en_l_s;

    reg       [width-1:0] buff_nxt;

    reg                   stat_nxt;
    reg                   stat_before;
    reg                   stat_after;
    reg                   en_l_var;

    integer               i;
    genvar                eni;

    wire [32:0]           size_t;
    reg [31:0]            count;
    reg [31:0]            count_t;
    reg [32:0]            n_elem;
// pragma translate_off
    reg [31:0]            peak;
// pragma translate_on

    wire [( (fifo_sz > 0) ? fifo_sz : 1)-1:0] dummy_statreg_lz;
    wire [( (fifo_b > 0) ? fifo_b : 1)-1:0] dummy_bufreg_lz;

    generate
    if ( fifo_sz > 0 )
    begin: FIFO_REG
      assign vd = vz | ~stat[0];
      assign lz = ld | stat[fifo_sz-1];
      assign size_t = (count - (vz && stat[fifo_sz-1])) + ld;
      assign size = size_t[sz_width-1:0];
      assign z = (stat[fifo_sz-1]) ? buff[fifo_b-1:width*(fifo_sz-1)] : d;

      always @(*)
      begin: FIFOPROC
        n_elem = 33'b0;
        for (i = fifo_sz-1; i >= 0; i = i - 1)
        begin
          if (i != 0)
            stat_before = stat[i-1];
          else
            stat_before = 1'b0;

          if (i != (fifo_sz-1))
            stat_after = stat[i+1];
          else
            stat_after = 1'b1;

          stat_nxt = stat_after &
                    (stat_before | (stat[i] & (~vz)) | (stat[i] & ld) | (ld & (~vz)));

          stat_pre[i] = stat_nxt;
          en_l_var = 1'b1;
          if (!stat_nxt)
            begin
              buff_nxt = {width{1'b0}};
              en_l_var = 1'b0;
            end
          else if (vz && stat_before)
            buff_nxt[0+:width] = buff[width*(i-1)+:width];
          else if (ld && !((vz && stat_before) || ((!vz) && stat[i])))
            buff_nxt = d;
          else
            begin
              if (pwropt == 0)
                buff_nxt[0+:width] = buff[width*i+:width];
              else
                buff_nxt = {width{1'b0}};
              en_l_var = 1'b0;
            end

          if (ph_en != 0)
            en_l[i] = en & en_l_var;
          else
            en_l[i] = en | ~en_l_var;

          buff_pre[width*i+:width] = buff_nxt[0+:width];

          if ((stat_after == 1'b1) && (stat[i] == 1'b0))
            n_elem = ($unsigned(fifo_sz) - 1) - i;
        end

        if (ph_en != 0)
          en_l_s[(((fifo_sz > 0) ? fifo_sz : 1)-1)/8] = 1'b1;
        else
          en_l_s[(((fifo_sz > 0) ? fifo_sz : 1)-1)/8] = 1'b0;

        for (i = fifo_sz-1; i >= 7; i = i - 1)
        begin
          if ((i%'d2) == 0)
          begin
            if (ph_en != 0)
              en_l_s[(i/8)-1] = en & (stat[i]|stat_pre[i-1]);
            else
              en_l_s[(i/8)-1] = en | ~(stat[i]|stat_pre[i-1]);
          end
        end

        if ( stat[fifo_sz-1] == 1'b0 )
          count_t = 32'b0;
        else if ( stat[0] == 1'b1 )
          count_t = { {(32-ph_log2){1'b0}}, fifo_sz};
        else
          count_t = n_elem[31:0];
        count = count_t;
// pragma translate_off
        if ( peak < count )
          peak = count;
// pragma translate_on
      end

      if (pwropt == 0)
      begin: NOCGFIFO
        // Output registers:
        mgc_out_reg
        #(
            .rscid   (rscid),
            .width   (fifo_sz),
            .ph_clk  (ph_clk),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
        )
        STATREG
        (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (1'b1),
            .d       (stat_pre),
            .lz      (dummy_statreg_lz[0]),
            .z       (stat)
        );
        mgc_out_reg
        #(
            .rscid   (rscid),
            .width   (fifo_b),
            .ph_clk  (ph_clk),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
        )
        BUFREG
        (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (1'b1),
            .d       (buff_pre),
            .lz      (dummy_bufreg_lz[0]),
            .z       (buff)
        );
      end
      else
      begin: CGFIFO
        // Output registers:
        if ( pwropt > 1)
        begin: CGSTATFIFO2
          for (eni = fifo_sz-1; eni >= 0; eni = eni - 1)
          begin: pwroptGEN1
            mgc_out_reg
            #(
              .rscid   (rscid),
              .width   (1),
              .ph_clk  (ph_clk),
              .ph_en   (ph_en),
              .ph_arst (ph_arst),
              .ph_srst (ph_srst)
            )
            STATREG
            (
              .clk     (clk),
              .en      (en_l_s[eni/8]),
              .arst    (arst),
              .srst    (srst),
              .ld      (1'b1),
              .d       (stat_pre[eni]),
              .lz      (dummy_statreg_lz[eni]),
              .z       (stat[eni])
            );
          end
        end
        else
        begin: CGSTATFIFO
          mgc_out_reg
          #(
            .rscid   (rscid),
            .width   (fifo_sz),
            .ph_clk  (ph_clk),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
          )
          STATREG
          (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (1'b1),
            .d       (stat_pre),
            .lz      (dummy_statreg_lz[0]),
            .z       (stat)
          );
        end
        for (eni = fifo_sz-1; eni >= 0; eni = eni - 1)
        begin: pwroptGEN2
          mgc_out_reg
          #(
            .rscid   (rscid),
            .width   (width),
            .ph_clk  (ph_clk),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
          )
          BUFREG
          (
            .clk     (clk),
            .en      (en_l[eni]),
            .arst    (arst),
            .srst    (srst),
            .ld      (1'b1),
            .d       (buff_pre[width*eni+:width]),
            .lz      (dummy_bufreg_lz[eni]),
            .z       (buff[width*eni+:width])
          );
        end
      end
    end
    else
    begin: FEED_THRU
      assign vd = vz;
      assign lz = ld;
      assign z = d;
      assign size = ld && !vz;
    end
    endgenerate

endmodule

//------------------------------------------------------------------
//-- PIPE ENTITIES
//------------------------------------------------------------------
/*
 *
 *             _______________________________________________
 * WRITER    |                                               |          READER
 *           |           MGC_PIPE                            |
 *           |           __________________________          |
 *        --<| vdout  --<| vd ---------------  vz<|-----ldin<|---
 *           |           |      FIFO              |          |
 *        ---|>ldout  ---|>ld ---------------- lz |> ---vdin |>--
 *        ---|>dout -----|>d  ---------------- dz |> ----din |>--
 *           |           |________________________|          |
 *           |_______________________________________________|
 */
// two clock pipe
module mgc_pipe (clk, en, arst, srst, ldin, vdin, din, ldout, vdout, dout, size, req_size);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter integer sz_width = 8; // width of size of elements in fifo
    parameter integer fifo_sz = 8; // fifo depth
    parameter integer log2_sz = 3; // log2(fifo_sz)
    parameter         ph_clk  = 1'b1;  // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   = 1'b1;  // clock enable polarity
    parameter         ph_arst = 1'b1;  // async reset polarity
    parameter         ph_srst = 1'b1;  // sync reset polarity
    parameter integer pwropt  = 0; // pwropt

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ldin;
    output             vdin;
    output [width-1:0] din;
    input              ldout;
    output             vdout;
    input  [width-1:0] dout;
    output [sz_width-1:0]      size;
    input              req_size;


    mgc_out_fifo_wait_core
    #(
        .rscid    (rscid),
        .width    (width),
        .sz_width (sz_width),
        .fifo_sz  (fifo_sz),
        .ph_clk   (ph_clk),
        .ph_en    (ph_en),
        .ph_arst  (ph_arst),
        .ph_srst  (ph_srst),
        .ph_log2  (log2_sz),
        .pwropt   (pwropt)
    )
    FIFO
    (
        .clk     (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (ldout),
        .vd      (vdout),
        .d       (dout),
        .lz      (vdin),
        .vz      (ldin),
        .z       (din),
        .size    (size)
    );

endmodule


//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   gsp14@EEWS104A-018
//  Generated date: Fri Mar 18 14:52:38 2016
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    mean_vga_core
// ------------------------------------------------------------------


module mean_vga_core (
  clk, en, arst_n, vin_rsc_mgc_in_wire_d, vout_rsc_mgc_out_stdreg_d
);
  input clk;
  input en;
  input arst_n;
  input [89:0] vin_rsc_mgc_in_wire_d;
  output [29:0] vout_rsc_mgc_out_stdreg_d;
  reg [29:0] vout_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations
  wire [3:0] sqrt_for_2_t_acc_tmp;
  wire [4:0] nl_sqrt_for_2_t_acc_tmp;
  reg [1:0] sqrt_d_sg4_6_lpi_1_dfm_1;
  reg [1:0] sqrt_d_sg3_6_lpi_1_dfm_1;
  reg [1:0] sqrt_d_sg2_6_lpi_1_dfm_1;
  reg [1:0] sqrt_d_sg1_6_lpi_1_dfm_1;
  reg [1:0] sqrt_d_7_lpi_1_dfm_1;
  reg sqrt_d_sg5_16_lpi_1_dfm_1;
  reg [1:0] sqrt_d_sg7_14_lpi_1_dfm_1;
  reg [1:0] sqrt_d_sg6_14_lpi_1_dfm_1;
  reg [1:0] sqrt_d_sg5_14_lpi_1_dfm_1;
  reg [1:0] sqrt_d_sg4_14_lpi_1_dfm_1;
  reg [1:0] sqrt_d_sg3_14_lpi_1_dfm_1;
  reg [1:0] sqrt_d_sg2_14_lpi_1_dfm_1;
  reg [1:0] sqrt_d_sg1_14_lpi_1_dfm_1;
  reg [1:0] sqrt_d_15_lpi_1_dfm_1;
  reg FRAME_nand_cse_sva_1;
  reg FRAME_nand_1_cse_sva_1;
  reg FRAME_nand_2_cse_sva_1;
  reg [9:0] regs_regs_slc_regs_regs_2_1_itm;
  reg [9:0] regs_regs_slc_regs_regs_2_2_itm;
  reg [9:0] regs_regs_slc_regs_regs_2_itm;
  reg [9:0] regs_regs_slc_regs_regs_2_4_itm;
  reg [9:0] regs_regs_slc_regs_regs_2_5_itm;
  reg [9:0] regs_regs_slc_regs_regs_2_3_itm;
  reg [9:0] regs_regs_slc_regs_regs_2_7_itm;
  reg [9:0] regs_regs_slc_regs_regs_2_8_itm;
  reg [9:0] regs_regs_slc_regs_regs_2_6_itm;
  reg [12:0] ACC1_if_2_acc_45_itm_1;
  wire [13:0] nl_ACC1_if_2_acc_45_itm_1;
  reg [12:0] ACC1_if_2_acc_44_itm_1;
  wire [13:0] nl_ACC1_if_2_acc_44_itm_1;
  reg [12:0] ACC1_if_acc_52_itm_1;
  wire [13:0] nl_ACC1_if_acc_52_itm_1;
  reg [12:0] ACC1_if_acc_51_itm_1;
  wire [13:0] nl_ACC1_if_acc_51_itm_1;
  reg [1:0] sqrt_for_7_if_slc_sqrt_for_t_1_itm_1;
  reg [1:0] sqrt_for_7_if_slc_sqrt_for_t_itm_1;
  reg [1:0] sqrt_for_7_if_slc_sqrt_for_t_2_itm_1;
  reg [1:0] sqrt_for_7_if_slc_sqrt_for_t_4_itm_1;
  reg [1:0] sqrt_for_7_if_slc_sqrt_for_t_6_itm_1;
  reg [1:0] sqrt_z_slc_sqrt_z_1_18_itm_1;
  reg [1:0] sqrt_for_7_if_slc_sqrt_for_t_8_itm_1;
  reg sqrt_for_7_if_slc_sqrt_for_t_3_itm_1;
  reg [1:0] sqrt_z_slc_sqrt_z_1_20_itm_1;
  reg [1:0] sqrt_z_slc_sqrt_z_1_24_itm_1;
  reg [1:0] sqrt_z_slc_sqrt_z_1_26_itm_1;
  reg [1:0] sqrt_z_slc_sqrt_z_1_28_itm_1;
  reg [1:0] sqrt_z_slc_sqrt_z_1_30_itm_1;
  reg [1:0] sqrt_z_slc_sqrt_z_1_32_itm_1;
  reg sqrt_z_slc_sqrt_z_1_56_itm_1;
  reg sqrt_for_if_slc_sqrt_for_5_t_acc_psp_14_itm_1;
  reg sqrt_for_if_slc_sqrt_for_6_t_acc_psp_12_itm_1;
  reg sqrt_for_if_slc_sqrt_for_7_t_acc_psp_10_itm_1;
  reg [1:0] sqrt_z_slc_sqrt_z_1_34_itm_1;
  reg sqrt_for_mux_89_itm_1;
  reg [1:0] sqrt_z_slc_sqrt_z_1_36_itm_1;
  reg [1:0] sqrt_z_slc_sqrt_z_1_36_itm_2;
  reg [1:0] sqrt_z_slc_sqrt_z_1_38_itm_1;
  reg [1:0] sqrt_z_slc_sqrt_z_1_38_itm_2;
  reg [1:0] sqrt_z_slc_sqrt_z_1_2_itm_1;
  reg [1:0] sqrt_z_slc_sqrt_z_1_2_itm_2;
  reg sqrt_z_slc_sqrt_z_1_59_itm_2;
  reg sqrt_for_if_slc_sqrt_for_2_t_acc_psp_23_itm_2;
  reg sqrt_for_if_slc_sqrt_for_3_t_acc_psp_21_itm_2;
  reg sqrt_for_if_slc_sqrt_for_4_t_acc_psp_19_itm_2;
  reg sqrt_for_if_slc_sqrt_for_2_t_acc_psp_25_itm_1;
  reg sqrt_for_if_slc_sqrt_for_3_t_acc_psp_24_itm_1;
  reg sqrt_for_if_slc_sqrt_for_4_t_acc_psp_23_itm_1;
  reg sqrt_for_if_slc_sqrt_for_8_t_acc_psp_12_itm_1;
  reg sqrt_for_9_slc_sqrt_for_t_11_itm_1;
  reg sqrt_for_10_slc_sqrt_for_t_10_itm_1;
  reg sqrt_for_11_slc_sqrt_for_t_9_itm_1;
  reg sqrt_for_12_slc_sqrt_for_t_2_itm_1;
  reg sqrt_for_13_slc_sqrt_for_t_2_itm_1;
  reg sqrt_for_14_slc_sqrt_for_t_2_itm_1;
  reg main_stage_0_2;
  reg main_stage_0_3;
  reg main_stage_0_4;
  wire [1:0] sqrt_d_sg7_15_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg6_15_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg5_15_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg4_15_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg3_15_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg2_15_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg1_15_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_16_lpi_1_dfm_mx0;
  reg [89:0] reg_regs_regs_0_sva_cse;
  reg reg_sqrt_for_if_slc_sqrt_for_5_t_acc_psp_22_itm_2_cse;
  reg reg_sqrt_for_if_slc_sqrt_for_6_t_acc_psp_21_itm_2_cse;
  reg reg_sqrt_for_if_slc_sqrt_for_7_t_acc_psp_20_itm_2_cse;
  wire [19:0] sqrt_for_t_acc_12_itm;
  wire [20:0] nl_sqrt_for_t_acc_12_itm;
  wire [19:0] sqrt_for_t_acc_11_itm;
  wire [20:0] nl_sqrt_for_t_acc_11_itm;
  wire [19:0] sqrt_for_t_acc_10_itm;
  wire [20:0] nl_sqrt_for_t_acc_10_itm;
  wire [19:0] sqrt_for_t_acc_9_itm;
  wire [20:0] nl_sqrt_for_t_acc_9_itm;
  wire [19:0] sqrt_for_t_acc_8_itm;
  wire [20:0] nl_sqrt_for_t_acc_8_itm;
  wire [19:0] sqrt_for_t_acc_7_itm;
  wire [20:0] nl_sqrt_for_t_acc_7_itm;
  wire [18:0] sqrt_for_t_acc_6_itm;
  wire [19:0] nl_sqrt_for_t_acc_6_itm;
  wire [16:0] sqrt_for_t_acc_5_itm;
  wire [17:0] nl_sqrt_for_t_acc_5_itm;
  wire [14:0] sqrt_for_t_acc_4_itm;
  wire [15:0] nl_sqrt_for_t_acc_4_itm;
  wire [12:0] sqrt_for_t_acc_3_itm;
  wire [13:0] nl_sqrt_for_t_acc_3_itm;
  wire [10:0] sqrt_for_t_acc_2_itm;
  wire [11:0] nl_sqrt_for_t_acc_2_itm;
  wire [8:0] sqrt_for_t_acc_1_itm;
  wire [9:0] nl_sqrt_for_t_acc_1_itm;
  wire [6:0] sqrt_for_t_acc_itm;
  wire [7:0] nl_sqrt_for_t_acc_itm;
  wire FRAME_nand_3_cse_sva;
  wire FRAME_nand_4_cse_sva;
  wire FRAME_nand_5_cse_sva;
  wire [1:0] sqrt_d_sg7_13_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_14_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg1_13_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg2_13_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg3_13_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg4_13_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg5_13_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg6_13_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg7_12_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_13_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg1_12_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg2_12_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg3_12_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg4_12_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg5_12_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg6_12_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg7_11_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_12_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg1_11_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg2_11_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg3_11_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg4_11_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg5_11_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg6_11_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg7_10_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_11_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg1_10_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg2_10_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg3_10_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg4_10_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg5_10_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg6_10_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg7_9_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_10_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg1_9_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg2_9_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg3_9_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg4_9_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg5_9_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg6_9_lpi_1_dfm_mx0;
  wire sqrt_d_sg7_16_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_9_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg1_8_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg2_8_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg3_8_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg4_8_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg5_8_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg6_8_lpi_1_dfm_mx0;
  wire sqrt_d_sg6_16_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_8_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg1_7_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg2_7_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg3_7_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg4_7_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg5_7_lpi_1_dfm_mx0;
  wire sqrt_d_sg5_16_lpi_1_dfm_1_mx0;
  wire [1:0] sqrt_d_7_lpi_1_dfm_1_mx0;
  wire [1:0] sqrt_d_sg1_6_lpi_1_dfm_1_mx0;
  wire [1:0] sqrt_d_sg2_6_lpi_1_dfm_1_mx0;
  wire [1:0] sqrt_d_sg3_6_lpi_1_dfm_1_mx0;
  wire [1:0] sqrt_d_sg4_6_lpi_1_dfm_1_mx0;
  wire [32:0] sqrt_acc_psp_sva;
  wire [33:0] nl_sqrt_acc_psp_sva;
  wire sqrt_d_sg4_17_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_6_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg1_5_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg2_5_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg3_5_lpi_1_dfm_mx0;
  wire sqrt_d_sg3_17_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_5_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg1_4_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg2_4_lpi_1_dfm_mx0;
  wire sqrt_d_sg2_17_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_4_lpi_1_dfm_mx0;
  wire [1:0] sqrt_d_sg1_3_lpi_1_dfm_mx0;
  wire sqrt_d_sg1_17_lpi_1_dfm;
  wire [1:0] sqrt_d_3_lpi_1_dfm_mx0;
  wire [11:0] acc_4_psp_sva;
  wire [12:0] nl_acc_4_psp_sva;
  wire [11:0] acc_4_psp_1_sva;
  wire [12:0] nl_acc_4_psp_1_sva;
  wire [11:0] ACC1_acc_10_psp_sva;
  wire [12:0] nl_ACC1_acc_10_psp_sva;
  wire [3:0] acc_5_psp_sva;
  wire [4:0] nl_acc_5_psp_sva;
  wire [2:0] acc_imod_4_sva;
  wire [3:0] nl_acc_imod_4_sva;
  wire [3:0] acc_5_psp_1_sva;
  wire [4:0] nl_acc_5_psp_1_sva;
  wire [2:0] acc_imod_11_sva;
  wire [3:0] nl_acc_imod_11_sva;
  wire [11:0] ACC1_if_acc_2_psp_sva;
  wire [12:0] nl_ACC1_if_acc_2_psp_sva;
  wire [11:0] ACC1_acc_10_psp_1_sva;
  wire [12:0] nl_ACC1_acc_10_psp_1_sva;
  wire [11:0] ACC1_acc_8_psp_sva;
  wire [12:0] nl_ACC1_acc_8_psp_sva;
  wire [11:0] acc_psp_2_sva;
  wire [12:0] nl_acc_psp_2_sva;
  wire [11:0] acc_8_psp_2_sva;
  wire [12:0] nl_acc_8_psp_2_sva;
  wire [2:0] acc_imod_10_sva;
  wire [3:0] nl_acc_imod_10_sva;
  wire [3:0] acc_9_psp_2_sva;
  wire [4:0] nl_acc_9_psp_2_sva;
  wire [2:0] acc_imod_14_sva;
  wire [3:0] nl_acc_imod_14_sva;
  wire [3:0] acc_1_psp_2_sva;
  wire [4:0] nl_acc_1_psp_2_sva;
  wire [11:0] acc_8_psp_sva;
  wire [12:0] nl_acc_8_psp_sva;
  wire [2:0] acc_imod_7_sva;
  wire [3:0] nl_acc_imod_7_sva;
  wire [3:0] acc_9_psp_sva;
  wire [4:0] nl_acc_9_psp_sva;
  wire [11:0] acc_psp_sva;
  wire [12:0] nl_acc_psp_sva;
  wire [2:0] acc_imod_1_sva;
  wire [3:0] nl_acc_imod_1_sva;
  wire [3:0] acc_1_psp_sva;
  wire [4:0] nl_acc_1_psp_sva;
  wire [11:0] acc_psp_1_sva;
  wire [12:0] nl_acc_psp_1_sva;
  wire [2:0] acc_imod_9_sva;
  wire [3:0] nl_acc_imod_9_sva;
  wire [3:0] acc_1_psp_1_sva;
  wire [4:0] nl_acc_1_psp_1_sva;
  wire [11:0] acc_8_psp_1_sva;
  wire [12:0] nl_acc_8_psp_1_sva;
  wire [2:0] acc_imod_13_sva;
  wire [3:0] nl_acc_imod_13_sva;
  wire [3:0] acc_9_psp_1_sva;
  wire [4:0] nl_acc_9_psp_1_sva;
  wire [19:0] sqrt_for_t_acc_13_itm;
  wire [20:0] nl_sqrt_for_t_acc_13_itm;
  wire [19:0] sqrt_for_t_acc_14_itm;
  wire [20:0] nl_sqrt_for_t_acc_14_itm;
  wire [13:0] ACC1_if_2_acc_itm;
  wire [14:0] nl_ACC1_if_2_acc_itm;
  wire [13:0] ACC1_if_acc_itm;
  wire [14:0] nl_ACC1_if_acc_itm;

  wire[0:0] sqrt_for_mux_98_nl;
  wire[0:0] sqrt_for_mux_103_nl;
  wire[1:0] sqrt_for_mux_99_nl;
  wire[1:0] sqrt_for_mux_100_nl;
  wire[1:0] sqrt_for_mux_101_nl;
  wire[1:0] sqrt_for_mux_104_nl;
  wire[1:0] sqrt_for_mux_105_nl;
  wire[1:0] sqrt_for_mux_106_nl;
  wire[1:0] sqrt_for_mux_107_nl;
  wire[1:0] sqrt_for_mux_102_nl;
  wire[0:0] sqrt_for_mux_80_nl;
  wire[0:0] sqrt_for_mux_71_nl;
  wire[0:0] sqrt_for_mux_62_nl;
  wire[0:0] sqrt_for_mux_53_nl;
  wire[0:0] sqrt_for_mux_44_nl;

  // Interconnect Declarations for Component Instantiations 
  assign FRAME_nand_3_cse_sva = ~((sqrt_for_t_acc_12_itm[19]) & reg_sqrt_for_if_slc_sqrt_for_5_t_acc_psp_22_itm_2_cse);
  assign FRAME_nand_4_cse_sva = ~((sqrt_for_t_acc_13_itm[19]) & reg_sqrt_for_if_slc_sqrt_for_6_t_acc_psp_21_itm_2_cse);
  assign FRAME_nand_5_cse_sva = ~((sqrt_for_t_acc_14_itm[19]) & reg_sqrt_for_if_slc_sqrt_for_7_t_acc_psp_20_itm_2_cse);
  assign nl_sqrt_for_t_acc_12_itm = ({sqrt_for_mux_89_itm_1 , sqrt_d_sg7_14_lpi_1_dfm_1
      , sqrt_d_sg6_14_lpi_1_dfm_1 , sqrt_d_sg5_14_lpi_1_dfm_1 , sqrt_d_sg4_14_lpi_1_dfm_1
      , sqrt_d_sg3_14_lpi_1_dfm_1 , sqrt_d_sg2_14_lpi_1_dfm_1 , sqrt_d_sg1_14_lpi_1_dfm_1
      , sqrt_d_15_lpi_1_dfm_1 , sqrt_z_slc_sqrt_z_1_36_itm_2 , 1'b1}) + conv_s2u_18_20({1'b1
      , (~ sqrt_z_slc_sqrt_z_1_59_itm_2) , sqrt_for_if_slc_sqrt_for_2_t_acc_psp_23_itm_2
      , sqrt_for_if_slc_sqrt_for_3_t_acc_psp_21_itm_2 , sqrt_for_if_slc_sqrt_for_4_t_acc_psp_19_itm_2
      , reg_sqrt_for_if_slc_sqrt_for_5_t_acc_psp_22_itm_2_cse , reg_sqrt_for_if_slc_sqrt_for_6_t_acc_psp_21_itm_2_cse
      , reg_sqrt_for_if_slc_sqrt_for_7_t_acc_psp_20_itm_2_cse , sqrt_for_if_slc_sqrt_for_8_t_acc_psp_12_itm_1
      , sqrt_for_9_slc_sqrt_for_t_11_itm_1 , sqrt_for_10_slc_sqrt_for_t_10_itm_1
      , sqrt_for_11_slc_sqrt_for_t_9_itm_1 , sqrt_for_12_slc_sqrt_for_t_2_itm_1 ,
      sqrt_for_13_slc_sqrt_for_t_2_itm_1 , sqrt_for_14_slc_sqrt_for_t_2_itm_1 , 3'b101});
  assign sqrt_for_t_acc_12_itm = nl_sqrt_for_t_acc_12_itm[19:0];
  assign sqrt_for_mux_98_nl = MUX_s_1_2_2({(sqrt_for_t_acc_12_itm[17]) , (sqrt_d_sg7_14_lpi_1_dfm_1[0])},
      sqrt_for_t_acc_12_itm[19]);
  assign nl_sqrt_for_t_acc_13_itm = ({(sqrt_for_mux_98_nl) , sqrt_d_sg7_15_lpi_1_dfm_mx0
      , sqrt_d_sg6_15_lpi_1_dfm_mx0 , sqrt_d_sg5_15_lpi_1_dfm_mx0 , sqrt_d_sg4_15_lpi_1_dfm_mx0
      , sqrt_d_sg3_15_lpi_1_dfm_mx0 , sqrt_d_sg2_15_lpi_1_dfm_mx0 , sqrt_d_sg1_15_lpi_1_dfm_mx0
      , sqrt_d_16_lpi_1_dfm_mx0 , sqrt_z_slc_sqrt_z_1_38_itm_2 , 1'b1}) + conv_s2u_19_20({1'b1
      , (~ sqrt_z_slc_sqrt_z_1_59_itm_2) , sqrt_for_if_slc_sqrt_for_2_t_acc_psp_23_itm_2
      , sqrt_for_if_slc_sqrt_for_3_t_acc_psp_21_itm_2 , sqrt_for_if_slc_sqrt_for_4_t_acc_psp_19_itm_2
      , reg_sqrt_for_if_slc_sqrt_for_5_t_acc_psp_22_itm_2_cse , reg_sqrt_for_if_slc_sqrt_for_6_t_acc_psp_21_itm_2_cse
      , reg_sqrt_for_if_slc_sqrt_for_7_t_acc_psp_20_itm_2_cse , sqrt_for_if_slc_sqrt_for_8_t_acc_psp_12_itm_1
      , sqrt_for_9_slc_sqrt_for_t_11_itm_1 , sqrt_for_10_slc_sqrt_for_t_10_itm_1
      , sqrt_for_11_slc_sqrt_for_t_9_itm_1 , sqrt_for_12_slc_sqrt_for_t_2_itm_1 ,
      sqrt_for_13_slc_sqrt_for_t_2_itm_1 , sqrt_for_14_slc_sqrt_for_t_2_itm_1 , (sqrt_for_t_acc_12_itm[19])
      , 3'b101});
  assign sqrt_for_t_acc_13_itm = nl_sqrt_for_t_acc_13_itm[19:0];
  assign sqrt_for_mux_103_nl = MUX_s_1_2_2({(sqrt_for_t_acc_13_itm[17]) , (sqrt_d_sg7_15_lpi_1_dfm_mx0[0])},
      sqrt_for_t_acc_13_itm[19]);
  assign sqrt_for_mux_99_nl = MUX_v_2_2_2({(sqrt_for_t_acc_13_itm[16:15]) , sqrt_d_sg6_15_lpi_1_dfm_mx0},
      sqrt_for_t_acc_13_itm[19]);
  assign sqrt_for_mux_100_nl = MUX_v_2_2_2({(sqrt_for_t_acc_13_itm[14:13]) , sqrt_d_sg5_15_lpi_1_dfm_mx0},
      sqrt_for_t_acc_13_itm[19]);
  assign sqrt_for_mux_101_nl = MUX_v_2_2_2({(sqrt_for_t_acc_13_itm[12:11]) , sqrt_d_sg4_15_lpi_1_dfm_mx0},
      sqrt_for_t_acc_13_itm[19]);
  assign sqrt_for_mux_104_nl = MUX_v_2_2_2({(sqrt_for_t_acc_13_itm[10:9]) , sqrt_d_sg3_15_lpi_1_dfm_mx0},
      sqrt_for_t_acc_13_itm[19]);
  assign sqrt_for_mux_105_nl = MUX_v_2_2_2({(sqrt_for_t_acc_13_itm[8:7]) , sqrt_d_sg2_15_lpi_1_dfm_mx0},
      sqrt_for_t_acc_13_itm[19]);
  assign sqrt_for_mux_106_nl = MUX_v_2_2_2({(sqrt_for_t_acc_13_itm[6:5]) , sqrt_d_sg1_15_lpi_1_dfm_mx0},
      sqrt_for_t_acc_13_itm[19]);
  assign sqrt_for_mux_107_nl = MUX_v_2_2_2({(sqrt_for_t_acc_13_itm[4:3]) , sqrt_d_16_lpi_1_dfm_mx0},
      sqrt_for_t_acc_13_itm[19]);
  assign sqrt_for_mux_102_nl = MUX_v_2_2_2({(sqrt_for_t_acc_13_itm[2:1]) , sqrt_z_slc_sqrt_z_1_38_itm_2},
      sqrt_for_t_acc_13_itm[19]);
  assign nl_sqrt_for_t_acc_14_itm = ({(sqrt_for_mux_103_nl) , (sqrt_for_mux_99_nl)
      , (sqrt_for_mux_100_nl) , (sqrt_for_mux_101_nl) , (sqrt_for_mux_104_nl) , (sqrt_for_mux_105_nl)
      , (sqrt_for_mux_106_nl) , (sqrt_for_mux_107_nl) , (sqrt_for_mux_102_nl) , sqrt_z_slc_sqrt_z_1_2_itm_2
      , 1'b1}) + ({1'b1 , (~ sqrt_z_slc_sqrt_z_1_59_itm_2) , sqrt_for_if_slc_sqrt_for_2_t_acc_psp_23_itm_2
      , sqrt_for_if_slc_sqrt_for_3_t_acc_psp_21_itm_2 , sqrt_for_if_slc_sqrt_for_4_t_acc_psp_19_itm_2
      , reg_sqrt_for_if_slc_sqrt_for_5_t_acc_psp_22_itm_2_cse , reg_sqrt_for_if_slc_sqrt_for_6_t_acc_psp_21_itm_2_cse
      , reg_sqrt_for_if_slc_sqrt_for_7_t_acc_psp_20_itm_2_cse , sqrt_for_if_slc_sqrt_for_8_t_acc_psp_12_itm_1
      , sqrt_for_9_slc_sqrt_for_t_11_itm_1 , sqrt_for_10_slc_sqrt_for_t_10_itm_1
      , sqrt_for_11_slc_sqrt_for_t_9_itm_1 , sqrt_for_12_slc_sqrt_for_t_2_itm_1 ,
      sqrt_for_13_slc_sqrt_for_t_2_itm_1 , sqrt_for_14_slc_sqrt_for_t_2_itm_1 , (sqrt_for_t_acc_12_itm[19])
      , (sqrt_for_t_acc_13_itm[19]) , 3'b101});
  assign sqrt_for_t_acc_14_itm = nl_sqrt_for_t_acc_14_itm[19:0];
  assign sqrt_d_sg7_15_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_12_itm[16:15])
      , sqrt_d_sg6_14_lpi_1_dfm_1}, sqrt_for_t_acc_12_itm[19]);
  assign sqrt_d_sg6_15_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_12_itm[14:13])
      , sqrt_d_sg5_14_lpi_1_dfm_1}, sqrt_for_t_acc_12_itm[19]);
  assign sqrt_d_sg5_15_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_12_itm[12:11])
      , sqrt_d_sg4_14_lpi_1_dfm_1}, sqrt_for_t_acc_12_itm[19]);
  assign sqrt_d_sg4_15_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_12_itm[10:9])
      , sqrt_d_sg3_14_lpi_1_dfm_1}, sqrt_for_t_acc_12_itm[19]);
  assign sqrt_d_sg3_15_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_12_itm[8:7])
      , sqrt_d_sg2_14_lpi_1_dfm_1}, sqrt_for_t_acc_12_itm[19]);
  assign sqrt_d_sg2_15_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_12_itm[6:5])
      , sqrt_d_sg1_14_lpi_1_dfm_1}, sqrt_for_t_acc_12_itm[19]);
  assign sqrt_d_sg1_15_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_12_itm[4:3])
      , sqrt_d_15_lpi_1_dfm_1}, sqrt_for_t_acc_12_itm[19]);
  assign sqrt_d_16_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_12_itm[2:1]) , sqrt_z_slc_sqrt_z_1_36_itm_2},
      sqrt_for_t_acc_12_itm[19]);
  assign sqrt_for_mux_80_nl = MUX_s_1_2_2({(sqrt_for_t_acc_10_itm[17]) , (sqrt_d_sg7_12_lpi_1_dfm_mx0[0])},
      sqrt_for_t_acc_10_itm[19]);
  assign nl_sqrt_for_t_acc_11_itm = ({(sqrt_for_mux_80_nl) , sqrt_d_sg7_13_lpi_1_dfm_mx0
      , sqrt_d_sg6_13_lpi_1_dfm_mx0 , sqrt_d_sg5_13_lpi_1_dfm_mx0 , sqrt_d_sg4_13_lpi_1_dfm_mx0
      , sqrt_d_sg3_13_lpi_1_dfm_mx0 , sqrt_d_sg2_13_lpi_1_dfm_mx0 , sqrt_d_sg1_13_lpi_1_dfm_mx0
      , sqrt_d_14_lpi_1_dfm_mx0 , sqrt_z_slc_sqrt_z_1_34_itm_1 , 1'b1}) + conv_s2u_17_20({1'b1
      , (~ sqrt_z_slc_sqrt_z_1_56_itm_1) , sqrt_for_if_slc_sqrt_for_2_t_acc_psp_25_itm_1
      , sqrt_for_if_slc_sqrt_for_3_t_acc_psp_24_itm_1 , sqrt_for_if_slc_sqrt_for_4_t_acc_psp_23_itm_1
      , sqrt_for_if_slc_sqrt_for_5_t_acc_psp_14_itm_1 , sqrt_for_if_slc_sqrt_for_6_t_acc_psp_12_itm_1
      , sqrt_for_if_slc_sqrt_for_7_t_acc_psp_10_itm_1 , (sqrt_for_t_acc_5_itm[16])
      , (sqrt_for_t_acc_6_itm[18]) , (sqrt_for_t_acc_7_itm[19]) , (sqrt_for_t_acc_8_itm[19])
      , (sqrt_for_t_acc_9_itm[19]) , (sqrt_for_t_acc_10_itm[19]) , 3'b101});
  assign sqrt_for_t_acc_11_itm = nl_sqrt_for_t_acc_11_itm[19:0];
  assign sqrt_for_mux_71_nl = MUX_s_1_2_2({(sqrt_for_t_acc_9_itm[17]) , (sqrt_d_sg7_11_lpi_1_dfm_mx0[0])},
      sqrt_for_t_acc_9_itm[19]);
  assign nl_sqrt_for_t_acc_10_itm = ({(sqrt_for_mux_71_nl) , sqrt_d_sg7_12_lpi_1_dfm_mx0
      , sqrt_d_sg6_12_lpi_1_dfm_mx0 , sqrt_d_sg5_12_lpi_1_dfm_mx0 , sqrt_d_sg4_12_lpi_1_dfm_mx0
      , sqrt_d_sg3_12_lpi_1_dfm_mx0 , sqrt_d_sg2_12_lpi_1_dfm_mx0 , sqrt_d_sg1_12_lpi_1_dfm_mx0
      , sqrt_d_13_lpi_1_dfm_mx0 , sqrt_z_slc_sqrt_z_1_32_itm_1 , 1'b1}) + conv_s2u_16_20({1'b1
      , (~ sqrt_z_slc_sqrt_z_1_56_itm_1) , sqrt_for_if_slc_sqrt_for_2_t_acc_psp_25_itm_1
      , sqrt_for_if_slc_sqrt_for_3_t_acc_psp_24_itm_1 , sqrt_for_if_slc_sqrt_for_4_t_acc_psp_23_itm_1
      , sqrt_for_if_slc_sqrt_for_5_t_acc_psp_14_itm_1 , sqrt_for_if_slc_sqrt_for_6_t_acc_psp_12_itm_1
      , sqrt_for_if_slc_sqrt_for_7_t_acc_psp_10_itm_1 , (sqrt_for_t_acc_5_itm[16])
      , (sqrt_for_t_acc_6_itm[18]) , (sqrt_for_t_acc_7_itm[19]) , (sqrt_for_t_acc_8_itm[19])
      , (sqrt_for_t_acc_9_itm[19]) , 3'b101});
  assign sqrt_for_t_acc_10_itm = nl_sqrt_for_t_acc_10_itm[19:0];
  assign sqrt_for_mux_62_nl = MUX_s_1_2_2({(sqrt_for_t_acc_8_itm[17]) , (sqrt_d_sg7_10_lpi_1_dfm_mx0[0])},
      sqrt_for_t_acc_8_itm[19]);
  assign nl_sqrt_for_t_acc_9_itm = ({(sqrt_for_mux_62_nl) , sqrt_d_sg7_11_lpi_1_dfm_mx0
      , sqrt_d_sg6_11_lpi_1_dfm_mx0 , sqrt_d_sg5_11_lpi_1_dfm_mx0 , sqrt_d_sg4_11_lpi_1_dfm_mx0
      , sqrt_d_sg3_11_lpi_1_dfm_mx0 , sqrt_d_sg2_11_lpi_1_dfm_mx0 , sqrt_d_sg1_11_lpi_1_dfm_mx0
      , sqrt_d_12_lpi_1_dfm_mx0 , sqrt_z_slc_sqrt_z_1_30_itm_1 , 1'b1}) + conv_s2u_15_20({1'b1
      , (~ sqrt_z_slc_sqrt_z_1_56_itm_1) , sqrt_for_if_slc_sqrt_for_2_t_acc_psp_25_itm_1
      , sqrt_for_if_slc_sqrt_for_3_t_acc_psp_24_itm_1 , sqrt_for_if_slc_sqrt_for_4_t_acc_psp_23_itm_1
      , sqrt_for_if_slc_sqrt_for_5_t_acc_psp_14_itm_1 , sqrt_for_if_slc_sqrt_for_6_t_acc_psp_12_itm_1
      , sqrt_for_if_slc_sqrt_for_7_t_acc_psp_10_itm_1 , (sqrt_for_t_acc_5_itm[16])
      , (sqrt_for_t_acc_6_itm[18]) , (sqrt_for_t_acc_7_itm[19]) , (sqrt_for_t_acc_8_itm[19])
      , 3'b101});
  assign sqrt_for_t_acc_9_itm = nl_sqrt_for_t_acc_9_itm[19:0];
  assign sqrt_for_mux_53_nl = MUX_s_1_2_2({(sqrt_for_t_acc_7_itm[17]) , (sqrt_d_sg7_9_lpi_1_dfm_mx0[0])},
      sqrt_for_t_acc_7_itm[19]);
  assign nl_sqrt_for_t_acc_8_itm = ({(sqrt_for_mux_53_nl) , sqrt_d_sg7_10_lpi_1_dfm_mx0
      , sqrt_d_sg6_10_lpi_1_dfm_mx0 , sqrt_d_sg5_10_lpi_1_dfm_mx0 , sqrt_d_sg4_10_lpi_1_dfm_mx0
      , sqrt_d_sg3_10_lpi_1_dfm_mx0 , sqrt_d_sg2_10_lpi_1_dfm_mx0 , sqrt_d_sg1_10_lpi_1_dfm_mx0
      , sqrt_d_11_lpi_1_dfm_mx0 , sqrt_z_slc_sqrt_z_1_28_itm_1 , 1'b1}) + conv_s2u_14_20({1'b1
      , (~ sqrt_z_slc_sqrt_z_1_56_itm_1) , sqrt_for_if_slc_sqrt_for_2_t_acc_psp_25_itm_1
      , sqrt_for_if_slc_sqrt_for_3_t_acc_psp_24_itm_1 , sqrt_for_if_slc_sqrt_for_4_t_acc_psp_23_itm_1
      , sqrt_for_if_slc_sqrt_for_5_t_acc_psp_14_itm_1 , sqrt_for_if_slc_sqrt_for_6_t_acc_psp_12_itm_1
      , sqrt_for_if_slc_sqrt_for_7_t_acc_psp_10_itm_1 , (sqrt_for_t_acc_5_itm[16])
      , (sqrt_for_t_acc_6_itm[18]) , (sqrt_for_t_acc_7_itm[19]) , 3'b101});
  assign sqrt_for_t_acc_8_itm = nl_sqrt_for_t_acc_8_itm[19:0];
  assign sqrt_for_mux_44_nl = MUX_s_1_2_2({(sqrt_for_t_acc_6_itm[17]) , sqrt_d_sg7_16_lpi_1_dfm_mx0},
      sqrt_for_t_acc_6_itm[18]);
  assign nl_sqrt_for_t_acc_7_itm = ({(sqrt_for_mux_44_nl) , sqrt_d_sg7_9_lpi_1_dfm_mx0
      , sqrt_d_sg6_9_lpi_1_dfm_mx0 , sqrt_d_sg5_9_lpi_1_dfm_mx0 , sqrt_d_sg4_9_lpi_1_dfm_mx0
      , sqrt_d_sg3_9_lpi_1_dfm_mx0 , sqrt_d_sg2_9_lpi_1_dfm_mx0 , sqrt_d_sg1_9_lpi_1_dfm_mx0
      , sqrt_d_10_lpi_1_dfm_mx0 , sqrt_z_slc_sqrt_z_1_26_itm_1 , 1'b1}) + conv_s2u_13_20({1'b1
      , (~ sqrt_z_slc_sqrt_z_1_56_itm_1) , sqrt_for_if_slc_sqrt_for_2_t_acc_psp_25_itm_1
      , sqrt_for_if_slc_sqrt_for_3_t_acc_psp_24_itm_1 , sqrt_for_if_slc_sqrt_for_4_t_acc_psp_23_itm_1
      , sqrt_for_if_slc_sqrt_for_5_t_acc_psp_14_itm_1 , sqrt_for_if_slc_sqrt_for_6_t_acc_psp_12_itm_1
      , sqrt_for_if_slc_sqrt_for_7_t_acc_psp_10_itm_1 , (sqrt_for_t_acc_5_itm[16])
      , (sqrt_for_t_acc_6_itm[18]) , 3'b101});
  assign sqrt_for_t_acc_7_itm = nl_sqrt_for_t_acc_7_itm[19:0];
  assign nl_sqrt_for_t_acc_6_itm = conv_u2s_18_19({sqrt_d_sg7_16_lpi_1_dfm_mx0 ,
      sqrt_d_sg6_8_lpi_1_dfm_mx0 , sqrt_d_sg5_8_lpi_1_dfm_mx0 , sqrt_d_sg4_8_lpi_1_dfm_mx0
      , sqrt_d_sg3_8_lpi_1_dfm_mx0 , sqrt_d_sg2_8_lpi_1_dfm_mx0 , sqrt_d_sg1_8_lpi_1_dfm_mx0
      , sqrt_d_9_lpi_1_dfm_mx0 , sqrt_z_slc_sqrt_z_1_24_itm_1 , 1'b1}) + conv_s2s_12_19({1'b1
      , (~ sqrt_z_slc_sqrt_z_1_56_itm_1) , sqrt_for_if_slc_sqrt_for_2_t_acc_psp_25_itm_1
      , sqrt_for_if_slc_sqrt_for_3_t_acc_psp_24_itm_1 , sqrt_for_if_slc_sqrt_for_4_t_acc_psp_23_itm_1
      , sqrt_for_if_slc_sqrt_for_5_t_acc_psp_14_itm_1 , sqrt_for_if_slc_sqrt_for_6_t_acc_psp_12_itm_1
      , sqrt_for_if_slc_sqrt_for_7_t_acc_psp_10_itm_1 , (sqrt_for_t_acc_5_itm[16])
      , 3'b101});
  assign sqrt_for_t_acc_6_itm = nl_sqrt_for_t_acc_6_itm[18:0];
  assign nl_sqrt_for_t_acc_5_itm = conv_u2s_16_17({sqrt_d_sg6_16_lpi_1_dfm_mx0 ,
      sqrt_d_sg5_7_lpi_1_dfm_mx0 , sqrt_d_sg4_7_lpi_1_dfm_mx0 , sqrt_d_sg3_7_lpi_1_dfm_mx0
      , sqrt_d_sg2_7_lpi_1_dfm_mx0 , sqrt_d_sg1_7_lpi_1_dfm_mx0 , sqrt_d_8_lpi_1_dfm_mx0
      , sqrt_z_slc_sqrt_z_1_20_itm_1 , 1'b1}) + conv_s2s_11_17({1'b1 , (~ sqrt_z_slc_sqrt_z_1_56_itm_1)
      , sqrt_for_if_slc_sqrt_for_2_t_acc_psp_25_itm_1 , sqrt_for_if_slc_sqrt_for_3_t_acc_psp_24_itm_1
      , sqrt_for_if_slc_sqrt_for_4_t_acc_psp_23_itm_1 , sqrt_for_if_slc_sqrt_for_5_t_acc_psp_14_itm_1
      , sqrt_for_if_slc_sqrt_for_6_t_acc_psp_12_itm_1 , sqrt_for_if_slc_sqrt_for_7_t_acc_psp_10_itm_1
      , 3'b101});
  assign sqrt_for_t_acc_5_itm = nl_sqrt_for_t_acc_5_itm[16:0];
  assign sqrt_d_sg7_13_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_10_itm[16:15])
      , sqrt_d_sg6_12_lpi_1_dfm_mx0}, sqrt_for_t_acc_10_itm[19]);
  assign sqrt_d_14_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_10_itm[2:1]) , sqrt_z_slc_sqrt_z_1_32_itm_1},
      sqrt_for_t_acc_10_itm[19]);
  assign sqrt_d_sg1_13_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_10_itm[4:3])
      , sqrt_d_13_lpi_1_dfm_mx0}, sqrt_for_t_acc_10_itm[19]);
  assign sqrt_d_sg2_13_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_10_itm[6:5])
      , sqrt_d_sg1_12_lpi_1_dfm_mx0}, sqrt_for_t_acc_10_itm[19]);
  assign sqrt_d_sg3_13_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_10_itm[8:7])
      , sqrt_d_sg2_12_lpi_1_dfm_mx0}, sqrt_for_t_acc_10_itm[19]);
  assign sqrt_d_sg4_13_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_10_itm[10:9])
      , sqrt_d_sg3_12_lpi_1_dfm_mx0}, sqrt_for_t_acc_10_itm[19]);
  assign sqrt_d_sg5_13_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_10_itm[12:11])
      , sqrt_d_sg4_12_lpi_1_dfm_mx0}, sqrt_for_t_acc_10_itm[19]);
  assign sqrt_d_sg6_13_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_10_itm[14:13])
      , sqrt_d_sg5_12_lpi_1_dfm_mx0}, sqrt_for_t_acc_10_itm[19]);
  assign sqrt_d_sg7_12_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_9_itm[16:15])
      , sqrt_d_sg6_11_lpi_1_dfm_mx0}, sqrt_for_t_acc_9_itm[19]);
  assign sqrt_d_13_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_9_itm[2:1]) , sqrt_z_slc_sqrt_z_1_30_itm_1},
      sqrt_for_t_acc_9_itm[19]);
  assign sqrt_d_sg1_12_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_9_itm[4:3]) ,
      sqrt_d_12_lpi_1_dfm_mx0}, sqrt_for_t_acc_9_itm[19]);
  assign sqrt_d_sg2_12_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_9_itm[6:5]) ,
      sqrt_d_sg1_11_lpi_1_dfm_mx0}, sqrt_for_t_acc_9_itm[19]);
  assign sqrt_d_sg3_12_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_9_itm[8:7]) ,
      sqrt_d_sg2_11_lpi_1_dfm_mx0}, sqrt_for_t_acc_9_itm[19]);
  assign sqrt_d_sg4_12_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_9_itm[10:9])
      , sqrt_d_sg3_11_lpi_1_dfm_mx0}, sqrt_for_t_acc_9_itm[19]);
  assign sqrt_d_sg5_12_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_9_itm[12:11])
      , sqrt_d_sg4_11_lpi_1_dfm_mx0}, sqrt_for_t_acc_9_itm[19]);
  assign sqrt_d_sg6_12_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_9_itm[14:13])
      , sqrt_d_sg5_11_lpi_1_dfm_mx0}, sqrt_for_t_acc_9_itm[19]);
  assign sqrt_d_sg7_11_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_8_itm[16:15])
      , sqrt_d_sg6_10_lpi_1_dfm_mx0}, sqrt_for_t_acc_8_itm[19]);
  assign sqrt_d_12_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_8_itm[2:1]) , sqrt_z_slc_sqrt_z_1_28_itm_1},
      sqrt_for_t_acc_8_itm[19]);
  assign sqrt_d_sg1_11_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_8_itm[4:3]) ,
      sqrt_d_11_lpi_1_dfm_mx0}, sqrt_for_t_acc_8_itm[19]);
  assign sqrt_d_sg2_11_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_8_itm[6:5]) ,
      sqrt_d_sg1_10_lpi_1_dfm_mx0}, sqrt_for_t_acc_8_itm[19]);
  assign sqrt_d_sg3_11_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_8_itm[8:7]) ,
      sqrt_d_sg2_10_lpi_1_dfm_mx0}, sqrt_for_t_acc_8_itm[19]);
  assign sqrt_d_sg4_11_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_8_itm[10:9])
      , sqrt_d_sg3_10_lpi_1_dfm_mx0}, sqrt_for_t_acc_8_itm[19]);
  assign sqrt_d_sg5_11_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_8_itm[12:11])
      , sqrt_d_sg4_10_lpi_1_dfm_mx0}, sqrt_for_t_acc_8_itm[19]);
  assign sqrt_d_sg6_11_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_8_itm[14:13])
      , sqrt_d_sg5_10_lpi_1_dfm_mx0}, sqrt_for_t_acc_8_itm[19]);
  assign sqrt_d_sg7_10_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_7_itm[16:15])
      , sqrt_d_sg6_9_lpi_1_dfm_mx0}, sqrt_for_t_acc_7_itm[19]);
  assign sqrt_d_11_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_7_itm[2:1]) , sqrt_z_slc_sqrt_z_1_26_itm_1},
      sqrt_for_t_acc_7_itm[19]);
  assign sqrt_d_sg1_10_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_7_itm[4:3]) ,
      sqrt_d_10_lpi_1_dfm_mx0}, sqrt_for_t_acc_7_itm[19]);
  assign sqrt_d_sg2_10_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_7_itm[6:5]) ,
      sqrt_d_sg1_9_lpi_1_dfm_mx0}, sqrt_for_t_acc_7_itm[19]);
  assign sqrt_d_sg3_10_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_7_itm[8:7]) ,
      sqrt_d_sg2_9_lpi_1_dfm_mx0}, sqrt_for_t_acc_7_itm[19]);
  assign sqrt_d_sg4_10_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_7_itm[10:9])
      , sqrt_d_sg3_9_lpi_1_dfm_mx0}, sqrt_for_t_acc_7_itm[19]);
  assign sqrt_d_sg5_10_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_7_itm[12:11])
      , sqrt_d_sg4_9_lpi_1_dfm_mx0}, sqrt_for_t_acc_7_itm[19]);
  assign sqrt_d_sg6_10_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_7_itm[14:13])
      , sqrt_d_sg5_9_lpi_1_dfm_mx0}, sqrt_for_t_acc_7_itm[19]);
  assign sqrt_d_sg7_9_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_6_itm[16:15])
      , sqrt_d_sg6_8_lpi_1_dfm_mx0}, sqrt_for_t_acc_6_itm[18]);
  assign sqrt_d_10_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_6_itm[2:1]) , sqrt_z_slc_sqrt_z_1_24_itm_1},
      sqrt_for_t_acc_6_itm[18]);
  assign sqrt_d_sg1_9_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_6_itm[4:3]) ,
      sqrt_d_9_lpi_1_dfm_mx0}, sqrt_for_t_acc_6_itm[18]);
  assign sqrt_d_sg2_9_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_6_itm[6:5]) ,
      sqrt_d_sg1_8_lpi_1_dfm_mx0}, sqrt_for_t_acc_6_itm[18]);
  assign sqrt_d_sg3_9_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_6_itm[8:7]) ,
      sqrt_d_sg2_8_lpi_1_dfm_mx0}, sqrt_for_t_acc_6_itm[18]);
  assign sqrt_d_sg4_9_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_6_itm[10:9]) ,
      sqrt_d_sg3_8_lpi_1_dfm_mx0}, sqrt_for_t_acc_6_itm[18]);
  assign sqrt_d_sg5_9_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_6_itm[12:11])
      , sqrt_d_sg4_8_lpi_1_dfm_mx0}, sqrt_for_t_acc_6_itm[18]);
  assign sqrt_d_sg6_9_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_6_itm[14:13])
      , sqrt_d_sg5_8_lpi_1_dfm_mx0}, sqrt_for_t_acc_6_itm[18]);
  assign sqrt_d_sg7_16_lpi_1_dfm_mx0 = MUX_s_1_2_2({(sqrt_for_t_acc_5_itm[15]) ,
      sqrt_d_sg6_16_lpi_1_dfm_mx0}, sqrt_for_t_acc_5_itm[16]);
  assign sqrt_d_9_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_5_itm[2:1]) , sqrt_z_slc_sqrt_z_1_20_itm_1},
      sqrt_for_t_acc_5_itm[16]);
  assign sqrt_d_sg1_8_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_5_itm[4:3]) ,
      sqrt_d_8_lpi_1_dfm_mx0}, sqrt_for_t_acc_5_itm[16]);
  assign sqrt_d_sg2_8_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_5_itm[6:5]) ,
      sqrt_d_sg1_7_lpi_1_dfm_mx0}, sqrt_for_t_acc_5_itm[16]);
  assign sqrt_d_sg3_8_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_5_itm[8:7]) ,
      sqrt_d_sg2_7_lpi_1_dfm_mx0}, sqrt_for_t_acc_5_itm[16]);
  assign sqrt_d_sg4_8_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_5_itm[10:9]) ,
      sqrt_d_sg3_7_lpi_1_dfm_mx0}, sqrt_for_t_acc_5_itm[16]);
  assign sqrt_d_sg5_8_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_5_itm[12:11])
      , sqrt_d_sg4_7_lpi_1_dfm_mx0}, sqrt_for_t_acc_5_itm[16]);
  assign sqrt_d_sg6_8_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_5_itm[14:13])
      , sqrt_d_sg5_7_lpi_1_dfm_mx0}, sqrt_for_t_acc_5_itm[16]);
  assign sqrt_d_sg6_16_lpi_1_dfm_mx0 = MUX_s_1_2_2({sqrt_for_7_if_slc_sqrt_for_t_3_itm_1
      , sqrt_d_sg5_16_lpi_1_dfm_1}, sqrt_for_if_slc_sqrt_for_7_t_acc_psp_10_itm_1);
  assign sqrt_d_8_lpi_1_dfm_mx0 = MUX_v_2_2_2({sqrt_for_7_if_slc_sqrt_for_t_8_itm_1
      , sqrt_z_slc_sqrt_z_1_18_itm_1}, sqrt_for_if_slc_sqrt_for_7_t_acc_psp_10_itm_1);
  assign sqrt_d_sg1_7_lpi_1_dfm_mx0 = MUX_v_2_2_2({sqrt_for_7_if_slc_sqrt_for_t_6_itm_1
      , sqrt_d_7_lpi_1_dfm_1}, sqrt_for_if_slc_sqrt_for_7_t_acc_psp_10_itm_1);
  assign sqrt_d_sg2_7_lpi_1_dfm_mx0 = MUX_v_2_2_2({sqrt_for_7_if_slc_sqrt_for_t_4_itm_1
      , sqrt_d_sg1_6_lpi_1_dfm_1}, sqrt_for_if_slc_sqrt_for_7_t_acc_psp_10_itm_1);
  assign sqrt_d_sg3_7_lpi_1_dfm_mx0 = MUX_v_2_2_2({sqrt_for_7_if_slc_sqrt_for_t_2_itm_1
      , sqrt_d_sg2_6_lpi_1_dfm_1}, sqrt_for_if_slc_sqrt_for_7_t_acc_psp_10_itm_1);
  assign sqrt_d_sg4_7_lpi_1_dfm_mx0 = MUX_v_2_2_2({sqrt_for_7_if_slc_sqrt_for_t_itm_1
      , sqrt_d_sg3_6_lpi_1_dfm_1}, sqrt_for_if_slc_sqrt_for_7_t_acc_psp_10_itm_1);
  assign sqrt_d_sg5_7_lpi_1_dfm_mx0 = MUX_v_2_2_2({sqrt_for_7_if_slc_sqrt_for_t_1_itm_1
      , sqrt_d_sg4_6_lpi_1_dfm_1}, sqrt_for_if_slc_sqrt_for_7_t_acc_psp_10_itm_1);
  assign sqrt_d_sg5_16_lpi_1_dfm_1_mx0 = MUX_s_1_2_2({(sqrt_for_t_acc_3_itm[11])
      , sqrt_d_sg4_17_lpi_1_dfm_mx0}, sqrt_for_t_acc_3_itm[12]);
  assign sqrt_d_7_lpi_1_dfm_1_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_3_itm[2:1]) , (sqrt_acc_psp_sva[23:22])},
      sqrt_for_t_acc_3_itm[12]);
  assign sqrt_d_sg1_6_lpi_1_dfm_1_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_3_itm[4:3])
      , sqrt_d_6_lpi_1_dfm_mx0}, sqrt_for_t_acc_3_itm[12]);
  assign sqrt_d_sg2_6_lpi_1_dfm_1_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_3_itm[6:5])
      , sqrt_d_sg1_5_lpi_1_dfm_mx0}, sqrt_for_t_acc_3_itm[12]);
  assign sqrt_d_sg3_6_lpi_1_dfm_1_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_3_itm[8:7])
      , sqrt_d_sg2_5_lpi_1_dfm_mx0}, sqrt_for_t_acc_3_itm[12]);
  assign sqrt_d_sg4_6_lpi_1_dfm_1_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_3_itm[10:9])
      , sqrt_d_sg3_5_lpi_1_dfm_mx0}, sqrt_for_t_acc_3_itm[12]);
  assign nl_sqrt_for_t_acc_4_itm = conv_u2s_14_15({sqrt_d_sg5_16_lpi_1_dfm_1_mx0
      , sqrt_d_sg4_6_lpi_1_dfm_1_mx0 , sqrt_d_sg3_6_lpi_1_dfm_1_mx0 , sqrt_d_sg2_6_lpi_1_dfm_1_mx0
      , sqrt_d_sg1_6_lpi_1_dfm_1_mx0 , sqrt_d_7_lpi_1_dfm_1_mx0 , (sqrt_acc_psp_sva[21:20])
      , 1'b1}) + conv_s2s_10_15({1'b1 , (~ (sqrt_acc_psp_sva[32])) , (sqrt_for_2_t_acc_tmp[3])
      , (sqrt_for_t_acc_itm[6]) , (sqrt_for_t_acc_1_itm[8]) , (sqrt_for_t_acc_2_itm[10])
      , (sqrt_for_t_acc_3_itm[12]) , 3'b101});
  assign sqrt_for_t_acc_4_itm = nl_sqrt_for_t_acc_4_itm[14:0];
  assign nl_sqrt_for_t_acc_3_itm = conv_u2s_12_13({sqrt_d_sg4_17_lpi_1_dfm_mx0 ,
      sqrt_d_sg3_5_lpi_1_dfm_mx0 , sqrt_d_sg2_5_lpi_1_dfm_mx0 , sqrt_d_sg1_5_lpi_1_dfm_mx0
      , sqrt_d_6_lpi_1_dfm_mx0 , (sqrt_acc_psp_sva[23:22]) , 1'b1}) + conv_s2s_9_13({1'b1
      , (~ (sqrt_acc_psp_sva[32])) , (sqrt_for_2_t_acc_tmp[3]) , (sqrt_for_t_acc_itm[6])
      , (sqrt_for_t_acc_1_itm[8]) , (sqrt_for_t_acc_2_itm[10]) , 3'b101});
  assign sqrt_for_t_acc_3_itm = nl_sqrt_for_t_acc_3_itm[12:0];
  assign nl_sqrt_for_t_acc_2_itm = conv_u2s_10_11({sqrt_d_sg3_17_lpi_1_dfm_mx0 ,
      sqrt_d_sg2_4_lpi_1_dfm_mx0 , sqrt_d_sg1_4_lpi_1_dfm_mx0 , sqrt_d_5_lpi_1_dfm_mx0
      , (sqrt_acc_psp_sva[25:24]) , 1'b1}) + conv_s2s_8_11({1'b1 , (~ (sqrt_acc_psp_sva[32]))
      , (sqrt_for_2_t_acc_tmp[3]) , (sqrt_for_t_acc_itm[6]) , (sqrt_for_t_acc_1_itm[8])
      , 3'b101});
  assign sqrt_for_t_acc_2_itm = nl_sqrt_for_t_acc_2_itm[10:0];
  assign nl_sqrt_for_t_acc_1_itm = conv_u2s_8_9({sqrt_d_sg2_17_lpi_1_dfm_mx0 , sqrt_d_sg1_3_lpi_1_dfm_mx0
      , sqrt_d_4_lpi_1_dfm_mx0 , (sqrt_acc_psp_sva[27:26]) , 1'b1}) + conv_s2s_7_9({1'b1
      , (~ (sqrt_acc_psp_sva[32])) , (sqrt_for_2_t_acc_tmp[3]) , (sqrt_for_t_acc_itm[6])
      , 3'b101});
  assign sqrt_for_t_acc_1_itm = nl_sqrt_for_t_acc_1_itm[8:0];
  assign nl_sqrt_for_t_acc_itm = conv_u2s_6_7({sqrt_d_sg1_17_lpi_1_dfm , sqrt_d_3_lpi_1_dfm_mx0
      , (sqrt_acc_psp_sva[29:28]) , 1'b1}) + conv_s2s_6_7({1'b1 , (~ (sqrt_acc_psp_sva[32]))
      , (sqrt_for_2_t_acc_tmp[3]) , 3'b101});
  assign sqrt_for_t_acc_itm = nl_sqrt_for_t_acc_itm[6:0];
  assign nl_sqrt_for_2_t_acc_tmp = conv_s2s_3_4(sqrt_acc_psp_sva[32:30]) + 4'b1111;
  assign sqrt_for_2_t_acc_tmp = nl_sqrt_for_2_t_acc_tmp[3:0];
  assign nl_sqrt_acc_psp_sva = conv_u2u_32_33(conv_u2u_64_32(conv_u2u_16_32({{2{ACC1_if_2_acc_itm[13]}},
      ACC1_if_2_acc_itm}) * conv_u2u_16_32({{2{ACC1_if_2_acc_itm[13]}}, ACC1_if_2_acc_itm})))
      + conv_u2u_32_33(conv_u2u_64_32(conv_u2u_16_32({{2{ACC1_if_acc_itm[13]}}, ACC1_if_acc_itm})
      * conv_u2u_16_32({{2{ACC1_if_acc_itm[13]}}, ACC1_if_acc_itm})));
  assign sqrt_acc_psp_sva = nl_sqrt_acc_psp_sva[32:0];
  assign sqrt_d_sg4_17_lpi_1_dfm_mx0 = MUX_s_1_2_2({(sqrt_for_t_acc_2_itm[9]) , sqrt_d_sg3_17_lpi_1_dfm_mx0},
      sqrt_for_t_acc_2_itm[10]);
  assign sqrt_d_6_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_2_itm[2:1]) , (sqrt_acc_psp_sva[25:24])},
      sqrt_for_t_acc_2_itm[10]);
  assign sqrt_d_sg1_5_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_2_itm[4:3]) ,
      sqrt_d_5_lpi_1_dfm_mx0}, sqrt_for_t_acc_2_itm[10]);
  assign sqrt_d_sg2_5_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_2_itm[6:5]) ,
      sqrt_d_sg1_4_lpi_1_dfm_mx0}, sqrt_for_t_acc_2_itm[10]);
  assign sqrt_d_sg3_5_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_2_itm[8:7]) ,
      sqrt_d_sg2_4_lpi_1_dfm_mx0}, sqrt_for_t_acc_2_itm[10]);
  assign sqrt_d_sg3_17_lpi_1_dfm_mx0 = MUX_s_1_2_2({(sqrt_for_t_acc_1_itm[7]) , sqrt_d_sg2_17_lpi_1_dfm_mx0},
      sqrt_for_t_acc_1_itm[8]);
  assign sqrt_d_5_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_1_itm[2:1]) , (sqrt_acc_psp_sva[27:26])},
      sqrt_for_t_acc_1_itm[8]);
  assign sqrt_d_sg1_4_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_1_itm[4:3]) ,
      sqrt_d_4_lpi_1_dfm_mx0}, sqrt_for_t_acc_1_itm[8]);
  assign sqrt_d_sg2_4_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_1_itm[6:5]) ,
      sqrt_d_sg1_3_lpi_1_dfm_mx0}, sqrt_for_t_acc_1_itm[8]);
  assign sqrt_d_sg2_17_lpi_1_dfm_mx0 = MUX_s_1_2_2({(sqrt_for_t_acc_itm[5]) , sqrt_d_sg1_17_lpi_1_dfm},
      sqrt_for_t_acc_itm[6]);
  assign sqrt_d_4_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_itm[2:1]) , (sqrt_acc_psp_sva[29:28])},
      sqrt_for_t_acc_itm[6]);
  assign sqrt_d_sg1_3_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_t_acc_itm[4:3]) , sqrt_d_3_lpi_1_dfm_mx0},
      sqrt_for_t_acc_itm[6]);
  assign sqrt_d_sg1_17_lpi_1_dfm = (sqrt_for_2_t_acc_tmp[2]) & (~ (sqrt_for_2_t_acc_tmp[3]));
  assign sqrt_d_3_lpi_1_dfm_mx0 = MUX_v_2_2_2({(sqrt_for_2_t_acc_tmp[1:0]) , (sqrt_acc_psp_sva[31:30])},
      sqrt_for_2_t_acc_tmp[3]);
  assign nl_acc_4_psp_sva = conv_u2u_11_12(conv_u2u_10_11(regs_regs_slc_regs_regs_2_4_itm)
      + conv_u2u_10_11(regs_regs_slc_regs_regs_2_5_itm)) + conv_u2u_10_12(regs_regs_slc_regs_regs_2_3_itm);
  assign acc_4_psp_sva = nl_acc_4_psp_sva[11:0];
  assign nl_acc_4_psp_1_sva = conv_u2u_11_12(conv_u2u_10_11(vin_rsc_mgc_in_wire_d[49:40])
      + conv_u2u_10_11(vin_rsc_mgc_in_wire_d[39:30])) + conv_u2u_10_12(vin_rsc_mgc_in_wire_d[59:50]);
  assign acc_4_psp_1_sva = nl_acc_4_psp_1_sva[11:0];
  assign nl_ACC1_acc_10_psp_sva = conv_u2s_10_12({(acc_8_psp_sva[11]) , (conv_u2u_8_9({(acc_8_psp_sva[11])
      , 1'b0 , (acc_8_psp_sva[11]) , 1'b0 , (acc_8_psp_sva[11]) , 1'b0 , (signext_2_1(acc_8_psp_sva[7]))})
      + conv_u2u_8_9(readslicef_9_8_1((({(acc_8_psp_sva[9]) , 1'b0 , (acc_8_psp_sva[9])
      , 1'b0 , (acc_8_psp_sva[9]) , 1'b0 , (signext_2_1(acc_8_psp_sva[5])) , 1'b1})
      + conv_u2u_8_9({(readslicef_8_7_1((conv_u2u_7_8({(acc_8_psp_sva[7]) , 1'b0
      , (acc_8_psp_sva[5]) , 1'b0 , (signext_2_1(acc_8_psp_sva[9])) , 1'b1}) + conv_u2u_6_8({(acc_8_psp_sva[6])
      , 1'b0 , (acc_8_psp_sva[6]) , 1'b0 , (acc_8_psp_sva[6]) , (acc_imod_7_sva[1])}))))
      , (~ (readslicef_3_1_2((({1'b1 , (acc_imod_7_sva[0]) , 1'b1}) + conv_u2s_2_3({(~
      (acc_imod_7_sva[1])) , (~ (acc_imod_7_sva[2]))})))))})))))}) + conv_s2s_10_12(conv_u2s_9_10({(acc_8_psp_sva[10])
      , 1'b0 , (acc_8_psp_sva[10]) , 1'b0 , (acc_8_psp_sva[10]) , 1'b0 , (acc_8_psp_sva[10])
      , 1'b0 , (acc_8_psp_sva[10])}) + conv_s2s_8_10(readslicef_9_8_1((conv_u2s_8_9({(acc_8_psp_sva[8])
      , 1'b0 , (acc_8_psp_sva[8]) , 1'b0 , (acc_8_psp_sva[8]) , 1'b0 , (acc_8_psp_sva[8])
      , 1'b1}) + conv_s2s_7_9({(readslicef_7_6_1((conv_s2s_5_7({(readslicef_5_4_1((conv_s2s_4_5({(readslicef_4_3_1((conv_u2s_3_4({(acc_8_psp_sva[3])
      , (acc_8_psp_sva[1]) , 1'b1}) + conv_s2s_3_4({1'b1 , (acc_8_psp_sva[2]) , (acc_8_psp_sva[3])}))))
      , 1'b1}) + conv_s2s_3_5({(acc_9_psp_sva[3:2]) , (acc_8_psp_sva[4])})))) , 1'b1})
      + conv_u2s_5_7({(acc_8_psp_sva[7]) , (acc_8_psp_sva[4]) , (signext_2_1(acc_8_psp_sva[11]))
      , (acc_9_psp_sva[1])})))) , (~ (acc_imod_7_sva[2]))})))));
  assign ACC1_acc_10_psp_sva = nl_ACC1_acc_10_psp_sva[11:0];
  assign nl_acc_5_psp_sva = (readslicef_5_4_1((conv_u2u_4_5({(readslicef_4_3_1((conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_4_psp_sva[3])) , 1'b1}) + conv_u2u_2_3({(acc_4_psp_sva[4]) , (acc_4_psp_sva[8])}))))
      , 1'b1}) + conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~ (acc_4_psp_sva[5]))
      , 1'b1}) + conv_u2u_2_3({(acc_4_psp_sva[6]) , (~ (acc_4_psp_sva[7]))})))) ,
      (acc_4_psp_sva[10])})))) , 1'b1}) + conv_u2u_3_5({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_4_psp_sva[1])) , 1'b1}) + conv_u2u_2_3({(acc_4_psp_sva[2]) , (~ (acc_4_psp_sva[9]))}))))
      , (~ (acc_4_psp_sva[11]))})))) + ({3'b101 , (acc_4_psp_sva[0])});
  assign acc_5_psp_sva = nl_acc_5_psp_sva[3:0];
  assign nl_acc_imod_4_sva = conv_s2s_2_3(conv_s2s_1_2(acc_5_psp_sva[1]) + conv_u2s_1_2(acc_5_psp_sva[0]))
      + conv_s2s_2_3(acc_5_psp_sva[3:2]);
  assign acc_imod_4_sva = nl_acc_imod_4_sva[2:0];
  assign nl_acc_5_psp_1_sva = (readslicef_5_4_1((conv_u2u_4_5({(readslicef_4_3_1((conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_4_psp_1_sva[3])) , 1'b1}) + conv_u2u_2_3({(acc_4_psp_1_sva[4]) , (acc_4_psp_1_sva[8])}))))
      , 1'b1}) + conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~ (acc_4_psp_1_sva[5]))
      , 1'b1}) + conv_u2u_2_3({(acc_4_psp_1_sva[6]) , (~ (acc_4_psp_1_sva[7]))}))))
      , (acc_4_psp_1_sva[10])})))) , 1'b1}) + conv_u2u_3_5({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_4_psp_1_sva[1])) , 1'b1}) + conv_u2u_2_3({(acc_4_psp_1_sva[2]) , (~ (acc_4_psp_1_sva[9]))}))))
      , (~ (acc_4_psp_1_sva[11]))})))) + ({3'b101 , (acc_4_psp_1_sva[0])});
  assign acc_5_psp_1_sva = nl_acc_5_psp_1_sva[3:0];
  assign nl_acc_imod_11_sva = conv_s2s_2_3(conv_s2s_1_2(acc_5_psp_1_sva[1]) + conv_u2s_1_2(acc_5_psp_1_sva[0]))
      + conv_s2s_2_3(acc_5_psp_1_sva[3:2]);
  assign acc_imod_11_sva = nl_acc_imod_11_sva[2:0];
  assign nl_ACC1_if_acc_2_psp_sva = conv_s2s_11_12({1'b1 , (conv_u2s_9_10({(acc_psp_1_sva[11])
      , 1'b0 , (acc_psp_1_sva[11]) , 1'b0 , (signext_2_1(acc_psp_1_sva[11])) , 2'b0
      , (acc_imod_9_sva[2])}) + ({1'b1 , (readslicef_10_9_1((({(acc_psp_1_sva[9])
      , 1'b0 , (acc_psp_1_sva[9]) , 1'b0 , (signext_2_1(acc_psp_1_sva[9])) , 2'b0
      , (acc_psp_1_sva[3]) , 1'b1}) + conv_s2s_9_10({1'b1 , (readslicef_8_7_1((conv_u2s_7_8({4'b1010
      , (signext_2_1(~ (acc_psp_1_sva[7]))) , 1'b1}) + conv_s2s_7_8({(readslicef_7_6_1((conv_s2s_5_7({(readslicef_5_4_1((conv_s2s_3_5({(~
      (acc_1_psp_1_sva[3:2])) , 1'b1}) + conv_u2s_3_5(signext_3_2({(~ (acc_psp_1_sva[9]))
      , (~ (acc_psp_1_sva[1]))}))))) , 1'b1}) + conv_u2s_5_7({(~ (acc_psp_1_sva[7]))
      , (~ (acc_psp_1_sva[3])) , (signext_2_1(~ (acc_psp_1_sva[11]))) , (~ (acc_psp_1_sva[2]))}))))
      , (~ (acc_1_psp_1_sva[1]))})))) , (readslicef_3_1_2((({1'b1 , (acc_imod_9_sva[0])
      , 1'b1}) + conv_u2s_2_3({(~ (acc_imod_9_sva[1])) , (~ (acc_imod_9_sva[2]))}))))}))))}))})
      + conv_s2s_10_12(({(acc_psp_1_sva[10]) , 1'b0 , (acc_psp_1_sva[10]) , 1'b0
      , (acc_psp_1_sva[10]) , 1'b0 , (acc_psp_1_sva[10]) , 1'b0 , (signext_2_1(acc_psp_1_sva[10]))})
      + conv_s2s_8_10(readslicef_9_8_1((({(readslicef_9_8_1((conv_s2s_7_9({(acc_psp_1_sva[6])
      , 1'b0 , (acc_psp_1_sva[6]) , 1'b0 , (signext_2_1(acc_psp_1_sva[6])) , 1'b1})
      + conv_u2s_7_9({(~ (acc_psp_1_sva[7])) , 1'b1 , (~ (acc_psp_1_sva[5:4])) ,
      (signext_2_1(~ (acc_psp_1_sva[5]))) , (~ (acc_psp_1_sva[4]))})))) , 1'b1})
      + ({(acc_psp_1_sva[8]) , 1'b0 , (acc_psp_1_sva[8]) , 1'b0 , (acc_psp_1_sva[8])
      , 1'b0 , (signext_2_1(acc_psp_1_sva[8])) , (~ (acc_imod_9_sva[1]))})))));
  assign ACC1_if_acc_2_psp_sva = nl_ACC1_if_acc_2_psp_sva[11:0];
  assign nl_ACC1_acc_10_psp_1_sva = conv_u2s_10_12({(acc_8_psp_1_sva[11]) , (conv_u2u_8_9({(acc_8_psp_1_sva[11])
      , 1'b0 , (acc_8_psp_1_sva[11]) , 1'b0 , (acc_8_psp_1_sva[11]) , 1'b0 , (signext_2_1(acc_8_psp_1_sva[7]))})
      + conv_u2u_8_9(readslicef_9_8_1((({(acc_8_psp_1_sva[9]) , 1'b0 , (acc_8_psp_1_sva[9])
      , 1'b0 , (acc_8_psp_1_sva[9]) , 1'b0 , (signext_2_1(acc_8_psp_1_sva[5])) ,
      1'b1}) + conv_u2u_8_9({(readslicef_8_7_1((conv_u2u_7_8({(acc_8_psp_1_sva[7])
      , 1'b0 , (acc_8_psp_1_sva[5]) , 1'b0 , (signext_2_1(acc_8_psp_1_sva[9])) ,
      1'b1}) + conv_u2u_6_8({(acc_8_psp_1_sva[6]) , 1'b0 , (acc_8_psp_1_sva[6]) ,
      1'b0 , (acc_8_psp_1_sva[6]) , (acc_imod_13_sva[1])})))) , (~ (readslicef_3_1_2((({1'b1
      , (acc_imod_13_sva[0]) , 1'b1}) + conv_u2s_2_3({(~ (acc_imod_13_sva[1])) ,
      (~ (acc_imod_13_sva[2]))})))))})))))}) + conv_s2s_10_12(conv_u2s_9_10({(acc_8_psp_1_sva[10])
      , 1'b0 , (acc_8_psp_1_sva[10]) , 1'b0 , (acc_8_psp_1_sva[10]) , 1'b0 , (acc_8_psp_1_sva[10])
      , 1'b0 , (acc_8_psp_1_sva[10])}) + conv_s2s_8_10(readslicef_9_8_1((conv_u2s_8_9({(acc_8_psp_1_sva[8])
      , 1'b0 , (acc_8_psp_1_sva[8]) , 1'b0 , (acc_8_psp_1_sva[8]) , 1'b0 , (acc_8_psp_1_sva[8])
      , 1'b1}) + conv_s2s_7_9({(readslicef_7_6_1((conv_s2s_5_7({(readslicef_5_4_1((conv_s2s_4_5({(readslicef_4_3_1((conv_u2s_3_4({(acc_8_psp_1_sva[3])
      , (acc_8_psp_1_sva[1]) , 1'b1}) + conv_s2s_3_4({1'b1 , (acc_8_psp_1_sva[2])
      , (acc_8_psp_1_sva[3])})))) , 1'b1}) + conv_s2s_3_5({(acc_9_psp_1_sva[3:2])
      , (acc_8_psp_1_sva[4])})))) , 1'b1}) + conv_u2s_5_7({(acc_8_psp_1_sva[7]) ,
      (acc_8_psp_1_sva[4]) , (signext_2_1(acc_8_psp_1_sva[11])) , (acc_9_psp_1_sva[1])}))))
      , (~ (acc_imod_13_sva[2]))})))));
  assign ACC1_acc_10_psp_1_sva = nl_ACC1_acc_10_psp_1_sva[11:0];
  assign nl_ACC1_acc_8_psp_sva = conv_u2s_10_12({(acc_psp_sva[11]) , (conv_u2u_8_9({(acc_psp_sva[11])
      , 1'b0 , (acc_psp_sva[11]) , 1'b0 , (acc_psp_sva[11]) , 1'b0 , (signext_2_1(acc_psp_sva[7]))})
      + conv_u2u_8_9(readslicef_9_8_1((({(acc_psp_sva[9]) , 1'b0 , (acc_psp_sva[9])
      , 1'b0 , (acc_psp_sva[9]) , 1'b0 , (signext_2_1(acc_psp_sva[5])) , 1'b1}) +
      conv_u2u_8_9({(readslicef_8_7_1((conv_u2u_7_8({(acc_psp_sva[7]) , 1'b0 , (acc_psp_sva[5])
      , 1'b0 , (signext_2_1(acc_psp_sva[9])) , 1'b1}) + conv_u2u_6_8({(acc_psp_sva[6])
      , 1'b0 , (acc_psp_sva[6]) , 1'b0 , (acc_psp_sva[6]) , (acc_imod_1_sva[1])}))))
      , (~ (readslicef_3_1_2((({1'b1 , (acc_imod_1_sva[0]) , 1'b1}) + conv_u2s_2_3({(~
      (acc_imod_1_sva[1])) , (~ (acc_imod_1_sva[2]))})))))})))))}) + conv_s2s_10_12(conv_u2s_9_10({(acc_psp_sva[10])
      , 1'b0 , (acc_psp_sva[10]) , 1'b0 , (acc_psp_sva[10]) , 1'b0 , (acc_psp_sva[10])
      , 1'b0 , (acc_psp_sva[10])}) + conv_s2s_8_10(readslicef_9_8_1((conv_u2s_8_9({(acc_psp_sva[8])
      , 1'b0 , (acc_psp_sva[8]) , 1'b0 , (acc_psp_sva[8]) , 1'b0 , (acc_psp_sva[8])
      , 1'b1}) + conv_s2s_7_9({(readslicef_7_6_1((conv_s2s_5_7({(readslicef_5_4_1((conv_s2s_4_5({(readslicef_4_3_1((conv_u2s_3_4({(acc_psp_sva[3])
      , (acc_psp_sva[1]) , 1'b1}) + conv_s2s_3_4({1'b1 , (acc_psp_sva[2]) , (acc_psp_sva[3])}))))
      , 1'b1}) + conv_s2s_3_5({(acc_1_psp_sva[3:2]) , (acc_psp_sva[4])})))) , 1'b1})
      + conv_u2s_5_7({(acc_psp_sva[7]) , (acc_psp_sva[4]) , (signext_2_1(acc_psp_sva[11]))
      , (acc_1_psp_sva[1])})))) , (~ (acc_imod_1_sva[2]))})))));
  assign ACC1_acc_8_psp_sva = nl_ACC1_acc_8_psp_sva[11:0];
  assign nl_acc_psp_2_sva = conv_u2u_11_12(conv_u2u_10_11(reg_regs_regs_0_sva_cse[19:10])
      + conv_u2u_10_11(reg_regs_regs_0_sva_cse[9:0])) + conv_u2u_10_12(reg_regs_regs_0_sva_cse[29:20]);
  assign acc_psp_2_sva = nl_acc_psp_2_sva[11:0];
  assign nl_acc_8_psp_2_sva = conv_u2u_11_12(conv_u2u_10_11(reg_regs_regs_0_sva_cse[79:70])
      + conv_u2u_10_11(reg_regs_regs_0_sva_cse[69:60])) + conv_u2u_10_12(reg_regs_regs_0_sva_cse[89:80]);
  assign acc_8_psp_2_sva = nl_acc_8_psp_2_sva[11:0];
  assign nl_acc_imod_10_sva = conv_s2s_2_3(conv_s2s_1_2(acc_1_psp_2_sva[1]) + conv_u2s_1_2(acc_1_psp_2_sva[0]))
      + conv_s2s_2_3(acc_1_psp_2_sva[3:2]);
  assign acc_imod_10_sva = nl_acc_imod_10_sva[2:0];
  assign nl_acc_9_psp_2_sva = (readslicef_5_4_1((conv_u2u_4_5({(readslicef_4_3_1((conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_8_psp_2_sva[3])) , 1'b1}) + conv_u2u_2_3({(acc_8_psp_2_sva[4]) , (acc_8_psp_2_sva[8])}))))
      , 1'b1}) + conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~ (acc_8_psp_2_sva[5]))
      , 1'b1}) + conv_u2u_2_3({(acc_8_psp_2_sva[6]) , (~ (acc_8_psp_2_sva[7]))}))))
      , (acc_8_psp_2_sva[10])})))) , 1'b1}) + conv_u2u_3_5({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_8_psp_2_sva[1])) , 1'b1}) + conv_u2u_2_3({(acc_8_psp_2_sva[2]) , (~ (acc_8_psp_2_sva[9]))}))))
      , (~ (acc_8_psp_2_sva[11]))})))) + ({3'b101 , (acc_8_psp_2_sva[0])});
  assign acc_9_psp_2_sva = nl_acc_9_psp_2_sva[3:0];
  assign nl_acc_imod_14_sva = conv_s2s_2_3(conv_s2s_1_2(acc_9_psp_2_sva[1]) + conv_u2s_1_2(acc_9_psp_2_sva[0]))
      + conv_s2s_2_3(acc_9_psp_2_sva[3:2]);
  assign acc_imod_14_sva = nl_acc_imod_14_sva[2:0];
  assign nl_acc_1_psp_2_sva = (readslicef_5_4_1((conv_u2u_4_5({(readslicef_4_3_1((conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_psp_2_sva[3])) , 1'b1}) + conv_u2u_2_3({(acc_psp_2_sva[4]) , (acc_psp_2_sva[8])}))))
      , 1'b1}) + conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~ (acc_psp_2_sva[5]))
      , 1'b1}) + conv_u2u_2_3({(acc_psp_2_sva[6]) , (~ (acc_psp_2_sva[7]))})))) ,
      (acc_psp_2_sva[10])})))) , 1'b1}) + conv_u2u_3_5({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_psp_2_sva[1])) , 1'b1}) + conv_u2u_2_3({(acc_psp_2_sva[2]) , (~ (acc_psp_2_sva[9]))}))))
      , (~ (acc_psp_2_sva[11]))})))) + ({3'b101 , (acc_psp_2_sva[0])});
  assign acc_1_psp_2_sva = nl_acc_1_psp_2_sva[3:0];
  assign nl_acc_8_psp_sva = conv_u2u_11_12(conv_u2u_10_11(regs_regs_slc_regs_regs_2_7_itm)
      + conv_u2u_10_11(regs_regs_slc_regs_regs_2_8_itm)) + conv_u2u_10_12(regs_regs_slc_regs_regs_2_6_itm);
  assign acc_8_psp_sva = nl_acc_8_psp_sva[11:0];
  assign nl_acc_imod_7_sva = conv_s2s_2_3(conv_s2s_1_2(acc_9_psp_sva[1]) + conv_u2s_1_2(acc_9_psp_sva[0]))
      + conv_s2s_2_3(acc_9_psp_sva[3:2]);
  assign acc_imod_7_sva = nl_acc_imod_7_sva[2:0];
  assign nl_acc_9_psp_sva = (readslicef_5_4_1((conv_u2u_4_5({(readslicef_4_3_1((conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_8_psp_sva[3])) , 1'b1}) + conv_u2u_2_3({(acc_8_psp_sva[4]) , (acc_8_psp_sva[8])}))))
      , 1'b1}) + conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~ (acc_8_psp_sva[5]))
      , 1'b1}) + conv_u2u_2_3({(acc_8_psp_sva[6]) , (~ (acc_8_psp_sva[7]))})))) ,
      (acc_8_psp_sva[10])})))) , 1'b1}) + conv_u2u_3_5({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_8_psp_sva[1])) , 1'b1}) + conv_u2u_2_3({(acc_8_psp_sva[2]) , (~ (acc_8_psp_sva[9]))}))))
      , (~ (acc_8_psp_sva[11]))})))) + ({3'b101 , (acc_8_psp_sva[0])});
  assign acc_9_psp_sva = nl_acc_9_psp_sva[3:0];
  assign nl_acc_psp_sva = conv_u2u_11_12(conv_u2u_10_11(regs_regs_slc_regs_regs_2_1_itm)
      + conv_u2u_10_11(regs_regs_slc_regs_regs_2_2_itm)) + conv_u2u_10_12(regs_regs_slc_regs_regs_2_itm);
  assign acc_psp_sva = nl_acc_psp_sva[11:0];
  assign nl_acc_imod_1_sva = conv_s2s_2_3(conv_s2s_1_2(acc_1_psp_sva[1]) + conv_u2s_1_2(acc_1_psp_sva[0]))
      + conv_s2s_2_3(acc_1_psp_sva[3:2]);
  assign acc_imod_1_sva = nl_acc_imod_1_sva[2:0];
  assign nl_acc_1_psp_sva = (readslicef_5_4_1((conv_u2u_4_5({(readslicef_4_3_1((conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_psp_sva[3])) , 1'b1}) + conv_u2u_2_3({(acc_psp_sva[4]) , (acc_psp_sva[8])}))))
      , 1'b1}) + conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~ (acc_psp_sva[5]))
      , 1'b1}) + conv_u2u_2_3({(acc_psp_sva[6]) , (~ (acc_psp_sva[7]))})))) , (acc_psp_sva[10])}))))
      , 1'b1}) + conv_u2u_3_5({(readslicef_3_2_1((conv_u2u_2_3({(~ (acc_psp_sva[1]))
      , 1'b1}) + conv_u2u_2_3({(acc_psp_sva[2]) , (~ (acc_psp_sva[9]))})))) , (~
      (acc_psp_sva[11]))})))) + ({3'b101 , (acc_psp_sva[0])});
  assign acc_1_psp_sva = nl_acc_1_psp_sva[3:0];
  assign nl_acc_psp_1_sva = conv_u2u_11_12(conv_u2u_10_11(vin_rsc_mgc_in_wire_d[19:10])
      + conv_u2u_10_11(vin_rsc_mgc_in_wire_d[9:0])) + conv_u2u_10_12(vin_rsc_mgc_in_wire_d[29:20]);
  assign acc_psp_1_sva = nl_acc_psp_1_sva[11:0];
  assign nl_acc_imod_9_sva = conv_s2s_2_3(conv_s2s_1_2(acc_1_psp_1_sva[1]) + conv_u2s_1_2(acc_1_psp_1_sva[0]))
      + conv_s2s_2_3(acc_1_psp_1_sva[3:2]);
  assign acc_imod_9_sva = nl_acc_imod_9_sva[2:0];
  assign nl_acc_1_psp_1_sva = (readslicef_5_4_1((conv_u2u_4_5({(readslicef_4_3_1((conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_psp_1_sva[3])) , 1'b1}) + conv_u2u_2_3({(acc_psp_1_sva[4]) , (acc_psp_1_sva[8])}))))
      , 1'b1}) + conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~ (acc_psp_1_sva[5]))
      , 1'b1}) + conv_u2u_2_3({(acc_psp_1_sva[6]) , (~ (acc_psp_1_sva[7]))})))) ,
      (acc_psp_1_sva[10])})))) , 1'b1}) + conv_u2u_3_5({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_psp_1_sva[1])) , 1'b1}) + conv_u2u_2_3({(acc_psp_1_sva[2]) , (~ (acc_psp_1_sva[9]))}))))
      , (~ (acc_psp_1_sva[11]))})))) + ({3'b101 , (acc_psp_1_sva[0])});
  assign acc_1_psp_1_sva = nl_acc_1_psp_1_sva[3:0];
  assign nl_acc_8_psp_1_sva = conv_u2u_11_12(conv_u2u_10_11(vin_rsc_mgc_in_wire_d[79:70])
      + conv_u2u_10_11(vin_rsc_mgc_in_wire_d[69:60])) + conv_u2u_10_12(vin_rsc_mgc_in_wire_d[89:80]);
  assign acc_8_psp_1_sva = nl_acc_8_psp_1_sva[11:0];
  assign nl_acc_imod_13_sva = conv_s2s_2_3(conv_s2s_1_2(acc_9_psp_1_sva[1]) + conv_u2s_1_2(acc_9_psp_1_sva[0]))
      + conv_s2s_2_3(acc_9_psp_1_sva[3:2]);
  assign acc_imod_13_sva = nl_acc_imod_13_sva[2:0];
  assign nl_acc_9_psp_1_sva = (readslicef_5_4_1((conv_u2u_4_5({(readslicef_4_3_1((conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_8_psp_1_sva[3])) , 1'b1}) + conv_u2u_2_3({(acc_8_psp_1_sva[4]) , (acc_8_psp_1_sva[8])}))))
      , 1'b1}) + conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~ (acc_8_psp_1_sva[5]))
      , 1'b1}) + conv_u2u_2_3({(acc_8_psp_1_sva[6]) , (~ (acc_8_psp_1_sva[7]))}))))
      , (acc_8_psp_1_sva[10])})))) , 1'b1}) + conv_u2u_3_5({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_8_psp_1_sva[1])) , 1'b1}) + conv_u2u_2_3({(acc_8_psp_1_sva[2]) , (~ (acc_8_psp_1_sva[9]))}))))
      , (~ (acc_8_psp_1_sva[11]))})))) + ({3'b101 , (acc_8_psp_1_sva[0])});
  assign acc_9_psp_1_sva = nl_acc_9_psp_1_sva[3:0];
  assign nl_ACC1_if_2_acc_itm = conv_s2s_13_14(ACC1_if_2_acc_45_itm_1) + conv_s2s_13_14(ACC1_if_2_acc_44_itm_1);
  assign ACC1_if_2_acc_itm = nl_ACC1_if_2_acc_itm[13:0];
  assign nl_ACC1_if_acc_itm = conv_s2s_13_14(ACC1_if_acc_52_itm_1) + conv_s2s_13_14(ACC1_if_acc_51_itm_1);
  assign ACC1_if_acc_itm = nl_ACC1_if_acc_itm[13:0];
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      vout_rsc_mgc_out_stdreg_d <= 30'b0;
      sqrt_for_if_slc_sqrt_for_8_t_acc_psp_12_itm_1 <= 1'b0;
      sqrt_for_9_slc_sqrt_for_t_11_itm_1 <= 1'b0;
      sqrt_for_10_slc_sqrt_for_t_10_itm_1 <= 1'b0;
      sqrt_for_11_slc_sqrt_for_t_9_itm_1 <= 1'b0;
      FRAME_nand_cse_sva_1 <= 1'b0;
      FRAME_nand_1_cse_sva_1 <= 1'b0;
      FRAME_nand_2_cse_sva_1 <= 1'b0;
      sqrt_for_12_slc_sqrt_for_t_2_itm_1 <= 1'b0;
      sqrt_for_13_slc_sqrt_for_t_2_itm_1 <= 1'b0;
      sqrt_for_14_slc_sqrt_for_t_2_itm_1 <= 1'b0;
      reg_sqrt_for_if_slc_sqrt_for_7_t_acc_psp_20_itm_2_cse <= 1'b0;
      reg_sqrt_for_if_slc_sqrt_for_6_t_acc_psp_21_itm_2_cse <= 1'b0;
      reg_sqrt_for_if_slc_sqrt_for_5_t_acc_psp_22_itm_2_cse <= 1'b0;
      sqrt_z_slc_sqrt_z_1_38_itm_2 <= 2'b0;
      sqrt_z_slc_sqrt_z_1_2_itm_2 <= 2'b0;
      sqrt_z_slc_sqrt_z_1_59_itm_2 <= 1'b0;
      sqrt_for_if_slc_sqrt_for_2_t_acc_psp_23_itm_2 <= 1'b0;
      sqrt_for_if_slc_sqrt_for_3_t_acc_psp_21_itm_2 <= 1'b0;
      sqrt_for_if_slc_sqrt_for_4_t_acc_psp_19_itm_2 <= 1'b0;
      sqrt_z_slc_sqrt_z_1_36_itm_2 <= 2'b0;
      sqrt_d_15_lpi_1_dfm_1 <= 2'b0;
      sqrt_d_sg1_14_lpi_1_dfm_1 <= 2'b0;
      sqrt_d_sg2_14_lpi_1_dfm_1 <= 2'b0;
      sqrt_d_sg3_14_lpi_1_dfm_1 <= 2'b0;
      sqrt_d_sg4_14_lpi_1_dfm_1 <= 2'b0;
      sqrt_d_sg5_14_lpi_1_dfm_1 <= 2'b0;
      sqrt_d_sg6_14_lpi_1_dfm_1 <= 2'b0;
      sqrt_for_mux_89_itm_1 <= 1'b0;
      sqrt_d_sg7_14_lpi_1_dfm_1 <= 2'b0;
      main_stage_0_2 <= 1'b0;
      main_stage_0_3 <= 1'b0;
      main_stage_0_4 <= 1'b0;
      sqrt_for_if_slc_sqrt_for_4_t_acc_psp_23_itm_1 <= 1'b0;
      sqrt_for_if_slc_sqrt_for_3_t_acc_psp_24_itm_1 <= 1'b0;
      sqrt_for_if_slc_sqrt_for_2_t_acc_psp_25_itm_1 <= 1'b0;
      sqrt_z_slc_sqrt_z_1_34_itm_1 <= 2'b0;
      sqrt_z_slc_sqrt_z_1_56_itm_1 <= 1'b0;
      sqrt_for_if_slc_sqrt_for_5_t_acc_psp_14_itm_1 <= 1'b0;
      sqrt_for_if_slc_sqrt_for_6_t_acc_psp_12_itm_1 <= 1'b0;
      sqrt_for_if_slc_sqrt_for_7_t_acc_psp_10_itm_1 <= 1'b0;
      sqrt_z_slc_sqrt_z_1_32_itm_1 <= 2'b0;
      sqrt_z_slc_sqrt_z_1_30_itm_1 <= 2'b0;
      sqrt_z_slc_sqrt_z_1_28_itm_1 <= 2'b0;
      sqrt_z_slc_sqrt_z_1_26_itm_1 <= 2'b0;
      sqrt_z_slc_sqrt_z_1_24_itm_1 <= 2'b0;
      sqrt_z_slc_sqrt_z_1_20_itm_1 <= 2'b0;
      sqrt_for_7_if_slc_sqrt_for_t_3_itm_1 <= 1'b0;
      sqrt_d_sg5_16_lpi_1_dfm_1 <= 1'b0;
      sqrt_for_7_if_slc_sqrt_for_t_8_itm_1 <= 2'b0;
      sqrt_z_slc_sqrt_z_1_18_itm_1 <= 2'b0;
      sqrt_for_7_if_slc_sqrt_for_t_6_itm_1 <= 2'b0;
      sqrt_d_7_lpi_1_dfm_1 <= 2'b0;
      sqrt_for_7_if_slc_sqrt_for_t_4_itm_1 <= 2'b0;
      sqrt_d_sg1_6_lpi_1_dfm_1 <= 2'b0;
      sqrt_for_7_if_slc_sqrt_for_t_2_itm_1 <= 2'b0;
      sqrt_d_sg2_6_lpi_1_dfm_1 <= 2'b0;
      sqrt_for_7_if_slc_sqrt_for_t_itm_1 <= 2'b0;
      sqrt_d_sg3_6_lpi_1_dfm_1 <= 2'b0;
      sqrt_for_7_if_slc_sqrt_for_t_1_itm_1 <= 2'b0;
      sqrt_d_sg4_6_lpi_1_dfm_1 <= 2'b0;
      sqrt_z_slc_sqrt_z_1_2_itm_1 <= 2'b0;
      sqrt_z_slc_sqrt_z_1_38_itm_1 <= 2'b0;
      sqrt_z_slc_sqrt_z_1_36_itm_1 <= 2'b0;
      ACC1_if_acc_52_itm_1 <= 13'b0;
      ACC1_if_acc_51_itm_1 <= 13'b0;
      ACC1_if_2_acc_45_itm_1 <= 13'b0;
      ACC1_if_2_acc_44_itm_1 <= 13'b0;
      regs_regs_slc_regs_regs_2_7_itm <= 10'b0;
      regs_regs_slc_regs_regs_2_8_itm <= 10'b0;
      regs_regs_slc_regs_regs_2_6_itm <= 10'b0;
      regs_regs_slc_regs_regs_2_4_itm <= 10'b0;
      regs_regs_slc_regs_regs_2_5_itm <= 10'b0;
      regs_regs_slc_regs_regs_2_3_itm <= 10'b0;
      regs_regs_slc_regs_regs_2_1_itm <= 10'b0;
      regs_regs_slc_regs_regs_2_2_itm <= 10'b0;
      regs_regs_slc_regs_regs_2_itm <= 10'b0;
      reg_regs_regs_0_sva_cse <= 90'b0;
    end
    else begin
      if ( en ) begin
        vout_rsc_mgc_out_stdreg_d <= MUX_v_30_2_2({vout_rsc_mgc_out_stdreg_d , ({(~
            sqrt_for_if_slc_sqrt_for_8_t_acc_psp_12_itm_1) , (~ sqrt_for_9_slc_sqrt_for_t_11_itm_1)
            , (~ sqrt_for_10_slc_sqrt_for_t_10_itm_1) , (~ sqrt_for_11_slc_sqrt_for_t_9_itm_1)
            , FRAME_nand_cse_sva_1 , FRAME_nand_1_cse_sva_1 , FRAME_nand_2_cse_sva_1
            , FRAME_nand_3_cse_sva , FRAME_nand_4_cse_sva , FRAME_nand_5_cse_sva
            , (~ sqrt_for_if_slc_sqrt_for_8_t_acc_psp_12_itm_1) , (~ sqrt_for_9_slc_sqrt_for_t_11_itm_1)
            , (~ sqrt_for_10_slc_sqrt_for_t_10_itm_1) , (~ sqrt_for_11_slc_sqrt_for_t_9_itm_1)
            , FRAME_nand_cse_sva_1 , FRAME_nand_1_cse_sva_1 , FRAME_nand_2_cse_sva_1
            , FRAME_nand_3_cse_sva , FRAME_nand_4_cse_sva , FRAME_nand_5_cse_sva
            , (~ sqrt_for_if_slc_sqrt_for_8_t_acc_psp_12_itm_1) , (~ sqrt_for_9_slc_sqrt_for_t_11_itm_1)
            , (~ sqrt_for_10_slc_sqrt_for_t_10_itm_1) , (~ sqrt_for_11_slc_sqrt_for_t_9_itm_1)
            , (~ sqrt_for_12_slc_sqrt_for_t_2_itm_1) , (~ sqrt_for_13_slc_sqrt_for_t_2_itm_1)
            , (~ sqrt_for_14_slc_sqrt_for_t_2_itm_1) , (~ (sqrt_for_t_acc_12_itm[19]))
            , (~ (sqrt_for_t_acc_13_itm[19])) , (~ (sqrt_for_t_acc_14_itm[19]))})},
            main_stage_0_4);
        sqrt_for_if_slc_sqrt_for_8_t_acc_psp_12_itm_1 <= sqrt_for_t_acc_5_itm[16];
        sqrt_for_9_slc_sqrt_for_t_11_itm_1 <= sqrt_for_t_acc_6_itm[18];
        sqrt_for_10_slc_sqrt_for_t_10_itm_1 <= sqrt_for_t_acc_7_itm[19];
        sqrt_for_11_slc_sqrt_for_t_9_itm_1 <= sqrt_for_t_acc_8_itm[19];
        FRAME_nand_cse_sva_1 <= ~((sqrt_for_t_acc_9_itm[19]) & sqrt_for_if_slc_sqrt_for_2_t_acc_psp_25_itm_1);
        FRAME_nand_1_cse_sva_1 <= ~((sqrt_for_t_acc_10_itm[19]) & sqrt_for_if_slc_sqrt_for_3_t_acc_psp_24_itm_1);
        FRAME_nand_2_cse_sva_1 <= ~((sqrt_for_t_acc_11_itm[19]) & sqrt_for_if_slc_sqrt_for_4_t_acc_psp_23_itm_1);
        sqrt_for_12_slc_sqrt_for_t_2_itm_1 <= sqrt_for_t_acc_9_itm[19];
        sqrt_for_13_slc_sqrt_for_t_2_itm_1 <= sqrt_for_t_acc_10_itm[19];
        sqrt_for_14_slc_sqrt_for_t_2_itm_1 <= sqrt_for_t_acc_11_itm[19];
        reg_sqrt_for_if_slc_sqrt_for_7_t_acc_psp_20_itm_2_cse <= sqrt_for_if_slc_sqrt_for_7_t_acc_psp_10_itm_1;
        reg_sqrt_for_if_slc_sqrt_for_6_t_acc_psp_21_itm_2_cse <= sqrt_for_if_slc_sqrt_for_6_t_acc_psp_12_itm_1;
        reg_sqrt_for_if_slc_sqrt_for_5_t_acc_psp_22_itm_2_cse <= sqrt_for_if_slc_sqrt_for_5_t_acc_psp_14_itm_1;
        sqrt_z_slc_sqrt_z_1_38_itm_2 <= sqrt_z_slc_sqrt_z_1_38_itm_1;
        sqrt_z_slc_sqrt_z_1_2_itm_2 <= sqrt_z_slc_sqrt_z_1_2_itm_1;
        sqrt_z_slc_sqrt_z_1_59_itm_2 <= sqrt_z_slc_sqrt_z_1_56_itm_1;
        sqrt_for_if_slc_sqrt_for_2_t_acc_psp_23_itm_2 <= sqrt_for_if_slc_sqrt_for_2_t_acc_psp_25_itm_1;
        sqrt_for_if_slc_sqrt_for_3_t_acc_psp_21_itm_2 <= sqrt_for_if_slc_sqrt_for_3_t_acc_psp_24_itm_1;
        sqrt_for_if_slc_sqrt_for_4_t_acc_psp_19_itm_2 <= sqrt_for_if_slc_sqrt_for_4_t_acc_psp_23_itm_1;
        sqrt_z_slc_sqrt_z_1_36_itm_2 <= sqrt_z_slc_sqrt_z_1_36_itm_1;
        sqrt_d_15_lpi_1_dfm_1 <= MUX_v_2_2_2({(sqrt_for_t_acc_11_itm[2:1]) , sqrt_z_slc_sqrt_z_1_34_itm_1},
            sqrt_for_t_acc_11_itm[19]);
        sqrt_d_sg1_14_lpi_1_dfm_1 <= MUX_v_2_2_2({(sqrt_for_t_acc_11_itm[4:3]) ,
            sqrt_d_14_lpi_1_dfm_mx0}, sqrt_for_t_acc_11_itm[19]);
        sqrt_d_sg2_14_lpi_1_dfm_1 <= MUX_v_2_2_2({(sqrt_for_t_acc_11_itm[6:5]) ,
            sqrt_d_sg1_13_lpi_1_dfm_mx0}, sqrt_for_t_acc_11_itm[19]);
        sqrt_d_sg3_14_lpi_1_dfm_1 <= MUX_v_2_2_2({(sqrt_for_t_acc_11_itm[8:7]) ,
            sqrt_d_sg2_13_lpi_1_dfm_mx0}, sqrt_for_t_acc_11_itm[19]);
        sqrt_d_sg4_14_lpi_1_dfm_1 <= MUX_v_2_2_2({(sqrt_for_t_acc_11_itm[10:9]) ,
            sqrt_d_sg3_13_lpi_1_dfm_mx0}, sqrt_for_t_acc_11_itm[19]);
        sqrt_d_sg5_14_lpi_1_dfm_1 <= MUX_v_2_2_2({(sqrt_for_t_acc_11_itm[12:11])
            , sqrt_d_sg4_13_lpi_1_dfm_mx0}, sqrt_for_t_acc_11_itm[19]);
        sqrt_d_sg6_14_lpi_1_dfm_1 <= MUX_v_2_2_2({(sqrt_for_t_acc_11_itm[14:13])
            , sqrt_d_sg5_13_lpi_1_dfm_mx0}, sqrt_for_t_acc_11_itm[19]);
        sqrt_for_mux_89_itm_1 <= MUX_s_1_2_2({(sqrt_for_t_acc_11_itm[17]) , (sqrt_d_sg7_13_lpi_1_dfm_mx0[0])},
            sqrt_for_t_acc_11_itm[19]);
        sqrt_d_sg7_14_lpi_1_dfm_1 <= MUX_v_2_2_2({(sqrt_for_t_acc_11_itm[16:15])
            , sqrt_d_sg6_13_lpi_1_dfm_mx0}, sqrt_for_t_acc_11_itm[19]);
        main_stage_0_2 <= 1'b1;
        main_stage_0_3 <= main_stage_0_2;
        main_stage_0_4 <= main_stage_0_3;
        sqrt_for_if_slc_sqrt_for_4_t_acc_psp_23_itm_1 <= sqrt_for_t_acc_1_itm[8];
        sqrt_for_if_slc_sqrt_for_3_t_acc_psp_24_itm_1 <= sqrt_for_t_acc_itm[6];
        sqrt_for_if_slc_sqrt_for_2_t_acc_psp_25_itm_1 <= sqrt_for_2_t_acc_tmp[3];
        sqrt_z_slc_sqrt_z_1_34_itm_1 <= sqrt_acc_psp_sva[7:6];
        sqrt_z_slc_sqrt_z_1_56_itm_1 <= sqrt_acc_psp_sva[32];
        sqrt_for_if_slc_sqrt_for_5_t_acc_psp_14_itm_1 <= sqrt_for_t_acc_2_itm[10];
        sqrt_for_if_slc_sqrt_for_6_t_acc_psp_12_itm_1 <= sqrt_for_t_acc_3_itm[12];
        sqrt_for_if_slc_sqrt_for_7_t_acc_psp_10_itm_1 <= sqrt_for_t_acc_4_itm[14];
        sqrt_z_slc_sqrt_z_1_32_itm_1 <= sqrt_acc_psp_sva[9:8];
        sqrt_z_slc_sqrt_z_1_30_itm_1 <= sqrt_acc_psp_sva[11:10];
        sqrt_z_slc_sqrt_z_1_28_itm_1 <= sqrt_acc_psp_sva[13:12];
        sqrt_z_slc_sqrt_z_1_26_itm_1 <= sqrt_acc_psp_sva[15:14];
        sqrt_z_slc_sqrt_z_1_24_itm_1 <= sqrt_acc_psp_sva[17:16];
        sqrt_z_slc_sqrt_z_1_20_itm_1 <= sqrt_acc_psp_sva[19:18];
        sqrt_for_7_if_slc_sqrt_for_t_3_itm_1 <= sqrt_for_t_acc_4_itm[13];
        sqrt_d_sg5_16_lpi_1_dfm_1 <= sqrt_d_sg5_16_lpi_1_dfm_1_mx0;
        sqrt_for_7_if_slc_sqrt_for_t_8_itm_1 <= sqrt_for_t_acc_4_itm[2:1];
        sqrt_z_slc_sqrt_z_1_18_itm_1 <= sqrt_acc_psp_sva[21:20];
        sqrt_for_7_if_slc_sqrt_for_t_6_itm_1 <= sqrt_for_t_acc_4_itm[4:3];
        sqrt_d_7_lpi_1_dfm_1 <= sqrt_d_7_lpi_1_dfm_1_mx0;
        sqrt_for_7_if_slc_sqrt_for_t_4_itm_1 <= sqrt_for_t_acc_4_itm[6:5];
        sqrt_d_sg1_6_lpi_1_dfm_1 <= sqrt_d_sg1_6_lpi_1_dfm_1_mx0;
        sqrt_for_7_if_slc_sqrt_for_t_2_itm_1 <= sqrt_for_t_acc_4_itm[8:7];
        sqrt_d_sg2_6_lpi_1_dfm_1 <= sqrt_d_sg2_6_lpi_1_dfm_1_mx0;
        sqrt_for_7_if_slc_sqrt_for_t_itm_1 <= sqrt_for_t_acc_4_itm[10:9];
        sqrt_d_sg3_6_lpi_1_dfm_1 <= sqrt_d_sg3_6_lpi_1_dfm_1_mx0;
        sqrt_for_7_if_slc_sqrt_for_t_1_itm_1 <= sqrt_for_t_acc_4_itm[12:11];
        sqrt_d_sg4_6_lpi_1_dfm_1 <= sqrt_d_sg4_6_lpi_1_dfm_1_mx0;
        sqrt_z_slc_sqrt_z_1_2_itm_1 <= sqrt_acc_psp_sva[1:0];
        sqrt_z_slc_sqrt_z_1_38_itm_1 <= sqrt_acc_psp_sva[3:2];
        sqrt_z_slc_sqrt_z_1_36_itm_1 <= sqrt_acc_psp_sva[5:4];
        ACC1_if_acc_52_itm_1 <= nl_ACC1_if_acc_52_itm_1[12:0];
        ACC1_if_acc_51_itm_1 <= nl_ACC1_if_acc_51_itm_1[12:0];
        ACC1_if_2_acc_45_itm_1 <= nl_ACC1_if_2_acc_45_itm_1[12:0];
        ACC1_if_2_acc_44_itm_1 <= nl_ACC1_if_2_acc_44_itm_1[12:0];
        regs_regs_slc_regs_regs_2_7_itm <= reg_regs_regs_0_sva_cse[79:70];
        regs_regs_slc_regs_regs_2_8_itm <= reg_regs_regs_0_sva_cse[69:60];
        regs_regs_slc_regs_regs_2_6_itm <= reg_regs_regs_0_sva_cse[89:80];
        regs_regs_slc_regs_regs_2_4_itm <= reg_regs_regs_0_sva_cse[49:40];
        regs_regs_slc_regs_regs_2_5_itm <= reg_regs_regs_0_sva_cse[39:30];
        regs_regs_slc_regs_regs_2_3_itm <= reg_regs_regs_0_sva_cse[59:50];
        regs_regs_slc_regs_regs_2_1_itm <= reg_regs_regs_0_sva_cse[19:10];
        regs_regs_slc_regs_regs_2_2_itm <= reg_regs_regs_0_sva_cse[9:0];
        regs_regs_slc_regs_regs_2_itm <= reg_regs_regs_0_sva_cse[29:20];
        reg_regs_regs_0_sva_cse <= vin_rsc_mgc_in_wire_d;
      end
    end
  end
  assign nl_ACC1_if_acc_52_itm_1  = ({(conv_s2u_11_12({conv_s2u_16_8(conv_s2s_2_8(conv_s2s_1_2(acc_4_psp_1_sva[11])
      + conv_u2s_1_2(acc_4_psp_sva[11])) * 8'b1010101) , 1'b0 , (signext_2_1(acc_4_psp_sva[11]))})
      + conv_s2u_11_12(ACC1_if_acc_2_psp_sva[11:1])) , (ACC1_if_acc_2_psp_sva[0])})
      + conv_s2s_12_13((~ ACC1_acc_10_psp_1_sva) + ACC1_acc_8_psp_sva);
  assign nl_ACC1_if_acc_51_itm_1  = conv_s2s_12_13({(conv_s2u_10_11(conv_s2s_9_10({conv_s2u_12_6(conv_s2s_2_6(conv_s2s_1_2(acc_4_psp_1_sva[9])
      + conv_u2s_1_2(acc_4_psp_sva[9])) * 6'b10101) , 1'b0 , (signext_2_1(acc_4_psp_sva[5]))})
      + conv_s2s_8_10({1'b1 , ((conv_s2s_6_7(conv_s2s_12_6(conv_s2s_2_6(conv_s2s_1_2(acc_4_psp_1_sva[6])
      + conv_u2s_1_2(acc_4_psp_sva[6])) * 6'b10101)) + conv_u2s_6_7({(acc_4_psp_sva[7])
      , 1'b0 , (acc_4_psp_sva[5]) , 1'b0 , (signext_2_1(acc_4_psp_sva[9]))})) + conv_u2s_6_7({5'b10011
      , (acc_4_psp_sva[2])}))})) + (ACC1_acc_10_psp_sva[11:1])) , (ACC1_acc_10_psp_sva[0])})
      + conv_s2s_12_13({(conv_s2u_9_11(conv_s2s_8_9(conv_s2s_16_8(conv_s2s_2_8(conv_s2s_1_2(acc_4_psp_1_sva[8])
      + conv_u2s_1_2(acc_4_psp_sva[8])) * 8'b1010101)) + conv_u2s_7_9((readslicef_8_7_1((conv_s2u_7_8({(readslicef_7_6_1((conv_s2s_6_7({(readslicef_6_5_1((conv_u2s_4_6({(readslicef_4_3_1((conv_u2u_3_4(signext_3_2({(~
      (acc_4_psp_1_sva[9])) , 1'b1})) + conv_u2u_3_4({(acc_4_psp_sva[3]) , (acc_4_psp_1_sva[3])
      , (acc_imod_4_sva[1])})))) , 1'b1}) + conv_s2s_3_6({(readslicef_3_2_1((({1'b1
      , (~ (acc_4_psp_1_sva[2])) , 1'b1}) + conv_u2s_2_3({(~ (acc_4_psp_1_sva[4]))
      , (acc_5_psp_sva[1])})))) , (~ (readslicef_3_1_2((({1'b1 , (acc_imod_4_sva[0])
      , 1'b1}) + conv_u2s_2_3({(~ (acc_imod_4_sva[1])) , (~ (acc_imod_4_sva[2]))})))))}))))
      , 1'b1}) + conv_u2s_4_7({(readslicef_4_3_1((conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(acc_4_psp_sva[1])
      , 1'b1}) + conv_u2u_2_3({(acc_4_psp_sva[3]) , (acc_4_psp_sva[4])})))) , 1'b1})
      + conv_u2u_3_4(signext_3_2({(~ (acc_4_psp_1_sva[5])) , (~ (acc_imod_4_sva[2]))})))))
      , (~ (acc_5_psp_1_sva[1]))})))) , 1'b1}) + conv_u2u_7_8({(~ (acc_4_psp_1_sva[7]))
      , 1'b1 , (~ (acc_4_psp_1_sva[5:4])) , 1'b1 , (~ (acc_4_psp_1_sva[1])) , (~
      (acc_imod_11_sva[1]))})))) + (conv_u2u_5_7({(conv_u2u_2_3({(acc_4_psp_sva[7])
      , (acc_4_psp_sva[4])}) + conv_u2u_2_3({(~ (acc_4_psp_1_sva[7])) , (~ (acc_4_psp_1_sva[3]))}))
      , (~ (acc_4_psp_1_sva[7])) , (~ (acc_4_psp_1_sva[7]))}) + conv_s2u_5_7(conv_s2s_3_5(readslicef_4_3_1((conv_s2s_3_4({(acc_5_psp_sva[3:2])
      , 1'b1}) + conv_s2s_3_4({(~ (acc_5_psp_1_sva[3:2])) , (readslicef_3_1_2((({1'b1
      , (acc_imod_11_sva[0]) , 1'b1}) + conv_u2s_2_3({(~ (acc_imod_11_sva[1])) ,
      (~ (acc_imod_11_sva[2]))}))))})))) + conv_u2s_3_5(readslicef_4_3_1((conv_u2u_3_4(signext_3_2({(acc_4_psp_sva[7])
      , 1'b1})) + conv_u2u_3_4(signext_3_2({(~ (acc_4_psp_1_sva[11])) , (acc_imod_11_sva[2])})))))))))
      + conv_s2u_10_11(conv_s2u_20_10(conv_s2s_2_10(conv_s2s_1_2(acc_4_psp_1_sva[10])
      + conv_u2s_1_2(acc_4_psp_sva[10])) * 10'b101010101))) , 1'b1});
  assign nl_ACC1_if_2_acc_45_itm_1  = ({(conv_s2u_11_12({conv_s2u_16_8(conv_s2s_2_8(conv_s2s_1_2(acc_8_psp_2_sva[11])
      + conv_u2s_1_2(acc_psp_2_sva[11])) * 8'b10101011) , 1'b0 , (signext_2_1(acc_8_psp_2_sva[11]))})
      + conv_s2u_11_12(ACC1_if_acc_2_psp_sva[11:1])) , (ACC1_if_acc_2_psp_sva[0])})
      + conv_s2s_12_13(ACC1_acc_10_psp_1_sva + (~ ACC1_acc_8_psp_sva));
  assign nl_ACC1_if_2_acc_44_itm_1  = conv_s2s_12_13({(conv_s2u_10_11(conv_s2s_9_10({conv_s2u_12_6(conv_s2s_2_6(conv_s2s_1_2(acc_8_psp_2_sva[9])
      + conv_u2s_1_2(acc_psp_2_sva[9])) * 6'b101011) , (acc_8_psp_2_sva[4]) , (signext_2_1(acc_8_psp_2_sva[7]))})
      + conv_s2s_8_10({1'b1 , ((conv_s2s_6_7(conv_s2s_12_6(conv_s2s_2_6(conv_s2s_1_2(acc_8_psp_2_sva[6])
      + conv_u2s_1_2(acc_psp_2_sva[6])) * 6'b101011)) + conv_u2s_6_7({(~ (acc_psp_2_sva[7]))
      , 1'b1 , (~ (acc_psp_2_sva[5:4])) , 1'b1 , (~ (acc_psp_2_sva[2]))})) + conv_u2s_6_7({5'b10001
      , (~ (acc_psp_2_sva[4]))}))})) + (ACC1_acc_10_psp_sva[11:1])) , (ACC1_acc_10_psp_sva[0])})
      + conv_s2s_12_13({(conv_s2u_9_11(readslicef_10_9_1((conv_s2s_9_10({(readslicef_9_8_1((conv_u2s_8_9({(readslicef_8_7_1((conv_u2u_7_8({(acc_8_psp_2_sva[7])
      , 1'b0 , (acc_8_psp_2_sva[5]) , 1'b0 , (signext_2_1(acc_8_psp_2_sva[5])) ,
      1'b1}) + conv_u2u_6_8({(readslicef_6_5_1((conv_u2u_5_6({(acc_8_psp_2_sva[7])
      , 1'b0 , (signext_2_1(~ (acc_psp_2_sva[5]))) , 1'b1}) + conv_u2u_5_6({(~ (acc_psp_2_sva[7]))
      , (~ (acc_psp_2_sva[3])) , 1'b1 , (~ (acc_1_psp_2_sva[1])) , (acc_imod_14_sva[1])}))))
      , (~ (acc_psp_2_sva[1]))})))) , 1'b1}) + conv_s2s_7_9({(readslicef_7_6_1((conv_s2s_6_7({(readslicef_6_5_1((conv_s2s_4_6({(readslicef_4_3_1((conv_s2s_3_4({(~
      (acc_1_psp_2_sva[3:2])) , 1'b1}) + conv_s2s_3_4({(acc_9_psp_2_sva[3:2]) , (acc_imod_10_sva[2])}))))
      , 1'b1}) + conv_u2s_4_6({(readslicef_4_3_1((conv_u2u_3_4(signext_3_2({(~ (acc_psp_2_sva[7]))
      , 1'b1})) + conv_u2u_3_4(signext_3_2({(~ (acc_psp_2_sva[9])) , (~ (acc_imod_10_sva[1]))})))))
      , (acc_9_psp_2_sva[1])})))) , 1'b1}) + conv_u2s_5_7({(readslicef_5_4_1((conv_u2u_4_5({(readslicef_4_3_1((conv_u2u_3_4(signext_3_2({(~
      (acc_psp_2_sva[11])) , 1'b1})) + conv_u2u_3_4(signext_3_2({(acc_8_psp_2_sva[9])
      , (acc_8_psp_2_sva[4])}))))) , 1'b1}) + conv_u2u_4_5({(readslicef_4_3_1((conv_u2u_3_4({(acc_8_psp_2_sva[3])
      , (acc_8_psp_2_sva[1]) , 1'b1}) + conv_u2u_2_4({(acc_8_psp_2_sva[2]) , (acc_8_psp_2_sva[3])}))))
      , (readslicef_3_1_2((({1'b1 , (acc_imod_10_sva[0]) , 1'b1}) + conv_u2s_2_3({(~
      (acc_imod_10_sva[1])) , (~ (acc_imod_10_sva[2]))}))))})))) , (~ (acc_imod_14_sva[2]))}))))
      , (acc_psp_2_sva[3])})))) , 1'b1}) + conv_s2s_9_10({conv_s2u_16_8(conv_s2s_2_8(conv_s2s_1_2(acc_8_psp_2_sva[8])
      + conv_u2s_1_2(acc_psp_2_sva[8])) * 8'b10101011) , (~ (readslicef_3_1_2((({1'b1
      , (acc_imod_14_sva[0]) , 1'b1}) + conv_u2s_2_3({(~ (acc_imod_14_sva[1])) ,
      (~ (acc_imod_14_sva[2]))})))))})))) + conv_s2u_10_11(conv_s2u_20_10(conv_s2s_2_10(conv_s2s_1_2(acc_8_psp_2_sva[10])
      + conv_u2s_1_2(acc_psp_2_sva[10])) * 10'b1010101011))) , 1'b1});

  function [0:0] MUX_s_1_2_2;
    input [1:0] inputs;
    input [0:0] sel;
    reg [0:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[1:1];
      end
      1'b1 : begin
        result = inputs[0:0];
      end
      default : begin
        result = inputs[1:1];
      end
    endcase
    MUX_s_1_2_2 = result;
  end
  endfunction


  function [1:0] MUX_v_2_2_2;
    input [3:0] inputs;
    input [0:0] sel;
    reg [1:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[3:2];
      end
      1'b1 : begin
        result = inputs[1:0];
      end
      default : begin
        result = inputs[3:2];
      end
    endcase
    MUX_v_2_2_2 = result;
  end
  endfunction


  function [1:0] signext_2_1;
    input [0:0] vector;
  begin
    signext_2_1= {{1{vector[0]}}, vector};
  end
  endfunction


  function [7:0] readslicef_9_8_1;
    input [8:0] vector;
    reg [8:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_9_8_1 = tmp[7:0];
  end
  endfunction


  function [6:0] readslicef_8_7_1;
    input [7:0] vector;
    reg [7:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_8_7_1 = tmp[6:0];
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


  function [5:0] readslicef_7_6_1;
    input [6:0] vector;
    reg [6:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_7_6_1 = tmp[5:0];
  end
  endfunction


  function [3:0] readslicef_5_4_1;
    input [4:0] vector;
    reg [4:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_5_4_1 = tmp[3:0];
  end
  endfunction


  function [2:0] readslicef_4_3_1;
    input [3:0] vector;
    reg [3:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_4_3_1 = tmp[2:0];
  end
  endfunction


  function [1:0] readslicef_3_2_1;
    input [2:0] vector;
    reg [2:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_3_2_1 = tmp[1:0];
  end
  endfunction


  function [8:0] readslicef_10_9_1;
    input [9:0] vector;
    reg [9:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_10_9_1 = tmp[8:0];
  end
  endfunction


  function [2:0] signext_3_2;
    input [1:0] vector;
  begin
    signext_3_2= {{1{vector[1]}}, vector};
  end
  endfunction


  function [29:0] MUX_v_30_2_2;
    input [59:0] inputs;
    input [0:0] sel;
    reg [29:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[59:30];
      end
      1'b1 : begin
        result = inputs[29:0];
      end
      default : begin
        result = inputs[59:30];
      end
    endcase
    MUX_v_30_2_2 = result;
  end
  endfunction


  function [4:0] readslicef_6_5_1;
    input [5:0] vector;
    reg [5:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_6_5_1 = tmp[4:0];
  end
  endfunction


  function  [19:0] conv_s2u_18_20 ;
    input signed [17:0]  vector ;
  begin
    conv_s2u_18_20 = {{2{vector[17]}}, vector};
  end
  endfunction


  function  [19:0] conv_s2u_19_20 ;
    input signed [18:0]  vector ;
  begin
    conv_s2u_19_20 = {vector[18], vector};
  end
  endfunction


  function  [19:0] conv_s2u_17_20 ;
    input signed [16:0]  vector ;
  begin
    conv_s2u_17_20 = {{3{vector[16]}}, vector};
  end
  endfunction


  function  [19:0] conv_s2u_16_20 ;
    input signed [15:0]  vector ;
  begin
    conv_s2u_16_20 = {{4{vector[15]}}, vector};
  end
  endfunction


  function  [19:0] conv_s2u_15_20 ;
    input signed [14:0]  vector ;
  begin
    conv_s2u_15_20 = {{5{vector[14]}}, vector};
  end
  endfunction


  function  [19:0] conv_s2u_14_20 ;
    input signed [13:0]  vector ;
  begin
    conv_s2u_14_20 = {{6{vector[13]}}, vector};
  end
  endfunction


  function  [19:0] conv_s2u_13_20 ;
    input signed [12:0]  vector ;
  begin
    conv_s2u_13_20 = {{7{vector[12]}}, vector};
  end
  endfunction


  function signed [18:0] conv_u2s_18_19 ;
    input [17:0]  vector ;
  begin
    conv_u2s_18_19 = {1'b0, vector};
  end
  endfunction


  function signed [18:0] conv_s2s_12_19 ;
    input signed [11:0]  vector ;
  begin
    conv_s2s_12_19 = {{7{vector[11]}}, vector};
  end
  endfunction


  function signed [16:0] conv_u2s_16_17 ;
    input [15:0]  vector ;
  begin
    conv_u2s_16_17 = {1'b0, vector};
  end
  endfunction


  function signed [16:0] conv_s2s_11_17 ;
    input signed [10:0]  vector ;
  begin
    conv_s2s_11_17 = {{6{vector[10]}}, vector};
  end
  endfunction


  function signed [14:0] conv_u2s_14_15 ;
    input [13:0]  vector ;
  begin
    conv_u2s_14_15 = {1'b0, vector};
  end
  endfunction


  function signed [14:0] conv_s2s_10_15 ;
    input signed [9:0]  vector ;
  begin
    conv_s2s_10_15 = {{5{vector[9]}}, vector};
  end
  endfunction


  function signed [12:0] conv_u2s_12_13 ;
    input [11:0]  vector ;
  begin
    conv_u2s_12_13 = {1'b0, vector};
  end
  endfunction


  function signed [12:0] conv_s2s_9_13 ;
    input signed [8:0]  vector ;
  begin
    conv_s2s_9_13 = {{4{vector[8]}}, vector};
  end
  endfunction


  function signed [10:0] conv_u2s_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2s_10_11 = {1'b0, vector};
  end
  endfunction


  function signed [10:0] conv_s2s_8_11 ;
    input signed [7:0]  vector ;
  begin
    conv_s2s_8_11 = {{3{vector[7]}}, vector};
  end
  endfunction


  function signed [8:0] conv_u2s_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2s_8_9 = {1'b0, vector};
  end
  endfunction


  function signed [8:0] conv_s2s_7_9 ;
    input signed [6:0]  vector ;
  begin
    conv_s2s_7_9 = {{2{vector[6]}}, vector};
  end
  endfunction


  function signed [6:0] conv_u2s_6_7 ;
    input [5:0]  vector ;
  begin
    conv_u2s_6_7 = {1'b0, vector};
  end
  endfunction


  function signed [6:0] conv_s2s_6_7 ;
    input signed [5:0]  vector ;
  begin
    conv_s2s_6_7 = {vector[5], vector};
  end
  endfunction


  function signed [3:0] conv_s2s_3_4 ;
    input signed [2:0]  vector ;
  begin
    conv_s2s_3_4 = {vector[2], vector};
  end
  endfunction


  function  [32:0] conv_u2u_32_33 ;
    input [31:0]  vector ;
  begin
    conv_u2u_32_33 = {1'b0, vector};
  end
  endfunction


  function  [31:0] conv_u2u_64_32 ;
    input [63:0]  vector ;
  begin
    conv_u2u_64_32 = vector[31:0];
  end
  endfunction


  function  [31:0] conv_u2u_16_32 ;
    input [15:0]  vector ;
  begin
    conv_u2u_16_32 = {{16{1'b0}}, vector};
  end
  endfunction


  function  [11:0] conv_u2u_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2u_11_12 = {1'b0, vector};
  end
  endfunction


  function  [10:0] conv_u2u_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_11 = {1'b0, vector};
  end
  endfunction


  function  [11:0] conv_u2u_10_12 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_12 = {{2{1'b0}}, vector};
  end
  endfunction


  function signed [11:0] conv_u2s_10_12 ;
    input [9:0]  vector ;
  begin
    conv_u2s_10_12 = {{2{1'b0}}, vector};
  end
  endfunction


  function  [8:0] conv_u2u_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_9 = {1'b0, vector};
  end
  endfunction


  function  [7:0] conv_u2u_7_8 ;
    input [6:0]  vector ;
  begin
    conv_u2u_7_8 = {1'b0, vector};
  end
  endfunction


  function  [7:0] conv_u2u_6_8 ;
    input [5:0]  vector ;
  begin
    conv_u2u_6_8 = {{2{1'b0}}, vector};
  end
  endfunction


  function signed [2:0] conv_u2s_2_3 ;
    input [1:0]  vector ;
  begin
    conv_u2s_2_3 = {1'b0, vector};
  end
  endfunction


  function signed [11:0] conv_s2s_10_12 ;
    input signed [9:0]  vector ;
  begin
    conv_s2s_10_12 = {{2{vector[9]}}, vector};
  end
  endfunction


  function signed [9:0] conv_u2s_9_10 ;
    input [8:0]  vector ;
  begin
    conv_u2s_9_10 = {1'b0, vector};
  end
  endfunction


  function signed [9:0] conv_s2s_8_10 ;
    input signed [7:0]  vector ;
  begin
    conv_s2s_8_10 = {{2{vector[7]}}, vector};
  end
  endfunction


  function signed [6:0] conv_s2s_5_7 ;
    input signed [4:0]  vector ;
  begin
    conv_s2s_5_7 = {{2{vector[4]}}, vector};
  end
  endfunction


  function signed [4:0] conv_s2s_4_5 ;
    input signed [3:0]  vector ;
  begin
    conv_s2s_4_5 = {vector[3], vector};
  end
  endfunction


  function signed [3:0] conv_u2s_3_4 ;
    input [2:0]  vector ;
  begin
    conv_u2s_3_4 = {1'b0, vector};
  end
  endfunction


  function signed [4:0] conv_s2s_3_5 ;
    input signed [2:0]  vector ;
  begin
    conv_s2s_3_5 = {{2{vector[2]}}, vector};
  end
  endfunction


  function signed [6:0] conv_u2s_5_7 ;
    input [4:0]  vector ;
  begin
    conv_u2s_5_7 = {{2{1'b0}}, vector};
  end
  endfunction


  function  [4:0] conv_u2u_4_5 ;
    input [3:0]  vector ;
  begin
    conv_u2u_4_5 = {1'b0, vector};
  end
  endfunction


  function  [3:0] conv_u2u_3_4 ;
    input [2:0]  vector ;
  begin
    conv_u2u_3_4 = {1'b0, vector};
  end
  endfunction


  function  [2:0] conv_u2u_2_3 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_3 = {1'b0, vector};
  end
  endfunction


  function  [4:0] conv_u2u_3_5 ;
    input [2:0]  vector ;
  begin
    conv_u2u_3_5 = {{2{1'b0}}, vector};
  end
  endfunction


  function signed [2:0] conv_s2s_2_3 ;
    input signed [1:0]  vector ;
  begin
    conv_s2s_2_3 = {vector[1], vector};
  end
  endfunction


  function signed [1:0] conv_s2s_1_2 ;
    input signed [0:0]  vector ;
  begin
    conv_s2s_1_2 = {vector[0], vector};
  end
  endfunction


  function signed [1:0] conv_u2s_1_2 ;
    input [0:0]  vector ;
  begin
    conv_u2s_1_2 = {1'b0, vector};
  end
  endfunction


  function signed [11:0] conv_s2s_11_12 ;
    input signed [10:0]  vector ;
  begin
    conv_s2s_11_12 = {vector[10], vector};
  end
  endfunction


  function signed [9:0] conv_s2s_9_10 ;
    input signed [8:0]  vector ;
  begin
    conv_s2s_9_10 = {vector[8], vector};
  end
  endfunction


  function signed [7:0] conv_u2s_7_8 ;
    input [6:0]  vector ;
  begin
    conv_u2s_7_8 = {1'b0, vector};
  end
  endfunction


  function signed [7:0] conv_s2s_7_8 ;
    input signed [6:0]  vector ;
  begin
    conv_s2s_7_8 = {vector[6], vector};
  end
  endfunction


  function signed [4:0] conv_u2s_3_5 ;
    input [2:0]  vector ;
  begin
    conv_u2s_3_5 = {{2{1'b0}}, vector};
  end
  endfunction


  function signed [8:0] conv_u2s_7_9 ;
    input [6:0]  vector ;
  begin
    conv_u2s_7_9 = {{2{1'b0}}, vector};
  end
  endfunction


  function signed [13:0] conv_s2s_13_14 ;
    input signed [12:0]  vector ;
  begin
    conv_s2s_13_14 = {vector[12], vector};
  end
  endfunction


  function  [11:0] conv_s2u_11_12 ;
    input signed [10:0]  vector ;
  begin
    conv_s2u_11_12 = {vector[10], vector};
  end
  endfunction


  function  [7:0] conv_s2u_16_8 ;
    input signed [15:0]  vector ;
  begin
    conv_s2u_16_8 = vector[7:0];
  end
  endfunction


  function signed [7:0] conv_s2s_2_8 ;
    input signed [1:0]  vector ;
  begin
    conv_s2s_2_8 = {{6{vector[1]}}, vector};
  end
  endfunction


  function signed [12:0] conv_s2s_12_13 ;
    input signed [11:0]  vector ;
  begin
    conv_s2s_12_13 = {vector[11], vector};
  end
  endfunction


  function  [10:0] conv_s2u_10_11 ;
    input signed [9:0]  vector ;
  begin
    conv_s2u_10_11 = {vector[9], vector};
  end
  endfunction


  function  [5:0] conv_s2u_12_6 ;
    input signed [11:0]  vector ;
  begin
    conv_s2u_12_6 = vector[5:0];
  end
  endfunction


  function signed [5:0] conv_s2s_2_6 ;
    input signed [1:0]  vector ;
  begin
    conv_s2s_2_6 = {{4{vector[1]}}, vector};
  end
  endfunction


  function signed [5:0] conv_s2s_12_6 ;
    input signed [11:0]  vector ;
  begin
    conv_s2s_12_6 = vector[5:0];
  end
  endfunction


  function  [10:0] conv_s2u_9_11 ;
    input signed [8:0]  vector ;
  begin
    conv_s2u_9_11 = {{2{vector[8]}}, vector};
  end
  endfunction


  function signed [8:0] conv_s2s_8_9 ;
    input signed [7:0]  vector ;
  begin
    conv_s2s_8_9 = {vector[7], vector};
  end
  endfunction


  function signed [7:0] conv_s2s_16_8 ;
    input signed [15:0]  vector ;
  begin
    conv_s2s_16_8 = vector[7:0];
  end
  endfunction


  function  [7:0] conv_s2u_7_8 ;
    input signed [6:0]  vector ;
  begin
    conv_s2u_7_8 = {vector[6], vector};
  end
  endfunction


  function signed [5:0] conv_u2s_4_6 ;
    input [3:0]  vector ;
  begin
    conv_u2s_4_6 = {{2{1'b0}}, vector};
  end
  endfunction


  function signed [5:0] conv_s2s_3_6 ;
    input signed [2:0]  vector ;
  begin
    conv_s2s_3_6 = {{3{vector[2]}}, vector};
  end
  endfunction


  function signed [6:0] conv_u2s_4_7 ;
    input [3:0]  vector ;
  begin
    conv_u2s_4_7 = {{3{1'b0}}, vector};
  end
  endfunction


  function  [6:0] conv_u2u_5_7 ;
    input [4:0]  vector ;
  begin
    conv_u2u_5_7 = {{2{1'b0}}, vector};
  end
  endfunction


  function  [6:0] conv_s2u_5_7 ;
    input signed [4:0]  vector ;
  begin
    conv_s2u_5_7 = {{2{vector[4]}}, vector};
  end
  endfunction


  function  [9:0] conv_s2u_20_10 ;
    input signed [19:0]  vector ;
  begin
    conv_s2u_20_10 = vector[9:0];
  end
  endfunction


  function signed [9:0] conv_s2s_2_10 ;
    input signed [1:0]  vector ;
  begin
    conv_s2s_2_10 = {{8{vector[1]}}, vector};
  end
  endfunction


  function  [5:0] conv_u2u_5_6 ;
    input [4:0]  vector ;
  begin
    conv_u2u_5_6 = {1'b0, vector};
  end
  endfunction


  function signed [5:0] conv_s2s_4_6 ;
    input signed [3:0]  vector ;
  begin
    conv_s2s_4_6 = {{2{vector[3]}}, vector};
  end
  endfunction


  function  [3:0] conv_u2u_2_4 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_4 = {{2{1'b0}}, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    mean_vga
//  Generated from file(s):
//    3) $PROJECT_HOME/../sobel_filter_source/blur_sob.c
// ------------------------------------------------------------------


module mean_vga (
  vin_rsc_z, vout_rsc_z, clk, en, arst_n
);
  input [89:0] vin_rsc_z;
  output [29:0] vout_rsc_z;
  input clk;
  input en;
  input arst_n;


  // Interconnect Declarations
  wire [89:0] vin_rsc_mgc_in_wire_d;
  wire [29:0] vout_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations for Component Instantiations 
  mgc_in_wire #(.rscid(1),
  .width(90)) vin_rsc_mgc_in_wire (
      .d(vin_rsc_mgc_in_wire_d),
      .z(vin_rsc_z)
    );
  mgc_out_stdreg #(.rscid(2),
  .width(30)) vout_rsc_mgc_out_stdreg (
      .d(vout_rsc_mgc_out_stdreg_d),
      .z(vout_rsc_z)
    );
  mean_vga_core mean_vga_core_inst (
      .clk(clk),
      .en(en),
      .arst_n(arst_n),
      .vin_rsc_mgc_in_wire_d(vin_rsc_mgc_in_wire_d),
      .vout_rsc_mgc_out_stdreg_d(vout_rsc_mgc_out_stdreg_d)
    );
endmodule



