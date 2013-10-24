class BootstrapLinkRenderer < WillPaginate::ActionView::LinkRenderer

  def html_container(html)
    tag :div, tag(:ul, html), container_attributes
  end

  def page_number(page)
    unless page == current_page
      tag :li, link(page, page, :rel => rel_value(page))
    else
      tag :li, tag(:span, page, :class => 'active')
    end
  end

  def gap
    tag :li, super
  end

  def previous_page
    num = @collection.current_page > 1 && @collection.current_page - 1
    previous_or_next_page(num , '&laquo;')
  end

  def next_page
    num = @collection.current_page < total_pages && @collection.current_page + 1
    previous_or_next_page(num , '&raquo;')
  end

  def previous_or_next_page(page, text)
    if page
      tag :li, link(text, page)
    else
      tag :li, tag(:span, text, :class => 'disabled')
    end
  end

end
