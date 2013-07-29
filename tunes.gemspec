# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tunes/version'

Gem::Specification.new do |s|
  s.name              = "tunes"
  s.version           = Tunes::VERSION
  s.summary           = "Command-line utility to control iTunes"
  s.homepage          = "http://github.com/michaelrevell/tunes"
  s.license           = 'BSD'
  s.email             = "mikearevell@gmail.com"
  s.authors           = [ "Michael Revell" ]
  s.require_paths   = ['lib']

  s.files            += Dir.glob("bin/**/*")
  s.files            += Dir.glob("lib/**/*")

  s.required_ruby_version = '>= 1.9.2'
  s.add_dependency 'thor'

  s.executables       = %w( tunes )
  s.description       = <<desc
  `tunes` is a command line utility which allows you to control itunes
  from the command line.


  Usage:

      $ tunes current
      Gets current song

      $ tunes next
      Jumps to next song

      $ tunes previous
      Jumps to previous song

      $ tunes rating
      Gets current songs rating

      $ tunes set rating 4
      Sets the rating of the current song to 4
desc
end
