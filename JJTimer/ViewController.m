//
//  ViewController.m
//  JJTimer
//
//  Created by LZC on 2020/11/25.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSTimer *nsTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


- (IBAction)startAction:(id)sender {
    [self nsTiemerDemo];
}

- (IBAction)endAction:(id)sender {
    [self.nsTimer invalidate];
}



- (void)nsTiemerDemo {
    /**
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@" - %s", __func__);
    }];
    self.nsTimer = timer;
     */
    
    // NSTimer 对 target 强引用。The timer maintains a strong reference to this object until it (the timer) is invalidated.
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(nsTimerAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    self.nsTimer = timer;
}

- (void)nsTimerAction:(NSTimer *)timer {
    NSLog(@" - %s", __func__);
}

@end
