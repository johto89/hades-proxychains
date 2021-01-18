#! /usr/bin/python3
# coding: utf-8

import random, shutil, os

samplefile = "sampleproxychains.conf"
infile = "good_proxies_list.txt"
configfile = "/etc/proxychains.conf"
backupfile = "/etc/bakproxychains.conf"

def CountLine(file_name):
    f = open(file_name, "r")
    lines = f.readlines()
    lengthline = (len(lines))
    f.close
    return lengthline


def ReadRandomLine(file_name):
    f = open(file_name, "r")
    lines = f.readlines()
    randomList = random.sample(range(0, len(lines)), 5) 
    for i in randomList:
        print(lines[i])
    f.close

def WriteFile(file_name):
    f = open(file_name, 'w+')
    to_write = ''
    for i in good_list:
        to_write += 'HTTPS 	' + i + '\n'
    f.write(to_write)
    f.close()

def AppendFile(infile, outfile):
    fr = open(infile, "r")
    lines = fr.read()
    
    fw = open(outfile, 'a+')
    fw.write(lines)
    
    fr.close
    fw.close

def WriteRandomLine(infile, outfile):
    fr = open(infile, "r")
    lines = fr.readlines()
    randomList = random.sample(range(0, len(lines)), 5) 
    
    fw = open(outfile, 'w+')
    to_write = ''

    for i in randomList:
        to_write += 'HTTPS 	' + lines[i]
    fw.write(to_write)
    
    fr.close
    fw.close

def AppendRandomLine(infile, outfile):
    fr = open(infile, "r")
    lines = fr.readlines()
    randomList = random.sample(range(0, len(lines)), 5) 
    
    fw = open(outfile, 'a+')
    to_write = ''

    for i in randomList:
        to_write += 'HTTPS 	' + lines[i]
    fw.write(to_write)
    
    fr.close
    fw.close

#check backup file
if os.path.isfile(backupfile):
   print ("File exist")
else:
   shutil.copy(configfile, backupfile)

shutil.copy(samplefile, configfile)
if CountLine(infile) < 6:
    AppendFile(infile, configfile)
else:
    AppendRandomLine(infile, configfile)





