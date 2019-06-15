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

  def alert_type(alert_key)
    case alert_key
      when 'notice'
        'success'
      when 'red_badge'
        'red_badge'
      when 'green_badge'
        'green_badge'
      when 'pink_badge'
        'pink_badge'
      else
        'danger'
      end
  end
end
