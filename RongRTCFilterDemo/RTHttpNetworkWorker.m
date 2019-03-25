//
//  RTHttpNetworkWorker.m
//  RTCTester
//
//  Created by birney on 2019/1/23.
//  Copyright © 2019年 RongCloud. All rights reserved.
//

#import "RTHttpNetworkWorker.h"
//#include <CommonCrypto/CommonHMAC.h>

extern NSString* const RCIMAPPKey;
extern NSString* const RCAppSecret;

static RTHttpNetworkWorker* defaultWorker = nil;

@implementation RTHttpNetworkWorker

+ (instancetype)shareInstance {
    if (!defaultWorker) {
        defaultWorker = [[RTHttpNetworkWorker alloc] init];
    }
    return defaultWorker;
}

+ (instancetype) allocWithZone:(struct _NSZone *)zone {
    if (!defaultWorker) {
        defaultWorker = [super allocWithZone:zone];
    }
    return defaultWorker;
}

- (instancetype) copy{
    return defaultWorker;
}


- (void)fetchTokenWithUserId:(NSString*)usrId
                        name:(NSString*)usrName
                     success:(void (^)(NSString* token))sucess
                       error:(void (^)(NSError* error))errorBlock {

    NSURL* urlPost = [NSURL URLWithString:@"https://apiqa.rongcloud.net/user/get_token_new"];
    NSMutableURLRequest *request  = [NSMutableURLRequest requestWithURL:urlPost];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//    NSString* body = [NSString stringWithFormat:@"userId=%@&name=%@",usrId,usrName];
//    NSDictionary *dic = @{@"id":usrId,@"appkey": @"e0x9wycfx7flq",@"secret": @"UfmrYyG1lpE",@"url": @"http://apixq.rongcloud.net:9200"};
    NSDictionary *dic = @{@"id":usrId};

    NSData* data = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:nil];
    request.HTTPBody = data;
    
    NSURLSession* session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error %@",error);
            errorBlock(error);
        }
        else{
            NSDictionary* responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary* result = responseObject[@"result"];
            NSString* token = result[@"token"];
            sucess(token);
        }
        [session finishTasksAndInvalidate];
    }] resume];

}

@end
