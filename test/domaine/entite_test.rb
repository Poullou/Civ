require 'test_helper'

module Domaine
  class Dummy
    include Entité
  end

  class EntitéTest < Minitest::Test
    def setup
      @dummy = Dummy.new
    end

    def test_peut_modifier_l_id
      id = SecureRandom.uuid
      @dummy.id = id

      assert_equal id, @dummy.id
    end

    def test_peut_générer_un_id
      @dummy.génère_un_id

      assert @dummy.id =~ /[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/, "L'ID n'est pas un UUID"
    end

    def test_assigner_un_id_autre_que_un_uuid_lève_une_exception
      assert_raises(RuntimeError){ @dummy.id = 'pouet' }
    end
  end
end
