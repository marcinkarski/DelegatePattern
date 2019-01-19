import UIKit

protocol Controller {
    associatedtype ViewType
    var typedView: ViewType { get }
}

class BaseViewController<ViewType: UIView>: UIViewController, Controller {
    
    override func loadView() {
        self.view = ViewType()
    }
    
    var typedView: ViewType {
        if let view = self.view as? ViewType {
            return view
        } else {
            let view = ViewType()
            self.view = view
            return view
        }
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .white
        self.title = "Delegate Pattern"
    }
}
