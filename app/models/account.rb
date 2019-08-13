class Account < ApplicationRecord
    has_secure_password
    validates :name, presence: { message: "Error: Name cannot be blank!" }
    validates :name, uniqueness: { message: "Error: Name is not available!" }
    #validates :password, length: {in: 4..100}

    has_many :holdings
    has_many :stocks, through: :holdings

    scope :investors, -> { where(broker_acc: false) }
    scope :vips, -> { investors.where("balance > 1000000") }


    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |acc|
            acc.provider = auth.provider
            acc.uid = auth.uid
            acc.name = auth.info.name unless acc.name != nil
            acc.password = SecureRandom.hex(10) unless acc.password != nil
            acc.save!
        end
    end
    
end
