//
//  OrderRecordViewController.m
//  37duxinB
//
//  Created by Zhang Xinrong on 13/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "OrderRecordViewController.h"
#import "OrderRecordCell.h"

@interface OrderRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation OrderRecordViewController

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
    [self.navView setBackStytle:@"订单记录" rightImage:@"whiteLeftArrow"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,h(self.navView),SIZE.width,SIZE.height-h(self.navView))];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self customView];
    
    
}

-(void)customView{
    
    //初始化一个emptyView
    LYEmptyView *emptyView = [LYEmptyView emptyActionViewWithImageStr:Image(@"nonData")
                                                             titleStr:@"无数据"
                                                            detailStr:@""
                                                          btnTitleStr:@""
                                                        btnClickBlock:^{}];
    //元素竖直方向的间距
    emptyView.contentViewY = 70.0f;
    emptyView.titleLabTextColor = Color_BABABA;
    emptyView.titleLabFont = FONT_13;
    //设置空内容占位图
    _tableView.ly_emptyView = emptyView;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 108.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MyIdentifier = @"MyIdentifier";
    OrderRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[OrderRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier]
        ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.row;
    return cell;
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
