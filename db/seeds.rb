# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

["Ryde Chemist", "Balmain Chemist"].each do |name|
  pharmacy = Pharmacy.where(name: name).first_or_create

  %w(Monday Tuesday Wednesday Friday).each do |day|
    pharmacy.open_periods.where(day: day).first_or_create
  end
  pharmacy.open_periods.where(day: "Thursday", time_to: "20:00").first_or_create

  ap pharmacy
  ap pharmacy.open_periods
end
