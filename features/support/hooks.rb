puts "Selected browser is #{ENV['BROWSER']}"

Before do |scenario|
  @scenario_name=scenario.name
  @step=0
#  if ENV['HEADLESS'] == 'true'
#    @headless = Headless.new
#    @headless.start
#  end

  if ENV['BROWSER'] == 'Chrome'
    launch_driver_chrome
  elsif ENV['BROWSER'] == 'Android'
    launch_driver_android
 elsif ENV['BROWSER'] == 'AndroidChrome' 
    launch_driver_android_chrome
  elsif ENV['BROWSER'] == 'Opera'
    launch_driver_opera
  elsif ENV['BROWSER'] == 'IE'
    launch_driver_ie
  elsif ENV['BROWSER'] == 'Safari'
    launch_driver_safari 
  else
    launch_driver_firefox
  end

end

After do |scenario|

#unsorted_har_list=Dir['report/*.har']
 # sorted_har_list=unsorted_har_list.sort_by!{ |m| m.downcase }
 # sorted_har_list.each_with_index do |har,i|
 #   new_name = "#{scenario.name.squeeze.gsub(" ","_")}_#{i+1}"
  #  File.rename(har,"report/#{new_name}.har")
  #  `simplehar report/#{new_name}.har report/#{new_name}.html`
  #  embed("#{new_name}.html","text/html","UPA")	
 # end

  if scenario.failed?
    begin
      encoded_img = driver.screenshot_as(:base64)
      embed("#{encoded_img}", "image/png;base64")
    rescue
      p "*** Could not take failed scenario screenshot ***"
    end
  end
  quit_driver
  #@headless.destroy
end

AfterStep do
 unsorted_har_list=Dir['report/upa/*.har']
  sorted_har_list=unsorted_har_list.sort_by!{ |m| m.downcase }
  sorted_har_list.each do |har|
    new_name = "#{@scenario_name.squeeze.gsub(" ","_")}_#{@step+=1}"
    File.rename(har,"report/upa/#{new_name}.har")
    `simplehar report/upa/#{new_name}.har report/upa/#{new_name}.html`
    #report_file = File.absolute_path("#{new_name}.html","report/upa")
    #doc = File.read(report_file)
 #   new_doc = doc.gsub("simpleharSrc", "https://rafacesar.github.io/simplehar/src")
 #   new_docc = new_doc.gsub("http:", "https:")
  #  File.open(report_file, "w") {|file| file.puts new_docc }
    report_file = File.absolute_path("#{new_name}.html","report/upa")
    doc = File.read(report_file)
    new_doc = doc.gsub("SimpleHar", "UPA Report")
    File.open(report_file, "w") {|file| file.puts new_doc }
  
    embed("upa/#{new_name}.html","text/html","UPA")
  end
  begin
    encoded_img = driver.screenshot_as(:base64)
    embed("#{encoded_img}", "image/png;base64")
  rescue
    p "*** Could Not take screenshot ***"
  end
end

at_exit do
  ENV['TITLE'] = "URLTest : Search #{ENV['TEXT_TO_SEARCH']} in  #{ENV['TEST_URL']}"
  ENV['HEADING'] = "TestNow URL Test Report"
  report_file = File.absolute_path("features_report.html","report")
  doc = File.read(report_file)
  new_doc = doc.sub("Cucumber Features", "#{ENV['TITLE']}")
  new_docc = new_doc.sub("<title>Cucumber</title>", "<title>#{ENV['HEADING']}</title>")
  File.open(report_file, "w") {|file| file.puts new_docc }
end
