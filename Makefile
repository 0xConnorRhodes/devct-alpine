shell:
	docker exec -it devpine /usr/bin/fish

run:
	docker container rm -f devpine
	docker run -d --name devpine --hostname devpine ghcr.io/0xconnorrhodes/devct-alpine
	docker exec -it devpine /usr/bin/fish

rerun:
	docker container rm -f devpine
	docker pull ghcr.io/0xconnorrhodes/devct-alpine
	docker container run -d --name devpine --hostname devpine ghcr.io/0xconnorrhodes/devct-alpine
	docker exec -it devpine /usr/bin/fish
