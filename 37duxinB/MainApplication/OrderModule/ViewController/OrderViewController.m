//
//  OrderViewController.m
//  37duxinB
//
//  Created by 37duxin on 02/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "OrderViewController.h"
#import "ReservationViewController.h"
#import "ConsultingViewController.h"
#import "OrderTitleView.h"

@interface OrderViewController ()<UIScrollViewDelegate>
{
    CustomNavView *_navView;
    OrderTitleView *_titleView;

}
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    
}

-(void)initData{
   
  
    
}

-(void)initUI{

    self.tabBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setHidden:YES];
    _navView = [[CustomNavView alloc] init];
    _navView.backgroundColor = Color_5DCBF5;
    [_navView.middleBtn setTitle:@"订单" forState:UIControlStateNormal];
    [_navView.middleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_navView.middleBtn.titleLabel setFont:FONT_20];
    [self.view addSubview:_navView];
    
//    __weak typeof(self) weakSelf = self;
//    _titleView = [[OrderTitleView alloc] initWithFrame:CGRectMake(0,h(_navView),SIZE.width, 50) withArray:@[@"深度咨询",@"初次咨询"]];
//    _titleView.indexBlock = ^(NSInteger index) {
//         [weakSelf selectedIndex:index];
//    };
//    [self.view addSubview:_titleView];
//
//    ConsultingViewController *vc0 = [ConsultingViewController new];
//    UINavigationController *nav0 = [[UINavigationController alloc] initWithRootViewController:vc0];
//    nav0.navigationBar.hidden = YES;
//    [self addChildViewController:nav0];
//
//    ReservationViewController *vc = [ReservationViewController new];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    nav.navigationBar.hidden = YES;
//    [self addChildViewController:nav];
//
//    self.selectedIndex = 0;
    
}


-(void)selectedIndex:(NSInteger)idx{
    [self setSelectedIndex:idx];
    NSLog(@"viewControllers==>%@",self.viewControllers);
    
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
