SHELL := /bin/bash
#LIBDIR=${HOME}/Rlibs/lib
PACKAGE=mrgsolve
VERSION=$(shell grep Version DESCRIPTION |awk '{print $$2}')
TARBALL=${PACKAGE}_${VERSION}.tar.gz
PKGDIR=.
CHKDIR=Rchecks


## Set libPaths:
## export R_LIBS=${LIBDIR}

gut_check:
	Rscript "inst/maintenance/gut_check.R"

everything:
	make all
	make pkgdown

pkgdown:
	Rscript "inst/maintenance/pkgdown.R"
	cp -r DOCS/ ../../mrgsolve/docs/
	touch ../../mrgsolve/docs/.nojekyll

test-all:
	Rscript -e 'library(testthat)' -e 'test_dir("tests/testthat")' -e 'test_dir("inst/maintenance/unit")'

unit:
	Rscript -e 'library(testthat)' -e 'test_dir("inst/maintenance/unit")'

cran:
	make doc
	make build
	R CMD CHECK --as-cran ${TARBALL} -o ${CHKDIR}

travis_build:
	make doc
	make build
	make install

readme:
	Rscript -e 'library(rmarkdown); render("README.Rmd")'

all:
	make doc
	make build
	make install


.PHONY: doc
doc:
	Rscript inst/maintenance/doc_mrgsolve.R

.PHONY: staticdoc
staticdoc:
	Rscript inst/maintenance/staticdocs.R

build:
	R CMD build --md5 $(PKGDIR)

install:
	R CMD INSTALL --install-tests ${TARBALL} -l ~/Rlibs

install-build:
	R CMD INSTALL --build --install-tests ${TARBALL}

check:
	make doc
	make build
	R CMD check ${TARBALL} -o ${CHKDIR}
	make unit
qcheck: 
	make doc
	make build 
	R CMD check ${TARBALL} -o ${CHKDIR} --no-manual --no-codoc


check-cran:
	make doc
	make build
	R CMD check --as-cran ${TARBALL} -o ${CHKDIR}

test:
	R CMD INSTALL ${PKGDIR}
	make test-all


clean:
	if test -d ${CHKDIR}/mrgsolve.Rcheck; then rm -rf ${CHKDIR}/mrgsolve.Rcheck;fi

datasets:
	Rscript inst/maintenance/datasets.R

travis:
	make build
	#R CMD check --as-cran --no-manual ${TARBALL} -o ${CHKDIR}
	make test
