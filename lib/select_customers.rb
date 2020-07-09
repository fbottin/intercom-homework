require_relative('geo_calculator')

# Class used to select customers based on the distance from an
# initial geolocation, and sort it based on a field and order
class SelectCustomers
  attr_reader :customers

  def initialize(customers, lat_origin, long_origin)
    @customers   = customers
    @lat_origin  = lat_origin
    @long_origin = long_origin
  end

  # select customers that are in a specified range from
  # the initial geolocation
  def select_in_range(range: 100.00)
    @customers.select! { |c| customer_in_range(c, range) }
  end

  # sort the customers based on a specified field and order
  def sort(field: 'user_id', order: :asc)
    @customers.sort_by! { |c| c[field] }
    @customers.reverse! if order == :desc
    @customers
  end

  private
  
  # method to calculate the distance using the GeoCalculator
  # and checks if the distance is inside the specified range
  def customer_in_range(customer, range)
    distance = GeoCalculator.distance(
      customer['latitude'].to_f, customer['longitude'].to_f,
      @lat_origin, @long_origin
    )

    distance <= range.to_f
  end
end