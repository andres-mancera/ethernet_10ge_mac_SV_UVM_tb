//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : xgmii_rx_agent.sv                                   //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
`ifndef XGMII_RX_AGENT__SV
`define XGMII_RX_AGENT__SV

`include "xgmii_rx_monitor.sv"


class xgmii_rx_agent extends uvm_agent;

  xgmii_rx_monitor                  xgmii_rx_mon;
  uvm_analysis_port #(xgmii_packet) ap_agent;

  `uvm_component_utils( xgmii_rx_agent )

  function new( input string name="xgmii_rx_agent", input uvm_component parent );
    super.new( name, parent );
  endfunction : new


  virtual function void build_phase( input uvm_phase phase );
    super.build_phase( phase );
    xgmii_rx_mon= xgmii_rx_monitor::type_id::create( "xgmii_rx_mon", this );
    ap_agent    = new ( "ap_agent", this );
  endfunction : build_phase


  virtual function void connect_phase( input uvm_phase phase );
    super.connect_phase( phase );
    this.ap_agent = xgmii_rx_mon.ap_mon;
  endfunction : connect_phase

endclass : xgmii_rx_agent

`endif  // XGMII_RX_AGENT__SV
