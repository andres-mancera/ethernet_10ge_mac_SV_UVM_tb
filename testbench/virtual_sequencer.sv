//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : virtual_sequencer.sv                                //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
`ifndef VIRTUAL_SEQUENCER__SV
`define VIRTUAL_SEQUENCER__SV


class virtual_sequencer extends uvm_sequencer;

  `uvm_component_utils(virtual_sequencer)

  reset_sequencer       seqr_rst;
  wishbone_sequencer    seqr_wshbn;
  packet_tx_sequencer   seqr_tx_pkt;

  function new(input string name="virtual_sequencer", input uvm_component parent);
    super.new(name, parent);
  endfunction : new

endclass : virtual_sequencer

`endif  // VIRTUAL_SEQUENCER__SV
