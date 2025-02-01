import sys

type = sys.argv[1]

if type == "t2.micro":
    print("This is for free")
elif type == "t2.medium":
    print("This is chargable")
elif type == "t2.xlarge":
    print("This is highly chargable")
else:
    print("Pass correct command")
    sys.exit(1)
print(type)    