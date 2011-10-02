# To change this template, choose Tools | Templates
# and open the template in the editor.

module Filter
  
  def censored_text(original_text,current_user)
    begin
      if(current_user.present? && current_user.censor_text?)
        original_text.present? ? original_text.censored : ""
      else
        return original_text
      end
  
    rescue
      return 0
    end
  end
end
