//
//  ServiceTagsCell.h
//  37duxinB
//
//  Created by Zhang Xinrong on 22/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceTagsCell : UITableViewCell{
    
    NSMutableArray *_btnArray;
    NSArray *_tagsTitleArray;
    
}
@property(nonatomic,retain)UILabel *titleLab;
@property(nonatomic,retain)UIImageView *requiredImagView;
@property(nonatomic,retain)UILabel *detailLabel;
@property(nonatomic,retain)UITextField *textFild;
@property(nonatomic,retain)NSString  *tagsString;
@property(nonatomic,retain)UIView *lineView;

-(void)updateUI:(NSDictionary *)dic;

-(void)drawTags:(NSString *)string;

@end
