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
    JJProxy *proxy = [JJProxy alloc];
    proxy.target = target;
    
    return proxy;
}

// 相较于继承于 NSObject，使用 forwardingTargetForSelector: 方法。
// 继承于 NSProxy，直接使用 methodSignatureForSelector: 方法。省略了方法查找的前两步，更有效率。
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

//// “转发者”角色，对 selector 细节不关心。直接原封不动的转发
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    return self.target;
//}

@end
