#' Calculate the root mean square (RMSE) and landmark distances for a specimen (a landmark matrix/array)
#'
#' This function calculates the root mean square (RMSE) and landmark distances for a specimen (a landmark matrix/array)
#' to a reference specimen (e.g., a mean shape or a manually landmarked specimen)
#' @param Matrix_test A matrix or 2d array storing landmark coordinates of a specimen
#' @param Matrix_ref A matrix or 2d array storing landmark coordinates of a reference specimen
#' @return A list that contains the RMSE of the specimen as well as pairwise landmark distances \cr
#' between the specimen and the reference \cr
#' The returned value contains: \cr
#' \itemize {
#'   \item $LM_distances = all pairwise landmark distances between a specimen and a reference
#'   \item $RMSE = the RMSE value between a specimen and a reference
#' }
#'
#' @examples
#' create two 3D LM coordinates:
#' x=NULL
#' for (i in 1:5) x=rbind(x, c(0,0,i))
#' x
#' [,1] [,2] [,3]
#' [1,]    0    0    1
#' [2,]    0    0    2
#' [3,]    0    0    3
#' [4,]    0    0    4
#' [5,]    0    0    5
#' y=NULL
#' for (i in 5:1) y=rbind(y, c(0,0,i))
#' rmse(x,y)
#' $LM_distances
#' [1] 4 2 0 2 4
#' $RMSE
#' [1] 2.828427
#' @export

rmse <- function(M1, M2){
  #Returns the RMSE between two LM matrices as well as Euclidean distances between corresponding LM pairs
  sq_diff <- (M1 - M2)^2
  sq_LM_dist <- rowSums(sq_diff) #a vector storing squared distances between LM pairs
  RMSE <- sqrt(mean(sq_LM_dist))
  result <- list("LM_distances" = sqrt(sq_LM_dist), "RMSE" = RMSE)
  return(result)
}
