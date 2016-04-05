//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : reset_agent.sv                                      //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
`ifndef RESET_AGENT__SV
`define RESET_AGENT__SV

`include "reset_driver.sv"
typedef uvm_sequencer #(reset_item) reset_sequencer;


class reset_agent extends uvm_agent;

  reset_sequencer       rst_seqr;
  reset_driver          rst_drv;

  `uvm_component_utils( reset_agent )

  function new( input string name="reset_agent", input uvm_component parent );
    super.new( name, parent );
  endfunction : new


  virtual function void build_phase( input uvm_phase phase );
    super.build_phase( phase );
    rst_seqr    = reset_sequencer::type_id::create( "rst_seqr", this );
    rst_drv     = reset_driver::type_id::create( "rst_drv", this );
  endfunction : build_phase


  virtual function void connect_phase( input uvm_phase phase );
    super.connect_phase( phase );
    rst_drv.seq_item_port.connect( rst_seqr.seq_item_export );
  endfunction : connect_phase

endclass : reset_agent

`endif  // RESET_AGENT__SV
