require 'rails_helper'

RSpec.describe "pharmacies/index", type: :view do
  before(:each) do
    assign(:pharmacies, [
      Pharmacy.create!(
        :name => "Name"
      ),
      Pharmacy.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of pharmacies" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
