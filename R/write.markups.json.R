write.markups.json = function (pts = NULL, outfile = NULL) {
  
  noLM = nrow(pts)
  if (length(dimnames(pts)[[1]]) > 0) labels = dimnames(pts)[[1]] else labels = paste("F", 1:noLM, collapse="-")
  
  points = list()
  
  for (i in 1:noLM) points[[i]] = list(id = i,
                                       label = labels[i],
                                       position = unlist(pts[i,]),
                                       orientation = "[-1.0, -0.0, -0.0, -0.0, -1.0, -0.0, 0.0, 0.0, 1.0]",
                                       selected = TRUE,
                                       locked =  FALSE,
                                       visibility= TRUE,
                                       positionStatus = "defined")
  markup = list(
    type= "Fiducial",
    coordinateSystem= "LPS",
    coordinateUnits= "mm",
    locked= TRUE,
    fixedNumberOfControlPoints= TRUE,
    #controlPoints = controlPoints
    controlPoints = points
  )
  
  markups = list(
    markup
  )
  
  data = list(
    "@schema"="https://raw.githubusercontent.com/slicer/slicer/master/Modules/Loadable/Markups/Resources/Schema/markups-schema-v1.0.3.json#",
    markups=markups
  )
  
  cat(jsonlite::toJSON(data, auto_unbox=TRUE, pretty=TRUE), file = outfile)
}
