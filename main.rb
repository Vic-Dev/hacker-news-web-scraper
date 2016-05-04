require 'nokogiri'
require 'pp'

require_relative('post')
require_relative('comment')

doc = Nokogiri::HTML(File.open('posts5.html'))

def extract_title(doc)
  doc.search('.title > a').map do |link| 
    link.inner_text 
  end
end

def extract_url(doc)
  doc.search('.title > a').map do |link|
    link['href']
  end
end

def extract_points(doc)
  doc.search('.subtext > span:first-child').map do |span|
    span.inner_text
  end
end

def extract_id(doc)
  doc.search('center > a').map { |link| link['id'] }.first.match(/\d+/).to_s.to_i
end

def extract_comment(doc)
  array = []
  doc.search('.default').map do |span|
    user_name = span.search('.comhead > a:first-child').inner_text
    age = span.search('.age').inner_text
    comment = span.search('.comment').inner_text.gsub("\n                  ","").gsub("        -----\n      ","")
    hash = {user: user_name, time: age, text: comment}
    array << hash
  end
  array
end

title = extract_title(doc)[0]
url = extract_url(doc)[0]
points = extract_points(doc)[0]
id = extract_id(doc)

post = Post.new(title, url, points, id)

extract_comment(doc).each do |comment|
  post.add_comment(Comment.new(comment[:user], comment[:time], comment[:text]))
end

pp post.comments
pp post.comments.length







