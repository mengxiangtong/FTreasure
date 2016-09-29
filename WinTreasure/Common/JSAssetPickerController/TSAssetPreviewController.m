//
//  TSAssetPreviewController.m
//  TSAssetPickerController
//
//  Created by linitial on 15-3-3.
//  Copyright (c) 2015年 linitial. All rights reserved.
//

#import "TSAssetPreviewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface TSAssetPreviewController () <UIScrollViewDelegate>

@property (assign) NSUInteger currentPhotoIndex;
@property (nonatomic) NSMutableArray *sendArray;
@property (nonatomic) UIScrollView *previewScrollView;

@end

@implementation TSAssetPreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _sendArray = [[NSMutableArray alloc] init];
    if (!_selectAssets) {
        _selectAssets = [[NSMutableArray alloc] init];
    } else {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        
        for (id object in _selectAssets) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:object];
            [dict setObject:[NSString stringWithFormat:@"%ld", 10+[_selectAssets indexOfObject:object]] forKey:@"tag"];
            [tempArray addObject:dict];
            dict = nil;
            
            [_sendArray addObject:[NSString stringWithFormat:@"%ld", [_selectAssets indexOfObject:object]]];
        }
        
        _selectAssets = [[NSMutableArray alloc] initWithArray:tempArray];
        
        tempArray = nil;
    }
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAction)];
    [_previewScrollView addGestureRecognizer:tap];
    tap = nil;
    
    CGRect frame = _topView.frame;
    frame.origin.y = 20;
    _topView.frame = frame;
    
    NSMutableArray *array = [NSMutableArray array];
    for (id object in _selectAssets) {
        [array addObject:[object objectForKey:@"asset"]];
    }
    
    CGFloat kPadding = 10;
    frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    frame.origin.x -= kPadding;
    frame.size.width += (2 * kPadding);
    
    if (!_previewScrollView) {
        _previewScrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_previewScrollView];
        [self.view sendSubviewToBack:_previewScrollView];
    }
    
    _previewScrollView.backgroundColor = [UIColor blackColor];
    _previewScrollView.frame = frame;
    _previewScrollView.pagingEnabled = YES;
    _previewScrollView.showsHorizontalScrollIndicator = NO;
    _previewScrollView.showsVerticalScrollIndicator = NO;
    _previewScrollView.delegate = self;
    _previewScrollView.contentSize = CGSizeMake(frame.size.width * array.count, 0);
    
    _numberLabel.text = [NSString stringWithFormat:@"%ld/%ld", _selectAssets.count, _selectAssets.count];
    _currentPhotoIndex = _selectAssets.count-1;
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    _previewScrollView.contentOffset = CGPointMake(_currentPhotoIndex * frame.size.width, 0);
    //预览照片
    for (int i = 0; i < array.count; i++) {
        CGRect bounds = _previewScrollView.bounds;
        CGRect imageViewFrame = bounds;
        imageViewFrame.size.width -= (2 * kPadding);
        imageViewFrame.origin.x = (bounds.size.width * i) + kPadding;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
        ALAsset *asset = (ALAsset *)[array objectAtIndex:i];
        imageView.image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [_previewScrollView addSubview:imageView];
        
        imageView = nil;
    }
    
    [self.view bringSubviewToFront:_topView];
    [self.view bringSubviewToFront:_bottomView];
    
    [_sendButton setTitle:[NSString stringWithFormat:@"发送 (%ld)", _sendArray.count] forState:UIControlStateNormal];
    [_sendButton setTitleColor:kDefaultColor forState:UIControlStateNormal];
    
    _topView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    _bottomView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    
    [_selectButton setTitle:@"" forState:UIControlStateNormal];
    [_selectButton setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    _selectButton.enabled = YES;
    _selectButton.userInteractionEnabled = YES;
}
#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _currentPhotoIndex = _previewScrollView.contentOffset.x / _previewScrollView.frame.size.width;
    
    _selectButton.userInteractionEnabled = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _selectButton.userInteractionEnabled = YES;
    _numberLabel.text = [NSString stringWithFormat:@"%ld/%ld", _currentPhotoIndex+1, _selectAssets.count];
    
    BOOL isExit = NO;
    for (id object in _sendArray) {
        if ([object integerValue] == _currentPhotoIndex && ![object isEqualToString:@""]) {
            isExit = YES;
            break;
        }
    }
    
    if (isExit) {
        [_selectButton setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
    } else {
        [_selectButton setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    }
    
    NSInteger selectedCount = 0;
    for (id object in _sendArray) {
        if (![object isEqualToString:@""]) {
            selectedCount = selectedCount+1;
        }
    }
    
    if (selectedCount > 0) {
        _sendButton.enabled = YES;
        
        [_sendButton setTitle:[NSString stringWithFormat:@"发送 (%ld)", selectedCount] forState:UIControlStateNormal];
    } else {
        _sendButton.enabled = NO;
        
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    }
    
    _selectButton.enabled = YES;
}
#pragma mark - 隐藏控件
- (void)hideAction {
    if (_topView.hidden == NO) {
        _topView.hidden = YES;
        _bottomView.hidden = YES;
    } else {
        _topView.hidden = NO;
        _bottomView.hidden = NO;
    }
}
#pragma mark - 返回
- (IBAction)returnBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 勾选
- (IBAction)selectAction:(id)sender {
    BOOL isExit = NO;
    for (id object in _sendArray) {
        if ([object integerValue] == _currentPhotoIndex && ![object isEqualToString:@""]) {
            isExit = YES;
            break;
        }
    }
    
    if (isExit) {
        [_sendArray replaceObjectAtIndex:_currentPhotoIndex withObject:@""];
        [_selectButton setImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
    } else {
        [_sendArray replaceObjectAtIndex:_currentPhotoIndex withObject:[NSString stringWithFormat:@"%ld", _currentPhotoIndex]];
        [_selectButton setImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateNormal];
    }
    
    NSInteger selectedCount = 0;
    for (id object in _sendArray) {
        if (![object isEqualToString:@""]) {
            selectedCount = selectedCount+1;
        }
    }
    
    if (selectedCount > 0) {
        _sendButton.enabled = YES;
        
        [_sendButton setTitle:[NSString stringWithFormat:@"发送 (%ld)", selectedCount] forState:UIControlStateNormal];
    } else {
        _sendButton.enabled = NO;
        
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    }
}
#pragma mark - 发送
- (IBAction)sendAction:(id)sender {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *array = [NSMutableArray array];
        for (id object in _sendArray) {
            if (![object isEqualToString:@""]) {
                [array addObject:[[_selectAssets objectAtIndex:[object integerValue]] objectForKey:@"asset"]];
            }
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
#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _numberLabel = nil;
    [_selectAssets removeAllObjects];
    _selectAssets = nil;
    [_sendArray removeAllObjects];
    _sendArray = nil;
    _previewScrollView = nil;
    _topView = nil;
    _bottomView = nil;
    _assetGroupController = nil;
    NSLog(@"%s", __func__);
}
@end
