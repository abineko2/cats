class Cat < ApplicationRecord
  belongs_to :user
  has_many :schedules,dependent: :destroy
  has_many :records,dependent: :destroy
  validates :cat_name,  presence: true, length: { maximum: 50 }    
end
