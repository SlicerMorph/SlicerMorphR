#' Import a JSON file into R
#'
#' This function imports a JSON file into R. It utilizes function "fromJSON" from the package
#' "jsonlite" to read a JSON file.
#' @param file the file path that leads to a particular JSON file.
#' @return an array that contains the landmark coordinates. The dimensions are specified by dimnames x, y, and z.
#' @export
read.markups.json = function(file=NULL){
  if (!require(jsonlite)) {
    print("installing jsonlite")
    install.packages('jsonlite')
    library(jsonlite)
  }
  dat = fromJSON(file, flatten=T)
  n=length(dat$markups$controlPoints[[1]]$position)
  labels = dat$markups$controlPoints[[1]]$label
  temp = array(dim = c(n, 3), dimnames=list(labels, c("X", "Y", "Z")))
  for (i in 1:n) temp[i,] = dat$markups$controlPoints[[1]]$position[[i]]
  return(temp)
}
