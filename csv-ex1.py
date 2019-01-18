"""
Simple script to read a csv file and print out its content
the csv file is in the format:
cisco-sw1,basement,10.10.10.10
"""
__author__ = "Imal"
__license__ = "Free"

import csv
from pprint import pprint

# Open the sample csv file and print it to screen
with open("file.csv") as f:
    print(f.read())
# Open the sample csv file, and create a csv.readerobject
with open("file.csv") as f:
    csv_python= csv.reader(f, delimiter=',')
    for col in csv_python:
        print("{device} is in {location} \nand has IP {ip}".format(device=col[0],location=col[2],ip=col[1]))