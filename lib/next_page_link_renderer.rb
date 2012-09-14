class NextPageLinkRenderer < WillPaginate::ActionView::LinkRenderer
  def to_html
    @options[:next_label] = 'Next'
    html = send(:next_page)
    @options[:container] ? html_container(html) : html
  end
end
