//
//  JJProxy.m
//  JJTimer
//
//  Created by LZC on 2020/11/26.
//

#import "JJProxy.h"


@interface JJProxy ()

@property (nonatomic, weak) id target;

@end

@implementation JJProxy

+ (instancetype)jj_proxyWithTarget:(id)target {
    JJProxy *proxy = [[JJProxy alloc] init];
    proxy.target = target;
    
    return proxy;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.target;
}

@end
