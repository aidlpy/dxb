//
//  LoginViewController.m
//  37duxinB
//
//  Created by 37duxin on 05/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "LoginViewController.h"
#import "ApplyViewController.h"
#import "ForgotPsViewController.h"
#import "MainTabbarVC.h"
#import "LoginView.h"
#import "DemoCallManager.h"
#import "SelectingAreaView.h"


@interface LoginViewController ()
{
    NSArray *_dataArray;
    NSMutableArray *_loginViewArray;
    UIButton *_loginBtn;
    UIButton *_applyBtn;
    UIButton *_forgotpsBtn;

    
    
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
    
}

-(void)initData{

    _loginViewArray = [[NSMutableArray alloc] init];
    _dataArray = @[@{@"logo":@"mobileLogo",@"placeHolder":@"请输入手机号"},@{@"logo":@"passwordLogo",@"placeHolder":@"请输入密码"}];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [SVProgressHUD dismiss];
}


-(void)initUI{

    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView.middleBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.navView.middleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.navView.middleBtn.titleLabel setFont:FONT_20];
    
    [_dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dic = (NSDictionary *)obj;
        CGFloat viewHeight = 50.0f;
        CGFloat pedding = 8.5f;
        LoginView *loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, h(self.navView)+pedding+idx*viewHeight, SIZE.width, viewHeight)];
        [loginView setLogoImageView:dic[@"logo"] setPlaceHolder:dic[@"placeHolder"]];
        if (idx == 0) {
            loginView.textField.keyboardType = UIKeyboardTypePhonePad;
        }
        if (idx == 1) {
            loginView.textField.secureTextEntry = YES;
            loginView.passwordBtn.hidden = NO;
        }
        loginView.codeBlock = ^(JKCountDownButton *sendeer) {nil;};
        [self.view addSubview:loginView];
        [_loginViewArray addObject:loginView];
        
    }];
    
    _forgotpsBtn = [[UIButton alloc] initWithFrame:CGRectMake(SIZE.width-80,bottom(_loginViewArray.lastObject)+13,60,10)];
    [_forgotpsBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_forgotpsBtn setTitleColor:Color_F54A5F forState:UIControlStateNormal];
    _forgotpsBtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    [_forgotpsBtn addTarget:self action:@selector(fogotPsAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgotpsBtn];
    
    _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, bottom(_loginViewArray.lastObject)+48,SIZE.width-80,40)];
    _loginBtn.backgroundColor = Color_5ECAF5;
    [_loginBtn.layer setCornerRadius:2.0f];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginAciton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    _applyBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, bottom(_loginBtn)+20,SIZE.width-80,40)];
    _applyBtn.backgroundColor = Color_5ECAF5;
    [_applyBtn.layer setCornerRadius:2.0f];
    [_applyBtn setTitle:@"申请入驻" forState:UIControlStateNormal];
    [_applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_applyBtn addTarget:self action:@selector(applyAciton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_applyBtn];
    
}

-(void)fogotPsAction:(UIButton *)sender{
    
    ForgotPsViewController *vc = [[ForgotPsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



-(void)loginAciton:(UIButton *)loginBtn{
    [self checkInputType];
}

-(void)checkInputType{
    
    NSString *cellPhone = ((LoginView *)(_loginViewArray[0])).textField.text;
    NSString *password = ((LoginView *)(_loginViewArray[1])).textField.text;
    
    if ([cellPhone isMobileNumber]){
        
        if ([RegularTool matchPassword:password]) {
            [SVProgressHUD show];
            [self postUser];
        }
        else
        {
            
            [SVHUD showErrorWithDelay:@"请输入正确的密码！" time:0.8];
        }
        
    }
    else
    {
        [SVHUD showErrorWithDelay:@"请输入正确的手机号码！" time:0.8];
        
    }
    
}

-(void)postUser{
    
    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"password" forKey:@"grant_type"];
    [dic setValue:((LoginView *)(_loginViewArray[0])).textField.text forKey:@"username"];
    [dic setValue:((LoginView *)(_loginViewArray[1])).textField.text forKey:@"password"];
    [dic setValue:@"testclient" forKey:@"client_id"];
    [dic setValue:@"testpass" forKey:@"client_secret"];
    [dic setValue:@"application/x-www-form-urlencoded" forKey:@"Content-Type"];
    NSString *usercid = FetchGETUICID;
    NSLog(@"deviceToken==>%@",usercid);
    [dic setValue:usercid forKey:@"device_id"];
    [dic setValue:@"1" forKey:@"type"];
    [httpsManager postServerAPI:FetchLogin deliveryDic:dic successful:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            if ([[dic objectForKey:@"code"] integerValue] == 200) {
                

                NSDictionary *dataDic = [dic objectForKey:@"data"];
                CacheToken([dataDic objectForKey:@"access_token"]);
                CacheTokenType( [dataDic objectForKey:@"token_type"]);
                CacheEexpiresIn([dataDic objectForKey:@"expires_in"]);
                CacheLoginState(LOGINSUCCESS);
                
                [self fetchUserInfo];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVHUD showSuccessWithDelay:@"登录成功！" time:0.8 blockAction:^{
                       
                        MainTabbarVC *vc = [[MainTabbarVC alloc] init];
                        [[DemoCallManager sharedManager] setMainController:vc];
                        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                        [nav.navigationBar setHidden:YES];
                        [self presentViewController:nav animated:YES completion:nil];
                        
                    }];
                });
                
            }
            else if([[dic objectForKey:@"code"] integerValue] == 401){
                CacheLoginState(LOGINERROR);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVHUD showErrorWithDelay:@"登录失败！" time:0.8];
                });
            }
            else{ [SVProgressHUD dismiss];}
        });
        
    } fail:^(id error) {
        [SVHUD showErrorWithDelay:@"登录失败！" time:0.8];
    }];
    
    
}

-(void)fetchUserInfo{
    
    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [httpsManager getServerAPI:FetchUserInfo deliveryDic:dic successful:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSDictionary *dic = (NSDictionary *)responseObject;
            if ([[dic objectForKey:@"code"] integerValue] == 200) {
                
                NSDictionary *dicData = [[dic objectForKey:@"data"] objectForKey:@"result"];
                NSString *headerImageStr = [dicData objectForKey:@"avatar"];
                NSString *areaString = [dicData objectForKey:@"area"];
                CacheUserArea(areaString);
                if (![headerImageStr isEqual:[NSNull null]]) {
                    CacheUserHeaderImage(headerImageStr);
                }
                NSString *genderStr = [NSString stringWithFormat:@"%@",[dicData objectForKey:@"gender"]];
                CacheUserSex(genderStr);
                CacheUserNickName([dicData objectForKey:@"nickname"]);
                CacheUsername([dicData objectForKey:@"username"]);
                CacheUserRole([dicData objectForKey:@"role"]);
                CacheUserID([dicData objectForKey:@"id"]);
                NSString *emusername = [dicData objectForKey:@"emchart_username"];
                NSString *empassword = [dicData objectForKey:@"emchart_password"];
                NSString *realName = [dicData objectForKey:@"name"];
                NSString *userid = [dicData objectForKey:@"id"];
                CacheUserID(userid);
                CacheEMUsername(emusername);
                CacheEMPassword(empassword);
                CacheRealName(realName);
                
                
                NSNotification *notification =[NSNotification notificationWithName:LOGINUPDATE object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                
                NSNotification *notifyEMLogin =[NSNotification notificationWithName:LOGINEMUSER object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notifyEMLogin];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
//                    MainTabbarVC *vc = [[MainTabbarVC alloc] init];
//                    [self.navigationController pushViewController:vc animated:YES];
                    
                });
                
            }
            else if([[dic objectForKey:@"code"] integerValue] == 401){
                NSLog(@"fetchUserInfoFailure==>%@",responseObject);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [SVProgressHUD showErrorWithStatus:@"请重新登录!"];
                });
            }
            else{ [SVProgressHUD dismiss];}
        });
        
    } fail:^(id error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败!"];
    }];
}

-(void)applyAciton:(UIButton *)sender{
    
    ApplyViewController *vc = [ApplyViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)dealloc
{
    //移除登录更新通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LOGINUPDATE object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LOGINEMUSER object:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
