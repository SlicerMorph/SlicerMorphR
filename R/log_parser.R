#' Parse the GPA log output
#'
#' This function parse log output (analysis.log file) from the SlicerMorph's GPA
#' (General Procrustes analysis) module output.Parser saves everything necessary,
#' including the output files as well as raw coordinates, in a large R object.
#' These output files are shown in the analysis.log file.
#' For details: please see https://github.com/SlicerMorph/Tutorials/blob/main/GPA_3/README.md
#' @param  file an object that points to the location of the analysis.log file, either by hard coding the path or interactively via the function "file.choose()"
#' @return A list that contains every output of the GPA module.
#' @examples 
#' SM.log.file <- file.choose()
#' SM.log <- parser(SM.log.file)
#' head(SM.log)
#' @export

parser = function(file=NULL){
  cut=function(x) return(strsplit(x,"=")[[1]][2])
  temp = unlist(lapply(X=readLines(file), FUN=cut))
  log = list()

  log$input.path = temp[3]
  log$output.path = temp[4]
  log$files = unlist(strsplit(temp[5],','))
  #log$format =  substr(temp[6], start=2, stop = nchar(temp[6]))
  log$format =  temp[6]
  log$no.LM = as.numeric(temp[7])

  # checking if any LMs are skipped
  if (is.na(temp[8])) log$skipped=FALSE else {
    log$skipped=TRUE
    log$skipped.LM=unlist(strsplit(temp[8],","))
  }

  # parsing if any landmarks are tagged as semiLMs

  if (is.na(temp[15])) log$semi=FALSE else {
    log$semi=TRUE
    log$semiLMs=unlist(strsplit(temp[15],","))
  }

  # checking if scaling to centroid size is disabled during GPA
  if (as.logical(temp[9])) log$scale=TRUE else log$scale=FALSE

  log$MeanShape=temp[10]
  log$eigenvalues=temp[11]
  log$eigenvectors=temp[12]
  log$OutputData=temp[13]
  log$pcScores=temp[14]
  log$ID=gsub(log$format, "", fixed=T, log$files )

  if (!log$skipped) {
    log$LM = array(dim =c (log$no.LM, 3, length(log$files)),
                   dimnames = list(1:log$no.LM, c("x", "y", "z"), log$ID))
    if (log$format=="fcsv") for (i in 1:length(log$files)) log$LM[,,i] = read.markups.fcsv(paste(log$input.path,log$files[i],sep = "/")) else
      for (i in 1:length(log$files))  log$LM[,,i] = read.markups.json(paste(log$input.path,log$files[i],sep = "/"))
  } else {
    log$LM = array(dim = c(log$no.LM - length(log$skipped.LM), 3, length(log$files)),
                   dimnames = list((1:log$no.LM)[-as.numeric(log$skipped.LM)], c("x", "y", "z"), log$ID))
    if (log$format=="fcsv") for (i in 1:length(log$files)) log$LM[,,i] = read.markups.fcsv(paste(log$input.path,log$files[i],sep = "/"))[-c(as.numeric(log$skipped.LM) ), ] else
      for (i in 1:length(log$files)) log$LM[,,i] = read.markups.json(paste(log$input.path,log$files[i],sep = "/"))[-c(as.numeric(log$skipped.LM) ), ]

  }

  return(log)

}
