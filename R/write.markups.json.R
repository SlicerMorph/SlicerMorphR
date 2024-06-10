write.markups.json = function (pts = NULL, outfile = NULL) {

  header = '{
    "@schema": "https://raw.githubusercontent.com/slicer/slicer/master/Modules/Loadable/Markups/Resources/Schema/markups-schema-v1.0.3.json#",
    "markups": [
        {
            "type": "Fiducial",
            "coordinateSystem": "LPS",
            "coordinateUnits": "mm",
            "locked": true,
            "fixedNumberOfControlPoints": true,
            "controlPoints": ['

  footer = ']}]}'

  ctrl.point = '{
          "id": "id1",
          "label": "label1",
          "description": "",
          "associatedNodeID": "",
          "position": [0, 0, 0],
          "orientation": [-1.0, -0.0, -0.0, -0.0, -1.0, -0.0, 0.0, 0.0, 1.0],
          "selected": true,
          "locked": false,
          "visibility": true,
          "positionStatus": "defined"
        }'

  if (length(dimnames(pts)[[1]]) > 0) labels = dimnames(pts)[[1]]
  noLM = nrow(pts)

  writeLines(header, con = outfile)
  for (i in 1:(noLM-1)) {
    temp =  sub("id1", i, ctrl.point)
    temp =  sub("label1", labels[i], temp)
    temp = sub("0, 0, 0", paste(pts[i,], collapse=", "), temp)
    cat(c(temp, ","), sep="", file=outfile, append = TRUE, fill=TRUE )
  }
  temp =  sub("id1", noLM, ctrl.point)
  temp =  sub("label1", labels[noLM], temp)
  temp = sub("0, 0, 0", paste(pts[noLM,], collapse=", "), temp)
  #cat('{ "label": ', '"', labels[i],'" ,', ' "position": [', paste(pts[i,], collapse=", "), '] },', sep="", file=outfile, append = TRUE, fill=TRUE )
  cat(temp, sep="", file=outfile, append = TRUE, fill=TRUE )
  cat(footer, file=outfile, append=TRUE)

}