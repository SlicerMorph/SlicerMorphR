#' Parse the GPA log output
#'
#' This function parse log output (analysis.json file) from the SlicerMorph's GPA
#' (General Procrustes analysis) module output. It is a revised version of the old parser, and supports the new JSON format for the output file. 
#' Parser saves everything necessary, including the output files as well as raw coordinates, in a large R object.
#' The schema for the GPA's JSON file can be found at TBD:
#' For detailed usage description: please see https://github.com/SlicerMorph/Tutorials/blob/main/GPA_3/README.md

#' @param  file An object that points to the location of the analysis.log file, either by hard coding the path or interactively via the function "file.choose()"
#' @param  forceLPS The forceLPS determines if the landmark coordinates stored in .fcsv files should be converted into LPS format in case they are saved in RAS. This should be necessary only for very old fcsv files, and never needed for landmarks saved in mrk.json format. 
#' For details of this parameter, please refer to the help file of read.markups.fcsv().
#' @return A list that contains every output of the GPA module.\cr
#' The output contains: \cr
#' \itemize{
#'   \item $input.path = Unix style path to input folder with landmark files
#'   \item $output.path = Unix stype path to the output folder created by GPA
#'   \item $files = files included in the analysis
#'   \item $format = format of landmark files ("fcsv" or "mrk.json")
#'   \item $no.LM = number of landmarks original
#'   \item $skipped = If any landmark is omitted in GPA (TRUE/FALSE)
#'   \item $skippedLM = Indices of skipped LMs (created only if $skipped=TRUE)
#'   \item $boas = is PCA conducted on GPA residuals rescaled back (i.e, Boas coordinates) (TRUE/FALSE)
#'   \item $MeanShape = filename that contains mean shape coordinates calculated by GPA (csv format)
#'   \item $eigenvalues = filename that contains eigenvalues as calculated by PCA in the SlicerMorph GPA (csv format)
#'   \item $eigenvectors = filename that contains eigenvectors as calculated by PCA in the SlicerMorph GPA (csv format)
#'   \item $OutputData = filename that contains procrustes distances, centroid sizes and procrustes aligned coordinates as calculated by the SlicerMorph GPA (csv format)
#'   \item $$pcScores = filename that contains individal PC scores of specimens as calculated by PCA in the SlicerMorph GPA (csv format)
#'   \item $ID = list of specimen identifiers (obtained from file names)
#'   \item $LM = 3D landmark array that contains the 3D raw coordinates as inputed to the SlicerMorph GPA module
#'   \item $semi = If any landmarks are tagged as semi-landmarks (TRUE/FALSE)
#'   \item $semiLM = indices of LMs tagged as semi-landmarks (created only if $semi==TRUE)
#'   \item $Covariate = Is there any covariate provided during the analysis (TRUE/FALSE)
#'   \item $CovariateFile = filename that contains the Covariates included in the analysis (csv format)

#'}
#'
#' @examples
#' SM.log.file <- file.choose() 
#' SM.log <- parser(SM.log.file, json=TRUE)
#' head(SM.log)
#' @export

parser2 = function(file=NULL, forceLPS = FALSE, json = TRUE) {
  
  cut=function(x) return(strsplit(x,"=")[[1]][2])
  is.empty <- function(x) length(x)==0
  
  temp = unlist(lapply(X=readLines(file), FUN=cut))
  log = list()
  
  if (!json) {
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
  
  # check is returned GPA coordinates are in Boas coordinates
  if (as.logical(temp[9])) log$boas=TRUE else log$boas=FALSE
  
  log$MeanShape=temp[10]
  log$eigenvalues=temp[11]
  log$eigenvectors=temp[12]
  log$OutputData=temp[13]
  log$pcScores=temp[14]
  } else {
    js = fromJSON(txt = file)
    log$input.path = js$GPALog$InputPath
    log$output.path = js$GPALog$OutputPath
    log$files = js$GPALog$Files[[1]]
    log$format = js$GPALog$LMFormat
    
    #note that these are the original number of landmarks in the files 
    #including anything that might have encoded as missing.
    log$no.LM = js$GPALog$NumberLM
    
    if (!is.empty(js$GPALog$Excluded[[1]])) {
      log$skipped = TRUE
      log$skipped.LM = js$GPALog$ExcludedLM[[1]]
    } else {
      log$skipped = FALSE
      log$skipped.LM = NULL
    }
    
    if (!is.empty(js$GPALog$SemiLandmarks[[1]])) {
      log$semi=TRUE
      log$semiLMs = js$GPALog$SemiLandmarks[[1]] 
      } else {
      log$semi= FALSE
      log$semiLMs = NULL
      }
  # skip the scaling step during GPA is no longer an option
  # hence $scale object is no longer meaningful
  # instead if set true, BOAS means PCA is conducted on Boas scaled GPA coordinates
    
    if (js$GPALog$Boas) log$boas=TRUE else log$boas=FALSE
    
    log$MeanShape = js$GPALog$MeanShape
    log$eigenvalues = js$GPALog$Eigenvalues
    log$eigenvectors = js$GPALog$Eigenvectors
    log$OutputData = js$GPALog$OutputData
    log$pcScores = js$GPALog$PCScores
    
    if (js$GPALog$Covariates != "") {
      log$Covariates=TRUE
      log$CovariateFile = js$GPALog$Covariates
    } else {
      log$Covariates=FALSE
      log$CovariateFile = NULL
    }
    
  } 
    
  log$ID=gsub(log$format, "", fixed=T, log$files )
  
  
  #start reading the original landmark coordinates:
  if (all(file.exists(paste(log$input.path, log$files, sep = "/")))) {
    if (!log$skipped) {
      log$LM = array(dim = c(log$no.LM, 3, length(log$files)), 
                     dimnames = list(1:log$no.LM, c("x", "y", "z"), log$ID))
      if (log$format == ".fcsv") 
        for (i in 1:length(log$files)) log$LM[, , i] = read.markups.fcsv(paste(log$input.path, 
                                                                               log$files[i], sep = "/"), forceLPS)
      else for (i in 1:length(log$files)) log$LM[, , i] = read.markups.json(paste(log$input.path, 
                                                                                  log$files[i], sep = "/"))
    }
    else {
      log$LM = array(dim = c(log$no.LM - length(log$skipped.LM), 
                             3, length(log$files)), dimnames = list((1:log$no.LM)[-as.numeric(log$skipped.LM)], 
                                                                    c("x", "y", "z"), log$ID))
      if (log$format == ".fcsv") 
        for (i in 1:length(log$files)) log$LM[, , i] = read.markups.fcsv(paste(log$input.path, 
                                                                               log$files[i], sep = "/"), forceLPS)[-c(as.numeric(log$skipped.LM)), 
                                                                               ]
      else for (i in 1:length(log$files)) log$LM[, , i] = read.markups.json(paste(log$input.path, 
                                                                                  log$files[i], sep = "/"))[-c(as.numeric(log$skipped.LM)), 
                                                                                  ]
    }
  } else stop("not all original landmark files are found. Make sure you didn't modify their location after you executed GPA in SliceMorph. Can't continue.")    
  
  
  return(log)
  
}
