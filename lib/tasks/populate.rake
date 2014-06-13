namespace :db do
  desc "Populate Services"
  task :populate => :environment do
    require 'faker'
    
    # Create Services
      8.times do |c|
        service = Service.create!(:name => Faker::Commerce.product_name,
          :summary =>Faker::Company.catch_phrase,
          :category_id => 1,
          :description => Faker::Lorem.paragraph(sentence_count = 3))

      end

       20.times do |c|
        client = Client.create!(:name => Faker::Company.name,
          :url => Faker::Internet.url,
          :email => Faker::Internet.email,
          :phone => Faker::PhoneNumber.cell_phone,
          :description => Faker::Lorem.paragraph(sentence_count = 1))

      end    

      40.times do |c|
        contact = Contact.create!(:full_name => Faker::Company.name,
          :full_name => Faker::Name.name,
          :email => Faker::Internet.email,
          :phone => Faker::PhoneNumber.cell_phone,
           :client_id => 1+rand(20),
          :notes => Faker::Lorem.paragraph(sentence_count = 1))



      end  
  end
end