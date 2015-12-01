require 'rails_helper'

RSpec.describe OpenPeriod, type: :model do
  subject(:period) { OpenPeriod.new(day: day, time_from: time_from, time_to: time_to) }
  let(:day) { "Monday" }
  let(:time_from) { "09:00" }
  let(:time_to) { "17:00" }
  describe '#formatted' do
    context "given Monday, 9 to 5" do
      let(:day) { "Monday" }
      let(:time_from) { "09:00" }
      let(:time_to) { "17:00" }
      it 'should format the output as "Monday: 9:00 AM - 5:00 PM"' do
        expect(period.formatted).to eq "Monday: 9:00 AM - 5:00 PM"
      end
    end
    context "when closing at 11 PM" do
      let(:day) { "Monday" }
      let(:time_from) { "09:00" }
      let(:time_to) { "23:00" }
      it 'should format the output as "Monday: 9:00 AM - 11:00 PM"' do
        expect(period.formatted).to eq "Monday: 9:00 AM - 11:00 PM"
      end
    end
  end
end


# RSpec.describe OpenPeriod, type: :model do
#   describe '#formatted' do # this is the name (by convention) of the method to test
#     # it 'should do a' do
#     # end
#     # it 'should do b' do
#     # end
#
#   context "when closing at 5" do
#     let(:day) {"Monday"}
#     let(:time_from) {"09:00"}
#     let(:time_to) {"17:00"}
#   end
#
#   it 'should format the output as "Monday 9:00AM - 5:00PM"' do
#     expect(period.formatted).to eq "Monday: 9:00 AM - 5:00 PM"
#   end
#
#   context "when closing at 11" do
#     let(:day) {"Monday"}
#     let(:time_from) {"09:00"}
#     let(:time_to) {"23:00"}
#   end
#
#   it 'should format the output as "Monday 9:00AM - 11:00PM"' do
#     expect(period.formatted).to eq "Monday 9:00 AM - 11:00 PM"
#     end
#   end
# # end
#
#
# RSpec.describe OpenPeriod, type: :model do
#   subject(:period) { OpenPeriod.new(day: day, time_from: time_from, time_to: time_to) }
#   let(:day) { "Monday" }
#   let(:time_from) { "09:00" }
#   let(:time_to) { "17:00" }
# ​
# ​
#   describe '#formatted' do
#     context "given Monday, 9 to 5" do
#       let(:day) { "Monday" }
#       let(:time_from) { "09:00" }
#       let(:time_to) { "17:00" }
# ​
#       it 'should format the output as "Monday: 9:00 AM - 5:00 PM"' do
#         expect(period.formatted).to eq "Monday: 9:00 AM - 5:00 PM"
#       end
#     end
# ​
#     context "when closing at 11 PM" do
#       let(:day) { "Monday" }
#       let(:time_from) { "09:00" }
#       let(:time_to) { "23:00" }
# ​
#       it 'should format the output as "Monday: 9:00 AM - 11:00 PM"' do
#         expect(period.formatted).to eq "Monday: 9:00 AM - 11:00 PM"
#       end
#     end
# ​
#   end
# end
#
#
#
#   #   it 'should format the output as "Monday 9:00AM - 5:00PM"' do
#   #     period = OpenPeriod.new(day: "Monday", time_from: "09:00", time_to: "17:00")
#   #     expect(period.formatted).to eq "Monday: 9:00 AM - 5:00 PM"
#   #   end
#   #
#   #   it 'should format the output as "Monday 9:00AM - 11:00PM"' do
#   #     period = OpenPeriod.new(day: "Monday", time_from: "09:00", time_to: "23:00")
#   #     expect(period.formatted).to eq "Monday: 9:00 AM - 11:00 PM"
#   #   end
#   #
#   # end
#   # pending "add some examples to (or delete) #{__FILE__}"
# # end
