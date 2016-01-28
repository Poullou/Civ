require 'securerandom'

module Domaine
  module Entité

    def id
      @id
    end

    def id=(value)
      raise 'ID invalide' unless id_valide?(value)
      @id = value
    end

    def génère_un_id
      @id = SecureRandom.uuid
    end

    private

    def id_valide?(id_à_tester)
      id_à_tester =~ /[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/
    end
  end
end
