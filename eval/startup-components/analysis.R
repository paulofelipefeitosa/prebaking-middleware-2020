# Metrics:
# InitializationTime -> time between the exec of the function and until it is ready to start serving requests.
# ExecID -> Treatment replica ID
# ReqID -> ID of the request within the treatment replica (0 meaning the first request)

require(dplyr)
require(ggplot2)
require(ggpubr)
library(boot)

bpftrace_startup <- read.csv("data/java_treated_startup_bpftrace.csv") %>% filter(is.na(Value) == FALSE)

calc_perc <- function(df){
  df <- df %>%
    group_by(Runtime, App, Technique, Metric) %>%
    summarise(sum=sum(Value),
              med=median(Value),
              p99=quantile(Value, 0.99)) %>%
    mutate(perc=signif((sum/sum(sum))*100, digits=3))
  return(df)
}

perc_bpftrace_startup <- calc_perc(bpftrace_startup)

p <- c("yellowgreen", "skyblue4", "violetred4")  # from viridis color pallete.

ggplot(transform(perc_bpftrace_startup, App=factor(App, levels = c("NOOP", "Markdown", "Image Resizer"))) %>%
         filter(Metric != "ST", Technique != "Prebaking Warm")) +
  #facet_grid(Runtime~App) +
  facet_grid(.~App) +
  geom_bar(aes(y = med,
               x = factor(Technique, c("Prebaking", "Vanilla")),
               fill = factor(Metric, c("APPINIT", "RTS", "EXEC", "CLONE"))),
           stat = "identity") +
  labs(fill = "Metric", x = "Technique", y = "Cold Start Latency (ms)") +
  theme_pubclean() +
  theme_bw() +
  scale_fill_grey(start = 0, end = 0.85) +
  theme(panel.grid.major.y = element_line(colour = "darkgray", linetype = 3))
#axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("new_stacked_startup_components_bar_plot.png")