module Domaine
  module Position
    module Positionnable

      def position
        Point.new(@latitude, @longitude)
      end

      def position?(autre_position)
        position == autre_position
      end

      def position_nord
        Point.new(@latitude - 2, @longitude)
      end

      def position_nord_est
        Point.new(@latitude - 1, @longitude + 1)
      end

      def position_sud_est
        Point.new(@latitude + 1, @longitude + 1)
      end

      def position_sud
        Point.new(@latitude + 2, @longitude)
      end

      def position_sud_ouest
        Point.new(@latitude + 1, @longitude - 1)
      end

      def position_nord_ouest
        Point.new(@latitude - 1, @longitude - 1)
      end
    end
  end
end
