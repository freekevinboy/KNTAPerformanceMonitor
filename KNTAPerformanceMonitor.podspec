Pod::Spec.new do |s|

  s.name         = "KNTAPerformanceMonitor"
  s.version      = "1.0"
  s.summary      = "performance monitor"

  s.homepage     = "https://github.com/FreedomKevin/performance.git"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.author             = "Kevin"

  s.platform     = :ios

  s.source       = { :git => "https://github.com/FreedomKevin/performance/releases", :tag => s.version }

  s.source_files  = "performanceMonitor/*.{h,m}"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
