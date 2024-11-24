class Customer < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable

    #using active storage to have one profile picture assoicated
    has_one_attached :profile_picture, dependent: :purge_later 

    #has many relationships and destroy build if customer deleted
    #https://guides.rubyonrails.org/v7.1/association_basics.html
    has_many :builds, dependent: :destroy

    #after customer created create and link build
    after_create :create_build
    #allow editing of build information in form
    accepts_nested_attributes_for :builds
    
    #validations
    validates :first_name, :last_name, :email, presence: true
    validate :acceptable_image
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email" }
    validates :password, presence: true, length: { minimum: 6 }


    private

    #create build when customer created
    #https://guides.rubyonrails.org/v7.1/association_basics.html

    def create_build
        builds.create!(title: "Default Title", notes: "Default Notes", last_modified: Time.current, active: false)
      end


    #validate that email is a valid email format
    ''' def email_format
        unless email =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
            errors.add(:email, "must be a valid email address")
        end
    end '''


    def acceptable_image
        return unless profile_picture.attached?

        unless profile_picture.blob.byte_size <= 1.megabyte
            errors.add(:profile_picture, "is too big")
        end

        acceptable_types = ["image/jpeg", "image/png"]
        unless acceptable_types.include?(profile_picture.content_type)
            errors.add(:profile_picture, "must be a JPEG or PNG")
        end

    end

end
