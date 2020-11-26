//
//  JJProxy.h
//  JJTimer
//
//  Created by LZC on 2020/11/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJProxy : NSProxy

+ (instancetype)jj_proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
