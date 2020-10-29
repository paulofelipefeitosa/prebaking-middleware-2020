# Prebaking Technique for ACM/IFIP Middleware 2020

This repository contains all relevant artifacts required to reproduce the experiments
conducted for the paper work "**Prebaking Functions to Warm the Serverless Cold Start**".
This repository also holds the data, and the data analysis scripts used to generate the 
paper main results.

## Reproduce Experiments

The module [serverless-handlers](https://github.com/paulofelipefeitosa/serverless-handlers) contains the required 
software to conduct the experiments described in the paper. The 
[README.md](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md) 
outlines how to run an experiment to measure serverless applications start-up time.

However, in this section we describe the required steps to reproduce all the paper 
experiments.

### Install Dependencies

First of all, you need to clone this repository by running the following commands:
``` shell script
git clone --recurse-submodules https://github.com/paulofelipefeitosa/prebaking-middleware-2020
cd prebaking-middleware-2020
```

After it, you need to install the following linux tools:
* `libcurl`, `g++`, `wget`;
* `R >= 4.0.0`.

Also, it is required to install the following R packages: 
* `dplyr`, `ggplot2`, `reshape` and `ggpubr`.

Finally, you need to install all `serverless-handlers` dependencies that 
were describe in the section 
[dependencies](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#dependencies).

Please, note that we performed our experiments using Ubuntu `16.04` with Linux kernel 
`4.15.0-45-generic-x86_64`. However, we already reproduced the experiments using 
Debian 10 with Linux kernel `4.19.0-12`.

### Function Start-up Time Experiments

The `Function Start-up Time` experiments reference to all executed experiments to generate
the results for the paper section `4.2`.

[Here](function-startup/README.md) you can access all required steps to reproduce 
the `Function Start-up Time` experiments.

### Start-up Components Experiments

The `Start-up Components` experiments reference to all conducted experiments to 
generate the results for the paper section `4.2.1`.

[Here](startup-components/README.md) you can access all required steps to reproduce 
the `Start-up Components` experiments.

### Choosing Ingredients Experiments

The `Choosing Ingredients` experiments reference to all conducted experiments to 
generate the results for the paper section `4.2.2`.

[Here](choosing-ingredients/README.md) you can access all required steps to reproduce 
the `Choosing Ingredients` experiments.

## Generate Paper Main Results from Our Data

The data along with the analysis scripts are stored inside the `eval` 
directory. [There](eval/README.md) we explain how to analyze the data 
and generate the paper main results.