class Team < ApplicationRecord
    has_many :memberships, dependent: :destroy
    has_many :users, through: :memberships
    has_many :member_shifts, dependent: :destroy

    validates :name, presence: true
end
