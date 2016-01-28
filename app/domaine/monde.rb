module Domaine
  class Monde
    include Entité
    attr_reader :carte, :options

    def initialize(options = {})
      @options = options
      initialise_la_carte
    end

    private

    def initialise_la_carte
      @carte = CarteHexagonale.new(@options[:taille]) do |latitude, longitude|
        Region.new(latitude, longitude)
      end
    end
  end
end
