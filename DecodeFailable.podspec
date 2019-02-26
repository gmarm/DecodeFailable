Pod::Spec.new do |s|
  s.name             = 'DecodeFailable'
  s.version          = '1.0'
  s.summary          = 'Allows decoding to fail for individual elements in arrays using Codable'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
DecodeFailable provides a custom `Decodable` collection that decoding for individual elements can fail silently for.
Thus, malformed or unknown elements in a JSON array won't result in a failure of the entire decoding. It also makes it
easy to log or add custom handling of decoding errors for those elements.
                       DESC

  s.homepage         = 'https://github.com/gmarm/DecodeFailable'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'George Marmaridis' => 'gmarmas@gmail.com' }
  s.source           = { :git => 'https://github.com/gmarm/DecodeFailable.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/gmarmas'

  s.ios.deployment_target = '8.0'

  s.source_files = 'DecodeFailable/Classes/**/*'
end
