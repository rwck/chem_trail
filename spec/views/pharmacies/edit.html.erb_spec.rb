require 'rails_helper'

RSpec.describe "pharmacies/edit", type: :view do
  before(:each) do
    @pharmacy = assign(:pharmacy, Pharmacy.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit pharmacy form" do
    render

    assert_select "form[action=?][method=?]", pharmacy_path(@pharmacy), "post" do

      assert_select "input#pharmacy_name[name=?]", "pharmacy[name]"
    end
  end
end
