module Domaine
  module Carte
    class Region
      include Position::Positionnable

      def initialize(latitude, longitude)
        @latitude = latitude
        @longitude = longitude
        @écozones = [:océan]
      end

      def écozone?(écozone)
        @écozones.include?(écozone)
      end

      def modifier_écozone(*écozones)
        @écozones = écozones
      end
    end
  end
end
