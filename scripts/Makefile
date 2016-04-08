##////////////////////////////////////////////////////////////////////
##                                                                  //
##  File name : Makefile                                            //
##  Author    : G. Andres Mancera                                   //
##  License   : GNU Lesser General Public License                   //
##  Course    : System and Functional Verification Using UVM        //
##              UCSC Silicon Valley Extension                       //
##                                                                  //
##////////////////////////////////////////////////////////////////////
# Makefile usage
#
help:
	@echo "======================================================================";
	@echo "Usage:";
	@echo "  > make regress          - run all tests & generate summary";
	@echo "  > make summary          - generate summary";
	@echo "  > make test_index       - run individual test [see list below]";
	@echo "  > make clean            - run CLEAN script";
	@echo "";
	@echo "    -----------------------------------------";
	@echo "    test_index      test_name";
	@echo "    -----------------------------------------";
	@echo "    t1              bringup_packet_test";
	@echo "    t2              oversized_packet_test";
	@echo "    t3              undersized_packet_test";
	@echo "    t4              small_large_packet_test";
	@echo "    t5              small_ipg_packet_test";
	@echo "    t6              zero_ipg_packet_test";
	@echo "======================================================================";


# Makefile variables
#####################
VCS_CMD_RAND	= vcs -full64 -R -sverilog -ntb_opts uvm-1.1 -debug_pp +ntb_random_seed_automatic -override_timescale=1ps/1ps
DESIGN_FILES	= ../rtl/verilog/*.v +incdir+../rtl/include/
TESTBENCH_FILES = +incdir+../testbench/ ../testbench/testcase.sv ../testbench/xge_test_top.sv ../testbench/xge_mac_interface.sv


# Makefile targets
#####################
regress: all_tests summary

all_tests: t1 t2 t3 t4 t5 t6

# Bogus targets -> map to real testnames
t1: bringup_packet_test
t2: oversized_packet_test
t3: undersized_packet_test
t4: small_large_packet_test
t5: small_ipg_packet_test
t6: zero_ipg_packet_test

bringup_packet_test:
	${VCS_CMD_RAND} ${DESIGN_FILES} ${TESTBENCH_FILES} +UVM_TESTNAME=$@ +UVM_VERBOSITY=HIGH -l ../sim/$@_vcs.log

oversized_packet_test:
	${VCS_CMD_RAND} ${DESIGN_FILES} ${TESTBENCH_FILES} +UVM_TESTNAME=$@ +UVM_VERBOSITY=HIGH -l ../sim/$@_vcs.log

undersized_packet_test:
	${VCS_CMD_RAND} ${DESIGN_FILES} ${TESTBENCH_FILES} +UVM_TESTNAME=$@ +UVM_VERBOSITY=HIGH -l ../sim/$@_vcs.log

small_large_packet_test:
	${VCS_CMD_RAND} ${DESIGN_FILES} ${TESTBENCH_FILES} +UVM_TESTNAME=$@ +UVM_VERBOSITY=HIGH -l ../sim/$@_vcs.log

small_ipg_packet_test:
	${VCS_CMD_RAND} ${DESIGN_FILES} ${TESTBENCH_FILES} +UVM_TESTNAME=$@ +UVM_VERBOSITY=HIGH -l ../sim/$@_vcs.log

zero_ipg_packet_test:
	${VCS_CMD_RAND} ${DESIGN_FILES} ${TESTBENCH_FILES} +UVM_TESTNAME=$@ +UVM_VERBOSITY=HIGH -l ../sim/$@_vcs.log

summary:
	perl gen_summary.pl | tee summary.log

clean:
	rm -rf ../sim/*_vcs.log \
	csrc \
	simv* \
	summary.log \
	ucli.key \
	vcdplus.vpd \
	*DVE* \
	*INCA* \
	transcript \
	work \
	vc_hdrs.h
