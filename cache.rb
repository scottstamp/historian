require_relative 'models'

def isCached(mix_id=:mix_id)
	mix = Mix.select().where(:id => mix_id.to_i)

	if (defined? mix.tracks)
		(mix.tracks.length > 0)
	else
		false
	end
end

def cacheMix(mix=:mix, tracks=:tracks)
	mix = Mix.create(
		:id => mix['id'].to_i,
		:name => mix['name'],
		:author => mix['user']['login'],
		:description => mix['description']
	)

	tracks.each do |track|
		unless track['set'].nil?
			track = Track.create(
				:id => track['set']['track']['id'].to_i,
				:title => track['set']['track']['name'],
				:artist => track['set']['track']['performer'],
				:url => track['set']['track']['track_file_stream_url'],
				:type => track['set']['track']['stream_source']
			)

			mix.add_track(track)
		end
	end
end
