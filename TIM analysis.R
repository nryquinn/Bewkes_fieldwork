
library(classInt)
rm(list = ls(all = TRUE))

Shrub2data <- read.table("/Volumes/data/data_repo/field_data/bewkes/TIM/6_20_18/shrub2data.csv", head = FALSE, sep = ";")
dim(Shrub2data)
datp2 <- data.frame(X=rep(seq(0,287),times=382),Y=rep(seq(0,381),each=288),
                    Temp=as.vector(data.matrix(Shrub2data[,1:382])))



b<-layout(matrix(c(1,2),ncol=2),width=c(lcm(15), lcm(5)), height=c(lcm(15), lcm(15))) 
layout.show(b)
#make a function
#inputs include the x and y coordinates, the temperature, and the number of temperature increments to show colors for
flir.plot<-function(x.input,y.input,T.input, ncolors){
  
  layout.show(b)
  
  #set up color increments
  crange<- classIntervals(datp2$Temp,ncolors)$brks
    #seq(range(T.input)[1],range(T.input)[2],length.out=ncolors)
  
  ccol<-heat.colors(ncolors)
  pcol<-character(0)
  for(i in 1:length(x.input)){
    for(j in 1:(ncolors)){
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
  pp<-seq(1,ncolors)
  xp<-rep(0,ncolors)
  par(c(.5,0,0,0))
  
  plot(c(0,1),c(0,ncolors+ 1),type="n",axes=FALSE,xlab=" ", ylab=" ")
  for(i in 1:ncolors){
  polygon( c(xp[i],xp[i],xp[i]+1,xp[i]+1),c(pp[i]-.5,pp[i]+.5,pp[i]+.5,pp[i]-.5),col=ccol[i])
  }
  axis(4,seq(1,ncolors+1)-.5,round(crange,2),las=2)
  
}

flir.plot(datp2$Y, datp2$X, datp2$Temp, 20)
