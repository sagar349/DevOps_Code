def update_server_conf(file_path, key, value):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    with open(file_path, 'w') as file:
        for i in lines:
            if key in i:
                file.write(key + "=" + value + "\n") 
            else:
                file.write(i)    



update_server_conf("server.conf", "MAX_CONNECTION", "6000")