module Domaine
  class Monde
    include Entité
    attr_reader :carte, :options

    def initialize(options = {})
      @options = options
      initialise_la_carte
    end

    def liste_des_régions
      (0...@carte.hauteur).inject([]) do |liste, latitude|
        liste.push(*@carte.régions_à_la_latitude(latitude))
      end
    end

    def définit_les_régions_autour_pour_chaque_région
      liste_des_régions.each do |région|
        région.définit_les_régions_autour(régions_autour_de_la_région(région))
      end
    end

    private

    def initialise_la_carte
      @carte = CarteHexagonale.new(@options[:taille]) do |latitude, longitude|
        Region.new(latitude, longitude)
      end
      définit_les_régions_autour_pour_chaque_région
    end

    def régions_autour_de_la_région(région)
      région.autour.inject([]) do |liste, direction|
        liste.push(@carte.région_à_la_position(région.send(direction)))
      end
    end
  end
end
