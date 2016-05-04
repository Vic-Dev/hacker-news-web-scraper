class Post

  attr_reader :title, :url, :points, :item_id

  def initialize(title, url, points, item_id)
    @title = title
    @url = url
    @points = points
    @item_id = item_id
    @comment_list = []
  end

  def comments
    # returns all the comments associated with a particular post

  end

  def add_comment(comment)
    # takes a Comment object as its input and adds it to the comment list
    @comment_list << comment
  end

end