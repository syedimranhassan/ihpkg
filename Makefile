.DEFAULT_GOAL := help


docker_build:
	docker build . -f Dockerfile -t syedimranhassan/test
	docker build . -f Dockerfile -t syedimranhassan/test:latest-newrelic

travis_docker_tag: docker_build
	docker tag syedimranhassan/test syedimranhassan/test:${GITHUB_SHA}
	docker tag syedimranhassan/test:latest-newrelic syedimranhassan/test:${GITHUB_SHA}-newrelic

travis_docker_auth:
	echo ${{ secrets.DOCKERHUB_PASSWORD }} | docker login -u ${{ secrets.DOCKERHUB_USERNAME }} --password-stdin

travis_docker_push: travis_docker_tag travis_docker_auth ## push to docker hub
	docker push 'syedimranhassan/test:latest'
	docker push "syedimranhassan/test:${GITHUB_SHA}"
	docker push 'syedimranhassan/test:latest-newrelic'
	docker push "syedimranhassan/test:${GITHUB_SHA}-newrelic"
