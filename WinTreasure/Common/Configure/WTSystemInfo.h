//
//  WTSystemInfo.h
//  WinTreasure
//
//  Created by Apple on 16/5/31.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef kScreenBounds
#define kScreenBounds [UIScreen mainScreen].bounds
#endif

#ifndef kDefaultColor
#define kDefaultColor [UIColor colorWithHexString:@"D02346"]
#endif

#ifndef kNavigationBarHeight
#define kNavigationBarHeight 64.0
#endif

#ifndef kTabBarHeight
#define kTabBarHeight 49.0
#endif

#ifndef SYSTEM_FONT
#define SYSTEM_FONT(__fontsize__)\
[UIFont systemFontOfSize:__fontsize__]
#endif

#ifndef IMAGE_NAMED
#define IMAGE_NAMED(__imageName__)\
[UIImage imageNamed:__imageName__]
#endif

#ifndef NIB_NAMED
#define NIB_NAMED(__nibName__)\
[UINib nibWithNibName:__nibName__ bundle:nil]
#endif

#ifndef kTreasureIsLogined
#define kTreasureIsLogined @"kTreasureIsLogined"
#endif

@interface WTSystemInfo : NSObject
/**手机号码
 */
+ (BOOL)validateMobile:(NSString *)mobile;

/**密码
 */
+ (BOOL)validatePassword:(NSString *)passWord;

/**验证码
 */
+ (BOOL)validateVerifyCode:(NSString *)verifyCode;

/**昵称
 */
+ (BOOL)validateNickname:(NSString *)nickname;

@end
