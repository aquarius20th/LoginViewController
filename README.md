LoginViewController
===================

The nature of mobile is such that you are frequently connecting to remote services. These services may provide a benefit like customized data, synchronization, or the like. These remote services often require credentials for secure access, often gathered with a login view of some sort.

Unfortunately, however, there are few _standard_ ways to programmatically create a login interface in iOS. In iOS 5, UIAlertView introduced an _alertViewStyle_ property, with a few options including UIAlertViewStyleSecureTextInput & UIAlertViewStyleLoginAndPasswordInput, but the modal appearance of alert views is often wanting.

Settings.app offers a number of examples (e.g., Mail, Twitter, Facebook) of an approach using table views that gets some attention on Stack Overflow. Most of these proposed solutions seem far too complicated - _convoluted_ even. Many attempt to add UITextFields to the content view of custom table view cells, or create prototype cells in a Storyboard.

This approach simply fashions a grouped UITableView with two rows. The text fields used for input are added as _accessory views_ to each row. The end result is rather straightforward, and backwards-compatible to some degree.

__DISCLAIMER__

While you are welcome to use this code, please be advised that this is simply a pedagogical project. No warranties are expressed or implied. Some assembly required. Batteries not included. Your mileage may vary. etc.
