//
//  CZQuestion.m
//  超级猜图
//
//  Created by lymos on 2023/8/27.
//

#import "CZQuestion.h"

@implementation CZQuestion

- (instancetype) initWithDict: (NSDictionary *) dict{
    if(self = [super init]){
        self.answer = dict[@"answer"];
        self.title = dict[@"title"];
        self.icon = dict[@"icon"];
        self.options = dict[@"questions"];
    }
    return self;
}

+ (instancetype) questionWithDict: (NSDictionary *) dict{
    return [[self alloc] initWithDict: dict];
}

@end
