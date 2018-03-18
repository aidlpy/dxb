//
//  ConsultingOrderModel.m
//  37duxinB
//
//  Created by Zhang Xinrong on 13/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ConsultingOrderModel.h"

@implementation ConsultingOrderModel
+(void)fetchArray:(NSArray *)array model:(void(^)(BOOL stop,ConsultingOrderModel *model))fetchModelBlock{
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dic = (NSDictionary *)obj;
        ConsultingOrderModel *model = [ConsultingOrderModel new];
        model.orderId = [dic objectForKey:@"id"];
        model.orderCID = [dic objectForKey:@"cid"];
        model.orderConsultationStatus = [dic objectForKey:@"consultation_status"];
        model.orderCustomerDesc = [dic objectForKey:@"customer_desc"];
        model.orderOldPrice = [dic objectForKey:@"old_price"];
        model.orderPrice = [dic objectForKey:@"price"];
        model.orderType = [dic objectForKey:@"type"];
        model.orderUID = [dic objectForKey:@"uid"];
        
        //consultantProfile
        NSDictionary *consultantProfileDic = [dic objectForKey:@"consultantProfile"];
        model.consultantUsername = [consultantProfileDic objectForKey:@"name"];
        
        //package
        NSDictionary *packageInfoDic = [dic objectForKey:@"package"];
        model.packageId = [packageInfoDic objectForKey:@"id"];
        model.packageTitle = [packageInfoDic objectForKey:@"title"];
        model.packageSerContent = [packageInfoDic objectForKey:@"service_content"];
        model.packageSerTimes = [packageInfoDic objectForKey:@"service_times"];
        model.packageSerHours = [packageInfoDic objectForKey:@"service_hours"];
        model.packageSerType = [packageInfoDic objectForKey:@"service_type"];
        model.packageSinglePrice = [packageInfoDic objectForKey:@"single_price"];
        NSString *tags = [packageInfoDic objectForKey:@"tags"];
        model.packageTags = [tags componentsSeparatedByString:@","];
        NSString *consultation_way_string = [packageInfoDic objectForKey:@"consultation_way"];
        model.packageConsultationWay = [consultation_way_string componentsSeparatedByString:@","];
    
        model.orderInfoZXAge = [dic objectForKey:@"zx_age"];
        model.orderInfoZXArea = [dic objectForKey:@"zx_area"];
        model.orderInfoZXCity = [dic objectForKey:@"zx_city"];
        model.orderInfoZXGender = [dic objectForKey:@"zx_gender"];
        model.orderInfoZXName = [dic objectForKey:@"zx_name"];
        model.orderInfoZXProvince = [dic objectForKey:@"zx_province"];
        
        fetchModelBlock(stop,model);
        
    }];
}
@end
