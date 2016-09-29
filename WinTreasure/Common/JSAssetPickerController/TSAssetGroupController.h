//
//  TSAssetGroupController.h
//  TSAssetPickerController
//
//  Created by linitial on 15-3-2.
//  Copyright (c) 2015年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol TSAssetPickerControllerDelegate;

@interface TSAssetGroupController : UIViewController

@property (nonatomic, weak) id <TSAssetPickerControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *groupTableView;
@property (nonatomic) ALAssetsFilter *assetsFilter;
@property (nonatomic) NSPredicate *selectionFilter;
@property (nonatomic, assign) NSInteger maximumNumberOfSelection;
@property (assign) BOOL showEmptyGroups;
@end

@protocol TSAssetPickerControllerDelegate <NSObject>
- (void)assetPickerController:(TSAssetGroupController *)picker didFinishPickingAssets:(NSArray *)assets;
@optional
- (void)assetPickerControllerDidCancel:(TSAssetGroupController *)picker;

@end
//TSAssetGroupController *assetGroup = [[TSAssetGroupController alloc] init];
//UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:assetGroup];
//assetGroup.showEmptyGroups = YES;
//assetGroup.delegate = self;
//assetGroup.maximumNumberOfSelection = 7;
//assetGroup.assetsFilter = [ALAssetsFilter allPhotos];
//[self presentViewController:nav animated:YES completion:NULL];
//assetGroup = nil;
//nav = nil;
