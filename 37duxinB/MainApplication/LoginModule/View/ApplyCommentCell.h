//
//  ApplyCommentCell.h
//  37duxinB
//
//  Created by 37duxin on 05/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^textChangeBlock)(NSString *text,NSInteger tag);
@interface ApplyCommentCell : UITableViewCell<UITextViewDelegate>
@property(nonatomic,retain)UILabel *titleLab;
@property(nonatomic,retain)UIImageView *requiredImagView;
@property(nonatomic,retain)UIButton *sampleBtn;
@property(nonatomic,retain)UITextView *commentTextView;
@property(nonatomic,retain)UILabel *textCountLabel;
@property(nonatomic,retain)UIView *lineView;
@property(nonatomic,copy)textChangeBlock textChangeBlock;
@property(nonatomic,copy)void (^showExampleBlock)(NSInteger tag);
-(void)updateUI:(NSDictionary *)dic;
@end
