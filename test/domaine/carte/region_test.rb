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

      def test_une_région_est_par_défaut_un_biome_océan
        assert @région.biome?(:océan)
        refute @région.biome?(:plaine)
      end

      def test_une_région_peut_modifier_son_biome
        @région.modifie_le_biome(:désert)

        assert @région.biome?(:désert)
      end

      def test_une_région_peut_avoir_plusieurs_biomes
        @région.modifie_le_biome(:plaine, :colline)

        assert @région.biome?(:plaine)
        assert @région.biome?(:colline)
      end
    end
  end
end
