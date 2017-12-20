//
//  DemoRecommendViewController.m
//  KSVSShortVideoDev
//
//  Created by devcdl on 2017/11/14.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import "DemoRecommendViewController.h"
#import "DemoPersonalCenterViewController.h"
#import "DemoLoginViewController.h"
#import <KSVSSdk/KSVSSdk.h>
#import "DemoNavigationBar.h"
#import "DemoCacheLoginMsg.h"
#import "NSObject+YYModel.h"
#import "DemoNetworkService.h"
#import "MBProgressHUD.h"
#import "UIView+toast.h"

@interface DemoRecommendViewController ()
@property (nonatomic, strong) DemoNavigationBar *navigationBar;
@property (nonatomic, strong) KSVSSquareViewController *squareVC;
@end

@implementation DemoRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loginStateHandler];
    [self registNotification];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    SHOW_STATUS_BAR;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationBar updateBarData];
}

- (void)registNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOutNotificationHandler) name:kDemoLoginTokenExpiredNotification object:nil];
}

- (void)loginStateHandler {
    DemoUser *user = [DemoCacheLoginMsg loginedUserMsg];
    NSLog(@"uid ======= %@", user.uid);
    if (user) {
        [kCurrUser configeWithUser:user];
        [self fetchProfile];
    } else {
        [self presentLoginVC];
    }
}
// 每次重新拉取个人信息
- (void)fetchProfile {
    if (!kNetworkReachable) {
        SHOW_NO_NETWORK;
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [DemoNetworkService fetchProfileWithComplete:^(DemoProfileResponse *response, DemoError *demoError) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        typeof(weakSelf) strongSelf = weakSelf;
        if (!demoError) {
            DemoUser *user = [DemoCacheLoginMsg loginedUserMsg];
            [user configeWithProfileData:response.data];
            [DemoCacheLoginMsg cacheLoginedUserMsg:user];
            [kCurrUser configeWithUser:user];
            
            if (!kCurrUser.token) {
                [strongSelf presentLoginVC];
            } else {
                [strongSelf startAuth];
            }
        } else {
            
        }
    }];
}

- (void)loginOutNotificationHandler {
    
    [DemoCacheLoginMsg loginOutHandler];
    [self presentLoginVC];
    [self removeAllSubviews];
}

- (void)removeAllSubviews {
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.squareVC removeFromParentViewController];
    self.navigationBar = nil;
    self.squareVC = nil;
}

- (void)presentLoginVC {
    self.navigationBar.userInteractionEnabled = NO;
    __weak typeof(self) weakSelf = self;
    DemoLoginViewController *loginVC = [[DemoLoginViewController alloc] initWithLoginSuccessBlock:^{
        typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf loginSuccessCallback];
    }];
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (void)loginSuccessCallback {
    [self removeAllSubviews];
    [self setupDemoUI];
    [self startAuth];
}

- (void)startAuth {
    if (!kNetworkReachable) {
        SHOW_NO_NETWORK;
        return;
    }
    
    NSString *bundleId = DEMO_BUNDLEID;
    NSString *ksvsToken = DEMO_TOKEN;
    
    __weak typeof(self) weakSelf = self;
    [KSVSAuthService authWithBundleIdentifier:bundleId ksvsToken:ksvsToken accessToken:kCurrUser.token success:^{
        typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf authSuccessCallback];
    } failure:^(KSVSError *ksvsError) {
        NSString *toast = [NSString stringWithFormat:@"鉴权失败(错误码: %zd)", ksvsError.errorCode];
        [self.view makeToast:toast duration:2.0 position:[NSValue valueWithCGPoint:self.view.center] style:nil];
    }];
}

- (void)authSuccessCallback {
    [self removeAllSubviews];
    [self setupDemoUI];
    [self setupSDKUI];
    self.navigationBar.userInteractionEnabled = YES;
}

- (void)setupDemoUI {
    self.view.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    self.navigationBar = [[DemoNavigationBar alloc] initWithUser:kCurrUser recordBlock:^{
        typeof(weakSelf) strongSelf = weakSelf;
        KSVSRecordViewController *recordVC = [[KSVSRecordViewController alloc] initWithUserId:[DemoUser shared].uid userName:[DemoUser shared].nickname userAvatar:[DemoUser shared].headUrl];
        [strongSelf.navigationController pushViewController:recordVC animated:YES];
    } avatarClickBlock:^{
        typeof(weakSelf) strongSelf = weakSelf;
        DemoPersonalCenterViewController *pcv = [[DemoPersonalCenterViewController alloc] init];
        [strongSelf.navigationController pushViewController:pcv animated:YES];
    }];
    [self.view addSubview:self.navigationBar];
    [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        if (!iPhoneX) {
            make.leading.trailing.top.equalTo(self.view);
        } else {
            make.leading.trailing.equalTo(self.view);
            make.top.mas_equalTo(20);
        }
        make.height.mas_equalTo(64);
    }];
    self.navigationBar.userInteractionEnabled = NO;
}

- (void)setupSDKUI {
    
    KSVSSquareViewController *squareVC = [[KSVSSquareViewController alloc] initWithUserId:kCurrUser.uid userName:kCurrUser.nickname headUrl:kCurrUser.headUrl bundleId:DEMO_BUNDLEID];
    [self addChildViewController:squareVC];
    [self.view addSubview:squareVC.view];
    self.squareVC = squareVC;
    [squareVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view);
        make.top.equalTo(self.navigationBar.mas_bottom);
    }];
}

@end
