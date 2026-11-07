class apb_write extends apb_generator;
   function new(mailbox gdmbx);
      super.new(gdmbx);
   endfunction : new
   
   task run();
      repeat(10) begin
         tr.randomize() with {tr.pwrite==1;};
         tr.disp("GEN");
         gdmbx.put(tr);
         @(e1);
      end
   endtask : run
endclass : apb_write
