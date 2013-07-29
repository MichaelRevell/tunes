module Tunes
  class Playlist

    def initialize(properties = :current)
      @properties = properties == :current ? get_current_playlist: properties
    end

    def get_current_playlist
      r = Tunes.do("get properties of current playlist")
      @properties = Tunes.parse_properties(r)
    end

    def name
      @properties["name"]
    end

    def duration
      @properties["duration"]
    end

    def size
      @properties["size"]
    end

    def visible
      @properties["visible"]
    end

    def shuffle
      @properties["shuffle"]
    end

    def index
      @properties["index"]
    end

    def all
      a = Array.new
      @properties.each { |key, value| a << "#{key}: #{value}" }
      a
    end
  end
end
