module Domaine
  class Monde
    class Banquise

      def initialize(carte)
        @carte = carte
      end

      def ajoute_la_banquise
        latitudes_de_banquise.each{ |latitude| ajoute_une_banquise_à_la_latitude(latitude) }
      end

      private

      def latitudes_de_banquise
        [0, 1, @carte.hauteur - 2, @carte.hauteur - 1]
      end

      def ajoute_une_banquise_à_la_latitude(latitude)
        @carte.régions_à_la_latitude(latitude){ |région| région.modifie_le_biome(:glace) }
      end
    end
  end
end
