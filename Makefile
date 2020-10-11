export RELEASE_MANAGER=philipphenkel
export RELEASE_VERSION=0_2_6

INSTALL_PREFIX?=/usr/local

# Default target executed when no arguments are given to make.
default_target: all

all: install

install:
	cp -R boost $(INSTALL_PREFIX)/include

uninstall:
	rm -rf $(INSTALL_PREFIX)/include/boost/threadpool

doc: clean
	make --directory=./libs/threadpool/doc --print-directory doc
	
release_doc:
	make --directory=./libs/threadpool/doc --print-directory release_doc

release_src: clean fetch_clean_src
	mv clean_src threadpool-$(RELEASE_VERSION)-src
	zip -r9 threadpool-$(RELEASE_VERSION)-src.zip threadpool-$(RELEASE_VERSION)-src
	rm -rf threadpool-$(RELEASE_VERSION)-src

deploy_website:
	make --directory=./libs/threadpool/doc --print-directory deploy_sf 
	
clean:
	rm -rf clean_src
	rm -rf threadpool-$(RELEASE_VERSION)-src.zip
	rm -rf threadpool-$(RELEASE_VERSION)-doc.zip
	make --directory=./libs/threadpool/doc --print-directory clean
	
fetch_clean_src:
	rm -rf clean_src
	mkdir clean_src	
#	cvs -d:pserver:anonymous@threadpool.cvs.sourceforge.net:/cvsroot/threadpool login
	cd clean_src; cvs -z3 -d:pserver:anonymous@threadpool.cvs.sourceforge.net:/cvsroot/threadpool export -r RELEASE_$(RELEASE_VERSION) threadpool
#	cd clean_src; cvs -z3 -d:ext:$(RELEASE_MANAGER)@cvs.sourceforge.net:/cvsroot/threadpool export -r RELEASE_$(RELEASE_VERSION) threadpool 



