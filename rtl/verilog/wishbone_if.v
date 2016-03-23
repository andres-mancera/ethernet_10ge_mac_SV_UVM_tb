//////////////////////////////////////////////////////////////////////
////                                                              ////
////  File name "wishbone.v"                                      ////
////                                                              ////
////  This file is part of the "10GE MAC" project                 ////
////  http://www.opencores.org/cores/xge_mac/                     ////
////                                                              ////
////  Author(s):                                                  ////
////      - A. Tanguay (antanguay@opencores.org)                  ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2008 AUTHORS. All rights reserved.             ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////


`include "defines.v"

module wishbone_if(/*AUTOARG*/
  // Outputs
  wb_dat_o, wb_ack_o, wb_int_o, ctrl_tx_enable,
  // Inputs
  wb_clk_i, wb_rst_i, wb_adr_i, wb_dat_i, wb_we_i, wb_stb_i, wb_cyc_i,
  status_crc_error, status_fragment_error, status_txdfifo_ovflow,
  status_txdfifo_udflow, status_rxdfifo_ovflow, status_rxdfifo_udflow,
  status_pause_frame_rx, status_local_fault, status_remote_fault
  );


input         wb_clk_i;
input         wb_rst_i;

input  [7:0]  wb_adr_i;
input  [31:0] wb_dat_i;
input         wb_we_i;
input         wb_stb_i;
input         wb_cyc_i;

output [31:0] wb_dat_o;
output        wb_ack_o;
output        wb_int_o;

input         status_crc_error;
input         status_fragment_error;
   
input         status_txdfifo_ovflow;

input         status_txdfifo_udflow;

input         status_rxdfifo_ovflow;

input         status_rxdfifo_udflow;

input         status_pause_frame_rx;

input         status_local_fault;
input         status_remote_fault;

output        ctrl_tx_enable;


/*AUTOREG*/
// Beginning of automatic regs (for this module's undeclared outputs)
reg [31:0]              wb_dat_o;
reg                     wb_int_o;
// End of automatics

reg  [0:0]              cpureg_config0;
reg  [8:0]              cpureg_int_pending;
reg  [8:0]              cpureg_int_mask;

reg                     cpuack;

reg                     status_remote_fault_d1;
reg                     status_local_fault_d1;


/*AUTOWIRE*/

wire [8:0]             int_sources;


//---
// Source of interrupts, some are edge sensitive, others
// expect a pulse signal.

assign int_sources = {
                      status_fragment_error,
                      status_crc_error,

                      status_pause_frame_rx,

                      status_remote_fault ^ status_remote_fault_d1,
                      status_local_fault ^ status_local_fault_d1,

                      status_rxdfifo_udflow,
                      status_rxdfifo_ovflow,
                      status_txdfifo_udflow,
                      status_txdfifo_ovflow
                      };

//---
// Config Register 0

assign ctrl_tx_enable = cpureg_config0[0];



//---
// Wishbone signals

assign wb_ack_o = cpuack && wb_stb_i;

always @(posedge wb_clk_i or posedge wb_rst_i) begin

    if (wb_rst_i == 1'b1) begin

        cpureg_config0 <= 1'h1;
        cpureg_int_pending <= 9'b0;
        cpureg_int_mask <= 9'b0;

        wb_dat_o <= 32'b0;
        wb_int_o <= 1'b0;

        cpuack <= 1'b0;

        status_remote_fault_d1 <= status_remote_fault;
        status_local_fault_d1 <= status_local_fault;

    end
    else begin

        wb_int_o <= |(cpureg_int_pending & cpureg_int_mask);

        cpureg_int_pending <= cpureg_int_pending | int_sources;

        cpuack <= wb_cyc_i && wb_stb_i;

        status_remote_fault_d1 <= status_remote_fault;
        status_local_fault_d1 <= status_local_fault;

        //---
        // Read access

        if (wb_cyc_i && wb_stb_i && !wb_we_i) begin

            case ({wb_adr_i[7:2], 2'b0})

              `CPUREG_CONFIG0: begin
                  wb_dat_o <= {31'b0, cpureg_config0};
              end
                           
              `CPUREG_INT_PENDING: begin
                  wb_dat_o <= {23'b0, cpureg_int_pending};
                  cpureg_int_pending <= int_sources;
                  wb_int_o <= 1'b0;
              end

              `CPUREG_INT_STATUS: begin
                  wb_dat_o <= {23'b0, int_sources};
              end

              `CPUREG_INT_MASK: begin
                  wb_dat_o <= {23'b0, cpureg_int_mask};
              end

              default: begin
              end

            endcase

        end

        //---
        // Write access

        if (wb_cyc_i && wb_stb_i && wb_we_i) begin

            case ({wb_adr_i[7:2], 2'b0})

              `CPUREG_CONFIG0: begin
                  cpureg_config0 <= wb_dat_i[0:0];
              end
                           
              `CPUREG_INT_PENDING: begin
                  cpureg_int_pending <= wb_dat_i[8:0] | cpureg_int_pending | int_sources;
              end

              `CPUREG_INT_MASK: begin
                  cpureg_int_mask <= wb_dat_i[8:0];
              end

              default: begin
              end

            endcase

        end

    end

end

endmodule

