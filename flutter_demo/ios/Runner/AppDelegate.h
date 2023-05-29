#import <Flutter/Flutter.h>
#import <UIKit/UIKit.h>

@interface AppDelegate : FlutterAppDelegate<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong)FlutterMethodChannel *methodChannel;
@end
