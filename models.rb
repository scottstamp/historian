require 'sequel'
DB = Sequel.sqlite('atetracks.db')
require_relative 'create_tables'
class Track < Sequel::Model
	unrestrict_primary_key
end

class Mix < Sequel::Model(:mixes)
	unrestrict_primary_key
	many_to_many :tracks
end
