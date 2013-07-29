module Tunes
  class Player
    attr_reader :current_song
    attr_reader :current_playlist

    def initialize
      update
    end

    def update
      @current_song = Tunes::Song.new(:current)
      @current_playlist = Tunes::Playlist.new(:current)
    end

    def state
      Tunes.do('get player state').chomp
    end

    def play(index = nil)
      if index.nil?
        Tunes.do("play")
      else
        Tunes.do "play track #{index}"
      end
    end

    def next
      Tunes.do("play (next track)")
    end

    def prev
      Tunes.do("play (previous track)")
    end

    def stop
      Tunes.do("stop")
    end

    def pause
      Tunes.do("pause")
    end

    def volume
      Tunes.do("get sound volume").to_i
    end

    def volume=(set)
      vol = self.volume
      if set == "up"
        new_volume = vol + 10
      elsif set == "down"
        new_volume = vol - 10
      else
        new_volume = set
      end

      new_volume = new_volume.to_i
      new_volume = [0, [new_volume, 100].min].max
      Tunes.do("set sound volume to #{new_volume}")
    end

    def find_songs(string)
      s = Tunes.do "get properties of (file tracks whose name contains \"#{string}\")"
      songs = s.split("class:file track,").map { |x| Song.new(Tunes.parse_properties(x)) }
      songs.shift
      s = Tunes.do "get properties of (file tracks whose artist contains \"#{string}\")"
      artists = s.split("class:file track,").map { |x| Song.new(Tunes.parse_properties(x)) }
      artists.shift
      artists.each { |a| songs << a }
      songs
    end

    def playlists
      lists = Tunes.do "get properties of playlists"
      lists = lists.split("class:user playlist,").map do |x|
        Playlist.new(Tunes.parse_properties(x))
      end
      lists.shift
      lists
    end

  end
end
