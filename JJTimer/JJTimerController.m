//
//  JJTimerController.m
//  JJTimer
//
//  Created by LZC on 2020/11/25.
//

#import "JJTimerController.h"
#import "JJTimer.h"
#import "JJProxy.h"

@interface JJTimerController ()

@property (nonatomic, strong) NSTimer *nsTimer;

@end

@implementation JJTimerController

- (void)dealloc {
    NSLog(@" - dealloc - ");
    
    [self.nsTimer invalidate];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}


- (IBAction)startAction:(id)sender {
    //FIXME: 通过 identifier， 停止多个开启的 timer
    [JJTimer jj_scheduledTimerWithAsync:YES interval:1.5 delay:0 repeats:YES block:^{
        NSLog(@" - 1 - thread: %@", [NSThread currentThread]);
    }];
    
    [JJTimer jj_scheduledTimerWithAsync:YES interval:1.5 delay:0 repeats:YES block:^{
        NSLog(@" - 2 - thread: %@", [NSThread currentThread]);
    }];
}

- (IBAction)endAction:(id)sender {
    [JJTimer jj_invalidate];
    
    [self.nsTimer invalidate];
}



- (void)nsTiemerDemo {
    /**
    // 1.
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@" - %s", __func__);
    }];
    self.nsTimer = timer;
     */
    
    // 2.
    // NSTimer 对 target 强引用。The timer maintains a strong reference to this object until it (the timer) is invalidated.
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(nsTimerAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    self.nsTimer = timer;
    
//    [timer invalidate];
}

- (void)nsTimerAction:(NSTimer *)timer {
    NSLog(@" - %s", __func__);
}

@end
