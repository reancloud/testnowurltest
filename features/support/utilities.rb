module URLTest

  def wait_for_title text , timeout = 10
    wait = Selenium::WebDriver::Wait.new(:timeout => timeout)
    wait.until { driver.title.include? text }
  end

  def select_drop_down_by_text drop_down ,text
    Selenium::WebDriver::Support::Select.new(driver.find_element(:id => drop_down)).select_by :text, text
  end

  def wait_for_element element_hash, timeout = 10
    wait = Selenium::WebDriver::Wait.new(:timeout => timeout) # seconds
    wait.until { driver.find_element element_hash }
  end

end
