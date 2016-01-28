require 'test_helper'

module Persistance
  class DepotMondeIntegration < Minitest::Test

    def setup
      purge_database
      @dépot = DepotMonde.new
    end

    def test_peut_stocker_un_monde
      monde = Domaine::Monde.new

      @dépot.dépose!(monde)
    end

    def test_peut_récupérer_un_monde
      monde = Domaine::Monde.new(taille: :grand)
      région = monde.carte.une_région
      région.modifie_le_biome(:prairie)
      @dépot.dépose!(monde)

      monde_récupéré = @dépot.récupère!(monde.id)

      assert_equal monde.id, monde_récupéré.id, "Le monde récupéré n'est pas le bon"
      assert_equal monde.options[:taille], monde_récupéré.options[:taille], "La taille n'a pas été persistée"
      assert monde_récupéré.carte.région_à_la_position(région.position).biome?(:prairie), "La région n'a pas été persistée"
    end
  end
end
