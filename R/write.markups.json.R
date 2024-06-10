

write.markups.json = function (pts = NULL, outfile = NULL, locked=TRUE) {
  
  header = '{"@schema": "https://raw.githubusercontent.com/Slicer/Slicer/main/Modules/Loadable/Markups/Resources/Schema/markups-schema-v1.0.0.json#",
  "markups": [{"type": "Fiducial", "coordinateSystem": "LPS", "controlPoints": ['
  footer = ']}]}'
  
  writeLines(header, con = outfile)  
  
  if (length(dimnames(pts)[[1]]) > 0) labels = dimnames(pts)[[1]]
  noLM = nrow(pts)
  ll=NULL
  for (i in 1:(noLM-1)) ll = cat('{ "label": ', '"', labels[i],'" ,', ' "position": [', paste(pts[i,], collapse=", "), '] },', sep="", file=outfile, append = TRUE, fill=TRUE )
  cat('{ "label": ', '"', labels[noLM],'" ,', ' "position": [', paste(pts[noLM,], collapse=", "), '] }', sep="", file=outfile, append = TRUE, fill = TRUE )
  cat(footer, file=outfile, append=TRUE)
    
}
