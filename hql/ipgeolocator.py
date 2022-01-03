#!/usr/bin/env python

# The line above tells the UNIX shell that it should 
# use the python interpreter to run this script

# The line below imports the 'sys' module, which is
# necessary for writing our records to standard output
import sys

# this is the main program logic
def main():

   # Loop through each record read from standard input
   for line in sys.stdin:

      # Remove whitespace from the line we just read
      trimmed = line.strip()

      # fields in the record are delimited by tabs
      fields = trimmed.split('\t')

      # The cookie is the first of our three fields.
      # Note that we don't need to process this field
      # in our script, we're just passing it through 
      # so it will be available for later queries.
      cookie = fields[0]

      # The IP address is the second field. We use
      # this to determine the ZIP code.
      ip_addr = fields[1]

      # The number of checks steps completed is the 
      # third field. Like the cookie, we don't need 
      # to do anything with it except pass it on.
      steps_completed = fields[2]

      zipcode = create_zipcode(ip_addr)

      # Now we write the resulting record to standard output
      # using a tab delimiter to delimit the three fields.
      print "%s\t%s\t%s" % (cookie, zipcode, steps_completed)



def create_zipcode(ip_addr):
   # This just creates a positive and repeatable
   # number based on the IP address supplied.
   hashed = abs(hash(ip_addr))

   # We'll use that number to simulate a ZIP code
   zipcode = str(hashed)[0:5] 

   # Since ZIP codes don't start with a zero, this one is
   # this one is invalid. We'll rewrite it to 
   # be somewhere near the West Coast
   if zipcode[0] == '0':
      zipcode = '94' + str(zipcode)[2:5]

   # Remap a few select IP addresses to specific ZIP codes
   # to create some patterns that we'll uncover later on.
   near = [
        "192.168.104.145", "192.168.104.168",
        "192.168.104.105", "192.168.104.209",
        "192.168.104.240", "10.16.100.225",
   ]

   far = [
        "172.19.122.247",   "192.168.36.171",
        "172.19.11.75",   "192.168.14.90",
        "172.19.221.108",   "192.168.228.241",
        "192.168.32.87",   "10.46.88.146",
        "192.168.28.66",   "192.168.57.48",
        "10.34.82.181",    "10.124.39.227",
        "10.5.10.170",     "10.89.48.21",
        "10.149.241.250",  "192.168.104.199"
   ]

   if ip_addr in near:
       return "94305"

   if ip_addr in far:
       return "10138"

   return zipcode;




if __name__ == '__main__':
  main()

