class Exceptions < Merb::Controller
  
  # handle NotFound exceptions (404)
  def not_found
    page_title "oh snap 404"
    render :format => :html
  end

  # handle NotAcceptable exceptions (406)
  def not_acceptable
    render :format => :html
  end
  def unauthenticated
    page_title "login"
    render :format => :html
  end
end
