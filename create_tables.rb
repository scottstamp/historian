DB.create_table :tracks do
       	primary_key     :id
        String          :title
       	String          :artist
	String		:url
	String		:type
end

DB.create_table :mixes do
       	primary_key     :id
        String          :name
	String		:author
       	String          :description
        List            :tags
end

DB.create_table :mixes_tracks do
       	int             :mix_id
        int             :track_id
       	primary_key [:mix_id, :track_id]
end
