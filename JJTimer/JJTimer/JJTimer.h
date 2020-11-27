//
//  JJTimer.h
//  JJTimer
//
//  Created by LZC on 2020/11/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJTimer : NSObject


/// 创建定时器并执行 block。返回创建的 Timer identifier
/// @param asnyc 是否异步执行
/// @param interval 执行时间间隔，s 为单位
/// @param delay 执行延迟时间，s 为单位
/// @param repeats 是否重复执行
/// @param block 回调
+ (nullable NSString *)jj_scheduledTimerWithAsync:(BOOL)asnyc
                          interval:(NSTimeInterval)interval
                             delay:(NSTimeInterval)delay
                           repeats:(BOOL)repeats
                             block:(void(^)(void))block;


/// 取消所有定时器
+ (void)jj_invalidateAll;


/// 取消指定定时器。
/// 如果 idenrifier 为 nil，则取消所有定时器
/// @param idenrifier idenrifier。
+ (void)jj_invalidateWithIdentifier:(nullable NSString *)idenrifier;

@end

NS_ASSUME_NONNULL_END
