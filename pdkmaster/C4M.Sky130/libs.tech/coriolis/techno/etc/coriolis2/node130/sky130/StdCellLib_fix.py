from Hurricane import Net

def fix(lib):
    for cell in lib.getCells():
        for net in cell.getNets():
            if net.getName() == 'vdd':
                net.setType( Net.Type.POWER )
                net.setDirection( Net.Direction.IN )
            elif net.getName() == 'vss':
                net.setType( Net.Type.GROUND )
                net.setDirection( Net.Direction.IN )
            elif net.getName() == 'ck':
                net.setType( Net.Type.CLOCK )
                net.setDirection( Net.Direction.IN )
            elif net.getName() in ('nq', "q", 'zero', 'one'):
                net.setDirection( Net.Direction.OUT )
            else:
                net.setDirection( Net.Direction.IN )
