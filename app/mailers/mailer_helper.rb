module MailerHelper
  def format_time(minutes)
    "#{minutes / 60}:#{minutes % 60}"
  end
end
