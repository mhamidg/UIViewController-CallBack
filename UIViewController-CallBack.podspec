Pod::Spec.new do |s|

  s.name         = "UIViewController-CallBack"
  s.version      = "1.1"
  s.summary      = "Add view unload callback lifecycle methods"
  s.description  = "Call back methods, which will trigger on same UIViewController close along with send result object to the parent view controller automatically."
  s.homepage     = "https://github.com/mhamidg/UIViewController-CallBack"
  s.license      = { :type => "MIT", :text => 'UIViewController-CallBack is licensed.'}
  s.author       = { "hamid" => "mhamidg@gmail.com" }
  s.source       = { :git => "https://github.com/mhamidg/UIViewController-CallBack.git", :tag => "1.1" }
  s.source_files = "UIViewController+CallBack.{h,m}"
  s.platform     = :ios

end
