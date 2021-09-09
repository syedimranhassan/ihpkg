.DEFAULT_GOAL := help

docker_build:
	docker build . -f Dockerfile --target node-angular-cli -t syedimranhassan/test
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


docker_ecr_build:
	docker build . -f Dockerfile --target node-angular-cli -t 257477529851.dkr.ecr.us-east-1.amazonaws.com/test:${{ github.sha }}
	docker build . -f Dockerfile --target newrelic -t 257477529851.dkr.ecr.us-east-1.amazonaws.com/test:latest-newrelic

docker_ecr_tag: docker_ecr_build
	docker tag 257477529851.dkr.ecr.us-east-1.amazonaws.com/test 257477529851.dkr.ecr.us-east-1.amazonaws.com/test:${GITHUB_SHA}
	docker tag 257477529851.dkr.ecr.us-east-1.amazonaws.com/test:latest-newrelic 257477529851.dkr.ecr.us-east-1.amazonaws.com/test:${GITHUB_SHA}-newrelic


docker_ecr_push: docker_ecr_tag 
	docker push '257477529851.dkr.ecr.us-east-1.amazonaws.com/test:latest'
	docker push "257477529851.dkr.ecr.us-east-1.amazonaws.com/test:${GITHUB_SHA}"
	docker push '257477529851.dkr.ecr.us-east-1.amazonaws.com/test:latest-newrelic'
	docker push "257477529851.dkr.ecr.us-east-1.amazonaws.com/test:${GITHUB_SHA}-newrelic"
