//
//  LocationPickerView.m
//  iLight
//
//  Created by linitial on 5/11/15.
//  Copyright (c) 2015 linitial. All rights reserved.
//

#import "LocationPickerView.h"

@interface LocationPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSInteger _provinceRow,_cityRow,_districtRow;
    NSArray *provinces, *cities, *districts, *streets;
    NSString *version;
}
@property (nonatomic, assign) BOOL showingLocation;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIPickerView *streetPicker;
@property (nonatomic, strong) UIView *moreView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UIView *activityIndicatorBackView;

@property (nonatomic, strong) NSMutableArray *locationArray;
@property (nonatomic, strong) NSMutableArray *datasource;

@property (nonatomic, assign) BOOL isLoadLocal;


@end

@implementation LocationPickerView

- (id)initWithLoadLocal {
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, [AppDelegate getAppDelegate].window.height, [AppDelegate getAppDelegate].window.width, [AppDelegate getAppDelegate].window.height);
        
        _datasource = [NSMutableArray array];
        _isLoadLocal = YES;
        
        _moreView = [self moreView];
        [self setPickerView];
        
        if (!_activityIndicatorView) {
            _activityIndicatorBackView = [[UIView alloc] initWithFrame:_picker.frame];
            _activityIndicatorBackView.backgroundColor = [UIColor whiteColor];
            
            _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            _activityIndicatorView.backgroundColor = [UIColor whiteColor];
            _activityIndicatorView.hidesWhenStopped = YES;
            _activityIndicatorView.center = CGPointMake(_activityIndicatorBackView.frame.size.width/2, _activityIndicatorBackView.frame.size.height/2);
            [_activityIndicatorBackView addSubview:_activityIndicatorView];
            
            [_activityIndicatorView startAnimating];
            
            [self addSubview:_activityIndicatorBackView];
            [self bringSubviewToFront:_activityIndicatorBackView];
            _picker.alpha = 0;
            _streetPicker.alpha = 0;
        }
        [self handleData];
    }
    return self;
}

#pragma mark - 处理数据
- (void)handleData {
    _locationArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LocalProvince" ofType:@"plist"]];

    //处理数据
    [_locationArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LocationModel *provinceModel = [[LocationModel alloc] initWithDictionary:obj];
        [_datasource addObject:provinceModel];
    }];
    provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LocalProvince" ofType:@"plist"]];
    cities = [[provinces objectAtIndex:0] objectForKey:@"CityList"];
    districts = [[cities objectAtIndex:0] objectForKey:@"DistrictList"];
    streets = [[districts objectAtIndex:0] objectForKey:@"StreetList"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self didLoadData];
    });
}

#pragma mark - 数据加载完成
- (void)didLoadData {
    [_picker reloadAllComponents];
    [_streetPicker reloadAllComponents];
    [_activityIndicatorView stopAnimating];
    
    [UIView animateWithDuration:0.4 animations:^{
        _picker.alpha = 1;
        _streetPicker.alpha = 1;
    } completion:^(BOOL finished) {
        [_activityIndicatorBackView removeFromSuperview];
        _activityIndicatorBackView = nil;
        [_activityIndicatorView removeFromSuperview];
        _activityIndicatorView = nil;
    }];
}

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == _streetPicker) {
        return 1;
    } else {
        if (cities.count > 0) {
            if (districts.count > 0) {
                return 3;
            } else {
                return 2;
            }
        } else {
            return 1;
        }
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    if (pickerView == _streetPicker) {
        return streets.count;
    } else {
        if (component == 0) {
            return provinces.count;
        } else if (component == 1) {
            return cities.count;
        } else {
            return districts.count;
        }
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (pickerView == _streetPicker) {
        return pickerView.width;
    } else {
        if (cities.count > 0) {
            if (districts.count > 0) {
                return pickerView.width/3;
            } else {
                return pickerView.width/2;
            }
        } else {
            return pickerView.width;
        }
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.adjustsFontSizeToFitWidth = YES;
    if (pickerView == _streetPicker) {
        label.text = [[streets objectAtIndex:row] objectForKey:@"StreetName"];
        label.frame = CGRectMake(0, 0, _picker.width, 30);
    } else {
        if (cities.count > 0) {
            if (districts.count > 0) {
                if (component == 2) {
                    label.frame = CGRectMake(0, 0, pickerView.width/3-18, 20);
                } else {
                    label.frame = CGRectMake(0, 0, pickerView.width/3-6, 20);
                }
            } else {
                label.frame = CGRectMake(0, 0, pickerView.width/2-10, 20);
            }
        } else {
            label.frame = CGRectMake(0, 0, pickerView.width, 20);
        }
        
        if (component==0) {
          label.text = [[provinces objectAtIndex:row] objectForKey:@"ProviceName"];
        } else if (component==1) {
            label.text = [[cities objectAtIndex:row] objectForKey:@"CityName"];
        } else if (component==2){
            if (cities.count>0) {
                label.text = [[districts objectAtIndex:row] objectForKey:@"DistrictName"];
            }
        }
    }
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == _picker) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            switch (component) {
                case 0: {
                    //市
                    NSArray *tempCityArray = [[provinces objectAtIndex:row] objectForKey:@"CityList"];
                    if (tempCityArray.count > 0) {
                        cities = tempCityArray;
                        //区
                        NSArray *tempDistrictArray = [[cities objectAtIndex:0] objectForKey:@"DistrictList"];
                        if (tempDistrictArray.count > 0) {
                            districts = tempDistrictArray;
                            //街道
                            NSArray *tempStreetArray = [[districts objectAtIndex:0] objectForKey:@"StreetList"];
                            if (tempStreetArray.count > 0) {
                                streets = tempStreetArray;
                            } else {
                                streets = nil;
                            }
                        } else {
                            districts = nil;
                            streets = nil;
                        }
                    } else {
                        cities = nil;
                        districts = nil;
                        streets = nil;
                    }
                }
                    break;
                case 1: {
                    //区
                    NSArray *tempDistrictArray = [[cities objectAtIndex:row] objectForKey:@"DistrictList"];
                    if (tempDistrictArray.count > 0) {
                        districts = tempDistrictArray;
                        
                        //街道
                        NSArray *tempStreetArray = [[districts objectAtIndex:0] objectForKey:@"StreetList"];
                        if (tempStreetArray.count > 0) {
                            streets = tempStreetArray;
                        } else {
                            streets = nil;
                        }
                    } else {
                        districts = nil;
                        streets = nil;
                    }
                }
                    break;
                case 2: {
                    //街道
                    NSArray *tempStreetArray = [[districts objectAtIndex:row] objectForKey:@"StreetList"];
                    if (tempStreetArray.count > 0) {
                        streets = tempStreetArray;
                    } else {
                        streets = nil;
                    }
                }
                    break;
                default:
                    break;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                _picker.dataSource = self;
                [_picker reloadAllComponents];
            });
        });
    }
}
#pragma mark - 隐藏
- (void)hideLocationView {
    if (_showingLocation == NO) {
        _showingLocation = YES;
        [UIView animateWithDuration:0.4 animations:^{
            [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.0]];
            _picker.center = CGPointMake(_picker.centerX, self.height+_picker.height);
            _streetPicker.center = CGPointMake(_streetPicker.centerX, self.height+_streetPicker.height);
            _moreView.center = CGPointMake(_picker.centerX, _picker.centerY-_picker.height/2-_moreView.height/2);
            _activityIndicatorBackView.center = CGPointMake(_activityIndicatorBackView.centerX, self.height+_activityIndicatorBackView.height);
        } completion:^(BOOL finished) {
            self.frame = CGRectMake(0, [AppDelegate getAppDelegate].window.height, [AppDelegate getAppDelegate].window.width, [AppDelegate getAppDelegate].window.height);
            _showingLocation = NO;
        }];
    }
}
#pragma mark - 功能按钮
- (UIView *)moreView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
    UIColor *color = color = UIColorHex(0xeeeeee);
    view.backgroundColor = color;
    
    color = nil;
    color = UIColorHex(333333);
    
    UIFont *font = SYSTEM_FONT(16);
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(8, 5, 50, 30)];
    cancelButton.backgroundColor = view.backgroundColor;
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:color forState:UIControlStateNormal];
    cancelButton.titleLabel.font = font;
    cancelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancelButton];
    cancelButton = nil;
    
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width-58, 5, 50, 30)];
    sureButton.backgroundColor = view.backgroundColor;
    [sureButton setTitleColor:color forState:UIControlStateNormal];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.titleLabel.font = font;
    sureButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:sureButton];
    sureButton = nil;
    
    return view;
}
#pragma mark - 取消
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([[touches anyObject] view] == _moreView) {
        return;
    }
    
    if ([[[touches anyObject] view] isKindOfClass:[UIButton class]] || [[[touches anyObject] view] isKindOfClass:[UIPickerView class]] || [[[touches anyObject] view] isKindOfClass:[UILabel class]]) {
        return;
    }
    
    [self cancelAction];
}

- (void)cancelAction {
    [self hideLocationView];
}
#pragma mark - 确定
- (void)sureAction {
    if (_completeBlock) {
        LocationModel *provinceModel = _datasource[[_picker selectedRowInComponent:0]];
        CityModel *cityModel;
        DistrictModel *districtModel;
        if (provinceModel.cityArray.count>0) {
            cityModel = provinceModel.cityArray[[_picker selectedRowInComponent:1]];
            if (cityModel.districArray.count>0) {
                districtModel = cityModel.districArray[[_picker selectedRowInComponent:2]];
            }
        }
        _completeBlock(provinceModel,cityModel,districtModel);
    }

    [self hideLocationView];
}
#pragma mark - pickerview
- (void)setPickerView {
    if (_picker == nil) {
        _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 216)];
        _picker.dataSource = self;
        _picker.delegate = self;
        _picker.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:_picker];
        [self addSubview:_moreView];
    }
    _picker.center = CGPointMake(_picker.centerX, self.height+_picker.height);
    
    if (_streetPicker == nil) {
        _streetPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 216)];
        _streetPicker.dataSource = self;
        _streetPicker.delegate = self;
        _streetPicker.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:_streetPicker];
    }
    _streetPicker.center = CGPointMake(_streetPicker.centerX, self.height+_streetPicker.height);
    
    _moreView.center = CGPointMake(_picker.centerX, _picker.centerY-_picker.height/2-_moreView.height/2);
}
#pragma mark - 显示pickerview
- (void)show:(LocationCompleteBlock)block {
    if (!_showingLocation) {
        _completeBlock = block;
        _picker.alpha = 1;
        _streetPicker.alpha = 0;
        [_picker reloadAllComponents];
        
        self.frame = CGRectMake(0, 0, [AppDelegate getAppDelegate].window.width, [AppDelegate getAppDelegate].window.height);
        [[AppDelegate getAppDelegate].window addSubview:self];
        
        _showingLocation = YES;
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.0]];
        
        [UIView animateWithDuration:0.6 animations:^{
            [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.6]];
            
            _picker.center = CGPointMake(_picker.centerX, self.height-_picker.height/2);
            _moreView.center = CGPointMake(_picker.centerX, _picker.centerY-_picker.height/2-_moreView.height/2);
            
            if (_activityIndicatorBackView) {
                _activityIndicatorBackView.center = CGPointMake(_activityIndicatorBackView.centerX, self.height-_activityIndicatorBackView.height/2);
            }
        } completion:^(BOOL finished) {
            _showingLocation = NO;
        }];
    }
}

#pragma mark -
- (void)dealloc {
    NSLog(@"%s", __func__);
    _picker.dataSource = nil;
    _picker.delegate = nil;
    _streetPicker.dataSource = nil;
    _streetPicker.delegate = nil;
    _moreView = nil;;
    _activityIndicatorView = nil;
     
    _activityIndicatorBackView = nil;
    
    _completeBlock = nil;
}


@end
