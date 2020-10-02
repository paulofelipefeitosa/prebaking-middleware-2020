require(dplyr)
require(ggplot2)
require(ggpubr)
library(boot)

# Startup Time

# Reading data
get_startup <- function(df) {
  df <- df %>% filter(Metric == "RuntimeReadyTime" & ReqID == 0) %>% select(App, Value_NS, Technique)
  colnames(df) <- c("app", "value", "technique")
  df$value <- df$value / 10^6
  df <- df %>% mutate(app = ifelse(app == "NoOp", "NOOP", ifelse(app == "Markdown", "Markdown", "Image Resizer")))
  return(df)
}

read_startup <- function(f) {
  df <- read.csv(f)
  return(get_startup(df))
}

data <- read_startup("data/function_startup_nobpftrace.csv")

pb <- filter(data, technique == "Prebaking")
vanilla <- filter(data, technique == "Vanilla")

pb_noop <- pb %>% filter(app == "NOOP")
vanilla_noop <- vanilla %>% filter(app == "NOOP")
pb_markdown <- pb %>% filter(app == "Markdown")
vanilla_markdown <- vanilla %>% filter(app == "Markdown")
pb_thumb <- pb %>% filter(app == "Image Resizer")
vanilla_thumb <- vanilla %>% filter(app == "Image Resizer")

shapiro.test(pb_noop$value)
shapiro.test(vanilla_noop$value)
wilcox.test(vanilla_noop$value, pb_noop$value, conf.int = T)

shapiro.test(pb_thumb$value)
shapiro.test(vanilla_thumb$value)
wilcox.test(vanilla_thumb$value, pb_thumb$value, conf.int = T)

shapiro.test(pb_markdown$value)
shapiro.test(vanilla_markdown$value)
wilcox.test(vanilla_markdown$value, pb_markdown$value, conf.int = T)

# Calculate confidence intervals around the mean.
# Inspiration: https://rpubs.com/dgolicher/median_boot
median_cl_boot <- function(x, conf = 0.95) {
  lconf <- (1 - conf)/2
  uconf <- 1 - lconf
  require(boot)
  bmedian <- function(x, ind) median(x[ind])
  bt <- boot(x, bmedian, 1000)
  data.frame(y = median(x), ymin = quantile(bt$t, lconf), ymax = quantile(bt$t,
                                                                          uconf))
}

median_ci_text <- function(x, conf = 0.95) {
  lconf <- (1 - conf)/2
  uconf <- 1 - lconf
  require(boot)
  bmedian <- function(x, ind) median(x[ind])
  bt <- boot(x, bmedian, 1000)
  data.frame(y = max(x) + 12,
             label = paste0('Median=[', signif(quantile(bt$t, lconf), 2), ', ', signif(quantile(bt$t, uconf), 2), ']'))
}

# Graphing
p <- c("yellowgreen", "violetred4")  # from viridis color pallete.
data <- rbind(pb, vanilla)
ggplot(transform(data, app=factor(app, levels = c("NOOP", "Markdown", "Image Resizer"))), aes(technique, value)) +
  geom_jitter(alpha=0.2) +
  stat_summary(fun.data = median_cl_boot, geom = "errorbar") +
  stat_summary(fun.data = median_ci_text, geom = "text", size=3.5)  +
  facet_wrap(~app) +
  theme_pubclean() +
  scale_color_manual(values=p) +
  scale_y_continuous(limits = c(0, max(vanilla$value)+20), breaks = seq(0, max(vanilla$value), by = 50)) +
  labs(x="Technique", y="Startup time (ms)")+
  theme(
    legend.position="none",
    axis.title.x=element_blank(),
    panel.grid.major.y = element_line(colour = "darkgray", linetype = 3))

ggsave("startup_cmp_nowarmup.png")

# Service Time

# Reading data
get_service_time <- function(df) {
  df <- df %>% filter(Metric == "ServiceTime") %>% select(App, Value_NS, Technique)
  colnames(df) <- c("app", "value", "technique")
  df$value <- df$value / 10^6
  df <- df %>% mutate(app = ifelse(app == "NoOp", "NOOP", ifelse(app == "Markdown", "Markdown", "Image Resizer")))
  return(df)
}

read_service_time <- function(f) {
  df <- read.csv(f)
  return (get_service_time(df))
}

data <- read_service_time("data/function_startup_nobpftrace.csv")

pb <- filter(data, technique == "Prebaking")
vanilla <- filter(data, technique == "Vanilla")

p <- c("grey66", "grey1")
data <- rbind(pb, vanilla)
ggplot(transform(data, app=factor(app, levels = c("NOOP", "Markdown", "Image Resizer"))), aes(value, linetype = technique, colour = technique)) +
  facet_wrap(~app, scales="free") +
  stat_ecdf(size=0.8) +
  theme_pubclean() +
  scale_linetype_manual(values=c("solid", "dotted"))+
  scale_color_manual(values=p) +
  labs(y = "Cumulative Probability", x="Service Time (ms)", linetype="Technique", colour="Technique") +
  theme(
    legend.position="bottom",
    panel.grid.major.x = element_line(colour = "white", linetype = 3))

ggsave("service_time.png")