//
//  DemoAssetCell.m
//  KSVSDemo
//
//  Created by devcdl on 2017/11/28.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import "DemoAssetCell.h"
#import "UIColor+YYAdd.h"
#import "Masonry.h"

@implementation DemoAssetCell


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置imageView
        [self setupUI];
        self.contentView.backgroundColor = [UIColor blackColor];
        
    }
    return self;
}

-(void)setupUI{
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    
    self.selectIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kvs_select"]];
    self.selectIcon.contentMode = UIViewContentModeScaleAspectFill;
    self.selectIcon.clipsToBounds = YES;
    
    self.videoTimeLab = [[UILabel alloc] init];
    self.videoTimeLab.font = [UIFont systemFontOfSize:11];
    self.videoTimeLab.textColor = [UIColor colorWithHexString:@"#ffffff"];
    self.videoTimeLab.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.videoTimeLab];
    [self.contentView addSubview:self.selectIcon];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.leading.trailing.equalTo(self.contentView);
    }];
    
    [self.selectIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0, 0));
        make.bottom.trailing.equalTo(self.contentView);
    }];
    
    [self.videoTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.trailing.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake((DEMO_SCREENWIDTH - 6) / 8, 20));
    }];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    CGFloat width = selected ? 30 : 0;
    [self.selectIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, width));
        make.bottom.trailing.equalTo(self.contentView);
    }];
}

@end
