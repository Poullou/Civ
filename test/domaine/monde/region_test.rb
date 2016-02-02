require 'test_helper'

module Domaine
  class Monde
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

      def test_peut_définir_les_régions_autour
        régions_autour = [Region.new(0, 2), Region.new(1, 1), Region.new(1, 99), Region.new(0, 148)]

        @région.définit_les_régions_autour(régions_autour)

        assert régions_autour.all?{ |région| @région.voisine?(région) }
        refute @région.voisine?(Region.new(10, 10))
      end

      def test_demander_si_une_région_est_voisine_lève_une_exception_si_les_régions_voisines_n_ont_pas_été_définies
        assert_raises(RuntimeError){ @région.voisine?(Region.new(10, 10)) }
      end
    end
  end
end
