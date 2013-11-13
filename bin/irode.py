#!/usr/bin/env python2.7
# Filename    : irode.py
# Author      : LIU Yang
# License     : MIT
# Contact me  : JeremyRobturtle@gmail.com
# Create time : 2013-11-02
"""Add the riding record to my jekyll post

My post it's located in ~/Blogs/2013-11-01-Riding-records.md
"""
import time
from decimal import Decimal

RECORD_FNAME = "/home/jeremy/Blogs/2013-11-01-Riding-records.md"
DST_LAKE_KM  = 28.5
PRECISION    = Decimal('0.1')

def main():
    '''Main process '''
    print("So you rode to Honghuahu Lake, do you?")

    time_min  = raw_input("How many minutes do you rode? ")
    time_hour = int(time_min) / 60.0
    avr_speed = DST_LAKE_KM / time_hour

    max_speed = raw_input("Max speed is: ")

    remark = raw_input("Remark:")

    date = time.strftime("%Y-%m-%d")

    record_row = (
            date +' | '+
            str(time_min) +'min | '+
            str(Decimal(max_speed).quantize(PRECISION)) +'km/h | '+
            str(Decimal(avr_speed).quantize(PRECISION)) +'km/h | '+
            remark +'\n'
    )

    print("Generate record:")
    print(record_row)
    print("Would be wrote into {}".format(RECORD_FNAME))
    with open(RECORD_FNAME, 'a') as recfile:
        recfile.write(record_row)

if __name__ == '__main__':
    main()
