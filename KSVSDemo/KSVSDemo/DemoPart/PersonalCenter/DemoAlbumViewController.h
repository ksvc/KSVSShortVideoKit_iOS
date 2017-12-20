//
//  DemoAlbumViewController.h
//  KSVSDemo
//
//  Created by devcdl on 2017/11/28.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoAssetCell.h"

@protocol DemoAlbumViewControllerDelegate <NSObject>

- (void)itemSelected:(DemoAssetCell *_Nullable)cell;

- (void)itemDeSelected:(DemoAssetCell *_Nullable)cell;

- (void)itemDidFinishSelectAssets:(NSArray *_Nullable)assets;

- (void)dismissHandler;

@end

@interface DemoAlbumViewController : UIViewController

@property (nonatomic, strong) PHFetchResult * _Nullable fetchResult;

@property (nonatomic, strong) NSMutableArray<PHAsset*> * _Nullable assets;

@property (nonatomic, weak) id <DemoAlbumViewControllerDelegate> delegate;

- (void)nextEvent;

@end
