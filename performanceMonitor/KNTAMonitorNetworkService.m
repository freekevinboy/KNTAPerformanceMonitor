//
//  KNTAMonitorNetworkService.m
//  TestPerformanceMonitor
//
//  Created by Kevin on 2018/4/25.
//  Copyright © 2018年 Kevin. All rights reserved.
//

#import "KNTAMonitorNetworkService.h"
#import <ifaddrs.h>
#import <sys/socket.h>
#import <net/if.h>
#import <net/if_var.h>
#import <QuartzCore/QuartzCore.h>


@interface KNTAMonitorNetworkService()

@property (assign, nonatomic) NSUInteger uploadBytes;

@property (assign, nonatomic) NSUInteger downloadBytes;

@property (assign, nonatomic) NSUInteger uploadStartBytes;

@property (assign, nonatomic) NSUInteger downloadStartBytes;

@property (assign, nonatomic) CFTimeInterval timeStamp;

@property (assign, nonatomic) long lastUploadBytes;

@property (assign, nonatomic) long lastDownloadBytes;

@end


KNTAMonitorNetworkService *sharedService = nil;

@implementation KNTAMonitorNetworkService

+ (KNTAMonitorNetworkService *)sharedService
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedService = [[KNTAMonitorNetworkService alloc] init];
    });
    return sharedService;
}

- (void)update
{
    struct ifaddrs *ifa_list = 0;
    struct ifaddrs *ifa = 0;
    
    if (getifaddrs(&ifa_list) == -1) {
        return;
    }
    
    uint32_t iBytes = 0;
    uint32_t oBytes = 0;

    uint32_t wifiIBytes = 0;
    uint32_t wifiOBytes = 0;

    uint32_t wwanIBytes = 0;
    uint32_t wwanOBytes = 0;
    
    struct IF_DATA_TIMEVAL time = {0};
    
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next) {

        if (ifa->ifa_addr->sa_family != AF_LINK) {
            continue;
        }
        
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING)) {
            continue;
        }
        
        if (ifa->ifa_data == 0) {
            continue;
        }
        
        if (strncmp(ifa->ifa_name, "lo", 2)) {
            
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            
            iBytes += if_data->ifi_ibytes;
            oBytes += if_data->ifi_obytes;
            
            time = if_data->ifi_lastchange;
        }
        
        if (strcmp(ifa->ifa_name, "en0") == 0) {
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            
            wifiIBytes += if_data->ifi_ibytes;
            wifiOBytes += if_data->ifi_obytes;
        }
        
        if (strcmp(ifa->ifa_name, "pdp_ip0") == 0) {
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;

            wwanIBytes += if_data->ifi_ibytes;
            wwanOBytes += if_data->ifi_obytes;
        }
        
    }
    
    freeifaddrs(ifa_list);
    
    if (_uploadStartBytes == 0) {
        _uploadStartBytes = oBytes;
    }
    
    if (_downloadStartBytes == 0) {
        _downloadStartBytes = iBytes;
    }
    
    _uploadBytes = oBytes - _uploadStartBytes;
    _downloadBytes = iBytes - _downloadStartBytes;
    
    CFTimeInterval now = CACurrentMediaTime();
    CFTimeInterval diff = now - _timeStamp;
    
    if (diff > 1.0) {
        _uploadSpeedKBytes = (_uploadBytes - _lastUploadBytes) / 1024.0 / diff;
        _downloadSpeedKBytes = (_downloadBytes - _lastDownloadBytes) / 1024.0 / diff;
        
        _lastUploadBytes = _uploadBytes;
        _lastDownloadBytes = _downloadBytes;
        
        _timeStamp = now;
        
    }
}

@end
