//
//  KNTAPerformanceMonitor.h
//  TestPerformanceMonitor
//
//  Created by Kevin on 2018/4/18.
//  Copyright © 2018年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNTAPerformanceMonitor : NSObject

+ (KNTAPerformanceMonitor *)sharedMonitor;

- (void)install;

@end
