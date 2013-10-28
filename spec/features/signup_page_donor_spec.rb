require 'spec_helper'
include UserHelper

describe "Sign Up Page for donor" do
  before(:each) do
    c = FactoryGirl.create(:candidate)
    m = Media.create(url: "Adigo_small.jpg",
             type: "Image", user_id: c.id)
    f = Media.create(url: "http://www.youtube.com/watch?v=BU3jfbb172E",
             type: "Video", user_id: c.id)
    c.update_attributes(profile_video_id: f.id)
    c.update_attributes(profile_photo_id: m.id)
    Campaign.create(candidate: c, start_date: "31/10/2013", end_date: "31/12/2013", total: 0, goal: 12500, current_campaign: true)
  end


  it "should let you sign up as a donator" do

    visit root_path
    click_link "Sign Up!"
    click_link "Interested in being a supporter?", match: :first

      fill_in 'Name', with: 'Scott'
      fill_in 'donor_email', with: 'pippen@gmail.com'
      fill_in 'donor_password', with: 'bah'
      fill_in 'donor_password_confirmation', with: 'bah'

    click_button "Create Donor"
    page.should have_content "Candidates You've Nominated"
    page.should have_content "Scott"

  end

  it "should show the copyright" do

    visit root_path
    click_link "Sign Up!"
    click_link "Interested in being a supporter?", match: :first

    within('footer') { expect(page).to have_content('Copyright') }
  end
end





