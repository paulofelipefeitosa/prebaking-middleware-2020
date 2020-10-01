# Prebaking Technique for ACM/IFIP Middleware 2020

This repository contains all relevant artifacts required to reproduce the experiments
conducted for the paper work "**Prebaking Functions to Warm the Serverless Cold Start**".
This repository also holds the data, and the data analysis scripts used to generate the 
paper main results.

## Reproduce the Experiments

The module [serverless-handlers](https://github.com/paulofelipefeitosa/serverless-handlers) contains the required 
software to conduct the experiments described in the paper. The 
[README.md](https://github.com/paulofelipefeitosa/serverless-handlers/README.md) outlines how to run an experiment to 
measure serverless applications start-up time.

However, in this section we describe the required steps to reproduce all the paper 
experiments.

### Install Dependencies

First of all, its required to install all `serverless-handlers` dependencies that 
were describe in section [dependencies](https://github.com/paulofelipefeitosa/serverless-handlers/README.md#dependencies).

In addition, you need to install `wget` in order to execute the commands used in 
the next sections. 

### Function Start-up Time Experiments

`Function Start-up Time` experiments reference to all executed experiments to generate
the results for the paper section `4.2`.

[Here](function-startup/README.md) you can access all required steps to reproduce 
the `Function Start-up Time` experiments.

## Data

TODO(paulofelipefeitosa): describe this section.

### Analysis

TODO(paulofelipefeitosa): describe this subsection.