LoginViewController
===================

The nature of mobile is such that you are frequently connecting to remote services, which may provide a benefit like customized data, synchronization, or the like. These service often require credentials to access, often gathered with a login view of some sort.

Unfortunately, however, there are few _standard_ ways to programmatically create a login interface in iOS. In iOS 5, UIAlertView introduced an _alertViewStyle_ property, with a few options including UIAlertViewStyleSecureTextInput & UIAlertViewStyleLoginAndPasswordInput, but the modal appearance of alert views is often wanting.

Apple's iTunes Connect app uses what appears to be a grouped UITableView to collect a user's username & password. The iOS Settings app also employs this technique in several places (e.g., Mail, Twitter, Facebook). This approach has garnered some attention on Stack Overflow, but many of proposed solutions seem far too complicated - _convoluted_ even. Many attempt to add UITextFields to the content view of custom table view cells, or create prototype cells in a Storyboard.

This approach simply fashions a grouped UITableView with two rows. The text fields used for input are added as _accessory views_ to each individual cell. The end result is fairly satisfying.

__DISCLAIMER__

While you are welcome to use this code, please be advised that this is simply a pedagogical project. No warranties are expressed or implied. Some assembly required. Batteries not included. Your mileage may vary. etc.
