//
//  JJTimer.m
//  JJTimer
//
//  Created by LZC on 2020/11/25.
//

#import "JJTimer.h"


static dispatch_source_t _timer;

@implementation JJTimer

+ (void)jj_scheduledTimerWithAsync:(BOOL)asnyc interval:(NSTimeInterval)interval delay:(NSTimeInterval)delay repeats:(BOOL)repeats block:(void(^)(void))block {
    if (delay < 0) return;
    if (!block) return;
    
    dispatch_queue_t queue = asnyc ? dispatch_queue_create("JJ_Timer_Asnyc_Queue", 0) : dispatch_get_main_queue();
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, time, interval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        block();
            
        if (!repeats)
            dispatch_source_cancel(timer);
    });
    
    dispatch_resume(timer);
    _timer = timer;
}

+ (void)jj_invalidate {
    if (!_timer) return;
    
    dispatch_source_cancel(_timer);
}

@end
