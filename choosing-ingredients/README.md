# Choosing The (Pre)Baking Ingredients

The Choosing The (Pre)Baking Ingredients experiments reference to all conducted
experiments for the paper section `4.2.2`. These experiments evaluate three functions
with different size of dependencies:
1. **`Small`** - dependencies with 50 classes.
2. **`Medium`** - dependencies with 250 classes.
3. **`Big`** - dependencies with 1250 classes.

## Setup

Inside the `choosing-ingredients` directory there are two subdirectories named 
`synthetic-classes` and `app-jars`.

The `synthetic-classes` subdirectory holds the jars that contain the java classes of the 
`Small`, `Medium` and `Big` synthetic functions.

The `app-jars` subdirectory holds the 
[`NOOP Class Loader`](https://github.com/paulofelipefeitosa/serverless-handlers/tree/master/functions/java/noop-class-loader) 
function jar along with each synthetic function classes.

Please note that, all the following bash commands may require `super user` rights.

## NOOP Class Loader

The [`NOOP Class Loader`](https://github.com/paulofelipefeitosa/serverless-handlers/tree/master/functions/java/noop-class-loader)
is a function that has no business logic, but imports, compiles and uses a bunch of 
classes during its execution.

Before proceeding to the experiment details, inside the `prebaking-middleware-2020` directory, create a 
[`Load Generator Config`](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#load-generator-config) 
file named `noop-class-loader-config.json` which will hold the following content:
``` json
{
    "Requests": 2,
    "RequestSpec": {
        "Method": "GET",
        "Path": "/"
    }
}
```

## Small

The `Small` synthetic function contains 50 classes that should be loaded by the 
NOOP Class Loader function when processing the very first request.

For the `Small` synthetic function we must perform three experiments: `Vanilla`, 
`Prebaking-NOWarmup`, and `Prebaking-Warmup`.

Before executing the experiments, you should copy the `Small` App jar to the `NOOP
Class Loader` maven target directory, and then rename the jar filename to 
`app-0.0.1-SNAPSHOT-jar-with-dependencies.jar`. You can do these steps by running
the following commands:
``` bash
$ mkdir -p serverless-handlers/functions/java/noop-class-loader/target
$ cp choosing-ingredients/app-jars/noop-class-loader-small.jar \ 
    serverless-handlers/functions/java/noop-class-loader/target/app-0.0.1-SNAPSHOT-jar-with-dependencies.jar
```

### Vanilla

After the configuration steps, you can execute the `Choosing Ingredients NOOP Small Vanilla` 
experiment using the following commands:

``` bash
# cd serverless-handlers
# bash run-experiment.sh java noop-class-loader 200 no-criu ../noop-class-loader-config.json \
    --sf_jar_path=../choosing-ingredients/synthetic-classes/small.jar > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs. You can consult these files to identify any unexpected error 
during the experiment execution.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) 
will be created containing all the collected metrics during the experiment execution. 
A successful output file will hold the metrics data for 200 executions with 2 
requests each.

Please quick check this file and rename it to `ingredients-noop-small-vanilla.csv`.

### Prebaking-NOWarmup

Now, you can execute the `Choosing Ingredients NOOP Small Prebaking-NOWarmup` 
experiment using the following commands:

``` bash
# cd serverless-handlers
# bash run-experiment.sh java noop-class-loader 200 criu ../noop-class-loader-config.json \
    --sf_jar_path=../choosing-ingredients/synthetic-classes/small.jar > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) 
will be created containing all collected metrics during the experiment execution. 
A successful output file will hold the metrics data for 200 executions with 2 
requests each.

Please quick check this file and rename it to `ingredients-noop-small-prebaking.csv`.

### Prebaking-Warmup

And finally, you can execute the `Choosing Ingredients NOOP Small Prebaking-Warmup` 
experiment using the following commands:

``` bash
# cd serverless-handlers
# bash run-experiment.sh java noop-class-loader 200 criu ../noop-class-loader-config.json \
    --sf_jar_path=../choosing-ingredients/synthetic-classes/small.jar \
    --warm_req > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) 
will be created containing all collected metrics during the experiment execution. 
A successful output file will hold the metrics data for 200 executions with 2 
requests each.

Please quick check this file and rename it to `ingredients-noop-small-prebaking-warm.csv`.

## Medium

The `Medium` synthetic function contains 250 classes that should be loaded by the 
NOOP Class Loader function when processing the very first request.

For the `Medium` synthetic function we must perform three experiments: `Vanilla`, 
`Prebaking-NOWarmup`, and `Prebaking-Warmup`.

Before executing the experiments, you should copy the `Medium` App jar to the `NOOP
Class Loader` maven target directory, and then rename the jar filename to 
`app-0.0.1-SNAPSHOT-jar-with-dependencies.jar`. You can do these steps by running
the following commands:
``` bash
$ mkdir -p serverless-handlers/functions/java/noop-class-loader/target
$ cp choosing-ingredients/app-jars/noop-class-loader-medium.jar \ 
    serverless-handlers/functions/java/noop-class-loader/target/app-0.0.1-SNAPSHOT-jar-with-dependencies.jar
```

### Vanilla

After the configuration steps, you can execute the `Choosing Ingredients NOOP Medium Vanilla` 
experiment using the following commands:

``` bash
# cd serverless-handlers
# bash run-experiment.sh java noop-class-loader 200 no-criu ../noop-class-loader-config.json \
    --sf_jar_path=../choosing-ingredients/synthetic-classes/medium.jar > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs. You can consult these files to identify any unexpected error 
during the experiment execution.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) 
will be created containing all the collected metrics during the experiment execution. 
A successful output file will hold the metrics data for 200 executions with 2 
requests each.

Please quick check this file and rename it to `ingredients-noop-medium-vanilla.csv`.

### Prebaking-NOWarmup

Now, you can execute the `Choosing Ingredients NOOP Medium Prebaking-NOWarmup` 
experiment using the following commands:

``` bash
# cd serverless-handlers
# bash run-experiment.sh java noop-class-loader 200 criu ../noop-class-loader-config.json \
    --sf_jar_path=../choosing-ingredients/synthetic-classes/medium.jar > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) 
will be created containing all collected metrics during the experiment execution. 
A successful output file will hold the metrics data for 200 executions with 2 
requests each.

Please quick check this file and rename it to `ingredients-noop-medium-prebaking.csv`.

### Prebaking-Warmup

And finally, you can execute the `Choosing Ingredients NOOP Medium Prebaking-Warmup` 
experiment using the following commands:

``` bash
# cd serverless-handlers
# bash run-experiment.sh java noop-class-loader 200 criu ../noop-class-loader-config.json \
    --sf_jar_path=../choosing-ingredients/synthetic-classes/medium.jar \
    --warm_req > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) 
will be created containing all collected metrics during the experiment execution. 
A successful output file will hold the metrics data for 200 executions with 2 
requests each.

Please quick check this file and rename it to `ingredients-noop-medium-prebaking-warm.csv`.

## Big

The `Big` synthetic function contains 1250 classes that should be loaded by the 
NOOP Class Loader function when processing the very first request.

For the `Big` synthetic function we must perform three experiments: `Vanilla`, 
`Prebaking-NOWarmup`, and `Prebaking-Warmup`.

Before executing the experiments, you should copy the `Big` App jar to the `NOOP
Class Loader` maven target directory, and then rename the jar filename to 
`app-0.0.1-SNAPSHOT-jar-with-dependencies.jar`. You can do these steps by running
the following commands:
``` bash
$ mkdir -p serverless-handlers/functions/java/noop-class-loader/target
$ cp choosing-ingredients/app-jars/noop-class-loader-big.jar \ 
    serverless-handlers/functions/java/noop-class-loader/target/app-0.0.1-SNAPSHOT-jar-with-dependencies.jar
```

### Vanilla

After the configuration steps, you can execute the `Choosing Ingredients NOOP Big Vanilla` 
experiment using the following commands:

``` bash
# cd serverless-handlers
# bash run-experiment.sh java noop-class-loader 200 no-criu ../noop-class-loader-config.json \
    --sf_jar_path=../choosing-ingredients/synthetic-classes/big.jar > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs. You can consult these files to identify any unexpected error 
during the experiment execution.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) 
will be created containing all the collected metrics during the experiment execution. 
A successful output file will hold the metrics data for 200 executions with 2 
requests each.

Please quick check this file and rename it to `ingredients-noop-big-vanilla.csv`.

### Prebaking-NOWarmup

Now, you can execute the `Choosing Ingredients NOOP Big Prebaking-NOWarmup` 
experiment using the following commands:

``` bash
# cd serverless-handlers
# bash run-experiment.sh java noop-class-loader 200 criu ../noop-class-loader-config.json \
    --sf_jar_path=../choosing-ingredients/synthetic-classes/big.jar > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) 
will be created containing all collected metrics during the experiment execution. 
A successful output file will hold the metrics data for 200 executions with 2 
requests each.

Please quick check this file and rename it to `ingredients-noop-big-prebaking.csv`.

### Prebaking-Warmup

And finally, you can execute the `Choosing Ingredients NOOP Medium Prebaking-Warmup` 
experiment using the following commands:

``` bash
# cd serverless-handlers
# bash run-experiment.sh java noop-class-loader 200 criu ../noop-class-loader-config.json \
    --sf_jar_path=../choosing-ingredients/synthetic-classes/big.jar \
    --warm_req > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) 
will be created containing all collected metrics during the experiment execution. 
A successful output file will hold the metrics data for 200 executions with 2 
requests each.

Please quick check this file and rename it to `ingredients-noop-big-prebaking-warm.csv`.

# Data Analysis

TODO(paulofelipefeitosa): describe this section.