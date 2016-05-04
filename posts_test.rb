require 'nokogiri'

doc = Nokogiri::HTML(File.open('posts.html'))

def extract_usernames(doc)
  doc.search('.comhead > a:first-child').map do |element|
    element.inner_text
  end
end

extract_usernames(doc)

doc.search('.subtext > span:first-child').map { |span| span.inner_text }
doc.search('.subtext > a:nth-of-type(2)').map { |link| link['href'] }
doc.search('.title > a:nth-of-type(1)').map { |link| link.inner_text }
doc.search('.title > a:nth-of-type(1)').map { |link| link['href'] }
puts doc.search('.comment > span:nth-of-type(1)').map { |span| span.inner_text }
