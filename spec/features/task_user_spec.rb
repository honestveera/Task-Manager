require 'spec_helper'

RSpec.feature "Widget management", :type => :feature,js:true do
  scenario "User creates a new widget" do
    visit "/"
require 'pry'
  binding.pry
    fill_in "Name", :with => "My Widget"
    click_button "Create Widget"

    expect(page).to have_text("Widget was successfully created.")
  end
end