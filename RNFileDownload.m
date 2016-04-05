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

RCT_EXPORT_METHOD(download:(NSString *)source targetPath:(NSString *)targetPath headers:(NSDictionary *)headers callback:(RCTResponseSenderBlock)callback) {
    NSURL *URL = [NSURL URLWithString:source];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    for (NSString *key in headers.allKeys){
        [request setValue:headers[key] forHTTPHeaderField:key];
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request
                                                            completionHandler:
                                              ^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                  NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                  if ([httpResponse statusCode]>=400){
                                                      NSLog(@"HTTP RESPONSE CODE %d", [httpResponse statusCode]);
                                                      callback(@[[NSString stringWithFormat:@"Error http status code: %d", [httpResponse statusCode]]]);
                                                  } else if (!error) {
                                                      NSURL *targetDirectoryURL = [NSURL fileURLWithPath:targetPath];
                                                      BOOL isDirectory;
                                                      BOOL fileExistsAtPath = [[NSFileManager defaultManager] fileExistsAtPath:targetPath isDirectory:&isDirectory];

                                                      NSURL *targetURL = fileExistsAtPath && isDirectory ? [targetDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]] : targetDirectoryURL;
                                                      
                                                      [[NSFileManager defaultManager] moveItemAtURL:location
                                                                                              toURL:targetURL
                                                                                              error:nil];
                                                      callback(@[[NSNull null], targetURL.absoluteString]);
                                                  } else {
                                                      NSLog(@"%@", [error description]);
                                                      callback(@[[error description]]);
                                                  }
                                              }
                                              ];
    
    [downloadTask resume];
}

@end
