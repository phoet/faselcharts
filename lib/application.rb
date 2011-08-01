# encoding: UTF-8

STORE = RedisStore.new

FASEL_TOKEN = '#faselcharts'

get '/update' do
  puts "updating twitter stream"
  Twitter::Search.new.q(FASEL_TOKEN).fetch.each do |tweet|
    msg = tweet.text.gsub(FASEL_TOKEN, '').strip
    STORE.add(msg)
  end
  'OK'
end

get '/vote' do
  puts "voting #{params['vote']}"
  STORE.vote(params['vote'])
end

get '/' do
  @cites = STORE.list
  @random_cite = @cites.shuffle.first
  haml :index
end

helpers do
  include Rack::Utils

  def title
    "Faselcharts"
  end

  def cite(entry)
    "<a href='/vote?vote=#{escape(entry.value)}' class='vote' title='Er hats schon wieder gemacht!'>(#{entry.votes})</a> “#{entry.value}”"
  end
end
