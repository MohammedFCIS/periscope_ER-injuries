top_prod <- injuries %>%
  filter(trmt_date >= as.Date("2017-01-01"), trmt_date < as.Date("2018-01-01")) %>%
  count(prod1, sort = TRUE) %>%
  filter(n > 5 * 365)

injuries <- injuries %>%
  filter(trmt_date >= as.Date("2017-01-01"), trmt_date < as.Date("2018-01-01")) %>%
  semi_join(top_prod, by = "prod1") %>%
  mutate(age = floor(age), sex = tolower(sex), race = tolower(race)) %>%
  filter(sex != "unknown") %>%
  select(trmt_date, age, sex, race, body_part, diag, location, prod_code = prod1, weight, narrative)

products <- products %>%
  semi_join(top_prod, by = c("code" = "prod1")) %>%
  rename(prod_code = code)

population <- population %>%
  filter(year == 2017) %>%
  select(-year) %>%
  rename(population = n)

prod_codes <- setNames(products$prod_code, products$title)
