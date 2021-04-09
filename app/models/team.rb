class Team < ApplicationRecord
    has_many :memberships
    has_many :users, through: :memberships
    has_many :member_shifts

    validates :name, presence: true
end
