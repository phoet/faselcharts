# encoding: UTF-8
enable :sessions

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
  if @search_term = session[:term] = params['s']
    @search_results = @cites.select{|cite| cite.value =~ /#{@search_term}/i }
  end
  if params['add']
    @random_cite = STORE.add(session[:term])
  end
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
