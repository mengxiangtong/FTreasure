//
//  LocationPickerView.h
//  iLight
//
//  Created by linitial on 5/11/15.
//  Copyright (c) 2015 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"
#import "DistrictModel.h"
#import "StreetModel.h"
#import "LocationModel.h"

typedef void(^LocationCompleteBlock) (LocationModel *provinceModel,
                                      CityModel *cityModel,
                                      DistrictModel *districtModel);

@interface LocationPickerView : UIView

@property (nonatomic, copy) LocationCompleteBlock completeBlock;

- (id)initWithLoadLocal;

- (void)show:(LocationCompleteBlock)block;

@end
