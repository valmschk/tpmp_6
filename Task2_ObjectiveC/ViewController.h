#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// Поле ввода города
@property (weak, nonatomic) IBOutlet UITextField *cityInput;
// Метка для вывода температуры и кухни
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
// Область для отображения фото ресторана
@property (weak, nonatomic) IBOutlet UIImageView *restaurantImage;

// Метод, срабатывающий при нажатии кнопки
- (IBAction)showInfo:(id)sender;

@end
