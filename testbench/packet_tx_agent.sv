//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : packet_tx_agent.sv                                  //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
`ifndef PACKET_TX_AGENT__SV
`define PACKET_TX_AGENT__SV

`include "packet_tx_monitor.sv"
`include "packet_tx_driver.sv"
typedef uvm_sequencer #(packet) packet_tx_sequencer;


class packet_tx_agent extends uvm_agent;

  packet_tx_sequencer           pkt_tx_seqr;
  packet_tx_driver              pkt_tx_drv;
  packet_tx_monitor             pkt_tx_mon;
  uvm_analysis_port #(packet)   ap_tx_agent;

  `uvm_component_utils( packet_tx_agent )

  function new( input string name="packet_tx_agent", input uvm_component parent );
    super.new( name, parent );
  endfunction : new


  virtual function void build_phase( input uvm_phase phase );
    super.build_phase( phase );
    pkt_tx_seqr = packet_tx_sequencer::type_id::create( "pkt_tx_seqr", this );
    pkt_tx_drv  = packet_tx_driver::type_id::create( "pkt_tx_drv", this );
    pkt_tx_mon  = packet_tx_monitor::type_id::create( "pkt_tx_mon", this );
    ap_tx_agent = new ( "ap_tx_agent", this );
  endfunction : build_phase


  virtual function void connect_phase( input uvm_phase phase );
    super.connect_phase( phase );
    pkt_tx_drv.seq_item_port.connect( pkt_tx_seqr.seq_item_export );
    this.ap_tx_agent = pkt_tx_mon.ap_tx_mon;
  endfunction : connect_phase

endclass : packet_tx_agent

`endif  // PACKET_TX_AGENT__SV
