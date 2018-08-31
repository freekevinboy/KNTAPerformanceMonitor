//
//  KNTAMonitorBar.m
//  TestPerformanceMonitor
//
//  Created by Kevin on 2018/4/18.
//  Copyright © 2018年 Kevin. All rights reserved.
//

#import "KNTAMonitorBar.h"
#import "KNTAMonitorFPSService.h"
#import "KNTAMonitorNetworkService.h"
#import "KNTAMonitorMemoryService.h"
#import "KNTAMonitorCPUService.h"

@interface KNTAMonitorBar ()

@property (assign, nonatomic) BOOL inited;

@property (strong, nonatomic) UILabel *label;

@end

@implementation KNTAMonitorBar

- (instancetype)init
{
    CGRect barFrame;
    barFrame.origin.x = 0.0f;
    barFrame.origin.y = [UIScreen mainScreen].bounds.size.height - 16.0f;
    barFrame.size.width = [UIScreen mainScreen].bounds.size.width;
    barFrame.size.height = 16.0f;
    
    self = [super initWithFrame:barFrame];
    if (self) {
        
        self.hidden = NO;
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelStatusBar + 5.0f;
        self.rootViewController = [[UIViewController alloc] init];
        
    }
    return self;
}

- (void)show
{
    if (_inited == NO) {
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.backgroundColor = [UIColor clearColor];
        _label.font = [UIFont systemFontOfSize:10.0f];
        _label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor blackColor];
        _label.backgroundColor = [UIColor clearColor];
        _label.lineBreakMode = NSLineBreakByClipping;
        _label.layer.shadowColor = [[UIColor whiteColor] CGColor];
        _label.layer.shadowOpacity = 1.0f;
        _label.layer.shadowRadius = 1.0f;
        _label.layer.shadowOffset = CGSizeMake(0.f, 0.0f);
        [self addSubview:_label];
        
        _inited = YES;
    }
    
    self.hidden = NO;
    
    [self update];
}

- (void)update
{
    if (self.hidden == NO) {
        
        _label.text = [NSString stringWithFormat:@"FPS:%ld, up:%.1fKB/s, down:%.1fKB/s, memory:%.1fMB, CPU:%.0f%%", [KNTAMonitorFPSService sharedService].fps, [KNTAMonitorNetworkService sharedService].uploadSpeedKBytes, [KNTAMonitorNetworkService sharedService].downloadSpeedKBytes, [KNTAMonitorMemoryService sharedService].mbytesUsed, [KNTAMonitorCPUService sharedService].usage * 100];
    }
}

- (void)hide
{
    self.hidden = YES;
}

@end
