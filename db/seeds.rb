require 'json'
require 'net/http'
require 'addressable/uri'

# Clean out db
puts '-----------------------------'
puts '----- Cleaning Database -----'
puts '-----------------------------'
KanjiCharacter.destroy_all
User.destroy_all

# Create Test User
puts '-------------------------'
puts '----- Creating User -----'
puts '-------------------------'
User.create!(
  firstname: 'George',
  lastname: 'Hunter',
  email: 'georgeh@example.com',
  password: 'PoliteGracefulHungry92'
)
puts '-------------------------'
puts '----- User Created! -----'
puts '-------------------------'

# kanji_api base url
base_url = 'https://kanjiapi.dev/v1/kanji'

# method for jlpt urls
def jlpt_url(level)
  "https://kanjiapi.dev/v1/kanji/jlpt-#{level}"
end

jlpt5 = jlpt_url('5')
jlpt4 = jlpt_url('4')
jlpt3 = jlpt_url('3')
jlpt2 = jlpt_url('2')
jlpt1 = jlpt_url('1')

# array holding all jlpt urls
all_jlpt_url = [jlpt5, jlpt4, jlpt3, jlpt2, jlpt1]

# array holding all kanji regardless of jlpt level
all_kanji = []

# parse each jlpt url > append all_kanji array with each individual character
all_jlpt_url.each do |url|
  url_json = URI.parse(url).read
  characters = JSON.parse(url_json)
  characters.each do |c|
    # insert kanji into all_kanji array
    all_kanji << c
  end
end

# take each character, pass it in to the base_url and match model columns with api values. Save into db
all_kanji.each_with_index do |kanji_character, index|
  get_kanji_url = "#{base_url}/#{kanji_character}"
  uri = Addressable::URI.parse(get_kanji_url) # use Addressable gem as 'kanji' is a non ascii character
  uri.normalize!
  response = Net::HTTP.get(uri)
  kanji = JSON.parse(response)

  kun_readings = kanji['kun_readings']
  on_readings  = kanji['on_readings']
  meanings     = kanji['meanings']
  heisig_en    = kanji['heisig_en']
  jlpt         = kanji['jlpt']
  kanji        = kanji['kanji']

  KanjiCharacter.create!(
    jlpt: jlpt,
    kanji: kanji,
    heisig_en: heisig_en,
    kun_readings: kun_readings,
    on_readings: on_readings,
    meanings: meanings
  )

  puts "----- #{index + 1}: Kanji Saved -----"
end

puts '----------------------------------------'
puts '----- All Kanji Saved to Database! -----'
puts '----------------------------------------'
