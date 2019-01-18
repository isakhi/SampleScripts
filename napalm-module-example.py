"""
Simple script using napalm module to read bgp neighbor configuration, show running configuration as well as gather facts from 
different network devices saved in the module devices.py
"""

__author__ = "Imal"
__license__ = "Free"

import json
from napalm.base import get_network_driver
from pprint import pprint
from datetime import datetime
from devices import device_list as all_devices

start= datetime.now()

for a_device in all_devices:
    dev_type = a_device['device_type']
    hostname = a_device['ip']

    print("Type:",dev_type," IP:",hostname)
    if dev_type == 'iosxr':
        driver = get_network_driver('iosxr')
    elif dev_type == 'junos':
        driver = get_network_driver('junos')
    
    dev = driver(hostname=a_device['ip'], username=a_device['username'],
             password=a_device['password'])
    pprint(dev)

    dev.open()
    if dev.is_alive():
        print("Getting data from {}".format(a_device['ip']),"\n")
    bgp_neighbors = dev.get_bgp_neighbors()
    ints = dev.get_interfaces()
    
    if a_device['device_type'] == 'junos':
        conf = dev.cli(commands=['show configuration | no-more'])
        print ("********************************\n")
        pprint(conf)
        print ("********************************\n")
    elif a_device['device_type'] == 'iosxr':
        conf = dev.cli(commands=['show configuration running-config'])
        print ("********************************\n")
        pprint(conf)
        print ("********************************\n")
    dev.close()
    pprint(ints)
    print(json.dumps(bgp_neighbors, sort_keys=True, indent=4),"\n")

end= datetime.now()
total=end-start
print("Total Execution Time: ", total)