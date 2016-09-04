validate-centos-7.2.json:
	#packer validate centos-7.2.json

image-factory:
	./bin/configure.sh centos7.2.json image-factory


