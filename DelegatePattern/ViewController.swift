import UIKit

protocol Controller {
    associatedtype ViewType
    var typedView: ViewType { get }
}

protocol SampleViewActionDelegate: AnyObject {
    func buttonWasTapped(_ sender: UIButton) -> Void
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

class BaseView: UIView {
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
    }
}

class SampleView: BaseView {
    
    public weak var buttonActionDelegate: SampleViewActionDelegate?
    
    private let button: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("This is a button", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor
            .constraint(equalToConstant: 60).isActive = true
        button.widthAnchor
            .constraint(equalToConstant: 200).isActive = true
        return button
    }()
    
    override func setupView() {
        super.setupView()
        self.backgroundColor = .white
        self.addSubview(button)
        self.button.centerXAnchor
            .constraint(equalTo: self.centerXAnchor).isActive = true
        self.button.centerYAnchor
            .constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.button.addTarget(self, action: #selector(self.delegateButtonTap), for: .touchUpInside)
    }
    
    @objc private func delegateButtonTap(_ sender: UIButton) {
        self.buttonActionDelegate?.buttonWasTapped(sender)
    }
}

class ViewController: BaseViewController<SampleView>, SampleViewActionDelegate {
    
    func buttonWasTapped(_ sender: UIButton) {
        //
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.typedView.buttonActionDelegate = self
        view.backgroundColor = .white
        self.title = "Delegate Pattern"
    }
}
