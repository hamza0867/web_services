class Event
  include Mongoid::Document
  field :o, as: :order, type: Integer
  field :n, as: :name, type: String
  field :d, as: :distance, type: Float
  field :u, as: :units, type: String
  embedded_in :parent, polymorphic: true, touch: true
  validates_presence_of :order, :name

  def meters
    case units
    when 'meters' then distance
    when 'kilometers' then distance * 1000
    when 'yards' then distance * 0.9144
    when 'miles' then distance * 1609.344
    end
  end

  def miles
    case units
    when 'meters' then distance * 0.000621371
    when 'kilometers' then distance * 0.621371
    when 'yards' then distance * 0.000568182
    when 'miles' then distance
    end
  end
end
