macro "Count cells" {

	//VARIABLES
	nuclei = 1;
	cellc = 2;
	
	setSlice(nuclei); 
	getSelectionCoordinates(xpoints, ypoints); 
	run("Select None");
	run("Duplicate...","title=copy1");
	copy1 = getTitle();
	run("8-bit"); 
	// Add the selected tissue to ROI Manager
	makeSelection("polygon", xpoints, ypoints);
	roiManager("Add");
	makeSelection("polygon", xpoints, ypoints);
	
	//Measure the area of the selection
	run("Measure");
	A = getResult("Area");
	run("Clear Results");	
	close("Results");
	run("Create Mask");
	rename("Tissue");
	
	// Count nuclei
	selectWindow(copy1);
	run("Select None");           
	run("Gaussian Blur...", "sigma=1.5"); 
	setAutoThreshold("Default dark");
	makeSelection("polygon", xpoints, ypoints);
	//The line below is where you can adjust the noise for nuclei
	run("Find Maxima...", "noise=0 output=[Point Selection] exclude above");
	roiManager("Add");
	getSelectionCoordinates(nuclei_xpoints, nuclei_ypoints);
	N = nuclei_xpoints.length;
	print('Area:');
	print('Nuclei:');
	print('Cells:');
	print(A);
	print(N);
	selectWindow("Tissue");
	close();
	selectWindow(copy1);
	close();

	// Count cells
	setSlice(cellc);
	makeSelection("polygon", xpoints, ypoints);
	run("Select None");
	run("Duplicate...","title=copy1");
	copy1 = getTitle();
	run("8-bit");
	makeSelection("polygon", xpoints, ypoints);
	run("Create Mask");
	rename("Tissue");
	selectWindow(copy1);
	run("Select None");
	run("Gaussian Blur...", "sigma=1.5");  
	setAutoThreshold("Triangle dark");
	makeSelection("polygon", xpoints, ypoints);
	//The line below is where you can adjust the noise for nuclei
	run("Find Maxima...", "noise=35 output=[Point Selection] exclude above"); //lower noise = more cells	
	getSelectionCoordinates(cell_xpoints, cell_ypoints);
	cell_count = cell_xpoints.length;
	print(cell_count);
	roiManager("Add"); 
	print('---------------------------');
	selectWindow("Tissue");	
	close();
	selectWindow(copy1);
	close();
}
