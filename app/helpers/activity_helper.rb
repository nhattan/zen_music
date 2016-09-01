module ActivityHelper
  def color_class_by_day date
    date = date.to_date
    if date.monday?
      "bg-green"
    elsif date.tuesday?
      "bg-blue"
    elsif date.wednesday?
      "bg-aqua"
    elsif date.thursday?
      "bg-yellow"
    elsif date.friday?
      "bg-orange"
    elsif date.saturday?
      "bg-maroon"
    elsif date.sunday?
      "bg-red"
    end
  end
end
