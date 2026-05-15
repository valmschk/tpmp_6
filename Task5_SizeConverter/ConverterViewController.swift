import UIKit

class ConverterViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    
    // MARK: - Data (Вариант 32)
    // Словарь: Ключ - размер, Значение - словарь с параметрами для разных стран и фоном
    let sizeData: [String: [String: String]] = [
        "EU 42": ["US": "9", "UK": "8.5", "CM": "26.5", "BG": "shoes_bg"],
        "EU 38": ["US": "7.5", "UK": "5", "CM": "24.0", "BG": "heels_bg"],
        "EU 40": ["US": "7.5", "UK": "7", "CM": "25.5", "BG": "shoes_bg"],
        "Size S": ["US": "4-6", "UK": "8-10", "CM": "84-88", "BG": "apparel_bg"],
        "Size M": ["US": "8-10", "UK": "12-14", "CM": "92-96", "BG": "apparel_bg"],
        "Size L": ["US": "12-14", "UK": "16-18", "CM": "100-104", "BG": "apparel_bg"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Начальная настройка интерфейса
        setupInitialUI()
        setupLocalization()
    }

    private func setupInitialUI() {
        resultLabel.numberOfLines = 0
        // Установка стандартного фона при запуске
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = UIImage(named: "default_bg")
    }

    // Метод локализации (требование: RU, EN, PL)
    private func setupLocalization() {
        inputTextField.placeholder = NSLocalizedString("PlaceholderText", comment: "Введите размер")
        resultLabel.text = NSLocalizedString("WelcomeText", comment: "Приветствие")
    }

    // MARK: - Actions
    @IBAction func convertButtonTapped(_ sender: UIButton) {
        // 1. Безопасное извлечение текста (Guard)
        guard let inputText = inputTextField.text, !inputText.isEmpty else {
            resultLabel.text = NSLocalizedString("EmptyError", comment: "Ошибка пустого ввода")
            return
        }
        
        // 2. Поиск в базе данных
        if let info = sizeData[inputText] {
            let us = info["US"] ?? ""
            let uk = info["UK"] ?? ""
            let cm = info["CM"] ?? ""
            
            // 3. Формирование локализованного результата
            let format = NSLocalizedString("ResultFormat", comment: "Формат вывода")
            resultLabel.text = String(format: format, us, uk, cm)
            
            // 4. Смена фонового изображения (Динамические фоны)
            if let imageName = info["BG"] {
                UIView.transition(with: backgroundImageView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    self.backgroundImageView.image = UIImage(named: imageName)
                }, completion: nil)
            }
        } else {
            // 5. Обработка ошибки поиска
            resultLabel.text = NSLocalizedString("NotFound", comment: "Размер не найден")
        }
    }
}
