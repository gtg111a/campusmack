class MyLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer
  def to_html
    html = pagination.map do |item|
      item.is_a?(Fixnum) ?
        page_number(item) :
        send(item)
    end.join(@options[:link_separator])

    first = previous_or_next_page((@collection.current_page == 1 ? nil : 1), @options[:first_label], 'first_page')
    last = previous_or_next_page((@collection.total_pages == @collection.current_page ? nil : @collection.total_pages), @options[:last_label], 'last_page')

    html = first + html + last

    @options[:container] ? html_container(html) : html
  end
end