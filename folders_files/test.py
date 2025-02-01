import os

folder = input("Provide folder name: ").split

for i in folder:
    files = os.listdir(i)
    for i in files:
        print(i) 
