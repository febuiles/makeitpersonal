module LastFm
  module Parser

    class TrackRow
      attr_reader :artist, :title, :art, :time

      def initialize(row)
        @artist = row.css("artist").first.content
        @title = row.css("name").first.content
        @art = row.css("image[size='small']").first.content
        @time = time_from_row(row)
      end

      private

      def time_from_row(row)
        begin
          time = row.css("date").attr("uts").value.to_i
          Time.at(time)
        rescue NoMethodError
          Time.now
        end
      end

    end
  end
end
