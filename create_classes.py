import os, sys

chr=sys.argv[1]
n=int(sys.argv[2])

out_file=open("chr" + chr + "_classes.txt", "w")
for i in range(0,n):
    out_file.write("0 0 ")
for i in range(0, 99):
    out_file.write("1 1 ")
for i in range(0, 108):
    out_file.write("2 2 ")
out_file.write("\n")
out_file.close()
