class ApiRequest < ActiveRecord::Base
  def self.incr(endpoint="/lyrics")
    counter = find_or_create_by_endpoint(endpoint)
    counter.update_attribute(:count, counter.count + 1)
  end

  def self.entry_count(endpoint="/lyrics")
    find_by_endpoint(endpoint).try(:count)
  end
end
