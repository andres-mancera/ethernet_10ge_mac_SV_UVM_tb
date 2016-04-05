//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : packet_rx_agent.sv                                  //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
`ifndef PACKET_RX_AGENT__SV
`define PACKET_RX_AGENT__SV

`include "packet_rx_monitor.sv"


class packet_rx_agent extends uvm_agent;

  packet_rx_monitor             pkt_rx_mon;
  uvm_analysis_port #(packet)   ap_rx_agent;

  `uvm_component_utils( packet_rx_agent )

  function new( input string name="packet_rx_agent", input uvm_component parent );
    super.new( name, parent );
  endfunction : new


  virtual function void build_phase( input uvm_phase phase );
    super.build_phase( phase );
    pkt_rx_mon  = packet_rx_monitor::type_id::create( "pkt_rx_mon", this );    
    ap_rx_agent = new ( "ap_rx_agent", this );
  endfunction : build_phase


  virtual function void connect_phase( input uvm_phase phase );
    super.connect_phase( phase );
    this.ap_rx_agent = pkt_rx_mon.ap_rx_mon;
  endfunction : connect_phase

endclass : packet_rx_agent

`endif  // PACKET_RX_AGENT__SV
