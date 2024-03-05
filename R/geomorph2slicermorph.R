geomorph2slicermorph = function(gpa=NULL,
                                pca=NULL,
                                output.folder=NULL) {
  
  #check whether data is 3D
  if (dim(gpa$consensus)[2] !=3) {
    print("data are not 3D. SlicerMorph requires 3D data")
    stop()
  } else if (!dir.exists(output.folder)) dir.create(output.folder)
  
  no.LM = dim(gpa$consensus)[1]
  temp = cbind(paste("LM", 1:no.LM), gpa$consensus)
  write.csv(file=paste0(output.folder, '/MeanShape.csv'), 
            temp, row.names = FALSE, quote = FALSE)
  
  #write pcScores.csv file
  temp = pca$x
  f = dimnames(gpa$coords)[[3]]
  temp = cbind(f, temp)
  dimnames(temp)[[2]] = c("Sample_name", paste("PC", 1:(dim(temp)[2]-1)))
  
  write.table(file=paste0(output.folder, '/pcScores.csv'), 
              temp, row.names = FALSE, sep=',', quote = FALSE)
  
  #write the OutputData.csv file
  #but we need the procrustes distance from mean
  
  pd <- function(M, A) sqrt(sum(rowSums((M-A)^2)))
  PD = NULL
  for (i in 1:length(f)) PD[i] <- pd(gpa$consensus, gpa$coords[,, i])
  temp = cbind(PD, gpa$Csize, two.d.array(gpa$coords))
  
  
  lm.labels=NULL
  for (i in 1:no.LM) lm.labels=c(lm.labels, paste0("LM ", rep(i,3), c("_X", "_Y", "_Z")))
  
  header=c("Sample_name","proc_dist","centeroid", lm.labels)
  file=paste0(output.folder, '/OutputData.csv')
  writeLines(con=file, paste(header, collapse=','))
  for (i in 1:nrow(temp)) cat(file=file, paste(f[i], paste(temp[i,], collapse=','), sep=","), sep="\n", append=TRUE)
  
  #write eigenvalues.csv file 
  temp = cbind(paste("PC", 1:dim(pca$x)[2]), as.vector(pca$d))
  file=paste0(output.folder, '/eigenvalues.csv')
  for (i in 1:nrow(temp)) cat(file=file, paste(temp[i,], collapse=','), sep="\n", append=TRUE )
  
  #write eigenvector.csv file
  temp = t(pca$rotation)
  file=paste0(output.folder, "/eigenvector.csv")
  cat(file=file, paste(c("", paste("PC", 1:dim(temp)[1])), collapse=","), sep="\n")
  t1=gsub('.', "_", colnames(temp), fixed=TRUE)
  
  for (i in 1:nrow(temp)) cat(file=file, paste(t1[i], paste(temp[i,], collapse=','), sep=','), sep="\n", append=TRUE)
  
  #write analysis.log
  header=c(paste0("Date=",Sys.Date()), 
           paste0("Time=", strsplit(as.character(Sys.time()), split = " ")[[1]][2]), 
           "InputPath=NULL", 
           "OutputPath=NULL", 
           "LM_format=.fcsv",
           "NumberLM=",
           "ExcludedLM=",
           "Scale=True",
           "MeanShape=MeanShape.csv",
           "eigenvalues=eigenvalues.csv",
           "eigenvectors=eigenvectors.csv",
           "OutputData=OutputData.csv",
           "pcScores=pcScores.csv",
           "SemiLandmarks=")
  file=paste0(output.folder, "/analysis.log")
  
  for (i in 1:length(header)) cat(file=file, paste(header[i]), sep="\n", append=TRUE)
  
}
  
  