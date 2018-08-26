Pod::Spec.new do |s|
  s.name = 'SDFrameWork'
  s.version = '1.0.4'
  s.swift_version = '4.0'
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.summary = 'Easy for create layout without storyboard.'
  s.homepage = 'https://github.com/SaeedDehshiri/SDFrameWork'
  # s.social_media_url = ''
  s.authors = { 'Saeed Dehshiri' => '1995sd@gmail.com' }
  s.source = { :git => 'https://github.com/SaeedDehshiri/SDFrameWork.git', :tag => s.version }
  # s.documentation_url = 'https://alamofire.github.io/Alamofire/'
  s.ios.deployment_target = '9.0'
  s.source_files = 'SDFrameWork/*.swift'
  s.dependency "Reflection"
end
