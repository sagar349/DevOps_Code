import os

folder = input("Provide the folder name with space: ").split()

for i in folder:
    try:
        files = os.listdir(i)
    except FileNotFoundError:
        print("Provide a valid folder name: " + i)
        break # continue
    except PermissionError:
        print("No permission for this folder: " + i)
        break   
        print(" === listing files - " + i)
    for i in files:
        print(i)
