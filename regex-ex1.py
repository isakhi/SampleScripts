"""
Script to play around with regex in python
"""

__author__ = "Imal"
__license__ = "Free"

import re
import sys
str = 'an example word:cat!!'
match = re.search(r'word:.*', str)
# If-statement after search() tests if it succeeded
print("match: ",match)
if match:
  print ('found', match.group()) ## 'found word:cat'
else:
  print ('did not find')

## Suppose we have a text with many email addresses
str = 'purple alice@google.com, blah monkey bob@abc.com blah dishwasher'

## Here re.findall() returns a list of all the found email strings
emails = re.findall(r'[^ -]+@[^ -]+\.(?:com|net|org)', str) ## ['alice@google.com', 'bob@abc.com']
for email in emails:
# do something with each found email string
    print (email)

str = 'purple alice@google.com, blah monkey bob@abc.com blah dishwasher'
match = re.findall(r'([\w\.-]+)@([\w\.-]+)', str)
for group in match:
  print("Finds: ", group)
  
## re.sub(pat, replacement, str) -- returns new string with all replacements,
## \1 is group(1), \2 group(2) in the replacement
print (re.sub(r'([\w\.-]+)@([\w\.-]+)', r'\1@yo-yo-dyne.com', str))

print (re.sub(r'([\w\.-]+)@([\w\.-]+)', r'\2@yo-yo-dyne.com', str))

match = re.match(r'(...)(.)(.)',str) # three gorups:  pur p l
print(match.group(1))
## purple alice@yo-yo-dyne.com, blah monkey bob@yo-yo-dyne.com blah dishwasher

#for path in sys.path:
#    print(path)

str =  "WHAT is your name"
match = re.search(r'what',str,re.IGNORECASE)

print (match.group())

str = "ABCDE123 test bla bla 01234567 ABCDEFGH AAABBB00 1234ABCD and what else"
match = re.findall(r'[A-F0-9]{8}',str) #will match anything upto 8 charcters in total that has A-F or 0-9
for group in match:
  print("Finds: ", group)