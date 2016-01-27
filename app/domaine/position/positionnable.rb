module Domaine
  module Position
    module Positionnable

      def position
        Point.new(@latitude, @longitude)
      end

      def position?(autre_position)
        position == autre_position
      end

      def position_nord_est
        Point.new(@latitude - 1, @longitude + 1)
      end

      def position_est
        Point.new(@latitude, @longitude + 2)
      end

      def position_sud_est
        Point.new(@latitude + 1, @longitude + 1)
      end

      def position_sud_ouest
        Point.new(@latitude + 1, @longitude - 1)
      end

      def position_ouest
        Point.new(@latitude, @longitude - 2)
      end

      def position_nord_ouest
        Point.new(@latitude - 1, @longitude - 1)
      end

      def adjacent?(objet)
        autour.any?{ |position_autour| objet.position?(send(position_autour)) }
      end

      def autour
        [:position_nord_est, :position_est, :position_sud_est, :position_sud_ouest, :position_ouest, :position_nord_ouest]
      end

      def quelque_part_autour(options = {})
        options[:directions_interdites] ||= []
        raise 'Aucune direction disponible' if options[:directions_interdites].size == autour.size
        direction = (autour - options[:directions_interdites]).sample
        autour = send(direction)
        if zone_interdite?(autour, options)
          options[:directions_interdites].push(direction)
          autour = quelque_part_autour(options)
        end
        autour
      end

      private

      def zone_interdite?(point, options)
        (options[:latitude_min] && point.latitude < options[:latitude_min]) || (options[:latitude_max] && point.latitude > options[:latitude_max])
      end
    end
  end
end
