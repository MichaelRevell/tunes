module Tunes
  class Song

    def initialize(properties = :current)
      @properties = properties == :current ? get_current_song : properties
      #puts "new song"
    end

    def get_current_song
      r = Tunes.do("get properties of current track")
      @properties = Tunes.parse_properties(r)
    end

    def index
      @properties["index"]
    end

    def name
      @properties["name"]
    end

    def artist
      @properties["artist"]
    end

    def album
      @properties["album"]
    end

    def rating
      @properties["rating"]
    end

    def lyrics
      # This is hacky and should probably be fixed
      l = Tunes.do "get lyrics of current track"
      l.gsub("\r", "\n")

      # This is how we SHOULD do it, but it's not working :/
      #@properties["lyrics"].gsub("\r", "\n")
    end

    def all
      a = Array.new
      @properties.each { |key, value| a << "#{key}: #{value}" }
      return a
    end



    def rating=(rating)
      @properties["rating"] = rating
      Tunes.do("set rating of current track to #{rating}")
    end

    def lyrics=(lyrics)
      @properties["lyrics"] = lyrics
      Tunes.do("set lyrics of current track to \"#{lyrics}\"")
    end
    
  end
end
