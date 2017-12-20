//
//  DemoAssetCell.h
//  KSVSDemo
//
//  Created by devcdl on 2017/11/28.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface DemoAssetCell : UICollectionViewCell

//图像层
@property (strong, nonatomic) UIImageView *imageView;
//选中标示
@property (strong, nonatomic) UIImageView *selectIcon;
//视频时长
@property (strong, nonatomic) UILabel* videoTimeLab;
//存储的asset
@property (strong, nonatomic) PHAsset* asset;

@end
