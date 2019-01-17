# elasticsearch

This repository contains scripts that will enable you to provision an elasticsearch cluster on aws and an NodeJs indexer that can be used to index data into the cluster.

## Tools & Platforms

This setups makes use of the following tools and platforms to provision and manage resources

Terraform
NodeJs

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

The indexer is a NodeJs cli that enables you to index data in JSON format into the ES cluster. This CLI takes the following options

- `--src`- The source path of json file to be indexed ( alias -s)
- `--index` - The name of the index to create (alias -i)
- `--type` - The type to place the indexed data in ( alias -t)

You can use this command by running it as follows

```bash
$ node cli --src data/titanic.json --index titanic --type survivors
#or
$ ./cli --src data/titanic.json --index titanic --type survivors
```

Before you run this command you will need to add .env file and add `ELASTICSEARCH_HOST` value. This will inform the script where the elastic search host is
