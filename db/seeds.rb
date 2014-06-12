# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
     

    categories = Category.create(:name => 'Default', :description => 'Default Category')
    rate_types = RateType.create(:name => 'Default', :unit => 1)