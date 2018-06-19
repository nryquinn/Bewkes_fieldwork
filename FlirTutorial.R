
install.packages(c("plyr"))

library(plyr)
#set the directory for the folder
setwd("c:\\Users\\hkropp\\Google Drive\\Flir_ex")
setwd("c:\\Users\\nquinn\\Downloads")
#output is seperated with ; read in data 
datp<-read.table("FLIR0003_temp.csv",sep=";", header=TRUE)

datp2t<-read.table("imagetest.csv",sep=";", header=FALSE)
datp2 <- data.frame(X=rep(seq(0,287),times=383),Y=rep(seq(0,382),each=288),
		Temp=as.vector(data.matrix(datp2t)))

#check file read in ok
dim(datp)
names(datp)
#run summary statistics on the output
mean(datp$Temp)
sd(datp$Temp)
sd(datp$Temp)/mean(datp$Temp)
max(datp$Temp)
min(datp$Temp)

datC <- read.csv("dogear.csv")
datS <- read.csv("shrub_sub.csv")
######################################################################################
#####################################################################################
############ for plotting 
#b<-layout(matrix(c(1,2),ncol=2),width=c(lcm(15),lcm(5)), height=c(lcm(15),lcm(15))) 
#layout.show(b)
b<-layout(matrix(c(1),ncol=1),width=c(lcm(15)), height=c(lcm(15))) 
layout.show(b)
#make a function
#inputs include the x and y coordinates, the temperature, and the number of temperature increments to show colors for
flir.plot<-function(x.input,y.input,T.input, ncolors){

layout.show(b)

#set up color increments
crange<-seq(range(T.input)[1],range(T.input)[2],length.out=ncolors)

ccol<-topo.colors(ncolors)
pcol<-character(0)
for(i in 1:length(x.input)){
	for(j in 1:(ncolors-1)){
		if(T.input[i]>=crange[j]&T.input[i]<crange[j+1]){
			pcol[i]<-ccol[j]
			}
	
	}

}


par(c(0,0,0,.5))
plot(c(0,max(x.input)),c(0,max(y.input)), xlab=" " ,ylab=" ", type="n", axes=FALSE)

for(i in 1:length(y.input)){
polygon(c(x.input[i]-.5,x.input[i]-.5,x.input[i]+.5,x.input[i]+.5),
	c(y.input[i]-.5,y.input[i]+.5,y.input[i]+.5,y.input[i]-.5), col=pcol[i],border="NA")

}
#pp<-seq(1,ncolors)
#xp<-rep(0,ncolors)
#par(c(.5,0,0,0))

#plot(c(0,1),c(0,ncolors+.5),type="n",axes=FALSE,xlab=" ", ylab=" ")
#for(i in 1:ncolors){
#polygon( c(xp[i],xp[i],xp[i]+1,xp[i]+1),c(pp[i]-.5,pp[i]+.5,pp[i]+.5,pp[i]-.5),col=ccol[i])
#}
#axis(4,seq(1,ncolors),round(crange,2),las=2)

}
datp2 <- datp2[datp2$Y!=382,]
flir.plot(datp2$X,datp2$Y,datp2$Temp,20)

polygon(c(datC$X,rev(datC$X)),c(datC$Y,rev(datC$Y)), col="red")

points(datS$X,datS$Y,pch=19)

shrub.sub <- join(datp2,datS, by=c("X","Y"), type="inner")
flir.plot(shrub.sub$X,shrub.sub$Y,shrub.sub$Temp,20)

mean(shrub.sub$Temp)

########################################################################################
########################################################################################
########### process a bunch of pictures

flir.summary<-function(input.dir,filename.out){
#get the names in the folder with the csv files output from the wrapper function
filename<-list.files(input.dir)
#grab the file name without the csv
fln<-gsub(".csv","",filename)
#get the information for each file
summ.list<-list()
summ.mat<-matrix(rep(NA,5*length(fln)),ncol=5)
#get summary statistics for each file
for(i in 1:length(fln)){
a<-read.table(paste(input.dir,"\\",filename[i], sep=""),sep=";", header=TRUE)
summ.mat[i,1]<-round(mean(a$Temp),1)
summ.mat[i,2]<-round(sd(a$Temp),1)
summ.mat[i,3]<-round(sd(a$Temp)/mean(a$Temp),1)
summ.mat[i,4]<-max(a$Temp)
summ.mat[i,5]<-min(a$Temp)
}
rownames(summ.mat)<-fln
colnames(summ.mat)<-c("mean","st.dev","cv","max","min")
#write the summary table to file
write.table(summ.mat,filename.out,sep=",",row.names=TRUE)

}
#run flir summary

flir.summary("c:\\Users\\hkropp\\Google Drive\\Flir_ex\\csv","c:\\users\\hkropp\\Google Drive\\flir_ex\\summary\\test.csv")