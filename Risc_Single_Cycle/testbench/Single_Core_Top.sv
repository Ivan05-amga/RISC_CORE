
module Single_Core_Top_tb;

  // Parameters

  //Ports
  reg clk;
  reg rstn;

  Single_Core_Top  Single_Core_Top_inst (
    .clk(clk),
    .rstn(rstn)
  );

  always #5  clk = ! clk ;

  initial begin
    clk = 0;
    rstn = 1;
    #10
    rstn = 0;
    #10 
    rstn = 1;
    #1000 
    $finish;
  end

endmodule