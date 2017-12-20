//
//  DemoReleasedVideoCell.m
//  KSVSDemo
//
//  Created by devcdl on 2017/11/27.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import "DemoReleasedVideoCell.h"
#import <KSVSSdk/KSVSVideoModel.h>
#import "UIImageView+YYWebImage.h"
#import "DemoCommon.h"

@interface DemoReleasedVideoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *releaseTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *durationLab;
@property (strong, nonatomic) KSVSVideoModel *videoModel;
@property (strong, nonatomic) NSDateFormatter *fmt;
@end

@implementation DemoReleasedVideoCell

- (void)awakeFromNib {
    self.coverImgView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)configeWithVideoModel:(KSVSVideoModel *)videoModel {
    self.videoModel = videoModel;
    [_coverImgView setImageWithURL:[NSURL URLWithString:videoModel.Cover] placeholder:[UIImage imageNamed:@"nil"]];
    self.titleLab.text = [DemoCommon decodeSpecialString:videoModel.Title];
    self.releaseTimeLab.text = [self.fmt stringFromDate:[NSDate dateWithTimeIntervalSince1970:videoModel.Time.doubleValue / 1000.0]];
    self.durationLab.text = [DemoCommon formattedVideoDuration:videoModel.Duration.doubleValue / 1000.0];
}

- (NSDateFormatter *)fmt {
    if (!_fmt) {
        _fmt = [[NSDateFormatter alloc] init];
        _fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    return _fmt;
}

@end
