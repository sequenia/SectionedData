#
#  Be sure to run `pod spec lint SQUtils.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
    s.platform = :ios
    s.ios.deployment_target = '9.0'
    s.name = "SectionedData"
    s.summary = "Base data to implementig as UITableCell/UICollectionView\'s data."
    s.requires_arc = true

    s.version = "0.1.6"

    s.license = { :type => "MIT", :file => "LICENSE" }

    s.author = { "Tabriz Dzhavadov" => "keeganrush@gmail.com" }

    s.homepage = "https://github.com/wolferineaz/SectionedData"

    s.source = { :git => "https://github.com/wolferineaz/SectionedData.git",
                 :tag => "#{s.version}" }

    s.framework = "UIKit"
    s.dependency 'DifferenceKit', '~> 1.1.3'

    s.source_files = "Sources/**/*.{swift}"

    s.swift_version = "4.2"

end
