AnnData (H5AD) file :  https://drive.google.com/file/d/1epWwuZeNcIWpU5MTWJFnlSYWhusEBPdN/view?usp=sharing

# Cann Assessment

This project is designed to run Azimuth annotation on a Seurat object and analyze the results using a Jupyter Notebook. The script `run_azimuth.R` performs the following steps:
1. Loads necessary libraries.
2. Converts an h5ad file to an h5Seurat file.
3. Runs Azimuth annotation on the Seurat object.
4. Saves the annotated Seurat object back to an h5ad file.

The Jupyter Notebook `test.ipynb` is used to load the annotated data, check available metadata columns, compute the number of cells per cell type, and visualize the distribution of cells per cell type.

## Prerequisites

Make sure you have the following R packages installed:
- `remotes`
- `Seurat`
- `Azimuth`
- `SeuratDisk`
- `reticulate`

If any of these packages are not installed, the script will attempt to install them.

Additionally, you need the following Python packages for the Jupyter Notebook:
- `anndata`
- `pandas`
- `matplotlib`
- `seaborn`

## Usage

1. Set the file path for the input h5ad file in the script:
    ```r
    input_h5ad <- "C:\\Users\\Digvi\\Documents\\assignment\\cann_assessment\\Mouse_brain.h5ad"
    ```

2. Run the [run_azimuth.R](http://_vscodecontentref_/1) script:
    ```sh
    Rscript run_azimuth.R
    ```

3. Open the [test.ipynb](http://_vscodecontentref_/2) Jupyter Notebook and run the cells to analyze the annotated data.

## Script Details

The script [run_azimuth.R](http://_vscodecontentref_/3) performs the following steps:

1. Loads necessary libraries:
    ```r
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

    library(Seurat)
    library(Azimuth)
    library(reticulate)
    library(SeuratDisk)
    ```

2. Sets the file path for the input h5ad file:
    ```r
    input_h5ad <- "C:\\Users\\Digvi\\Documents\\assignment\\cann_assessment\\Mouse_brain.h5ad"
    ```

3. Converts the h5ad file to an h5Seurat file:
    ```r
    Convert(input_h5ad, dest = "h5seurat", overwrite = TRUE, assay = "RNA")
    seurat_obj <- LoadH5Seurat(gsub(".h5ad", ".h5Seurat", input_h5ad))
    ```

4. Runs Azimuth annotation on the Seurat object:
    ```r
    seurat_obj <- Azimuth::RunAzimuth(seurat_obj, reference = "mousecortexref")
    ```

5. Saves the annotated Seurat object back to an h5ad file:
    ```r
    SaveH5Seurat(seurat_obj, filename = "C:\\Users\\Digvi\\Documents\\assignment\\cann_assessment\\annotated_Mouse_brain.h5Seurat")
    Convert("C:\\Users\\Digvi\\Documents\\assignment\\cann_assessment\\annotated_Mouse_brain.h5Seurat", dest = "h5ad", overwrite = TRUE)
    ```

## Jupyter Notebook Details

The Jupyter Notebook [test.ipynb](http://_vscodecontentref_/4) performs the following steps:

1. Loads the annotated data:
    ```python
    import anndata as ad
    import pandas as pd
    import matplotlib.pyplot as plt
    import seaborn as sns

    # Load the annotated data
    adata = ad.read_h5ad("C:\\Users\\Digvi\\Documents\\assignment\\cann_assessment\\annotated_Mouse_brain.h5ad")
    ```

2. Checks available metadata columns:
    ```python
    # Check available columns
    print("Available metadata columns:", adata.obs.columns)
    ```

3. Selects the correct column for cell type:
    ```python
    # Select the correct column for cell type
    cell_type_col = None
    for col in ["predicted.celltype", "predicted.class", "predicted.subclass"]:
        if col in adata.obs.columns:
            cell_type_col = col
            break

    if cell_type_col is None:
        raise ValueError("No predicted cell type column found in metadata.")
    ```

4. Computes the number of cells per cell type:
    ```python
    # Compute the number of cells per cell type
    cell_counts = adata.obs[cell_type_col].value_counts()
    ```

5. Prints cell counts:
    ```python
    # Print cell counts
    print(cell_counts)
    ```

6. Visualizes the distribution using a bar plot:
    ```python
    # Visualize distribution using a bar plot
    plt.figure(figsize=(12, 6))
    sns.barplot(x=cell_counts.index, y=cell_counts.values, palette="viridis")
    plt.xticks(rotation=90)
    plt.xlabel("Cell Type")
    plt.ylabel("Cell Count")
    plt.title("Distribution of Cells per Cell Type")
    plt.show()
    ```

## Output

The script will generate an annotated h5ad file at the specified location



AnnData (H5AD) file :  https://drive.google.com/file/d/1epWwuZeNcIWpU5MTWJFnlSYWhusEBPdN/view?usp=sharing
