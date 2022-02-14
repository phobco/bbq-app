class Event < ApplicationRecord
  belongs_to :user
  
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user

  validates :title, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1200 }
  validates :address, :datetime, presence: true

  scope :randomize, -> { order('random()') }

  def visitors
    [user, *subscribers].uniq
  end

  def pincode_valid?(pin2chek)
    pincode == pin2chek
  end
end
