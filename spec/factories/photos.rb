FactoryGirl.define do 

  factory :photo do 
    title { Faker::Name.name }
    description { Faker::Lorem.sentence }
    status 'Public'
    photo_upload File.open(File.join(Rails.root, '/spec/fixtures/profile_new_page.jpg'))
  end 
  
end


