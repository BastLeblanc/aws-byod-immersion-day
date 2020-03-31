  
- [Lab 3: Interactive SQL Queries Using Amazon Athena](#Lab-3-Interactive-SQL-Queries-Using-Amazon-Athena)
	- [Introduction](#Introduction)
	- [Architectural Diagram](#Architectural-Diagram)
	- [Setting up Workgroups](#Setting-up-Workgroups)
	- [Setting up Amazon S3 and Athena for Storing Query Results](#Setting-up-Amazon-S3-and-Athena-for-Storing-Query-Results)
		- [Creating an Amazon S3 Bucket](#Creating-an-Amazon-S3-Bucket)
		- [Setting up Amazon Athena](#Setting-up-Amazon-Athena)
	- [Start Exploring with Athena](#Start-Exploring-with-Athena)
	- [Amazon Athena Best Practices](#Amazon-Athena-Best-Practices)
	- [Joining Tables](#Joining-Tables)
		- [Create a new Table](#Create-a-new-Table)
		- [SQL Joins](#SQL-Joins)
		- [Storing SQL Join Results](#Storing-SQL-Join-Results)
	- ['Create Table as Select' Queries](#Create-Table-as-Select-Queries)
	- [Creating Views](#Creating-Views)


# Lab 3: Interactive SQL Queries Using Amazon Athena



## Introduction

Amazon Athena is an interactive query service that makes it easy to analyze data in Amazon S3 using standard SQL. Athena is serverless, so there is no infrastructure to setup or manage, and you can start analyzing data immediately. You don’t even need to load your data into Athena, it works directly with data stored in S3.

In this lab, we will use Athena to explore, analyze and prepare the data for visualization in QuickSight. This lab is divided into three sections; one manadatory and two optional:

*  To start working with Athena, continue on this lab and follow throught the different section. Next lab is [Setting up Workgroups](#setting-up-workgroups)
*  [Optional] In [lab 1](../01_ingestion_with_glue/ingestion_with_glue.md), we used Glue Crawlers to create our Database and Tables. To create your Database and tables using Athena, click [here](./optional.md)
*  [Optional] To review Athena best practices, click on [Amazon Athena Best Practices](./athena_best_practices.md)


## Architectural Diagram

This is an example Architecture, the raw data is stored in S3 in CSV format and the curated data is stored in another S3 bucket in Parquet. While you might have a different setup, this is only for illustrative purposes. Amazon Athena will be used to query both data sources if needed. 

![architecture-overview-lab2.png](https://s3.amazonaws.com/us-east-1.data-analytics/labcontent/reinvent2017content-abd313/lab2/architecture-overview-lab2.png)

  

## Setting up Workgroups

  

Workgroups are used to isolate queries for teams, applications, or different workloads. Workgroups offer some benefits such as:

  

- Enforcing cost constraints - you can apply a limit for each workgroup or you can limit the data scanned by each query.

- Track query-related metrics for all workgroup queries in CloudWatch.

  

You may create separate workgroups for different teams in your organisation. In this lab, we will create a workgroup for our Quicksight Users

  

1. Open the [AWS Management Console for Athena](https://console.aws.amazon.com/athena/home).

  

2. Make sure you are in the same region as the previous labs.

  

3. If this is your first time visiting the AWS Management Console for Athena, you will get a Getting Started page. Choose **Get Started** to open the Query Editor.

  

4. Click on **Workgroup:Primary**. In the Workgroup page, click on **Create workgroup**

![image](img/athena_workgroup.png)

  

5. In the new page, enter the **Workgroup name**, **Description** and click on **Create workgroup**.

![image](img/athena_workgroup_general.png)

  

6. In the Workgroup page, select the newly created workgroup and click on **Switch workgroup**.

![image](img/athena_workgroup_switch.png)

  

7. In the top bar, make sure you are currently on the new workgroup.

![image](img/athena_workgroup_validate.png)

  

## Setting up Amazon S3 and Athena for Storing Query Results

  

If you’re a first time Athena user, you will have to configure an S3 bucket, where Athena will store the query results.

  

### Creating an Amazon S3 Bucket

  

> Note: If you have already have an S3 bucket in your AWS Account and can be used to store Athena Query results, you can skip this section.

  

1. Open the [AWS Management console for Amazon S3](https://s3.console.aws.amazon.com/s3/home?region=eu-west-1)

  

2. On the S3 Dashboard, Click on **Create Bucket**.

  

  

![image](img/create-bucket.png)

  

  

3. In the **Create Bucket** pop-up page, input a unique **Bucket name**. It is advised to choose a large bucket name, with many random characters and numbers (no spaces).

  

  

1. Select the region and make sure you are using the same region used throughout the lab.

  

2. Click **Next** to navigate to next tab.

  

3. In the **Set properties** tab, leave all options as default.

  

4. In the **Set permissions** tag, leave all options as default.

  

5. In the **Review** tab, click on **Create Bucket**

  

![image](img/athena-s3.png)

  

### Setting up Amazon Athena

  

You can use an already existing bucket with a dedicated folder or you can create a new, dedicated bucket.

  

1. Navigate to Athena console

2. Make sure you are on the right workgroup and click on **Settings** on the top bar

  

3. Fill in the required information and click **Save**

  

![image](img/athena-setup.png)

  

> Note: Make sure you have forward slash at the end of the S3 path

  

## Start Exploring with Athena

  

After initial setup you can start exploring your data with Athena. You can run normal SQL queries using the **Query Editor** in Athena console. To run your first query follow the below:

  

> Note: If you do not have a database created, you can follow [Lab 1: Ingestion with Glue](../01_ingestion_with_glue/ingestion_with_glue.md) to create your first database. Alternatively, you can follow this lab to [create your first database and table using Athena](./optional.md#creating-amazon-athena-database-and-table).

  

1. Navigate to Athena console

  

2. In the right pane, choose the database name

![image](img/athena-db-selec.png)

  

3. After selecting the DB, browse the tables and explore the schema clicking on the table.

![image](img/athena-table-selec.png)

  

4. On the left pane, enter the first query and click on **Run query**

![image](img/athena-first-query.png)

  
  

## Amazon Athena Best Practices

**[OPTIONAL]**

  

*Columnar Storage*, *Partitioning* and *Bucketing* are common best practices that should be used to store and structure the data to be analysed with Athena.

  

In [Lab 1: Ingestion with Glue](../01_ingestion_with_glue/ingestion_with_glue.md) we converted the data format from *row-based* (csv, json, etc..) to columnar (parquet). To explore other optimisations that could be employed, check [Athena Best Practices Lab](./athena_best_practices.md). In addition to this, see [Top Performance Tuning Tips for Amazon Athena](http://aws.amazon.com/blogs/big-data/top-10-performance-tuning-tips-for-amazon-athena/) for general best practices that should be done when working with Athena.

  

## Joining Tables

This section shows how to join two tables together.

  

### Create a new Table

> Note: If you already have *two* tables that could be joined together skip this step and proceed to [next sub-section](#sql-joins)

>

Before joining *two* tables, let's create a new table (with mocked data) and will refer to it in this lab as {table2}with a foreign key relationship with our *{curated_table_name}*

  

1. Open the [AWS Management Console for Athena](https://console.aws.amazon.com/athena/home) and make sure you are on the same AWS Region.

2. Choose the *{curated database}* from the dropdown menu and execute the following query:

```sql

CREATE  EXTERNAL  TABLE {table2} (

  

{col1} BIGINT,

  

{col2} STRING,

  

col{3} BIGINT,

  

...........

  

)

  

STORED AS  PARQUET

  

LOCATION  ''s3://{athena-s3-bucket}/{table2}/''

  

```

  

> Note: You not need to create the S3 folder before running the query; Athena will do it for you. Just choose the S3 path to store the data. Feel free to use any path as long as you own the S3 bucket and it is in the same region you are using through out this lab.

  

3. Now let's insert some mocked data to the new table. The data should have foreign key relationship with the original table.

```sql

INSERT  INTO {table2} ({column1},{column2}, {column3}, ...)

VALUES ({value1.1}, {value2.1}, {value3.1}, ...),

({value1.2}, {value2.2}, {value3.2}, ...),

({value1.3}, {value2.3}, {value3.3}, ...)

............;

```

  

![image](img/athena_insert.png)

  

4. Make sure the data is inserted by executing ```SELECT * FROM {table2}```

  

### SQL Joins

  

Here are the different types of the JOINs in SQL:

  

-  *Inner Join*:- Returns records that have matching values in both tables. Run the following query in the **Query Editor**

```sql

SELECT {table1}.{col1}, {table2}.{col3}, {table2}.{col5}

FROM {table1}

INNER JOIN {table2} ON {table1}.{key}={table2}.{key}

```

-  *Left Join*:- If you use the same query but replace ```INNER``` with ```LEFT```. We will see records from left table and the matched records from the right table

```sql

SELECT {table1}.{col1}, {table2}.{col3}, {table2}.{col5}

FROM {table1}

LEFT JOIN {table2} ON {table1}.{key}={table2}.{key}

```

-  *Right Join*:- Returns all records from the right table, and the matched records from the left table

```sql

SELECT {table1}.{col1}, {table2}.{col3}, {table2}.{col5}

FROM {table1}

RIGHT JOIN {table2} ON {table1}.{key}={table2}.{key}

```

-  *Full Join*:- All records are returned

```sql

SELECT {table1}.{col1}, {table2}.{col3}, {table2}.{col5}

FROM {table1}

FULL JOIN {table2} ON {table1}.{key}={table2}.{key}

```

  

### Storing SQL Join Results

  

There are two options to store the results from a SQL join statement; *physically* and *virtually*

  

-  *Physically:* When the results are written to S3. Useful, if the data does not change frequently. This is useful when integrating Quicksight with Athena. To store the join results in S3, check [Create Table as Select Queries](#create-table-as-select-queries)

-  *Virtually*: A logical representation of the data is stored as View. Every time the view queried, the query the created the view runs again. To create a view from the join, check [Creating Views](#creating-views)

  

## 'Create Table as Select' Queries

A `CREATE TABLE AS SELECT` (CTAS) query creates a new table in Athena from the results of a `SELECT` statement from another query. Athena stores data files created by the CTAS statement in a specified location in Amazon S3.

  

This is useful in joins because it creates tables from join query results in one step, without repeatedly querying raw data sets. In this section we walk through how create a table from join query (or any query) results and store it in S3.

  

1. Open the [AWS Management Console for Athena](https://console.aws.amazon.com/athena/home) and make sure you are on the same AWS Region.

2. Choose the *{curated database}* from the dropdown menu and execute the following query:

> Note: Make sure that the S3 folder [used to store the files] is empty before running the query. If the folder contains any objects, the query will fail.

> There is no need to create the folder before running the query, Athena will create it for you.

```sql

CREATE  Table {join_table_name}

WITH (

format = 'PARQUET',

external_location = 's3://{athena-s3-bucket}/{join_table_folder}',

partitioned_by = ARRAY['{col1}','{col2}']#optional

AS {your_join_query}

```

The above query creates a new table, stores the results in parquet format, in this s3://{athena-s3-bucket}/{join_table_folder} location.

  
  

3. Wait for the query to execute. After it finishes you can see the newly created view under **Tables** on the right pane.

  

![image](img/athena-join-table.png)

  

## Creating Views

**[OPTIONAL]**

  

A view in Amazon Athena is a logical, not a physical table. The query that defines a view runs each time the view is referenced in a query. In this section, we walk through how to create a view:

  

1. Open the [AWS Management Console for Athena](https://console.aws.amazon.com/athena/home) and make sure you are on the same AWS Region.

2. Choose the *{curated database}* from the dropdown menu and execute the following query:

```sql

CREATE VIEW {view_name} AS {your_query}

```

  

3. Wait for the query to execute. After it finishes you can see the newly created view under **Views** on the right pane.

  

![image](img/athena-view-create.png)

  

4. To query a view, run the following:

```sql

SELECT * FROM {view_name}

```

5. To update a view, run the following

```sql

CREATE [ OR REPLACE ] VIEW {view_name} AS {your_query}

```

Now go to lab 4 : [Vizualization](../04_visualization_and_reporting/README.md)