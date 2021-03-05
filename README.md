# 2021_cell_counting
> The script was developed for cell counting using ImageJ and FIJI and was written in the ImageJ Macro Language (IJM). It can be opened in the FIJI by dragging and dropping the .ijm file into the main menu, which will open the .ijm script editor in FIJI. From this window, the script can be edited and used for immunofluorescent images. In our experience, .LIF files directly saved from Leica imaging software can be directly dragged into FIJI to open files. The script is designed to enumerate nucleated cells (as detected by a nucleic acid stain such as DAPI) and a second cell population (as measured by a surface marker such as Thy1.1), and measure the area in metric distance of the image selection. To allow for flexibility, the code can be edited within the .ijm script editor. Specifically, the user can edit the respective channels for 'nuclei' and 'cells' within the code, so that they match the corresponding channel number in the given LIF file. Additionally, the 'noise value' can and should be modulated for the nuclei and cell count. A higher value will result in a more fidelitous count, but may exclude true cells. A lower value will include more true cells, but may doubly count certain cells. A ' trial and error' approach can be taken to determine an acceptable noise value. 

# Files
count_cells_spw.ijm

## Contact
Created by Sathi Wijeyesinghe (wijey001@umn.edu)
