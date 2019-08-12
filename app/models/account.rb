class Account < ApplicationRecord
    has_secure_password
    validates :name, presence: { message: "Error: Name cannot be blank!" }
    validates :name, uniqueness: { message: "Error: Name is not available!" }
    validates :password, length: {in: 6..20}
    
    has_many :holdings
    has_many :stocks, through: :holdings

    
end
