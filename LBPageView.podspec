
Pod::Spec.new do |s|
  s.name             = 'LBPageView'
  s.version          = '1.1.0'
  s.summary          = 'slide view'



  s.description      = <<-DESC
                        TODO: slide view like 百思不得其姐 home
                       DESC

  s.homepage         = 'https://github.com/LeonLeeboy/LBPageView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'j1103765636@iCloud.com' => '1103765636@qq.com' }
  s.source           = { :git => 'https://github.com/LeonLeeboy/LBPageView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'LBPageView/Classes/**/*'
   s.frameworks = 'UIKit', 'Foundation'
end
