Pod::Spec.new do |s|
  s.name         = "FXViewContext"
  s.version      = "1.0.0"
  s.summary      = "FX视图展示框架"

  s.homepage     = "https://github.com/zqw87699/FXViewContext"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = {"zhangdazong" => "929013100@qq.com"}

  s.source       = { :git => "https://github.com/zqw87699/FXViewContext.git", :tag => "#{s.version}"}

  s.platform     = :ios, "7.0"

  s.frameworks = "Foundation", "UIKit"

  s.module_name = 'FXViewContext' 

  s.requires_arc = true

  s.source_files = 'Classes/*'
  s.public_header_files = 'Classes/*.h'

  s.dependency 'FXCommon/Core'
  s.dependency 'Masonry', '1.0.2'
  s.dependency 'ReactiveObjC', '2.1.2'

end
