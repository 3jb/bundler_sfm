#!/usr/bin/env ruby

require 'flickraw'
require 'open-uri'


@SEARCH_TERM = "mt rainier"
@IMG_DIR = "img/"

FlickRaw.api_key="7673f29cb55eddccaf8e9b107047cf6c"
FlickRaw.shared_secret="d777249184154c9b"

#collect list
list = flickr.photos.search :text => @SEARCH_TERM, :per_page => 500

id = list[0].id
list.each{ |i|
  # wait to be a better citizen
  sleep(0.3)
  id=i.id
  sizes = flickr.photos.getSizes :photo_id => id
  sizes.each{ |s|
    if s.label == "Medium" then
      puts "get #{s.source}"
      #save the image locally
      open( "#{@IMG_DIR}#{id}.jpg", 'wb'){ |file| 
	file << open(s.source).read
      }
    end
  }
}
#how many did we grab
puts "collected #{list.length} images"
