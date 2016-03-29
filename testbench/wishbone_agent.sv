`ifndef WISHBONE_AGENT__SV
`define WISHBONE_AGENT__SV

`include "wishbone_driver.sv"
typedef uvm_sequencer #(wishbone_item) wishbone_sequencer;


class wishbone_agent extends uvm_agent;

  wishbone_sequencer    wshbn_seqr;
  wishbone_driver       wshbn_drv;

  `uvm_component_utils( wishbone_agent )

  function new( input string name="wishbone_agent", input uvm_component parent );
    super.new( name, parent );
  endfunction : new


  virtual function void build_phase( input uvm_phase phase );
    super.build_phase( phase );
    wshbn_seqr  = wishbone_sequencer::type_id::create( "wshbn_seqr", this );
    wshbn_drv   = wishbone_driver::type_id::create( "wshbn_drv", this );
  endfunction : build_phase


  virtual function void connect_phase( input uvm_phase phase );
    super.connect_phase( phase );
    wshbn_drv.seq_item_port.connect( wshbn_seqr.seq_item_export );
  endfunction : connect_phase

endclass : wishbone_agent

`endif  // WISHBONE_AGENT__SV
