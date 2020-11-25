//
//  JJTimer.h
//  JJTimer
//
//  Created by LZC on 2020/11/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJTimer : NSObject


/// 创建定时器并执行 block
/// @param asnyc 是否异步执行
/// @param interval 执行时间间隔，s 为单位
/// @param delay 执行延迟时间，s 为单位
/// @param repeats 是否重复执行
/// @param block 回调
+ (void)jj_scheduledTimerWithAsync:(BOOL)asnyc
                          interval:(NSTimeInterval)interval
                             delay:(NSTimeInterval)delay
                           repeats:(BOOL)repeats
                             block:(void(^)(void))block;


/// 取消定时器
+ (void)jj_invalidate;

@end

NS_ASSUME_NONNULL_END
