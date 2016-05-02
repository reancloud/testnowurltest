module URLTest

  # Firefox browser
  def launch_driver_firefox
    #puts "Launching driver for firefox.........................."
  ENV['IS_UPA'] = "false" if ENV['IS_UPA'].nil?  
  if ENV['IS_UPA']=="true"  
    profile = Selenium::WebDriver::Firefox::Profile.new
    profile.add_extension("./harexport/firebug-2.0.13.xpi")
    profile.add_extension("./harexport/netExport-0.8.xpi")
    profile['extensions.firebug.allPagesActivation'] = "on"
    profile['extensions.firebug.defaultPanelName'] = "net"
    profile['extensions.firebug.net.enableSites'] = "true"
    profile['extensions.firebug.showFirstRunPage'] = "false"
    profile['extensions.firebug.netexport.alwaysEnableAutoExport'] = "true"
    profile['extensions.firebug.netexport.showPreview'] = "false"
    profile['extensions.firebug.netexport.defaultLogDir'] = File.absolute_path("./report/upa")
    profile['extensions.firebug.netexport.defaultFileName'] = "upaReport.har"
    profile['extensions.firebug.netexport.jsonpCallback'] = "jsonCallback";
    @driver = Selenium::WebDriver.for :firefox, :profile => profile
  else
   @driver = Selenium::WebDriver.for :firefox
  end
  @driver.manage.timeouts.implicit_wait = 30
  #@driver.manage.timeouts.page_load = 120
  @driver.manage.window.maximize
  end
  
  def launch_driver_safari
    #puts "Launching driver for firefox.........................."
    @driver = Selenium::WebDriver.for :safari
    @driver.manage.timeouts.implicit_wait = 60
    @driver.manage.window.maximize
  end

  # Chrome browser
  def launch_driver_chrome
    #puts "Launching driver for chrome.........................."
    @driver = Selenium::WebDriver.for :chrome
    @driver.manage.timeouts.implicit_wait = 60
    @driver.manage.window.maximize
  end

  def launch_driver_device
    #puts "Launching driver for chrome.........................."
    # @driver = Selenium::WebDriver.for :chrome
    # @driver.manage.timeouts.implicit_wait = 60
    # @driver.manage.window.maximize

    mobile_emulation = { "deviceName" => ENV['DEVICE'] }
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(
        "chromeOptions" => { "mobileEmulation" => mobile_emulation })
    @driver = Selenium::WebDriver.for :remote, url: 'http://localhost:4444/wd/hub', desired_capabilities: caps
  end

  def launch_driver_opera
    service = Selenium::WebDriver::Chrome::Service.new("/usr/bin/operadriver",48923)
    service.start
    sleep(10)
    begin
      @driver = Selenium::WebDriver.for :remote,:url => service.uri,  :desired_capabilities => Selenium::WebDriver::Remote::Capabilities.opera('opera.binary' => "/usr/bin/opera",'operaOptions'=> {'binary' => '/usr/bin/opera'} )
      @driver.manage.timeouts.implicit_wait = 60
      @driver.manage.window.maximize
    rescue
      @driver = Selenium::WebDriver.for :remote,:url => service.uri,  :desired_capabilities => Selenium::WebDriver::Remote::Capabilities.opera('opera.binary' => "/usr/bin/opera",'operaOptions'=> {'binary' => '/usr/bin/opera'} )
      @driver.manage.timeouts.implicit_wait = 60
      @driver.manage.window.maximize
    end
   
  end

  def launch_driver_ie
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 120
    caps = Selenium::WebDriver::Remote::Capabilities.ie(:javascript_enabled => true, :native_events => false)
    @driver = Selenium::WebDriver.for(:remote, :http_client => client, :url => "http://localhost:5555", :desired_capabilities => caps)
    @driver.manage.timeouts.implicit_wait = 60
    #@driver.manage.window.maximize
    target_size = Selenium::WebDriver::Dimension.new(1366, 768)
    @driver.manage.window.size = target_size
  end

  def launch_driver_android
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 9999
    @driver = Selenium::WebDriver.for(:remote, :http_client => client, :desired_capabilities => :android)
  end

  def launch_driver_android_chrome
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 120
    caps = {'chromeOptions'=> {'androidPackage' => 'com.android.chrome'}}
    @driver = Selenium::WebDriver.for(:remote, :http_client => client, :url => "http://localhost:9515", :desired_capabilities => caps)
    @driver.manage.timeouts.implicit_wait = 60

  end

  def driver
    @driver
  end

  def quit_driver
    driver.quit
  end

end
