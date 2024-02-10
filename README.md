# PassKit

Generate PassKit passes without external dependencies like openssl

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/hiimtmac/pass-kit.git", .branch("main"))
],
```

> [!Warning]
> This is a pre-release and is subject to change

## Usage

```swift
import PassCore
import PassGen

let pass: Pass = ...
let cert: Data = ...
let key: Data = ...

let generator = try PassGenerator()

// add pass
try generator.add(pass: pass)

// add image
try generator.add(image: Data(...), as: .icon(.x2))
// add localized image
try generator.add(image: Data(...), as: .icon(.x2), localization: "en")
// add strings
try generator.add(strings: Data(...), localization: "en")
// generate manifest
let manifest = try generator.manifestData()
try generator.add(manifest: manifest)
// generate signature
let signature = try generator.signatureData(manifest: manifest, cert: cert, key: key)
try generator.add(signature: signature)
// get zip data
let archive = try generator.archiveData()
// save as Something.pkpass and distribute
```

## More

- [Ray Wenderlich](https://www.raywenderlich.com/2855-beginning-passbook-in-ios-6-part-1-2)
- [Apple PassKit](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/)
