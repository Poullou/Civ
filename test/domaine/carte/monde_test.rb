require 'test_helper'


module Domaine
  module Carte
    class MondeTest < Minitest::Test

      def test_un_monde_a_une_taille_petite_par_défaut
        monde = Monde.new

        assert_equal 100, monde.latitudes.size
        assert_equal 100, monde.longitudes.size
      end

      def test_peut_créer_un_monde_de_petite_taille
        monde = Monde.new(taille: :petit)

        assert_equal 100, monde.latitudes.size
        assert_equal 100, monde.longitudes.size
      end

      def test_peut_créer_un_monde_de_taille_normale
        monde = Monde.new(taille: :normal)

        assert_equal 200, monde.latitudes.size
        assert_equal 200, monde.longitudes.size
      end

      def test_peut_créer_un_monde_de_grande_taille
        monde = Monde.new(taille: :grand)

        assert_equal 300, monde.latitudes.size
        assert_equal 300, monde.longitudes.size
      end

      def test_le_pole_nord_est_couvert_par_la_banquise
        monde = Monde.new
        monde.ajoute_la_banquise

        taille_de_la_bordure_de_banquise = taille_de_la_banquise(monde, 2)

        assert_equal 50, taille_de_la_banquise(monde, 0)
        assert_equal 50, taille_de_la_banquise(monde, 1)
        assert 0 < taille_de_la_bordure_de_banquise
        assert taille_de_la_bordure_de_banquise <= 50/3
      end

      def test_le_pole_sud_est_couvert_par_la_banquise
        monde = Monde.new
        monde.ajoute_la_banquise

        taille_de_la_bordure_de_banquise = taille_de_la_banquise(monde, 97)

        assert_equal 50, taille_de_la_banquise(monde, 99)
        assert_equal 50, taille_de_la_banquise(monde, 98)
        assert 0 < taille_de_la_bordure_de_banquise
        assert taille_de_la_bordure_de_banquise <= 50/3
      end

      private

      def taille_de_la_banquise(monde, latitude)
        monde.latitudes[latitude].select{ |région| région && région.biome?(:glace) }.size
      end
    end
  end
end
