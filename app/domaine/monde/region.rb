module Domaine
  class Monde
    class Region
      include Position::Positionnable
      attr_reader :biomes, :régions_autour

      def initialize(latitude, longitude)
        @latitude = latitude
        @longitude = longitude
        @biomes = [:océan]
      end

      def biome?(biome)
        @biomes.include?(biome)
      end

      def modifie_le_biome(*biomes)
        @biomes = biomes
      end

      def définit_les_régions_autour(régions_autour)
        @régions_autour = régions_autour
      end

      def voisine?(région)
        raise 'Régions autour non définies' if @régions_autour.nil?
        @régions_autour.any?{ |voisine| voisine.position?(région.position) }
      end
    end
  end
end
