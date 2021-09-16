module CountiesHelper
  def county_options
    hash = {}
    County.all.pluck(:name).each { |name| hash[name] = name }
    return hash
  end
end
