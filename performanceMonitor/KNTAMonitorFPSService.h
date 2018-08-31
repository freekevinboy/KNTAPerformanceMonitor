//
//  KNTAMonitorFPSService.h
//  TestPerformanceMonitor
//
//  Created by Kevin on 2018/4/19.
//  Copyright © 2018年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNTAMonitorFPSService : NSObject

@property (assign, nonatomic) NSInteger fps;

+ (KNTAMonitorFPSService *)sharedService;

@end
