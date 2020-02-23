<div align="center">
<img src="/screenshots/shib-repaint.png" title="logo" width="512">
</div>

# UniversalShibLogin

A Shibboleth login add-on.

**Please Note**

- This controller only tells if a user is a Duke affiliate by letting them go through Shibboleth authentication. It is not a session based authentication, and does not enforce the back-end API to be under the protection of Shib.

- This controller relies on some Duke services, and does not allow frequently logging in due to Duke Central Shib server session count limit for a single person.

## Usage

<div>
    <img style="float: right" align="right" src="/screenshots/installation.jpg" title="installation" width="320">
</div>

If you just want to know the login succeeded or not, follow the instructions in Quick Start section below.

### Installation

Add the framework to your project.

1. download the `shibauthframework2019.framework` file

    You need to first download this repo and unzip. There will be a `shibauthframework2019.framework` file in the folder. Copy or move this file to your project's folder.

2. in your project file, select your **Target**, click on the **General** tab, and under `Framework, Libraries and Embedded Content`, the framework should appear.  Make sure you set it to `Embed & Sign`

3. in the swift file you are using this library, `import shibauthframework2019`

### Quick Start

Where ever you want to authenticate a user, simply add follows:

- In `YourViewController` class

```swift
let alertController = LoginAlert(title: "Authenticate", message: nil, preferredStyle: .alert)
alertController.delegate = self
self.present(alertController, animated: true, completion: nil)
```

- And use delegate methods to get the results.

```swift
extension YourViewController: LoginAlertDelegate {
    
    func onSuccess(_ loginAlertController: LoginAlert, didFinishSucceededWith status: LoginResults, netidLookupResult: NetidLookupResultData?, netidLookupResultRawData: Data?, cookies: [HTTPCookie]?, lastLoginTime: Date) {
        // succeeded, extract netidLookupResult.id and netidLookupResult.password for your server credential
        // other properties needed for homework are also in netidLookupResult
    }
    
    func onFail(_ loginAlertController: LoginAlert, didFinishFailedWith reason: LoginResults) {
        // when authentication fails, this method will be called.
        // default implementation provided
    }
    
    func inProgress(_ loginAlertController: LoginAlert, didSubmittedWith status: LoginResults) {
        // this method will get called for each step in progress.
        // default implementation provided
    }
    
    func onLoginButtonTapped(_ loginAlertController: LoginAlert) {
    	// the login button on the alert is tapped
    	// default implementation provided
    }

    func onCancelButtonTapped(_ loginAlertController: LoginAlert) {
    	// the cancel button on the alert is tapped
    	// default implementation provided
    }
}
```

### Result formats

- LoginResults

```swift
public enum LoginResults: Error, CustomStringConvertible {
    case ShibURLNotAccessible
    case MultiFactorRequired
    case UsernamePasswordEmpty
    case UsernamePasswordWrong
    case LoginSucceeded
    case UsernamePasswordSubmitted
    case IllegalNavigation
    case UnknownNavigation
}
```

- NetidLookupResultData

```swift
public struct NetidLookupResultData: Codable, CustomStringConvertible {
    /// The email address of the authenticated user
    public var email: String?
    /// The ID of the authenticated user, the same value of netid
    public var id: String?
    /// The NetID of the authenticated user, also serve as the username for the communication with ECE564 server
    public var netid: String?
    /// The first name of the authenticated user
    public var firstName: String?
    /// The last name of the authenticated user
    public var lastName: String?
    /// The affiliation of this netid, e.g. student, faculty, etc.
    public var role: String?
    /// The password for the communication with ECE564 server
    public var password: String?
    /// Debug description
    public var description: String
}
```

## Update history

- 190923

released the first version. it is a headless framework which is later required to be changed.

- 191003

update to add a simple login box to facilitate usage

- 191014

update to the latest Xcode and compiler version

---

```
Revised 191014
Duke Center for Mobile Development
```
