
require 'spec_helper'

  describe Candidate do

    context "Validations and Associations" do

      it "should have one application" do
        candidate = Candidate.reflect_on_association(:application)
        candidate.macro.should == :has_one
      end

      it "should have many responses" do
        candidate = Candidate.reflect_on_association(:responses)
        candidate.macro.should == :has_many
      end

      it "should have many nominations" do
        candidate = Candidate.reflect_on_association(:nominations)
        candidate.macro.should == :has_many
      end

      it "should NOT be valid if password and password confirmation dont match" do
        FactoryGirl.build(:candidate, password: "not password").should_not be_valid
      end

      it "should not be valid without proper email syntax" do
        FactoryGirl.build(:candidate, email: 'bob.com').should_not be_valid
      end

      it  "should have a unique email" do
        user = FactoryGirl.create(:donor)
        FactoryGirl.create(:candidate, email: "scott@gmail.com")
        FactoryGirl.build(:candidate, email: "scott@gmail.com").should_not be_valid
      end

      it "should have an email" do
        FactoryGirl.build(:candidate, email: nil).should_not be_valid
      end

      it "should have a password" do
        FactoryGirl.build(:candidate, password: nil).should_not be_valid
      end

      it "should have a phone number" do
        FactoryGirl.build(:candidate, phone: nil).should_not be_valid
      end

      it "should have an address" do
        FactoryGirl.build(:candidate, address1: nil).should_not be_valid
      end

      it "should be valid without a secondary address" do
        FactoryGirl.build(:candidate, address2: nil).should be_valid
      end

      it "should have a city" do
        FactoryGirl.build(:candidate, city: nil).should_not be_valid
      end

      it "should have a state" do
        FactoryGirl.build(:candidate, state: nil).should_not be_valid
      end

      it "should have a zip" do
        FactoryGirl.build(:candidate, zip: nil).should_not be_valid
      end

    end

  end