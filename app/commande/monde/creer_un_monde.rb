module Commande
  module Monde
    class CréerUnMonde

      def exécute(paramètres)
        monde = Domaine::Monde.new(taille: paramètres[:taille])
        monde.id = paramètres[:id]
        constructeur_d_îles = Domaine::Monde::Ile.new(monde.carte)
        2.times{ constructeur_d_îles.ajoute_une_île }
        Domaine::Monde::Banquise.new(monde.carte).ajoute_la_banquise
        Persistance::DepotMonde.new.dépose!(monde)
      end
    end
  end
end
