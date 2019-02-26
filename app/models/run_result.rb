class RunResult < LegResult
  field :mmile, as: :minute_mile, type: Float

  def calc_ave
    if event && secs
      meters = event.meters
      self.minute_mile = meters.nil? ? nil : 12.1
    end
  end
end
