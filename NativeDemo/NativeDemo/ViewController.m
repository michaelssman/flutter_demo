//
//  ViewController.m
//  NativeDemo
//
//  Created by michael on 2022/1/25.
//

#import "ViewController.h"
#import <Flutter/Flutter.h>
@interface ViewController ()
@property (nonatomic, strong)FlutterEngine *flutterEngine;//引擎
@property (nonatomic, strong)FlutterViewController *flutterVC;
@property (nonatomic, strong)FlutterBasicMessageChannel *msgChannel;
@end

@implementation ViewController

- (FlutterEngine *)flutterEngine {
    if (!_flutterEngine) {
        FlutterEngine *engine = [[FlutterEngine alloc]initWithName:@"hhhhh"];
        if (engine.run) {
            _flutterEngine = engine;
        }
    }
    return _flutterEngine;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.flutterEngine;//先调一下
    self.flutterVC = [[FlutterViewController alloc]initWithEngine:self.flutterEngine nibName:nil bundle:nil];
    
    //监听
    self.msgChannel = [FlutterBasicMessageChannel messageChannelWithName:@"messageChannel" binaryMessenger:self.flutterVC.binaryMessenger];
    [self.msgChannel setMessageHandler:^(id  _Nullable message, FlutterReply  _Nonnull callback) {
            NSLog(@"收到Flutter的：%@",message);
    }];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.backgroundColor = [UIColor whiteColor];
    button1.layer.masksToBounds = YES;
    button1.layer.cornerRadius = 20.0;
    button1.layer.borderColor = [UIColor blueColor].CGColor;
    button1.layer.borderWidth = 1.0;
    [button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button1 setTitle:@"pushFlutter1" forState:UIControlStateNormal];
    [self.view addSubview:button1];
    button1.frame = CGRectMake(100, 100, 200, 70);
    [button1 addTarget:self action:@selector(pushFlutter1) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.backgroundColor = [UIColor whiteColor];
    button2.layer.masksToBounds = YES;
    button2.layer.cornerRadius = 20.0;
    button2.layer.borderColor = [UIColor blueColor].CGColor;
    button2.layer.borderWidth = 1.0;
    [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button2 setTitle:@"pushFlutter2" forState:UIControlStateNormal];
    [self.view addSubview:button2];
    button2.frame = CGRectMake(100, 200, 200, 70);
    [button2 addTarget:self action:@selector(pushFlutter2) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - push Flutter工程
- (void)pushFlutter1 {
    self.flutterVC.modalPresentationStyle = UIModalPresentationFullScreen;
    //创建channel.
    FlutterMethodChannel *methodChannel = [FlutterMethodChannel methodChannelWithName:@"one_page" binaryMessenger:self.flutterVC.binaryMessenger];
    //告诉flutter显示one_page
    [methodChannel invokeMethod:@"one" arguments:nil];
    //弹出页面
    [self presentViewController:self.flutterVC animated:YES completion:nil];
    //监听退出
    [methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        //如果是exit 就退出
        if ([call.method isEqualToString:@"exit"]) {
            [self.flutterVC dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)pushFlutter2 {
    self.flutterVC.modalPresentationStyle = UIModalPresentationFullScreen;
    //创建channel.
    FlutterMethodChannel *methodChannel = [FlutterMethodChannel methodChannelWithName:@"two_page" binaryMessenger:self.flutterVC.binaryMessenger];
    //告诉flutter显示two_page
    [methodChannel invokeMethod:@"two" arguments:nil];
    //弹出页面
    [self presentViewController:self.flutterVC animated:YES completion:nil];
    //监听退出
    [methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        //如果是exit 就退出
        if ([call.method isEqualToString:@"exit"]) {
            [self.flutterVC dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static int a = 0;
    [self.msgChannel sendMessage:[NSString stringWithFormat:@"%d",a++]];
}

@end
