#get data
require(synapseClient)
synapseLogin()

require(dplyr)
require(data.table)

ecoliObj <- synGet('syn2787234')
ecoliExpr <- fread(ecoliObj@filePath,data.table=F,header=T) %>% data.frame

ecoliExperObj<-synGet('syn3130846')
ecoliExper <- fread(ecoliExperObj@filePath,data.table=F,header=T)

ecoliGeneNamesObj <- synGet('syn2787232')
ecoliGeneNames <- fread(ecoliGeneNamesObj@filePath,data.table=F,header=T)

tfNamesObj <- synGet('syn2787235')
tfNames <- fread(tfNamesObj@filePath,data.table=F,header=T)

#rownames(ecoliExpr) <- ecoliGeneNames[,1]
#ecoliExpr <- t(ecoliExpr)
ecoliExpr <- scale(ecoliExpr)
ecoliTFs <- ecoliExpr[,tfNames[,1]]
library(metanetwork)

foo <- regressionEnsemble(y=ecoliExpr[,1],x=ecoliTFs)
boo <- synGet('syn2787243')
goldStandard <- fread(boo@filePath,data.table=F,header=F)


