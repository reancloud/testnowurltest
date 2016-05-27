Given(/^User page is opened$/) do
  page = GmailInfoPage.new(@driver)
  page.open_url
end

Then(/^I should see the specified text$/) do
  page = GmailInfoPage.new(@driver)
  #sleep(20)
  page.verify_text_presence
end


And(/^I should navigate to each link on the page and take screenshot$/) do
  page = GmailInfoPage.new(@driver)
  #sleep(20)
  links = page.get_all_links_on_page(ENV['TEST_URL'])

  links.each  { |link|

    step ("Navigate and take screenshot of \"#{link.href}\"")


    # if link.href.match(/^http/)
    #   @driver.get(link.href)
    # else
    #   @driver.get("http://facebook.com/"+link.href)
    # end
    encoded_label = @driver.screenshot_as(:base64)
    # @out = StringIO.new
    # HtmlFormatter.new(runtime, @out, {}).embedembed("#{encoded_label}", "image/png;base64",link.text)
    embed("#{encoded_label}", "image/png;base64","          #{link.text}")

  }

end

And(/^Navigate and take screenshot of "([^"]*)"/) do |link|
  page = GmailInfoPage.new(@driver)
  link = link.strip
  if link.match(/^http/)
  # if link =~ /^http/
    @driver.get(link)
    code = page.verify_response_code(link)
    embed(link,"step/html",code)
    data = "The Link: #{link} and the Return Code is :#{code}"
    embed data, "mime-type;base64"
  else
    @driver.get(ENV['TEST_URL']+"/"+link)
    code = page.verify_response_code(ENV['TEST_URL']+"/"+link)
    actual_link=ENV['TEST_URL']+"/"+link
    embed(actual_link,"step/html",code)

    data = "The Link: #{actual_link} and the Return Code is :#{code}"
    embed data, "mime-type;base64"
  end


  sleep 3
end

