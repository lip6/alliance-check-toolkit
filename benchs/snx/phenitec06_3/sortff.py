import sys
divide=10
args = sys.argv
path = args[1]
# path="snx_scan_cts_r.ap"
print('BEGIN_PATH_REG')
with open(path) as f:
    s = f.readlines()
aminx=0
aminy=0
amaxx=0
amaxy=0
apres=0
block=[[ [] for i in range(divide)] for j in range(divide)]
for line in s:
    mode=line[0]
    operand=line[1:].split(',')
    if mode=='H':
        apres=int(operand[3])
    if mode=='A':
        aminx=int(operand[0])
        aminy=int(operand[1])
        amaxx=int(operand[2])
        amaxy=int(operand[3])
    if mode=='I' and operand[2]=='sff1_x4':
        block[int(divide*int(operand[0])/amaxx)][int(divide*int(operand[1])/amaxy)].append(operand[3])
for i in range(divide/2):
    for j in range(divide):
        for item in block[i*2][j]:
            print(item)
    for j in reversed(range(divide)):
        for item in block[i*2+1][j]:
            print(item)
print('END_PATH_REG')
print('BEGIN_CONNECTOR')
print('SCAN_IN scin')
print('SCAN_OUT scout')
print('SCAN_TEST sctest')
print('END_CONNECTOR')

 
 
 


