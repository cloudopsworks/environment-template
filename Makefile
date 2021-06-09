##
# (c) 2021 - CloudopsWorks OÜ - https://docs.cloudops.works/
#
OS := $(shell uname)
NAMESPACE := "finconecta-staging"
RELEASE_VERSION := $(shell cat VERSION | grep VERSION | cut -f 2 -d "=")
TARGET :=  $(shell cat VERSION | grep TARGET | cut -f 2 -d "=")

.PHONY: version
version:
ifeq ($(OS),Darwin)
	sed -i "" -e "s/chart_version[ \t]*=.*/chart_version = \"$(RELEASE_VERSION)\"/" ${TARGET}-module.tf
else ifeq ($(OS),Linux)
	sed -i -e "s/chart_version[ \t]*=.*/chart_version = \"$(RELEASE_VERSION)\"/" ${TARGET}-module.tf
else
	echo "platfrom $(OS) not supported to release from"
	exit -1
endif

clean:
	rm -f VERSION
