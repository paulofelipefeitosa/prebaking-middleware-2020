require(dplyr)
require(reshape2)

load <- function(filepath, app, runtime, technique) {
  df <- read.csv(filepath)
  head(df)
  df$App <- app
  df$Runtime <- runtime
  df$Technique <- technique
  return (df)
}

noop_vanilla <- load("startup-components-noop-vanilla.csv", "NOOP", "Java", "Vanilla")
noop_pb <- load("startup-components-noop-prebaking.csv", "NOOP", "Java", "Prebaking")

ir_vanilla <- load("startup-components-image_resizer-vanilla.csv", "Image Resizer", "Java", "Vanilla")
ir_pb <- load("startup-components-image_resizer-prebaking.csv", "Image Resizer", "Java", "Prebaking")

mk_vanilla <- load("startup-components-markdown-vanilla.csv", "Markdown", "Java", "Vanilla")
mk_pb <- load("startup-components-markdown-prebaking.csv", "Markdown", "Java", "Prebaking")

all <- rbind(noop_vanilla, noop_pb,
             ir_vanilla, ir_pb,
             mk_vanilla, mk_pb)

read_bpftrace_pure_data <- function(df) {
  evaluate <- function(df, v1, v2, is_pb=FALSE, v3_opt=NA) {
    if (is_pb) {
      if (!is.na(v3_opt) && length(v1) == 1 && length(v3_opt) == 1) {
        return(df[v1] - df[v3_opt])
      } else {
        return(NA)
      }
    } else {
      if (length(v1) == 1 && length(v2) == 1) {
        return(df[v1] - df[v2])
      } else {
        return(NA)
      }
    }
  }

  return (df %>%
            group_by(Technique, Runtime, App, ExecID, ReqID) %>%
            summarise(
              CLONE = evaluate(Value, which(Metric == "CloneExit"), which(Metric == "CloneEntry")),
              EXEC = evaluate(Value, which(Metric == "ExecveExit"), which(Metric == "CloneExit")),
              RTS = evaluate(Value,
                             which(Metric == "MainEntry"),
                             which(Metric == "ExecveExit"),
                             grepl("^Prebaking", unique(Technique))),
              APPINIT = evaluate(Value,
                                 which(Metric == "Ready2Serve"),
                                 which(Metric == "MainEntry"),
                                 grepl("^Prebaking", unique(Technique)),
                                 which(Metric == "ExecveExit")),
              ST = Value[which(Metric == "ServiceTime")]) %>%
            melt(id.vars = c("Technique", "Runtime", "App", "ExecID", "ReqID"),
                 measure.vars = c("CLONE", "EXEC", "RTS", "APPINIT", "ST")) %>%
            rename("Metric" = "variable", "Value" = "value"))
}

startup_bpftrace <- all
startup_bpftrace$Value <- startup_bpftrace$Value / 10^6

bpftrace_startup <- read_bpftrace_pure_data(startup_bpftrace %>% filter(ReqID == 0))

write.csv(bpftrace_startup,
          file = "java_treated_startup_bpftrace.csv",
          row.names = FALSE)