CRYSTAL_VERSION ?=    ## How the binaries should be branded
CRYSTAL_SHA1 ?=       ## Git tag/branch/sha1 to checkout and build source
PACKAGE_ITERATION ?=  ## The package iteration

PREVIOUS_CRYSTAL_RELEASE_LINUX32_TARGZ ?=  ## url or path to crystal-{version}-{package}-linux-i686.tar.gz

OUTPUT_DIR = build
DEB_NAME = crystal_$(CRYSTAL_VERSION)-$(PACKAGE_ITERATION)_i386.deb

.PHONY: all
all: linux32-previous $(OUTPUT_DIR)/$(DEB_NAME)

$(OUTPUT_DIR)/$(DEB_NAME):
	mkdir -p $(OUTPUT_DIR)
	docker build -t crystal-build-temp -f $(CURDIR)/Dockerfile ../
	docker run --rm -v $(CURDIR)/../omnibus:/omnibus -v $(CURDIR)/$(OUTPUT_DIR):/omnibus/pkg crystal-build-temp /bin/bash -l -c "\
		   cd /omnibus \
		&& linux32 bundle exec omnibus clean crystal shards \
	  && CRYSTAL_VERSION=$(CRYSTAL_VERSION) PACKAGE_ITERATION=$(PACKAGE_ITERATION) CRYSTAL_SHA1=$(CRYSTAL_SHA1) linux32 bundle exec omnibus build crystal"

.PHONY: linux32-previous
linux32-previous:
	if [[ "$(PREVIOUS_CRYSTAL_RELEASE_LINUX32_TARGZ)" =~ ^http(s?):\/\/ ]]; \
	then curl -L -o /tmp/crystal-linux-i686.tar.gz "$(PREVIOUS_CRYSTAL_RELEASE_LINUX32_TARGZ)"; \
	else cp "$(PREVIOUS_CRYSTAL_RELEASE_LINUX32_TARGZ)" /tmp/crystal-linux-i686.tar.gz; \
	fi \
	&& tar xfz /tmp/crystal-linux-i686.tar.gz -O "crystal-*/embedded/bin/crystal" > $(CURDIR)/../omnibus/crystal-linux-i686 \
	&& rm /tmp/crystal-linux-i686.tar.gz \
	&& chmod +x $(CURDIR)/../omnibus/crystal-linux-i686

.PHONY: clean
clean: ## Clean up build directory
	rm -Rf $(OUTPUT_DIR)
	rm -Rf $(CURDIR)/../omnibus/pkg/crystal-*
	rm -Rf $(CURDIR)/../omnibus/pkg/version-*
	rm -f $(CURDIR)/../omnibus/crystal-linux-i686
