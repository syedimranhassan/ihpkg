.DEFAULT_GOAL := help

docker_build:
	docker build . -f Dockerfile -t syedimranhassan/test
	docker build . -f Dockerfile --target newrelic -t syedimranhassan/test:latest-newrelic

docker_tag: docker_build
	docker tag syedimranhassan/test syedimranhassan/test:${GITHUB_SHA}
	docker tag syedimranhassan/test:latest-newrelic syedimranhassan/test:${GITHUB_SHA}-newrelic

docker_auth:
	echo "$$DOCKERHUB_PASSWORD" | docker login -u "$$DOCKERHUB_USERNAME" --password-stdin

docker_push: docker_tag docker_auth ## push to docker hub
	docker push 'syedimranhassan/test:latest'
	docker push "syedimranhassan/test:${GITHUB_SHA}"
	docker push 'syedimranhassan/test:latest-newrelic'
	docker push "syedimranhassan/test:${GITHUB_SHA}-newrelic"
