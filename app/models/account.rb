class Account < ApplicationRecord
    has_secure_password

    has_many :holdings
    has_many :stocks, through: :holdings
end
