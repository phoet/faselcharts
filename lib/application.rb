
get '/' do
  haml :index
end

helpers do
  def title
    "Faselcharts"
  end
end