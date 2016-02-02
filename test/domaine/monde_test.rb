require 'test_helper'

module Domaine
  class MondeTest < Minitest::Test

    def test_un_monde_est_une_entité
      assert Monde.new.is_a? Entité
    end

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

    def test_peut_utiliser_un_string_au_lieu_d_un_symbole_pour_la_taille
      monde = Monde.new(taille: 'normal')

      assert_equal 200, monde.carte.hauteur
      assert_equal 300, monde.carte.longueur
    end

    def test_peut_lister_les_régions
      monde = Monde.new
      prairie = monde.carte.une_région
      prairie.modifie_le_biome(:prairie)

      régions = monde.liste_des_régions

      assert_equal monde.carte.hauteur * monde.carte.longueur / 2, régions.size, 'Le nombre de régions listées est faux'
      assert régions.all?{ |région| région.biome?(:océan) || région.biome?(:prairie) }, "Au moins une région n'a pas le bon biome"
      assert régions.any?{ |région| région.biome?(:prairie) && région.position == prairie.position }, "La prairie est au bon endroit"
    end

    def test_le_pole_nord_est_couvert_par_la_banquise
      monde = Monde.new

      Monde::Banquise.new(monde.carte).ajoute_la_banquise

      assert_equal 75, taille_de_la_banquise_à_la_latitude(monde, 0), 'La première couche de la banquise nord est incomplète'
      assert_equal 75, taille_de_la_banquise_à_la_latitude(monde, 1), 'La seconde couche de la banquise nord est incomplète'
    end

    def test_le_pole_sud_est_couvert_par_la_banquise
      monde = Monde.new

      Monde::Banquise.new(monde.carte).ajoute_la_banquise

      assert_equal 75, taille_de_la_banquise_à_la_latitude(monde, 99), 'La première couche de la banquise sud est incomplète'
      assert_equal 75, taille_de_la_banquise_à_la_latitude(monde, 98), 'La seconde couche de la banquise sud est incomplète'
    end

    def test_peut_définir_pour_chaque_région_les_régions_autour
      monde = Monde.new

      assert monde.liste_des_régions.all?{ |région| région.régions_autour }, "Des régions n'ont pas encore connaissance de leur voisine"
    end

    def test_peut_créer_une_île_avec_un_climat
      monde = Monde.new

      île = Monde::Ile.new(monde.carte).ajoute_une_île

      assert île.size > 0, "L'île est trop petite"
      assert île.size <= Monde::Ile::TAILLE_MAX, "L'île est trop grande"
      assert île.size == 1 || île.all?{ |région| île.any?{ |autre_région| région.voisine?(autre_région) }}, 'Les régions ne sont pas voisines'
    end

    private

    def taille_de_la_banquise_à_la_latitude(monde, latitude)
      monde.carte.régions_à_la_latitude(latitude).select{ |région| région && région.biome?(:glace) }.size
    end
  end
end
