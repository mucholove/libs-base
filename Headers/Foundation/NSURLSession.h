#ifndef __NSURLSession_h_GNUSTEP_BASE_INCLUDE
#define __NSURLSession_h_GNUSTEP_BASE_INCLUDE

#import <Foundation/NSObject.h>

#if OS_API_VERSION(MAC_OS_X_VERSION_10_9,GS_API_LATEST)
@protocol NSURLSessionDelegate;
@protocol NSURLSessionTaskDelegate;

/*
 * Disposition options for various delegate messages
 */
typedef NS_ENUM(NSInteger, NSURLSessionDelayedRequestDisposition) {
    NSURLSessionDelayedRequestContinueLoading = 0,  /* Use the original request provided when the task was created; the request parameter is ignored. */
    NSURLSessionDelayedRequestUseNewRequest   = 1,  /* Use the specified request, which may not be nil. */
    NSURLSessionDelayedRequestCancel          = 2,  /* Cancel the task; the request parameter is ignored. */
};

typedef NS_ENUM(NSInteger, NSURLSessionAuthChallengeDisposition) {
    NSURLSessionAuthChallengeUseCredential                 = 0,                                       /* Use the specified credential, which may be nil */
    NSURLSessionAuthChallengePerformDefaultHandling        = 1,                              /* Default handling for the challenge - as if this delegate were not implemented; the credential parameter is ignored. */
    NSURLSessionAuthChallengeCancelAuthenticationChallenge = 2,                       /* The entire request will be canceled; the credential parameter is ignored. */
    NSURLSessionAuthChallengeRejectProtectionSpace         = 3,                               /* This challenge is rejected and the next authentication protection space should be tried; the credential parameter is ignored. */
};

typedef NS_ENUM(NSInteger, NSURLSessionResponseDisposition) {
    NSURLSessionResponseCancel         = 0,  /* Cancel the load, this is the same as -[task cancel] */
    NSURLSessionResponseAllow          = 1,  /* Allow the load to continue */
    NSURLSessionResponseBecomeDownload = 2,  /* Turn this request into a download */
    NSURLSessionResponseBecomeStream   = 3,  /* Turn this task into a stream task */
};

@interface NSURLSession : NSObject
@end

@interface NSURLSessionConfiguration : NSObject <NSCopying>
@end

@interface NSURLSessionTask : NSObject <NSCopying>
@end

@interface NSURLSessionDataTask : NSURLSessionTask
@end

@interface NSURLSessionUploadTask : NSURLSessionDataTask
@end

@interface NSURLSessionDownloadTask : NSURLSessionTask
@end

#if OS_API_VERSION(MAC_OS_X_VERSION_10_11,GS_API_LATEST)
@interface NSURLSessionStreamTask : NSURLSessionTask
@end
#endif

@protocol NSURLSessionDelegate <NSObject>
@end

@protocol NSURLSessionTaskDelegate <NSURLSessionDelegate>
@end

#endif
#endif
