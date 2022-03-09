Pod::Spec.new do |s|
   s.platform = :ios
   s.ios.deployment_target = '11.0'
   s.name = "YZCoordinatorFlow"
   s.summary = "YZCoordinatorFlow this is simple bar line to show progress"
   s.requires_arc = true

   s.version = "1.1.0"

   s.author = { "Yaroslav Zavyalov" => "yaroslavzavyalov1@gmail.com" }

   s.homepage = "https://github.com/YarZav/YZCoordinatorFlow"

   s.source = { :git => "https://github.com/YarZav/YZCoordinatorFlow.git", :tag => "#{s.version}"}

   s.framework = "UIKit"

   s.source_files = "YZCoordinatorFlow/**/*.{swift}"
end