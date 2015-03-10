class PhoneNumber < ActiveRecord::Base
  validates :numbertype, :phonenumber, :contact_id, presence: true
  belongs_to :contact

  def to_s
    "(#{numbertype.to_s.capitalize}) #{phonenumber}"
  end
end
