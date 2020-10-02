small_v <- read.csv("ingredients-noop-small-vanilla.csv")
small_v$Technique <- "Vanilla"
small_v$App <- "NOOP Class Loader"
small_v$Runtime <- "Java"
small_v$Loaded_Classes <- "50"

small_pb <- read.csv("ingredients-noop-small-prebaking.csv")
small_pb$Technique <- "Prebaking-NOWarmup"
small_pb$App <- "NOOP Class Loader"
small_pb$Runtime <- "Java"
small_pb$Loaded_Classes <- "50"

small_pbw <- read.csv("ingredients-noop-small-prebaking-warm.csv")
small_pbw$Technique <- "Prebaking-Warmup"
small_pbw$App <- "NOOP Class Loader"
small_pbw$Runtime <- "Java"
small_pbw$Loaded_Classes <- "50"


medium_v <- read.csv("ingredients-noop-medium-vanilla.csv")
medium_v$Technique <- "Vanilla"
medium_v$App <- "NOOP Class Loader"
medium_v$Runtime <- "Java"
medium_v$Loaded_Classes <- "250"

medium_pb <- read.csv("ingredients-noop-medium-prebaking.csv")
medium_pb$Technique <- "Prebaking-NOWarmup"
medium_pb$App <- "NOOP Class Loader"
medium_pb$Runtime <- "Java"
medium_pb$Loaded_Classes <- "250"

medium_pbw <- read.csv("ingredients-noop-medium-prebaking-warm.csv")
medium_pbw$Technique <- "Prebaking-Warmup"
medium_pbw$App <- "NOOP Class Loader"
medium_pbw$Runtime <- "Java"
medium_pbw$Loaded_Classes <- "250"


big_v <- read.csv("ingredients-noop-big-vanilla.csv")
big_v$Technique <- "Vanilla"
big_v$App <- "NOOP Class Loader"
big_v$Runtime <- "Java"
big_v$Loaded_Classes <- "1250"

big_pb <- read.csv("ingredients-noop-big-prebaking.csv")
big_pb$Technique <- "Prebaking-NOWarmup"
big_pb$App <- "NOOP Class Loader"
big_pb$Runtime <- "Java"
big_pb$Loaded_Classes <- "1250"

big_pbw <- read.csv("ingredients-noop-big-prebaking-warm.csv")
big_pbw$Technique <- "Prebaking-Warmup"
big_pbw$App <- "NOOP Class Loader"
big_pbw$Runtime <- "Java"
big_pbw$Loaded_Classes <- "1250"


all <- rbind(small_v, small_pb, small_pbw,
             medium_v, medium_pb, medium_pbw,
             big_v, big_pb, big_pbw)

write.csv(all,
          file = "choosing-ingredients.csv",
          row.names = FALSE)