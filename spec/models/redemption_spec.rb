require 'spec_helper'

describe Redemption do
  it "correctly adjusts count in postables" do
    college = FactoryGirl.create(:college)
    conference = FactoryGirl.create(:conference)

    [college, conference].each do |redeemable|
      redeemable.redemptions_count.should == 0

      redemptions = []
      redemptions << FactoryGirl.create(:redemption, :postable => redeemable)
      redeemable.reload.redemptions_count.should == 1
      redemptions << FactoryGirl.create(:redemption, :postable => redeemable)
      redeemable.reload.redemptions_count.should == 2

      redemptions[0].destroy
      redeemable.reload.redemptions_count.should == 1
      redemptions[1].destroy
      redeemable.reload.redemptions_count.should == 0
    end
  end
end
