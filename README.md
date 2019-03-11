# ParallaxSwift
ParallaxSwift is a Swift 2 library, support Onboarding with built-in annimations
  - Move: straight, circle
  - Scale: in, out
  - Fade: in, out
### Use
Simply call to start annimation. For example:
```swift
override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    (self.view as? ParallaxView)?.update()
}
```
### Note
- ParallaxSwift uses Swift 2, cannot be built in Swift 3.
