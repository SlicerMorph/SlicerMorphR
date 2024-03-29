% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/extract.outliers.R
\name{extract.outliers}
\alias{extract.outliers}
\title{Extract outlier estimates by individual templates}
\usage{
extract.outliers(allEstimates, MALPACA_medians, outputPath, ZScore = 2)
}
\arguments{
\item{allEstimates}{The 4d array that contains all estimates of individual templates. One can use the read.malpca.estimates function in SlicerMorphR to generate it.}

\item{MALPACA_medians}{The 3d array that contains MALPACA median estimates.}

\item{outputPath}{The directory for storing the output pdf for boxplots that mark outlier estimates.}

\item{ZScore}{The index is used to determined how many standard deviations above the mean distances for one specimen\cr
as the threshold for determining outliers. The default value is 2, so the threshold is 2*SD + mean.}
}
\value{
A list that contains median estimates, manual landmarks and estimates of individual templates \cr
The returned value contains: \cr
\itemize{
\item $estimates_no_out = a 4d array with all outliers denoted as NA
\item $outlier_info = A list that stores outlier landmarks and templates that generate them for each specimen. The length is the sample size. Each element is a shorter list, in which each element represents a template and outlier estimates generated by it.
}
}
\description{
This function extracts outlier estimates based on the squared root Euclidean distance between each
estimate generated by a template to its corresponding MALPACA final output. It replace the outlier
landmark coordinates in the input 4D array by NA.
}
\details{
This function also generates a pdf, each page of which is a boxplot of
distances between each estimate to the final output for one specimen, storing in a user specified directory.
Estimates generated by different templates are denoted by different colors.
The threshold, which is the red horizontal line, is by default 2*standard deviation + mean for the pooled distances
for that specimen. Points above the line represent the outlier estimates.
}
\examples{
#Please refer to the help file of 'read.malpaca.estimates' in SlicerMorphR.
}
