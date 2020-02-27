When /^I follow tabs on page$/ do
  @page_tab = TabVerificationPage .new(@driver)
  @driver.find_element(link: "Amazing Services").click
  @driver.find_element(link: "Testimonials").click

end

Then /^I verify tabs is on page$/ do
  @page_tab = TabVerificationPage .new(@driver)
  @driver.find_element(link: "Amazing Services").text.include?('Amazing Services').should == true
  @driver.find_element(link: "Testimonials").text.include?('Testimonials').should == true

end

And /^I follow link on page$/ do
  @page_tab = TabVerificationPage .new(@driver)
  @driver.find_element(link: "Chef Certification Workshop").click
end
Then /^I verify link open in page$/ do
  @driver.find_element(xpath: "//h1").text.include?('Get Chef certified to become a DevOps expert').should == true
end