//
//  RecieverInformation.m
//  WinTreasure
//
//  Created by Apple on 16/6/28.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "RecieverInformation.h"
#import "LocationPickerView.h"
#import "IQTextView.h"
#import "AddressModel.h"

@interface RecieverInformation ()

@property (nonatomic, strong) UITextField *recieverField;

@property (nonatomic, strong) UITextField *phoneField;

@property (nonatomic, strong) IQTextView *addressTextView;

@property (nonatomic, strong) UIButton *addressButton;

@property (nonatomic, strong) UISwitch *defaultSwitch;

@property (nonatomic, strong) LocationPickerView *pickerView;

@end

const CGFloat kTextFieldPadding = 10.0;

@implementation RecieverInformation

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        YYLabel *recieverLabel = [YYLabel new];
        recieverLabel.origin = CGPointMake(kRecieverInformationPadding, kRecieverInformationMargin);
        recieverLabel.size = CGSizeMake(100, 20);
        recieverLabel.font = SYSTEM_FONT(18);
        recieverLabel.textColor = UIColorHex(333333);
        recieverLabel.text = @"收货人";
        [recieverLabel sizeToFit];
        [self addSubview:recieverLabel];

        CAShapeLayer *lineOne = [CAShapeLayer layer];
        lineOne.origin = CGPointMake(kRecieverInformationPadding/2.0, recieverLabel.bottom+kRecieverInformationMargin);
        lineOne.size = CGSizeMake(kScreenWidth-kRecieverInformationPadding/2.0, CGFloatFromPixel(1));
        lineOne.backgroundColor = UIColorHex(0xeeeeee).CGColor;
        [self.layer addSublayer:lineOne];

        YYLabel *phoneLabel = [YYLabel new];
        phoneLabel.origin = CGPointMake(kRecieverInformationPadding, lineOne.bottom+kRecieverInformationMargin);
        phoneLabel.size = CGSizeMake(100, 20);
        phoneLabel.font = SYSTEM_FONT(18);
        phoneLabel.textColor = UIColorHex(333333);
        phoneLabel.text = @"手机号码";
        [phoneLabel sizeToFit];
        [self addSubview:phoneLabel];

        _phoneField = [[UITextField alloc]initWithFrame:({
            CGRect rect = {phoneLabel.right+kTextFieldPadding,lineOne.bottom+kRecieverInformationMargin,kScreenWidth-recieverLabel.right-2*kTextFieldPadding,20};
            rect;
        })];
        _phoneField.attributedPlaceholder = [self placeholder:@"手机号码"];
        _phoneField.font = SYSTEM_FONT(18);
        _phoneField.textColor = UIColorHex(333333);
        [self addSubview:_phoneField];
        _phoneField.centerY = phoneLabel.centerY;

        _recieverField = [[UITextField alloc]initWithFrame:({
            CGRect rect = {phoneLabel.right+kTextFieldPadding,kRecieverInformationMargin,kScreenWidth-phoneLabel.right-2*kTextFieldPadding,20};
            rect;
        })];
        _recieverField.attributedPlaceholder = [self placeholder:@"收货人"];
        _recieverField.font = SYSTEM_FONT(18);
        _recieverField.textColor = UIColorHex(333333);
        [self addSubview:_recieverField];
        _recieverField.centerY = recieverLabel.centerY;

        CAShapeLayer *lineTwo = [CAShapeLayer layer];
        lineTwo.origin = CGPointMake(kRecieverInformationPadding/2.0, phoneLabel.bottom+kRecieverInformationMargin);
        lineTwo.size = CGSizeMake(kScreenWidth-kRecieverInformationPadding/2.0, CGFloatFromPixel(1));
        lineTwo.backgroundColor = UIColorHex(0xeeeeee).CGColor;
        [self.layer addSublayer:lineTwo];
        
        YYLabel *proviceLabel = [YYLabel new];
        proviceLabel.origin = CGPointMake(kRecieverInformationPadding, lineTwo.bottom+kRecieverInformationMargin);
        proviceLabel.size = CGSizeMake(100, 20);
        proviceLabel.font = SYSTEM_FONT(18);
        proviceLabel.textColor = UIColorHex(333333);
        proviceLabel.text = @"省市区";
        [proviceLabel sizeToFit];
        [self addSubview:proviceLabel];

        CAShapeLayer *lineThree = [CAShapeLayer layer];
        lineThree.origin = CGPointMake(kRecieverInformationPadding/2.0, proviceLabel.bottom+kRecieverInformationMargin);
        lineThree.size = CGSizeMake(kScreenWidth-kRecieverInformationPadding/2.0, CGFloatFromPixel(1));
        lineThree.backgroundColor = UIColorHex(0xeeeeee).CGColor;
        [self.layer addSublayer:lineThree];
        
        _addressButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addressButton.origin = CGPointMake(phoneLabel.right+kTextFieldPadding, lineTwo.bottom+kRecieverInformationMargin);
        _addressButton.size = CGSizeMake(kScreenWidth-phoneLabel.right-2*kTextFieldPadding,40);
        _addressButton.titleLabel.font = SYSTEM_FONT(18);
        _addressButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_addressButton setTitle:@"请选择" forState:UIControlStateNormal];
        [_addressButton setTitleColor:UIColorHex(666666) forState:UIControlStateNormal];
        [_addressButton addTarget:self action:@selector(chooseAddress) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addressButton];
        _addressButton.centerY = proviceLabel.centerY;

        YYLabel *addressLabel = [YYLabel new];
        addressLabel.origin = CGPointMake(kRecieverInformationPadding, lineThree.bottom+kRecieverInformationMargin);
        addressLabel.size = CGSizeMake(100, 20);
        addressLabel.font = SYSTEM_FONT(18);
        addressLabel.textColor = UIColorHex(333333);
        addressLabel.text = @"详细地址";
        [addressLabel sizeToFit];
        [self addSubview:addressLabel];

        _addressTextView = [IQTextView new];
        _addressTextView.origin = CGPointMake(phoneLabel.right+kTextFieldPadding, lineThree.bottom+kRecieverInformationMargin-10);
        _addressTextView.size = CGSizeMake(kScreenWidth-phoneLabel.right-2*kTextFieldPadding, 120);
        _addressTextView.placeholder = @"详细地址";
        _addressTextView.font = SYSTEM_FONT(18);
        _addressTextView.textColor = UIColorHex(333333);
        [self addSubview:_addressTextView];
        
        CAShapeLayer *lineFour = [CAShapeLayer layer];
        lineFour.origin = CGPointMake(kRecieverInformationPadding/2.0, _addressTextView.bottom+kRecieverInformationMargin);
        lineFour.size = CGSizeMake(kScreenWidth-kRecieverInformationPadding/2.0, CGFloatFromPixel(1));
        lineFour.backgroundColor = UIColorHex(0xeeeeee).CGColor;
        [self.layer addSublayer:lineFour];
        
        YYLabel *defaultLabel = [YYLabel new];
        defaultLabel.origin = CGPointMake(kRecieverInformationPadding, lineFour.bottom+kRecieverInformationMargin);
        defaultLabel.size = CGSizeMake(200, 20);
        defaultLabel.font = SYSTEM_FONT(18);
        defaultLabel.textColor = UIColorHex(333333);
        defaultLabel.text = @"设置为默认地址";
        [defaultLabel sizeToFit];
        [self addSubview:defaultLabel];

        _defaultSwitch = [[UISwitch alloc]init];
        _defaultSwitch.right = kScreenWidth-kRecieverInformationMargin;
        _defaultSwitch.centerY = defaultLabel.centerY;
        [_defaultSwitch addTarget:self action:@selector(setDefaultAddress) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_defaultSwitch];
        
    }
    return self;
}

- (void)chooseAddress {
    if (!_pickerView) {
        _pickerView = [[LocationPickerView alloc]initWithLoadLocal];
    }
    @weakify(self);
    [_pickerView show:^(LocationModel *provinceModel,
                       CityModel *cityModel,
                       DistrictModel *districtModel) {
        @strongify(self);
        NSString *location = [NSString stringWithFormat:@"%@%@%@",provinceModel.locationName,cityModel.CityName,districtModel.DistrictName];
        NSLog(@"%@",location);
        if (self.locationBlock) {
            self.locationBlock(location);
            [self.addressButton setTitle:location forState:UIControlStateNormal];
        }
    }];
}

- (void)setDefaultAddress {
    
}

- (NSMutableAttributedString *)placeholder:(NSString *)name {
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:name];
    placeholder.font = SYSTEM_FONT(18);
    placeholder.color = UIColorHex(666666);
    return placeholder;
}

- (void)setModel:(AddressModel *)model {
    _model = model;
    _recieverField.text = _model.name;
    _phoneField.text = _model.phone;
    _addressTextView.text = _model.address;
    self.height = _defaultSwitch.bottom + kRecieverInformationMargin;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
