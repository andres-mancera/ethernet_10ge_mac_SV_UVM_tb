`ifndef PACKET_TX_DRIVER__SV
`define PACKET_TX_DRIVER__SV


class packet_tx_driver extends uvm_driver #(packet);

  `uvm_component_utils( packet_tx_driver )

  function new(input string name="packet_tx_driver", input uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual task run_phase(input uvm_phase phase);
    `uvm_info( get_name(), $sformatf("HIERARCHY: %m"), UVM_HIGH);
    forever begin
      seq_item_port.get_next_item(req);
      `uvm_info( get_name(), $psprintf("Packet: \n%0s", req.sprint()), UVM_HIGH)
      seq_item_port.item_done();
    end
  endtask : run_phase

endclass : packet_tx_driver

`endif  // PACKET_TX_DRIVER__SV
