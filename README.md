# minecraft-servers

Ansible to manage Minecraft servers running under Docker Compose

## Requirements

Ubuntu (tested with focal) and Ansible 2.9

## Instructions

Running everything from the Minecraft host:
```
apt -y install ansible make
git clone https://github.com/ruaidhrip/minecraft-servers.git
cd minecraft-servers
make cfg
sed -i 's/^[ #]*docker_install:.*$/docker_install: true/' \
    host_vars/localhost.yml # if you want docker and compose to be installed
# Uncomment and edit minecraft_users to allow your user to connect
make
```
Running Minecraft on a remote host using local Ansible:
```
apt -y install ansible make
git clone https://github.com/ruaidhrip/minecraft-servers.git
cd minecraft-servers
cp host_vars/localhost.yml.example host_vars/minecraft.example.org.yml
echo minecraft.example.org > hosts
sed -i 's/^[ #]*docker_install:.*$/docker_install: true/' \
    host_vars/minecraft.example.org.yml # if you want docker and compose to be installed
# Uncomment and edit minecraft_users to allow your user to connect
make
```

If you want to take backups, set `minecraft_backup_dir` in host_vars to the directory you'd like to use - this does a nightly backup by shutting down the server and using a separate compose file to create a new container that copies the data to the backup location.

## Notes
* If you get a permission denied error on the Docker socket, you should relog to finish adding you to the `docker` group.
* Determining the latest version is done by visiting the download webpages, which may not work depending on what IP you're connecting from - it fails on my AWS instance for example. See https://bugs.mojang.com/browse/WEB-4753 for more info.
* To enable or disable servers, use `state: present`/`state: absent` in the minecraft_servers configuration for that server. The world data will match the server name you set, so be aware if you change the name it will assume this is a new server. All your data should still be intact in the data volume however.
* If you're using a host with a single IP, be sure to set unique `port`s for each server for the Docker port forwarding to work.
