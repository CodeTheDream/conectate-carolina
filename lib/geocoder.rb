def nearbys(radius = 20)
	return [] unless geocoded?
	lat,lon = self.class._get_coordinates(self)
	self.class.find_near([lat, lon], radius) - [self]
end