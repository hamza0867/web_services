class BikeResult < LegResult
  field :mph, type: Float

  def calc_ave
    if event && secs
      meters = event.meters
      self.mph = meters.nil? ? nil : 12.1
    end
  end
end
