# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
     
    if Category.all.size == 0
    categories = Category.create(:name => 'Default', :description => 'Default Category')
	end
	if RateType.all.size == 0
    rate_types = RateType.create(:name => 'Default', :unit => 1)
	end

    site_name = Setting.site_name = 'Admin Site' 
    blog_enabled = Setting.blog_enabled = 'false'
    sponsors_enabled = Setting.sponsors_enabled = 'false'
    products_enabled = Setting.products_enabled = 'false'
    tickets_enabled =Setting.tickets_enabled = 'false'
    messages_enabled = Setting.messages_enabled = 'false'
    services_enabled = Setting.services_enabled = 'false'
   