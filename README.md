# tif2gif

## Purpose

This package contains a function which allows the user to turn a folder of TIF files in an animated GIF file. It is a wrapper for the animation functions from tmap with file name flexibility and iterative use in mind.   

## Installation

To use this package, run these lines:
library(devtools)
devtools::install_github("laurenaceae/tif2gif", build_vignettes = TRUE)
library(tif2gif)

Building the vignettes is optional and the default is FALSE, but this vignette contains some helpful examples of use and of possible outputs. To view the vignette, run these lines:
vignette("tif_to_gif_vignette")

## Usage

tif2gif::tif_to_gif(prefix, suffix, output_name, output_location, path_to_folder, frames_per_sec = 1, colors = "Purples")
