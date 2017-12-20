//
//  DemoPersonalCenterViewController.m
//  KSVSDemo
//
//  Created by devcdl on 2017/11/21.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import "DemoPersonalCenterViewController.h"
#import "DemoPersonalSettingViewController.h"
#import "UIImageView+YYWebImage.h"
#import "UIView+YYAdd.h"
#import <KSVSSdk/KSVSUserInfoRequestService.h>
#import <KSVSSdk/KSVSReleasedVideoResponse.h>
#import <KSVSSdk/KSVSVideoModel.h>
#import "MBProgressHUD.h"
#import "DemoReleasedVideoCell.h"
#import <KSVSSdk/KSVSPlayerViewController.h>
#import "AppDelegate.h"
#import "Masonry.h"
#import "DemoCommon.h"

@interface DemoPersonalCenterViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic)   IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *genderImgView;
@property (weak, nonatomic)   IBOutlet UILabel *nickNameLab;
@property (weak, nonatomic)   IBOutlet UILabel *playIdLab;
@property (weak, nonatomic)   IBOutlet UITableView *releasedVideoTable;
@property (strong, nonatomic) NSMutableArray<KSVSVideoModel*> *releasedVideos;
@property (weak, nonatomic) IBOutlet UILabel *releasedAmountLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backTopConstraint;
@end

static NSString * const kDemoReleasedVideoCellId = @"kDemoReleasedVideoCellId";
#define kVideoCellHeight (100)

@implementation DemoPersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configeViews];
    [self fetchReseasedVideos];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)configeViews {
    if (iPhoneX) {
        self.backTopConstraint.constant += 20;
    }
    
    self.releasedVideoTable.dataSource = self;
    self.releasedVideoTable.delegate = self;
    [self.releasedVideoTable registerNib:[UINib nibWithNibName:@"DemoReleasedVideoCell" bundle:nil] forCellReuseIdentifier:kDemoReleasedVideoCellId];
    self.releasedVideoTable.rowHeight = kVideoCellHeight;
    self.releasedVideoTable.tableFooterView = [[UIView alloc] init];
    self.releasedAmountLab.text = nil;
    
    self.avatarImgView.layer.cornerRadius = 37;
    self.avatarImgView.clipsToBounds = YES;
    [self configProfileViews];
    self.playIdLab.text = [NSString stringWithFormat:@"开播ID：%@", kCurrUser.uid];
    
    NSString *genderImg = kCurrUser.gender ? @"female_icon" : @"male_icon";
    self.genderImgView.image = [UIImage imageNamed:genderImg];
    
    self.playIdLab.hidden = YES;
}

- (void)configProfileViews {
    [_avatarImgView setImageWithURL:[NSURL URLWithString:kCurrUser.headUrl] placeholder:[UIImage imageNamed:@"ksvs_defaultAvatar_male"]];
    self.nickNameLab.text = kCurrUser.nickname;
    NSString *genderImg = kCurrUser.gender ? @"female_icon" : @"male_icon";
    self.genderImgView.image = [UIImage imageNamed:genderImg];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)settingAction:(id)sender {
    [self pushToSettingVC];
}
- (IBAction)tapHeadIconAction:(id)sender {
    [self pushToSettingVC];
}

- (void)pushToSettingVC {
    __weak typeof(self) weakSelf = self;
    DemoPersonalSettingViewController *settingVC = [[DemoPersonalSettingViewController alloc] initWithUpdatedProfileBlock:^{
        typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf configProfileViews];
    }];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (NSMutableArray *)releasedVideos {
    if (!_releasedVideos) {
        _releasedVideos = [NSMutableArray new];
    }
    return _releasedVideos;
}

- (void)fetchReseasedVideos {
    if (!kNetworkReachable) {
        SHOW_NO_NETWORK;
        return;
    }
    __weak typeof(self) weakSelf = self;
    [KSVSUserInfoRequestService fetchReleasedVideoWithUserId:kCurrUser.uid page:1 size:50 completion:^(KSVSReleasedVideoResponse *response, KSVSError *ksvsError) {
        typeof(weakSelf) strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
        if (!ksvsError) {
            NSString *releasedCnt = nil;
            if (response.Data.Videos.count > 0) {
                releasedCnt = [NSString stringWithFormat:@"已发布视频（%zd）", response.Data.Videos.count];
                [strongSelf.releasedVideos removeAllObjects];
                [strongSelf.releasedVideos addObjectsFromArray:response.Data.Videos];
                [strongSelf.releasedVideoTable reloadData];
            }
            strongSelf.releasedAmountLab.text = releasedCnt;
        } else {
            [ksvsError showErrorInView:strongSelf.view];
        }
    }];
}

#pragma mark ---------- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.releasedVideos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DemoReleasedVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:kDemoReleasedVideoCellId];
    [cell configeWithVideoModel:self.releasedVideos[indexPath.row]];
    return cell;
}

#pragma mark ------------ UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KSVSVideoModel *model = self.releasedVideos[indexPath.row];
    model.Author = kCurrUser.nickname;
    model.Cover = kCurrUser.headUrl;
    KSVSPlayerViewController *playerVC = [[KSVSPlayerViewController alloc] initWithVideoModel:model playerFrom:KSVSPlayerFromPersonalCenter];
    [self.navigationController pushViewController:playerVC animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return   UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!kNetworkReachable) {
        SHOW_NO_NETWORK;
        return;
    }
    if (!kNetworkReachable) {
        SHOW_NO_NETWORK;
        return;
    }
    [tableView setEditing:NO animated:YES];
    if (editingStyle != UITableViewCellEditingStyleDelete) {
        return;
    }
    if (indexPath.row >= _releasedVideos.count) {
        return;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认删除?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertControllerStyleAlert handler:^(UIAlertAction * _Nonnull action)
    {
        KSVSVideoModel *model = self.releasedVideos[indexPath.row];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        __weak typeof(self) weakSelf = self;
        [KSVSUserInfoRequestService deleteReleasedVideoWithUserId:kCurrUser.uid videoId:model.Id completion:^(KSVSDeleteReleasedVideoResponse *response, KSVSError *ksvsError) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            typeof(weakSelf) strongSelf = weakSelf;
            if (!ksvsError) {
                [strongSelf.releasedVideos removeObjectAtIndex:indexPath.row];
                [tableView reloadData];
                strongSelf.releasedAmountLab.text = [NSString stringWithFormat:@"已发布视频（%zd）", strongSelf.releasedVideos.count];
            } else {
                [ksvsError showErrorInView:strongSelf.view];
            }
        }];
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
