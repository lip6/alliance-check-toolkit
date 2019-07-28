
useNda = True

if useNda:
  import os.path
  import socket

  hostname = socket.gethostname()
  if hostname.startswith('lepka'):
    NdaDirectory = '/dsk/l1/jpc/crypted/soc/techno'
   #print '          - Using NDA on <lepka>:"%s".' % NdaDirectory
    if not os.path.isdir(NdaDirectory):
      print '[ERROR] You forgot to mount the NDA encrypted directory, stupid!'
  else:
    NdaDirectory = '/users/soft/techno/techno'
   #print '          - Using NDA on <LIP6/SoC>:"%s".' % NdaDirectory

 # AMS 350nm.
  technology = '350/c35b4'
  
 # ST 130nm.
 #technology = '130/hcmos9gp'
  
 # ST 65nm.
 #technology = '65/cmos065'
else:
# NdaDirectory not used for MOSIS technologies.
# MOSIS 180nm.
  technology = '180/scn6m_deep_09'
