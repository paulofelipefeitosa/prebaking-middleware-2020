# Start-up Components Experiments

## Data Format

The CSV file named `java_treated_startup_bpftrace.csv` inside the subdirectory 
`data` contains all collected metrics during the experiments' execution. The CSV
file contains the following columns:

* **Metric** - the collected metric name, the available metrics are 
(*CLONE*, *EXEC*, *RTS*, *APPINIT* and *ST*) that represents a start-up phase. 

* **Value** - the value of the collected metric, for the Start-up Components 
Experiments the values account how long the app spend in each start-up 
phase.

* **ExecID** - the ID of the execution when the metric was collect.

* **ReqID** - the ID of the request which triggered the metric collection.

* **Runtime** - the App Runtime that was being execute during the metric
 collection. For these experiments we only evaluated *Java*.

* **App** - the Application that was being execute during when the metric was
collect. The Start-up Components Experiments evaluated the Apps (*Image Resizer*,
*Markdown* and *NOOP*).

* **Technique** - the technique used to start-up the application that was being
executed during the metric collection. These experiments evaluated the techniques
(*Vanilla*, *Prebaking* and *Prebaking-Warm*).
