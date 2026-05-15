import SwiftUI

struct ContentView: View {
    // 1. Определение состояния (@State)
    // Эти переменные заставляют интерфейс обновляться при каждом движении ползунка
    @State private var rTarget = Double.random(in: 0...1)
    @State private var gTarget = Double.random(in: 0...1)
    @State private var bTarget = Double.random(in: 0...1)
    
    @State private var rGuess: Double = 0.5
    @State private var gGuess: Double = 0.5
    @State private var bGuess: Double = 0.5
    
    @State private var showAlert = false
    
    // Функция расчета точности (от 0 до 100)
    func computeScore() -> Int {
        let diff = sqrt(pow(rTarget - rGuess, 2) + 
                        pow(gTarget - gGuess, 2) + 
                        pow(bTarget - bGuess, 2))
        let score = Int((1.0 - diff) * 100.0)
        return max(0, score)
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Угадай цвет (Match the Color!)")
                .font(.headline)
            
            // Блоки отображения цветов
            HStack {
                VStack {
                    Rectangle()
                        .foregroundColor(Color(red: rTarget, green: gTarget, blue: bTarget))
                    Text("Цель")
                }
                VStack {
                    Rectangle()
                        .foregroundColor(Color(red: rGuess, green: gGuess, blue: bGuess))
                    Text("Твой результат")
                }
            }
            .frame(height: 200)
            .padding()

            // 2. "Умные" ползунки (Binding через $)
            VStack {
                ColorSlider(value: $rGuess, textColor: .red, label: "Red")
                ColorSlider(value: $gGuess, textColor: .green, label: "Green")
                ColorSlider(value: $bGuess, textColor: .blue, label: "Blue")
            }
            .padding(.horizontal)

            // Кнопка проверки результата
            Button(action: {
                self.showAlert = true
            }) {
                Text("Hit Me!")
                    .font(.title2)
                    .bold()
            }
            // 3. Вывод оценки через Alert
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Ваш результат"),
                      message: Text("Вы набрали \(computeScore()) очков"),
                      dismissButton: .default(Text("OK")) {
                        // Обновляем цель для новой игры
                        self.rTarget = Double.random(in: 0...1)
                        self.gTarget = Double.random(in: 0...1)
                        self.bTarget = Double.random(in: 0...1)
                      })
            }
        }
    }
}

// Переиспользуемое представление для ползунка (Reusable View)
struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color
    var label: String
    
    var body: some View {
        HStack {
            Text(label).foregroundColor(textColor).frame(width: 50)
            Slider(value: $value)
            Text("\(Int(value * 255))").frame(width: 35)
        }
    }
}

// Предпросмотр (включая Landscape для отчета)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        // Для теста альбомной ориентации (Задание 4, Тест 4)
        ContentView().previewInterfaceOrientation(.landscapeLeft)
    }
}
