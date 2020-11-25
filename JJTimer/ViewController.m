//
//  ViewController.m
//  JJTimer
//
//  Created by LZC on 2020/11/25.
//

#import "ViewController.h"
#import "JJTimer.h"

@interface ViewController ()

@property (nonatomic, strong) NSTimer *nsTimer;

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation ViewController

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
