# mimim_iii_readmission
Prediction Readmission from Text Data.


## CODE STRUCTURE:

The main codes are in the folder **notebooks**. To fully reproduce the analysis, it is first necessary to setup a local PostgreSQL server containing the MIMIC-III database. For more information, follow the official documentation at the following [link](https://mimic.mit.edu/docs/gettingstarted/).

### 1. Data Processing.ipynb:

This notebook starts by executing a PostgreSQL query, *note_events.sql*, which fetches all the discharge notes in the database. It then performs a variety of cleanup steps, mainly removing duplicates and restricting our sample to only relevant admissions. 

### 2. Text Cleaning.ipynb:

Performs basic text cleaning, such as removing stopwords and recurring text (*e.g. placeholders for de-identified information such as [**Patient Name**] were removed*).

### 3. Text Vectorization.ipynb:

Splits the dataset into train/test. Then transform our dataset into a Document-to-Term (DTM) Matrix using common Bag Of Words methods (BoW). Furthermore, performs either SVD and LDA to get DOcument-to-Topic Matrices.

### 4. Classification.ipynb:

In this notebook we train all our main models in the previously vectorized datasets. We then check their performance using ROC AUC score.

### 5. Permutation_Importance.ipynb

Applies permutation importance to all our main models to provide interpretability to our results. 

### 6. Further Analysis.ipynb

Contains a variety of additional analyisis. Mainly produces a descriptive table to better understand our sample and checks the top 20 terms from the most important LDA topics following notebook (5).


## Additional Notes:

The folder **queries** contain the main queries used in our data. The queries are ran within our notebooks, although they can be ran independently on the PostgreSQL client (*or any SQL client connected to your local instance of the MIMIC-III dataset*).

The folders **ccs_categories** and **cms_planned_readmission** contains files to reproduce the CMS algorithm to split between planned and unplanned readmission. For more information, see the uploaded pdf **cms_planned_readmission/Version4.0_Hospital-Wide_Readmission_Measure_Updates_Report_3.25.15_With_Measure_Results.pdf**. The main paper did not use this classification in the end, but code to use this measure is still available within the notebook *1. Data Processing.ipynb* for further experimentation. 