# Choosing The (Pre)Baking Ingredients

## Data Format

The CSV file named `choosing-ingredients.csv` inside the subdirectory 
`data` contains all collected metrics during the experiments' execution. The CSV
file contains the following columns:

* **Metric** - the collected metric name, the available metrics are 
(*MainEntry*, *MainExit*, *Ready2Serve*, *RuntimeReadyTime*, *ServiceTime*,
 *LatencyTime*, *LoadedClasses*, *FindingClassesTime*, *CompilingClassesTime*,
 *LoadClassesTotalTime*, *LoadingClassesOverheadTime*) 
 that represents the raw metrics collected by the 
[Load Generator](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#collected-metrics)
along with the 
[Synthetic Function Metrics](https://github.com/paulofelipefeitosa/serverless-handlers/blob/master/README.md#synthetic-function-metrics).

* **Value_NS** - the value of the collected metric in **nanoseconds**. Please,
note that some metrics are *timestamps* and other are *time* values.

* **ExecID** - the ID of the execution when the metric was collect.

* **ReqID** - the ID of the request which triggered the metric collection.

* **Runtime** - the App Runtime that was being execute during the metric
 collection. For these experiments we only evaluated *Java*.

* **App** - the Application that was being execute during when the metric was
collect. The Choosing Ingredients Experiments evaluated the App (*NOOP Class Loader*).

* **Technique** - the technique used to start-up the application that was being
executed during the metric collection. These experiments evaluated the techniques
(*Vanilla*, *Prebaking-NOWarmup* and *Prebaking-Warmup*).

* **Loaded_Classes** - the number of classes loaded for the NOOP Class Loader
 APP on the processing of the very first request.