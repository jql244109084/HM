//
//  HMStatus.m
//  HM2
//
//  Created by JLove on 16/12/16.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "HMStatus.h"
#import "MJExtension.h"
#import "HMPhoto.h"

@implementation HMStatus
- (NSDictionary *)objectClassInArray {
    return @{@"pic_urls" : [HMPhoto class]};
}

- (NSString *)created_at
{
    
//    return @"12分钟前";

    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    // EEE:月份 MMM：星期 Z：时区
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //微博的创建时间
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    //现在的时间
    NSDate *nowDate = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *component = [calender components:unit fromDate:createDate toDate:nowDate options:0];
    
    if ([self isThisYear:createDate]) {//今年
        if ([self isYesterday:createDate]) {//昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        }else if ([self isTaday:createDate]){//今天
            if (component.hour >= 1) {
                return [NSString stringWithFormat:@"%lu小时前",(long)component.hour];
            }else if (component.minute >= 1){
                return [NSString stringWithFormat:@"%lu分钟前",(long)component.minute];
            }else{
                return @"刚刚";
            }

        }else{//其他日子
            fmt.dateFormat = @"MM-DD HH:mm";
            return [fmt stringFromDate:createDate];
        }
            
        
        
    }else{
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
    
    
}
- (BOOL)isTaday:(NSDate *)date {
    NSDate *now = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [fmt stringFromDate:now];
    NSString *string = [fmt stringFromDate:date];
    
    return [nowString isEqualToString:string];
}

- (BOOL)isYesterday:(NSDate *)date {
    
    NSDate *now = [NSDate date];
    
    // date ==  2014-04-30 10:05:28 --> 2014-04-30 00:00:00
    // now == 2014-05-01 09:22:10 --> 2014-05-01 00:00:00
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 2014-04-30
    NSString *dateStr = [fmt stringFromDate:date];
    // 2014-10-18
    NSString *nowStr = [fmt stringFromDate:now];
    
    // 2014-10-30 00:00:00
    date = [fmt dateFromString:dateStr];
    // 2014-10-18 00:00:00
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;

}
- (BOOL)isThisYear:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获得某个时间的年月日时分秒
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:date];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
    
}

- (void)setSource:(NSString *)source {//在set方法中截取比较好 因为只调用一次的
    
    //截取字符串
    if (source.length) {
        NSRange rng = [source rangeOfString:@">"];
        NSRange range = [source rangeOfString:@"</"];
        NSString *sour = [source substringWithRange:NSMakeRange(rng.location + 1, range.location - rng.location - 1)];
        _source = [NSString stringWithFormat:@"来自 %@",sour];
    }
    
    
}






@end
