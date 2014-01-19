LoginViewController
===================

Many mobile applications provide synchronization services, access to sensitive data, or the like. Once an app is launched for the first time, a user is typically prompted to input username & password information into a login view of some sort.

Unfortunately, however, there are few *standard* ways to programmatically create a login interface in iOS. Apple provides little explicit guidance, but there are some examples that warrant consideration.

Programmatically, `UIAlertView` introduced an `alertViewStyle` property in iOS 5, with options including `UIAlertViewStyleLoginAndPasswordInput` and `UIAlertViewStyleSecureTextInput`. Unfortunately, however, the alert implies transience (e.g,. can I dismiss and ignore this?), where in many cases it is more appropriate to present a fullscreen modal view.

In iOS, *Settings.app* appears to use a grouped `UITableView` to separately collect username & password information (e.g., Twitter, Facebook). Apple's iTunes Connect Mobile app employs a similar technique. This approach has garnered some attention on Stack Overflow, but many proposed solutions are overly complex. Most either add a `UITextField` directly to the content view of a custom table view cell or construct static prototype cells in a storyboard.

This example project suggests a more straightforward approach. It fashions a grouped `UITableView` with two rows. The text fields used for input are added as *accessory views* to each individual cell. The end result is fairly satisfying, and provides a reasonable approximation of the look & feel found in *Settings.app*.

**DISCLAIMER**

While you are welcome to use this code, please be advised that this is simply an example project created for a pedagogical purpose. No warranties expressed or implied. Some assembly required. Batteries not included. Your mileage may vary.
