module ApplicationHelper
  def current_year
    Date.today.year
  end

  def github_url(author, repo)
    link_to Rails.application.class.parent_name, "https://github.com/#{author}/#{repo}"
  end
end
