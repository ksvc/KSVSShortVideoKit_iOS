//
//  DemoAlbumViewController.m
//  KSVSDemo
//
//  Created by devcdl on 2017/11/28.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import "DemoAlbumViewController.h"

@interface DemoAlbumViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) PHCachingImageManager *imageManager;
@property (nonatomic, strong) NSMutableOrderedSet * selectedArray;
@property (nonatomic, strong) UIImage *selectedImage;
@end

@implementation DemoAlbumViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTopBar];
    [self loadCollectionView];
    
    PHFetchOptions *options = [PHFetchOptions new];
    options.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    self.fetchResult = [PHAsset fetchAssetsInAssetCollection:[DemoCommon photoAssetCollection] options:options];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.collectionView reloadData];
}

- (void)setupTopBar {
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextEvent) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.frame = CGRectMake(self.view.bounds.size.width - 60 - 10, 0, 60, 44);
    [self.view addSubview:nextBtn];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont systemFontOfSize:22];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = @"相机胶卷";
    titleLab.frame = CGRectMake((self.view.bounds.size.width - 100)/2.0, 0, 100, 44);
    [self.view addSubview:titleLab];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 50, 44);
    [backBtn addTarget:self action:@selector(backEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

-(void)loadCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize =CGSizeMake((DEMO_SCREENWIDTH-6)/4, (DEMO_SCREENWIDTH-6)/4);
    layout.minimumInteritemSpacing = 2.0f;
    layout.minimumLineSpacing = 2.0f;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.frame = CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height - 44);
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[DemoAssetCell class] forCellWithReuseIdentifier:@"DemoAssetCell"];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.allowsMultipleSelection = YES;
    self.collectionView.bounces = NO;
}

- (void)nextEvent {
//    NSMutableArray * assets = [[NSMutableArray alloc] init];
//    for(int i = 0;i< self.selectedArray.count ;i++){
//        assetCell * cell = self.selectedArray[i];
//        [assets insertObject:cell.asset atIndex:i];
//    }
//    self.assets = assets;
}

- (void)backEvent {
    
}

- (NSMutableOrderedSet *)selectedArray {
    if (!_selectedArray) {
        _selectedArray = [[NSMutableOrderedSet alloc] init];
    }
    return _selectedArray;
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.fetchResult.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DemoAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DemoAssetCell" forIndexPath:indexPath];
    cell.tag = indexPath.item;
    
    // Image
    PHAsset *asset = self.fetchResult[indexPath.item];
    cell.asset = asset;
    CGSize itemSize = [(UICollectionViewFlowLayout *)collectionView.collectionViewLayout itemSize];
    CGSize targetSize = CGSizeMake(itemSize.width *[[UIScreen mainScreen] scale], itemSize.height*[[UIScreen mainScreen] scale]);
    
    [self.imageManager requestImageForAsset:asset
                                 targetSize:targetSize
                                contentMode:PHImageContentModeAspectFit
                                    options:nil
                              resultHandler:^(UIImage *result, NSDictionary *info) {
                                  if (cell.tag == indexPath.item) {
                                      cell.imageView.image = result;
                                  }
                              }];
    
    // Video indicator
    if (asset.mediaType == PHAssetMediaTypeVideo) {
        cell.videoTimeLab.hidden = NO;
        cell.selectIcon.hidden = NO;
        NSInteger minutes = (NSInteger)(asset.duration / 60.0);
        NSInteger seconds = (NSInteger)ceil(asset.duration - 60.0 * (double)minutes);
        cell.videoTimeLab.text = [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
        
        if (asset.mediaSubtypes & PHAssetMediaSubtypeVideoHighFrameRate) {
            
        }
        else {
            
        }
    } else {
        cell.videoTimeLab.hidden = YES;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DemoAssetCell *cell = (DemoAssetCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UIImage *image = cell.imageView.image;
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
}

#pragma mark 懒加载
- (PHCachingImageManager *)imageManager
{
    if (_imageManager == nil) {
        _imageManager = [PHCachingImageManager new];
    }
    
    return _imageManager;
}

@end
