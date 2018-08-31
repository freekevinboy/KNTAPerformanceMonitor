//
//  KNTAMonitorCPUService.h
//  TestPerformanceMonitor
//
//  Created by Kevin on 2018/4/26.
//  Copyright © 2018年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNTAMonitorCPUService : NSObject

+ (KNTAMonitorCPUService *)sharedService;

@property (assign, nonatomic) float usage;

- (void)update;

@end
