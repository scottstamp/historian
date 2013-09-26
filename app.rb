require 'httparty'
require_relative 'cache'
class EightTracks
	@token = ''
	include HTTParty
	base_uri '8tracks.com'
	format :json

	def initialize
		@token = self.class.get("/sets/new?format=jsonh")['play_token']
	end

	def get_mix_data(mix_id=:mix_id)
		self.class.get("/mixes/#{mix_id}?format=jsonh")['mix']
	end

	def request_playlist(mix_id=:mix_id)
		tracks = [self.request_track(mix_id, 'play')]
		next_track = self.request_track(mix_id, 'next')
		until next_track['set']['at_end']
			tracks << next_track
			begin
				next_track = self.request_track(mix_id, 'next')
			rescue
				sleep(1)
				next_track = self.request_track(mix_id, 'next')
			end
		end
		tracks
	end

	def request_track(mix_id=:mix_id, which=:which)
		self.class.get("/sets/#{@token}/#{which}?mix_id=#{mix_id}&format=jsonh")
	end
end

unless isCached('123455')
	et = EightTracks.new
	cacheMix(et.get_mix_data('123455'), et.request_playlist('123455'))
end

Mix.each do |mix|
	puts "Name: #{mix[:name]}"
	puts "Author: #{mix[:author]}"
	puts "Description: #{mix[:description]}"
	puts "Number of songs: #{mix[:track_count]}"
	puts "Tags: #{mix[:tags]}"
	mix.tracks.each do |track|
		puts ""
		puts "#{track[:title]} - #{track[:artist]}"
		puts track[:url]
	end
end
