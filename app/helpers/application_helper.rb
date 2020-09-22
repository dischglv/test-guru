module ApplicationHelper

  def current_year
    Date.current.year
  end

  def github_url(author, repo)
    "https://github.com/#{author}/#{repo}"
  end

  BADGE_TYPES = {
    all_from_category: "Пройдены все тесты из категории",
    all_of_level: "Пройдены все тесты уровня",
    first_try: "Тест пройден с первого раза"
  }

  def badge_type(badge)
    BADGE_TYPES[badge.rule]
  end

  def badge_collection
    BADGE_TYPES.to_a.map { |array|
      [array.last, array.first.to_s]
    }
  end
end
