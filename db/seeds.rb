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
    if Gallery.all.size == 0
    galleries = Gallery.create(:name => 'Default', :description => 'Default Gallery')
    end
	if RateType.all.size == 0
    rate_types = RateType.create(:name => 'Default', :unit => 1)
	end
    if SeverityType.all.size == 0
    severity_types = SeverityType.create(:name => 'Normal', :description => "Normal Severity")
    end
    if TicketStatus.all.size == 0
    ticket_statuses = TicketStatus.create(:state => 'Open', :position => 1, :description => 'Default State')
    end
    if InvoiceStatus.all.size == 0
    ticket_statuses = InvoiceStatus.create(:state => 'Open', :position => 1, :description => 'Default State')
    end

    site_name = Setting.site_name = 'Admin Site' 
    company_name = Setting.company_name = "My Company"
    company_slogan = Setting.company_slogan = "My Company is the best!"
    company_address = Setting.company_address = "123 Some Street"
    company_city = Setting.company_city = "Some City"
    company_state = Setting.company_state = "Texas"
    company_zip = Setting.company_zip = "75701"
    company_phone = Setting.company_phone = "123 456-7899"
    company_email = Setting.company_email = "someone@example.com"
    company_url = Setting.company_url = "http://www.example.com"
    blog_enabled = Setting.blog_enabled = 'false'
    sponsors_enabled = Setting.sponsors_enabled = 'false'
    products_enabled = Setting.products_enabled = 'false'
    videos_enabled = Setting.videos_enabled = 'false'
    galleries_enabled = Setting.galleries_enabled = 'false'
    photos_enabled = Setting.photos_enabled = 'false'
    tickets_enabled =Setting.tickets_enabled = 'false'
    messages_enabled = Setting.messages_enabled = 'false'
    services_enabled = Setting.services_enabled = 'false'
    company_addresss = Setting.company_address = "123 Some Street"
   