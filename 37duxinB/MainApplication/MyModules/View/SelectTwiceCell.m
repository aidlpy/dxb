//
//  SelectTwiceCell.m
//  37duxinB
//
//  Created by 37duxin on 07/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "SelectTwiceCell.h"

@implementation SelectTwiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, 52, 20)];
        _titleLab.center = CGPointMake(_titleLab.center.x,26.5);
        _titleLab.font = FONT_13;
        _titleLab.textColor = Color_4B4B4B;
        [self addSubview:_titleLab];
        
        _requiredImagView = [[UIImageView alloc] initWithFrame:CGRectMake(left(_titleLab),_titleLab.frame.origin.x-2,8, 8)];
        [_requiredImagView setImage:[UIImage imageNamed:Image(@"star")]];
        [self addSubview:_requiredImagView];
        
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(left(_titleLab)+20,0,70.0f, 25.0f)];
        _leftBtn.center = CGPointMake(_leftBtn.center.x, _titleLab.center.y);
        _leftBtn.backgroundColor = Color_5ECAF7;
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftBtn.layer setCornerRadius:2.0f];
        [_leftBtn.layer setBorderWidth:1.0f];
        [_leftBtn.layer setBorderColor:Color_F1F1F1.CGColor];
        _leftBtn.tag = 0;
        [_leftBtn addTarget:self action:@selector(clickSelection0:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftBtn];
        
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(left(_leftBtn)+11, 0, 70, 25.0f)];
        _rightBtn.center = CGPointMake(_rightBtn.center.x, _titleLab.center.y);
        _rightBtn.backgroundColor = [UIColor whiteColor];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_rightBtn setTitleColor:Color_1F1F1F   forState:UIControlStateNormal];
        [_rightBtn.layer setCornerRadius:2.0f];
        [_rightBtn.layer setBorderWidth:1.0f];
        [_rightBtn.layer setBorderColor:Color_F1F1F1.CGColor];
        _rightBtn.tag = 1;
        [_rightBtn addTarget:self action:@selector(clickSelection1:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightBtn];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 52, SIZE.width-20, 1)];
        lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:lineView];
        
    }
    return  self;
    
}

-(void)updateUI:(NSDictionary *)dic
{
    _titleLab.text = [dic objectForKey:@"title"];
    CGSize size = [_titleLab boundingRectWithSize:CGSizeMake(0, 20)];
    [_titleLab setMj_w:size.width];
    [_requiredImagView setMj_x:left(_titleLab)];
    _requiredImagView.hidden = ![[dic objectForKey:@"required"] boolValue];
    
    NSArray *array = [dic objectForKey:@"selectedbtn"];
    [_leftBtn setTitle:array[0] forState:UIControlStateNormal];
    [_rightBtn setTitle:array[1] forState:UIControlStateNormal];
}

-(void)setSelectedData:(NSString *)string{
    
    
    NSArray *array =[string componentsSeparatedByString:@","];
    _selectedArray = [[NSMutableArray alloc] initWithObjects:@"0",@"0",nil];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:@"0"]) {
            [_selectedArray replaceObjectAtIndex:0 withObject:@"1"];
        }
        if ([obj isEqualToString:@"1"]) {
            [_selectedArray replaceObjectAtIndex:1 withObject:@"1"];
        }
    }];
    
    if ([_selectedArray[0] integerValue] == 0) {
        
        _leftBtn.backgroundColor = [UIColor whiteColor];
        [_leftBtn setTitleColor:Color_1F1F1F  forState:UIControlStateNormal];
     
   
        
    }
    else
    {
        _leftBtn.backgroundColor =  Color_5ECAF7;
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        
    }
    
    if ([_selectedArray[1] integerValue] == 0)
    {
        _rightBtn.backgroundColor = [UIColor whiteColor];
        [_rightBtn setTitleColor:Color_1F1F1F  forState:UIControlStateNormal];
     
    }
    else
    {

        _rightBtn.backgroundColor =  Color_5ECAF7;
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  
        
    }
    
    
}

-(void)clickSelection0:(UIButton *)sender{
    
    if ([_selectedArray[0] integerValue] == 0) {
        
        _leftBtn.backgroundColor =  Color_5ECAF7;
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_selectedArray replaceObjectAtIndex:0 withObject:@"1"];
       
    }
    else
    {
        _leftBtn.backgroundColor = [UIColor whiteColor];
        [_leftBtn setTitleColor:Color_1F1F1F  forState:UIControlStateNormal];
        [_selectedArray replaceObjectAtIndex:0 withObject:@"0"];
        
    }
    
    __block NSString *consultaingwayString = @"";
    [_selectedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:@"1"]) {
            if (idx == 0)
            {
                consultaingwayString = [NSString stringWithFormat:@"%ld",(long)idx];
            }
            else
            {
                consultaingwayString = [NSString stringWithFormat:@"%@,%ld",consultaingwayString,(long)idx];
                
            }
        }
        
    }];

    _selectedTypeBlock(consultaingwayString);
}

-(void)clickSelection1:(UIButton *)sender{
    
    if ([_selectedArray[1] integerValue] == 0)
    {
        _rightBtn.backgroundColor =  Color_5ECAF7;
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_selectedArray replaceObjectAtIndex:1 withObject:@"1"];
    }
    else
    {
        _rightBtn.backgroundColor = [UIColor whiteColor];
        [_rightBtn setTitleColor:Color_1F1F1F  forState:UIControlStateNormal];
        [_selectedArray replaceObjectAtIndex:1 withObject:@"0"];
        
    }
    __block NSString *consultaingwayString = @"";
    [_selectedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:@"1"]) {
            if (idx == 0)
            {
                consultaingwayString = [NSString stringWithFormat:@"%ld",(long)idx];
            }
            else
            {
                consultaingwayString = [NSString stringWithFormat:@"%@,%ld",consultaingwayString,(long)idx];
                
            }
        }
        
    }];
    
    _selectedTypeBlock(consultaingwayString);
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
