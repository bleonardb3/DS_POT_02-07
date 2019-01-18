In this lab, you will use SparkML in IBM's Watson Studio to run generated travel data through a machine learning algorithm, automatically tune the algorithm, and load the results into Cloud Object Storage. 

## Objectives:
Upon completing the lab, you will know how to:


1. Connect to cloud object storage and read data used for machine learning.
2. Identify labels and transform data.
3. Conduct feature engineering for algorithm data.
4. Declare a machine learning model.
5. Setup the Pipeline for data transofms and training.
6. Train the data.
7. Show and evaluate machine learning results.
8. Automatically tune machine learning results.
9. Score data and load results into cloud object storage. 

## Instructions:

### Step 1. Click on the [link](https://github.com/bleonardb3/WatsonStudio/blob/master/Lab-1/data/female_human_trafficking.csv) and then right click on `Raw` and then click the `Save link as...` and then click `Save` to download the `female_human_trafficking.csv file` to your computer. Don't change the name of the file. 
<img src="https://github.com/bleonardb3/WatsonStudio/blob/master/Lab-1/images/Right%20Click%20on%20Raw.png"/>

### Step 2.  Log into your [Watson Studio](http://datascience.ibm.com/) account, then click Projects in the top menubar and select the project you created at the beginning of this proof of technology.
<img src="https://github.com/bleonardb3/WatsonStudio/blob/master/Lab-1/images/Select%20Project.png"/>

### Step 3.  Click the `Add to project > Data Asset` link in the top right of your project pane. 
<img src="https://github.com/bleonardb3/WatsonStudio/blob/master/Lab-1/images/Add%20to%20Project%20Data%20Asset.png"/>

### Step 4.  Click on `browse`. 
<img src="https://github.com/bleonardb3/WatsonStudio/blob/master/Lab-1/images/Click%20Browse.png"/>

### Step 5. Navigate to the folder where you downloaded the `female_human_trafficking.csv` file. Click on the file, and then click on `Open`.
<img src="https://github.com/bleonardb3/WatsonStudio/blob/master/Lab-1/images/Navigate%20to%20File.png"/>

### Step 6. Click on the `Assets` tab (if you are not already on that panel) and you should see `female_human_trafficking.csv` listed under the `Data Assets` category. 
<img src="https://github.com/bleonardb3/WatsonStudio/blob/master/Lab-1/images/Data%20Asset.png"/>

### Step 7.  Click the `Add to project > Notebook` link in the top right of your project pane.
<img src="https://github.com/bleonardb3/WatsonStudio/blob/master/Lab-1/images/Add%20to%20Project.png"/>

### Step 8.  Click the `From URL` tab under `Create Notebook`. Give the notebook a name in the `Name` field, for example `Machine learning with SparkML` and optionally you can give it a description. In the Notebook URL field, use

`https://github.com/bleonardb3/WatsonStudio/blob/master/Lab-1/Categorizing-Vetted-Data.ipynb` 

In the `Select runtime` field, make sure to select the Spark service, and then click on `Create Notebook`

<img src="https://github.com/bleonardb3/WatsonStudio/blob/master/Lab-1/images/Create%20Notebook.png"/>

### Step 9.  Follow the instructions in the notebook.

<img src="https://github.com/bleonardb3/WatsonStudio/blob/master/Lab-1/images/Notebook.png"/>
