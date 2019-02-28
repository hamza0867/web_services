class Race
  include Mongoid::Document
  include Mongoid::Timestamps
  field :n, as: :name, type: String
  field :date, type: Date
  field :loc, as: :location, type: Address
  embeds_many :events, as: :parent, order: [:order.asc]
  has_many :entrants, foreign_key: :"race._id", dependent: :delete, order: [:secs.asc, :bib.asc]
  scope :upcoming, -> { where(:date.gte => Date.current) }
  scope :past, -> { where(:date.lt => Date.current) }
  delegate :city, :city=, to: :location
  delegate :state, :state=, to: :location

  DEFAULT_EVENTS = { 'swim' => { order: 0, name: 'swim', distance: 1.0, units: 'miles' },
                     't1' => { order: 1, name: 't1' },
                     'bike' => { order: 2, name: 'bike', distance: 25.0, units: 'miles' },
                     't2' => { order: 3, name: 't2' },
                     'run' => { order: 4, name: 'run', distance: 10.0, units: 'kilometers' } }.freeze

  DEFAULT_EVENTS.keys.each do |name|
    define_method(name.to_s) do
      event = events.select { |event| name == event.name }.first
      event ||= events.build(DEFAULT_EVENTS[name.to_s])
    end
    %w[order distance units].each do |prop|
      next unless DEFAULT_EVENTS[name.to_s][prop.to_sym]

      define_method("#{name}_#{prop}") do
        event = send(name.to_s).send(prop.to_s)
      end
      define_method("#{name}_#{prop}=") do |value|
        event = send(name.to_s).send("#{prop}=", value)
      end
    end
  end

  def self.default
    Race.new do |race|
      DEFAULT_EVENTS.keys.each { |leg| race.send(leg.to_s) }
    end
  end

  %w[city state].each do |action|
    define_method(action.to_s) do
      location ? location.send(action.to_s) : nil
    end
    define_method("#{action}=") do |name|
      object = self.location ||= Address.new
      object.send("#{action}=", name)
      self.location = object
    end
  end
end
