#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController {
    NSDictionary *cities; // Наш словарь с данными
}

- (void)viewDidLoad {
    super.viewDidLoad();
    
    // Инициализация базы данных городов согласно Варианту 32
    cities = @{
        @"Minsk": @{@"temp": @"+18", @"cuisine": @"CuisineBelarusian", @"image": @"minsk_rest"},
        @"Warsaw": @{@"temp": @"+20", @"cuisine": @"CuisinePolish", @"image": @"warsaw_rest"},
        @"Krakow": @{@"temp": @"+19", @"cuisine": @"CuisinePolish", @"image": @"krakow_rest"},
        @"Hrodna": @{@"temp": @"+15", @"cuisine": @"CuisineEuropean", @"image": @"grodno_rest"}
    };
}

- (IBAction)showInfo:(id)sender {
    NSString *userInput = self.cityInput.text;
    NSDictionary *cityData = cities[userInput];
    
    if (cityData) {
        NSString *temp = cityData[@"temp"];
        NSString *cuisineKey = cityData[@"cuisine"];
        NSString *imageName = cityData[@"image"];
        
        // Локализация типа кухни через макрос
        NSString *localizedCuisine = NSLocalizedString(cuisineKey, nil);
        
        self.infoLabel.text = [NSString stringWithFormat:@"%@\n%@", temp, localizedCuisine];
        self.restaurantImage.image = [UIImage imageNamed:imageName];
        
        // Логика изменения цвета текста (Красный — тепло, Синий — холод)
        if ([temp containsString:@"+"]) {
            self.infoLabel.textColor = [UIColor redColor];
        } else {
            self.infoLabel.textColor = [UIColor blueColor];
        }
    } else {
        // Если город не найден — выводим ошибку
        self.infoLabel.text = NSLocalizedString(@"CityNotFound", nil);
        self.restaurantImage.image = nil;
        self.infoLabel.textColor = [UIColor grayColor];
    }
}

@end
