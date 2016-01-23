require 'matrix'

module Domaine
  class Monde
    class CarteHexagonale

      def initialize(taille = nil)
        @régions = Matrix.build(*hauteur_et_longueur_par_taille(taille)) do |latitude, longitude|
          yield(latitude, longitude) if emplacement_valide?(latitude, longitude) && block_given?
        end
      end

      def hauteur
        @régions.row_vectors.size
      end

      def longueur
        @régions.column_vectors.size
      end

      def régions_à_la_latitude(latitude)
        @régions.row_vectors[latitude].each do |région|
          yield(région) if block_given? && région
        end
      end

      private

      def hauteur_et_longueur_par_taille(taille)
        {
          petit: [100, 150],
          normal: [200, 300],
          grand: [300, 450]
        }[taille] || [100, 150]
      end

      def emplacement_valide?(latitude, longitude)
        (latitude.even? && longitude.even?) || (latitude.odd? && longitude.odd?)
      end
    end
  end
end
