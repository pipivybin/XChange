class Stock < ApplicationRecord
    has_many :holdings
    has_many :accounts, through: :holdings
end
