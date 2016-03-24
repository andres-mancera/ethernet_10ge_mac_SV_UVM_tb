`ifndef TESTCLASS__SV
`define TESTCLASS__SV


class test_base extends uvm_test;

  `uvm_component_utils( test_base );

  function new(input string name, input uvm_component parent);
    super.new(name, parent);
  endfunction : new


  virtual function void build_phase(input uvm_phase phase);
    super.build_phase(phase);

    // ==== Assign virtual interface ================================
    // FIXME
  endfunction : build_phase



  virtual function void end_of_elaboration_phase(input uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    `uvm_info(get_name(), "Printing Topology from end_of_elaboration phase", UVM_MEDIUM)
    uvm_top.print_topology();
  endfunction : end_of_elaboration_phase


  virtual function void start_of_simulation_phase(input uvm_phase phase);
    super.start_of_simulation_phase(phase);
    `uvm_info(get_name(), "Printing factory from start_of_simulation phase", UVM_MEDIUM);
    factory.print();
  endfunction  : start_of_simulation_phase


  virtual task run_phase(input uvm_phase phase);
    `uvm_info(get_name(), "Inside run_phase()", UVM_HIGH);
  endtask : run_phase


//  virtual task main_phase( input uvm_phase phase);
//    uvm_objection   objection;
//    super.main_phase(phase);
//    objection = phase.get_objection();
//    objection.set_drain_time(this, 50us);   //FIXME: Fine-tune this number
//  endtask : main_phase

endclass : test_base

`endif // TESTCLASS__SV

