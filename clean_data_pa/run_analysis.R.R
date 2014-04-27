setwd('/Users/Nan/Dropbox/DatSci_coursera/cleaning data/pa/UCI HAR Dataset/')

act <- read.table('activity_labels.txt')
names(act) <- c('act_code','activity')
feature <- read.table('features.txt')

#test
x_test <- read.table('test/X_test.txt')
names(x_test) <- feature[,2]
x_test <- x_test[,grep('(mean|std)',names(x_test))]

y_test <- read.table('test/y_test.txt')
names(y_test) <- 'act_code'

sub_test <- read.table('test/subject_test.txt')
names(sub_test) <- 'id'

all_test <- cbind(sub_test,y_test,x_test)
all_test <- merge(all_test,act,by="act_code")

#train
x_train <- read.table('train/X_train.txt')
names(x_train) <- feature[,2]
x_train <- x_train[,grep('(mean|std)',names(x_train))]

y_train <- read.table('train/y_train.txt')
names(y_train) <- 'act_code'

sub_train <- read.table('train/subject_train.txt')
names(sub_train) <- 'id'

all_train <- cbind(sub_train,y_train,x_train)
all_train <- merge(all_train,act,by="act_code")


#final, required dataset 1
final <- rbind(all_train,all_test)
dim(final)
final <- final[order(final$act_code,final$id),c(2,1,82,3:81)]

write.csv(final,"data_1.txt",row.names=F,quote=F)

#summarize, required dataset 2
library(reshape2)
vars <- names(final)
final_rs <- melt(final,id=vars[1:3],measure.vars=vars[4:82])

avg <- dcast(final_rs,id+activity ~ variable,mean)
avg[1:6,1:6]

write.csv(avg,"data_2.txt",row.names=F,quote=F)
