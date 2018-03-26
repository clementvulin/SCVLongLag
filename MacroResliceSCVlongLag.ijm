macro "Reslicing [f2]" {

 usual_file_name=getString("give file name", "frame_t_0.ets");
/* trouble openning ets file, do this by hand ? */

 path=getDirectory("Choose the directory containing the file");

/* File.open(path+usual_file_name); */
run("Bio-Formats", "open=" + path + usual_file_name + " color_mode=Default open_files view=[Standard ImageJ] stack_order=Default use_virtual_stack series_1");
/* see comment on ".ets" files above */

rename("mixed");
Stack.getDimensions(width, height, channels, slices, frames);
numpos=getNumber("number of positions in stack", 8);

/*first images user can observe*/
for (i=1;i<2;i++){
selectWindow("mixed");
run("Slice Keeper", "first=" + i + " last=" + frames + " increment=" + numpos + "");
saveAs("Tiff", path+"/pos"+i+".tif");
close("pos"+i+".tif");
} 

/*now windw is hidden*/
setBatchMode("hide")
for (i=2;i<numpos+1;i++){
selectWindow("mixed");
run("Slice Keeper", "first=" + i + " last=" + frames + " increment=" + numpos + "");
saveAs("Tiff", path+"/pos"+i+".tif");
close("pos"+i+".tif");
} 

/*save first and last images*/

newdir=path+"/firstframes";
File.makeDirectory(newdir);

for (i=1;i<numpos+1;i++){
selectWindow("mixed");
run ("Duplicate...","title=img duplicate range="+i+"-"+i+"");
saveAs("Tiff", ""+newdir+"/"+i+".tif");
close("img");
}

selectWindow("mixed");
fin2=numpos*floor(frames/numpos); /*the acquisition could have been stoped before the end*/
fin=fin2-numpos+1;

newdir=path+"/lastframes";
File.makeDirectory(newdir);

for (i=fin;i<fin2+1;i++){
selectWindow("mixed");
run ("Duplicate...","title=img duplicate range="+i+"-"+i+"");
nameimg=i-fin+1; /*so that images have the same name*/
saveAs("Tiff", ""+newdir+"/"+nameimg+".tif");
close("*.tif");
}
setBatchMode("show");
