Pod::Spec.new do |s|
  s.name             = 'QNetworking'
  s.version          = '1.0.4'
  s.license          = 'MIT'
  s.summary          = 'Quadram QNetworking Utils'
  s.homepage         = 'https://www.quadram.mobi'
  s.authors          = { 'Quadram iOS Team' => 'info@quadram.mobi' }
  s.source           = { :git => 'https://bitbucket.org/qios/qnetworking.git', :tag => s.version }

  s.ios.deployment_target     = '9.0'
  s.ios.framework = 'Foundation'

  s.source_files = 'Sources/**/*.swift'
end