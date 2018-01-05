Pod::Spec.new do |spec|
spec.name         = "KSVSShortVideoKit"
spec.summary      = "金山云iOS平台短视频解决方案"
spec.version      = "1.1.0"
spec.license      = "Copyright 2016 kingsoft Ltd. All rights reserved"
spec.source       = { :git => "https://github.com/ksvc/KSVSShortVideoKit_iOS.git", :tag => "v1.1.0"}
spec.resource     = 'KSVSResource.bundle'
spec.homepage     = "https://github.com/ksvc/KSVSShortVideoKit_iOS"
spec.author       = { "ksyun" => "ksyun.com"  }
spec.platform     = :ios, '8.0'

spec.vendored_frameworks = "KSVSDemo/KSVSSdk.framework"

spec.dependency 'KSYMediaEditorKit'

spec.dependency 'Bugly'
spec.dependency 'Masonry'
spec.dependency 'MBProgressHUD'
spec.dependency 'YYKit'
spec.dependency 'AFNetworking'
spec.dependency 'VTMagic'
spec.dependency 'FMDB'
spec.dependency 'ICGVideoTrimmer'
spec.dependency 'UITextView+Placeholder'
spec.dependency 'MJRefresh'
spec.dependency 'Toast'
end
