# Codebook content

Description of variables, the data and transformation performed to clean up the data

# the data [from README.txt file in dataset] 

The data represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project is at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data was produced in the experiment performed on 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 

Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity. 

The experiments have been video-recorded to label the data manually. 

The dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The dataset includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


For more information about this dataset contact: activityrecognition@smartlab.ws


# the variables, 

outdir   contains path to working directory

fileUrl     URL for the data

filename     dataset filename

zipF     allows user to choose file to unzip

X_test, X_train, Y_test, Y_train      data from the dataset, test and training set, test and training labels, respectively

test_subject, train_subject        data identyifing subjects in test and training set, respectively

test_train       combined training and test dataset

features       names of all features in test_train dataset, read from features.txt file

test_train_labels, test_train_subjects        combined lables, subjects for test_train dataset, respectively

tables_subjectes_labels          combined subjects and labels

table      the entire dataset merged


keeps     variable keeping only columns containg mean() or std()

activity_names     vector that stores activity names

table_group    dataset grouped by subject and activityID

tidy_data      summarised dataset whereby mean was applied to each feature for each subject and activity


# transformations or work that I performed to clean up the data

To clean up the data the test and train datasets are merged using rbind and cbind function

Descriptive names are added using features.txt. Similarly descriptive names of columns are added for Subjects and Activity. Later on these are altered to be more "user friendly"

Data containing mean and standard deviation for each measurement is extracted using grepl

Activity names are assigned (intially 1-6, were changed to WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.)

Data is grouped by by subject and activity using group_by

Data is summarised and means are taken using summarise_all

Data is saved as a csv file using write.table


