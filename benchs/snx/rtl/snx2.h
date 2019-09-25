#define ADDRSP	10
declare    snx2  {   
    // -- snx  -- 
    input    datai[16]; 
    output    datao[16]; 
    output    adrs[ADDRSP];   
    // -- snx  -- 
    func_in	start();
    func_in	mem_ok();
    func_out    memory_adr(adrs); 
    func_out    memory_read():datai; 
    func_out    memory_write(adrs,datao); 
    func_out    stgi(); 
    func_out    stge(); 
    func_out    stgs(); 
    func_out    stgs2(); 
    func_out    stgl(); 
    func_out    wb(); 
    func_out    hlt(); 
} 
  
