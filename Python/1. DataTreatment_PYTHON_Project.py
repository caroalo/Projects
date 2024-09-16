# 1. Import libraries and read data set. 
import pandas as pd
import numpy as np

df = pd.read_csv("dataset_1.csv", index_col=0)  # df = DataFrame

# 2. Explore Data set before transformation.

#print(df)  # Displays data from DataSet.csv

#print(df.describe())  # Provides central tendency and statistical data


#print(df.info())  # Shows data types of each variable



# Generation of sets: gender, education, cities (to see different options of categorical variables)
set_gen = set(df["Gender"].to_list()) 

set_edu = set(df["EducationLevel"].to_list())
set_ciu = set(df["City"].to_list())
#print(set_gen)  # Displays the values of each set. Commented out to avoid display while cleaning.
#print(set_edu)
#print(set_ciu)

# 3. Data transformation

  # a) Handling negative values (beginner method)
df["Age"] = df["Age"].apply(lambda x: np.nan if x < 0 else x)  # Replaces negative value with nan
df["Income"] = df["Income"].apply(lambda x: np.nan if x < 0 else x)
df["Children"] = df["Children"].apply(lambda x: np.nan if x < 0 else x)

 # b) Impute missing values.

	# Replaces with the median
for column in ["Age", "Income", "Children"]:  # Creates list
    median_value = df[column].median()
    df.fillna({column: median_value}, inplace=True)  # Fills missing values with the median
       # Replaces with the mode (most frequent value)
for column in ["Gender", "City"]:
    mode_value = df[column].mode()[0]  
    df.fillna({column: mode_value}, inplace=True)

# 4. Mapping categorical data
education_mapping = {
    "Bachelors": "Bachelor",  # Corrects the misspelling
    "pHd": "PhD",
    "no education": "NE"
}

# Replace incorrect or inconsistent values
df['EducationLevel'] = df['EducationLevel'].replace(education_mapping)

# Fill missing values with 'NE'
df['EducationLevel'] = df['EducationLevel'].fillna('NE')

# 5. Casting data types to ensure consistency
df["Age"] = df["Age"].astype(int)
df["Children"] = df["Children"].astype(int)
df["Income"] = df["Income"].astype(float)
df["Height"] = df["Height"].astype(float)
print(df)

print(df.describe())

