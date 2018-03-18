//
//  OrderDetailViewController.m
//  37duxinB
//
//  Created by Zhang Xinrong on 13/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailCell.h"
#import "OrderTagsCell.h"

@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIImageView *_headerImageView;
    UILabel *_userLabel;
    UILabel *_sexLabel;
    NSArray *_titleArray;
    NSMutableArray *_section0Array;
    NSMutableArray *_section1Array;

}
@end

@implementation OrderDetailViewController

-(void)fetchData{
    
    HttpsManager *httpManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",FetchBReservationOrderDetail,_idString];
    [httpManager getServerAPI:urlString deliveryDic:dic successful:^(id responseObject) {
        
        [_section0Array removeAllObjects];
        [_section1Array removeAllObjects];
        
        NSDictionary *resultDic = [[responseObject objectForKey:@"data"] objectForKey:@"result"];
        [_section0Array addObject:[[resultDic objectForKey:@"package"] objectForKey:@"title"]];
        [_section0Array addObject:@""];
        [_section0Array addObject:[[resultDic objectForKey:@"package"] objectForKey:@"consultation_way"]];
        [_section0Array addObject:[[resultDic objectForKey:@"package"] objectForKey:@"service_hours"]];
        [_section0Array addObject:[[resultDic objectForKey:@"package"] objectForKey:@"service_times"]];
        [_section0Array addObject:[[resultDic objectForKey:@"package"] objectForKey:@"single_price"]];
        
        [_section1Array addObject: [resultDic objectForKey:@"zx_name"]];
        [_section1Array addObject: [resultDic objectForKey:@"zx_gender"]];
        [_section1Array addObject: [resultDic objectForKey:@"zx_age"]];
        [_section1Array addObject: [resultDic objectForKey:@"zx_city"]];
        [_section1Array addObject: [resultDic objectForKey:@"customer_desc"]];
        
        [_headerImageView sd_setImageWithURL:[NSURL URLWithString:[[resultDic objectForKey:@"userInfo"] objectForKey:@"avatar"]]];
        _userLabel.text = [[resultDic objectForKey:@"userInfo"] objectForKey:@"nickname"];
        _sexLabel.text =  [_section1Array[1] isEqualToString:@"2"]?@"女":@"男";
        [_tableView reloadData];
        
    } fail:^(id error) {
        
    }];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchData];
    
}

-(void)initData{
    
    _titleArray =@[@[@"咨询主题",@"咨询标签",@"咨询方式",@"咨询时长",@"咨询次数",@"咨询单价"],@[@"姓名",@"性别",@"年龄",@"城市",@"客服描述"]];
    _section0Array = [[NSMutableArray alloc] init];
    _section1Array = [[NSMutableArray alloc] init];
}


-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"订单详情" rightImage:@"whiteLeftArrow"];
    
    _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0,h(self.navView), SIZE.width,SIZE.height-h(self.navView)) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([_orderStatus integerValue] == 1) {
        _tableView.tableHeaderView = [self fetchTableviewHeader];
    }
    else
    {
        _tableView.tableHeaderView = [self fetchTableviewHeader2];
    }
    
    _tableView.tableFooterView = [self fetchFooterView];
    [self.view addSubview:_tableView];

}

-(UIView *)fetchTableviewHeader{

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0, SIZE.width,135)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 49)];
    titleLabel.text = @"订单待咨询";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor =  Color_1F1F1F;
    [view addSubview:titleLabel];
    
    UIView *headerLine = [[UIView alloc] initWithFrame:CGRectMake(0,50,SIZE.width, 1)];
    headerLine.backgroundColor = Color_F1F1F1;
    [view addSubview:headerLine];
    
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 67.5, 50, 50)];
    [_headerImageView.layer setCornerRadius:h(_headerImageView)/2];
    _headerImageView.backgroundColor = Color_F1F1F1;
    [view addSubview:_headerImageView];
    
    _userLabel = [[UILabel alloc] initWithFrame:CGRectMake(left(_headerImageView)+10,0,100,15)];
    _userLabel.center = CGPointMake(_userLabel.center.x, _headerImageView.center.y-18);
    _userLabel.font = FONT_15;
    _userLabel.text =@"周大哥";
    [view addSubview:_userLabel];
    
    _sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(x(_userLabel), 0, 100,15)];
    _sexLabel.center = CGPointMake(_sexLabel.center.x, _headerImageView.center.y+18);
    _sexLabel.font = FONT_15;
    _sexLabel.textColor = Color_BABABA;
    _sexLabel.text = @"女";
    [view addSubview:_sexLabel];
    
    UIButton *chatBtn = [[UIButton alloc] initWithFrame:CGRectMake(SIZE.width-85, 0, 70, 27)];
    chatBtn.center = CGPointMake(chatBtn.center.x, _headerImageView.center.y);
    [chatBtn.layer setBorderColor:self.navView.backgroundColor.CGColor];
    [chatBtn setTitle:@"聊天" forState:UIControlStateNormal];
    [chatBtn setTitleColor:self.navView.backgroundColor forState:UIControlStateNormal];
    [chatBtn.layer setBorderWidth:1.0f];
    [chatBtn.layer setCornerRadius:4.0f];
    [view addSubview:chatBtn];
    
    UIView *gapView = [[UIView alloc] initWithFrame:CGRectMake(0,127,SIZE.width,8)];
    gapView.backgroundColor = Color_F1F1F1;
    [view addSubview:gapView];
    
    return view;
}

-(UIView *)fetchTableviewHeader2{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0, SIZE.width,50)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 49)];
    titleLabel.text = @"订单待评价";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor =  Color_1F1F1F;
    [view addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49,SIZE.width, 1)];
    lineView.backgroundColor = Color_F1F1F1;
    [view addSubview:lineView];
    
    return view;
}

-(UIView *)fetchFooterView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0, SIZE.width,150)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _titleArray.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *array = _titleArray[section];
    return array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  50.0f;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        static NSString *orderTagsCellID = @"orderTagsCellID";
        OrderTagsCell *cell = [tableView dequeueReusableCellWithIdentifier:orderTagsCellID];
        if (cell == nil) {
            cell = [[OrderTagsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderTagsCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.row;
        NSArray *array = _titleArray[indexPath.section];
        cell.titleLabel.text =array[indexPath.row];
        return cell;
        
    }
    else
    {
        
        static NSString *orderDetailCellID = @"orderDetailCellID";
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:orderDetailCellID];
        if (cell == nil) {
            cell = [[OrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderDetailCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.row;
        NSArray *array = _titleArray[indexPath.section];
        cell.titleLabel.text =array[indexPath.row];
        if (_section0Array.count != 0 ) {
            if (indexPath.section == 0) {
                cell.detailLabel.text = _section0Array[indexPath.row];
            }
            else
            {
                cell.detailLabel.text = _section1Array[indexPath.row];
            }
          
        }
        return cell;
    }

    
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
