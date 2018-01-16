class MatchPrediction
  attr_reader :data

  TARGET_METHODS = { match: Match,left_team: Team, right_team: Team, prediction: Prediction}

  def initialize(data = {})
    @data = data
    create_methods_for_data
    create_methods_for_models
  end

  def predicted?
    prediction.predicted?
  end

  def predictable?
    match.kickoff_at > Time.zone.now
  end

  private

  def create_methods_for_data
    data.each do |key, value|
      define_singleton_method(key) { value }
    end
  end

  def create_methods_for_models
    TARGET_METHODS.each do |target_method_name, klass|
      source_method_names = self.singleton_methods.select { |sm| sm.to_s.start_with?(target_method_name.to_s) }
      object = klass.new
      source_method_names.each do |source_method_name|
        target_key_name = source_method_name.to_s.sub(/^#{target_method_name}_/, '')
        object.assign_attributes("#{target_key_name}" => send(source_method_name))
      end
      define_singleton_method(target_method_name) { object }
    end
  end
end
