# encoding: UTF-8

STORE = RedisStore.new

FASEL_TOKEN = '#faselcharts'

get '/update' do
  puts "updating twitter stream"
  Twitter.search(FASEL_TOKEN).results.each do |tweet|
    msg = tweet.text.gsub(FASEL_TOKEN, '').strip
    STORE.add(msg)
  end
  'OK'
end

get '/vote' do
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

  def link_to_vote(entry, type)
    id = tooltip_id(entry, type)
    "#{tooltip(entry, id, 'Vote')}<a href='/vote?vote=#{escape(entry.value)}' class='vote' name='#{id}'>(#{entry.votes})</a> #{cite(entry)}"
  end

  def link_to_reload(entry)
    id = tooltip_id(entry, :reload)
    "#{tooltip(entry, id, 'Reload')}<a id='reload' name='#{id}' href='#'>&#x21A9;</a> <cite>#{cite(entry)}</cite>"
  end

  def tooltip(entry, id, msg)
    "<span class='tooltip hidden' id='#{id}'><abbr>#{msg} &#x2192;</abbr></span>"
  end

  def tooltip_id(entry, type)
    "tooltip_#{type}_#{entry.hash.abs}"
  end

  def cite(entry)
    "“#{entry.value}”"
  end
end
