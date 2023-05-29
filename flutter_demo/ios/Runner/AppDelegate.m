#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
    
    //注册方法 flutter和原生交互
    FlutterViewController *vc = (FlutterViewController *)self.window.rootViewController;
    self.methodChannel = [FlutterMethodChannel methodChannelWithName:@"mine_page/method" binaryMessenger:vc];
    UIImagePickerController *imageVC = [[UIImagePickerController alloc]init];
    imageVC.delegate = self;
    [self.methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"picture"]) {
            [vc presentViewController:imageVC animated:YES completion:nil];
        }
    }];
    
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%@",info);
       NSString *imagePath = [NSString stringWithFormat:@"%@",info[@"UIImagePickerControllerImageURL"]];
        [self.methodChannel invokeMethod:@"imagePath" arguments:imagePath];
    }];
}

@end
