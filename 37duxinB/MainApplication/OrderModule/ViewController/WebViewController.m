//
//  WebViewController.m
//  duxin
//
//  Created by Zhang Xinrong on 11/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "WebViewController.h"
#import "ChatWithPaymentVC.h"
#import "LoginViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface WebViewController ()<UIWebViewDelegate>
{
    JSContext *_context;
}
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSMutableURLRequest *requestUrl = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:_urlString]];
    [_webView loadRequest:requestUrl];
}

-(void)initData{
    
    
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];

    _webView =[[UIWebView alloc] initWithFrame:CGRectMake(0, h(self.navView), SIZE.width, SIZE.height-h(self.navView))];
    _webView.delegate =self ;
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@",request.allHTTPHeaderFields);
    
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [SVProgressHUD dismiss];
    __weak typeof(self) weakSelf = self;
    
    //获取js的运行环境
    _context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];

    _context[@"imChat"] = ^(){
        NSArray *args = [JSContext currentArguments];
        [weakSelf pushImChatViewController:args];
    };
    
    _context[@"userLogin"] = ^(){
        [weakSelf userLogin];
    };
    
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self.navView setBackStytle:title rightImage:@"whiteLeftArrow"];
}

-(void)pushImChatViewController:(NSArray *)args{
    
    if (args.count >= 3) {
        
        JSValue *jsurl = args[0];
        JSValue *jschatterID = args[2];
        JSValue *jsfriendNickName = args[1];
        
        CacheChatReceiverAdvatar([jsurl toString]);
        ChatWithPaymentVC *vc = [[ChatWithPaymentVC alloc] initWithConversationChatter:[jschatterID toString] conversationType:EMConversationTypeChat];
        vc.hidesBottomBarWhenPushed = YES;
        vc.friendNickName = [jsfriendNickName toString];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else
    {
        [SVHUD showErrorWithDelay:@"参数缺失" time:0.8f];
    }

    
}

-(void)userLogin{
    
    LoginViewController *vc = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController pushViewController:nav animated:YES];
    
}


-(void)backTo{
    [self.navigationController popViewControllerAnimated:YES];
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
