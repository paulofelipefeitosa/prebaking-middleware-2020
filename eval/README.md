# Evaluation

This document assumes that **R** is installed along with the following 
packages:
1. **dplyr**;
2. **ggplot2**;
3. **reshape**;
4. **ggpubr**;
5. **boot**.

This directory contains three subdirectories `function-startup`, 
`startup-components` and `choosing-ingredients`. Each subdirectory 
points to a conducted experiment. Also, inside each 
subdirectory there a subdirectory `data` and an analysis script 
`analysis.R`.

The `data` subdir holds all the data artifacts, and the analysis script 
generates the results artifacts used in the paper.

## Function Start-up Time Experiments

The `Function Start-up Time` [README.md](function-startup/README.md)
explains the format of the data CSV file, as well as documents each column 
content.

To generate the results artifacts for the `Function Start-up Experiment`,
described in the paper section `4.2`, you must run the following commands:
``` shell script
$ cd eval/function-startup
$ Rscript analysis.R > shapiro_test.out
```

After the analysis script execution, inside the same directory, two images 
plot are going to be stored: `startup_cmp_nowarmup.png` and 
`service_time.png`. These are the paper figures 3 and 7.

The file `shapiro_test.out` will hold the output of the Shapiro-Wilk 
normality test performed for the experimental results.

## Start-up Components Experiments

The `Start-up Components Experiment` [README.md](startup-components/README.md)
explains the format of the data CSV file, as well as documents each column 
content.

To generate the results artifacts for the `Start-up Components Experiment`,
described in the paper section `4.2.1`, you must run the following commands:
``` shell script
$ cd eval/startup-components
$ Rscript analysis.R
```

After the analysis script execution, inside the same directory, one image 
plot are going to be stored: `new_stacked_startup_components_bar_plot.png`.
This is the paper figure 4.

## Choosing Ingredients Experiments

The `Choosing Ingredients Experiments` [README.md](choosing-ingredients/README.md)
explains the format of the data CSV file, as well as documents each column 
content.

To generate the results artifacts for the `Choosing Ingredients Experiment`,
described in the paper section `4.2.2`, you must run the following commands:
``` shell script
$ cd eval/choosing-ingredients
$ Rscript analysis.R > startup-apps-median.out
```

After the analysis script execution, inside the same directory, two images 
plot are going to be stored: `impact_function_size_vanilla.png` and 
`impact_function_size_cmp.png`. These are the paper figures 5 and 6.

The file `startup-apps-median.out` will contain the median apps start-up 
time for each evaluated technique. The paper table 1 uses this data to 
compare the techniques start-up time.