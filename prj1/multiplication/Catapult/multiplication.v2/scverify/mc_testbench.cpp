// ----------------------------------------------------------------------------
// SystemC Testbench Body
//
//    HLS version: 2011a.126 Production Release
//       HLS date: Wed Aug  8 00:52:07 PDT 2012
//  Flow Packages: HDL_Tcl 2008a.1, SCVerify 2009a.1
//
//   Generated by: al3515@EEWS104A-002
// Generated date: Tue Mar 08 15:03:48 +0000 2016
//
// ----------------------------------------------------------------------------
// 
// -------------------------------------
// testbench
// User supplied testbench
// -------------------------------------
// 
#include "mc_testbench.h"
#include <mc_simulator_extensions.h>

testbench* testbench::that;
std::vector<mc_end_of_testbench*> testbench::_end_of_tb_objs;
bool testbench::input_a_ignore;
bool testbench::input_a_skip;
void mc_testbench_input_a_skip(bool v) { testbench::input_a_skip = v; }
int testbench::input_a_array_comp_first;
int testbench::input_a_array_comp_last;
int testbench::input_a_wait_cycles;
mc_wait_ctrl testbench::input_a_wait_ctrl;
bool testbench::input_b_ignore;
bool testbench::input_b_skip;
void mc_testbench_input_b_skip(bool v) { testbench::input_b_skip = v; }
int testbench::input_b_array_comp_first;
int testbench::input_b_array_comp_last;
int testbench::input_b_wait_cycles;
mc_wait_ctrl testbench::input_b_wait_ctrl;
bool testbench::output_ignore;
bool testbench::output_skip;
void mc_testbench_output_skip(bool v) { testbench::output_skip = v; }
int testbench::output_array_comp_first;
int testbench::output_array_comp_last;
bool testbench::output_use_mask;
ac_int<8, true > testbench::output_output_mask;
int testbench::output_wait_cycles;
mc_wait_ctrl testbench::output_wait_ctrl;
extern "C++" void multiplication( ac_int<8, true > *input_a,  ac_int<8, true > *input_b,  ac_int<8, true > *output);

// ============================================
// Function: mc_testbench_process_wait_ctrl
// --------------------------------------------

void testbench::mc_testbench_process_wait_ctrl(const sc_string &var,int &var_wait_cycles,mc_wait_ctrl &var_wait_ctrl,tlm::tlm_fifo_put_if< mc_wait_ctrl > *ccs_wait_ctrl_fifo_if,const int var_capture_count,const int var_stopat)
{
   if (var_wait_cycles) {
      // backward compatibility mode
      var_wait_ctrl.cycles = var_wait_cycles;
      var_wait_cycles = 0;
      std::ostringstream msg; msg.str("");
      msg << "Depricated use of '" << var << "_wait_cycles' variable. Use '" << var << "_wait_ctrl.cycles' instead.";
      SC_REPORT_WARNING("User testbench", msg.str().c_str());
   }
   if (var_wait_ctrl.cycles != 0) {
      var_wait_ctrl.iteration = var_capture_count;
      var_wait_ctrl.stopat = var_stopat;
      if (var_wait_ctrl.cycles < 0) {
         std::ostringstream msg; msg.str("");
         msg << "Ignoring negative value (" << var_wait_ctrl.cycles << ") for testbench control testbench::" << var << "_wait_ctrl.cycles.";
         SC_REPORT_WARNING("User testbench", msg.str().c_str());
         var_wait_ctrl.cycles = 0;
      }
      if (var_wait_ctrl.interval < 0) {
         std::ostringstream msg; msg.str("");
         msg << "Ignoring negative value (" << var_wait_ctrl.interval << ") for testbench control testbench::" << var << "_wait_ctrl.interval.";
         SC_REPORT_WARNING("User testbench", msg.str().c_str());
         var_wait_ctrl.interval = 0;
      }
      if (var_wait_ctrl.is_set()) {
         std::ostringstream msg; msg.str("");
         msg << "Captured wait_ctrl request " << var_wait_ctrl;
         SC_REPORT_INFO("User testbench", msg.str().c_str());
         ccs_wait_ctrl_fifo_if->put(var_wait_ctrl);
      }
   }
   var_wait_ctrl.clear(); // reset wait_ctrl
}
// ============================================
// Function: register_end_of_testbench_obj
// --------------------------------------------

void testbench::register_end_of_testbench_obj(mc_end_of_testbench* obj)
{
   _end_of_tb_objs.push_back(obj);
}
// ============================================
// Function: capture_input_a
// --------------------------------------------

void testbench::capture_input_a( ac_int<8, true > *input_a)
{
   if (input_a_capture_count == wait_cnt)
      wait_on_input_required();
   if (_capture_input_a && !input_a_ignore)
   {
      int cur_iter=input_a_iteration_count;
      ++input_a_iteration_count;
      ccs_input_a->put((*input_a));
      ++input_a_capture_count;
      mc_testbench_process_wait_ctrl("input_a",input_a_wait_cycles,input_a_wait_ctrl,ccs_wait_ctrl_input_a.operator->(),cur_iter,input_a_capture_count);
      input_a_ignore = false;
   }
}
// ============================================
// Function: capture_input_b
// --------------------------------------------

void testbench::capture_input_b( ac_int<8, true > *input_b)
{
   if (input_b_capture_count == wait_cnt)
      wait_on_input_required();
   if (_capture_input_b && !input_b_ignore)
   {
      int cur_iter=input_b_iteration_count;
      ++input_b_iteration_count;
      ccs_input_b->put((*input_b));
      ++input_b_capture_count;
      mc_testbench_process_wait_ctrl("input_b",input_b_wait_cycles,input_b_wait_ctrl,ccs_wait_ctrl_input_b.operator->(),cur_iter,input_b_capture_count);
      input_b_ignore = false;
   }
}
// ============================================
// Function: capture_output
// --------------------------------------------

void testbench::capture_output( ac_int<8, true > *output)
{
   if (_capture_output)
   {
      int cur_iter=output_iteration_count;
      ++output_iteration_count;
      mc_golden_info< ac_int<8, true >, ac_int<8, true > > output_tmp((*output), output_ignore, ~0, false, output_iteration_count);
      // BEGIN: testbench output_mask control for field_name output
      if ( output_use_mask ) {
         output_tmp._use_mask = true;
         output_tmp._mask = output_output_mask ;
      }
      // END: testbench output_mask control for field_name output
      if (!output_skip) {
         output_golden.put(output_tmp);
         ++output_capture_count;
      } else {
         std::ostringstream msg; msg.str("");
         msg << "output_skip=true for iteration=" << output_iteration_count << " @ " << sc_time_stamp();
         SC_REPORT_WARNING("User testbench", msg.str().c_str());
      }
      mc_testbench_process_wait_ctrl("output",output_wait_cycles,output_wait_ctrl,ccs_wait_ctrl_output.operator->(),cur_iter,output_capture_count);
      output_ignore = false;
      output_use_mask = false;
   }
   output_skip = false;
}
// ============================================
// Function: wait_on_input_required
// --------------------------------------------

void testbench::wait_on_input_required()
{
   ++wait_cnt;
   wait(SC_ZERO_TIME); // get fifos a chance to update
   while (atleast_one_active_input) {
      if (_capture_input_a && ccs_input_a->used() == 0) return;
      if (_capture_input_b && ccs_input_b->used() == 0) return;
      that->cpp_testbench_active.write(false);
      wait(ccs_input_a->ok_to_put() | ccs_input_b->ok_to_put());
      that->cpp_testbench_active.write(true);
   }
}
// ============================================
// Function: capture_IN
// --------------------------------------------

void testbench::capture_IN( ac_int<8, true > *input_a,  ac_int<8, true > *input_b,  ac_int<8, true > *output)
{
   that->capture_input_a(input_a);
   that->capture_input_b(input_b);
}
// ============================================
// Function: capture_OUT
// --------------------------------------------

void testbench::capture_OUT( ac_int<8, true > *input_a,  ac_int<8, true > *input_b,  ac_int<8, true > *output)
{
   that->capture_output(output);
}
// ============================================
// Function: exec_multiplication
// --------------------------------------------

void testbench::exec_multiplication( ac_int<8, true > *input_a,  ac_int<8, true > *input_b,  ac_int<8, true > *output)
{
   that->cpp_testbench_active.write(true);
   capture_IN(input_a, input_b, output);
   multiplication(input_a, input_b, output);
   // throttle ac_channel based on number of calls to chan::size() or chan::empty() or chan::nb_read() (but not chan::available()) 
   if (1) {
      int cnt=0;
      if (cnt) std::cout << "mc_testbench.cpp: CONTINUES @ " << sc_time_stamp() << std::endl;
      if (cnt) that->cpp_testbench_active.write(true);
   }
   capture_OUT(input_a, input_b, output);
}
// ============================================
// Function: end_of_simulation
// --------------------------------------------

void testbench::end_of_simulation()
{
   if (!_checked_results) {
      SC_REPORT_INFO(name(), "Simulation ran into deadlock");
      check_results();
   }
}
// ============================================
// Function: check_results
// --------------------------------------------

void testbench::check_results()
{
   for (std::vector<mc_end_of_testbench*>::iterator i = _end_of_tb_objs.begin(); i != _end_of_tb_objs.end(); ++i)
      (*i)->end_of_testbench();
   
   _checked_results = true;
   cout<<endl;
   cout<<"Checking results"<<endl;
   _failed = false;
   if (main_exit_code) _failed = true;
   int _num_outputs_checked = 0;
   
   if (!_capture_output) {
      cout<<"'output' - warning, output was optimized away"<<endl;
   } else {
      _num_outputs_checked++;
      cout<<"'output'"<<endl;
      cout<<"   capture count        = "<<output_capture_count<<endl;
      cout<<"   comparison count     = "<<output_comp->get_compare_count();
      if (output_comp->get_partial_compare_count()) 
         cout <<" ("<<output_comp->get_partial_compare_count()<<" partial)";
      if (output_comp->get_mask_compare_count()) 
         cout <<" ("<<output_comp->get_mask_compare_count()<<" masked)";
      cout << endl;
      cout<<"   ignore count         = "<<output_comp->get_ignore_count()<<endl;
      cout<<"   error count          = "<<output_comp->get_error_count()<<endl;
      cout<<"   stuck in dut fifo    = "<<ccs_output->used()<<endl;
      cout<<"   stuck in golden fifo = "<<output_golden.used()<<endl;
      if (output_comp->get_error_count() > 0) cout << "   Error: output 'output' had comparison errors"<<endl;
      if (output_comp->get_compare_count() < output_capture_count) cout << "   Error: output 'output' has incomplete comparisons"<<endl;
      if (output_capture_count == 0) cout << "   Error: output 'output' has no golden values to compare against"<<endl;
      _failed = _failed || output_comp->get_error_count() > 0;
      _failed = _failed || output_comp->get_compare_count() < output_capture_count;
      _failed = _failed || output_capture_count == 0;
      cout<<endl;
   }
   cout<<endl;
   if (_num_outputs_checked == 0) {
      cout<<"Error: All outputs were optimized away. No output values were compared."<<endl;
      _failed = _failed || (_num_outputs_checked == 0);
   }
   if (main_exit_code) cout << "Error: C++ Testbench 'main()' returned a non-zero exit code ("<<main_exit_code<<"). Check your testbench." <<endl;
   cout<<(_failed ? "Error: ":"Info: ")<<"Simulation "<<(_failed ? "FAILED":"PASSED")<<" @ "<<sc_time_stamp()<<endl;
   
   if (_failed) {
      cout << endl;
      cout << "Error: Simulation may have failed due to incorrect testbench stimulus synchronization. Try turning on the TRANSACTION_DONE_SIGNAL directive." << endl;
   }
}
// ============================================
// Function: failed
// --------------------------------------------

bool testbench::failed()
{
   return _failed;
}
// ---------------------------------------------------------------
// Process: SC_METHOD wait_for_end
// Static sensitivity: sensitive << clk.pos() << testbench_end_event;

void testbench::wait_for_end() {
   // If run() has not finished, we do nothing here
   if (!testbench_ended) return;
   // check for completed outputs
   if (output_comp->get_compare_count() < output_capture_count) {testbench_end_event.notify(1,SC_NS); return;}
   // If we made it here, all outputs have flushed. Check the results
   SC_REPORT_INFO(name(), "Simulation completed");
   check_results();
   sc_stop();
}
// ---------------------------------------------------------------
// Process: SC_THREAD run
// Static sensitivity: 

void testbench::run() {
   input_a_ignore = false;
   input_a_skip = false;
   input_a_array_comp_first = -1;
   input_a_array_comp_last = -1;
   input_a_wait_cycles = 0;
   input_a_wait_ctrl.clear();
   input_a_capture_count = 0;
   input_a_iteration_count = 0;
   input_b_ignore = false;
   input_b_skip = false;
   input_b_array_comp_first = -1;
   input_b_array_comp_last = -1;
   input_b_wait_cycles = 0;
   input_b_wait_ctrl.clear();
   input_b_capture_count = 0;
   input_b_iteration_count = 0;
   output_ignore = false;
   output_skip = false;
   output_array_comp_first = -1;
   output_array_comp_last = -1;
   output_use_mask = false;
   output_output_mask = ~0;
   output_wait_cycles = 0;
   output_wait_ctrl.clear();
   output_capture_count = 0;
   output_iteration_count = 0;
   main_exit_code = main();
   cout<<"Info: Execution of user-supplied C++ testbench 'main()' has completed with exit code = " << main_exit_code << endl;
   cout<<endl;
   cout<<"Info: Collecting data completed"<<endl;
   cout<<"   captured "<<input_a_capture_count<<" values of input_a"<<endl;
   cout<<"   captured "<<input_b_capture_count<<" values of input_b"<<endl;
   cout<<"   captured "<<output_capture_count<<" values of output"<<endl;
   testbench_ended = true;
   testbench_end_event.notify(SC_ZERO_TIME);
}
