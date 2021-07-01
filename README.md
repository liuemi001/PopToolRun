# PopToolRun

# meshes are located in the meshes folder

# a full list of the error occurences: 
# https://docs.google.com/document/d/1DUlX7HJ6Xd_IEGULcrfBrqWg_kR-2b3EFCZ5_LZaQ0I/edit?usp=sharing

# There are four scenarios that give an error: 
# 3 radius 30 points
# virtual goniometer radius 30 points
# 3 radius 60 points
# virtual goniometer radius 60 points

# All of them give the same error
# In each of them, this if statement in the e2sIntersect function is being triggered: 
#  if (length(eoi) == 0){
#    return(NA)
#  }

# which causes the eoi.int object within the edgeAngles function to be null,
# causing the error message I receive directly, which says the error is at this line

#     if (nrow(eoi.int) > 2){

# in the edgeAngles function. 
# it errors out since nrow(eoi.int) is NA since eoi.int is NA. 
# My issue is that I have no idea why these specific meshes and landmark points
# give this error, while all the rest are perfectly fine. 

# Thank you!!
