#set the url to fileurl variable
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#Download the file and unzip
  download.file(fileUrl, destfile = "Dataset.zip", method = "curl")
  unzip("Dataset.zip")

#take all the data and set a them a variable
  test_X <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
  test_Y <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
  test_sub <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
  train_X <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
  train_Y <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
  train_sub <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)

# Create data with the activities type
  activities <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)
  es$V1,labels=activities$V2)

# Create data with the features type
  features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE)

#Set good columns names to data frames viewed above
  colnames(test_X)<-features$V2
  colnames(train_X)<-features$V2
  colnames(test_Y)<-c("Activity")
  colnames(train_Y)<-c("Activity")
  colnames(test_sub)<-c("Subject")
  colnames(train_sub)<-c("Subject")

# merge test and training sets into one data set, including the activities
  testData<-cbind(test_X,test_Y)
  testData<-cbind(testData,test_sub)
  trainData<-cbind(train_X,train_Y)
  trainData<-cbind(trainData,train_sub)
  Data<-rbind(testData,trainData)

# extract the mean and standard deviation for each measurement
Data_mean<-sapply(Data,mean,na.rm=TRUE)
Data_sd<-sapply(Data,sd,na.rm=TRUE)

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  install.packages("data.table")
  library(data.table)
  DT <- data.table(Data)
  tidy<-lapply(DT,mean)
  write.table(tidy,file="tidy.csv",sep=",",row.names = FALSE)