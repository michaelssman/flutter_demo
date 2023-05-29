#import "FlutterPlugin.h"

@implementation FlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_plugin"
            binaryMessenger:[registrar messenger]];
  FlutterPlugin* instance = [[FlutterPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if([@"getPlatformBatteryLevel" isEqualToString:call.method]){
      int batteryLevel = [self getBatteryLevel];
      result(@(batteryLevel));
  }else{
    result(FlutterMethodNotImplemented);
  }
}

-(int)getBatteryLevel{
    UIDevice * device = UIDevice.currentDevice;
    device.batteryMonitoringEnabled = YES;
    if (device.batteryLevel == UIDeviceOrientationUnknown) {
        return  -1;
    }else{
        return (int)(device.batteryState * 100);
    }
}

@end
