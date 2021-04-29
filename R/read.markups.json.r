#' Import a JSON file into R
#'
#' This function imports a JSON file into R. It utilizes function "fromJSON" from the package
#' "jsonlite" to read a JSON file.
#' @param file The file path that leads to a particular JSON file.
#' @return An array/matrix that contains the landmark coordinates. \cr
#' Row numbers = number of landmarks;  \cr
#' Column numbers = dimensions of the landmark coordinates  \cr
#' Row names are assigned from the labels in the FCSV file  \cr
#' Column names are assigned as "x", "y", and "z", depending on the dimension  \cr
#' @examples
#' lms = read.markups.json(file = url("https://raw.githubusercontent.com/SlicerMorph/SampleData/master/Gorilla_template_LM1.json"))
#' #Return a 41x3 matrix; rownames = labels in the FCSV file; colnames = "x", "y", "z"
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
