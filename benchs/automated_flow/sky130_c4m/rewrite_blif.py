#instanciate one sky130c4m buffer between 2 nets
def add_buffer(net_name1,net_name2):
    return f'.subckt buf_x1 i={net_name1} q={net_name2}'

# replace the multiassignement of one net by buffers in the blif file
# in order to obtain several output for one net after the b2v
def replace_multi_connectors_by_buffer(blif_file):
 names_dico={}   #dictionnary containing the nets assigned
 with open(blif_file, 'r') as file:
        lines = file.readlines()
        for i, line in enumerate(lines):
         if '.name' in line:                 
             assignement_line = line.split()
             if len(assignement_line) == 3 : # distinguish between classic assignement and
                                             # setting options for the .name
               net_name1= assignement_line[1]
               net_name2= assignement_line[2]
               if net_name1 in names_dico:   # if a net is assigned to several nets we add a buffer
                   lines[i] = add_buffer(net_name1,net_name2)+'\n'
               else:    
                names_dico[net_name1] = [net_name1,net_name2]
 file = open(f'{blif_file}', 'w')
 file.writelines(lines)
 file.close()
replace_multi_connectors_by_buffer('multioutput_mac.blif')





