Pod::Spec.new do |s|
  s.name                      = "Socketkit"
  s.version                   = "1.0.0"
  s.summary                   = "Security & Privacy focused mobile analytics & behavior tracking"
  s.homepage                  = "https://www.github.com/socketkit/socketkit-swift"
  s.license                   = { :type => "MIT", :file => "LICENSE" }
  s.author                    = { "Yagiz Nizipli" => "hello@socketkit.com" }
  s.source                    = { :git => "https://www.github.com/socketkit/socketkit-swift.git", :tag => s.version.to_s }
  s.swift_version             = "5.1"
  s.ios.deployment_target     = "12.1"
  s.tvos.deployment_target    = "12.0"
  s.watchos.deployment_target = "6.0"
  s.osx.deployment_target     = "10.15"
  s.source_files              = "Sources/**/*"
  s.frameworks                = "Foundation"
end
