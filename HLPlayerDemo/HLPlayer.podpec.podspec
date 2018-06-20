Pod::Spec.new do |s|
s.name         = 'HLPlayer'
s.version      = '1.0.0'
s.summary      = '视频播放'
s.homepage     = 'https://github.com/songhailong/HLPlayer.git'
s.license      = 'MIT'
s.authors      = {'songhailong' => '997496837@qq.com'}
s.platform     = :ios, '8.0'
s.source       = {:git => 'https://github.com/songhailong/HLPlayer.git', :tag => s.version}
s.source_files = 'HLPlayer/**/*'
s.requires_arc = true
end


