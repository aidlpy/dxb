//
//  ServiceSelectedVC.m
//  37duxinB
//
//  Created by 37duxin on 07/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ServiceSelectedVC.h"
#import "FirstConsultingVC.h"
#import "DeepConsultingVC.h"
@interface ServiceSelectedVC ()

@end

@implementation ServiceSelectedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)initData{
    
    
    
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"服务类型" rightImage:@"whiteLeftArrow"];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0,h(self.navView)+122,105.0f, 105.0f)];
    btn.center = CGPointMake(SIZE.width/2,btn.center.y);
    [btn setImage:[UIImage imageNamed:Image(@"firstConsulting")] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(firstAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0,bottom(btn)+42,105.0f, 105.0f)];
    btn1.center = CGPointMake(SIZE.width/2,btn1.center.y);
    [btn1 setImage:[UIImage imageNamed:Image(@"deepConsulting")] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(deepAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,SIZE.height-88, 20, 20)];
    cancelBtn.center = CGPointMake(SIZE.width/2, cancelBtn.center.y);
    [cancelBtn setImage:[UIImage imageNamed:Image(@"closeBtn")] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
}

-(void)firstAction:(UIButton *)sender{
    
    FirstConsultingVC *vc= [FirstConsultingVC new];
    vc.hidesBottomBarWhenPushed  = YES;
    vc.isEdit = NO;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)deepAction:(UIButton *)sender{
    
    DeepConsultingVC *vc = [DeepConsultingVC new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.isEdit = NO;
    [self.navigationController  pushViewController:vc animated:YES];

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
