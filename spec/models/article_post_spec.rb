require 'spec_helper'

describe ArticlePost do
  it "correctly adjusts count in postables" do
    college = FactoryGirl.create(:college)
    conference = FactoryGirl.create(:conference)

    [college, conference].each do |postable|
      postable.smacks_count.should == 0

      article_posts = []
      article_posts << FactoryGirl.create(:article_post, :postable => postable)
      postable.reload.smacks_count.should == 1
      article_posts << FactoryGirl.create(:article_post, :postable => postable)
      postable.reload.smacks_count.should == 2

      article_posts[0].destroy
      postable.reload.smacks_count.should == 1
      article_posts[1].destroy
      postable.reload.smacks_count.should == 0
    end
  end
end
