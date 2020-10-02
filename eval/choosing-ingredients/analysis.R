require(dplyr)
require(ggplot2)
require(reshape)
require(ggpubr)

read_service_time <- function(f) {
  df <- read.csv(f)
  df <- data.frame(
    Complexity=df[df$Metric=="ServiceTime", ]$Loaded_Classes,
    Value=df[df$Metric=="ServiceTime", ]$Value+df[df$Metric=="RuntimeReadyTime", ]$Value,
    Technique=df[df$Metric=="ServiceTime", ]$Technique
  )
  colnames(df) <- c("app", "value", "technique")
  df$value <- df$value / 10^6
  df <- df %>% mutate(app = ifelse(app == "50", "Small", ifelse(app == "250", "Medium", "Big")))
  return(df)
}
data <- read_service_time("data/choosing-ingredients.csv")

pb <- data %>% filter(technique == "Prebaking-Warmup")
pb1 <- data %>% filter(technique == "Prebaking-NOWarmup")
vanilla <- data %>% filter(technique == "Vanilla")

calculate_median <- function(df, app) {
  df.t <- wilcox.test(df[df$app == app, ]$value, conf.int = T)
  return(data.frame(
    app=app,
    value=df.t$estimate,
    min=df.t$conf.int[1],
    max=df.t$conf.int[2]))
}

print("Prebaking-Warmup App Median Start-up Time")
calculate_median(pb, "Small")
calculate_median(pb, "Medium")
calculate_median(pb, "Big")
print("Prebaking-NOWarmup App Median Start-up Time")
calculate_median(pb1, "Small")
calculate_median(pb1, "Medium")
calculate_median(pb1, "Big")
print("Vanilla App Median Start-up Time")
calculate_median(vanilla, "Small")
calculate_median(vanilla, "Medium")
calculate_median(vanilla, "Big")

calculate_ratio <- function(pb, vanilla, app) {
  pb.t <- wilcox.test(pb[pb$app == app, ]$value, conf.int = T)
  vanilla.t <- wilcox.test(vanilla[vanilla$app == app, ]$value, conf.int = T)
  return(data.frame(
    type=pb$technique,
    app=app,
    value=(vanilla.t$estimate/pb.t$estimate)*100,
    min=(vanilla.t$conf.int[1]/pb.t$conf.int[1])*100,
    max=(vanilla.t$conf.int[2]/pb.t$conf.int[2])*100))
}

result <- calculate_ratio(pb, vanilla, "Small")
result <- rbind(result, calculate_ratio(pb, vanilla, "Medium"))
result <- rbind(result, calculate_ratio(pb, vanilla, "Big"))
result <- rbind(result, calculate_ratio(pb1, vanilla, "Small"))
result <- rbind(result, calculate_ratio(pb1, vanilla, "Medium"))
result <- rbind(result, calculate_ratio(pb1, vanilla, "Big"))

ggplot(result, aes(x=app, value, fill=type)) +
  #geom_errorbar(aes(ymin=min, ymax=max), width=.5) +
  geom_bar(position="dodge", stat = "identity") +
  theme_pubclean() +
  labs(y = "Startup Time Improvement (%)", x="Function Size", fill = "Type") +
  scale_x_discrete(limits=c("Small", "Medium", "Big")) +
  theme(
    legend.position="bottom",
    panel.grid.major.x = element_line(colour = "darkgray", linetype = 3))

ggsave("impact_function_size_cmp.png")

result <- calculate_median(vanilla, "Small")
result <- rbind(result, calculate_median(vanilla, "Medium"))
result <- rbind(result, calculate_median(vanilla, "Big"))

ggplot(result, aes(x=app, y=value)) +
  geom_bar(position="dodge", stat="identity", fill="violetred4") +
  geom_errorbar(aes(ymin=min, ymax=max), width=.5) +
  theme_pubclean() +
  labs(y = "Startup Time (ms)", x="Function Size") +
  scale_x_discrete(limits=c("Small", "Medium", "Big")) +
  theme(
    legend.position="bottom",
    panel.grid.major.x = element_line(colour = "darkgray", linetype = 3))

ggsave("impact_function_size_vanilla.png")