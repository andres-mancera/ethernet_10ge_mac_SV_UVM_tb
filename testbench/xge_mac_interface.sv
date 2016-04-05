//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : xge_mac_interface.sv                                //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
`ifndef XGE_MAC_INTERFACE__SV
`define XGE_MAC_INTERFACE__SV


interface xge_mac_interface( input bit  clk_156m25,
                             input bit  clk_xgmii_rx,
                             input bit  clk_xgmii_tx,
                             input bit  wb_clk_i,
                             ref logic  reset_156m25_n,
                             ref logic  reset_xgmii_rx_n,
                             ref logic  reset_xgmii_tx_n,
                             ref logic  wb_rst_i        );

  logic         pkt_rx_ren, pkt_tx_eop, pkt_tx_sop, pkt_tx_val;
  logic         wb_cyc_i, wb_stb_i, wb_we_i, wb_ack_o, wb_int_o;
  logic         pkt_rx_avail, pkt_rx_eop, pkt_rx_err, pkt_rx_sop, pkt_rx_val, pkt_tx_full;
  logic [63:0]  pkt_tx_data, xgmii_rxd, pkt_rx_data, xgmii_txd;
  logic [31:0]  wb_dat_i, wb_dat_o;
  logic [7:0]   wb_adr_i, xgmii_rxc, xgmii_txc;
  logic [2:0]   pkt_tx_mod, pkt_rx_mod;

  parameter INPUT_SKEW  = 1;
  parameter OUTPUT_SKEW = 1;

  clocking drv_cb @(posedge clk_156m25);
    default input   #INPUT_SKEW;
    default output  #OUTPUT_SKEW;
    input   pkt_rx_avail;
    input   pkt_rx_data;
    input   pkt_rx_eop;
    input   pkt_rx_err;
    input   pkt_rx_mod;
    input   pkt_rx_sop;
    input   pkt_rx_val;
    input   pkt_tx_full;
    input   wb_ack_o;
    input   wb_dat_o;
    input   wb_int_o;
    input   xgmii_txc;
    input   xgmii_txd;
    output  pkt_rx_ren;
    output  pkt_tx_data;
    output  pkt_tx_eop;
    output  pkt_tx_mod;
    output  pkt_tx_sop;
    output  pkt_tx_val;
    output  wb_adr_i;
    output  wb_cyc_i;
    output  wb_dat_i;
    output  wb_stb_i;
    output  wb_we_i;
    output  xgmii_rxc;
    output  xgmii_rxd;
  endclocking // drv_cb
  modport driver_port( clocking drv_cb );

  clocking mon_cb @(posedge clk_156m25);
    default input   #INPUT_SKEW;
    default output  #OUTPUT_SKEW;
    input   pkt_rx_avail;
    input   pkt_rx_data;
    input   pkt_rx_eop;
    input   pkt_rx_err;
    input   pkt_rx_mod;
    input   pkt_rx_sop;
    input   pkt_rx_val;
    input   pkt_tx_full;
    input   wb_ack_o;
    input   wb_dat_o;
    input   wb_int_o;
    input   xgmii_txc;
    input   xgmii_txd;
    output  pkt_rx_ren;
    input   pkt_tx_data;
    input   pkt_tx_eop;
    input   pkt_tx_mod;
    input   pkt_tx_sop;
    input   pkt_tx_val;
    input   wb_adr_i;
    input   wb_cyc_i;
    input   wb_dat_i;
    input   wb_stb_i;
    input   wb_we_i;
    input   xgmii_rxc;
    input   xgmii_rxd;
  endclocking //mon_cb
  modport monitor_port( clocking mon_cb );

  modport dut_port  (
                        output  pkt_rx_avail,
                        output  pkt_rx_data,
                        output  pkt_rx_eop,
                        output  pkt_rx_err,
                        output  pkt_rx_mod,
                        output  pkt_rx_sop,
                        output  pkt_rx_val,
                        output  pkt_tx_full,
                        output  wb_ack_o,
                        output  wb_dat_o,
                        output  wb_int_o,
                        output  xgmii_txc,
                        output  xgmii_txd,
                        input   pkt_rx_ren,
                        input   pkt_tx_data,
                        input   pkt_tx_eop,
                        input   pkt_tx_mod,
                        input   pkt_tx_sop,
                        input   pkt_tx_val,
                        input   wb_adr_i,
                        input   wb_cyc_i,
                        input   wb_dat_i,
                        input   wb_stb_i,
                        input   wb_we_i,
                        input   xgmii_rxc,
                        input   xgmii_rxd
                    );

  // Configure the DUT in loopback mode
  // input 'xgmii_rxc' connected to output 'xgmii_txc'
  // input 'xgmii_rxd' connected to output 'xgmii_txd'
  initial begin
    assign  xgmii_rxc = xgmii_txc;
    assign  xgmii_rxd = xgmii_txd;
  end

endinterface : xge_mac_interface

`endif  // XGE_MAC_INTERFACE__SV
