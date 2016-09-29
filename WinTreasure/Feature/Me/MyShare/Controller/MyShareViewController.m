//
//  MyShareViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/24.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "MyShareViewController.h"
#import "ShareTextView.h"
#import "ShareContentView.h"
#import "TSAssetGroupController.h"

@interface MyShareViewController () <UIActionSheetDelegate,TSAssetPickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    BOOL _isAddImage;
}
@property (nonatomic, assign) NSInteger maxImageCount;

@property (nonatomic, assign) NSInteger currentImageIndex;

@property (nonatomic, strong) NSMutableArray *selectImageArray;

@property (nonatomic, strong) ShareTextView *textView;

@property (nonatomic, strong) ShareContentView *contentView;

@end

@implementation MyShareViewController

- (NSMutableArray *)selectImageArray {
    if (!_selectImageArray) {
        _selectImageArray = [NSMutableArray array];
    }
    return _selectImageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"晒单";
    [self commonInit];
}

- (void)commonInit {
    [self initTextView];
    [self initShareView];
    [self initSubmitButton];
}

- (void)initTextView {
    self.view.backgroundColor = UIColorHex(0xF6F6F6);
    _textView = [[ShareTextView alloc]initWithFrame:({
        CGRect rect = {0,kNavigationBarHeight+15,kScreenWidth,160};
        rect;
    })];
    [self.view addSubview:_textView];
}

- (void)initShareView {
    _maxImageCount = 3;
    _contentView = [[ShareContentView alloc]initWithFrame:({
        CGRect rect = {0,_textView.bottom+15,kScreenWidth,100};
        rect;
    })];
    [self.view addSubview:_contentView];
    @weakify(self);
    _contentView.addSharingImage = ^{
        @strongify(self);
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择",nil];
        [actionSheet showInView:self.view];
    };
}

- (void)initSubmitButton {
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = ({
        CGRect rect = {15,kScreenHeight-30-44,kScreenWidth-15*2,44};
        rect;
    });
    submitButton.layer.cornerRadius = 4.0;
    submitButton.backgroundColor = kDefaultColor;
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}

- (void)submit {
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (![[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"取消"]) {
        if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"拍照"]) {
            UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
            pickerController.navigationBar.tintColor = [UIColor blackColor];
            [pickerController setDelegate:self];
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
                [pickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
                [pickerController setCameraDevice:UIImagePickerControllerCameraDeviceRear];
            } else {
                [pickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            }
            [self presentViewController:pickerController animated:YES completion:nil];
        } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"从相册选择"]) {
            TSAssetGroupController *assetGroup = [[TSAssetGroupController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:assetGroup];
            assetGroup.showEmptyGroups = NO;
            assetGroup.delegate = self;
            assetGroup.maximumNumberOfSelection = _maxImageCount-_currentImageIndex;
            assetGroup.assetsFilter = [ALAssetsFilter allPhotos];
            [self presentViewController:nav animated:YES completion:nil];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TSAssetPickerControllerDelegate
- (void)assetPickerController:(TSAssetGroupController *)picker didFinishPickingAssets:(NSArray *)assets {
    if (_isAddImage) {
        return;
    }
    _isAddImage = YES;
    
    NSArray *array = [assets subarrayWithRange:NSMakeRange(0, assets.count)];
    if (assets.count > 3) {
        array = [assets subarrayWithRange:NSMakeRange(0, 3)];
    }
    
    CGFloat imgView_X = 0.0;
    CGFloat imgSpace = 15.0, margin = 10.0;
    
    CGFloat startX = _currentImageIndex*(kShareImageWidth+imgSpace);
    
    for (int i=0; i<array.count; i++) {
        ALAsset *asset = array[i];
        UIImage *orgImage = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        imgView_X = margin+i*(kShareImageWidth+imgSpace);
        
        if (orgImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(startX+imgView_X, CGRectGetMinY(_contentView.picImageView.frame), kShareImageWidth, kShareImageWidth)];
                imgView.contentMode = UIViewContentModeScaleAspectFill;
                imgView.clipsToBounds = YES;
                imgView.image = orgImage;
                imgView.backgroundColor = [UIColor redColor];
                [self.selectImageArray addObject:orgImage];
                imgView.tag = 10+i+_currentImageIndex;
                [_contentView addSubview:imgView];
                
                imgView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
                [imgView addGestureRecognizer:tap];
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                button.frame = CGRectMake(imgView.right-17, imgView.origin.y-5, 24, 24);
                [button setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
                [_contentView addSubview:button];
                button.tag = 1000+i+_currentImageIndex;
                [button addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
            });
        }
        
        if (i == array.count-1) {
            _isAddImage = NO;
            dispatch_async(dispatch_get_main_queue(), ^{
                _currentImageIndex = _currentImageIndex+assets.count;
                if (_currentImageIndex < _maxImageCount) {
                    CGRect cameraBtnRect = _contentView.picImageView.frame;
                    cameraBtnRect.origin.x = margin+_currentImageIndex*(kShareImageWidth+imgSpace);
                    _contentView.picImageView.frame = cameraBtnRect;
                    _contentView.picImageView.hidden = NO;
                } else {
                    _contentView.picImageView.hidden = YES;
                }
            });
        }
    }
}

#pragma mark - delete selected image
- (void)deleteImage:(UIButton *)sender {
    NSInteger tag = sender.tag-1000;
    [sender removeFromSuperview];
    
    UIImageView *imageView = (UIImageView *)[_contentView viewWithTag:tag+10];
    [imageView removeFromSuperview];
//    NSLog(@"_currentImageIndex %@", [NSNumber numberWithInteger:_currentImageIndex]);
    [_selectImageArray removeObjectAtIndex:tag];
    _currentImageIndex = _currentImageIndex-1;
        
    __block CGFloat imgView_X = 0.0;
    CGFloat imgSpace = 15.0, margin = 10.0;
    
    NSMutableArray *array = [NSMutableArray array];
    for (UIView *view in _contentView.subviews) {
        if (view.tag < 1000 && view.tag >= 10 &&
            [view isKindOfClass:[UIImageView class]]) {
            [array addObject:view];
        }
    }
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIImageView *imgView = (UIImageView *)obj;
        imgView_X = margin+idx*(kShareImageWidth+imgSpace);
        imgView.frame = CGRectMake(imgView_X, _contentView.picImageView.frame.origin.y, kShareImageWidth, kShareImageWidth);
        UIButton *btn = (UIButton *)[_contentView viewWithTag:(imgView.tag-10+1000)];
        btn.frame = CGRectMake(imgView.right-17, imgView.origin.y-5, 24, 24);
        imgView.tag = 10+idx;
        btn.tag = 1000+idx;
    }];
    
    if (_currentImageIndex < _maxImageCount) {
        CGRect cameraBtnRect = _contentView.picImageView.frame;
        cameraBtnRect.origin.x = margin+_currentImageIndex*(kShareImageWidth+imgSpace);
        _contentView.picImageView.frame = cameraBtnRect;
        _contentView.picImageView.hidden = NO;
    } else {
        _contentView.picImageView.hidden = YES;
    }
}

#pragma mark -  click selected image
- (void)imageClick:(UITapGestureRecognizer *)tap {
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}


@end
