//
//  TSAssetGroupController.m
//  TSAssetPickerController
//
//  Created by linitial on 15-3-2.
//  Copyright (c) 2015年 linitial. All rights reserved.
//

#import "TSAssetGroupController.h"
#import "TSAssetController.h"

@implementation UIImage (TSAssetGroupImageUnitl)
#pragma mark - 无损压缩图片
- (UIImage *)thumbImageWithSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, 0.0); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (newImage == nil) {
        NSLog(@"could not scale image");
        newImage = self;
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end

@interface TSAssetGroupController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSMutableArray *groups;
@property (nonatomic) ALAssetsLibrary *assetsLibrary;

@end

@implementation TSAssetGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (_maximumNumberOfSelection == 0) {
        _maximumNumberOfSelection = 3;
    }
    self.title = @"最近照片";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(dismissPicker)];
    
    _groups = [NSMutableArray array];
    _selectionFilter = [NSPredicate predicateWithValue:YES];
    [self setupGroup];
}
#pragma mark - Not allowed / No assets
- (void)showNotAllowed {
    self.title = nil;
    _groupTableView.tableFooterView = [UIView new];
    UIImageView *padlock = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ZYQAssetPicker.Bundle/Images/AssetsPickerLocked@2x.png"]]];
    padlock.translatesAutoresizingMaskIntoConstraints = NO;
    
    UILabel *title = [UILabel new];
    title.translatesAutoresizingMaskIntoConstraints = NO;
    title.preferredMaxLayoutWidth = 304.0f;
    
    UILabel *message = [UILabel new];
    message.translatesAutoresizingMaskIntoConstraints = NO;
    message.preferredMaxLayoutWidth = 304.0f;
    
    title.text = @"此应用无法使用您的照片或视频。";
    title.font = [UIFont boldSystemFontOfSize:17.0];
    title.textColor = [UIColor colorWithRed:129.0/255.0 green:136.0/255.0 blue:148.0/255.0 alpha:1];
    title.textAlignment = NSTextAlignmentCenter;
    title.numberOfLines = 5;
    
    message.text = @"你可以在「隐私设置」中启用存取。";
    message.font = [UIFont systemFontOfSize:14.0];
    message.textColor = [UIColor colorWithRed:129.0/255.0 green:136.0/255.0 blue:148.0/255.0 alpha:1];
    message.textAlignment = NSTextAlignmentCenter;
    message.numberOfLines = 5;
    
    [title sizeToFit];
    [message sizeToFit];
    
    UIView *centerView = [UIView new];
    centerView.translatesAutoresizingMaskIntoConstraints = NO;
    [centerView addSubview:padlock];
    [centerView addSubview:title];
    [centerView addSubview:message];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(padlock, title, message);
    
    [centerView addConstraint:[NSLayoutConstraint constraintWithItem:padlock attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:centerView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [centerView addConstraint:[NSLayoutConstraint constraintWithItem:title attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:padlock attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [centerView addConstraint:[NSLayoutConstraint constraintWithItem:message attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:padlock attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [centerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[padlock]-[title]-[message]|" options:0 metrics:nil views:viewsDictionary]];
    
    UIView *backgroundView = [UIView new];
    [backgroundView addSubview:centerView];
    [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:centerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:centerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    
    _groupTableView.backgroundView = backgroundView;
}

- (void)showNoAssets {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 90)];
    
    title.backgroundColor = [UIColor clearColor];
    title.text = @"没有照片或视频。";
    title.font = [UIFont systemFontOfSize:26.0];
    title.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
    title.textAlignment = NSTextAlignmentCenter;
    title.numberOfLines = 0;
    
    message.backgroundColor = [UIColor clearColor];
    message.text = @"没有照片或视频。\n您可以使用 iTunes 将照片和视频\n同步到 iPhone。";
    message.font = [UIFont systemFontOfSize:18.0];
    message.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
    message.textAlignment = NSTextAlignmentCenter;
    message.numberOfLines = 0;
    
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
    [centerView addSubview:title];
    [centerView addSubview:message];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [backgroundView addSubview:centerView];
    centerView.center = CGPointMake(backgroundView.frame.size.width/2, backgroundView.frame.size.height/2);
    
    [self.view addSubview:backgroundView];

}
#pragma mark - ALAssetsLibrary
+ (ALAssetsLibrary *)defaultAssetsLibrary {
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}
#pragma mark - 获取相簿
- (void)setupGroup {
    if (!_assetsLibrary) {
        _assetsLibrary = [TSAssetGroupController defaultAssetsLibrary];
    }
    
    if (!_groups) {
        _groups = [NSMutableArray array];
    } else {
        [_groups removeAllObjects];
    }
    
    ALAssetsFilter *assetsFilter = _assetsFilter;
    
    ALAssetsLibraryGroupsEnumerationResultsBlock resultsBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group setAssetsFilter:assetsFilter];
            if (group.numberOfAssets > 0 || _showEmptyGroups) { 
                [_groups addObject:group];
            }
        } else {
            [_groupTableView reloadData];
            _groupTableView.tableFooterView = [UIView new];
            if (_groups.count == 0) {
                [self showNoAssets];
            }
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        [self showNotAllowed];
    };
    
    [_assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                      usingBlock:resultsBlock
                                    failureBlock:failureBlock];
    
    NSUInteger type = ALAssetsGroupLibrary|ALAssetsGroupAlbum|ALAssetsGroupEvent|ALAssetsGroupFaces|ALAssetsGroupPhotoStream;
    
    [_assetsLibrary enumerateGroupsWithTypes:type
                                  usingBlock:resultsBlock
                                failureBlock:failureBlock];
}
#pragma mark - 退出
- (void)dismissPicker {
    if ([_delegate respondsToSelector:@selector(assetPickerControllerDidCancel:)]) {
        [_delegate assetPickerControllerDidCancel:self];
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _groups.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    ALAssetsGroup *group = (ALAssetsGroup *)[_groups objectAtIndex:indexPath.row];
    cell.textLabel.text = [group valueForProperty:ALAssetsGroupPropertyName];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", group.numberOfAssets];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.imageView.image = [[UIImage imageWithCGImage:group.posterImage] thumbImageWithSize:CGSizeMake(90, 90)];
    
    if (_groups.count > 0) {
        NSNumber *groupType = [group valueForProperty:ALAssetsGroupPropertyType];
        if ([groupType unsignedIntegerValue] == ALAssetsGroupSavedPhotos) {
            NSLog(@"相机胶卷");
            
            TSAssetController *asset = [[TSAssetController alloc] init];
            asset.assetGroupController = self;
            asset.assetsGroup = group;
            asset.maximumNumberOfSelection = _maximumNumberOfSelection;
            [self.navigationController pushViewController:asset animated:NO];
        }
    }
    
    group = nil;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TSAssetController *asset = [[TSAssetController alloc] init];
    asset.assetGroupController = self;
    ALAssetsGroup *group = (ALAssetsGroup *)[_groups objectAtIndex:indexPath.row]; 
    asset.assetsGroup = group;
    asset.maximumNumberOfSelection = _maximumNumberOfSelection;
    [self.navigationController pushViewController:asset animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _groupTableView.dataSource = nil;
    _groupTableView.delegate = nil;
    _groupTableView = nil;
    _assetsFilter = nil;
    [_groups removeAllObjects];
    _groups = nil;
    _assetsLibrary = nil;
    NSLog(@"%s", __func__);
}

@end
