

Pod::Spec.new do |s|

  s.name         = "ZEDAsyncOperation"
  s.version      = "0.0.1"
  s.summary      = "一个实现并发的NSOperation抽象类，用于创建和执行异步任务"

  s.homepage     = "https://github.com/lichao1992/ZEDAsyncOperation"
  s.license      = "MIT"
  s.author             = { "李超" => "964139523@qq.com" }

  s.source       = { :git => "https://github.com/lichao1992/ZEDAsyncOperation.git", :tag => s.version }
  s.source_files  = "Classes/**/*.{h,m}"
  s.requires_arc = true
  s.platform     = :ios, '9.0'
  s.ios.deployment_target = '9.0'


end
