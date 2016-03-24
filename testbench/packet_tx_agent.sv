`ifndef PACKET_TX_AGENT__SV
`define PACKET_TX_AGENT__SV

`include "packet_tx_driver.sv"
typedef uvm_sequencer #(packet) packet_tx_sequencer;


class packet_tx_agent extends uvm_agent;

  packet_tx_sequencer   pkt_tx_seqr;
  packet_tx_driver      pkt_tx_drv;

  `uvm_component_utils( packet_tx_agent )

  function new( input string name="packet_tx_agent", input uvm_component parent );
    super.new( name, parent );
  endfunction : new


  virtual function void build_phase( input uvm_phase phase );
    super.build_phase( phase );
    pkt_tx_seqr = packet_tx_sequencer::type_id::create( "pkt_tx_seqr", this );
    pkt_tx_drv  = packet_tx_driver::type_id::create( "pkt_tx_drv", this );
  endfunction : build_phase


  virtual function void connect_phase( input uvm_phase phase );
    super.connect_phase( phase );
    pkt_tx_drv.seq_item_port.connect( pkt_tx_seqr.seq_item_export );
  endfunction : connect_phase

endclass : packet_tx_agent

`endif  // PACKET_TX_AGENT__SV
