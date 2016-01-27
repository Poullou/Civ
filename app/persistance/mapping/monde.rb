module Persistance
  module Mapping
    class Monde
      include Mongoid::Document
      field :_id, type: String
      field :options, type: Hash
      # field :carte, type: CarteHexagonale

      class << self
        def depuis_le_domaine(monde)
          monde.génère_un_id if monde.id.nil?
          new(_id: monde.id, options: monde.options)
        end
      end

      def vers_le_domaine
        monde = Domaine::Monde.new(options)
        monde.id = _id
        monde
      end
    end
  end
end
