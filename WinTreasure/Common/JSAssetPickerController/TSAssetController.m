//
//  TSAssetController.m
//  TSAssetPickerController
//
//  Created by linitial on 15-3-2.
//  Copyright (c) 2015年 linitial. All rights reserved.
//

#import "TSAssetController.h"
#import "TSAssetPreviewController.h"

@implementation UIImage (TSAssetImageUnitl)
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

@interface TSAssetController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (assign) NSInteger numberOfPhotos;
@property (assign) NSInteger numberOfVideos;
@property (nonatomic) NSMutableArray *selectArray;
@property (weak, nonatomic) IBOutlet UILabel *descriptLabel; 
@property (weak, nonatomic) IBOutlet UICollectionView *assetCollectionView;

@end

@implementation TSAssetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"最近照片";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(dismissPicker)];
     
    [self setupAssets];
    _bottomView.layer.shadowPath =[UIBezierPath bezierPathWithRect:_bottomView.bounds].CGPath;
    
    _bottomView.layer.masksToBounds = NO;
    [_bottomView.layer setShadowOffset:CGSizeMake(0, 0)];
    [_bottomView.layer setShadowRadius:2.0];
    [_bottomView.layer setShadowColor:UIColorHex(0xcccccc).CGColor];
    
    _selectArray = [NSMutableArray array];
    _previewButton.enabled = NO;
    _sendButton.enabled = NO;
    _selectedNoLabel.layer.cornerRadius = CGRectGetHeight(_selectedNoLabel.frame)/2.0;
    _selectedNoLabel.layer.masksToBounds = YES;
    _selectedNoLabel.hidden = YES;
    
    NSDictionary *aAttrs = @{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: UIColorHex(333333)};
    NSMutableAttributedString *desString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"最多%ld张", _maximumNumberOfSelection]];
    [desString addAttributes:aAttrs range:NSMakeRange(0, desString.length)]; 
    _descriptLabel.attributedText = desString; 
    
    _assetCollectionView.backgroundColor = [UIColor whiteColor];
    [_assetCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"AssetCollectionCell"]; 
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - Setup
- (void)setupAssets {
    self.title = [_assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    _numberOfPhotos = 0;
    _numberOfVideos = 0;
    
    if (!_assets) {
        _assets = [[NSMutableArray alloc] init];
    } else {
        [_assets removeAllObjects];
    }
    
    ALAssetsGroupEnumerationResultsBlock resultsBlock = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        if (asset) {
            [_assets addObject:asset];
            
            NSString *type = [asset valueForProperty:ALAssetPropertyType];
            
            if ([type isEqual:ALAssetTypePhoto]) {
                _numberOfPhotos++;
            }
            
            if ([type isEqual:ALAssetTypeVideo]) {
                _numberOfVideos++;
            }
        } else if (_assets.count > 0) {
            /*
            //每行个数
            NSInteger NumPerLine = 4;
            //上下间隙
            CGFloat EdgeDistance = 5;
            //左右间隙
            CGFloat EdgeInterVal = 5;
            //行数
            NSInteger Lines = (_assets.count%NumPerLine == 0) ? (_assets.count/NumPerLine) : (_assets.count/NumPerLine+1);
            //宽高
            CGFloat MoreSize = (kScreenWidth-EdgeInterVal*(NumPerLine+1))/NumPerLine;
            
            // 水平间隔
            CGFloat horizontalInterval = (kScreenWidth-NumPerLine*MoreSize-2*EdgeDistance)/(NumPerLine-1);
            // 上下垂直间隔
            CGFloat verticalInterval = EdgeDistance;
            
            CGFloat maxY = EdgeDistance;
            for (int i = 0; i < Lines; i++) {
                for (int x = 0; x < NumPerLine; x++) {
                    if (i*NumPerLine+x < _assets.count) {
                        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.backgroundColor = [UIColor clearColor];
                        [_assetScrollView addSubview:button];
                        ALAsset *asset = (ALAsset *)[_assets objectAtIndex:i*NumPerLine+x];
                        button.tag = 10+i*NumPerLine+x;
                        [button setFrame:CGRectMake(x*MoreSize+EdgeDistance+x*horizontalInterval, i*MoreSize+i*verticalInterval+EdgeInterVal, MoreSize, MoreSize)];
                        [button setImage:[[UIImage imageWithCGImage:asset.thumbnail] thumbImageWithSize:button.frame.size] forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
                        
                        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, button.frame.size.width, button.frame.size.height)];
                        imageView.tag = button.tag+10;
                        imageView.backgroundColor = [UIColor clearColor];
                        
                        UIImageView *tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.frame.size.width-27, 4, 23, 23)];
                        tipImageView.contentMode = UIViewContentModeScaleAspectFit;
                        tipImageView.image = [UIImage imageNamed:@"未选中.png"];
                        tipImageView.backgroundColor = [UIColor clearColor];
                        tipImageView.tag = 101;
                        [imageView addSubview:tipImageView];
                        tipImageView = nil;
                        
                        [button addSubview:imageView];
                        imageView.userInteractionEnabled = NO;
                        imageView = nil;
                        
                        maxY = CGRectGetMaxY(button.frame);
                        button = nil;
                    }
                }
            }
            
//            NSString *title;
//            if (_numberOfVideos == 0) {
//                title = [NSString stringWithFormat:@"%ld 张照片", (long)_numberOfPhotos];
//            } else if (_numberOfPhotos == 0) {
//                title = [NSString stringWithFormat:@"%ld 部视频", (long)_numberOfVideos];
//            } else {
//                title = [NSString stringWithFormat:@"%ld 张照片, %ld 部视频", (long)_numberOfPhotos, (long)_numberOfVideos];
//            }
//            
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY+8, kScreenWidth, 20)];
//            label.backgroundColor = [UIColor clearColor];
//            label.font = [UIFont systemFontOfSize:12];
//            label.text = title;
//            label.textAlignment = NSTextAlignmentCenter;
//            [_assetScrollView addSubview:label];
//            maxY = CGRectGetMaxY(label.frame);
//            label = nil;
            
             _assetScrollView.contentSize = CGSizeMake(0, maxY+8+49);
             */
        }
    };
     
    [_assetsGroup enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:resultsBlock];
    
    if (_assets.count == 0) {
        [self showNoAssets];
        _bottomView.alpha = 0;
    } else {
        _bottomView.alpha = 1;
    }
}
#pragma mark - 选择
- (void)selectAction:(UIButton *)button {
    BOOL isExit = NO;
    for (id object in _selectArray) {
        if ([[object objectForKey:@"tag"] integerValue] == button.tag) {
            isExit = YES;
            break;
        }
    }
    
    ALAsset *asset = (ALAsset *)[_assets objectAtIndex:button.tag-10];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSString stringWithFormat:@"%ld", button.tag] forKey:@"tag"];
    [dict setObject:asset forKey:@"asset"];
    
    UIImageView *tipImageView = (UIImageView *)[button viewWithTag:101];
    
    if (isExit) {
        [_selectArray removeObject:dict];
        tipImageView.image = [UIImage imageNamed:@"未选中.png"];
    } else {
        if (_selectArray.count < _assetGroupController.maximumNumberOfSelection) {
            [_selectArray addObject:dict];
            tipImageView.image = [UIImage imageNamed:@"选中.png"];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"最多只能选择%ld张图片", _assetGroupController.maximumNumberOfSelection] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
    }
    if (_selectArray.count > 0) {
        _previewButton.enabled = YES;
        _sendButton.enabled = YES;
        _selectedNoLabel.hidden = NO;
        _selectedNoLabel.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:_selectArray.count]];
        NSDictionary *aAttrs = @{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: UIColorHex(0x333333)};
        NSDictionary *redAttrs = @{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: kDefaultColor};
        NSMutableAttributedString *desString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"最多%ld张，已选%@张", _maximumNumberOfSelection, _selectedNoLabel.text]];
        [desString addAttributes:aAttrs range:NSMakeRange(0, 7)];
        [desString addAttributes:redAttrs range:NSMakeRange(7, 1)];
        [desString addAttributes:aAttrs range:NSMakeRange(8, 1)];
        _descriptLabel.attributedText = desString;
//        [_sendButton setTitle:[NSString stringWithFormat:@"完成(%ld)", _selectArray.count] forState:UIControlStateNormal];
    } else {
        _previewButton.enabled = NO;
        _sendButton.enabled = NO;
        _selectedNoLabel.hidden = YES;
        
        NSDictionary *aAttrs = @{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: UIColorHex(0x333333)};
        NSMutableAttributedString *desString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"最多%ld张", _maximumNumberOfSelection]];
        [desString addAttributes:aAttrs range:NSMakeRange(0, desString.length)];
        _descriptLabel.attributedText = desString;
        
//        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    }
}
#pragma mark - Not allowed / No assets
- (void)showNoAssets {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 90)];
    
    title.backgroundColor = [UIColor clearColor];
    title.text = @"没有照片或视频";
    title.font = [UIFont systemFontOfSize:26.0];
    title.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
    title.textAlignment = NSTextAlignmentCenter;
    title.numberOfLines = 0;
    
    message.backgroundColor = [UIColor clearColor];
    message.text = @"您可以使用 iTunes 将照片和视频\n同步到 iPhone。";
    message.font = [UIFont systemFontOfSize:18.0];
    message.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
    message.textAlignment = NSTextAlignmentCenter;
    message.numberOfLines = 0;
    
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
    [centerView addSubview:title];
    [centerView addSubview:message];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [backgroundView addSubview:centerView];
    centerView.center = CGPointMake(backgroundView.frame.size.width/2, backgroundView.frame.size.height/2-40);
    
    [self.view addSubview:backgroundView];
    
    backgroundView = nil;
    title = nil;
    message = nil;
    centerView = nil;
}
#pragma mark - 退出
- (void)dismissPicker {
    if ([_assetGroupController.delegate respondsToSelector:@selector(assetPickerControllerDidCancel:)]) {
        [_assetGroupController.delegate assetPickerControllerDidCancel:_assetGroupController];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 预览
- (IBAction)perviewAction:(id)sender {
    TSAssetPreviewController *preview = [[TSAssetPreviewController alloc] init];
    preview.assetGroupController = _assetGroupController;
    preview.selectAssets = [[NSMutableArray alloc] initWithArray:_selectArray];
    [self.navigationController pushViewController:preview animated:YES];
}
#pragma mark - 发送
- (IBAction)sendAction:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *array = [NSMutableArray array];
        for (id object in _selectArray) {
            [array addObject:[object objectForKey:@"asset"]];
        }
        
        if ([_assetGroupController.delegate respondsToSelector:@selector(assetPickerController:didFinishPickingAssets:)]) {
            [_assetGroupController.delegate assetPickerController:_assetGroupController didFinishPickingAssets:array];
        }
        
        array = nil;
        
       dispatch_async(dispatch_get_main_queue(), ^{
           [self dismissViewControllerAnimated:YES completion:nil];
       });
    });
}
#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _assets.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"AssetCollectionCell" forIndexPath:indexPath];
    
    NSInteger maxCol = 4;
    CGFloat space = 5;
    
    CGFloat width = (kScreenWidth-space*(maxCol+1))/maxCol;
    CGFloat height = width;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [cell addSubview:button];
    ALAsset *asset = (ALAsset *)[_assets objectAtIndex:indexPath.row];
    button.tag = 10+indexPath.row;
    [button setFrame:CGRectMake(0, 0, width, height)];
    [button setImage:[UIImage imageWithCGImage:asset.aspectRatioThumbnail] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    button.imageView.contentMode = UIViewContentModeScaleAspectFill;
    button.clipsToBounds = YES;
    
    UIImageView *tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(button.frame.size.width-27, 4, 23, 23)];
    tipImageView.contentMode = UIViewContentModeScaleAspectFit;
    tipImageView.image = [UIImage imageNamed:@"未选中.png"];
    tipImageView.tag = 101;
    [button addSubview:tipImageView];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger maxCol = 4;
    CGFloat space = 5;
    
    CGFloat width = (kScreenWidth-space*(maxCol+1))/maxCol;
    CGFloat height = width;
    
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _assetsGroup = nil;
    [_assets removeAllObjects];
    _assets = nil;
    [_selectArray removeAllObjects];
    _selectArray = nil;
    _assetGroupController = nil;
    _assetCollectionView = nil;
    _previewButton = nil;
    _sendButton = nil;
    NSLog(@"%s", __func__);
}
@end
