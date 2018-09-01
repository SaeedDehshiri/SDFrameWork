![SDFrameWork in Swift by [Saeed Dehshiri](https://dehshiri.com)](https://api.dehshiri.com/media/images/iResume.png)

SDFrameWork is a powerfull and easy to use framework that saves your time on building no-`Storyboard` ios apps.

# Step By Step
After checked all step, you can easily to use framework.

- [ ] [Install](#install-from-cocoapod) last version from cocoapod
- [ ] [Import](#import) pod after install in AppDelegate
- [ ] [Use](#how-to-use!) spesific class for Layout, Time, ...

## Install from cocoapod

First create `Podfile` in your project directory, after that use below code in `Podfile`.

```ruby
platform :ios, '9.0'
use_frameworks!

target '<Your App Name>' do
  pod 'SDFrameWork'
end
```

## Import

You should import SDFrameWork in `AppDelegate`

```swift
import SDFrameWork
```

## How to use!

```swift
        var label = UILabel()
        label = SDLayout.createLabel(uiLabel: label, hex: UIColor.init(red: 20, green: 20, blue: 20, alpha: 1.0), x: 20, y: 30, h: 30, w: 100, txt: "SAMPLE label")
        self.view.addSubview(label)
```

## License

SDFrameWork is released under the MIT license. [See LICENSE](https://github.com/SaeedDehshiri/SDFrameWork/blob/master/LICENSE) for details.
