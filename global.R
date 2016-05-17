library(baad.data)
library(gplots)
library(scales)
library(magicaxis)

baad_all <- baad_data("1.0.0")
baad <- baad_all$data
dictio <- baad_all$dictionary

# Add variables:
# Log-transform, add Group
baad <- within(baad, {
  
  mlf_astbh <- m.lf/a.stbh
  alf_astbh <- a.lf/a.stbh
  mlf_astba <- m.lf/a.stba
  alf_astba <- a.lf/a.stba
  mlf_mst <- m.lf / m.st
  mlf_mso <- m.lf / m.so
  alf_mso <- a.lf / m.so
  alf_mst <- a.lf / m.st
  mrt_mso <- m.rt / m.so
  
  sla <- a.lf / m.lf
  lma <- m.lf / a.lf
  
})
extravars <- names(baad)[ncol(baad):(ncol(baad)-10)]
baad_vars <- c(extravars, dictio$variable)
baad_vars_label <- c(extravars, dictio$label)
