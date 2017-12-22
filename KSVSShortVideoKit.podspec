Pod::Spec.new do |spec|
   spec.name         = "KSVSShortVideoKit"
   spec.summary      = "金山云iOS平台短视频解决方案"
   spec.version      = "1.0.0"
   spec.license      = "Copyright 2016 kingsoft Ltd. All rights reserved"
   spec.source       = { :git => "https://github.com/ksvc/KSVSShortVideoKit_iOS", :tag => "v1.0.0"}
   spec.homepage     = "https://github.com/"
   spec.author       = { "ksyun" => "ksyun.com"  }
   spec.platform     = :ios, '8.0'

   spec.vendored_frameworks = "framework/KSVSSdk.framework"

   # spec.dependency 'CocoaAsyncSocket' 
   # spec.dependency 'CocoaLumberjack'
end
