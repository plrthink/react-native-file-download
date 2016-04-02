//
//  RNFileDownloadSessionManager.h
//  RNFileDownload
//
//  Created by Luavis Kang on 4/2/16.
//  Copyright © 2016 Perry Poon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#import "RNFileDownload.h"

#define RANDOM_FILENAME_LENGTH 10

@interface RNFileDownloadSessionManager : NSObject<NSURLSessionDownloadDelegate>
@property (nonatomic, strong) RCTResponseSenderBlock callback;
@property (nonatomic, strong) RCTBridge *bridge;
@property (nonatomic, strong, readonly) NSString *targetPath;
@property (nonatomic, strong, readonly) NSString *downloadFileName;

- (instancetype)initWithTargetPath:(NSString *)targetPath downloadFileName:(NSString *)fileName bridge:(RCTBridge *)bridge callback:(RCTResponseSenderBlock)callback;

@end
