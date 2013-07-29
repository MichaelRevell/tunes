require 'tunes/cli'
require 'tunes/song'
require 'tunes/player'
require 'tunes/playlist'

module Tunes


  def Tunes.parse_properties(p)
    arr = {}

    p.split(',').map do |x| 
      a, b = x.split(':'); 
      arr[a.strip] = b.strip if a && b
    end

    arr
  end

  def Tunes.do(action)
    `osascript -e 'tell application \"iTunes\" to #{action}'`
  end

  def Tunes.execute(args)
    command = args.shift
    if args.empty?
      Tunes::Commands.send "#{command.to_sym}"
    else
      Tunes::Commands.send "#{command.to_sym}", *args
    end
  end
end
