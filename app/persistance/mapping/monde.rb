module Persistance
  module Mapping
    class Monde
      include Mongoid::Document
      field :_id, type: String
      field :options, type: Hash
      field :régions, type: Array

      class << self
        def depuis_le_domaine(monde)
          monde.génère_un_id if monde.id.nil?
          new({
            _id: monde.id,
            options: monde.options,
            régions: monde.liste_des_régions.map{ |région| {
              latitude: région.position.latitude,
              longitude: région.position.longitude,
              biomes: région.biomes
            }}
          })
        end
      end

      def vers_le_domaine
        monde = Domaine::Monde.new(options)
        régions.each do |région|
          position = Domaine::Position::Point.new(région[:latitude], région[:longitude])
          monde.carte.région_à_la_position(position).modifie_le_biome(*région[:biomes])
        end
        monde.id = _id
        monde
      end
    end
  end
end
