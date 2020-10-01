# Start-up Components Experiments

The `Function Start-up Components` experiments points to all conducted experiments 
to generate the results for the paper section `4.2.1`.

These experiments evaluate the `NOOP`, `Image-Resizer` and `Markdown` functions 
using the `Vanilla` and `Prebaking` techniques, but measuring the following start-up
phases:
1. **CLONE**;
2. **EXEC**;
3. **RTS**;
4. **APPINIT**.

## Setup

Before executing the experiments, its required to declare two environment variables:
1. **CRIU_BINARY_PATH** - the absolute path to CRIU's executable file.
2. **JAVA_BINARY_PATH** - the absolute path to Java 8 executable file.

These two variables can be declared using the following commands:
``` shell script
# CRIU_BINARY_PATH=$(whereis criu)
# JAVA_BINARY_PATH=$(whereis java)
```
 
## NOOP

The [`NOOP`](https://github.com/paulofelipefeitosa/serverless-handlers/tree/master/functions/java/noop) 
is a do-nothing function.

Inside the current directory, create a 
[`Load Generator Config`](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#load-generator-config) 
file named `noop-config.json` which holds the following content:
``` json
{
    "Requests": 200,
    "RequestSpec": {
        "Method": "GET",
        "Path": "/"
    }
}
```

### NOOP Vanilla

Execute the `Start-up Components NOOP Vanilla` experiment using the following commands:
``` shell script
# cd serverless-handlers
# bash run-experiment.sh java noop 200 no-criu ../noop-config.json \
    --executor_process_name=${JAVA_BINARY_PATH} > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs. You can consult these files to identify any unexpected error 
during the experiment execution.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) 
will be created containing all the collected metrics during the experiment execution. 
A successful output file will hold the metrics data for 200 executions with 200 
requests each.

Please quick check this file and rename it to `startup-components-noop-vanilla.csv`.

### NOOP Prebaking

Execute the `Start-up Components NOOP Prebaking` experiment using the following commands:
``` shell script
# cd serverless-handlers
# bash run-experiment.sh java noop 200 criu ../noop-config.json \
    --executor_process_name=${CRIU_BINARY_PATH} > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) 
will be created containing all the collected metrics during the experiment execution. 
A successful output file will hold the metrics data for 200 executions with 200 
requests each.

Please quick check the output file and rename it to `startup-components-noop-prebaking.csv`.

## Image-Resizer

The [`Image-Resizer`](https://github.com/paulofelipefeitosa/serverless-handlers/tree/master/functions/java/thumbnailator) 
app scales down an image, then we need to download the image used
to evaluate the Image-Resizer application. The following command describes how to 
do it.

``` shell script
$ wget https://i.imgur.com/BhlDUOR.jpg
```

Inside the current directory, create a 
[`Load Generator Config`](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#load-generator-config) 
file named `image_resizer-config.json`, holding the below content. The `EnvVars`
property must declare the variables `scale` and `image_path`. The `image_path` var
should point to the absolute path of the downloaded image named `BhlDUOR.jpg`.

``` json
{
    "EnvVars": ["scale=0.1", "image_path={PathFromRoot}/prebaking-middleware-2020/BhlDUOR.jpg"],
    "Requests": 200,
    "RequestSpec": {
        "Method": "GET",
        "Path": "/"
    }
}
```

### Image-Resizer Vanilla

After the configuration steps, you can execute the `Start-up Components Image-Resizer Vanilla` 
experiment using the following commands:
``` shell script
# cd serverless-handlers
# bash run-experiment.sh java thumbnailator 200 no-criu ../image_resizer-config.json \
    --executor_process_name=${JAVA_BINARY_PATH} > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) 
will be created containing all collected metrics. A successful
output file will hold the metrics data for 200 executions with 200 requests each.

Please quick check this file and rename it to `startup-components-image_resizer-vanilla.csv`.

### Image-Resizer Prebaking

After the configuration steps, you can execute the `Start-up Components Image-Resizer Prebaking` 
experiment using the following commands:
``` shell script
# cd serverless-handlers
# bash run-experiment.sh java thumbnailator 200 criu ../image_resizer-config.json \
    --executor_process_name=${CRIU_BINARY_PATH} > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) 
will be created containing all collected metrics. A successful
output file will hold the metrics data for 200 executions with 200 requests each.

Please quick check this file and rename it to `startup-components-image_resizer-prebaking.csv`.

## Markdown

The [`Markdown`](https://github.com/paulofelipefeitosa/serverless-handlers/tree/master/functions/java/markdown) 
function renders markdown files into HTML. To evaluate this function we used the 
[OpenPiton](https://github.com/PrincetonUniversity/openpiton) `README.md`.

The following command downloads the file and rename it to `OpenPiton-README.md`:
``` shell script
$ wget -O OpenPiton-README.md https://raw.githubusercontent.com/PrincetonUniversity/openpiton/openpiton/README.md
```

Inside the current directory, you need to create a 
[`Load Generator Config`](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#load-generator-config) 
file named `markdown-config.json`, holding the below content. The `Bodyfilepath`
field from the `RequestSpec` property must point to the absolute path of the 
OpenPiton `README.md`.

``` json
{
    "Requests": 200,
    "RequestSpec": {
        "Method": "POST",
        "Path": "/",
        "Bodyfilepath": "{PathFromRoot}/prebaking-middleware-2020/OpenPiton-README.md"
    }
}
```

### Markdown Vanilla

Now you can execute the `Start-up Components Markdown Vanilla` 
experiment using the following commands:
``` shell script
# cd serverless-handlers
# bash run-experiment.sh java markdown 200 no-criu ../markdown-config.json \
    --executor_process_name=${JAVA_BINARY_PATH} > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) will be created 
containing all collected metrics. A successful
output file will hold the metrics data for 200 executions with 200 requests each.

Please quick check this file and rename it to `startup-components-markdown-vanilla.csv`.

### Markdown Prebaking

Now you can execute the `Start-up Components Markdown Prebaking` 
experiment using the following commands:
``` shell script
# cd serverless-handlers
# bash run-experiment.sh java markdown 200 criu ../markdown-config.json \
    --executor_process_name=${CRIU_BINARY_PATH} > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) will be created 
containing all collected metrics. A successful
output file will hold the metrics data for 200 executions with 200 requests each.

Please quick check this file and rename it to `startup-components-markdown-prebaking.csv`.

## Data Analysis

TODO(paulofelipefeitosa): describe this section.