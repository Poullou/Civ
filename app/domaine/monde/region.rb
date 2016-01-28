module Domaine
  class Monde
    class Region
      include Position::Positionnable
      attr_reader :biomes

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
    end
  end
end
