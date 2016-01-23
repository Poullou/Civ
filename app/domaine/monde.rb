module Domaine
  class Monde
    attr_reader :carte

    def initialize(options = {})
      @options = options
      initialise_la_carte
      initialise_la_banquise
    end

    private

    def initialise_la_carte
      @carte = CarteHexagonale.new(@options[:taille]) do |latitude, longitude|
        Region.new(latitude, longitude)
      end
    end

    def initialise_la_banquise
      Banquise.new(@carte).ajoute_la_banquise
    end
  end
end
