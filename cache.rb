require_relative 'models'

def isCached(mix_id=:mix_id)
	mix = Mix.first(:id => mix_id.to_i)
	unless mix.nil?
		(mix.tracks_dataset.count > 0)
	else
		false
	end
end

def cacheMix(mix=:mix, tracks=:tracks)
	mix = Mix.create(
		:id => mix['id'].to_i,
		:name => mix['name'],
		:author => mix['user']['login'],
		:description => mix['description'],
		:description_html => mix['description_html'],
		:tags => mix['tag_list_cache'],
		:track_count => mix['track_count']
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
