//
//  RNFileDownload.m
//  RNFileDownload
//
//  Created by Perry Poon on 8/31/15.
//  Copyright (c) 2015 Perry Poon. All rights reserved.
//

#import "RNFileDownload.h"
#import "RNFileDownloadSessionManager.h"

@implementation RNFileDownload
@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(download:(NSString *)source targetPath:(NSString *)targetPath downloadFileName:(NSString *)fileName headers:(NSDictionary *)headers callback:(RCTResponseSenderBlock)callback) {
    if(!source)
        callback(@[@"source need to be not null"]);
    if(!targetPath)
        callback(@[@"targetPath need to be not null"]);

    NSURL *URL = [NSURL URLWithString:source];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    for (NSString *key in headers.allKeys){
        [request setValue:headers[key] forHTTPHeaderField:key];
    }

    RNFileDownloadSessionManager *manager = [[RNFileDownloadSessionManager alloc] initWithTargetPath:targetPath
                                                                                    downloadFileName:fileName
                                                                                              bridge:self.bridge
                                                                                            callback:callback];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSession sharedSession].delegate
                                                          delegate:manager
                                                     delegateQueue:[NSOperationQueue mainQueue]];

    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request];

    [downloadTask resume];
}

@end
