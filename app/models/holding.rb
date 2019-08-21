class Holding < ApplicationRecord
    belongs_to :account
    belongs_to :stock

    scope :most, -> { order(balance: :DESC).limit(1).first }

end
