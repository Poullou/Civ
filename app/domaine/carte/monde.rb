require 'matrix'

module Domaine
  module Carte
    class Monde

      def initialize(options = {})
        @options = options
        initialise_les_régions
      end

      def latitudes
        @régions.row_vectors
      end

      def longitudes
        @régions.column_vectors
      end

      def ajoute_la_banquise
        [0, 1, taille - 2, taille - 1].each{ |latitude| ajoute_une_banquise_à_la_latitude(latitude) }
        [2, taille - 3].each{ |latitude| ajoute_des_icebergs_à_la_latitude(latitude) }
      end

      private

      def taille
        { petit: 100, normal: 200, grand: 300 }[@options[:taille]] || 100
      end

      def initialise_les_régions
        @régions = Matrix.build(taille, taille) do |latitude, longitude|
          région_utilisable?(latitude, longitude) ? Region.new(latitude, longitude) : nil
        end
      end

      def région_utilisable?(latitude, longitude)
        (latitude.even? && longitude.even?) || (latitude.odd? && longitude.odd?)
      end

      def ajoute_une_banquise_à_la_latitude(latitude)
        latitudes[latitude].each{ |région| région && région.modifier_écozone(:glace) }
      end

      def ajoute_des_icebergs_à_la_latitude(latitude)
        icebergs_disponibles = taille / 6
        latitudes[latitude].each{ |région| icebergs_disponibles = ajoute_un_iceberg(région, icebergs_disponibles) }
      end

      def ajoute_un_iceberg(région, icebergs_disponibles)
        if région && rand(taille) < taille / 3 && icebergs_disponibles > 0
          région.modifier_écozone(:glace)
          icebergs_disponibles -= 1
        end
        icebergs_disponibles
      end
    end
  end
end
