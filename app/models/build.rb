class Build < ApplicationRecord
  belongs_to :customer

  # Validations
  validates :title, :notes, :last_modified, presence: true

  # Enable ActiveStorage for build image
  has_one_attached :build_image

  # Optional: Set a default value for `active` if it's nil
  after_initialize :set_default_active, if: :new_record?

  private

  def set_default_active
    self.active = false if active.nil?
  end
end
