

run:
	docker run --name cache -d --restart=always --publish 3128:3128 --publish 3141:3141 --publish 3142:3142 --volume $(PWD)/data/squid:/var/spool/squid --volume /data/devpi:/var/.devpi/server --volume /data/aptcacherng:/var/cache/apt-cacher-ng cache
