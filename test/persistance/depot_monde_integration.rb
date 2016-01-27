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
      @dépot.dépose!(monde)

      monde_récupéré = @dépot.récupère!(monde.id)

      assert_equal monde.id, monde_récupéré.id
      assert_equal monde.options[:taille], monde_récupéré.options[:taille]
    end
  end
end
