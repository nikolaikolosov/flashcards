# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'nokogiri'
require 'open-uri'

def parser (url)
  doc = Nokogiri::HTML(open(url))
  doc.search('//table/tbody/tr').each do |row|
    original = row.search('td[2]')[0].content.to_s
    translated = row.search('td[3]')[0].content.to_s
    if original != 'German word ' && translated != 'English translation' && translated != ''
      Card.create(original_text: original, translated_text: translated)
    end
  end
end

parser("http://www.languagedaily.com/learn-german/vocabulary/common-german-words")
parser("http://www.languagedaily.com/learn-german/vocabulary/most-common-german-words-2")
(3..12).each do |n|
  parser("http://www.languagedaily.com/learn-german/vocabulary/common-german-words-#{n}")
end