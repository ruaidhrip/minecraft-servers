all: cfg
	ansible-playbook -i ./hosts minecraft-servers.yml

cfg:
	[ -f ./hosts ] || (cp -n hosts.example hosts; cp host_vars/localhost.yml.example host_vars/localhost.yml)
