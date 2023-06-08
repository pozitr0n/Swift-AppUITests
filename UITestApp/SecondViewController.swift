import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var mainViewController: ViewController?
    var data: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Навешиваем таргет на textField, чтобы отреагировать на его изменение
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        // Если данные не пустые, меняем текст titleLabel
        if let title = data?.title {
            titleLabel.text = title
        }
    }
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        // Если id у данных не пустой И title не пустой, то изменяем данные на ViewController'e
        guard let id = data?.id, let title = textField.text else { return }
        mainViewController?.change(.init(id: id, title: title))
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true)
    }
}
