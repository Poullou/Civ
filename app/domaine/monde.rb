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
        liste
      end
    end

    private

    def initialise_la_carte
      @carte = CarteHexagonale.new(@options[:taille]) do |latitude, longitude|
        Region.new(latitude, longitude)
      end
    end
  end
end
