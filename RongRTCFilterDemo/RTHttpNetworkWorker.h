//
//  RTHttpNetworkWorker.h
//  RTCTester
//
//  Created by birney on 2019/1/23.
//  Copyright © 2019年 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RTHttpNetworkWorker : NSObject

+ (instancetype)shareInstance;

- (void)fetchTokenWithUserId:(NSString*)usrId
                        name:(NSString*)usrName
                     success:(void (^)(NSString* token))sucess
                       error:(void (^)(NSError* error))errorBlock;

@end


NS_ASSUME_NONNULL_END
