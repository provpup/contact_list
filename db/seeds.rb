require_relative '../factories'

10.times do
  contact = FactoryGirl.build :contact
  contact.save!
end

