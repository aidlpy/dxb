//
//  Header.h
//  SnackStore
//
//  Created by Albert on 4/20/17.
//  Copyright © 2017 Albert. All rights reserved.
//

#ifndef Header_h
#define Header_h


#define SIZE [UIScreen mainScreen].bounds.size

#define IS_IPHONE_X (SIZE.height == 812.0f)? YES : NO

#define Height_NavContentBar 44.0f

#define Height_StatusBar (IS_IPHONE_X==YES)?44.0f:20.0f

#define Height_NavBar (IS_IPHONE_X==YES)?88.0f: 64.0f

#define Height_TabBar (IS_IPHONE_X==YES)?83.0f: 49.0f

#define IsConsultingMainOrder(status) (status== 10000||status== 1||status== 4)?YES:NO


#define SERVICENUMBER [NSString stringWithFormat:@"4006580180"]
#define Image(name) [NSString stringWithFormat:@"Images.bundle/%@",name]
#define COLOR(string) [UIColor colorWithHexString:string]

/**
 *  成功Code
 */
#define CODE_STATUS_SUCCESS 200
/**
 *  成功 error_code
 */
#define ERRORCODE_STATUS_SUCCESS 0
/**
 *  请求方法
 */
#define REQUEST_METHOD_POST                         @"POST"
#define REQUEST_METHOD_GET                          @"GET"
#define CustomerKEY [NSString stringWithFormat:@"%@",@"kefuchannelimid_329995"]

//拼两个字符串
#define NStringAppending(str1,str2)   [NSString stringWithFormat:@"%@%@",str1,str2]
#define  COLORA(string,alpha) [UIColor colorWithHex:NStringAppending(string,alpha)]
#define  COLOR_ffd5cb COLOR(@"ffd5cb")
#define  COLOR_fdcda5 COLOR(@"fdcda5")
#define  COLOR_333333 COLOR(@"333333")
#define  COLOR_666666 COLOR(@"666666")
#define  COLOR_999999 COLOR(@"999999")
#define  COLOR_f3f4f4 COLOR(@"f3f4f4")
#define  COLOR_cccccc COLOR(@"cccccc")
#define  COLOR_45b640 COLOR(@"45b640")
#define  COLOR_eaeaea COLOR(@"eaeaea")
#define  COLOR_45b640 COLOR(@"45b640")
#define  COLOR_231C16 COLOR(@"231C16")//黑色
#define  COLOR_e77817 COLOR(@"e77817")//橙色
#define  COLOR_F19CA1 COLOR(@"F19CA1")//粉色
#define  COLOR_F9CF00 COLOR(@"F9CF00")//黄色
#define  Color_F2F2F2 COLOR(@"f2f2f2")//灰5
#define  Color_E7405D COLOR(@"E7405D")//粉红色
#define  Color_5DCBF5 COLOR(@"5DCBF5")//tabbarselectedcolor
#define  Color_F1F1F1 COLOR(@"F1F1F1")//cellline
#define  Color_EEEEEE COLOR(@"EEEEEE")//cellline
#define  Color_1F1F1F COLOR(@"1F1F1F")
#define  Color_FFFFFF COLOR(@"FFFFFF")
#define  Color_5ECAF5 COLOR(@"5ECAF5")
#define  Color_5ECAF7 COLOR(@"5ECAF7")
#define  Color_FDA8AF COLOR(@"FDA8AF")
#define  Color_2A2A2A COLOR(@"2A2A2A")
#define  Color_3A3A3A COLOR(@"3A3A3A")
#define  Color_2E2E2E COLOR(@"2E2E2E")
#define  Color_BABABA COLOR(@"BABABA")
#define  Color_F54A5F COLOR(@"F54A5F")
#define  Color_4B4B4B COLOR(@"4B4B4B")
#define  Color_D4D4D4 COLOR(@"D4D4D4")
#define  Color_EBEBEB COLOR(@"EBEBEB")
#define  Color_FE6C7E COLOR(@"FE6C7E")
#define  Color_DCDCDC COLOR(@"DCDCDC")
#define  Color_2A2A2A COLOR(@"2A2A2A")
#define  Color_57CAFA COLOR(@"57CAFA")
#define  Color_FC5268 COLOR(@"FC5268")
#define  Color_FA9E4B COLOR(@"FA9E4B")
#define  Color_FB9F3F COLOR(@"FB9F3F")
#define  Color_E5E5E5 COLOR(@"E5E5E5")
#define  Color_5A5A5A COLOR(@"5A5A5A")
#define  Color_FF5166 COLOR(@"FF5166")
#define  Color_F9A108 COLOR(@"F9A108")
#define  Color_8AD72E COLOR(@"8AD72E")
#define  Color_4C4C4C COLOR(@"4C4C4C")
#define  Color_EB7580 COLOR(@"EB7580")
#define  Color_57CAE7 COLOR(@"57CAE7")
#define  Color_57CAF7 COLOR(@"57CAF7")
#define  Color_CBE3E8 COLOR(@"CBE3E8")
#define  Color_2B2B2B COLOR(@"2B2B2B")
#define  Color_8BBAC4 COLOR(@"8BBAC4")
#define  Color_8D989C COLOR(@"8D989C")




#define A100 @"FF"
#define A95 @"F2"
#define A90 @"E5"
#define A85 @"DB"
#define A80 @"CC"
#define A75 @"BF"
#define A70 @"B2"
#define A65 @"A5"
#define A60 @"99"
#define A55 @"8c"
#define A50 @"7F"
#define A40 @"66"
#define A35 @"59"
#define A30 @"4C"
#define A25 @"3F"
#define A20 @"33"
#define A15 @"21"
#define A10 @"19"
#define A05 @"0C"
#define A00 @"00"

//includeAlpha
#define  COLORA_BALCK95 COLORA(@"000000",@"95")

#import "BaseViewController.h"
#import "UIColor+Category.h"
#import "UIColor+SSToolkitAdditions.h"
#import "UITextField+Category.h"   
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "SDCycleScrollView.h"
#import "HttpsManager.h"
#import "ZSize.h"
#import "SVProgressHUD.h"
#import "CustomNavView.h"
#import "IQKeyboardManager.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "RegularTool.h"
#import "MBProgressHUD.h"
#import "SVHUD.h"
#import "MJRefresh.h"
#import "AAlertView.h"
#import "GCD.h"
#import "UILabel+Category.h"
#import "NSString+Category.h"
#import "CustomTextView.h"
#import "CBImageCompressor.h"
#import <LYEmptyView/LYEmptyViewHeader.h>
#import "UIImage+Category.h"
#import "CWStarRateView.h"
#import "NSString+RegexCategory.h"


#import "UIButton+Sh.h"
#import "LKProtocolNetworkEngine.h"
#import <Masonry.h>
#import "ShProtocolNetworkEngine.h"
#import <LYEmptyView/LYEmptyViewHeader.h>
#import "LKPrecompile.h"

//systemFontOfSize
#define FONT_10 [UIFont systemFontOfSize:10.0f]
#define FONT_11 [UIFont systemFontOfSize:11.0f]
#define FONT_12 [UIFont systemFontOfSize:12.0f]
#define FONT_13 [UIFont systemFontOfSize:13.0f]
#define FONT_14 [UIFont systemFontOfSize:14.0f]
#define FONT_15 [UIFont systemFontOfSize:15.0f]
#define FONT_20 [UIFont systemFontOfSize:20.0f]
#define FONT_25 [UIFont systemFontOfSize:25.0f]
#define FONT_30 [UIFont systemFontOfSize:30.0f]


//LocalCache
//字符
#define USERNAME @"moblie"
#define PASSWORD @"password"
#define TOKEN @"token"
#define TOKENTYPE @"tokentype"
#define REALNAME @"realName"
#define USERID @"userid"
#define AUTOLOGIN @"autologin"
#define DEVICEID @"deviceid"
#define DeviceToKen @"deviceToken"
#define GETUICID @"GETUICID"
#define USERSEX @"sex"
#define USERADDRESS @"address"
#define USEREMAIL @"email"
#define USERINTERGRAL @"intergral"
#define USERLEVEL @"level"
#define REALLYNAME @"realname"
#define USERNICKNAME @"nickname"
#define USERHEDAERIMAGE @"headerImage"
#define EXPIRESININ @"expires_in"
#define USERROLE @"userrole"
#define LOGINEMUSER @"lgoinEMuser"
#define PUSHLOGINVC @"pushloginpushvc"
#define USERAREA @"userarea"
#define CancelPopView @"cancelPopView"
#define ConfrimPopView @"confirmPopView"
#define LOGINUPDATE @"loginUpdate"
#define LOGINSTATE @"loginState"
#define LOGINERROR [NSString stringWithFormat:@"401"]
#define LOGINSUCCESS [NSString stringWithFormat:@"200"]
#define MALE [NSString stringWithFormat:@"1"]
#define FEMALE [NSString stringWithFormat:@"2"]
#define ZERO [NSString stringWithFormat:@"0"]
#define EMUSER @"emuser"
#define EMPASSWORD @"empassword"
#define EMCUSTOMERNUMBERT @"37duxincustomerservice"
#define RECEIVERADVATARIAMGE @"receiver_advatar_image"
#define CustomServiceAdvatar @"https://37duxin.oss-cn-huhehaote.aliyuncs.com/banner/20180224/f8632a910396488b2f13f11415e22faa.png"

//自动登录
#define CacheAutoLoginState(bool) [[NSUserDefaults standardUserDefaults] setBool:bool forKey:AUTOLOGIN]
//是否自动登录
#define FetchAutoLoginState [[NSUserDefaults standardUserDefaults] boolForKey:AUTOLOGIN]

//快速取本地值
#define NSUserDefaultsFetch(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
//快速存值在本地
#define NSUserDefaultsSet(key,value)  [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]
//快速删除
#define NSUserDefalutsDel(key)  [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]
//拼两个字符串
#define NStringAppending(str1,str2)   [NSString stringWithFormat:@"%@%@",str1,str2]
//缓存设备标识
#define CacheDeviceID(value) NSUserDefaultsSet(DEVICEID,value)
//获取设备标识
#define FetchDeviceID NSUserDefaultsFetch(DEVICEID)

//缓存用户名
#define CacheUsername(value) NSUserDefaultsSet(USERNAME,value)
//获取用户名
#define FetchUsername NSUserDefaultsFetch(USERNAME)
//删除用户名
#define ClearUsername NSUserDefalutsDel(USERNAME)

//缓存环信用户名
#define CacheEMUsername(value) NSUserDefaultsSet(EMUSER,value)
//获取环信用户名
#define FetchEMUsername NSUserDefaultsFetch(EMUSER)
//删除环信用户名
#define ClearEMUsername NSUserDefalutsDel(EMUSER)

//缓存密码
#define CachePassword(value) NSUserDefaultsSet(PASSWORD,value)
//获取密码
#define FetchPassword NSUserDefaultsFetch(PASSWORD)
//删除密码
#define ClearPassword NSUserDefalutsDel(PASSWORD)

//缓存环信密码
#define CacheEMPassword(value) NSUserDefaultsSet(EMPASSWORD,value)
//获取环信密码
#define FetchEMPassword NSUserDefaultsFetch(EMPASSWORD)
//删除环信密码
#define ClearEMPassword NSUserDefalutsDel(EMPASSWORD)

//缓存Token
#define CacheToken(value) NSUserDefaultsSet(TOKEN,value)
//获取Token
#define FetchToken NSUserDefaultsFetch(TOKEN)
//删除Token
#define ClearToken NSUserDefalutsDel(TOKEN)

//缓存TokenType
#define CacheTokenType(value) NSUserDefaultsSet(TOKENTYPE,value)
//获取TokenType
#define FetchTokenType NSUserDefaultsFetch(TOKENTYPE)
//删除TokenType
#define ClearTokenType NSUserDefalutsDel(TOKENTYPE)

//缓存登录的状态 200登录成功 401登录失败
#define CacheLoginState(value) NSUserDefaultsSet(LOGINSTATE,value)
//获取登录的状态
#define FetchLoginState NSUserDefaultsFetch(LOGINSTATE)
//删除登录的状态
#define ClearLoginState NSUserDefalutsDel(LOGINSTATE)


//缓存expires_in
#define CacheEexpiresIn(value) NSUserDefaultsSet(EXPIRESININ,value)
//获取expires_in
#define FetchEexpiresIn NSUserDefaultsFetch(EXPIRESININ)
//删除expires_in
#define ClearEexpiresIn NSUserDefalutsDel(EXPIRESININ)

//缓存userid
#define CacheUserID(value) NSUserDefaultsSet(USERID,value)
//获取userid
#define FetchUserID NSUserDefaultsFetch(USERID)
//删除userid
#define ClearUserID NSUserDefalutsDel(USERID)

//缓存用户头像
#define CacheUserNickName(value) NSUserDefaultsSet(USERNICKNAME,value)
//获取用户头像
#define FetchUserNickName NSUserDefaultsFetch(USERNICKNAME)
//删除用户头像
#define ClearUserNickName NSUserDefalutsDel(USERNICKNAME)


//缓存性别
#define CacheUserSex(value) NSUserDefaultsSet(USERSEX,value)
//获取性别
#define FetchUserSex NSUserDefaultsFetch(USERSEX)
//删除性别
#define ClearUserSex NSUserDefalutsDel(USERSEX)

//缓存地址
#define CacheUserAddress(value) NSUserDefaultsSet(USERADDRESS,value)
//获取地址
#define FetchUserAddress NSUserDefaultsFetch(USERADDRESS)
//删除地址
#define ClearUserAddress NSUserDefalutsDel(USERADDRESS)

//缓存地址
#define CacheUserEmail(value) NSUserDefaultsSet(USEREMAIL,value)
//获取地址
#define FetchUserEmail NSUserDefaultsFetch(USEREMAIL)
//删除地址
#define ClearUserEmail NSUserDefalutsDel(USEREMAIL)

//缓存userArea
#define CacheUserArea(value) NSUserDefaultsSet(USERAREA,value)
//获取userArea
#define FetchUserArea NSUserDefaultsFetch(USERAREA)
//删除userArea
#define ClearUserArea NSUserDefalutsDel(USERAREA)

//缓存积分
#define CacheUserIntegral(value) NSUserDefaultsSet(USERINTERGRAL,value)
//获取积分
#define FetchUserIntegral NSUserDefaultsFetch(USERINTERGRAL)
//删除积分
#define ClearUserIntegral NSUserDefalutsDel(USERINTERGRAL)

//缓存等级
#define CacheUserLevel(value) NSUserDefaultsSet(USERLEVEL,value)
//获取等级
#define FetchUserLevel NSUserDefaultsFetch(USERLEVEL)
//删除等级
#define ClearUserLevel NSUserDefalutsDel(USERLEVEL)

//缓存用户头像
#define CacheUserHeaderImage(value) NSUserDefaultsSet(USERHEDAERIMAGE,value)
//获取用户头像
#define FetchUserHeaderImage NSUserDefaultsFetch(USERHEDAERIMAGE)
//删除用户头像
#define ClearUserHeaderImage NSUserDefalutsDel(USERHEDAERIMAGE)

//缓存用户角色
#define CacheUserRole(value) NSUserDefaultsSet(USERROLE,value)
//获取用户角色
#define FetchUserRole NSUserDefaultsFetch(USERROLE)
//删除用户角色
#define ClearUserRole NSUserDefalutsDel(USERROLE)

//缓存聊天对方的头像
#define CacheChatReceiverAdvatar(value) NSUserDefaultsSet(RECEIVERADVATARIAMGE,value)
//获取聊天对方的头像
#define FetchChatReceiverAdvatar NSUserDefaultsFetch(RECEIVERADVATARIAMGE)
//删除聊天对方的头像
#define ClearChatReceiverAdvatar NSUserDefalutsDel(RECEIVERADVATARIAMGE)


//缓存DeviceToken
#define CacheDeviceToken(value) NSUserDefaultsSet(DeviceToKen,value)
//获取DeviceToken
#define FetchDeviceToken NSUserDefaultsFetch(DeviceToKen)
//删除DeviceToken
#define ClearDeviceToken NSUserDefalutsDel(DeviceToKen)

//缓存CID
#define CacheGETUICID(value) NSUserDefaultsSet(GETUICID,value)
//获取CID
#define FetchGETUICID NSUserDefaultsFetch(GETUICID)
//删除CID
#define ClearGETUICID NSUserDefalutsDel(GETUICID)

//缓存真实姓名
#define CacheRealName(value) NSUserDefaultsSet(REALLYNAME,value)
//获取真实姓名
#define FetchRealName NSUserDefaultsFetch(REALLYNAME)
//删除真实姓名
#define ClearRealName NSUserDefalutsDel(REALLYNAME)








#endif /* Header_h */
