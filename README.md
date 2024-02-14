# recipe-finder

This Recipe Finder application will allow you to find recipes based on the provided ingredients. It supports

* Parsing indredients from a large dataset(allrecipes.com)

* Search from ingredients as multi-input

* Detailed view of recipes

## Setup
Migrate the db(make sure to have postgresql installed)
    ```
    rails db:migrate
    ```

Seed recipes data from recipes-en dataset
    ```
    rake import:recipe_dataset
    ```

Start the server
    ```
    rails s
    ```
