//
//  JJTimer.m
//  JJTimer
//
//  Created by LZC on 2020/11/25.
//

#import "JJTimer.h"


static NSMutableDictionary *_timerMap;
static dispatch_semaphore_t _semaphore;

@implementation JJTimer

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _timerMap = [NSMutableDictionary dictionary];
        _semaphore = dispatch_semaphore_create(3);
    });
}

+ (NSString *)jj_scheduledTimerWithAsync:(BOOL)asnyc interval:(NSTimeInterval)interval delay:(NSTimeInterval)delay repeats:(BOOL)repeats block:(void(^)(void))block {
    if (interval < 0) return nil;
    if (delay < 0) return nil;
    if (!block) return nil;
    
    static NSUInteger i = 0;
    NSString *identifier = [NSString stringWithFormat:@"%ld", i];
    i++;
    
    
    dispatch_queue_t queue = asnyc ? dispatch_queue_create("JJ_Timer_Asnyc_Queue", 0) : dispatch_get_main_queue();
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, time, interval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        block();
            
        if (!repeats)
            [self jj_invalidateWithIdentifier:identifier];
    });
    
    dispatch_resume(timer);
    
    
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    _timerMap[identifier] = timer;
    dispatch_semaphore_signal(_semaphore);
    
    return identifier;
}

+ (void)jj_invalidateAll {
    if (!_timerMap) return;
    
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    [_timerMap.allValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_source_cancel(obj);
    }];
    [_timerMap removeAllObjects];
    dispatch_semaphore_signal(_semaphore);
}

+ (void)jj_invalidateWithIdentifier:(NSString *)idenrifier {
    if (!_timerMap) return;
        
    if (!idenrifier || !idenrifier.length) {
        [self jj_invalidateAll];
        return;
    }
    
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    if (_timerMap[idenrifier])
        dispatch_source_cancel(_timerMap[idenrifier]);
    dispatch_semaphore_signal(_semaphore);
}


@end
