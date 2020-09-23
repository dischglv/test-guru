module ApplicationHelper

  def current_year
    Date.current.year
  end

  def github_url(author, repo)
    "https://github.com/#{author}/#{repo}"
  end

  def badge_type(badge)
    t("badge_type.#{badge.rule}")
  end

  def badge_collection
    BadgeManager::BADGE_TYPES.map { |type|
      [t("badge_type.#{badge.rule}"), type]
    }
  end
end
