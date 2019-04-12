library("RePsychLing")
library("tidyverse")

kb07_v2 <- readRDS("kb07_v2.rds")

kb07_v2 %>%
  group_by(spkr, prec, load)  %>%
  summarize(m1 = mean(rt_trunc), sd1 = sd(rt_trunc),
            m2 = mean(rt_raw), sd2 = sd(rt_raw))

kb07 %>%
  group_by(S, P, C) %>%
  summarize(m1 = mean(RTtrunc), sd1 = sd(RTtrunc))
