require 'test_helper'

module Requete
  module Monde
    class VoirLeMondeTest < Minitest::Test

      def test_peut_voir_le_monde_avec_chacune_de_ses_régions
        monde = Domaine::Monde.new
        monde.carte.une_région.modifie_le_biome(:prairie)
        monde.génère_un_id
        Persistance::DepotMonde.any_instance.expects(:récupère!).with(monde.id).returns(monde).once
        requete = VoirLeMonde.new

        hash_monde = requete.exécute(monde.id)

        assert_equal monde.carte.hauteur * monde.carte.longueur / 2,  hash_monde[:régions].size
        assert hash_monde[:régions].all?{ |hash_région| hash_région[:biomes].include?(:océan) || hash_région[:biomes].include?(:prairie) }
        assert hash_monde[:régions].all?{ |hash_région| hash_région[:latitude] && hash_région[:longitude] }
      end
    end
  end
end
