//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    var label: UIView!
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        label = UIView()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.backgroundColor = .red
        
        view.addSubview(label)
        self.view = view
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = UIColor.yellow.cgColor
        animation.toValue = UIColor.green.cgColor
        animation.beginTime = CACurrentMediaTime() + 2
        animation.duration = 5
        animation.fillMode = kCAFillModeForwards
//        animation.isRemovedOnCompletion = false
        
        label.layer.add(animation, forKey: nil)
        
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
