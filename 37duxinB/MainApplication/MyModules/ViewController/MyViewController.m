//
//  MyViewController.m
//  37duxinB
//
//  Created by 37duxin on 02/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "MyViewController.h"
#import "LoginViewController.h"
#import "MyInfoViewController.h"
#import "AccountSettingViewController.h"
#import "MyConsultingServiewVC.h"
#import "CustomerServiceViewController.h"
#import "AboutUsViewController.h"
#import "BalanceViewController.h"
#import "ShConsultantDetailInfoViewController.h"
#import "MyCell.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_infoArray;
    UIImageView *_headerImagView;
    UILabel *_titleLab;
    UIImageView  *_grayRightArrow;
    UIView *_footerView;
    UIButton *_loginoutBtn;
}
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)initData{
    _infoArray =@[@[@{@"image":@"baseInfo",@"title":@"基本信息"},
                    @{@"image":@"setting",@"title":@"账户设置"}],
                  @[@{@"image":@"consultingService",@"title":@"咨询服务"},
                    @{@"image":@"balance",@"title":@"账户余额"},
                    @{@"image":@"customerService",@"title":@"联系客服"},
                    @{@"image":@"aboutUs",@"title":@"关于我们"}]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginUpdate:) name:LOGINUPDATE object:nil];

}

- (void)loginUpdate:(NSNotification *)notification{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadDataForTableViewHeader];
    });
    
}

-(void)reloadDataForTableViewHeader{
    
    NSString *string = FetchToken;
    if (string == nil) {
        [_headerImagView setImage:[UIImage imageNamed:Image(@"defalutIcon")]];
        _titleLab.text =@"咨询师A";
    }
    else{

        [_headerImagView sd_setImageWithURL:[NSURL URLWithString:FetchUserHeaderImage]];
        NSString *realName = FetchRealName;
        if (realName != nil) {
           _titleLab.text = realName;
        }
        
       
    }
    
}

-(void)initUI{

    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView.middleBtn setTitle:@"我的" forState:UIControlStateNormal];
    [self.navView.middleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.navView.middleBtn.titleLabel setFont:FONT_20];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, h(self.navView),SIZE.width,SIZE.height-h(self.navView)) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = [self fetchTableViewHeader];
    _tableView.tableFooterView = [self fetchTableViewFooterView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self reloadDataForTableViewHeader];
    
}

-(UIView *)fetchTableViewHeader{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width,83.0f)];
    view.backgroundColor = [UIColor whiteColor];
    
    _headerImagView= [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 53, 53)];
    _headerImagView.center = CGPointMake(_headerImagView.center.x, view.center.y);
    [_headerImagView setImage:[UIImage imageNamed:Image(@"defalutIcon")]];
    _headerImagView.clipsToBounds = YES;
    _headerImagView.backgroundColor = [UIColor whiteColor];
    [_headerImagView.layer setCornerRadius:h(_headerImagView)/2];
    [view addSubview:_headerImagView];
    
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(left(_headerImagView)+5.0f,0,SIZE.width-105.0f, 14)];
    _titleLab.center = CGPointMake(_titleLab.center.x,_headerImagView.center.y);
    _titleLab.font= [UIFont systemFontOfSize:14.0f];
    _titleLab.textColor = Color_1F1F1F;
    _titleLab.text =@"咨询师A";
    [view addSubview:_titleLab];
    
    _grayRightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(SIZE.width-23, 0, 9, 15)];
    _grayRightArrow.center =CGPointMake(_grayRightArrow.center.x, view.center.y);
    [_grayRightArrow setImage:[UIImage imageNamed:Image(@"grayRightArrow")]];
    [view addSubview:_grayRightArrow];
    
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [view addGestureRecognizer:tap];
    
    return view;
    
}

-(void)tapView{
    
    ShConsultantDetailInfoViewController *vc = [[ShConsultantDetailInfoViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    NSString *userID = [NSString stringWithFormat:@"%@",FetchUserID];
    vc.strID = userID;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(UIView *)fetchTableViewFooterView{
    
    _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width,150)];
    _footerView.backgroundColor = [UIColor whiteColor];
    
    _loginoutBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,SIZE.width,50)];
    _loginoutBtn.center = _footerView.center;
    [_loginoutBtn.layer setBorderColor:Color_F1F1F1.CGColor];
    [_loginoutBtn.layer setBorderWidth:0.5];
    _loginoutBtn.backgroundColor = [UIColor clearColor];
    [_loginoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [_loginoutBtn setTitleColor:Color_FF5166 forState:UIControlStateNormal];
    [_loginoutBtn addTarget:self action:@selector(loginOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [_footerView addSubview:_loginoutBtn];
    return _footerView;
}

-(void)loginOutAction:(UIButton *)btn{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        ClearLoginState;
        if (FetchToken) {
             ClearToken;
        }
       
        ClearTokenType;
        ClearEexpiresIn;
        ClearUserHeaderImage;
        ClearUserSex;
        ClearUserNickName;
        ClearUsername;
        ClearUserRole;
        ClearEMUsername;
        ClearEMPassword;
        ClearRealName;

        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"code", nil];
        NSNotification *notification =[NSNotification notificationWithName:LOGINUPDATE object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    });
    
    LoginViewController *vc = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    
}




-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    return  view;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = Color_F1F1F1;
    return  view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat cellHeader = 0.001f;
    
    if (section == 0) {
        
        cellHeader = 9.0f;
        
    }
    else
    {
        cellHeader = 9.0f;
    }
    
    return cellHeader;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    CGFloat cellFooter = 0.001f;
    
    if (section == 0) {
        
        cellFooter = 0.001f;
    
    }
    else
    {
        cellFooter =0.001f;
    }
    
    return cellFooter;
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _infoArray.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArray = _infoArray[section];
    return sectionArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0f;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *sectionArray = _infoArray[indexPath.section];
    NSDictionary *dic =sectionArray[indexPath.row];
    static NSString *myInfoId = @"myInfoId";
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:myInfoId];
    if (cell == nil) {
        cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myInfoId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.row;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    [cell.imageView setImage:[UIImage imageNamed:Image([dic objectForKey:@"image"])]];
    cell.textLabel.text = [dic objectForKey:@"title"];
    cell.textLabel.font = FONT_15;
    cell.textLabel.textColor = Color_2A2A2A;
    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                MyInfoViewController *vc = [MyInfoViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            case 1:
            {
                AccountSettingViewController *vc = [[AccountSettingViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
                
            default:
                break;
        }
        
    }
    else{
        switch (indexPath.row) {
            case 0:
            {
                MyConsultingServiewVC *vc = [[MyConsultingServiewVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            case 1:
            {
                BalanceViewController *vc = [[BalanceViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            case 2:
            {
                if (FetchToken != nil) {
                    [[EMClient sharedClient] loginWithUsername:FetchEMUsername password:FetchEMPassword];
                }
                CacheChatReceiverAdvatar(CustomServiceAdvatar);
                CustomerServiceViewController *vc = [[CustomerServiceViewController  alloc] initWithConversationChatter:EMCUSTOMERNUMBERT conversationType:EMConversationTypeChat];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            case 3:
            {
                AboutUsViewController *vc =[[AboutUsViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            
                
            default:
                break;
        }
        
        
    }
    
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
