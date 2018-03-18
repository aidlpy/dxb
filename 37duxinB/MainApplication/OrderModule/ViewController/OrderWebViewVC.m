//
//  OrderWebViewVC.m
//  37duxinB
//
//  Created by Zhang Xinrong on 28/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "OrderWebViewVC.h"
#import "WebViewController.h"
#import "LoginViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface OrderWebViewVC ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    BOOL _isFirstLoad;
    NSMutableArray *_urlArray;
    JSContext *_context;
    
}
@end

static NSString *urlString = @"https://bside.37du.xin/";

@implementation OrderWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)initData{
    _isFirstLoad = YES;
    _urlArray = [[NSMutableArray alloc] initWithCapacity:0];
}

-(void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView.middleBtn setTitle:@"订单" forState:UIControlStateNormal];
    [self.navView.middleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.navView.middleBtn.titleLabel setFont:FONT_20];
    
    CGFloat tabbarHeight = Height_TabBar;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,h(self.navView),SIZE.width,SIZE.height-h(self.navView)-tabbarHeight)];
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
    
    [SVProgressHUD show];

    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    [request setURL:url];
    [_webView loadRequest:request];
}

-(void)saveCookies {
    
    

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *usertoken =FetchToken;
    NSString *userid =FetchUserID;
    NSDictionary *dic = @{@"token":usertoken,@"userid":userid};
    NSLog(@"usertoken==>%@userid==>%@",usertoken,userid);
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 设定 cookie
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:
                                [NSDictionary dictionaryWithObjectsAndKeys:
                                 [request.URL host], NSHTTPCookieDomain,
                                 [request.URL path], NSHTTPCookiePath,
                                 key,NSHTTPCookieName,
                                 obj,NSHTTPCookieValue,
                                 nil]];
        
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        NSLog(@"cookie = %@",cookie);
    }];
    
    if (_isFirstLoad) {
        _isFirstLoad = !_isFirstLoad;
        return YES;
    }
    else
    {
        WebViewController *webViewVC = [[WebViewController alloc] init];
        webViewVC.urlString = request.URL.absoluteString;
        webViewVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webViewVC animated:YES];
        _isFirstLoad = !_isFirstLoad;
        return NO;
        
    }

}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
    [SVProgressHUD dismiss];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{

    [SVProgressHUD dismiss];
    
    NSArray *nCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];

    NSLog(@"%@",nCookies);
    
    
    __weak typeof(self) weakSelf = self;

    //获取js的运行环境
    _context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];

    //html调用无参数OC
    _context[@"userLogin"] = ^(){
        [weakSelf userLogin];
    };

//    _context[@"customerService"] = ^(){
//        NSArray *args = [JSContext currentArguments];
//        NSString *typeString = args[0];
//        [weakSelf customerService:typeString];
//    };
    
    
}

-(void)userLogin{
    
    LoginViewController *vc = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController pushViewController:nav animated:YES];
    
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
