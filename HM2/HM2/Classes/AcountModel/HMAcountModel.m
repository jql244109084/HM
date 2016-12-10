//
//  HMAcountModel.m
//  HM2
//
//  Created by 焦起龙 on 16/12/10.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "HMAcountModel.h"

@implementation HMAcountModel
+ (instancetype)accountWithDictionary:(NSDictionary *)dict {
    HMAcountModel *account = [[self alloc] init];
    account.expires_in = dict[@"expires_in"];
    account.access_token = dict[@"access_token"];
    account.uid = dict[@"uid"];
    return account;
}
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
}
- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
    }
    return self;
}
@end
