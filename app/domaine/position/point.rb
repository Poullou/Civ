module Domaine
  module Position
    class Point
      attr_reader :latitude, :longitude

      def initialize(latitude, longitude)
        @latitude = latitude
        @longitude = longitude
      end

      def ==(autre_point)
        @latitude == autre_point.latitude && @longitude == autre_point.longitude
      end
    end
  end
end
