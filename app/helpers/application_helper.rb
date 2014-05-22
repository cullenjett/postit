module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def fix_date(datetime)
    datetime.strftime("%m/%d/%Y %l:%M%P %Z")
  end
end
