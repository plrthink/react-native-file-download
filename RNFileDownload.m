//
//  RNFileDownload.m
//  RNFileDownload
//
//  Created by Perry Poon on 8/31/15.
//  Copyright (c) 2015 Perry Poon. All rights reserved.
//

#import "RNFileDownload.h"

@implementation RNFileDownload

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(download:(NSString *)source targetPath:(NSString *)targetPath callback:(RCTResponseSenderBlock)callback) {
    NSURL *URL = [NSURL URLWithString:source];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request
                                                            completionHandler:
                                              ^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                  if (!error) {
                                                      NSURL *targetDirectoryURL = [NSURL fileURLWithPath:targetPath];
                                                      NSURL *targetURL = [targetDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
                                                      [[NSFileManager defaultManager] moveItemAtURL:location
                                                                                              toURL:targetURL
                                                                                              error:nil];
                                                      callback(@[@0]);
                                                  } else {
                                                      NSLog(@"%@", [error description]);
                                                      callback(@[@1]);
                                                  }
                                              }
                                              ];
    
    [downloadTask resume];
}

@end
