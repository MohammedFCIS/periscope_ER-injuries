injuries   <- vroom::vroom("./program/data/neiss/injuries.tsv.gz") %>% as.data.frame()
products   <- vroom::vroom("./program/data/neiss/products.tsv") %>% as.data.frame()
population <- vroom::vroom("./program/data/neiss/population.tsv") %>% as.data.frame()
prod_codes <- setNames(products$prod_code, products$title)
