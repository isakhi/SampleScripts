"""
A simple script that uses the napalm module and takes name of configuration file as an argument, checks it agains running config on the device
and based on what the user specifies (yes or no) it will commit the changes on the device
this example is for an iosxr device

"""
__author__ = "Imal"
__license__ = "Free"

import napalm
import sys
import os

def main(config_file):
    if not(os.path.exists(config_file) and os.path.isfile(config_file)):
        msg = 'Missing or invalid config file {0}'.format(config_file)
        raise ValueError(msg)
    
    print('Loading config file {0}.'.format(config_file))
    # Use the appropriate network driver to connect to the device:
    driver = napalm.get_network_driver('iosxr')
    # Connect:
    device = driver(hostname='x.x.x.x', username='root',password='abcd1234')

    print('Opening ...')
    try:
        device.open()
    except Exception as e:
        print ("Cannot open connection to device", e)
        sys.exit(1)
    
    print('Loading replacement candidate ...')
    device.load_replace_candidate(filename=config_file)

    print('\nDiff:')
    print(device.compare_config())

    # You can commit or discard the candidate changes.
    choice = input("\nWould you like to commit these changes? [yN]: ")
    if choice == 'y':
        print('Committing ...')
        device.commit_config()
    else:
        print('Discarding ...')
        device.discard_config()
        # close the session with the device.
    device.close()
    print('Done.')

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Please supply the full path to "new_good.conf"')
        sys.exit(1)
    config_file = sys.argv[1]
    
    main(config_file)