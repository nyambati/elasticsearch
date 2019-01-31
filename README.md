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
├── terraform
│   ├── alarms.tf
│   ├── es.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── modules
│   │   ├── alarms
│   │   └── elasticsearch
│   └── terraform.tfvars

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

This is an ELasticsearch CLI explorer that enables you to achieve the following functionality
- Index data from json files
- Index data from a url
- Search based on terms and columns
- List and delete indices
- Set and view CLI configuration

The codebase has been moved [nyambati/es](https://github.com/nyambati/es) repository. Further documentation will be provided there.
