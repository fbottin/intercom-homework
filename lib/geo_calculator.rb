# Module to perform Geo Calculus 
module GeoCalculator
  RAD_PER_DEG  = Math::PI/180
  RADIUS_IN_KM = 6371

  # Method to calc the distance between to geo points using
  # https://en.wikipedia.org/wiki/Great-circle_distance as reference
  def self.distance(lat, long, lat1, long1)
    delta_long = (long - long1) * RAD_PER_DEG
    lat_rad    = lat  * RAD_PER_DEG
    lat1_rad   = lat1 * RAD_PER_DEG

    central_angle =
      (Math.sin(lat_rad) * Math.sin(lat1_rad)) +
      (Math.cos(lat_rad) * Math.cos(lat1_rad) * Math.cos(delta_long))

    Math.acos(central_angle) * RADIUS_IN_KM
  end
end