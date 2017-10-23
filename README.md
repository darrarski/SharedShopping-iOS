# SharedShopping-iOS

![Swift v4.0](https://img.shields.io/badge/swift-v4.0-orange.svg)

## Setup

Requirements: 

- Ruby with [Bundler](http://bundler.io)
- Xcode 9

To bootstrap the project run:

```sh
bundle install
bundle exec fastlane setup
```

## Develop

Open `SharedShopping.xcworkspace` in Xcode.

Use `SharedShopingApp` build scheme for building and runing the app.

## Test

Use `SharedShopingAppTests` build scheme for runing tests.

To run tests from command line execute:

```sh
bundle exec fastlane test
```

To generate and open code coverage report run:

```sh
bundle exec fastlane codecov
open xcov_output/index.html
```

## Deploy

To bump build version execute:

```sh
bundle exec fastlane bump
```

To setup code signing (certificates and provisioning profiles) run:

```sh
bundle exec fastlane codesigning
```

To build and deploy app to iTunes Connect run:

```sh
bundle exec fastlane deploy
```

## License

Copyright © 2017 Dariusz Rybicki Darrarski

[MIT License](LICENSE). You are allowed to use the source code commercially, but licence and copyright notice MUST be distributed along with it.
