module ApplicationHelper
  def current_year
    Date.current.year
  end

  def github_url(author, repo)
    link_to 'TestGuru', "https://github.com/#{author}/#{repo}"
  end

  def flash_alert
    if flash[:alert]
      content_tag :p, flash[:alert], class: 'flash alert'
    end
  end
end
