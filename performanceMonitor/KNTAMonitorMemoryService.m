//
//  KNTAMonitorMemoryService.m
//  TestPerformanceMonitor
//
//  Created by Kevin on 2018/4/26.
//  Copyright © 2018年 Kevin. All rights reserved.
//

#import "KNTAMonitorMemoryService.h"
#import <malloc/malloc.h>
#import <mach/mach_init.h>
#import <mach/mach_host.h>


@interface KNTAMonitorMemoryService ()



@end


static KNTAMonitorMemoryService *service = nil;

@implementation KNTAMonitorMemoryService

+ (KNTAMonitorMemoryService *)sharedService
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[KNTAMonitorMemoryService alloc] init];
    });
    return service;
}

- (void)update
{
    struct mstats stats = mstats();
    
//    mach_port_t host_port;
//    mach_msg_type_number_t host_size;
//    vm_size_t pagesize;
//
//    host_port = mach_host_self();
//    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
//    host_page_size( host_port, &pagesize );
//
//    vm_statistics_data_t vm_stat;
//    kern_return_t ret = host_statistics( host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size );
//
//    if ( KERN_SUCCESS == ret )
//    {
//        natural_t mem_used = (natural_t)((vm_stat.active_count + vm_stat.inactive_count + vm_stat.wire_count) * pagesize);
//        natural_t mem_free = (natural_t)(vm_stat.free_count * pagesize);
//        natural_t mem_total = mem_used + mem_free;
//
//    }
    
    _mbytesUsed = stats.bytes_used / 1024.0 / 1024.0;
}

@end
