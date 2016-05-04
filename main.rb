require 'nokogiri'
require 'pp'

require_relative('post')

doc = Nokogiri::HTML(File.open('post.html'))

def extract_usernames(doc)
  doc.search('.comhead > a').map do |link|
    if link['href'].include? "user"
      link.inner_text
    end
  end
end

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

title = extract_title(doc)[0]
url = extract_url(doc)[0]
points = extract_points(doc)[0]
id = extract_id(doc)

post = Post.new(title, url, points, id)

def extract_user(doc)
  doc.search('.comhead > a').select { |link|
    link['href'].include? "user" }
    .map { |link| link.inner_text }
end

# p extract_user(doc)

def extract_age(doc)
  doc.search('.age').map do |link|
    link.inner_text
  end
end

# p extract_age(doc)

def extract_comment(doc)
  doc.search('.comment').map do |span|
    span.inner_text.gsub("  ","").gsub("\n\nreply\n\n","").gsub("\n\n-----\n\n","")
  end
end

all_comments = doc.search('td.default > span.comment').map { |comment| comment.inner_text.gsub("  ","")}



