module Persistance
  class DepotMonde

    def dépose!(monde)
      Mapping::Monde.depuis_le_domaine(monde).save!
    end

    def récupère!(id)
      Mapping::Monde.find(id).vers_le_domaine
    end
  end
end
