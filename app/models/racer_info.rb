class RacerInfo
  include Mongoid::Document
  field :racer_id, as: :_id
  field :_id, default: -> { racer_id }
  field :fn, as: :first_name, type: String
  field :ln, as: :last_name,  type: String
  field :g, as: :gender, type: String
  field :yr, as: :birth_year, type: Integer
  field :res, as: :residence, type: Address
  embedded_in :parent, polymorphic: true
  validates_presence_of :first_name, :last_name, :birth_year, :gender
  validates_inclusion_of :gender, in: %w[M F], message: 'must be M or F'
  validates_numericality_of :birth_year, less_than: Date.today.year,\
                                         message: 'must in past'
  %w[city state].each do |action|
    define_method(action.to_s) do
      residence ? residence.send(action.to_s) : nil
    end
    define_method("#{action}=") do |name|
      object = self.residence ||= Address.new
      object.send("#{action}=", name)
      self.residence = object
    end
  end
end
