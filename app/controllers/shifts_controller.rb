# frozen_string_literal: true

class ShiftsController < ApplicationController
  before_action :authenticate_user!

  def index
    @teams = Team.includes(:memberships).includes(:users)
    redirect_to(root_path, notice: 'No teams added') and return if @teams.empty?

    @selected_team = if params[:team_id]
                       @teams.find { |team| team.id == params['team_id'].to_i }
                     else
                       @teams.find { |team| team.users.count.positive? }
                     end
    selected_team_members_shift
  end

  def create_shifts
    user_id = params[:user_id]
    team_id = params[:team_id]

    params[:shift_date].each do |key, value|
      next if value['start_time'].empty? && value['end_time'].empty?

      shift = MemberShift.find_by('DATE(shift_date) = ? and user_id = ? and team_id = ?', key, user_id, team_id)
      if shift
        shift.update(start_time: value['start_time'], end_time: value['end_time'])
      else
        create_member_shift(key, params[:user_id], params[:team_id], value)
      end
    end

    redirect_to shifts_path(user_id: user_id, team_id: team_id), notice: 'Successfully Saved'
  end

  private

  def generate_shifts(member_shifts)
    today = Time.zone.today
    next_6th = today + 6
    shifts = {}
    (today..next_6th).each do |date|
      date = date.strftime('%Y-%m-%d')
      shift = member_shifts.find { |member_shift| member_shift.shift_date == date }
      shifts[date] = { 'start_time': shift&.start_time, 'end_time': shift&.end_time }
    end

    shifts
  end

  def create_member_shift(key, user_id, team_id, value)
    MemberShift.create(shift_date: key,
                       user_id: user_id,
                       team_id: team_id,
                       start_time: value['start_time'],
                       end_time: value['end_time'])
  end

  def selected_team_members_shift
    message = 'Please add atleast one member to at least one team'
    redirect_to(root_path, notice: message) and return unless @selected_team

    @members = @selected_team.users
    message = "Please add atleast one member to team #{@selected_team.name}"
    redirect_to root_path, notice: message and return if @members.empty?

    @selected_member = params[:user_id] ? fetch_member : @members.first
    member_shifts = @selected_member.member_shifts.where("shift_date >= '#{Time.zone.today}'")
    @shifts = generate_shifts(member_shifts)
  end

  def fetch_member
    @selected_member = @members.find { |member| member.id == params['user_id'].to_i }
  end
end
