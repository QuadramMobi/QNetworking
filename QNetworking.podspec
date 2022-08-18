Pod::Spec.new do |s|
  s.name             = 'QNetworking'
  s.version          = '1.1.9'
  s.license          = 'MIT'
  s.summary          = 'Quadram QNetworking Utils'
  s.homepage         = 'https://www.quadram.mobi'
  s.authors          = { 'Quadram iOS Team' => 'info@quadram.mobi' }
  s.source           = { :git => 'https://github.com/QuadramMobi/QNetworking.git', :tag => "#{s.version}" }

  s.ios.deployment_target     = '11.0'
  s.swift_versions = ['4.0', '4.1', '4.2', '4.3', '4.4', '5.0', '5.1', '5.2', '5.3', '5.4', '5.5', '5.6' ]
  s.ios.framework = 'Foundation'

  s.source_files = 'Sources/*.swift'
  
end
