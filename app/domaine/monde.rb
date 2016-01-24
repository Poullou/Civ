module Domaine
  class Monde
    attr_reader :carte

    def initialize(options = {})
      @options = options
      initialise_la_carte
    end

    def ajoute_une_île(climat)
      construit_une_écozone(rand(10), climat)
    end

    private

    def initialise_la_carte
      @carte = CarteHexagonale.new(@options[:taille]) do |latitude, longitude|
        Region.new(latitude, longitude)
      end
    end

    def construit_une_écozone(taille, climat)
      écozone = []
      région = @carte.une_région
      taille.times do
        modifie_le_climat(région, climat)
        écozone << région
        région = nouvelle_région_adjacente_à_modifier(écozone)
      end
      écozone
    end

    def modifie_le_climat(région, climat)
      région.modifie_le_biome(:prairie)
    end

    def nouvelle_région_adjacente_à_modifier(régions_modifiées)
      loop do
        région = @carte.région_à_la_position(régions_modifiées.last.quelque_part_autour)
        return région unless régions_modifiées.include?(région)
      end
    end
  end
end