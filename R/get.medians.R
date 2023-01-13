#' Calculate median landmark coordinates based on separate landmark sets
#'
#' This function returns the median landmark estimates based on separate landmark sets.
#' It is useful to calculate median estimates based on ALPACA estimates of individual templates.
#'
#' @param AllLMs A 4d array that store separate landmark sets with corresponding landmarks and identical samples.
#' @param outlier.NA A boolean variable determines whether there is NA (TRUE) or not (FALSE).
#' @return A 3D array that contains median landmark coordinates \cr
#'
#' @examples
#' #Please refer to the help file of 'read.malpaca.estimates' in SlicerMorphR to see how this function calculates median estimates.
#' @export


get.medians <- function(AllLMs, outlier.NA = FALSE){
  LM_number <- dim(AllLMs)[1]
  sample_size <- dim(AllLMs)[4]
  #New medians after removing outlier estimates (setting their values as NA)
  medians <- array(dim = c(LM_number, 3, sample_size))
  for (i in 1:sample_size){
    median_i <- apply(AllLMs[, , , i], 1:2, median, na.rm = outlier.NA)
    medians[, , i] <- median_i
  }
  return (medians)
}





