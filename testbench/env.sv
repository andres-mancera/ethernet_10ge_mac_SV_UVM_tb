//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : env.sv                                              //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
`ifndef ENV__SV
`define ENV__SV

`include "reset_agent.sv"
`include "wishbone_agent.sv"
`include "packet_tx_agent.sv"
`include "packet_rx_agent.sv"
`include "xgmii_tx_agent.sv"
`include "xgmii_rx_agent.sv"
`include "scoreboard.sv"


class env extends uvm_env;

  reset_agent       rst_agent;
  wishbone_agent    wshbn_agent;
  packet_tx_agent   pkt_tx_agent;
  packet_rx_agent   pkt_rx_agent;
  xgmii_tx_agent    xgmii_tx_agt;
  xgmii_rx_agent    xgmii_rx_agt;
  scoreboard        scbd;

  `uvm_component_utils(env)

  function new(input string name, input uvm_component parent);
    super.new(name, parent);
  endfunction : new


  virtual function void build_phase( input uvm_phase phase );
    super.build_phase( phase );
    rst_agent      = reset_agent::type_id::create( "rst_agent", this );
    wshbn_agent    = wishbone_agent::type_id::create( "wshbn_agent", this );
    pkt_tx_agent   = packet_tx_agent::type_id::create( "pkt_tx_agent", this );
    pkt_rx_agent   = packet_rx_agent::type_id::create( "pkt_rx_agent", this );
    xgmii_tx_agt   = xgmii_tx_agent::type_id::create( "xgmii_tx_agt", this );
    xgmii_rx_agt   = xgmii_rx_agent::type_id::create( "xgmii_rx_agt", this );
    scbd           = scoreboard::type_id::create( "scbd", this );
  endfunction : build_phase


  virtual function void connect_phase ( input uvm_phase phase );
    super.connect_phase( phase );
    pkt_tx_agent.ap_tx_agent.connect( scbd.from_pkt_tx_agent );
    pkt_rx_agent.ap_rx_agent.connect( scbd.from_pkt_rx_agent );
    wshbn_agent.ap_agent.connect( scbd.from_wshbn_agent );
  endfunction : connect_phase

endclass : env

`endif  //ENV__SV
