require 'test_helper'

module Domaine
  module Position
    class PositionnableTest < Minitest::Test

      class Dummy
        include Positionnable

        def initialize(latitude, longitude)
          @latitude = latitude
          @longitude = longitude
        end
      end

      def setup
        @dummy = Dummy.new(10, 10)
      end

      def test_peut_donner_sa_position
        assert_equal Point.new(10, 10), @dummy.position
      end

      def test_peut_vérifier_sa_position
        assert @dummy.position?(Point.new(10, 10))
        refute @dummy.position?(Point.new(0, 10))
        refute @dummy.position?(Point.new(10, 0))
      end

      def test_peut_donner_la_position_nord_est
        assert_equal Point.new(9, 11), @dummy.position_nord_est
      end

      def test_peut_donner_la_position_est
        assert_equal Point.new(10, 12), @dummy.position_est
      end

      def test_peut_donner_la_position_sud_est
        assert_equal Point.new(11, 11), @dummy.position_sud_est
      end

      def test_peut_donner_la_position_sud_ouest
        assert_equal Point.new(11, 9), @dummy.position_sud_ouest
      end

      def test_peut_donner_la_position_ouest
        assert_equal Point.new(10, 8), @dummy.position_ouest
      end

      def test_peut_donner_la_position_nord_ouest
        assert_equal Point.new(9, 9), @dummy.position_nord_ouest
      end

      def test_peut_vérifier_si_adjacent_à_une_autre_position
        assert @dummy.adjacent?(Dummy.new(10, 8))
        assert @dummy.adjacent?(Dummy.new(9, 9))

        refute @dummy.adjacent?(Dummy.new(12, 12))
        refute @dummy.adjacent?(Dummy.new(10, 10))
      end

      def test_peut_donner_une_position_quelque_part_autour
        nouvelle_position = @dummy.quelque_part_autour

        assert @dummy.adjacent?(Dummy.new(nouvelle_position.latitude, nouvelle_position.longitude))
      end

      def test_aller_quelque_part_autour_ne_peut_aller_au_dessus_de_la_latitude_donnée
        @dummy.stubs(:autour).returns([:position_nord_ouest, :position_nord_est])

        assert_raises(RuntimeError){ @dummy.quelque_part_autour(latitude_min: 10) }
      end

      def test_aller_quelque_part_autour_ne_peut_aller_en_dessous_de_la_latitude_donnée
        @dummy.stubs(:autour).returns([:position_sud_ouest, :position_sud_est])

        assert_raises(RuntimeError){ @dummy.quelque_part_autour(latitude_max: 10) }
      end
    end
  end
end
