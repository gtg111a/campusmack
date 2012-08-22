class PagesController < ApplicationController
  skip_authorization_check

  def about
    @about = self.class.to_s
    @menu = [
      [:text, 'About', '', 'active'],
      [:link, 'FAQ', '/faq'],
      [:link, 'How To', '/howto']
    ]
    breadcrumbs.add 'About'
  end

  def faq
    @menu = [
      [:link, 'About', '/about'],
      [:text, 'FAQ', '', 'active'],
      [:link, 'How To', '/howto']
    ]
    breadcrumbs.add 'About', '/about'
    breadcrumbs.add 'FAQ'
  end

  def howto
    @menu = [
      [:link, 'About', '/about'],
      [:link, 'FAQ', '/faq'],
      [:text, 'How To', '', 'active']
    ]
    breadcrumbs.add 'About', '/about'
    breadcrumbs.add 'How To'
  end

  def help
    @title = "Help"
  end

end
