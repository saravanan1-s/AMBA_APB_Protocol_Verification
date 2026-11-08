class apb_ww_slverr extends apb_generator;
   function new(mailbox gdmbx);
      super.new(gdmbx);
   endfunction : new
   
   task run();
      repeat(10) begin
         tr.randomize() with {tr.paddr=={32{1'b1}};};
         tr.disp("GEN");
         gdmbx.put(tr);
         @(e1);
      end
   endtask : run
endclass : apb_ww_slverr
