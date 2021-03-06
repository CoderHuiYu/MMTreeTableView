Pod::Spec.new do |s|
  s.name         = 'MMTreeTableView'
  s.version      = '1.1.0'
  s.summary      = 'An excellent treeTableview'
  s.homepage     = 'https://github.com/CoderHuiYu/MMTreeTableView'
  s.license      = 'MIT'
  s.author       = { 'Jeffery Yu' => '171364980@qq.com' }
  s.platform     = :ios, '11.0'
  s.source       = { :git => 'https://github.com/CoderHuiYu/MMTreeTableView.git', :tag => s.version }
  s.source_files  = 'MMTreeTableView/*.swift'
  s.swift_versions = '5.0'
end