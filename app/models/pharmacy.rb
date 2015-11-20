# == Schema Information
#
# Table name: pharmacies
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Pharmacy < ActiveRecord::Base
  has_many :open_periods

  validates :name, presence: true

  def open_periods_formatted
  end

  def open?(time = Time.now)
  end
end
