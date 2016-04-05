//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : reset_driver.sv                                     //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
`ifndef RESET_DRIVER__SV
`define RESET_DRIVER__SV


class reset_driver extends uvm_driver #(reset_item);

  virtual xge_mac_interface     drv_vi;

  `uvm_component_utils( reset_driver )

  function new(input string name="reset_driver", input uvm_component parent);
    super.new(name, parent);
  endfunction : new


  virtual function void build_phase(input uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(virtual xge_mac_interface)::get(this, "", "drv_vi", drv_vi);
    if ( drv_vi==null )
      `uvm_fatal(get_name(), "Virtual Interface for driver not set!");
  endfunction : build_phase


  virtual task run_phase(input uvm_phase phase);
    `uvm_info( get_name(), $sformatf("HIERARCHY: %m"), UVM_HIGH);
    forever begin
      seq_item_port.get_next_item(req);
      `uvm_info( get_name(), $psprintf("Reset Transaction: \n%0s", req.sprint()), UVM_HIGH)
      @(drv_vi.drv_cb);
      drv_vi.reset_156m25_n   <= req.reset_n;
      drv_vi.reset_xgmii_rx_n <= req.reset_n;
      drv_vi.reset_xgmii_tx_n <= req.reset_n;
      drv_vi.wb_rst_i         <= !req.reset_n;
      repeat (req.cycles)
        @(drv_vi.drv_cb);
      seq_item_port.item_done();
    end
  endtask : run_phase

endclass : reset_driver

`endif  // RESET_DRIVER__SV
