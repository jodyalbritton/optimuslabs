namespace :db do
  desc "Populate Services"
  task :populate => :environment do
    require 'faker'
    
    # Create Services
      8.times do |c|
        service = Service.create!(:name => Faker::Commerce.product_name,
          :summary =>Faker::Company.catch_phrase,
          :description => Faker::Lorem.paragraph(sentence_count = 3))
      end    
  end
end