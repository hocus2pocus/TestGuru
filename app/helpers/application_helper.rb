module ApplicationHelper
  def current_year
    Date.current.year
  end

  def github_url(author, repo)
    link_to 'TestGuru', "https://github.com/#{author}/#{repo}"
  end

  def flash_helper(type)
    content_tag :p, flash[type.to_sym], class: "flash #{type}" if type.present?
  end
end
