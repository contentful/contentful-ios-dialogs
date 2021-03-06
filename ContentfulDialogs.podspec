#!/usr/bin/ruby

Pod::Spec.new do |s|
  s.name             = "ContentfulDialogs"
  s.version          = "2.0.0"
  s.summary          = 'Informational dialogs for iOS applications, like "About Us", licensing information and a quick overview of the product.'
  s.homepage         = "https://github.com/contentful/contentful-ios-dialogs"
  s.license          = 'MIT'
  s.author           = { "Boris Bügling" => "boris@contentful.com" }
  s.source           = { :git => "https://github.com/contentful/contentful-ios-dialogs.git",
                         :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/contentful'
  s.swift_version = '4.1'


  s.platform = :ios, '10.0'

  s.requires_arc = true

  s.resources       = 'Pod/Assets/*.png'
  s.source_files    = 'Pod/Classes/*.swift'

  s.frameworks = 'UIKit', 'SafariServices'
  
  s.dependency 'markymark'
end
