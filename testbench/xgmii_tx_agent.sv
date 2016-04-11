//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : xgmii_tx_agent.sv                                   //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
`ifndef XGMII_TX_AGENT__SV
`define XGMII_TX_AGENT__SV

`include "xgmii_tx_monitor.sv"


class xgmii_tx_agent extends uvm_agent;

  xgmii_tx_monitor                  xgmii_tx_mon;
  uvm_analysis_port #(xgmii_packet) ap_agent;

  `uvm_component_utils( xgmii_tx_agent )

  function new( input string name="xgmii_tx_agent", input uvm_component parent );
    super.new( name, parent );
  endfunction : new


  virtual function void build_phase( input uvm_phase phase );
    super.build_phase( phase );
    xgmii_tx_mon= xgmii_tx_monitor::type_id::create( "xgmii_tx_mon", this );
    ap_agent    = new ( "ap_agent", this );
  endfunction : build_phase


  virtual function void connect_phase( input uvm_phase phase );
    super.connect_phase( phase );
    this.ap_agent = xgmii_tx_mon.ap_mon;
  endfunction : connect_phase

endclass : xgmii_tx_agent

`endif  // XGMII_TX_AGENT__SV
