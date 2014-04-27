Readme
========================================================

data_1.txt is the first required dataset while data_2.txt is the second.

My script run_analysis.r runs assuming the data has already been unzipped. 

For data_1.txt, it first read activities and features, which are later combined with both training and test datasets. The grep() function identifies features that are either mean or std. The subject ID, label of activities, and recorded feature data are combined. Finally the training and test datasets are combined together using rbind().

For data_2.txt, first reshape the dataset into a long format using melt(), and then using dcast() to calculate the averages for each subject and each activity.