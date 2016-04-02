//
//  RNFileDownloadSessionManager.m
//  RNFileDownload
//
//  Created by Luavis Kang on 4/2/16.
//  Copyright © 2016 Perry Poon. All rights reserved.
//

#import "RNFileDownloadSessionManager.h"

@implementation RNFileDownloadSessionManager

- (instancetype)initWithTargetPath:(NSString *)targetPath downloadFileName:(NSString *)fileName bridge:(RCTBridge *)bridge callback:(RCTResponseSenderBlock)callback
{
    self = [super init];
    if (self) {
        self.bridge = bridge;
        self.callback = callback;
        _targetPath = targetPath;
        _downloadFileName = fileName;
    }
    return self;
}

#pragma mark - Session delegates

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    if(_downloadFileName == nil) {
        _downloadFileName = downloadTask.response.suggestedFilename;

        if(!self.downloadFileName)
            _downloadFileName = [self randomStringWithLength:RANDOM_FILENAME_LENGTH];
    }

    if(bytesWritten > 0 && self.bridge != nil)
        [self.bridge.eventDispatcher sendAppEventWithName:[@"RNFileDownloadProgress" stringByAppendingString:downloadTask.originalRequest.URL.absoluteString]
                                                     body:@{
                                                                @"filename": self.downloadFileName,
                                                                @"sourceUrl": downloadTask.originalRequest.URL.absoluteString,
                                                                @"targetPath": self.targetPath,
                                                                @"bytesWritten": @(bytesWritten),
                                                                @"totalBytesWritten": @(totalBytesWritten),
                                                                @"totalBytesExpectedToWrite": @(totalBytesExpectedToWrite),
                                                            }];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
        NSURL *targetDirectoryURL = [NSURL fileURLWithPath:self.targetPath];
        NSURL *targetURL = [targetDirectoryURL URLByAppendingPathComponent:self.downloadFileName];
        [[NSFileManager defaultManager] moveItemAtURL:location
                                                toURL:targetURL
                                                error:nil];
    self.callback(@[[NSNull null], targetURL.absoluteString]);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if([error description] != nil) {
        NSLog(@"RNFileDownload error: %@", [error description]);
        self.callback(@[[error description]]);
    }
}

#pragma mark - Tools

- (NSString *)randomStringWithLength: (int) len {
    static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];

    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }

    return randomString;
}

@end
