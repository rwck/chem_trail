# == Schema Information
#
# Table name: open_periods
#
#  id          :integer          not null, primary key
#  pharmacy_id :integer
#  day         :string           not null
#  time_from   :integer          default(900), not null
#  time_to     :integer          default(1700), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class OpenPeriod < ActiveRecord::Base
  belongs_to :pharmacy

  validates :pharmacy, presence: true
  validates :day, inclusion: Date::DAYNAMES
  validates :time_from, presence: true
  validates :time_to, presence: true

  def formatted

    #context
    #subject
    #let




    string = "#{day}: #{time_from.strftime("%l:%M %p").strip} - #{time_to.strftime("%l:%M %p").strip}"

    # string = day + ":" + time_from.strftime("%l:%M %p -") + time_to.strftime("%l:%M %p")
    # return string
    # return "Monday: 9:00 AM - 5:00 PM"
  end

  def covers?(time = Time.now)
  end
end
