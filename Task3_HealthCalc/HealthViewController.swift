import UIKit

class HealthViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var activitySegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Настройка меток и клавиатур при запуске
        setupUI()
    }
    
    func setupUI() {
        resultLabel.text = "Введите данные для расчета"
        resultLabel.numberOfLines = 0 // Позволяет тексту переноситься на несколько строк
        
        // Устанавливаем цифровую клавиатуру для ввода
        ageTextField.keyboardType = .numberPad
        heightTextField.keyboardType = .numberPad
        weightTextField.keyboardType = .numberPad
    }

    // MARK: - Actions
    @IBAction func calculateTapped(_ sender: UIButton) {
        // 1. Извлечение и проверка данных (Guard исключает пустые значения или текст)
        guard let ageText = ageTextField.text, let age = Double(ageText),
              let heightText = heightTextField.text, let height = Double(heightText),
              let weightText = weightTextField.text, let weight = Double(weightText) else {
            resultLabel.text = "Ошибка: введите корректные числовые данные"
            return
        }
        
        // 2. Расчет ИМТ (BMI)
        // Формула: Вес (кг) / (Рост (м) * Рост (м))
        let heightInMeters = height / 100
        let bmi = weight / (heightInMeters * heightInMeters)
        
        // 3. Расчет BMR (Базовый метаболизм по Гаррису-Бенедикту)
        var bmr: Double = 0
        if genderSegmentedControl.selectedSegmentIndex == 0 {
            // Формула для мужчин
            bmr = 88.36 + (13.4 * weight) + (4.8 * height) - (5.7 * age)
        } else {
            // Формула для женщин
            bmr = 447.59 + (9.2 * weight) + (3.1 * height) - (4.3 * age)
        }
        
        // 4. Учет физической активности
        // Массив коэффициентов соответствует индексам в UISegmentedControl
        let activityCoefficients = [1.2, 1.375, 1.55, 1.725, 1.9]
        let selectedIndex = activitySegmentedControl.selectedSegmentIndex
        let finalCalories = bmr * activityCoefficients[selectedIndex]
        
        // 5. Вывод результата (округление до 1 знака после запятой)
        resultLabel.text = String(format: "Ваш ИМТ (BMI): %.1f\nСуточная норма: %.0f ккал", bmi, finalCalories)
    }
}
