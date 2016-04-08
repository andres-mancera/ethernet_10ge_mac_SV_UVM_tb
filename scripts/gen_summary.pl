#!/bin/perl
##////////////////////////////////////////////////////////////////////
##                                                                  //
##  File name : gen_summary.pl                                      //
##  Author    : G. Andres Mancera                                   //
##  License   : GNU Lesser General Public License                   //
##  Course    : System and Functional Verification Using UVM        //
##              UCSC Silicon Valley Extension                       //
##                                                                  //
##////////////////////////////////////////////////////////////////////

my @logfiles = `find ../ -name "*vcs.log"`;
my $logcount = $#logfiles+1;
if ( $logcount==0 ) {
  die "Cannot find VCS log files, report cannot be generated!\n";
}
my $pass_total, $fail_total, $other_total, $test_total = 0;
my @results_array;

foreach (@logfiles) {
  my $pass = `egrep \"********** TEST PASSED **********\" $_`;
  my $fail = `egrep \"********** TEST FAILED **********\" $_`;
  my $seed = `egrep \"automatic random seed used\" $_`;
  my $test_seed;
  if ( $seed =~ /NOTE: automatic random seed used:\s*(\d+)/ ) {
    $test_seed = $1;
  }
  else {
    $test_seed = "unknown";
  }
  if($pass){
    push (@results_array, "  PASSED  (Seed=$test_seed)\t ==>   $_");
    $pass_total++;
  } elsif ($fail){
    push (@results_array, "  FAILED  (Seed=$test_seed)\t ==>   $_");
    $fail_total++;
  } else {
    push (@results_array, "  UNKNOWN (Seed=$test_seed)\t ==>   $_");
    $other_total++;
  }
  $test_total++;
}

my $pass_percent  = ($pass_total/$test_total)*100;
my $fail_percent  = ($fail_total/$test_total)*100;
my $other_percent = ($other_total/$test_total)*100;

printf ("\n");
printf ("===============================================================================\n");
printf ("                             REGRESSION SUMMARY\n");
printf ("===============================================================================\n");
printf ("      TESTCASES THAT PASSED         :  %d [%d\%]\n", $pass_total, $pass_percent);
printf ("      TESTCASES THAT FAILED         :  %d [%d\%]\n", $fail_total, $fail_percent);
printf ("      TESTCASES WITH UNKNOWN STATUS :  %d [%d\%]\n", $other_total, $other_percent);
printf ("      TOTAL NUMBER OF TESTCASES     :  %d\n", $test_total);
printf ("===============================================================================\n");
printf ("\n");
foreach (@results_array) {
  print ($_);
}
printf ("\n");
printf ("===============================================================================\n");
printf ("\n");
