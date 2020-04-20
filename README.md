# Bring Your Own Data Immersion Day (BYOD)

In this repo you'll find the sources for the BYOD Immersion Day.

## Setting up the environment

This immersion day uses `mkdocs` to create the static website.

There is also a `Makefile` with a directive to deploy the static website to an S3 bucket. If you'd like to
use a different one, change the `Makefile`.

Note that to upload automatically to S3 you need to configure your AWS CLI tool.

## Getting Started !

Ready to get started ?

* [Check the pre-requisites](labs/00_Prerequisites/Prerequisites.md)
* [Start lab 1 directly](labs/01_ingestion_with_glue/ingestion_with_glue.md)