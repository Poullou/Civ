require 'test_helper'

module Domaine
  module Carte
    class RegionTest < Minitest::Test

      def setup
        @région = Region.new(0, 0)
      end

      def test_une_region_est_positionnable
        assert @région.is_a? Position::Positionnable
        assert @région.position?(Position::Point.new(0, 0))
      end

      def test_une_région_est_par_défaut_une_écozone_océan
        assert @région.écozone?(:océan)
        refute @région.écozone?(:plaine)
      end

      def test_une_région_peut_modifier_son_écozone
        @région.modifier_écozone(:désert)

        assert @région.écozone?(:désert)
      end

      def test_une_région_peut_avoir_plusieurs_écozones
        @région.modifier_écozone(:plaine, :colline)

        assert @région.écozone?(:plaine)
        assert @région.écozone?(:colline)
      end
    end
  end
end
