//
//  DemoPersonalSettingViewController.m
//  KSVSDemo
//
//  Created by devcdl on 2017/11/21.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import "DemoPersonalSettingViewController.h"
#import "DemoAlbumViewController.h"
#import "UIImageView+YYWebImage.h"
#import "DemoActionSheet.h"
#import <KSVSSdk/KSVSKS3UploadService.h>
#import "DemoNetworkService.h"
#import "MBProgressHUD.h"
#import "DemoCacheLoginMsg.h"
#import "DemoCommon.h"

@interface DemoPersonalSettingViewController ()
<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UITextField *nickTextField;
@property (weak, nonatomic) IBOutlet UIButton *genderButton;
@property (weak, nonatomic) IBOutlet UIImageView *cameraImgView;
@property (weak, nonatomic) IBOutlet UIButton *finisheBtn;
@property (strong, nonatomic)        DemoActionSheet *actionSheet;
@property (nonatomic, strong)        KSVSKS3UploadService *ks3Service;
@property (nonatomic, copy)          NSString *headImageUrl;
@property (nonatomic, copy)          void(^updatedProfileBlock)(void);
@property (nonatomic, strong)        UIImage *selectedHeadImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navBarTopConstraint;
@end

@implementation DemoPersonalSettingViewController

- (instancetype)initWithUpdatedProfileBlock:(void(^)(void))updatedProfileBlock {
    if (self = [super init]) {
        _updatedProfileBlock = updatedProfileBlock;
        _headImageUrl = kCurrUser.headUrl;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self addGestures];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:nil];
}

- (KSVSKS3UploadService *)ks3Service {
    if (!_ks3Service) {
        _ks3Service = [[KSVSKS3UploadService alloc] initWithUserId:kCurrUser.uid];
    }
    return _ks3Service;
}

- (void)setupView {
    if (iPhoneX) {
        self.navBarTopConstraint.constant = 20;
    }
    self.avatarImgView.layer.cornerRadius = 37;
    self.avatarImgView.clipsToBounds = YES;
    self.avatarImgView.userInteractionEnabled = YES;
    [_avatarImgView setImageWithURL:[NSURL URLWithString:kCurrUser.headUrl] placeholder:[UIImage imageNamed:@"ksvs_defaultAvatar_male"]];
    
    NSString *gender = kCurrUser.gender ? @"女" : @"男";
    [self.genderButton setTitle:gender forState:UIControlStateNormal];
    
    self.nickTextField.text = [DemoCommon decodeSpecialString:kCurrUser.nickname];
    self.nickTextField.delegate = self;
}

- (void)addGestures {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAvatarActon)];
    [self.avatarImgView addGestureRecognizer:tap];
}

- (void)tapAvatarActon {
    self.actionSheet = [[DemoActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍一张", @"相册选择", nil];
    __weak typeof(self) weakSelf = self;
    self.actionSheet.actionSheetBlock = ^(NSInteger buttonIndex) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (buttonIndex == 0) {
            [strongSelf presentPickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
        } else if (buttonIndex == 1) {
            [strongSelf presentPickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
    };
    [self.actionSheet showInView:self.view];
}

- (void)presentPickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (IBAction)genderClicked:(UIButton *)sender {
    self.actionSheet = [[DemoActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男", @"女", nil];
    __weak typeof(self) weakSelf = self;
    self.actionSheet.actionSheetBlock = ^(NSInteger buttonIndex) {
        typeof(weakSelf) strongSelf = weakSelf;
        NSString *gender = @"男";
        if (buttonIndex == 1) {
            gender = @"女";
        }
        [strongSelf.genderButton setTitle:gender forState:UIControlStateNormal];
    };
    [self.actionSheet showInView:self.view];
}
- (IBAction)popBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)loginOut:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确定要退出登录吗?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
   {
       [self loginOutHandler];
   }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)loginOutHandler {
    if (!kNetworkReachable) {
        SHOW_NO_NETWORK;
        return;
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [DemoNetworkService loginOutComplete:^(DemoLoginOutResponse *response, DemoError *demoError) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (!demoError) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kDemoLoginTokenExpiredNotification object:nil];
            [strongSelf.navigationController popToRootViewControllerAnimated:YES];
        } else {
            NSLog(@"demoError === %@", demoError);
        }
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    }];
}

- (IBAction)finishAction:(id)sender {
    
    if (self.selectedHeadImage) {
        __weak typeof(self) weakSelf = self;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self.ks3Service uploadHeadImage:_selectedHeadImage success:^(NSString *headImageUrl) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.avatarImgView.image = strongSelf.selectedHeadImage;
            strongSelf.headImageUrl = headImageUrl;
            kCurrUser.headUrl = headImageUrl;
            [DemoCacheLoginMsg cacheLoginedUserMsg:kCurrUser];
            
            [self updateProfileWithHeadUrl:headImageUrl];
        } failure:^(KSVSError *ksvsError) {
            typeof(weakSelf) strongSelf = weakSelf;
            [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
            [ksvsError showErrorInView:strongSelf.view];
        }];
    } else {
        [self updateProfileWithHeadUrl:_headImageUrl];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.nickTextField endEditing:YES];
    
    NSLog(@"dddd ===== %d", 0xD800);
}

#pragma mark --- UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.actionSheet.actionSheetBlock) {
        self.actionSheet.actionSheetBlock(buttonIndex);
    }
}

#pragma mark - image picker delegte

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    NSData *imageData = UIImagePNGRepresentation(editedImage);
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    self.avatarImgView.image = compressedImage;
    self.selectedHeadImage = compressedImage;
}

- (void)updateProfileWithHeadUrl:(NSString *)headImageUrl {
    if (!kNetworkReachable) {
        SHOW_NO_NETWORK;
        return;
    }
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    BOOL gender = [self.genderButton.titleLabel.text isEqualToString:@"女"];
    [DemoNetworkService updateProfileWithHeadUrlPath:headImageUrl nickname:[DemoCommon encodeSpecialString:self.nickTextField.text] gender:gender complete:^(DemoUpdateProfileResponse *response, DemoError *demoError) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        typeof(weakSelf) strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!demoError) {
            kCurrUser.nickname = strongSelf.nickTextField.text;
            kCurrUser.gender = gender;
            [DemoCacheLoginMsg cacheLoginedUserMsg:kCurrUser];
            if (strongSelf.updatedProfileBlock) {
                strongSelf.updatedProfileBlock();
            }
            [strongSelf.navigationController popViewControllerAnimated:YES];
        } else {
            if (demoError.errorCode == kNotLoggedIn) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kDemoLoginTokenExpiredNotification object:nil];
            }
            NSLog(@"更新个人信息失败");
        }
    }];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]) {
        return ![DemoCommon stringContainsEmoji:string];
    }
    return YES;
}

#pragma mark -- Notification Event

- (void)textFieldTextDidChange {
    if(_nickTextField.text.length > 10 ) {
        // 此处暂不做连续空格字符的过滤
        NSRange range = NSMakeRange(0, 10);
        _nickTextField.text = [_nickTextField.text substringWithRange:range];
    }
    if ([DemoCommon isContainsTwoEmoji:_nickTextField.text]) {
        _nickTextField.text = [_nickTextField.text substringToIndex:(_nickTextField.text.length - 2)];
    }
}

@end
