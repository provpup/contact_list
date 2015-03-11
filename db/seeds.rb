require_relative '../factories'

50.times do
  contact = FactoryGirl.build :contact
  contact.save!
end

