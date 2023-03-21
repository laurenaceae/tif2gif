#' tif_to_gif: Create an animated GIF file from a folder of TIF files
#'
#' This function allows the user to generate a GIF from a folder of TIF files. Required inputs are the file paths for the input TIFs and the output GIF, and a name to use as a prefix for the output GIF.
#' @name tif_to_gif
#' @param prefix The prefix of your TIF files (argument optional)
#' @param suffix The suffix of your TIF files before the file extension (argument optional)
#' @param frames_per_sec How fast you want the GIF to go aka frames per second (argument optional)
#' @param path_to_folder The location of all TIF files (argument required)
#' @param output_name The name of the output file will be: output_name + _ + prefix (if present) + suffix (if present) + .gif. (argument required)
#' @param output_location The file path to place the GIF in (argument required)
#' @param colors The color palette for your GIF (argument optional)
#' @return A single GIF file made from your TIF files
#' @author Lauren Harris

tif_to_gif <- function(prefix, suffix, frames_per_sec = 1, path_to_folder, output_location, output_name, colors = "Purples"){
  # error checking to see if it is missing required inputs
  if(missing(output_name) == TRUE){stop("Missing variable output_name")}
  if(missing(path_to_folder) == TRUE){stop("Missing file path")}
  if(missing(output_location) == TRUE){stop("Missing output file location")}
  # file matching pattern with optional prefix and suffix
  if(missing(prefix) & missing(suffix)){pattern_here = '.tif$'}
  if(missing(prefix)){pattern_here = paste0(".*", suffix, "\\.tif$")}
  if(missing(suffix)){pattern_here = c(paste0(prefix,".*", ".tif$"))}
  else{pattern_here = c(paste0(prefix,".*", suffix, "\\.tif$"))}
  # find the files and sort them into a list
  tif_list <- gtools::mixedsort(list.files(path = path_to_folder, pattern=pattern_here, all.files=TRUE, full.names=TRUE,),decreasing = TRUE)
  # convert all files to raster
  lapply(tif_list,raster::raster)
  # brick and stack the rasters
  all_tifs <- raster::stack(tif_list)
  b_tifs <- raster::brick(all_tifs)
  # animate using tmap
  anim <- tmap::tm_shape(b_tifs) + tmap::tm_raster(palette = colors) + tmap::tm_facets(nrow = 1, ncol = 1)
  # create output file names based on optional prefix and suffix
  if(missing(prefix)){output_file_name <- paste0(output_name, "_", suffix, ".gif")}
  if(missing(suffix)){output_file_name <- paste0(output_name, "_", prefix, ".gif")}
  if(missing(prefix) & missing(suffix)){output_file_name <- paste0(output_name, "_", prefix, "_", suffix, ".gif")}
  else{output_file_name <- paste0(output_name, "_", prefix, "_", suffix, ".gif")}
  # create gif output
  tamp::tmap_animation(anim, fps = frames_per_sec, filename = paste0(output_location, "/", output_file_name))
}
