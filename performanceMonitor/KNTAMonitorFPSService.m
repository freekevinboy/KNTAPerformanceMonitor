//
//  KNTAMonitorFPSService.m
//  TestPerformanceMonitor
//
//  Created by Kevin on 2018/4/19.
//  Copyright © 2018年 Kevin. All rights reserved.
//

#import "KNTAMonitorFPSService.h"
#import <QuartzCore/QuartzCore.h>

@interface KNTAMonitorFPSService ()

@property (strong, nonatomic) CADisplayLink *displayLink;

@property (assign, nonatomic) NSInteger frameCount;

@property (assign, nonatomic) CFTimeInterval timeStamp;

@end


static KNTAMonitorFPSService *FPSService = nil;

@implementation KNTAMonitorFPSService

+ (KNTAMonitorFPSService *)sharedService
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FPSService = [[KNTAMonitorFPSService alloc] init];
    });
    return FPSService;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _fps = 0;
        
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateFrameCount)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        _frameCount = 0;
        _timeStamp = 0;
        
    }
    return self;
}

- (void)dealloc
{
    [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    _displayLink = nil;
}

- (void)updateFrameCount
{
    ++_frameCount;
    
    CFTimeInterval now = CACurrentMediaTime();
    CFTimeInterval diff = now - _timeStamp;
    
    if (diff > 1) {
        
        self.fps = _frameCount;
        
        _frameCount = 0;
        
        _timeStamp = now;
        
    }
}


@end
