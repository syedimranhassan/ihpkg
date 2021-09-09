.DEFAULT_GOAL := help

docker_build:
	docker build . -f Dockerfile --target node-angular-cli -t 257477529851.dkr.ecr.us-east-1.amazonaws.com/test:${{ github.sha }}
	docker build . -f Dockerfile --target newrelic -t 257477529851.dkr.ecr.us-east-1.amazonaws.com/test:latest-newrelic

docker_tag: docker_build
	docker tag 257477529851.dkr.ecr.us-east-1.amazonaws.com/test 257477529851.dkr.ecr.us-east-1.amazonaws.com/test:${GITHUB_SHA}
	docker tag 257477529851.dkr.ecr.us-east-1.amazonaws.com/test:latest-newrelic 257477529851.dkr.ecr.us-east-1.amazonaws.com/test:${GITHUB_SHA}-newrelic

docker_auth:
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 257477529851.dkr.ecr.us-east-1.amazonaws.com

docker_push: docker_tag docker_auth
	docker push '257477529851.dkr.ecr.us-east-1.amazonaws.com/test:latest'
	docker push "257477529851.dkr.ecr.us-east-1.amazonaws.com/test:${GITHUB_SHA}"
	docker push '257477529851.dkr.ecr.us-east-1.amazonaws.com/test:latest-newrelic'
	docker push "257477529851.dkr.ecr.us-east-1.amazonaws.com/test:${GITHUB_SHA}-newrelic"
