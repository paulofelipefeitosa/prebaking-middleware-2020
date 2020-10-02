noop_v <- read.csv("startup-time-noop-vanilla.csv")
noop_v$Technique <- "Vanilla"
noop_v$App <- "NOOP"
noop_v$Runtime <- "Java"

noop_pb <- read.csv("startup-time-noop-prebaking.csv")
noop_pb$Technique <- "Prebaking"
noop_pb$App <- "NOOP"
noop_pb$Runtime <- "Java"

ir_v <- read.csv("startup-time-image_resizer-vanilla.csv")
ir_v$Technique <- "Vanilla"
ir_v$App <- "Image Resizer"
ir_v$Runtime <- "Java"

ir_pb <- read.csv("startup-time-image_resizer-prebaking.csv")
ir_pb$Technique <- "Prebaking"
ir_pb$App <- "Image Resizer"
ir_pb$Runtime <- "Java"

mk_v <- read.csv("startup-time-markdown-vanilla.csv")
mk_v$Technique <- "Vanilla"
mk_v$App <- "Markdown"
mk_v$Runtime <- "Java"

mk_pb <- read.csv("startup-time-markdown-prebaking.csv")
mk_pb$Technique <- "Prebaking"
mk_pb$App <- "Markdown"
mk_pb$Runtime <- "Java"

all <- rbind(noop_v, noop_pb, ir_v, ir_pb, mk_v, mk_pb)

write.csv(all,
          file = "function_startup_nobpftrace.csv",
          row.names = FALSE)