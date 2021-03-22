# PassKit

PassKit Models

## Installation

> **Warning**: This package relies on OpenSSL being installed on usage machine. OpenSSL is needed for signature generation of manifest.

```swift
dependencies: [
    .package(url: "https://github.com/hiimtmac/pass-kit.git", .branch("main"))
],
```

> **Warning**: This is a pre-release and is subject to change

## Setup

### Download WWDR

- Download WWDR certificate from [apple](https://www.apple.com/certificateauthority/).
- This will be downloaded as `AppleWWDRCA.cer`.
- Double click to open it and add to Keychain Access 
- Find it in Keychain Access, right click on it, and choose the "Export" option
- Save it as a `.pem` file and keep note of this location

> Make sure to use the one expiring in 2023 and not the one expiring in 2030 (the 2030 one did not work for me)

### Create Identifier

In the developer portal under "Certificates, Identifiers & Profiles":
- Choose "Identifiers" from the left side menu
- Change the type to "Pass Type IDs"
- Create a new identifier, name it whatever you want

### Create Certificate

In the developer portal under "Certificates, Identifiers & Profiles":
- Choose "Certificates" from the left side menu
- Create a new certificate, under "Services" choose "Pass Type ID Certificate"
- Name it whatever you want and choose the identifier that you just made
- You will be prompted to create a certificate signing request
  - open Keychain Access, under Keychain Access > Certificate Assistant > Request a Certificate from a Certificate Authority
  - Choose the save to disk option and fill out the fields
  - Download the file and use this to upload to the developer portal
- Download your certificate which will a `.cer` file
- Double click to open it and add to Keychain Access
- Find the certificate and right click on it and choose the "Export" option
  - DO NOT export the name under the dropdown, make sure to export the top level certificate
  - Save it with or without a password as a `.p12` file
  
  ### Run `certgen` and `keygen` commands
  
  Add `CertificateCommand` and `PrivateKeyCommand` as subcommands to your main command. Run both of these commands to generate the `cert.pem` and `key.pem`. Once you have these, you have everything you need along with the `wwdr.pem` to create the signatures needed to sign PassKit manifests.
  
## Running `PassGenerator`

1. Initialize a `PassGenerator`
  - You can specify a folder to generate the pass in or it can use the temp directory if no folder is declared
2. Copy items like images into the folder with `copy(itemAt:as:)`
3. Add and serialize the `Pass` object to `pass.json` using `preparePass(pass:)`
4. Generate manifest of the files in the folder using `generateManifest()`
5. Generate signature using `generateSignature(certificate:key:wwdr:password)` using resources created above
6. Zip pass to file (generally with extension `.pkpass`)

Example:

```swift
let resources: URL = ...
let wwdr: URL = ...
let cert: URL = ...
let key: URL = ...
let pass = Pass.init(...)
let output = URL(...).appendingPathComponent("MyPass.pkpass")

let generator = try PassGenerator(folder: directory)
try generator.preparePass(pass: pass)
try generator.copy(itemAt: resources.appendingPathComponent("myicon.png", as: "icon.png")
try generator.copy(itemAt: resources.appendingPathComponent("myicon@2x.png", as: "icon@2x.png")
try generator.copy(itemAt: resources.appendingPathComponent("myicon@3x.png", as: "icon@3x.png")
try generator.generateManifest()
try generator.generateSignature(certificate: cert, key: key, wwdr: wwdr, password: "")
try generator.zipPass(url: output)
```

## More

- [Ray Wenderlich](https://www.raywenderlich.com/2855-beginning-passbook-in-ios-6-part-1-2)
- [Apple PassKit](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/)
