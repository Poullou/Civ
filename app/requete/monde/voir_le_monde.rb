module Requete
  module Monde
    class VoirLeMonde

      def exécute(id)
        @monde = Persistance::DépôtMonde.new.récupère!(id)
        hash_monde = { régions: [] }
        ajoute_les_régions(hash_monde)
        hash_monde
      end

      private

      def ajoute_les_régions(hash_monde)
        @monde.liste_des_régions.inject(hash_monde[:régions]) do |liste, région|
          liste << région_en_hash(région)
          liste
        end
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
