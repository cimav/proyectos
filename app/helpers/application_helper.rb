module ApplicationHelper
  def future_date(date)
    if "#{date.year}#{date.month}#{date.day}" == "#{Time.now.year}#{Time.now.month}#{Time.now.day}"
      r_date = "Hoy"
    elsif "#{date.year}#{date.month}#{date.day}" == "#{Time.now.year}#{Time.now.month}#{Time.now.day - 1}"
      r_date = "Ayer"
    elsif "#{date.year}#{date.month}#{date.day}" == "#{Time.now.year}#{Time.now.month}#{Time.now.day + 1}"
      r_date = "Mañana"
    else
      d = "#{date.year}#{date.month}#{date.day}".to_i
      t = "#{Time.now.year}#{Time.now.month}#{Time.now.day}".to_i
      r_date = "En #{t - d} días"
    end
  end
end
