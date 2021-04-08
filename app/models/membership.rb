class Membership < ApplicationRecord
  belongs_to :team
  belongs_to :user

  validates :team_id, :user_id, presence: true
  validates :user_id, uniqueness: { scope: :team_id }
end
