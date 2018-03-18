//
//  ApplyCommentCell.m
//  37duxinB
//
//  Created by 37duxin on 05/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ApplyCommentCell.h"

@implementation ApplyCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(22,30, 52, 20)];
        _titleLab.font = FONT_13;
        _titleLab.textColor = Color_4B4B4B;
        [self addSubview:_titleLab];
        
        _sampleBtn= [[UIButton alloc] initWithFrame:CGRectMake(left(_titleLab)+15, 0,50, 20)];
        _sampleBtn.backgroundColor = [UIColor clearColor];
        _sampleBtn.center = CGPointMake(_sampleBtn.center.x,_titleLab.center.y);
        _sampleBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_sampleBtn setTitle:@"示例描述" forState:UIControlStateNormal];
        [_sampleBtn setTitleColor:Color_5ECAF7 forState:UIControlStateNormal];
        [_sampleBtn addTarget:self action:@selector(showExamplesAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sampleBtn];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(x(_sampleBtn),bottom(_sampleBtn)-3,50,0.5)];
        _lineView.center = CGPointMake(_sampleBtn.center.x,_lineView.center.y);
        _lineView.backgroundColor =Color_5ECAF7;
        [self addSubview:_lineView];
        
        _requiredImagView = [[UIImageView alloc] initWithFrame:CGRectMake(left(_titleLab),32,8,8)];
        [_requiredImagView setImage:[UIImage imageNamed:Image(@"star")]];
        [self addSubview:_requiredImagView];
        
        _commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(22, 61.5, SIZE.width-44,150)];
        [_commentTextView.layer setBorderColor:Color_F1F1F1.CGColor];
        [_commentTextView.layer setBorderWidth:1.0f];
        _commentTextView.delegate =self;
        [self addSubview:_commentTextView];
        
        _textCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, bottom(_commentTextView), SIZE.width-43,20)];
        _textCountLabel.text =@"0/200";
        _textCountLabel.textAlignment = NSTextAlignmentRight;
        _textCountLabel.font = [UIFont systemFontOfSize:12.0f];
        _textCountLabel.textColor = Color_F1F1F1;
        [self addSubview:_textCountLabel];
    
    }
    
    return self;
}

-(void)showExamplesAction:(UIButton *)sender{
    
    if(_showExampleBlock)
    {
        _showExampleBlock(self.tag);
    }
    
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length <= 200) {
        _textCountLabel.text = [NSString stringWithFormat:@"%ld/200",(long)textView.text.length];
        _textChangeBlock(textView.text,self.tag);

    }
    else
    {
        _textCountLabel.text = @"200/200";
        textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(200,1) withString:@""];
    }
}



-(void)updateUI:(NSDictionary *)dic{
    
    _titleLab.text = [dic objectForKey:@"title"];
    CGSize size = [_titleLab boundingRectWithSize:CGSizeMake(0, 20)];
    [_titleLab setMj_w:size.width];
    [_requiredImagView setMj_x:left(_titleLab)];
    _requiredImagView.hidden = ![[dic objectForKey:@"required"] boolValue];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
