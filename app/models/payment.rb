class Payment < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories, dependent: :destroy
  validates :name, :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
end
