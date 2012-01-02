module LastFm
  module Parser
    def time_from_row(row)
      begin
        time = row.attr("uts").value.to_i
        Time.at(time)
      rescue NoMethodError
        Time.now
      end
    end
  end
end
