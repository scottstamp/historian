DB.create_table? :tracks do
       	primary_key     :id
        String          :title
       	String          :artist
		String			:url
		String			:type
end

DB.create_table? :mixes do
       	primary_key     :id
        String          :name
		String			:author
       	String          :description
		String			:description_html
		String			:track_count
        String          :tags
end

DB.create_table? :mixes_tracks do
       	foreign_key     :mix_id, :mixes, :null => false
       	foreign_key     :track_id, :tracks, :null => false
       	primary_key [:mix_id, :track_id]
       	index [:mix_id, :track_id]
end
