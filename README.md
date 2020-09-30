# Prebaking Technique for ACM/IFIP Middleware 2020

This repository contains all relevant artifacts required to reproduce the experiments
conducted for the paper work "**Prebaking Functions to Warm the Serverless Cold Start**".
This repository also holds the data, and the data analysis scripts used to generate the 
paper main results.

## Reproduce the Experiments

The module [serverless-handlers](serverless-handlers) contains the required 
software to conduct the experiments described in the paper. The 
[README.md](serverless-handlers/README.md) outlines how to run an experiment to 
measure serverless applications start-up time.

However, in this section we describe the required steps to reproduce all the paper 
experiments.

### Install Dependencies

First of all, its required to install all `serverless-handlers` dependencies that 
were describe in section [dependencies](serverless-handlers/README.md#dependencies).

### Function Start-up Time Experiment

Function Start-up Time experiment points to all executed experiments to generate
the results for the paper section `4.2`.
 
#### NOOP

Inside the current directory, create a 
[`Load Generator Config`](serverless-handlers/README.md#load-generator-config) 
file named `noop-vanilla-config.json` which holds the following content:
``` json
{
    "Requests": 200,
    "RequestSpec": {
        "Method": "GET",
        "Path": "/"
    }
}
```

##### Vanilla

Execute the experiment using the following commands:
``` shell script
cd serverless-handlers
bash run-experiment.sh java noop 200 no-criu ../noop-vanilla-config.json > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs. You can consult these files to identify any unexpected error 
during the experiment execution.

If the above commands execute successfully, then an 
[output CSV file](serverless-handlers/README.md#results-artifact) will be created 
containing all the collected metrics during the experiment execution. A successful
output file will hold the metrics data for 200 executions with 200 requests each.

Please quick check this file and rename it to `startup-time-java-noop-vanilla.csv`.

##### Prebaking

Execute the experiment using the following commands:
``` shell script
cd serverless-handlers
bash run-experiment.sh java noop 200 criu ../noop-vanilla-config.json > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs. You can consult these files to identify any unexpected error 
during the experiment execution.

If the above commands execute successfully, then an 
[output CSV file](serverless-handlers/README.md#results-artifact) will be created 
containing all the collected metrics during the experiment execution. A successful
output file will hold the metrics data for 200 executions with 200 requests each.

Please quick check this file and rename it to `startup-time-java-noop-vanilla.csv`.

#### Java Image-Resizer

[Download the image...]

##### Vanilla

##### Prebaking

TODO(paulofelipefeitosa):

## Data

TODO(paulofelipefeitosa): describe this section.

## Data Analysis

TODO(paulofelipefeitosa): describe this section.