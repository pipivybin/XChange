class Account < ApplicationRecord
    has_secure_password
    validates :name, presence: { message: "Error: Name cannot be blank!" }
    validates :name, uniqueness: { message: "Error: Name is not available!" }
    validates :password, length: {in: 6..100}

    has_many :holdings
    has_many :stocks, through: :holdings

    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |acc|
            acc.provider = auth.provider
            acc.uid = auth.uid
            acc.name = auth.name
            acc.password = SecureRandom.urlsafe_base64 unless acc.password != nil
            acc.save!
        end
    end
    
end
