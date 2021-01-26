macro "Count nuclei v2" {

	//VARIABLES
	nuclei = 1;
	cellc = 2;
	
//	//Get nuclei channel
			//unused code: Prompt for channel //nuclei = getNumber("Nuclei Channel:",1); //get Nuclei channel
	setSlice(nuclei); //use nuclei if using prompt for channel (see above line)
	//Make selection on your image first!
	//Prompt for Output directory
	//outdir = getDirectory("Output directory");
	//Get selection, and duplicate
	getSelectionCoordinates(xpoints, ypoints); 
	run("Select None");
	run("Duplicate...","title=copy1");
	copy1 = getTitle();
	run("8-bit"); //necessary for find maxima
	
	// Add the selected tissue to ROI Manager
	makeSelection("polygon", xpoints, ypoints);
	roiManager("Add");
	makeSelection("polygon", xpoints, ypoints);
	//:Measure the area of the selection
	run("Measure");
	A = getResult("Area");
	run("Clear Results");	
	close("Results");
	
	//To Measure Area
	//run("Set Measurements...", "area redirect=None decimal=5");
	//run("Measure");
	//saveAs("Results", outdir+"Tissue_area.csv");
	
	//Create Mask of Tissue Area
	run("Create Mask");
	rename("Tissue");
	//roiManager("Save", outdir+"Tissue.zip");
	
	// Detect nuclei centers
	selectWindow(copy1);
	run("Select None");           
	run("Gaussian Blur...", "sigma=1.5"); 
	//run("Subtract Background...", "rolling=100 slice");
	setAutoThreshold("Default dark");
	makeSelection("polygon", xpoints, ypoints);
	//This line below is where you can adjust the noise
	run("Find Maxima...", "noise=0 output=[Point Selection] exclude above");
	roiManager("Add");
	getSelectionCoordinates(nuclei_xpoints, nuclei_ypoints);
	N = nuclei_xpoints.length;
	print('Area:');
	print('Nuclei:');
	print('Cells:');
	print(A);
	print(N);

	//Close windows 
	selectWindow("Tissue");
	close();
	selectWindow(copy1);
	close();
////////////////////////////// cell count below/////////
	
	//Get nuclei channel
	//unused code: prompt for channel: //cellc = getNumber("Cell Channel:", 3); //get Nuclei channel
	setSlice(cellc); //use cellc if using prompt for channel (see above line)

	//Name original image, get selection, and duplicate
	makeSelection("polygon", xpoints, ypoints);
	run("Select None");
	run("Duplicate...","title=copy1");
	copy1 = getTitle();
	run("8-bit"); //necessary for find maxima  
	
	//Create Mask of Tissue Area
	makeSelection("polygon", xpoints, ypoints);
	run("Create Mask");
	rename("Tissue");
	
	// Detect nuclei centers
	selectWindow(copy1);
	run("Select None");
	run("Gaussian Blur...", "sigma=1.5");  
	//run("Subtract Background...", "rolling=100 slice");
	setAutoThreshold("Triangle dark");
	makeSelection("polygon", xpoints, ypoints);
	run("Find Maxima...", "noise=35 output=[Point Selection] exclude above"); //lower noise = more cells
	//Run this to recount	
	getSelectionCoordinates(cell_xpoints, cell_ypoints);
	cell_count = cell_xpoints.length;
	print(cell_count);
	roiManager("Add"); 
	print('---------------------------');
	//Close windows 
	selectWindow("Tissue");	
	close();
	selectWindow(copy1);
	close();
