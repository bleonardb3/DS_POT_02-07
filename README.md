# IBM Proof of Technology - Introduction to Data Science using Watson Studio

## Description:
Watson Studio provides you with the environment and tools to solve your business problems by collaboratively working with data. You can choose the tools you need to analyze and visualize data, to cleanse and shape data, to ingest streaming data, or to create, train, and deploy machine learning/deep learning models. Watson Studio contains both open source and IBM value-add capabilities to help infuse AI into business to drive innovation. 

Watson Studio is tightly integrated with the Watson Knowledge Catalog. The Watson Knowledge Catalog is a secure enterprise catalog to discover, catalog and govern your data/models with greater efficiency. The catalog is underpinned by a central repository of metadata describing all the information managed by the platform. Users will be able to share data with their colleagues more easily, regardless of what the data is, where it is stored, or how they intend to use it. In this way, the intelligent asset catalog will unlock the value held within that data across user groups—helping organizations use this key asset to its full potential.

The labs in this workshop will illustrate the myriad features included in Watson Studio, and Watson Knowlege Catalog. lab-1, Lab-2, and Lab-3 need to be completed in order. Subsequent labs are independent. 


1. [Lab-1](Lab-1) - The first lab will demonstrate the features of the Watson Knowledge Catalog

1. [Lab-2](Lab-2) - The second lab will leverage Spark machine learning (SparkML) in a Jupyter notebook to create categorical predictions using pyspark and a supervised learning model. The model will be saved into a model repository using Watson Machine Learning APIs. 

1. [Lab-3](Lab-3) - The third lab will guide participants in examining an R notebook and Shiny UI in Watson Studio using RStudio. It will rely on the output results from Lab-1 and Lab-2. 

1. [Lab-4](Lab-4) - Neural Network Lab

1. [Lab-5](Lab-5) - SPSS Modeler Lab

1. [Lab-6](Lab-6) - Data Refinery Lab

1. [Lab-7](Lab-7) - Visual Recognition Lab 

1. [Lab-8](Lab-8) - Natural Language Classifier Lab 

## Instructions: Create a Watson Studio project and set up the required services. 

### Step 1.  Log into your Watson Studio account at datascience.ibm.com, then click on the hamburger icon, then `Projects`, and then `View All Projects`
> <img src="https://github.com/bleonardb3/DS_POT_02-07/blob/master/images/Navigation%20Selection.png"/>
> <img src="https://github.com/bleonardb3/DS_POT_02-07/blob/master/images/ViewAllProjects.png"/>


### Step 2.  If you have an existing project from following the signup instructions then select it, and skip to Step 8.  Otherwise, click on `New Project`. 
> <img src="https://github.com/bleonardb3/ThinkGov/blob/master/Images/Select%20New%20Project.png"/>

### Step 3. Hover the mouse over Standard, and click on `Create Project`. 
> <img src="https://github.com/bleonardb3/DS_POT_02-07/blob/master/images/CreateStandardProject.png"/>


### Step 3. Enter the project name (eg. Watson Studio Labs), optionally a description, and then click on `Add` in the Storage section. Note if you have already provisioned cloud object storage (you shouldn't see an Add button) , then just click on the `Create` button, and skip to Step 8. 

> <img src="https://github.com/bleonardb3/DS_POT_02-07/blob/master/images/EnterProjectInfo.png"/>

### Step 4. Click on the Lite plan, and then click on `Create`. 

> <img src="https://github.com/bleonardb3/ThinkGov/blob/master/Images/Create%20Object%20Storage.png"/>

### Step 5. Optionally change the storage name, and then click on `Confirm`

> <img src="https://github.com/bleonardb3/ThinkGov/blob/master/Images/Confirm%20Creation.png"/>

### Step 6. Click on `Refresh`. 

> <img src="https://github.com/bleonardb3/DS_POT_02-07/blob/master/images/ClickonRefresh.png"/>

### Step 7.  The cloud object storage should appear. Now click on `Create`. 

> <img src="https://github.com/bleonardb3/DS_POT_02-07/blob/master/images/ClickonCreateProject.png"/>


### Step 9.  Click on the project `Settings` tab.

> <img src="https://github.com/bleonardb3/ML-POT/blob/master/Lab-1/images/Select%20Settings.png"/>

### Step 10. Scroll down to `Associated Services`, then select `Add service` and select `Watson`.

> <img src="https://github.com/bleonardb3/WatsonStudio/blob/master/images/SelectWatsonService.png"/>

### Step 11. Select the `Machine Learning` service 

> <img src="https://github.com/bleonardb3/WatsonStudio/blob/master/images/SelectMachineLearningService.png"/>

### Step 12. Select `New`.

> <img src="https://github.com/bleonardb3/ML-POT/blob/master/Lab-1/images/Select%20New%20Service.png"/>

### Step 13. Select the `Lite` plan. 

> <img src="https://github.com/bleonardb3/ML-POT/blob/master/Lab-1/images/Select%20Lite%20ML.png"/>

### Step 13. Scroll down and click `Create`, then change the `Service name` to `Machine Learning` in the `Confirm Creation` panel and click `Confirm`.  

> <img src="https://github.com/bleonardb3/WatsonStudio/blob/master/images/ConfirmMachineLearningCreation.png"/>

### Step 14. The Machine Learning service that you created should now appear in `Associated Services`. 

> <img src="https://github.com/bleonardb3/ML-POT/blob/master/Lab-1/images/See%20ML%20in%20Associated%20Services..png"/>



