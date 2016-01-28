module Domaine
  class Monde
    class Ile

      TAILLE_MAX = 10

      def initialize(carte)
        @carte = carte
      end

      def ajoute_une_île
        construit_une_écozone(rand(TAILLE_MAX) + 1)
      end

      private

      def construit_une_écozone(taille)
        écozone = []
        région = @carte.une_région
        taille.times do
          région.modifie_le_biome(:prairie)
          écozone << région
          région = nouvelle_région_adjacente_à_modifier(écozone)
          break if région.nil?
        end
        écozone
      end

      def nouvelle_région_adjacente_à_modifier(régions_modifiées)
        loop do
          région = @carte.région_à_la_position(régions_modifiées.last.quelque_part_autour(latitude_min: 0, latitude_max: @carte.hauteur))
          return région unless régions_modifiées.include?(région)
        end
      end
    end
  end
end
