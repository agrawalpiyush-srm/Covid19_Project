# Prepare semantic data to measure GO similarity
init.gosemsim <- function(ont = "BP" ) {
  require(org.Hs.eg.db)
  require(GOSemSim)
  hsGO <- godata('org.Hs.eg.db', ont=ont)
  return(hsGO)
}

# Semantic similarity between two sets of GO terms
# @param meas: method for the semantic similarity between two GO terms. By default, the Wang method is used 
# @param comb: semantic similarity between two sets of GO terms. By default, 'rcmax' is used
getResult <- function(GO1, GO2, sem, meas="Wang", comb="rcmax" ){
  return(mgoSim(GO1, GO2, semData=sem, measure=meas, combine=comb))
}
