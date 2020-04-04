module WaitForAjax
    extend Capybara::DSL

    def self.wait_for_ajax
      Timeout.timeout(Capybara.default_max_wait_time) do
        active = page.evaluate_script('jQuery.active')
        break if active == 0
      end
    end
  
    # def finished_all_ajax_requests?
    #   page.evaluate_script('jQuery.active').zero?
    # end
  end