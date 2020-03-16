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


We are going to use the data we transformed to parquet in previous steps. For that we create a dynamic frame calling the database and table name our crawler infer, then we are going to show the schema.

If you dont remeber the name, just go to Databases/ Table tab in Glue and copy its names.

``` python
taxis = glueContext.create_dynamic_frame.from_catalog(database="DATABASE_NAME", table_name="TABLE_NAME")
taxis.printSchema()
```

## Transformations

You probably have a large number of columns and some of them can have complicated names. To analyze the data, perphaps we may not need all the columns, just a small set of them and to make easier to recall we may want to change the name of the column. Therefore, we are going to select only the columns we are interested in, drop the rest of them and we are going to rename them.

### Drop Columns


``` python
taxis_conv=taxis.select_fields(['COLUMN1_TO_KEEP/RENAME','COLUMN2_TO_KEEP']).rename_field('COLUMN1_TO_KEEP/RENAME', 'NEW_COLUMN_NAME')
taxis_conv.printSchema()
```

For my taxis example
``` python
taxis_conv=taxis.select_fields(['tpep_pickup_datetime','trip_distance']).rename_field('tpep_pickup_datetime', 'pickup_datetime')
taxis_conv.printSchema()
```


### Convert to Time stamp


``` python 
from pyspark.sql.functions import to_date
taxis_DF = taxis_conv.toDF()
taxis_DF.show()
```

``` python 
## Adding trx_date date column with y-M format converting a current timestamp/unix date format
taxis_date2_df=taxis_DF.withColumn('pickup_datetime', to_date("pickup_datetime", "yyyy-MM-dd HH:mm"))
taxis_date2_df.show()
```

### Join with another dataset (Optional)




## Partitioning




