Pod::Spec.new do |s|

s.name         = 'WMCalendar'
s.version      = '0.0.4'
s.summary      = 'An easy way to use WMCalendar'
s.homepage     = 'https://github.com/BabyWong/CalendarDemo'
s.license      = 'MIT'
s.author       = {'Heaven Wong' => 'wenmeiwong@126.com'}
s.platform     = :ios, '8.0'
#s.ios.deployment_target = "8.0"
s.source       = {:git => 'https://github.com/BabyWong/CalendarDemo.git', :tag => s.version}
s.source_files  = 'CalendarView/**/*.{h,m}'
s.requires_arc = true


end
