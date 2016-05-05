Given(/^User page is opened$/) do
  page = GmailInfoPage.new(@driver)
  page.open_url
end

Then(/^I should see the specified text$/) do
  page = GmailInfoPage.new(@driver)
  #sleep(20)
  page.verify_text_presence
end


Then(/^I should navigate to each link on the page and take screenshot$/) do
  page = GmailInfoPage.new(@driver)
  #sleep(20)
  links = page.get_all_links_on_page(ENV['TEST_URL'])

  links.each { |link|

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

Then(/^Navigate and take screenshot of "([^"]*)"/) do |link|
  link = link.strip
  if link.match(/^http/)
  # if link =~ /^http/
    @driver.get(link)
  else
    @driver.get(ENV['TEST_URL']+"/"+link)
  end

  sleep 3
end

