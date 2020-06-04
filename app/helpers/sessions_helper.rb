module SessionsHelper

  def show_msg(msg)
    if flash[msg]
      content_tag :p, flash[:alert], class: "flash #{msg}"
    end
  end

end
