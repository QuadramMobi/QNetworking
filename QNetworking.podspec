Pod::Spec.new do |s|
  s.name             = 'QNetworking'
  s.version          = '1.1.1'
  s.license          = 'MIT'
  s.summary          = 'Quadram QNetworking Utils'
  s.homepage         = 'https://www.quadram.mobi'
  s.authors          = { 'Quadram iOS Team' => 'info@quadram.mobi' }
  s.source           = { :git => 'https://github.com/QuadramMobi/QNetworking.git', :tag => s.version }

  s.ios.deployment_target     = '9.0'
  s.ios.framework = 'Foundation'

  s.source_files = 'Sources/**/*.swift'
  
  s.dependency 'PromiseKit', '~> 6.8'
end
