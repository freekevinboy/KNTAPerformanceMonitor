//
//  KNTAMonitorNetworkService.h
//  TestPerformanceMonitor
//
//  Created by Kevin on 2018/4/25.
//  Copyright © 2018年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNTAMonitorNetworkService : NSObject

+ (KNTAMonitorNetworkService *)sharedService;

@property (assign, nonatomic) float uploadSpeedKBytes;

@property (assign, nonatomic) float downloadSpeedKBytes;

- (void)update;

@end
