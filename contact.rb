require 'active_record'

class Contact < ActiveRecord::Base
  validates :firstname, :lastname, :email, presence: true
  validates :email, uniqueness: true
 
  def to_s
    "#{firstname} #{lastname} (#{email})"
  end

  def self.email_already_exists?(email)
    # Find contacts that contain the email string
    contacts_containing_email = find_by(email: email)

    !contacts_containing_email.nil?
  end
end
