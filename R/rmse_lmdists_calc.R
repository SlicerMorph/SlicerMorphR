#' Calculate the root mean square (RMSE) and landmark distances for a specimen (a landmark matrix/array)
#'
#' This function calculates the root mean square (RMSE) and landmark distances for a specimen (a landmark matrix/array)
#' to a reference specimen (e.g., a mean shape or a manually landmarked specimen)
#' @param Matrix_test A matrix or 2d array storing landmark coordinates of a specimen
#' @param Matrix_ref A matrix or 2d array storing landmark coordinates of a reference specimen
#' @return A list that contains the RMSE of the specimen as well as pairwise landmark distances \cr
#' between the specimen and the reference \cr
#' The returned value contains:
#' \itemize {
#'   \item $LM_distances = all pairwise landmark distances between a specimen and a reference
#'   \item $RMSE = the RMSE value between a specimen and a reference
#' }
#' @examples
#' results <- LMDists_RMSE_per_specimen(specimen1_matrix, mean_matrix)
#' @export

LMDists_RMSE_per_specimen <- function(Matrix_test, Matrix_ref){
  #Return the RMSE for each between a test landmark matrix/array and the landmark matrix/array serving as the standard
  #Return individual landmark Euclidean distances
  diff <- (Matrix_test - Matrix_ref)^2
  LM_distances <- rowSums(diff) #a vector storing individual LM distance vs. the GS
  LM_number <- dim(Matrix_test)[1]
  RMSE <- sqrt(sum(LM_distances)/LM_number)
  result <- list("LM_distances" = LM_distances, "RMSE" = RMSE)
  return(result)
}
