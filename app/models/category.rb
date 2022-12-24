class Category < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }
  validates :icon, allow_blank: true, presence: true
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_and_belongs_to_many :payments, dependent: :destroy
end
