library(Lithics3D)
library(rgl)
library(Morpho)
library(tidyverse)

setwd("C:/Users/emily/OneDrive/Documents")
#sets working directory to Documents

meshlistraw <- dir("Mesh Data")
#collects a list of the names of the .ply files

meshlist = c(meshlistraw[1], meshlistraw[12], meshlistraw[23], meshlistraw[34], meshlistraw[45], meshlistraw[47:50], meshlistraw[2:11], meshlistraw[13:22], meshlistraw[24:33], meshlistraw[35:44], meshlistraw[46])
#reordering of meshlistraw into 1-50

VG_edge_points <- read.csv("~/VG_edge_points_ordered.csv", header = FALSE)
#creates matrix of containing the landmark points and the mesh it corresponds to

radii <- read.csv("~/VirtGon_radius_data.csv", header = FALSE)
#creates matrix containing radii data for each mesh and landmark set

outputraw <- dir("C:/Users/emily/OneDrive/Documents/R Output data/30points/Virt_GonRadius30points")
#collects a list of the names of the files we will read this into. CHANGE THIS FOR DIFF PARAMETERS

output = c(outputraw[1:3], outputraw[34:36], outputraw[67:69], outputraw[100:102], outputraw[133:135], outputraw[139:150], outputraw[4:33], outputraw[37:66], outputraw[70:99], outputraw[103:132], outputraw[136:138])
#reorders the output files

allangles = c()
filespot = 1
#filespot = 1 indicates we are reading into the first file (initialize)



for (i in 1:50) {
  #for each mesh
  
  setwd("C:/Users/emily/OneDrive/Documents/Mesh Data")
  mesh <- ply2mesh(meshlist[as.numeric(i)])
  
  for (j in 1:3) {
    
   if (!(i==20 && (j==2||j==3))) {
     if (!(i==33 && (j==2))) {
        if (!(i==40 && (j==2))) {
         if (!(i==42 && (j==1||j==3))) {
            #for each landmark set in this mesh
            currentpoints = c(as.numeric(VG_edge_points[3*i-(3-j)+1, 3:8]))
            currentrad = radii[as.numeric(3*i-(3-j)+1),1]
            #obtains the next set of landmarks, saves into a vector
            
            lms = matrix(currentpoints, nrow = 2, ncol = 3)
            #converts landmarks to matrix form
            
            shade3d(mesh, color="green")
            
            edge.curve.ids = sPathConnect(lms, mesh, path.choice="ridges")
            edge.curve.path = t(mesh$vb)[edge.curve.ids,1:3]
            lines3d(edge.curve.path, color="blue", size=6, lwd=4) # Let's see the actual path:
            edge.curve = pathResample(edge.curve.path, 30, method="npts")
            #change second parameter to match number of points
            
            
            points3d(edge.curve, color="purple", size=10)
            res = edgeAngles(mesh, edge.curve, as.numeric(currentrad))
            #change third parameter to match distance from edge
            
            
            rgl.close()
            
            storeangles = c()
            # creates an empty vector named storeangles
            
            for (k in 1:length(res)) {
              #change k to match number of points
              storeangles = append(storeangles, res[[k]]$angle)
              allangles = append(allangles, res[[k]]$angle)
            }
            #transfers the data from res (the angles) into our vector
            
            angles.df = data.frame(matrix(storeangles))
            #converts vector to matrix to data frame
            setwd("C:/Users/emily/OneDrive/Documents/R Output data/30points/Virt_GonRadius30points")
            #change to match new directory
            currentfile <- output[filespot]
            write.csv(angles.df, output[filespot], row.names = FALSE)
            #transfers data from data frame into the proper csv file
          }
       
        }
       
      }
    
    }
    
    filespot = filespot + 1
  }
  
}
