require(dplyr)
require(ggplot2)
require(ggpubr)
library(boot)

load <- function(filepath, app, runtime, technique) {
  df <- read.csv(filepath)
  head(df)
  df$App <- app
  df$Runtime <- runtime
  df$Technique <- technique
  return (df)
}

nocriu_nobpf_nowarm_java_markdown <- load("data/java-no-criu-markdown-1599601948-200---.csv", "Markdown", "Java", "Vanilla") %>%
  rename("Value_NS" = "KernelTime_NS")
criu_nobpf_nowarm_java_markdown <- load("data/java-criu-markdown-1599612651-200---.csv", "Markdown", "Java", "Prebaking") %>%
  rename("Value_NS" = "KernelTime_NS")


# Metrics:
# RuntimeReadyTime -> time between the start of the function and until it is ready to start serving requests.
# ExecID -> Treatment replica ID
# ReqID -> ID of the request within the treatment replica (0 meaning the first request)

# Reading data
get_startup <- function(df) {
  df <- df %>% filter(Metric == "RuntimeReadyTime" & ReqID == 0) %>% select(App, Value_NS)
  colnames(df) <- c("app", "value")
  df$value <- df$value / 10^6
  df <- df %>% mutate(app = ifelse(app == "NoOp", "NOOP", ifelse(app == "Markdown", "Markdown", "Image Resizer")))
  return(df)
}

read_startup <- function(f) {
  df <- read.csv(f)
  return(get_startup(df))
}

pb_markdown <- get_startup(criu_nobpf_nowarm_java_markdown)
vanilla_markdown <- get_startup(nocriu_nobpf_nowarm_java_markdown)

pb <- read_startup("data/criu_nobpftrace_nogc_nowarmup.csv")
pb <- rbind(pb, pb_markdown)
pb$type <- "Prebaking"
vanilla <- read_startup("data/nocriu_nobpftrace_nogc_nowarmup.csv")
vanilla <- rbind(vanilla, vanilla_markdown)
vanilla$type <- "Vanilla"

pb_noop <- pb %>% filter(app == "NOOP")
vanilla_noop <- vanilla %>% filter(app == "NOOP")
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

# Some samples did not pass the Shapiro test, so let's calculate
# the confidence interval using bootstrap and test using a non-parametric
# test.

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
ggplot(transform(data, app=factor(app, levels = c("NOOP", "Markdown", "Image Resizer"))), aes(type, value)) +
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


# Metrics:
# RuntimeReadyTime -> time between the start of the function and until it is ready to start serving requests.
# ExecID -> Treatment replica ID
# ReqID -> ID of the request within the treatment replica (0 meaning the first request)

# Reading data
get_service_time <- function(df) {
  df <- df %>% filter(Metric == "ServiceTime") %>% select(App, Value_NS)
  colnames(df) <- c("app", "value")
  df$value <- df$value / 10^6
  df <- df %>% mutate(app = ifelse(app == "NoOp", "NOOP", ifelse(app == "Markdown", "Markdown", "Image Resizer")))
  return(df)
}

read_service_time <- function(f) {
  df <- read.csv(f)
  return (get_service_time(df))
}

pb_markdown_st <- get_service_time(criu_nobpf_nowarm_java_markdown)
vanilla_markdown_st <- get_service_time(nocriu_nobpf_nowarm_java_markdown)

pb <- read_service_time("data/criu_nobpftrace_nogc_nowarmup.csv")
pb <- rbind(pb, pb_markdown_st)
pb$type <- "Prebaking"
vanilla <- read_service_time("data/nocriu_nobpftrace_nogc_nowarmup.csv")
vanilla <- rbind(vanilla, vanilla_markdown_st)
vanilla$type <- "Vanilla"

p <- c("grey66", "grey1")
data <- rbind(pb, vanilla)
ggplot(transform(data, app=factor(app, levels = c("NOOP", "Markdown", "Image Resizer"))), aes(value, linetype = type, colour = type)) +
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