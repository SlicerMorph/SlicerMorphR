write.markups.json = function (pts = NULL, outfile = NULL) 
{
  noLM = nrow(pts)
  if (length(dimnames(pts)[[1]]) > 0) 
    labels = dimnames(pts)[[1]]
  else labels = paste("F", 1:noLM, collapse = "-")
  points = list()
  
  for (i in 1:noLM) { 
    if (!all(is.na(as.numeric(pts[i,])))) {
                                       points[[i]] = list(id = i, 
                                       label = labels[i], 
                                       position = as.numeric(pts[i, ]), 
                                       orientation = c(-1.0, -0.0, -0.0, -0.0, -1.0, -0.0, 0.0, 0.0, 1.0), 
                                       selected = TRUE, 
                                       locked = FALSE, 
                                       visibility = TRUE, 
                                       positionStatus = "defined") 
                                       } else {
                                                points[[i]] = list(id = i, 
                                                label = labels[i], 
                                                position = as.numeric(pts[i, ]), 
                                                orientation = c(-1.0, -0.0, -0.0, -0.0, -1.0, -0.0, 0.0, 0.0, 1.0), 
                                                selected = TRUE, 
                                                locked = FALSE, 
                                                visibility = TRUE, 
                                                positionStatus = "missing") 
                                       }
  }
  
  display = list(visibility = TRUE,
                 opacity = 1.0,
                 color = c(0.4, 1.0, 1.0), 
                 selectedColor = c(1.0, 0.50000, 0.50000), 
                 activeColor = c(0.4, 1.0, 0.0),
                 propertiesLabelVisibility = FALSE,
                 pointLabelsVisibility = TRUE,
                 textScale = 3.0,
                 glyphType = "Sphere3D",
                 glyphScale = 3.0,
                 glyphSize = 5.0,
                 useGlyphScale = TRUE)
  
  markup = list(type = "Fiducial", 
                coordinateSystem = "LPS", 
                coordinateUnits = "mm", 
                locked = TRUE, 
                fixedNumberOfControlPoints = TRUE, 
                controlPoints = points,
                display = display)
  
  markups = list(markup)
  data = list(`@schema` = "https://raw.githubusercontent.com/slicer/slicer/master/Modules/Loadable/Markups/Resources/Schema/markups-schema-v1.0.3.json#", 
              markups = markups)
  cat(jsonlite::toJSON(data, auto_unbox = TRUE, pretty = TRUE, digits=NA, always_decimal=TRUE), 
      file = outfile)
}
