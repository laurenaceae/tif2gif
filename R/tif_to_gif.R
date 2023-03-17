#' @title tif_to_gif
#' @param prefix = the prefix of your files of interest, is optional 
#' @param frames_per_sec = how fast you want the gif to go (in frames per second), is optional 
#' @param path_to_folder = the location of all tiff files, is required
#' @param output_name = the name of the output file will be: output_name + _ + prefix (if present) + .gif, is required
#' @param output_location = the file path to place the gif in (compatible with here), is required  
#' @param colors = the color palette for your GIF
#' @return GIF file made from your TIF files
#' @author Lauren Harris
library(raster)
library(gtools)
library(here)
library(raster)
library(tmap)
tif_to_gif <- function(prefix, frames_per_sec = 1, path_to_folder, output_location, output_name, colors = "Purples"){
  if(missing(prefix)){pattern_here = '.tif$'}
  else{pattern_here = c(paste0(prefix,"."), '.tif$')}
  tif_list <- gtools::mixedsort(list.files(path = path_to_folder, pattern=pattern_here, all.files=TRUE, full.names=TRUE,),decreasing = TRUE)
  lapply(tif_list,raster)
  all_tifs <- raster::stack(tif_list)
  b_tifs <- raster::brick(all_tifs)
  anim <- tmap::tm_shape(b_tifs) + tmap::tm_raster(palette = colors) + tmap::tm_facets(nrow = 1, ncol = 1)
  if(missing(prefix)){output_file_name <- paste0(output_name, ".gif")}
  else{output_file_name <- paste0(output_name, "_", prefix, ".gif")}
  tmap_animation(anim, fps = frames_per_sec, filename = paste0(output_location, "/", output_file_name))
}