class MemberShift < ApplicationRecord
  belongs_to :user
  belongs_to :team

  validates :user_id, :team_id, :shift_date, presence: true
end
