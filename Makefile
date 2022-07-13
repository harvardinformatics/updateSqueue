#
# Make file for docs and test.  Docs aren't setup yet
#
PACKAGE_NAME=updateSqueue

PRODIMAGE     = harvardinformatics/update-squeue:latest
PRODBUILDARGS = 
DEVIMAGE      = update-squeue
DEVBUILDARGS  = 

.PHONY: test Makefile docs dev prod up down build

prod: clean
	docker build --platform linux/amd64 -t $(PRODIMAGE) $(PRODBUILDARGS) .
	docker push $(PRODIMAGE)
build: 
	docker build -t $(DEVIMAGE) $(DEVBUILDARGS) .
up: 
	docker-compose up
down:
	docker-compose down
clean:
	find . -name "*.pyc" -print0 | xargs -0 rm -f
test: drf
	docker-compose run squeue ./wait-for-it.sh -t 120 squeue-db:3306 -- python setup.py test; docker-compose down

