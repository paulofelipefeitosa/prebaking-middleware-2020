# Function Start-up Time Experiments

Function Start-up Time experiments points to all executed experiments to generate
the results for the paper section `4.2`.

These experiments evaluate the `NOOP`, `Image-Resizer` and `Markdown` functions 
using the `Vanilla` and `Prebaking` techniques.

## Setup

The following bash commands may require `super user` rights.
 
## NOOP

The [`NOOP`](https://github.com/paulofelipefeitosa/serverless-handlers/tree/master/functions/java/noop) 
is a do-nothing function, and for this function we should perform two experiments:
`Vanilla` and `Prebaking`.

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

After the configuration steps, we should execute the `Function Start-up NOOP Vanilla` 
experiment using the following commands:
``` shell script
# cd serverless-handlers
# bash run-experiment.sh java noop 200 no-criu ../noop-config.json > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs. You can consult these files to identify any unexpected error 
during the experiment execution.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) 
will be created containing all the collected metrics during the experiment execution. 
A successful output file will hold the metrics data for 200 executions with 200 
requests each.

Please quick check this file and rename it to `startup-time-noop-vanilla.csv`.

### NOOP Prebaking

Now, we can execute the `Function Start-up NOOP Prebaking` experiment using the 
following commands:
``` shell script
# cd serverless-handlers
# bash run-experiment.sh java noop 200 criu ../noop-config.json > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) 
will be created containing all the collected metrics during the experiment execution. 
A successful output file will hold the metrics data for 200 executions with 200 
requests each.

Please quick check the output file and rename it to `startup-time-noop-prebaking.csv`.

## Image-Resizer

The [`Image-Resizer`](https://github.com/paulofelipefeitosa/serverless-handlers/tree/master/functions/java/thumbnailator) 
app scales down an image, then we need to download the image used
to evaluate the Image-Resizer application. The following command describes how to 
do it.

``` shell script
$ wget https://i.imgur.com/BhlDUOR.jpg
```

The `Image-Resizer` function was evaluate in the two experimental scenarios: 
`Vanilla` and `Prebaking`.

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

After the configuration steps, you can execute the `Function Start-up Image-Resizer Vanilla` 
experiment using the following commands:
``` shell script
# cd serverless-handlers
# bash run-experiment.sh java thumbnailator 200 no-criu ../image_resizer-config.json > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) 
will be created containing all collected metrics. A successful
output file will hold the metrics data for 200 executions with 200 requests each.

Please quick check this file and rename it to `startup-time-image_resizer-vanilla.csv`.

### Image-Resizer Prebaking

Now, you can execute the `Function Start-up Image-Resizer Prebaking` 
experiment using the following commands:
``` shell script
# cd serverless-handlers
# bash run-experiment.sh java thumbnailator 200 criu ../image_resizer-config.json > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) 
will be created containing all collected metrics. A successful
output file will hold the metrics data for 200 executions with 200 requests each.

Please quick check this file and rename it to `startup-time-image_resizer-prebaking.csv`.

## Markdown

The [`Markdown`](https://github.com/paulofelipefeitosa/serverless-handlers/tree/master/functions/java/markdown) 
function renders markdown files into HTML. To evaluate this function we used the 
[OpenPiton](https://github.com/PrincetonUniversity/openpiton) `README.md`.

The following command downloads the file and rename it to `OpenPiton-README.md`:
``` shell script
$ wget -O OpenPiton-README.md https://raw.githubusercontent.com/PrincetonUniversity/openpiton/openpiton/README.md
```

The `Markdown` function must be evaluated by two experiments: `Vanilla` and `Prebaking`.

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

First, we should execute the `Function Start-up Markdown Vanilla` 
experiment using the following commands:
``` shell script
# cd serverless-handlers
# bash run-experiment.sh java markdown 200 no-criu ../markdown-config.json > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) will be created 
containing all collected metrics. A successful
output file will hold the metrics data for 200 executions with 200 requests each.

Please quick check this file and rename it to `startup-time-markdown-vanilla.csv`.

### Markdown Prebaking

And finally, we must execute the `Function Start-up Markdown Prebaking` 
experiment using the following commands:
``` shell script
# cd serverless-handlers
# bash run-experiment.sh java markdown 200 criu ../markdown-config.json > log.out 2> log.err
```
The files `log.out` and `log.err` file will contain the `stdout` and `stderr` 
execution logs.

If the above commands execute successfully, then an 
[output CSV file](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#results-artifact) will be created 
containing all collected metrics. A successful
output file will hold the metrics data for 200 executions with 200 requests each.

Please quick check this file and rename it to `startup-time-markdown-prebaking.csv`.

## Data Analysis

TODO(paulofelipefeitosa): describe this section.

### Service Time

TODO(paulofelipefeitosa): describe this section.