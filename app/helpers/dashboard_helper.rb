module DashboardHelper
  def format_currency(amount)
    number_to_currency(amount, precision: 2)
  end

  def format_percentage(value, total)
    return "0%" if total.zero?
    percentage = (value.to_f / total.to_f * 100).round(1)
    "#{percentage}%"
  end

  def format_duration(seconds)
    return "0s" if seconds.nil? || seconds.zero?

    if seconds < 60
      "#{seconds.round}s"
    elsif seconds < 3600
      "#{(seconds.to_f / 60).round(1)}m"
    else
      hours = (seconds.to_f / 3600).round(1)
      "#{hours}h"
    end
  end

  def trend_indicator(current, previous)
    return "→" if previous.nil? || previous.zero?

    change = ((current - previous) / previous.to_f * 100).round(1)
    if change > 0
      "↗ +#{change}%"
    elsif change < 0
      "↘ #{change}%"
    else
      "→ 0%"
    end
  end

  def chart_bar_height(value, max_value, max_height = 250)
    return 0 if max_value.zero?
    (value.to_f / max_value.to_f * max_height).round
  end
end
