#' Export landmark data into FCSV file
#'
#' This function export landmark coordinates into an FCSV file
#' a fcsv file,
#' @param pts a matrix that contains landmark coordinates; nrow = number of coordinates; ncol = dimensions
#' @param outfile this parameter specifies a file to be created
#' @return a FCSV file of morphometric data
#' @export
write.markups.fcsv = function(pts=NULL, outfile=NULL){
  
  temp = "# Markups fiducial file version = 4.13\n# CoordinateSystem = LPS\n# columns = id,x,y,z,ow,ox,oy,oz,vis,sel,lock,label,desc,associatedNodeID\n"
  
  if (length(rownames(pts))==0) {
    for (i in 1:nrow(pts)) 
      temp = paste0(temp, '\n',
                    paste(paste0("vtkMRMLMarkupsFiducialNode_", i-1), 
                          pts[i,1],
                          pts[i,2], 
                          pts[i,3],
                          paste(rep(0,3), collapse=','), 
                          paste(rep(1,4), collapse=','), 
                          paste0("F-", i),
                          paste(rep("",2), collapse=','), 
                          sep=','))
    
    cat (temp, file = outfile)
  } else {
    labels=rownames(pts)
    for (i in 1:nrow(pts)) 
      temp = paste0(temp, '\n',
                    paste(paste0("vtkMRMLMarkupsFiducialNode_", i-1), 
                          pts[i,1],
                          pts[i,2], 
                          pts[i,3],
                          paste(rep(0,3), collapse=','), 
                          paste(rep(1,4), collapse=','), 
                          paste(labels[i]),
                          paste(rep("",2), collapse=','), 
                          sep=','))
    
    cat (temp, file = outfile)
  }
}