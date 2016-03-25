Given(/^User page is opened$/) do
  page = GmailInfoPage.new(@driver)
  page.open_url
end

Then(/^I should see the specified text$/) do
  page = GmailInfoPage.new(@driver)
  #sleep(20)
  page.verify_text_presence
end

