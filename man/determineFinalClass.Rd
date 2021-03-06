% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/multipleTestClassifierSubfunc.R
\name{determineFinalClass}
\alias{determineFinalClass}
\title{Determine Final Class based on the Classifier Results}
\usage{
determineFinalClass(g)
}
\arguments{
\item{g}{character vector of 3-elements with the output from each of the classifiers.}
}
\value{
vector
}
\description{
\code{determineFinalClass} returns a 2-element vector: 1)classification;
2) classification groups.
}
\details{
This function is called by \code{\link{reportClassifierCalls}} to perform the logic that
determines the overall class of a test sample based on the results from multiple classifiers.
}
\examples{
g <- list(C=c(AvC="C", BvC="C", BvA="B"),
         A=c(AvC="A", BvC="C", BvA="A"),
         B=c(AvC="C", BvC="B", BvA="B"),
         A2=c(AvC="A", BvC="B", BvA="A"),
         B2=c(AvC="A", BvC="B", BvA="B"))
lapply(g, determineFinalClass)
}

