
import os
import os.path
import socket

NdaDirectory = None
if os.environ.has_key('NDA_TOP'):
  NdaDirectory = os.environ['NDA_TOP']

if not NdaDirectory:
  hostname = socket.gethostname()
  if hostname.startswith('lepka'):
    NdaDirectory = '/dsk/l1/jpc/crypted/soc/techno'
    if not os.path.isdir(NdaDirectory):
      print '[ERROR] You forgot to mount the NDA encrypted directory, stupid!'
  else:
    NdaDirectory = '/users/soft/techno/techno'

technology = '350/c35b4'
