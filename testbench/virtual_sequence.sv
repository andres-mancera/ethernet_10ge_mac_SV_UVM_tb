//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : virtual_sequence.sv                                 //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
`ifndef VIRTUAL_SEQUENCE__SV
`define VIRTUAL_SEQUENCE__SV


class virtual_sequence extends uvm_sequence;

  `uvm_object_utils(virtual_sequence)
  `uvm_declare_p_sequencer(virtual_sequencer)

  reset_sequence            seq_rst;
  wishbone_init_sequence    seq_init_wshbn;
  wishbone_eot_sequence     seq_eot_wshbn;
  packet_sequence           seq_pkt;

  function new(input string name="virtual_sequence");
    super.new(name);
    `uvm_info( get_name(), $sformatf("Hierarchy: %m"), UVM_HIGH )
  endfunction : new


  virtual task body();
    `uvm_do_on( seq_pkt, p_sequencer.seqr_tx_pkt );
    #1000000;
    `uvm_do_on( seq_eot_wshbn, p_sequencer.seqr_wshbn );
  endtask : body


  virtual task pre_start();
    super.pre_start();
    if ( (starting_phase!=null) && (get_parent_sequence()==null) )
      starting_phase.raise_objection( this );
  endtask : pre_start


  virtual task post_start();
    super.post_start();
    if ( (starting_phase!=null) && (get_parent_sequence()==null) )
      starting_phase.drop_objection( this );
  endtask : post_start

endclass : virtual_sequence

`endif  // VIRTUAL_SEQUENCE__SV
