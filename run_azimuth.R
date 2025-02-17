# Load necessary libraries
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}
if (!requireNamespace("Seurat", quietly = TRUE)) {
  install.packages("Seurat")
}
if (!requireNamespace("Azimuth", quietly = TRUE)) {
  remotes::install_github("satijalab/azimuth", ref = "master")
}
if (!requireNamespace("SeuratDisk", quietly = TRUE)) {
  remotes::install_github("mojaveazure/seurat-disk")
}

# Load required libraries
library(Seurat)
library(Azimuth)
library(reticulate)
library(SeuratDisk)

# Set file paths
input_h5ad <- "C:\\Users\\Digvi\\Documents\\assignment\\cann_assessment\\Mouse_brain.h5ad"

# Convert h5ad to h5Seurat (SeuratDisk is required for this step)
Convert(input_h5ad, dest = "h5seurat", overwrite = TRUE, assay = "RNA")
seurat_obj <- LoadH5Seurat(gsub(".h5ad", ".h5Seurat", input_h5ad))


# Run Azimuth annotation
seurat_obj <- Azimuth::RunAzimuth(seurat_obj, reference = "mousecortexref")

# Save the annotated Seurat object back to h5ad
SaveH5Seurat(seurat_obj, filename = "C:\\Users\\Digvi\\Documents\\assignment\\cann_assessment\\annotated_Mouse_brain.h5Seurat")
Convert("C:\\Users\\Digvi\\Documents\\assignment\\cann_assessment\\annotated_Mouse_brain.h5Seurat", dest = "h5ad", overwrite = TRUE)
