injuries   <- vroom::vroom("./program/data/neiss/injuries.tsv.gz")
products   <- vroom::vroom("./program/data/neiss/products.tsv")
population <- vroom::vroom("./program/data/neiss/population.tsv")
prod_codes <- setNames(products$prod_code, products$title)
