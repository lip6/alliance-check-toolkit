import fileinput
import string
import datetime
state='magic'
DRWLayer='ALU3'
LAMBDA=0.3
BOX=0.9
MAG=100
DLR=(0.0)*MAG/LAMBDA
DWR=(0.2)*MAG/LAMBDA
Width=int(BOX*MAG/LAMBDA + 0.5)
sizex=0
sizey=0
xcount=0
ycount=0
fname=''
seg=2*BOX*MAG/LAMBDA
def header(line):
 global state;
 if(line[0:2] != 'P1'):
   print(line[0:2])
   print("Not supported file format ERROR!")
   quit()
 state='size'

def setsize(line):
 global state, sizex, sizey, fname, centx, centy, seg, LAMBDA, BOX, DRWLayer
 date=datetime.date.today()
 sizex,sizey=line.split()
 sizex=int(sizex)
 sizey=int(sizey)
 print("V ALLIANCE : 6")
 print("H "+fname[:fname.find('.')]+',P, '+str(date.day)+'/ '+str(date.month)+'/'+str(date.year)+','+str(MAG))
 print("A 0,0,"+str(int(sizex*MAG*BOX/LAMBDA))+','+str(int(sizey*MAG*BOX/LAMBDA)))
 state='body'

def putbox(centx,centy):
 global seg
 print("S "+str(int(centx))+','+str(int(centy))+','+str(int(centx+Width-2*DLR+0.5))+','+str(int(centy))+','+str(int(Width-DWR))+',*,RIGHT,'+DRWLayer)

def generate(line):
 global state, sizex, sizey, xcount, ycount, debug
 debug = 0
 for ch in line:
  if ch not in ['0', '1']:
    continue
  centx=xcount*seg+seg/2
  centy=sizey*seg-seg/2-ycount*seg
  if(debug):
    print("new (centx, centy)", (centx, centy))
  if(ch=='1'):
    if(debug):
      print("*")
    putbox(centx,centy)
  xcount=xcount+1
  if(xcount >= sizex):
    xcount=0
    ycount=ycount+1
    if(debug):
      print("x,y",  (xcount,ycount))


func={'magic':header,'size':setsize,'body':generate}

for line in fileinput.input():
  fname=fileinput.filename()
  if(line[0] == '#'):
    continue
  func[state](line)


print('EOF')
quit()

