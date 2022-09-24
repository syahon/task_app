module PostsHelper
  def all_day_display(post)
    post.all_day ? "○" : ""
  end

  def start_day_format(post)
    date = post.start_day
    "#{date.year}年#{date.month}月#{date.day}日"
  end

  def end_day_format(post)
    date = post.end_day
    "#{date.year}年#{date.month}月#{date.day}日"
  end
end
