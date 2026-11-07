class apb_generator;
   apb_transaction tr;
   mailbox gdmbx;
   function new(mailbox gdmbx);
      this.gdmbx=gdmbx;
      tr=new();
   endfunction : new
   virtual task run();
      repeat(10) begin
         tr.randomize() with {tr.pwrite==1;};
         tr.disp("GEN");
         gdmbx.put(tr);
         @(e1);
      end
      repeat(10) begin
         tr.randomize() with {tr.pwrite==0;tr.pwdata==0;};
         tr.disp("gEN");
         gdmbx.put(tr);
         @(e1);
      end
   endtask : run
endclass : apb_generator
