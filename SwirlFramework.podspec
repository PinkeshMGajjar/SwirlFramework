Pod::Spec.new do |spec|

  spec.name         = "SwirlFramework"
  spec.version      = "1.0.0"
  spec.summary      = "This short description of SwirlFramework."
  spec.description  = "This is Framework"

  spec.homepage     = "https://github.com/PinkeshMGajjar/SwirlFramework"
  spec.license      = "MIT"
  
  spec.author             = { "Pinkesh Gajjar" => "pinkeshmgajjar@gmail.com" }
  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/PinkeshMGajjar/SwirlFramework.git", :tag => spec.version.to_s }

  spec.source_files  = "SwirlFramework/**/*.{swift}"
  spec.frameworks = "UIKit", "AVKit", "AVFoundation"

  spec.requires_arc = true
  spec.static_framework = true
  spec.dependency   "SwiftyJSON", "~> 4.0"
  spec.dependency   "ObjectMapper", "~> 3.4"
  spec.dependency   "IQKeyboardManagerSwift"
  spec.dependency   "SDWebImage", "~> 5.0"
  spec.swift_version = "5.0"
  
  # spec.dependency "JSONKit", "~> 1.4"

end
