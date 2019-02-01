#           Broadlink RM2 Python Plugin for Domoticz
#
#           Dev. Platform : Win10 x64 & Py 3.5.3 x86
#
#           Author:     zak45, 2017
#
#   Send learned command stored in ini file
#   One param required: ini file full path name
#   Can be used stand alone
#

#
# Main Import
import broadlink
import configparser
import sys
import os

#
sendCommand = ""
brohost = "" 
bromac = ""

#

def send():
    global sendCommand

    if not sendCommand:
        print('Nothing to send')
        sys.exit(3)
    
    sendCommand = bytes.fromhex(sendCommand)

    try:
        device.send_data(sendCommand)
        print( "Code Sent....")
        
    except:    
        raise
        return False

    return True


def broadlinkConnect():
    global device, brohost, bromac

    try:
        device = broadlink.rm(host=(brohost,80), mac=bytearray.fromhex(bromac))
        device.auth()
        device.host        
        print( "Connected to Broadlink device.")        
    except:
        print( "Error Connecting to Broadlink device....")        
        sys.exit(2)

    return True

path=sys.argv[1]

if not os.path.exists(path):
    print(' ini file not found: ' + path)
    sys.exit(1)

config = configparser.ConfigParser()
config.read(path)
Unit=config.get("DEFAULT", "Unit")
brohost=config.get("Device", "host")
bromac=config.get("Device", "mac")
sendCommand = config.get("LearnedCode", Unit)
broadlinkConnect()
send()