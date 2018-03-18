//
//  PackageModel.m
//  37duxinB
//
//  Created by Zhang Xinrong on 19/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "PackageModel.h"

@implementation PackageModel

-(instancetype)init{
    self = [super init];
    if (self) {
        _cellHeight = 210.0f;
    }
    
    return self;
}

+(void)fetchArray:(NSArray *)array model:(void(^)(BOOL stop,PackageModel *model))fetchModelBlock{
 
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSDictionary *dic = (NSDictionary *)obj;
        PackageModel *model = [PackageModel new];
        model.packageId = [dic objectForKey:@"id"];
        model.packageTitle = [dic objectForKey:@"title"];
        model.packageServiceTags  = [dic objectForKey:@"tags"];
        model.packageConsultationWay = [dic objectForKey:@"consultation_way"];
        model.packageServiceType = [dic objectForKey:@"service_type"];
        model.packageServiceHours = [dic objectForKey:@"service_hours"];
        model.packageServiceTimes = [dic objectForKey:@"service_times"];
        model.packageServiceContent = [dic objectForKey:@"service_content"];
        model.packageServiceSinglePrice = [dic objectForKey:@"single_price"];
        model.packageServiceCreateTime = [dic objectForKey:@"created_at"];
        fetchModelBlock(stop,model);
        
    }];
}

@end
