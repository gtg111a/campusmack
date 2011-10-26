class PagesController < ApplicationController
  skip_authorization_check

  def about
    @menu = [
      [:link, 'FAQ', '/faq'],
      [:link, 'Howto', '/howto']
    ]
    breadcrumbs.add 'About'
  end

  def faq
    @menu = [
      [:text, 'FAQ', '', 'active'],
      [:link, 'Howto', '/howto']
    ]
    breadcrumbs.add 'About', '/about'
    breadcrumbs.add 'FAQ'
  end

  def howto
    @menu = [
      [:link, 'FAQ', '/faq'],
      [:text, 'Howto', '', 'active']
    ]
    breadcrumbs.add 'About', '/about'
    breadcrumbs.add 'Howto'
  end

  def help
    @title = "Help"
  end

end

