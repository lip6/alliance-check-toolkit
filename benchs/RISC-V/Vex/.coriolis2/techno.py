
#import os.path
#import socket
#
#hostname = socket.gethostname()
#if hostname.startswith('lepka'):
#  NdaDirectory = '/dsk/l1/jpc/crypted/soc/techno'
# #print '          - Using NDA on <lepka>:"%s".' % NdaDirectory
#  if not os.path.isdir(NdaDirectory):
#    print '[ERROR] You forgot to mount the NDA encrypted directory, stupid!'
#else:
#  NdaDirectory = '/users/soft/techno/techno'
# #print '          - Using NDA on <LIP6/SoC>:"%s".' % NdaDirectory

technology = '45/freepdk_45'
