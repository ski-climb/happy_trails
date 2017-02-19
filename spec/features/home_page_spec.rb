require 'rails_helper'

describe "the home page" do
  scenario "the home page appears" do
    visit root_path

    expect(page).to have_content "Pampered Trails"
  end
end
