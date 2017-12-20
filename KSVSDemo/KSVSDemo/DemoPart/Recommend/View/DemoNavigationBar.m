//
//  DemoNavigationBar.m
//  KSVSShortVideoDev
//
//  Created by devcdl on 2017/11/14.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import "DemoNavigationBar.h"
#import <Masonry/Masonry.h>
#import "UIColor+YYAdd.h"
#import "UIImageView+YYWebImage.h"
#import "DemoUser.h"
#import "UIView+YYAdd.h"

@interface DemoNavigationBar ()
@property (nonatomic, strong) UIImageView *avatarImgView;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIButton *recordButton;
@property (nonatomic, strong) UIView *partingLine;

@property (nonatomic, copy)   void(^recordBlock)(void);
@property (nonatomic, copy)   void(^avatarClickBlock)(void);
@property (nonatomic, strong) DemoUser *user;
@end

@implementation DemoNavigationBar

- (instancetype)initWithUser:(DemoUser *)user
                 recordBlock:(void(^)(void))recordBlock {
    if (self = [super init]) {
        _user = user;
        _recordBlock = recordBlock;
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithUser:(DemoUser *)user
                 recordBlock:(void(^)(void))recordBlock
            avatarClickBlock:(void(^)(void))avatarClickBlock {
    if (self = [super init]) {
        _user = user;
        _recordBlock = recordBlock;
        _avatarClickBlock = avatarClickBlock;
        [self setupUI];
    }
    return self;
}

- (void)configeWithUser:(DemoUser *)user {
    self.user = user;
    [self.avatarImgView setImageWithURL:[NSURL URLWithString:self.user.headUrl] placeholder:[UIImage imageNamed:@"ksvs_defaultAvatar_male"]];
    self.nameLab.text = user.nickname;
}

#pragma mark ---------- UI

- (void)setupUI {
    [self addSubview:self.avatarImgView];
    [self addSubview:self.nameLab];
    [self addSubview:self.recordButton];
    [self addSubview:self.partingLine];
    [self configeConstraints];
}

- (UIImageView *)avatarImgView {
    if (!_avatarImgView) {
        _avatarImgView = [[UIImageView alloc] init];
        _avatarImgView.layer.cornerRadius = 11;
        _avatarImgView.clipsToBounds = YES;
        _avatarImgView.userInteractionEnabled = YES;
        [_avatarImgView setImageWithURL:[NSURL URLWithString:self.user.headUrl] placeholder:[UIImage imageNamed:@"ksvs_defaultAvatar_male"]];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAvatarEvent:)];
        [_avatarImgView addGestureRecognizer:tap];
    }
    return _avatarImgView;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.text = self.user.nickname;
        _nameLab.font = [UIFont systemFontOfSize:13];
        _nameLab.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _nameLab;
}

- (UIButton *)recordButton {
    if (!_recordButton) {
        _recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recordButton setImage:[UIImage imageNamed:@"ksvs_record_machine"] forState:UIControlStateNormal];
        [_recordButton setImage:[UIImage imageNamed:@"ksvs_record_machine"] forState:UIControlStateHighlighted];
        [_recordButton addTarget:self action:@selector(recordEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _recordButton;
}

- (UIView *)partingLine {
    if (!_partingLine) {
        _partingLine = [[UIView alloc] init];
        _partingLine.backgroundColor = [UIColor colorWithHexString:@"f3f3f3"];
    }
    return _partingLine;
}

- (void)configeConstraints {
    [self.avatarImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.top.mas_equalTo(33);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImgView.mas_right).offset(5);
        make.centerY.equalTo(self.avatarImgView);
    }];
    [self.recordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self);
        make.centerY.equalTo(self.avatarImgView);
        make.size.mas_equalTo(CGSizeMake(62, 40));
    }];
    [self.partingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark ---------- Control Event

- (void)recordEvent:(UIButton *)sender {
    if (self.recordBlock) {
        self.recordBlock();
    }
}

- (void)tapAvatarEvent:(UITapGestureRecognizer *)tap {
    if (self.avatarClickBlock) {
        self.avatarClickBlock();
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (point.x >= 0 && point.x <= 150 && point.y >= 0 && point.y <= self.height) {
        return self.avatarImgView;
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark --
#pragma mark --  Public Method

- (void)updateBarData {
    [self.avatarImgView setImageWithURL:[NSURL URLWithString:kCurrUser.headUrl] placeholder:[UIImage imageNamed:@"ksvs_defaultAvatar_male"]];
    self.nameLab.text = kCurrUser.nickname;
}

@end
