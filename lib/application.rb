# encoding: UTF-8
# DB = "#{ENV['CLOUDANT_URL']}/cites"
# 
# get "/doc/:doc" do
#   doc = RestClient.get("#{DB}/#{params[:doc]}")
#   @result = JSON.parse(doc)
#   haml :doc_id
# end

enable :sessions

get '/' do
  @cites = [
    'Tu dir nicht weh!',
    'Verletz dich nicht!',
    'Hättste das mal bei mir gemacht!',
    'Geh schon mal raus, lauf dich warm und fang schon mal an zu bluten.',
    'Ich mein schon was du weißt.',
    'I told you, I schmit you down the Kellertreppe and you never come back to the Tageslicht again!',
    'Mach mal \'nen Satz draus.',
    'Was ist die Hälfte von Wasser.',
    'Schrei mich nicht an!',
    'I break together, I can\'t no more!',
    'Gänsefleisch mein Koffer tragen...',
    'Du do ne do!',
    'Ja ja ja ja, nee.',
    'Ein Glück, dass Bewegungslegasthenie nicht vererbbar ist.',
    'Piss off, I tell you something!',
    'War Daniel eigentlich beim Frisör.',
    'Sowas von 80er...',
    'Lösen durch Anstarren.'
    ]
  @random_cite = @cites.shuffle.first
  if params['s']
    @search_term = session[:term] = params['s']
    @search_results = @cites.grep(/#{@search_term}/i)
  end
  if params['add']
    @cites << session[:term]
    @random_cite = session[:term]
  end
  haml :index
end

helpers do
  def title
    "Faselcharts"
  end
end