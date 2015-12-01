require 'rails_helper'

RSpec.describe "pharmacies/new", type: :view do
  before(:each) do
    assign(:pharmacy, Pharmacy.new(
      :name => "MyString"
    ))
  end

  it "renders new pharmacy form" do
    render

    assert_select "form[action=?][method=?]", pharmacies_path, "post" do

      assert_select "input#pharmacy_name[name=?]", "pharmacy[name]"
    end
  end
end
