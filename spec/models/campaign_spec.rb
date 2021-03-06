require 'spec_helper'

  describe Campaign do

    describe "Validations and Associations" do

      it "should belong to a candidate" do
        campaign = Campaign.reflect_on_association(:candidate)
        campaign.macro.should == :belongs_to
      end

      it "should have many donations" do
        campaign = Campaign.reflect_on_association(:donations)
        campaign.macro.should == :has_many
      end

      it "should have many donors" do
        campaign = Campaign.reflect_on_association(:donors)
        campaign.macro.should == :has_many
      end

      it "should have many nominations" do
        campaign = Campaign.reflect_on_association(:nominations)
        campaign.macro.should == :has_many
      end

      it "should have a start date" do
         FactoryGirl.build(:campaign, start_date: nil).should_not be_valid
      end

      it "should have an end date" do
         FactoryGirl.build(:campaign, end_date: nil).should_not be_valid
      end

      it "should not need to have a total" do
         FactoryGirl.build(:campaign, total: nil).should be_valid
      end

      it "should need to have a goal" do
         FactoryGirl.build(:campaign, goal: nil).should_not be_valid
      end
    end

      describe "#current_campaign_percentage" do

        it "should return the percent compelete" do
          @campaign = FactoryGirl.create(:campaign)
          Campaign.stub(:current_campaign).and_return(@campaign)
          @campaign.total = "1200"
          @campaign.goal = "12000"
          @percent = Campaign.current_campaign_percentage

          @percent.should eq 10.0
        end
      end
  end





