# Playing with the data


Now we are going to start cleaning, transforming, aggregating and partitioning data. For data we are going to use the Developer Endpoint and Notebook we created some steps back.

## Create a notebook

Click in the Notebooks and Open the Notebook created. This will launch Jupyter Notebook. Go to New -> Sparkmagic (PySpark)

We will start by importing all the libraries we need 

``` python
import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

from pyspark.sql.functions import lit
from awsglue.dynamicframe import DynamicFrame

glueContext = GlueContext(SparkContext.getOrCreate())
```

We are going to use the data we transformed to parquet in previous steps. For that, we create a dynamic frame pointing to the database and table that our crawler inferred, then we are going to show the schema.

If you dont remember the database/ table names, just go to Databases/ Table tab in Glue and copy its names.

``` python
taxis = glueContext.create_dynamic_frame.from_catalog(database="DATABASE_NAME", table_name="TABLE_NAME")
taxis.printSchema()
```

## Transformations

You probably have a large number of columns and some of them can have complicated names. To analyze the data, perphaps we may not need all the columns, just a small set of them, and to make easier to recall we may want to change the name of the column. Therefore, we are going to select only the columns we are interested in, drop the rest of them and we are going to rename them.

### Drop Columns


``` python
taxis_conv=taxis.select_fields(['COLUMN1_TO_KEEP/RENAME','COLUMN2_TO_KEEP']).rename_field('COLUMN1_TO_KEEP/RENAME', 'NEW_COLUMN_NAME')
taxis_conv.printSchema()
```

####Example NY Taxis dataset

``` python
taxis_conv=taxis.select_fields(['tpep_pickup_datetime','trip_distance']).rename_field('tpep_pickup_datetime', 'pickup_datetime')
taxis_conv.printSchema()
```


### Convert to Time stamp

Please check the date, time column schema, from the previous step. It may be string or other type different than what we may need it to be. Therefore, we are going to do some transformations.

First, lets add the different libraries we need to make this conversion

``` python 
from pyspark.sql.functions import date_format
from pyspark.sql.functions import to_date
from pyspark.sql.types import DateType
```
then depending the format our current date format is, we may want to convert it into another that contains year and month only. This will allow us later to partition our data according to year and month easily. Select which line of code you will use according to your date type format.

First, we need to change the format from dynamic frame to dataframe. This will allow us to use some the libraries previously imported


``` python 
data_DF = YOUR_DYNAMIC_FRAME.toDF()
data_DF.show()
```

Now, depending on the time format, please select which line of code you will use according to your date type format.

**ISO 8601 TIMESTAMP¶**
Below is example code that can be used to do the conversion from ISO 8601 date format.

``` python 
## Adding trx_date date column with y-M format converting a current timestamp/unix date format
data_df=data_df.withColumn('trx_date', date_format(data_df['{YOUR_DATE_COL_NAME}'], "y-M").cast(DateType()))
```

**UNIX TIMESTAMP¶**

``` python
## Adding trx_date date column with y-M format converting a current timestamp/unix date format
data_df=data_df.withColumn('trx_date', date_format(from_unixtime(data_df['{YOUR_DATE_COL_NAME}']), "y-M").cast(DateType()))
```

**OTHER DATE FORMATS¶**
To convert unique data formats, we use to_date() function to specify how to parse your value specifying date literals in second attribute (Look at resources section for more information).

``` python
## Adding trx_date date column with y-M format converting a current timestamp/unix date format
data_df=data_df.withColumn('trx_date', date_format(to_date(data_df['{YOUR_DATE_COL_NAME}'], {DATE_LITERALS}), "y-M").cast(DateType()))
```

####Example NY Taxis dataset

``` python 
## Adding trx_date date column with y-M format converting a current timestamp/unix date format
taxis_DF = taxis_conv.toDF()
taxis_date2_df=taxis_DF.withColumn('pickup_datetime', to_date("pickup_datetime", "yyyy-MM-dd HH:mm"))
taxis_date2_df.show()
```

### Join with another dataset (Optional)




## Partitioning




## Run this in a Glue Job

Now, lets export our job and move it into a glue job.

![exporting notebook to glue](./img/orchestration/notebook-to-glue.png)

1. Click File
2. Download as > Pyspark (txt)

Please open the .txt and copy it. In the AWS Glue Console (https://console.aws.amazon.com/glue/), click in 	Jobs, and **Add Job**

- Name:  `byod-data-transformation`
- IAM Role: glue-processor-role
- This job runs: A new script to be authored by you
- Monitoring - Job metrics
- Connections - Save job and edit script
- Now, paste the txt downloaded from the notebook
- Save and Run





