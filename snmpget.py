"""

Simple script that takes input like IP, SNMP read community and MIB from end user, runs an snmpwalk, collects data and displays
the output to stdout

"""
__author__ = "Imal"
__license__ = "Free"

from pysnmp.entity.rfc3413.oneliner import cmdgen
#from pysnmp.proto.rfc1902 import Integer, IpAddress, OctetString
#from pysnmp.hlapi import *
ip=input("IP: ")
community=input("Community: ")
value=input("MIB: ")

generator = cmdgen.CommandGenerator()
comm_data = cmdgen.CommunityData('server', community, 1) # 1 means version SNMP v2c
transport = cmdgen.UdpTransportTarget((ip, 161))

real_fun = getattr(generator, 'nextCmd')
res = (errorIndication, errorStatus, errorIndex, varBinds)\
    = real_fun(comm_data, transport, value)

if not errorIndication is None  or errorStatus is True:
       print ("Error: %s %s %s %s" % res)
else:
       for varBind in varBinds:
            print(' = '.join([x.prettyPrint() for x in varBind]))