require 'active_record'

class PhoneNumber < ActiveRecord::Base
  validates :numbertype, :phonenumber, :contact_id presence: true
  belongs_to :user
end

class Contact < ActiveRecord::Base
  validates :firstname, :lastname, :email, presence: true
  validates :email, uniqueness: true
  has_many :phone_numbers
 
  def to_s
    phone_num = ''
    phone_num = ' (phone numbers hidden)' unless phone_numbers.empty?

    "#{firstname} #{lastname} (#{email})#{phone_num}"
  end

  def self.email_already_exists?(email)
    # Find contacts that contain the email string
    contacts_containing_email = find_by(email: email)

    !contacts_containing_email.nil?
  end
end
