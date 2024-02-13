# recipe-finder

This Recipe Finder application will allow you to find recipes based on the provided ingredients. It supports parsing indredients from a large dataset(allrecipes.com), search from ingredients as multi-input, and detailed view of recipes.


* Ruby/Rails version
ruby 3.2.2 and rails 7.1.3

## Setup
Migrate the db(make sure to have postgresql installed)
	rails db:migrate

Seed recipes data from recipes-en dataset
  rake import:recipe_dataset

Start the server
  rails s
