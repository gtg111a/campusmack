require 'spec_helper'

describe Smack do
  it "correctly adjusts count in postables" do
    college = FactoryGirl.create(:college)
    conference = FactoryGirl.create(:conference)

    [college, conference].each do |smackable|
      smackable.smacks_count.should == 0

      smacks = []
      smacks << FactoryGirl.create(:smack, :postable => smackable)
      smackable.reload.smacks_count.should == 1
      smacks << FactoryGirl.create(:smack, :postable => smackable)
      smackable.reload.smacks_count.should == 2

      smacks[0].destroy
      smackable.reload.smacks_count.should == 1
      smacks[1].destroy
      smackable.reload.smacks_count.should == 0
    end
  end
end
