//
//  DemoLoginViewController.m
//  KSVSDemo
//
//  Created by devcdl on 2017/11/21.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import "DemoLoginViewController.h"
#import "DemoNetworkService.h"
#import "MBProgressHUD.h"
#import "DemoCacheLoginMsg.h"
#import "NSObject+YYModel.h"

@interface DemoLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *verCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *verCodeTextField;
@property (copy, nonatomic) void(^loginSuccessBlock)(void);
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation DemoLoginViewController

- (instancetype)initWithLoginSuccessBlock:(void(^)(void))loginSuccessBlock {
    if (self = [super init]) {
        _loginSuccessBlock = loginSuccessBlock;
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)textFieldTextDidChange {
    if(_mobileTextField.text.length >= 11 ) {
        NSRange range = NSMakeRange(0, 11);
        _mobileTextField.text = [_mobileTextField.text substringWithRange:range];
        [self.verCodeTextField becomeFirstResponder];
    }
    self.verCodeBtn.enabled = (_mobileTextField.text.length >= 11 );
    self.loginButton.enabled = (_mobileTextField.text.length >= 11 && _verCodeTextField.text.length >= 4);
}

- (void)setupViews {
    self.loginButton.layer.cornerRadius = 22;
    self.loginButton.enabled = NO;
    self.verCodeBtn.enabled = NO;
}

- (IBAction)verCodeBtnClicked:(UIButton *)sender {
    if (!kNetworkReachable) {
        SHOW_NO_NETWORK;
        return;
    }
    self.verCodeBtn.enabled = NO;
    [self.timer fire];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [DemoNetworkService fetchVerificationCodeWithMobile:_mobileTextField.text complete:^(DemoVerificationCodeResponse *response, DemoError *demoError) {
        typeof(weakSelf) strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
        if (!demoError) {
            
        } else {
            NSLog(@"demoError === %@", demoError);
        }
    }];
}

- (IBAction)loginEvent:(id)sender {
    if (!kNetworkReachable) {
        SHOW_NO_NETWORK;
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [DemoNetworkService loginWithMobile:_mobileTextField.text verCode:_verCodeTextField.text complete:^(DemoVerificationCodeLoginResponse *response, DemoError *demoError) {
        typeof(weakSelf) strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
        if (!demoError) {
            if (response.data.token) {
                [DemoCacheLoginMsg cacheLoginedUserMsg:response.data];
                [kCurrUser configeWithUser:response.data];
                [strongSelf dismissViewControllerAnimated:YES completion:nil];
                if (count >= 0) {
                    [strongSelf.timer invalidate];
                    strongSelf.timer = nil;
                }
                if (strongSelf.loginSuccessBlock) {
                    strongSelf.loginSuccessBlock();
                }
            } else {
                NSLog(@"登录失败，返回token为空");
            }
        } else {
            NSLog(@"demoError === %@", demoError);
        }
    }];
}

static NSInteger count = 60;

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _timer;
}
- (void)countDown {
    if (count == -1) {
        count = 60;
        [self.timer invalidate];
        self.timer = nil;
        self.verCodeBtn.enabled = YES;
        [self.verCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        return;
    }
    [self.verCodeBtn setTitle:[@(count--) stringValue] forState:UIControlStateNormal];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.mobileTextField endEditing:YES];
    [self.verCodeTextField endEditing:YES];
}

@end
