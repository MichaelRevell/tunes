require 'thor'
require 'tunes'

module Tunes
  class Cli < Thor

    desc 'status', 'Status of the iTunes Player'
    def status
      state = player.state
      puts "iTunes is #{state}"
      unless state == "stopped"
        puts
        puts "title: #{player.current_song.name}"
        puts "artist: #{player.current_song.artist}"
        puts "album: #{player.current_song.album}"
        puts "rating: #{player.current_song.rating}"
      end
    end

    desc 'play', 'Begin playing a song'
    def play(index = nil)
      player.play(index)
    end

    desc 'pause', 'Pause the current song'
    def pause
      player.pause
    end 

    desc 'stop', 'Stop playing music'
    def stop
      player.stop
    end

    desc 'next', "Play the next song in the playlist"
    def next
      player.next
    end

    desc 'prev', "Play the previous song in the playlist"
    def prev
      player.prev
    end

    desc 'rating', "Display the rating of the current song"
    def rating
      puts player.current_song.rating
    end

    desc 'vol', "Turn volume up or down"
    def vol(*args)
      v = args.shift
      if v.nil?
        puts player.volume
      else 
        player.volume = v
      end
    end

    desc 'lyrics', "Display the lyrics of the current song"
    def lyrics
      puts player.current_song.lyrics
    end

    desc 'set', "Set various values of the song"
    def set(*args)
      atribute = args.shift
      if atribute == 'rating'
        rating = args.shift
        player.current_song.rating = rating
      elsif atribute == 'lyrics'
        $/ = "END"
        lyrics = $stdin.gets.chomp
        player.current_song.lyrics = lyrics.inspect.gsub("\"", '')
      end
    end

    desc 'all', "Display all attributes for a song"
    def all
      player.current_song.all.each do |line|
        puts line
      end
    end

    desc 'search', "Search songs matching a given string"
    def search(string)
      songs = player.find_songs(string)
      songs.each do |s|
        puts "#{s.index}) #{s.name} - #{s.artist}"
      end
    end

    desc 'playlists', 'Prints the name of all of your playlists'
    def playlist(attribute = nil)
      if attribute.nil?
        puts player.current_playlist.name
      else
        player.playlists.each do |p|
          puts "#{p.index}) #{p.name}"
        end
      end
    end

    desc 'playlist', 'Prints the name of the current playlist'
    def playlist(attribute = nil)
      if attribute.nil?
        puts player.current_playlist.name
      else
        player.current_playlist.all.each do |line|
          puts line
        end
      end
    end

    private

      def player
        @player ||= Tunes::Player.new
      end

  end
end
