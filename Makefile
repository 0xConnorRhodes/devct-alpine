shell:
	docker exec -it dev /usr/bin/fish

run:
	docker run -d --name dev --hostname devpine ghcr.io/0xconnorrhodes/devct-alpine

rerun:
	docker container rm -f dev
	docker pull ghcr.io/0xconnorrhodes/devct-alpine
	docker container run -d --name dev --hostname devpine ghcr.io/0xconnorrhodes/devct-alpine
	docker exec -it dev /usr/bin/fish
