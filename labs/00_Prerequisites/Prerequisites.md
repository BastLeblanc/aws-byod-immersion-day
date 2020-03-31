# Prerequisites

Before getting straight into the lab, you need to follow these preparation steps. The labs are designed in a "bring your own data" mindset, these instructions are here to help you prepare you own dataset.
 
- Choose your preferred dataset.
  - The best way is to bring your data, but if you just want to trial the workshop, you can use sample public datasets:
  - You can download free samples from different websites. https://www.kaggle.com/ is a good example that we used before. Most probably the dataset will include date column(s), which will be used a lot in the labs.
- Your data set size should not exceed 2 – 3 GB max.
- Data with multiple related tables via foreign keys are supported.
- Data with nested fields like JSON structures are NOT supported.
- Structure your data in S3 so that each table would be in a separate folder, with the whole data in separate bucket. (explained in lab 1)
- Before uploading your data files to S3, make sure the files are UTF-8 encoding format. You can use terminal commands to detect your current format and use Mac TextEdit to convert (will differ on your used OS).
 
Ready to go to lab 1 : [Ingestion with Glue](../01_ingestion_with_glue/ingestion_with_glue.md)