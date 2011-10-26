class PagesController < ApplicationController
  skip_authorization_check

  def about
    @menu = [
      [:link, 'FAQ', '/faq'],
      [:link, 'How To', '/howto']
    ]
    breadcrumbs.add 'About'
  end

  def faq
    @menu = [
      [:text, 'FAQ', '', 'active'],
      [:link, 'How To', '/howto']
    ]
    breadcrumbs.add 'About', '/about'
    breadcrumbs.add 'FAQ'
  end

  def howto
    @menu = [
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

