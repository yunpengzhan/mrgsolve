% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nmxml.R
\name{read_nmext}
\alias{read_nmext}
\title{Extract estimates from NONMEM ext file}
\usage{
read_nmext(run, file = paste0(run, ".ext"), project = getwd())
}
\arguments{
\item{run}{a run number or run identifier}

\item{file}{the ext file name}

\item{project}{the NONMEM project directory}
}
\value{
A list with theta, omega, and sigma in a format
ready to be used to update a model object.
}
\description{
Extract estimates from NONMEM ext file
}
\examples{
project <- system.file("nonmem", package = "mrgsolve")

est <- read_nmext(1005, project = project)

est$theta

est$omega

est$sigma

}
