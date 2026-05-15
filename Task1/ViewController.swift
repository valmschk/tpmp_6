import UIKit

class ViewController: UIViewController {

    // Ссылки на элементы интерфейса (создаются через Control-перетягивание)
    @IBOutlet weak var switchIndicator: UILabel!
    @IBOutlet weak var backgroundSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Настройка при запуске (Тест 1)
        setupInitialState()
    }

    // Настройка стартового состояния приложения
    func setupInitialState() {
        switchIndicator.text = "Фон выключен"
        switchIndicator.textColor = .white
        
        // Устанавливаем начальное фоновое изображение (bg2)
        if let backgroundImage = UIImage(named: "bg2") {
            self.view.backgroundColor = UIColor(patternImage: backgroundImage)
        }
    }

    // Событие, которое срабатывает при нажатии на переключатель
    @IBAction func backgroundSwitchTapped(_ sender: UISwitch) {
        if sender.isOn {
            // Логика для включенного состояния (Тест 2)
            switchIndicator.text = "Фон включен (bg1)"
            
            if let image = UIImage(named: "bg1") {
                self.view.backgroundColor = UIColor(patternImage: image)
            }
        } else {
            // Логика для выключенного состояния (Тест 3)
            switchIndicator.text = "Фон выключен (bg2)"
            
            if let image = UIImage(named: "bg2") {
                self.view.backgroundColor = UIColor(patternImage: image)
            }
        }
    }
}
