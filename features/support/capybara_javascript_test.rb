Capybara.class_eval do

  def self.javascript_test?
    [:selenium, :webkit, :chrome, :poltergeist].include?(Capybara.current_driver)
  end

end
