require 'test_helper'


module Domaine
  class MondeTest < Minitest::Test

    def test_un_monde_a_une_taille_petite_par_défaut
      monde = Monde.new

      assert_equal 100, monde.carte.hauteur
      assert_equal 150, monde.carte.longueur
    end

    def test_peut_créer_un_monde_de_petite_taille
      monde = Monde.new(taille: :petit)

      assert_equal 100, monde.carte.hauteur
      assert_equal 150, monde.carte.longueur
    end

    def test_peut_créer_un_monde_de_taille_normale
      monde = Monde.new(taille: :normal)

      assert_equal 200, monde.carte.hauteur
      assert_equal 300, monde.carte.longueur
    end

    def test_peut_créer_un_monde_de_grande_taille
      monde = Monde.new(taille: :grand)

      assert_equal 300, monde.carte.hauteur
      assert_equal 450, monde.carte.longueur
    end

    def test_le_pole_nord_est_couvert_par_la_banquise
      monde = Monde.new

      assert_equal 75, taille_de_la_banquise_à_la_latitude(monde, 0)
      assert_equal 75, taille_de_la_banquise_à_la_latitude(monde, 1)
    end

    def test_le_pole_sud_est_couvert_par_la_banquise
      monde = Monde.new

      assert_equal 75, taille_de_la_banquise_à_la_latitude(monde, 99)
      assert_equal 75, taille_de_la_banquise_à_la_latitude(monde, 98)
    end

    private

    def taille_de_la_banquise_à_la_latitude(monde, latitude)
      monde.carte.régions_à_la_latitude(latitude).select{ |région| région && région.biome?(:glace) }.size
    end
  end
end
