class GmailInfoPage < PageObject

  element :make_payment_button, {css: 'input.btn-orange'}
  element :search_form, {id: 'search-widget-form'}
  element :quick_links, {id: 'quick-links'}

  element :confluence_username, {id: "os_username"}
  element :confluence_password, {id: "os_password"}
  element :confluence_login_button, {id: "loginButton"}
  element :forgot_password, {id: "forgot-password"}
  element :forgot_password_login_button, {xpath: "//p[@class='last']/a"}

  def initialize(page_driver)
    @driver = page_driver
  end

  def open_url()
    begin
	sleep(10)
      driver.get(get_homepage_url)
	sleep(30)
    rescue Exception=>e
      raise ("Wrong page #{e}")
    end
  end

  def get_homepage_url
    ENV['TEST_URL']
  end

  def verify_text_presence
    words = ENV['TEXT_TO_SEARCH'].to_s.split(',')
    wait = Selenium::WebDriver::Wait.new(:timeout => "#{ENV['PAGE_LOAD_TIME_OUT']}".to_i)
    not_found = []
    success = false
    words.each do |word|
      begin
        text = @driver.find_element(:tag_name => "body").text.split("\n")

        text.each do |val|

          result = val =~ /#{word}/i

          if result.nil?
            not_found << word
            puts "Text (#{word}) is not present on page"
          else
            puts "Success! Text (#{word}) is present on page"
            not_found = []
            success = true
            break
          end

          if success
            break
          end
        end
        if success
          break
        end
        
      end
    end

    if not_found.size > 0
      raise("Failure! None of the mentioned words (#{words}) are present on page")
    end
  end

  def get_page_title
    driver.title
  end

  def login_to_confluence(uname,pwd)
    confluence_username.send_keys(uname)
    confluence_password.send_keys(pwd)
    confluence_login_button.click
  end
end

