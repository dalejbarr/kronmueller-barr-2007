
kronmueller-barr-2007
=====================

Repository of data and scripts for:

Kronmüller, E., & Barr, D. J. (2007). [Perspective-free pragmatics: Broken precedents and the recovery-from-preemption hypothesis.](https://doi.org/10.1016/j.jml.2006.05.002) *Journal of Memory and Language*, *56*, 436--455.

Currently this repository contains only response time data for Experiment 2.

Experiment 2
------------

-   1789 total observations taken over 56 subjects and 32 stimuli (*Note*: three observations were removed due to implausibly fast responding; see p. 447 of the manuscript)

### Response Time

-   The full data are available in [`kb07_exp2_rt.rds`](kb07_exp2_rt.rds).

#### Codebook

| column     | description                                    |
|:-----------|:-----------------------------------------------|
| `subj`     | unique subject identifier                      |
| `item`     | unique stimulus item identifier                |
| `spkr`     | whether the speaker was old or new             |
| `prec`     | whether the precedent was broken or maintained |
| `load`     | whether the subject was under cognitive load   |
| `rt_trunc` | response time, truncated at 5171 ms            |
| `rt_raw`   | response time, not truncated                   |

#### Table 3 (p. 448)

*Note:* The values in Table 3 are based on the raw (non-truncated) values.

``` r
library("tidyverse")

kb07 <- readRDS("kb07_exp2_rt.rds")

kb07 %>%
  group_by(spkr, prec, load) %>%
  summarize(mean = mean(rt_raw), sd = sd(rt_raw)) %>%
  ungroup() %>%
  knitr::kable("markdown", digits = 0)
```

| spkr | prec     | load |  mean|    sd|
|:-----|:---------|:-----|-----:|-----:|
| new  | break    | no   |  2391|  1185|
| new  | break    | yes  |  2610|  1463|
| new  | maintain | no   |  1761|   592|
| new  | maintain | yes  |  1843|   610|
| old  | break    | no   |  2573|  1174|
| old  | break    | yes  |  2837|  1751|
| old  | maintain | no   |  1771|   670|
| old  | maintain | yes  |  2020|   732|

#### Analysis by Subject (p. 448)

``` r
subj_means_trunc <- kb07 %>%
  group_by(subj, spkr, prec, load) %>%
  summarize(rt = mean(rt_trunc)) %>%
  ungroup() %>%
  mutate(spkr = factor(spkr),
         prec = factor(prec),
         load = factor(load))

by_subj <- ez::ezANOVA(subj_means_trunc,
            rt,
            wid = subj,
            within = .(spkr, prec, load),
            type = 3)$ANOVA

by_subj %>%
  knitr::kable("markdown", digits = 2, row.names = FALSE) 
```

| Effect         |  DFn|  DFd|       F|     p| p&lt;.05 |   ges|
|:---------------|----:|----:|-------:|-----:|:---------|-----:|
| spkr           |    1|   55|    9.71|  0.00| \*       |  0.02|
| prec           |    1|   55|  231.90|  0.00| \*       |  0.28|
| load           |    1|   55|   13.22|  0.00| \*       |  0.02|
| spkr:prec      |    1|   55|    1.18|  0.28|          |  0.00|
| spkr:load      |    1|   55|    1.10|  0.30|          |  0.00|
| prec:load      |    1|   55|    0.05|  0.83|          |  0.00|
| spkr:prec:load |    1|   55|    1.34|  0.25|          |  0.00|

#### Analysis by Item (p. 448)

``` r
item_means_trunc <- kb07 %>%
  group_by(item, spkr, prec, load) %>%
  summarize(rt = mean(rt_trunc)) %>%
  ungroup() %>%
  mutate(spkr = factor(spkr),
         prec = factor(prec),
         load = factor(load))

by_item <- ez::ezANOVA(item_means_trunc,
            rt,
            wid = item,
            within = .(spkr, prec, load),
            type = 3)$ANOVA

by_item %>%
  knitr::kable("markdown", digits = 2, row.names = FALSE)
```

| Effect         |  DFn|  DFd|      F|     p| p&lt;.05 |   ges|
|:---------------|----:|----:|------:|-----:|:---------|-----:|
| spkr           |    1|   31|   8.76|  0.01| \*       |  0.01|
| prec           |    1|   31|  42.35|  0.00| \*       |  0.27|
| load           |    1|   31|  18.46|  0.00| \*       |  0.02|
| spkr:prec      |    1|   31|   1.40|  0.25|          |  0.00|
| spkr:load      |    1|   31|   0.78|  0.38|          |  0.00|
| prec:load      |    1|   31|   0.05|  0.82|          |  0.00|
| spkr:prec:load |    1|   31|   1.12|  0.30|          |  0.00|
