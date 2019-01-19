# elasticsearch

This repository contains scripts that will enable you to provision an elasticsearch cluster on aws and an NodeJs indexer that can be used to index data into the cluster.

## Tools & Platforms

This setups makes use of the following tools and platforms to provision and manage resources

- Terraform
- NodeJs

## Directory structure

Below is the directory structure

```
.
├── Makefile
├── README.md
├── cli
├── data
│   └── titanic.json
├── indexer
│   ├── client.js
│   └── index.js
├── package.json
├── terraform
│   ├── alarms.tf
│   ├── es.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── modules
│   │   ├── alarms
│   │   └── elasticsearch
│   └── terraform.tfvars
└── yarn.lock

```

## Usage

### Makefile commands

#### Plan

Plan command, terraform plan enables you to dry run your infrastructure and see the changes before applying them to your existing infrastructure.

```bash
$ make plan
```

#### Apply

Apply command terraform apply commit the changes to the infrastructure.

```bash
$ make apply
```

#### Refresh

In cases where you need to refresh your infrastructure state terraform refresh.

```bash
$ make refresh
```

#### Destroy

Destroy command, this command destroys the infrastructure. Run this command if you are absolutely sure you need destroy the current environment.

```bash
$ make destroy
```

## Indexer

The indexer is a NodeJs cli that enables you to index data in JSON format into the ES cluster as well as make a search. This CLI takes the following commands and options

**Commands**

- `index`- Index data into the cluster
- `search` - Search data in the cluster based on terms

**Options**

- `--src`- The source path of json file to be indexed
- `--index` - The name of the index to create
- `--type` - The type to place the indexed data
- `--count` - Number of results to be returned
- `--term` - Term to be searched
- `--url` - Host of the elastic search cluster
- `--offset` - The starting offset

You can use this command by running it as follows

```bash
# Indexing data
$ es index --src data/titanic.json --index titanic --type survivors

# Search indexed data

$ es search titanic female --count 30 --offset 5
#  search - command
# titanic - index to search from
# female - Searcch term

# set es host config
$ es config --url localhost:9200
```

Before you run this commands you will need link this package by running `npm link` and then add .env file with `ELASTICSEARCH_HOST` value, or run `es config --url localhost:9200`.
