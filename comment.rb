class Comment

  attr_reader :user, :time, :text

  def initialize(user, time, text)
    @user = user
    @time = time
    @text = text
  end

end