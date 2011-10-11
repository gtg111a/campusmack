module ContactsHelper
  def items_per_page_min(*args)
    array = Array.new
    args.each do |x|
      array << x.to_i
    end
    min = array.min_by {|x| x }
    return min
  end

  def items_per_page(args, options = {})
    html = ""
    array = Array.new
    args.each do |x|
      array << x.to_i
    end
    min = array.min_by {|x| x }
    array.each do |x|
      (x == params[:per].to_i or (params[:per] == nil && x == min )) ? html << "<li class='active'><span>#{x.to_s}</span></li>" : html << "<li>#{link_to x.to_s, contacts_path(:page => 1, :per => x, :group_id => params[:group_id]), :remote => (options[:remote] || false)}</li>"
    end
    return raw html
  end
end