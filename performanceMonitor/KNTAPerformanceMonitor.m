//
//  KNTAPerformanceMonitor.m
//  TestPerformanceMonitor
//
//  Created by Kevin on 2018/4/18.
//  Copyright © 2018年 Kevin. All rights reserved.
//

#import "KNTAPerformanceMonitor.h"
#import "KNTAMonitorBar.h"
#import "KNTAMonitorNetworkService.h"
#import "KNTAMonitorMemoryService.h"
#import "KNTAMonitorCPUService.h"

static KNTAPerformanceMonitor *monitor = nil;


@interface KNTAPerformanceMonitor ()

@property (strong, nonatomic) KNTAMonitorBar *bar;

@property (strong, nonatomic) NSTimer *timer;

@end


@implementation KNTAPerformanceMonitor

+ (void)load
{
    [[KNTAPerformanceMonitor sharedMonitor] install];
}

+ (KNTAPerformanceMonitor *)sharedMonitor
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monitor = [[KNTAPerformanceMonitor alloc] init];
    });
    return monitor;
}


- (void)install
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didFinishedLaunch)
                                                 name:UIApplicationDidFinishLaunchingNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willTerminal)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(update) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)didFinishedLaunch
{
    _bar = [[KNTAMonitorBar alloc] init];
    [_bar show];
    
}

- (void)willTerminal
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)update
{
    
    [[KNTAMonitorNetworkService sharedService] update];
    [[KNTAMonitorMemoryService sharedService] update];
    [[KNTAMonitorCPUService sharedService] update];
    
    [_bar update];
}


@end
