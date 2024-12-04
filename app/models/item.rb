class Item < ApplicationRecord
    has_one_attached :image
    validates :title, :price, :description, presence: true
end
  