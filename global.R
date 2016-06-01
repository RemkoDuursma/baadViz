library(baad.data)
library(gplots)
library(scales)
library(magicaxis)

baad_all <- baad_data("1.0.0")
baad <- baad_all$data
dictio <- baad_all$dictionary

# Add variables:
# Log-transform, add Group
orig_names <- names(baad)
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
extravars <- setdiff(names(baad), orig_names)
baad_vars <- c(extravars, dictio$variable)

# Bit dangerous! Note that in within() variables are added in reverse.
baad_units <- c("kg/m2","m2/kg","kg/kg","m2/kg","m2/kg","kg/kg","kg/kg",
                "m2/m2","kg/m2","m2/m2","kg/m2",dictio$units)

extra_labels <- c("leaf mass per area (recalc.)","specific leaf area",
                  "root mass / total mass","leaf area / stem mass",
                  "leaf area / total mass","leaf mass / total mass",
                  "leaf mass / stem mass", "leaf area / stem basal area",
                  "leaf mass / stem basal area", "leaf area / stem b-h area",
                  "leaf mass / stem b-h area")

baad_vars_label <- c(extra_labels, dictio$label)
baad_vars_axis_label <- sprintf("%s (%s)", baad_vars_label, baad_units)


