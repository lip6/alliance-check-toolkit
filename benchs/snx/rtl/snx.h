declare    snx  {   
    // -- snx  -- 
    input    inst[16]; 
    input    datai[16]; 
    output    datao[16]; 
    output    iadrs[16]; 
    output    adrs[16];   
    // -- snx  -- 
    func_in	start();
    func_in	IntReq();
    func_in	inst_ok();
    func_in	mem_ok();
    func_out    inst_adr(iadrs); 
    func_out    inst_read():inst; 
    func_out    memory_adr(adrs); 
    func_out    memory_read():datai; 
    func_out    memory_write(adrs,datao); 
    func_out    IntAck(); 
    func_out    wb(); 
    func_out    hlt(); 
    func_in	ShowCR();
} 
  
