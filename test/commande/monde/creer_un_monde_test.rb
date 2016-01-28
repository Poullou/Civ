require 'test_helper'

module Commande
  module Monde
    class CréerUnMondeTest < Minitest::Test

      def test_peut_créer_un_monde_avec_paramètres_et_le_faire_persister
        id = SecureRandom.uuid
        commande = CréerUnMonde.new
        Persistance::DépôtMonde.any_instance.expects(:dépose!).once.with(){ |monde| monde.id == id && monde.options[:taille] == 'normal' }
        Domaine::Monde::Banquise.any_instance.expects(:ajoute_la_banquise).once
        Domaine::Monde::Ile.any_instance.expects(:ajoute_une_île).twice

        commande.exécute(id: id, taille: 'normal')
      end
    end
  end
end
