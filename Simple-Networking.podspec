Pod::Spec.new do |s|
    s.name             = 'Simple-Networking'
    s.version          = '0.3.2'
    s.summary          = 'A Simple and light way to perform a all your Network operations.'
    s.description      = 'We love the KISS principle, everything in Software should be simple and solid, this is how to apply this principle in your networking operations.'
    s.homepage         = 'https://github.com/mejiagarcia/simple-networking'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.swift_version    = '5'
    s.author           = { 'Carlos Mejía' => 'carlosmejia083@gmail.com' }
    s.source           = { :git => 'https://github.com/mejiagarcia/simple-networking.git', :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/lcmejiaga'
    s.ios.deployment_target = '9.0'
    s.source_files = 'SimpleNetworking/SimpleNetworking/Source/**/*'
  end
  