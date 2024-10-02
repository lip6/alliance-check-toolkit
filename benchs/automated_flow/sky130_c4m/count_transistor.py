def count_transistor_lib(lib_file):
    instance_dico={}
    file = open(lib_file, 'r')
    lines = file.readlines()
    file.close()
    i=0
    while  i < len(lines):
        if '.subckt' in lines[i]:
            instance_dico[lines[i].split()[1]]=0
            j=i
            while j<len(lines)-1:
             if '.ends' in lines[j]:
                 break
             elif 'fet' in lines[j]:
                instance_dico[lines[i].split()[1]]+=1
             j+=1
        i=i+1        
    return instance_dico        

def count_transistors_in_spi(spi_file,dico): 
    file = open(spi_file, 'r')
    lines = file.readlines()
    file.close()
    s=0
    for i in range (0,len(lines)):
      if len(lines[i].split()) != 0:
       if lines[i].split()[0] != "*":
        if '.include' not in lines[i]:
            if lines[i].split()[-1] in dico:
                s+=dico[lines[i].split()[-1]]
    return s            

s='picorv32_cts_r.spi'
d=count_transistor_lib('../../../pdkmaster/C4M.Sky130/libs.ref/StdCellLib/spice/StdCellLib.spi')
print(count_transistors_in_spi(s,d))
