# DecodeFailable

[![CI Status](https://img.shields.io/travis/George Marmaridis/DecodeFailable.svg?style=flat)](https://travis-ci.org/George Marmaridis/DecodeFailable)
[![Version](https://img.shields.io/cocoapods/v/DecodeFailable.svg?style=flat)](https://cocoapods.org/pods/DecodeFailable)
[![License](https://img.shields.io/cocoapods/l/DecodeFailable.svg?style=flat)](https://cocoapods.org/pods/DecodeFailable)
[![Platform](https://img.shields.io/cocoapods/p/DecodeFailable.svg?style=flat)](https://cocoapods.org/pods/DecodeFailable)

DecodeFailable provides a custom `Decodable` collection that decoding for individual elements can fail silently for.
Thus, malformed or unknown elements in a JSON array won't result in a failure of the entire decoding.

It also makes it easy to log or add custom handling of decoding errors for those elements.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 8.0+
- Swift 4.2+

## Installation

### CocoaPods

DecodeFailable is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DecodeFailable'
```

### Manually

If you prefer not to use CocoaPods, you can integrate DecodeFailable into your project manually.

## Usage

Using DecodeFailable is very simple. All you need to implement is ` init(from decoder: Decoder)` and use `DecodeFailableArray` for your array decoding.

```swift
import DecodeFailable

struct GetPeopleResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case people
    }
    let people: [Person]

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.people = try container.decode(DecodeFailableArray<Person>.self, forKey: .people).elements
    }
}

struct Person: Codable {
    let id: String
    let firstName: String
    let lastName: String
}
```

## Author

George Marmaridis

- https://github.com/gmarm
- https://twitter.com/gmarmas
- https://www.linkedin.com/in/gmarm
- gmarmas@gmail.com

## License

DecodeFailable is available under the MIT license. See the LICENSE file for more info.
