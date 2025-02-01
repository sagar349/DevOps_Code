
import sys

type = sys.argv[1]

if type == "t2.micro":
    print("This is for free account")
elif type == "t2.medium":
    print("This is for chargable")
elif type == "t2.xlarge":
    print("This is high chargable")

else:
    print("Invalid istance")