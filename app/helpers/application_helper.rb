# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def draw_status(comment)
    if comment.status == 'rejected'
      a = link_to_remote "Одобрить", :url => approve_comment_path(comment)      
      a += " | <span class='rejected'>Неодобрен</span>"

    elsif comment.status == 'approved'
      a = "<span class='approved'>Одобрен</span> | "
      a += link_to_remote "Отказать", :url => reject_comment_path(comment)
    else
      a = link_to_remote "Одобрить", :url => approve_comment_path(comment)
      a += " | "
      a += link_to_remote "Отказать", :url => reject_comment_path(comment)
    end
      a += " | "
      a += link_to_remote "Удалить", :url => comment_path(comment), :method => "delete", :confirm => "Вы уверены?"
      a
  end

end
