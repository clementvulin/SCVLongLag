macro "watchnext [c]" {
	a=getList("image.titles")
	if (a.length==0) { /*no window was opened*/
	path=getDirectory("Choose the directory containing the stacks you want to watch");
	numstack=getNumber("start from ?",1);
}
else { /* one window is already opened*/
	close("*.tif*"); /* closes the opened stack */
	numstack = parseInt(getPixel (0,0)+1);
	path= getTitle;
	close ("*");
	}
	newImage(path, "8bit",1,1,1); /*this stores path in the name of the openned image (dirty code here!)*/
	setPixel(0,0,numstack); /*this stores numstack in one pixel of the openned image (see usage below)*/
	run("TIFF Virtual Stack...", "open="+path+"/pos"+numstack+".tif"); /* open one tif stack*/
	setSlice(15);
	//run("Enhance Contrast", "saturated=0.35");
	setSlice(1);
	//open(path+"/pos"+numstack+".tif");
	}
macro "watchnext [v]" {
	run ("Next Slice [>]");
	run("Enhance Contrast", "saturated=0.35");
}
macro "watchnext [x]" {
	a=getList("image.titles")
	if (a.length==0) { /*no window was opened*/
	path=getDirectory("Choose the directory containing the stacks you want to watch");
	numstack=getNumber("start from ?",1);
}
else { /* one window is already opened*/
	close("*.tif*"); /* closes the opened stack */
	numstack = parseInt(getPixel (0,0)-1);
	path= getTitle;
	close ("*");
	}
	newImage(path, "8bit",1,1,1); /*this stores path in the name of the openned image (dirty code here!)*/
	setPixel(0,0,numstack); /*this stores numstack in one pixel of the openned image (see usage below)*/
	run("TIFF Virtual Stack...", "open="+path+"/pos"+numstack+".tif"); /* open one tif stack*/
	setSlice(15);
	//run("Enhance Contrast", "saturated=0.35");
	setSlice(1);
	//open(path+"/pos"+numstack+".tif");
	}