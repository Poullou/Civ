module Requete
  module Monde
    class VoirLeMonde

      def exécute(id)
        @monde = Persistance::DepotMonde.new.récupère!(id)
        hash_monde = { régions: [] }
        ajoute_les_régions(hash_monde)
        hash_monde
      end

      private

      def ajoute_les_régions(hash_monde)
        (0...@monde.carte.hauteur).each{ |latitude| hash_monde[:régions].push(*régions_de_la_latitude(latitude)) }
      end

      def régions_de_la_latitude(latitude)
        régions_en_hash(@monde.carte.régions_à_la_latitude(latitude))
      end

      def régions_en_hash(régions)
        régions.map{ |région| région_en_hash(région) }
      end

      def région_en_hash(région)
        position = région.position
        {
          latitude: position.latitude,
          longitude: position.longitude,
          biomes: région.biomes
        }
      end
    end
  end
end
