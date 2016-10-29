class Contact < ApplicationRecord
  has_many :contact_groups
  has_many :groups, through: :contact_groups
  belongs_to :user
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  def friendly_timing
    updated_at.strftime("%D")
  end

  def full_name
    first_name + " " + last_name
  end

  def add_jap_prefix
    "+81 " + phone_number
  end

  def self.all_johns
    Contact.all.map do |contact|
      contact.full_name
    end
  end
end
