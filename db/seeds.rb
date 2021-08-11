# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

%w[Fried\ Zucchini Apple\ Cider\ Donuts Homemade\ Pumpkin Pie\ Spice].each do |meal_name|
  Recipe.create(name: meal_name, content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    Aenean condimentum risus dui, volutpat consequat enim auctor quis. Sed eu elit egestas,
    scelerisque quam quis, posuere libero. Fusce tincidunt sapien vel efficitur cursus.
    Nam a pretium purus, vel vestibulum mi. Aliquam erat volutpat. Morbi sed fermentum ante. Donec maximus lacinia libero,
    tempor semper libero ultrices posuere. Maecenas id erat ac enim pharetra consequat.")
end
