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
        refute @dummy.position?(Point.new(0, 0))
      end

      def test_peut_donner_la_position_nord
        assert_equal Point.new(8, 10), @dummy.position_nord
      end

      def test_peut_donner_la_position_nord_est
        assert_equal Point.new(9, 11), @dummy.position_nord_est
      end

      def test_peut_donner_la_position_sud_est
        assert_equal Point.new(11, 11), @dummy.position_sud_est
      end

      def test_peut_donner_la_position_sud
        assert_equal Point.new(12, 10), @dummy.position_sud
      end

      def test_peut_donner_la_position_sud_ouest
        assert_equal Point.new(11, 9), @dummy.position_sud_ouest
      end

      def test_peut_donner_la_position_nord_ouest
        assert_equal Point.new(9, 9), @dummy.position_nord_ouest
      end
    end
  end
end
