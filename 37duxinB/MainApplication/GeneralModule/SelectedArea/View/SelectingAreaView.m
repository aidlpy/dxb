//
//  SelectingAreaView.m
//  37duxinB
//
//  Created by Zhang Xinrong on 01/03/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "SelectingAreaView.h"
#import "CityModel.h"
#import "AreaModel.h"

@interface SelectingAreaView()<UIPickerViewDelegate,UIPickerViewDataSource>{
    
    UIPickerView *_pickView;
    NSMutableArray *_mutableArray;
    NSMutableArray *_pocketArray;
    NSString  *_areaString;

    /** 第一级选中的下标 **/
    NSInteger _selectOneRow;
    /** 第二级选中的下标 **/
    NSInteger _selectTwoRow;
    /** 第三级选中的下标 **/
    NSInteger _selectThreeRow;

}
@end

@implementation SelectingAreaView

-(instancetype)initWithFrame:(CGRect)frame{
    self  = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = Color_D4D4D4;
        
        _areaString = @"北京/北京/东城区";
        _mutableArray = [SelectingAreaView getCityData];
        _pocketArray = [[NSMutableArray alloc] initWithCapacity:0];
        [self fetchAreaData];
        
        _selectOneRow = 0;
        _selectTwoRow = 0;
        _selectThreeRow = 0;
        
      
        UIButton *cancelbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
        cancelbtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelbtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelbtn];
        
        UIButton *confirmBtn= [[UIButton alloc] initWithFrame:CGRectMake(SIZE.width-100,0, 100, 25)];
        confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:confirmBtn];
        
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,25, SIZE.width, self.frame.size.height-25)];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        _pickView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_pickView];
        
    }
    return self;
}

-(void)cancelAction:(UIButton *)btn{

    [UIView animateWithDuration:0.4f animations:^{
        [self setMj_y:SIZE.height];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
   
}

-(void)confirmAction:(UIButton *)btn{
    
    if (_fetchAreaBlock) {
        _fetchAreaBlock(_areaString);
    }
    [UIView animateWithDuration:0.4f animations:^{
        [self setMj_y:SIZE.height];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

-(void)fetchAreaData{
    [_pocketArray removeAllObjects];
    [_mutableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"cityObj==>%@",obj);
        if ([obj isKindOfClass:[NSDictionary class]]) {
            CityModel *citymodel = [[CityModel alloc] init];
            citymodel.cityName = [obj objectForKey:@"name"];
            NSArray *array = [obj objectForKey:@"city"];
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    
                    AreaModel *areamodel = [[AreaModel alloc] init];
                    areamodel.areaName = [obj objectForKey:@"name"];
                    areamodel.areaArray = [obj objectForKey:@"area"];
                    [citymodel.cityArray addObject:areamodel];
                }
            
            }];
            
            [_pocketArray addObject:citymodel];
            
        }
    }];
    
}


//返回显示的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}


//返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
   
    if (component == 0) {
        
        return _pocketArray.count;
        
    }else if (component == 1){
        
         CityModel *model = _pocketArray[_selectOneRow];
        return model.cityArray.count;
        
    }else{
        CityModel *model = _pocketArray[_selectOneRow];
        AreaModel *areaModel = model.cityArray[_selectTwoRow];
        return areaModel.areaArray.count;
    }

}

//设置当前行的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if(component == 0)
    {
        CityModel *citymodel = _pocketArray[row];
        return citymodel.cityName;
    }
    else if (component == 1)
    {
        CityModel *citymodel = _pocketArray[_selectOneRow];
        AreaModel *areamodel = citymodel.cityArray[row];
        return areamodel.areaName;
    }
    else
    {
        
        CityModel *citymodel = _pocketArray[_selectOneRow];
        AreaModel *areamodel = citymodel.cityArray[_selectTwoRow];
        NSString *string = areamodel.areaArray[row];
        return string;
        
    }
}
//选择的行数
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        _selectOneRow = row;
        _selectTwoRow = 0 ;
        _selectThreeRow = 0 ;
        [_pickView reloadComponent:1];
        [_pickView reloadComponent:2];
    }
    else if(component == 1)
    {
         _selectTwoRow= row;
        [_pickView reloadComponent:2];
        
    }
    else{
         _selectThreeRow = row;
        
    }
    CityModel *citymodel = _pocketArray[_selectOneRow];
    AreaModel *areaModel = citymodel.cityArray[_selectTwoRow];
    NSArray *areaString = areaModel.areaArray[_selectThreeRow];
    _areaString = [NSString stringWithFormat:@"%@/%@/%@",citymodel.cityName,areaModel.areaName,areaString];
    
}
//每行显示的文字样式
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 107, 30)];
    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.backgroundColor = [UIColor clearColor];
    if(component == 0) {
        CityModel *citymodel = _pocketArray[row];
        titleLabel.text =citymodel.cityName;
    }
    else if (component == 1) {
        CityModel *citymodel = _pocketArray[_selectOneRow];
        AreaModel *areamodel = citymodel.cityArray[row];
        titleLabel.text = areamodel.areaName;
    }
    else{
        CityModel *citymodel = _pocketArray[_selectOneRow];
        AreaModel *areamodel = citymodel.cityArray[_selectTwoRow];
        NSString *string = areamodel.areaArray[row];
        titleLabel.text = string;
    }
    return titleLabel;

}


+ (NSMutableArray *)getCityData
{
    NSArray *jsonArray = [[NSArray alloc]init];
    NSData *fileData = [[NSData alloc]init];
    NSUserDefaults *UD = [NSUserDefaults standardUserDefaults];
    if ([UD objectForKey:@"city"] == nil) {
        NSString *path;
        path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"json"];
        fileData = [NSData dataWithContentsOfFile:path];
        
        [UD setObject:fileData forKey:@"city"];
        [UD synchronize];
    }
    else {
        fileData = [UD objectForKey:@"city"];
    }
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
    jsonArray = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];
    for (NSDictionary *dict in jsonArray) {
        [array addObject:dict];
    }
    
    return array;
}

@end
