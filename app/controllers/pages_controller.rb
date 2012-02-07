class PagesController < ApplicationController
  skip_authorization_check

  def about
    @menu = [
      [:link, 'FAQ', '/faq'],
      [:link, 'How To', '/howto'],
      [:link, 'Our Team','/ourteam']
    ]
    breadcrumbs.add 'About'
  end

  def faq
    @menu = [
      [:text, 'FAQ', '', 'active'],
      [:link, 'How To', '/howto'],
      [:link, 'Our Team', '/ourteam']
    ]
    breadcrumbs.add 'About', '/about'
    breadcrumbs.add 'FAQ'
  end

  def howto
    @menu = [
      [:link, 'FAQ', '/faq'],
      [:text, 'How To', '', 'active'],
      [:link, 'Our Team', '/ourteam']
    ]
    breadcrumbs.add 'About', '/about'
    breadcrumbs.add 'How To'
  end
  
  def ourteam
     @menu = [
       [:link, 'FAQ', '/faq'],
       [:link, 'How To', '/howto'],
       [:text, 'Our Team', '', 'active']
     ]
     breadcrumbs.add 'About', '/about'
     breadcrumbs.add 'Our Team'
   end
  

  def help
    @title = "Help"
  end

end
