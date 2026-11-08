import apb_package::*;
module apb_top;
   apb_interface vif();
   apb_slave dut(.dif(vif));
   initial vif.pclk=0;
   always #5 vif.pclk=~vif.pclk;
   apb_test t;
   initial begin
      vif.presetn=0;
      //repeat(5)                           // this reset should be 1 for atleat 5 posedge
        // @(posedge vif.pclk);
          #40  vif.presetn=1;
       end
       initial begin
   t=new(vif);
   t.run();
   end
   initial #1000 $finish;
endmodule
