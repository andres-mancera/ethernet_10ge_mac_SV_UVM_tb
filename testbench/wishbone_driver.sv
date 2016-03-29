`ifndef WISHBONE_DRIVER__SV
`define WISHBONE_DRIVER__SV


class wishbone_driver extends uvm_driver #(wishbone_item);

  virtual xge_mac_interface     drv_vi;

  `uvm_component_utils( wishbone_driver )

  function new(input string name="wishbone_driver", input uvm_component parent);
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
    // Initial assignment for wishbone interface signals
    drv_vi.drv_cb.wb_adr_i  <= $urandom_range(255,0);
    drv_vi.drv_cb.wb_cyc_i  <= 1'b0;
    drv_vi.drv_cb.wb_stb_i  <= 1'b0;
    drv_vi.drv_cb.wb_dat_i  <= $urandom;
    drv_vi.drv_cb.wb_we_i   <= 1'b0;

    forever begin
      seq_item_port.get_next_item(req);
      drv_vi.drv_cb.wb_adr_i  <= req.wr_addr;
      drv_vi.drv_cb.wb_cyc_i  <= 1'b1;
      drv_vi.drv_cb.wb_stb_i  <= 1'b1;
      drv_vi.drv_cb.wb_dat_i  <= req.wr_data;
      drv_vi.drv_cb.wb_we_i   <= 1'b1;
      repeat (2)
        @(drv_vi.drv_cb);
      drv_vi.drv_cb.wb_adr_i  <= $urandom_range(255,0);
      drv_vi.drv_cb.wb_cyc_i  <= 1'b0;
      drv_vi.drv_cb.wb_stb_i  <= 1'b0;
      drv_vi.drv_cb.wb_dat_i  <= $urandom;
      drv_vi.drv_cb.wb_we_i   <= 1'b0;
      repeat (20)
        @(drv_vi.drv_cb);
      seq_item_port.item_done();
    end
  endtask : run_phase

endclass : wishbone_driver

`endif  // WISHBONE_DRIVER__SV
