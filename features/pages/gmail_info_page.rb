require 'mechanize'
require "net/https"
require "uri"

class GmailInfoPage



  # element :make_payment_button, {css: 'input.btn-orange'}
  # element :search_form, {id: 'search-widget-form'}
  # element :quick_links, {id: 'quick-links'}

  # element :confluence_username, {id: "os_username"}
  # element :confluence_password, {id: "os_password"}
  # element :confluence_login_button, {id: "loginButton"}
  # element :forgot_password, {id: "forgot-password"}
  # element :forgot_password_login_button, {xpath: "//p[@class='last']/a"}

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
    words = ENV['TEXT_TO_SEARCH'].to_s.gsub(" ","").split(',')
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


  def verify_response_code(url)

    puts url
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)


    if url.match(/^https/)
      http.use_ssl = true
    end


    request = Net::HTTP::Get.new(uri.request_uri)
    res = http.request(request)

    # res.code #=> "200"
    puts "--->The Return code is #{res.code}"
    if res.code == "4*" || res.code == "5*"
      raise("Failure! Return Response Code (#{res.code})")
    end
    return res.code
  end

  def get_all_links_on_page(url)

    a = Mechanize.new
    a.get(url) do |page|
      links = page.links
      page.links.each { |link|
        puts "#{link.text} => #{link.href}"
      }
      return page.links
    end

  end

  def get_page_title
    driver.title
  end

  def login_to_confluence(uname,pwd)
    @driver.find_element(id: "os_username").send_keys(uname)
    @driver.find_element(id: "os_password").send_keys(pwd)
    @driver.find_element(id: "loginButton").click
  end

  def embed_link(src, label)
    @builder.span(:class => 'embed') do |pre|
      pre << %{<a href="#{src}" target="_blank">"#{label}"</a> }
    end
  end


  def embed_text(src, label)
    @builder.span(:class => 'embed') do |pre|
      pre << %{<a href="#{src}" target="_blank">"#{label}"</a> }
    end
  end

end


