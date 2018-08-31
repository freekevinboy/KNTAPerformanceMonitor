//
//  KNTAMonitorMemoryService.h
//  TestPerformanceMonitor
//
//  Created by Kevin on 2018/4/26.
//  Copyright © 2018年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNTAMonitorMemoryService : NSObject

+ (KNTAMonitorMemoryService *)sharedService;

//MB
@property (assign, nonatomic) float mbytesUsed;

- (void)update;

@end
