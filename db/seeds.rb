require 'json'
require 'net/http'
require 'addressable/uri'

puts '--- Cleaning Database ---'
KanjiCharacter.destroy_all

# kanji_api base url
url = 'https://kanjiapi.dev/v1/kanji'

# method for jlpt urls
def jlpt_url(level)
  "https://kanjiapi.dev/v1/kanji/jlpt-#{level}"
end

jlpt5 = jlpt_url('5')
jlpt4 = jlpt_url('4')
jlpt3 = jlpt_url('3')
jlpt2 = jlpt_url('2')
jlpt1 = jlpt_url('1')

# array holding all kanji regardless of jlpt level
all_kanji = []

parsed = URI.parse(jlpt5).read
characters = JSON.parse(parsed)
characters.each do |c|
  all_kanji << c
end

url2 = "#{url}/#{all_kanji[4]}"

parsed2 = Addressable::URI.parse(url2)
parsed2.normalize!
response = Net::HTTP.get(parsed2)
kanji = JSON.parse(response)

puts kanji
