#' Export landmark data into FCSV file
#'
#' This function export landmark coordinates into an FCSV file
#' By default coordinates are assumed to be written in LPS, but can be change to RAS using the @param coord option.
#' a fcsv file,
#' @param pts a matrix/array that contains landmark coordinates \cr
#' nrow = number of coordinates \cr
#' ncol = dimensions \cr
#' Row names are assigned from the labels in the FCSV file  \cr
#' Column names are assigned as "x", "y", and "z", depending on the dimension  \cr
#' @param outfile this parameter specifies a file to be created (e.g., a directory leads to a particular FCSV file; see example)
#' @return A FCSV file of morphometric data\cr
#' The label for each landmark is the rowname of the input landmark matrix
#' @examples
#' lms = read.markups.fcsv(file = url("https://raw.githubusercontent.com/SlicerMorph/SampleData/master/Gorilla_template_LM1.fcsv"))
#' write.markups.fcsv(pts=lms, outfile = "Your_Directory/test.fcsv", coord="LPS")
#' @export

write.markups.fcsv = function (pts = NULL, outfile = NULL, coord="LPS") {

  if (toupper(coord) == "LPS") {  
      temp = "# Markups fiducial file version = 4.13\n# CoordinateSystem = LPS\n# columns = id,x,y,z,ow,ox,oy,oz,vis,sel,lock,label,desc,associatedNodeID"
      if (length(rownames(pts)) == 0) {
        for (i in 1:nrow(pts)) temp = paste0(temp, "\n", paste(paste0("vtkMRMLMarkupsFiducialNode_", 
                                                                      i - 1), pts[i, 1], pts[i, 2], pts[i, 3], paste(rep(0, 
                                                                                                                         3), collapse = ","), paste(rep(1, 4), collapse = ","), 
                                                               paste0("F-", i), paste(rep("", 2), collapse = ","), 
                                                               sep = ","))
        cat(temp, file = outfile)
      }
      else {
        labels = rownames(pts)
        for (i in 1:nrow(pts)) temp = paste0(temp, "\n", paste(paste0("vtkMRMLMarkupsFiducialNode_", 
                                                                      i - 1), pts[i, 1], pts[i, 2], pts[i, 3], paste(rep(0, 
                                                                                                                         3), collapse = ","), paste(rep(1, 4), collapse = ","), 
                                                               paste(labels[i]), paste(rep("", 2), collapse = ","), 
                                                               sep = ","))
        cat(temp, file = outfile)
      }
  } else if (toupper(coord) == "RAS") {  
    temp = "# Markups fiducial file version = 4.13\n# CoordinateSystem = RAS\n# columns = id,x,y,z,ow,ox,oy,oz,vis,sel,lock,label,desc,associatedNodeID\n"
    if (length(rownames(pts)) == 0) {
      for (i in 1:nrow(pts)) temp = paste0(temp, "\n", paste(paste0("vtkMRMLMarkupsFiducialNode_", 
                                                                    i - 1), pts[i, 1], pts[i, 2], pts[i, 3], paste(rep(0, 
                                                                                                                       3), collapse = ","), paste(rep(1, 4), collapse = ","), 
                                                             paste0("F-", i), paste(rep("", 2), collapse = ","), 
                                                             sep = ","))
      cat(temp, file = outfile)
    }
    else {
      labels = rownames(pts)
      for (i in 1:nrow(pts)) temp = paste0(temp, "\n", paste(paste0("vtkMRMLMarkupsFiducialNode_", 
                                                                    i - 1), pts[i, 1], pts[i, 2], pts[i, 3], paste(rep(0, 
                                                                                                                       3), collapse = ","), paste(rep(1, 4), collapse = ","), 
                                                             paste(labels[i]), paste(rep("", 2), collapse = ","), 
                                                             sep = ","))
      cat(temp, file = outfile)
    }
  } else print("unsupported Coordinate System")
  
}
