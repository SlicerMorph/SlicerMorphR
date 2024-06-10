### Sample markup file
{
  "@schema": "https://raw.githubusercontent.com/slicer/slicer/master/Modules/Loadable/Markups/Resources/Schema/markups-schema-v1.0.3.json#",
  "markups": [
    {
      "type": "Fiducial",
      "coordinateSystem": "LPS",
      "coordinateUnits": "mm",
      "locked": true,
      "fixedNumberOfControlPoints": true,
      "controlPoints": [
        {
          "id": "1",
          "label": "Locked",
          "description": "",
          "associatedNodeID": "",
          "position": [-661.8345053017131, -0.0, -29.47441116728276],
          "orientation": [-1.0, -0.0, -0.0, -0.0, -1.0, -0.0, 0.0, 0.0, 1.0],
          "selected": true,
          "locked": false,
          "visibility": true,
          "positionStatus": "defined"
        },
        {
          "id": "2",
          "label": "Invisible",
          "description": "",
          "associatedNodeID": "",
          "position": [-673.3707775970707, -15.319816767053146, -30.31662555615479],
          "orientation": [-1.0, -0.0, -0.0, -0.0, -1.0, -0.0, 0.0, 0.0, 1.0],
          "selected": true,
          "locked": false,
          "visibility": false,
          "positionStatus": "defined"
        }
      ]
    }
  ]
}

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
            "controlPoints": [
                {
                    "id": "1",
                    "label": '
  
  footer = ']}]}'
  
  if (length(dimnames(pts)[[1]]) > 0) labels = dimnames(pts)[[1]]
  noLM = nrow(pts)
  
  writeLines(header, con = outfile)  
  for (i in 1:(noLM-1)) cat('{ "label": ', '"', labels[i],'" ,', ' "position": [', paste(pts[i,], collapse=", "), '] },', sep="", file=outfile, append = TRUE, fill=TRUE )
  cat('{ "label": ', '"', labels[noLM],'" ,', ' "position": [', paste(pts[noLM,], collapse=", "), '] }', sep="", file=outfile, append = TRUE, fill = TRUE )
  cat(footer, file=outfile, append=TRUE)
    
}
