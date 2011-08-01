# encoding: UTF-8
$:.unshift ::File.join(::File.dirname(__FILE__), 'lib')

require 'rubygems'
require 'bundler'

Bundler.require

require 'redis_store'

namespace :faselcharts do
  desc "import inital cites"
  task :import do
    store = RedisStore.new
    store.clear
    [
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
      ].each do |cite|
        store.add cite
      end
  end
end
