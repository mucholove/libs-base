#ifndef __NSURLSession_h_GNUSTEP_BASE_INCLUDE
#define __NSURLSession_h_GNUSTEP_BASE_INCLUDE

#import <Foundation/NSObject.h>
#import <Foundation/NSURLCredential.h>
#import <Foundation/NSURLProtectionSpace.h>
#import <Foundation/NSURLRequest.h>
#import <Foundation/NSDateInterval.h>
#import <Foundation/NSHTTPCookieStorage.h>

@protocol NSURLSessionDelegate;
@protocol NSURLSessionTaskDelegate;

@class
    NSArray,
    NSData,
    NSError,
    NSNumber,
    NSString,
    //--
    NSURLAuthenticationChallenge,
    //---
    NSInputStream,
    NSOutputStream,
    //---
    NSOperationQueue,
    //---
    NSNetService,
    NSHTTPCookieStorage,
    //---
    NSURLCredential,
    NSURLCredentialStorage,
    NSURLProtectionSpace,
    //---
    NSURL,
    NSURLCache,
    NSCachedURLResponse,
    NSURLRequest,
    NSURLResponse,
    NSHTTPURLResponse,
    //---
    NSURLSession,
    NSURLSessionConfiguration,
    NSURLSessionWebSocketTask,
    NSURLCredential,
    NSURLSessionStreamTask,
    NSURLSessionDataTask;
/*
 * Disposition options for various delegate messages
 */
#if OS_API_VERSION(MAC_OS_X_VERSION_10_13,GS_API_LATEST)
typedef NS_ENUM(NSInteger, NSURLSessionDelayedRequestDisposition) {
    NSURLSessionDelayedRequestContinueLoading = 0,  /* Use the original request provided when the task was created; the request parameter is ignored. */
    NSURLSessionDelayedRequestUseNewRequest = 1,    /* Use the specified request, which may not be nil. */
    NSURLSessionDelayedRequestCancel = 2,           /* Cancel the task; the request parameter is ignored. */
};
#endif

#if OS_API_VERSION(MAC_OS_X_VERSION_10_9,GS_API_LATEST)
typedef NS_ENUM(NSInteger, NSURLSessionAuthChallengeDisposition) {
    NSURLSessionAuthChallengeUseCredential = 0,                                       /* Use the specified credential, which may be nil */
    NSURLSessionAuthChallengePerformDefaultHandling = 1,                              /* Default handling for the challenge - as if this delegate were not implemented; the credential parameter is ignored. */
    NSURLSessionAuthChallengeCancelAuthenticationChallenge = 2,                       /* The entire request will be canceled; the credential parameter is ignored. */
    NSURLSessionAuthChallengeRejectProtectionSpace = 3,                               /* This challenge is rejected and the next authentication protection space should be tried; the credential parameter is ignored. */
};


typedef NS_ENUM(NSInteger, NSURLSessionResponseDisposition) {
    NSURLSessionResponseCancel = 0,                                      /* Cancel the load, this is the same as -[task cancel] */
    NSURLSessionResponseAllow = 1,                                       /* Allow the load to continue */
    NSURLSessionResponseBecomeDownload = 2,                              /* Turn this request into a download */
    NSURLSessionResponseBecomeStream = 3,  /* Turn this task into a stream task */
};
#endif


typedef void (^NSURLSessionTaskCompletionHandler)(NSData*, NSURLResponse *, NSError *);
typedef void (^NSURLSessionRedirectCompletioHandler)(NSURLRequest *);


@interface NSURLCredential (GNUstepNetworkingAdditions)

+(id)credentialForTrust:(id)serverTrust;
@end

@interface NSURLProtectionSpace (GNUstepNetworkingAdditions)



-(id)serverTrust;

@end



#if OS_API_VERSION(MAC_OS_X_VERSION_10_1,GS_API_LATEST)
typedef NS_ENUM(NSUInteger, NSURLRequestNetworkServiceType)
{
    NSURLNetworkServiceTypeDefault          = 0,  // Standard internet traffic
    NSURLNetworkServiceTypeVoIP             = 1,  // Voice over IP control traffic
    NSURLNetworkServiceTypeVideo            = 2,  // Video traffic
    NSURLNetworkServiceTypeBackground       = 3,  // Background traffic
    NSURLNetworkServiceTypeVoice            = 4,  // Voice data
    NSURLNetworkServiceTypeResponsiveData   = 6,  // Responsive data
    #if OS_API_VERSION(MAC_OS_X_VERSION_10_9,GS_API_LATEST)
    NSURLNetworkServiceTypeAVStreaming      = 8,  // Multimedia Audio/Video Streaming
    NSURLNetworkServiceTypeResponsiveAV     = 9,  // Responsive Multimedia Audio/Video
    #endif
    #if OS_API_VERSION(MAC_OS_X_VERSION_10_12,GS_API_LATEST)
    NSURLNetworkServiceTypeCallSignaling    = 11, // Call Signaling
    #endif
};
#endif

#if OS_API_VERSION(MAC_OS_X_VERSION_10_1,GS_API_LATEST)
typedef NS_ENUM(NSInteger, NSURLSessionMultipathServiceType)
{
    NSURLSessionMultipathServiceTypeNone        = 0,  /* None - no multipath (default) */
    NSURLSessionMultipathServiceTypeHandover    = 1,  /* Handover - secondary flows brought up when primary flow is not performing adequately. */
    NSURLSessionMultipathServiceTypeInteractive = 2,  /* Interactive - secondary flows created more aggressively. */
    NSURLSessionMultipathServiceTypeAggregate   = 3   /* Aggregate - multiple subflows used for greater bandwitdh. */
};


@interface NSURLSessionTask : NSObject

-(void)setTaskIdentifier:( NSUInteger )newVar;
-(NSUInteger)taskIdentifier;

-(void)setOriginalRequest:( NSURLRequest* )newVar;
-(NSURLRequest*)originalRequest;

-(void)setCurrentRequest:( NSURLRequest* )newVar;
-(NSURLRequest*)currentRequest;

-(void)setResponse:( NSURLResponse* )newVar;
-(NSURLResponse*)response;

-(void)setProgress:( id )newVar;
-(id)progress;

-(void)setEarliestBeginDate:( NSDate* )newVar;
-(NSDate*)earliestBeginDate;

-(void)setTaskDescription:( NSString* )newVar;
-(NSString*)taskDescription;

-(void)countOfBytesClientExpectsToSend:( int64_t )newVar;
-(int64_t)countOfBytesClientExpectsToSend;

-(void)countOfBytesClientExpectsToReceive:( int64_t )newVar;
-(int64_t)countOfBytesClientExpectsToReceive;

-(void)setCountOfBytesReceieved:( int64_t )newVar;
-(int64_t)countOfBytesReceived;

-(void)setCountOfBytesSent:( int64_t )newVar;
-(int64_t)countOfBytesSent;

-(void)setCountOfBytesExpectedToSend:( int64_t )newVar;
-(int64_t)countOfBytesExpectedToSend;

-(void)setCountOfBytesExpectedToReceive:( int64_t )newVar;
-(int64_t)countOfBytesExpectedToReceive;

-(void)setPriority:( float )newVar;
-(float)priority;

-(void)cancel;
-(void)suspend;
-(void)resume;

@end

@interface NSURLSessionDataTask : NSURLSessionTask
@end

@interface NSURLSessionUploadTask : NSURLSessionDataTask
@end

@interface NSURLSessionDownloadTask : NSURLSessionDataTask
- (void)cancelByProducingResumeData:(void (^)(NSData * resumeData))completionHandler;
@end


@interface NSURLSessionStreamTask : NSURLSessionTask
- (void)
    readDataOfMinLength:(NSUInteger)minBytes
    maxLength:(NSUInteger)maxBytes
    timeout:(NSTimeInterval)timeout
    completionHandler:(void (^) (NSData *data, BOOL atEOF, NSError *error))completionHandler;
- (void)
    writeData:(NSData *)data
    timeout:(NSTimeInterval)timeout
    completionHandler:(void (^) (NSError * error))completionHandler;
- (void)captureStreams;
- (void)closeWrite;
- (void)closeRead;
- (void)startSecureConnection;
- (void)stopSecureConnection;
@end



#if OS_API_VERSION(MAC_OS_X_VERSION_10_15,GS_API_LATEST)
typedef NS_ENUM(NSInteger, NSURLSessionWebSocketCloseCode)
{
    NSURLSessionWebSocketCloseCodeInvalid                           =    0,
    NSURLSessionWebSocketCloseCodeNormalClosure                     = 1000,
    NSURLSessionWebSocketCloseCodeGoingAway                         = 1001,
    NSURLSessionWebSocketCloseCodeProtocolError                     = 1002,
    NSURLSessionWebSocketCloseCodeUnsupportedData                   = 1003,
    NSURLSessionWebSocketCloseCodeNoStatusReceived                  = 1005,
    NSURLSessionWebSocketCloseCodeAbnormalClosure                   = 1006,
    NSURLSessionWebSocketCloseCodeInvalidFramePayloadData           = 1007,
    NSURLSessionWebSocketCloseCodePolicyViolation                   = 1008,
    NSURLSessionWebSocketCloseCodeMessageTooBig                     = 1009,
    NSURLSessionWebSocketCloseCodeMandatoryExtensionMissing         = 1010,
    NSURLSessionWebSocketCloseCodeInternalServerError               = 1011,
    NSURLSessionWebSocketCloseCodeTLSHandshakeFailure               = 1015,
};
typedef NS_ENUM(NSInteger, NSURLSessionWebSocketMessageType) {
    NSURLSessionWebSocketMessageTypeData   = 0,
    NSURLSessionWebSocketMessageTypeString = 1,
};
@interface NSURLSessionWebSocketMessage : NSObject

- (instancetype)
    initWithData:(NSData *)data;

- (instancetype)
    initWithString:(NSString *)string;

@property (readonly) NSURLSessionWebSocketMessageType type;
@property (readonly, copy) NSData *data;
@property (readonly, copy) NSString *string;

- (instancetype)init;
+ (instancetype)new;

@end

@interface NSURLSessionWebSocketTask : NSURLSessionTask


- (void)
    sendMessage:(NSURLSessionWebSocketMessage *)message
    completionHandler:(void (^)(NSError * error))completionHandler;

- (void)
    receiveMessageWithCompletionHandler:(void (^)(NSURLSessionWebSocketMessage* message, NSError * error))completionHandler;
    
- (void)
    sendPingWithPongReceiveHandler:(void (^)(NSError* error))pongReceiveHandler;
    
- (void)
    cancelWithCloseCode:(NSURLSessionWebSocketCloseCode)closeCode
    reason:(NSData *)reason;


@property NSInteger maximumMessageSize;
@property (readonly) NSURLSessionWebSocketCloseCode closeCode;
@property (readonly, copy) NSData *closeReason;

- (instancetype)init;
+ (instancetype)new;
@end
#endif


@interface NSURLSession : NSObject

+(NSURLSession*)sharedSession;





+ (NSURLSession *)
    sessionWithConfiguration:(NSURLSessionConfiguration *)configuration;
+ (NSURLSession *)
    sessionWithConfiguration:(NSURLSessionConfiguration *)configuration
    delegate:(id <NSURLSessionDelegate>)delegate
    delegateQueue:(NSOperationQueue *)queue;

-(void)setDelegateQueue:( NSOperationQueue* )newVar;
-(NSOperationQueue*)delegateQueue;;
-(void)setDelegate:( id<NSURLSessionDelegate> )newVar; -(id<NSURLSessionDelegate>)delegate;;
-(void)setConfiguration:( NSURLSessionConfiguration* )newVar; -(NSURLSessionConfiguration*)configuration;;
-(void)setSessionDescription:( NSString* )newVar; -(NSString*)sessionDescription;;





- (void)finishTasksAndInvalidate;

- (void)invalidateAndCancel;







- (void)
    resetWithCompletionHandler:(void (^)(void))completionHandler;
- (void)
    flushWithCompletionHandler:(void (^)(void))completionHandler;

- (void)
    getTasksWithCompletionHandler:(void (^)(NSArray*dataTasks, NSArray*uploadTasks, NSArray*downloadTasks))completionHandler;
    // getTasksWithCompletionHandler:(void (^)(NSArray<NSURLSessionDataTask *> *dataTasks, NSArray<NSURLSessionUploadTask *> *uploadTasks, NSArray<NSURLSessionDownloadTask *> *downloadTasks))completionHandler;

- (void)
    getAllTasksWithCompletionHandler:(void (^)(NSArray*tasks))completionHandler;


- (NSURLSessionDataTask *)
    dataTaskWithRequest:(NSURLRequest *)request
    completionHandler:(void(^)(NSData*, NSURLResponse *, NSError *))completionHandler;






- (NSURLSessionDataTask *)
    dataTaskWithRequest:(NSURLRequest *)request;


- (NSURLSessionDataTask *)
    dataTaskWithURL:(NSURL *)url;


- (NSURLSessionUploadTask *)
    uploadTaskWithRequest:(NSURLRequest *)request
    fromFile:(NSURL *)fileURL;


- (NSURLSessionUploadTask *)
    uploadTaskWithRequest:(NSURLRequest *)request
    fromData:(NSData *)bodyData;


- (NSURLSessionUploadTask *)
    uploadTaskWithStreamedRequest:(NSURLRequest *)request;


- (NSURLSessionDownloadTask *)
    downloadTaskWithRequest:(NSURLRequest *)request;


- (NSURLSessionDownloadTask *)
    downloadTaskWithURL:(NSURL *)url;


- (NSURLSessionDownloadTask *)
    downloadTaskWithResumeData:(NSData *)resumeData;



- (NSURLSessionStreamTask *)
    streamTaskWithHostName:(NSString *)hostname
    port:(NSInteger)port;




- (NSURLSessionStreamTask *)
    streamTaskWithNetService:(NSNetService *)service;




- (NSURLSessionWebSocketTask *)
    webSocketTaskWithURL:(NSURL *)url;





- (NSURLSessionWebSocketTask *)
    webSocketTaskWithURL:(NSURL *)url
    protocols:(NSArray*)protocols;






- (NSURLSessionWebSocketTask *)
    webSocketTaskWithRequest:(NSURLRequest *)request;




@end

@interface NSURLSessionConfiguration : NSObject
+(id)defaultSessionConfiguration;
+(id)ephemeralSessionConfiguration;
+(id)backgroundSessionConfigurationWithIdentifier:(id)theIdentifier;

-(void)setIdentifier:( NSString* )newVar; -(NSString*)identifier;;
-(void)setHTTPAdditionalHeaders:( NSDictionary* )newVar; -(NSDictionary*)HTTPAdditionalHeaders;;
-(void)setAllows:( NSString* )newVar; -(NSString*)sharedContainerIdentifier;;
-(void)setHTTPCookieStorage:( NSHTTPCookieStorage* )newVar; -(NSHTTPCookieStorage*)HTTPCookieStorage;;
-(void)setURLCredentialStorage:( NSURLCredentialStorage* )newVar; -(NSURLCredentialStorage*)URLCredentialStorage;;
-(void)setURLCache:( NSURLCache* )newVar; -(NSURLCache*)URLCache;;
// -(void)setProtocolClasses:( NSArray<Class>* )newVar; -(NSArray<Class>*)protocolClasses;;
-(void)setProtocolClasses:( NSArray* )newVar; -(NSArray*)protocolClasses;;
-(void)setConnectionProxyDictionary:( NSDictionary* )newVar; -(NSDictionary*)connectionProxyDictionary;;

-(void)setRequestCachePolicy:( NSURLRequestCachePolicy )newVar; -(NSURLRequestCachePolicy)requestCachePolicy;;
-(void)setTimeoutIntervalForRequest:( NSTimeInterval )newVar; -(NSTimeInterval)timeoutIntervalForRequest;;
-(void)setTimeoutIntervalForResource:( NSTimeInterval )newVar; -(NSTimeInterval)timeoutIntervalForResource;;
-(void)setNetworkServiceType:( NSURLRequestNetworkServiceType )newVar; -(NSURLRequestNetworkServiceType)networkServiceType;;
-(void)setAllowsCellularAccess:( BOOL )newVar; -(BOOL)allowsCellularAccess;;
-(void)setAllowsExpensiveNetworkAccess:( BOOL )newVar; -(BOOL)allowsExpensiveNetworkAccess;;;
-(void)setAllowsConstrainedNetworkAccess:( BOOL )newVar; -(BOOL)allowsConstrainedNetworkAccess;;;
-(void)setWaitsForConnectivity:( BOOL )newVar; -(BOOL)waitsForConnectivity;;
-(void)setDiscretionary:( BOOL )newVar; -(BOOL)discretionary;;
-(void)setSessionSendsLaunchEvents:( BOOL )newVar; -(BOOL)sessionSendsLaunchEvents;;;




-(void)setHTTPShouldUsePipelining:( BOOL )newVar;
-(BOOL)HTTPShouldUsePipelining;;

-(void)setHTTPShouldSetCookies:( BOOL )newVar;
-(BOOL)HTTPShouldSetCookies;;

-(void)setHTTPCookieAcceptPolicy:( NSHTTPCookieAcceptPolicy )newVar;
-(NSHTTPCookieAcceptPolicy)HTTPCookieAcceptPolicy;

-(void)setHTTPMaximumConnectionsPerHost:( NSInteger )newVar;
 -(NSInteger)HTTPMaximumConnectionsPerHost;
 
-(void)setShouldUseExtendedBackgroundIdleMode:( BOOL )newVar;
-(BOOL)shouldUseExtendedBackgroundIdleMode;

-(void)setMultipathServiceType:( NSURLSessionMultipathServiceType )newVar;
-(NSURLSessionMultipathServiceType)multipathServiceType;
@end





@protocol NSURLSessionDelegate <NSObject>
@optional

- (void)
    URLSession:(NSURLSession *)session
    didBecomeInvalidWithError:(NSError *)error;
- (void)
    URLSession:(NSURLSession *)session
    didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
    completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * credential))completionHandler;
- (void)
    URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session;
@end


#if OS_API_VERSION(MAC_OS_X_VERSION_10_12,GS_API_LATEST)
typedef NS_ENUM(NSInteger, NSURLSessionTaskMetricsResourceFetchType) {
    NSURLSessionTaskMetricsResourceFetchTypeUnknown,
    NSURLSessionTaskMetricsResourceFetchTypeNetworkLoad,   // The resource was loaded over the network.
    NSURLSessionTaskMetricsResourceFetchTypeServerPush,    // The resource was pushed by the server to the client.
    NSURLSessionTaskMetricsResourceFetchTypeLocalCache,    // The resource was retrieved from the local storage.
};
@interface NSURLSessionTaskTransactionMetrics : NSObject
@property (copy, readonly) NSURLRequest *request;
@property (copy, readonly) NSURLResponse *response;
@property (copy, readonly) NSDate *fetchStartDate;
@property (copy, readonly) NSDate *domainLookupStartDate;
@property (copy, readonly) NSDate *domainLookupEndDate;
@property (copy, readonly) NSDate *connectStartDate;
@property (copy, readonly) NSDate *secureConnectionStartDate;
@property (copy, readonly) NSDate *secureConnectionEndDate;
@property (copy, readonly) NSDate *connectEndDate;
@property (copy, readonly) NSDate *requestStartDate;
@property (copy, readonly) NSDate *requestEndDate;
@property (copy, readonly) NSDate *responseStartDate;
@property (copy, readonly) NSDate *responseEndDate;
@property (copy, readonly) NSString *networkProtocolName;
@property (assign, readonly, getter=isProxyConnection) BOOL proxyConnection;
@property (assign, readonly, getter=isReusedConnection) BOOL reusedConnection;


@property (readonly) int64_t countOfRequestHeaderBytesSent;
@property (readonly) int64_t countOfRequestBodyBytesSent;
@property (readonly) int64_t countOfRequestBodyBytesBeforeEncoding;
@property (readonly) int64_t countOfResponseHeaderBytesReceived;
@property (readonly) int64_t countOfResponseBodyBytesReceived;
@property (readonly) int64_t countOfResponseBodyBytesAfterDecoding;
@property (copy, readonly) NSString *localAddress;
@property (copy, readonly) NSNumber *localPort;
@property (copy, readonly) NSString *remoteAddress;
@property (copy, readonly) NSNumber *remotePort;
@property (copy, readonly) NSNumber *negotiatedTLSProtocolVersion;
@property (copy, readonly) NSNumber *negotiatedTLSCipherSuite;
@property (readonly, getter=isCellular) BOOL cellular;
@property (readonly, getter=isExpensive) BOOL expensive;
@property (readonly, getter=isConstrained) BOOL constrained;
@property (readonly, getter=isMultipath) BOOL multipath;

@end

@interface NSURLSessionTaskMetrics : NSObject

// @property (copy, readonly) NSArray<NSURLSessionTaskTransactionMetrics *> *transactionMetrics;
@property (copy, readonly) NSArray *transactionMetrics;
// @property (copy, readonly) NSDateInterval *taskInterval;
@property (assign, readonly) NSDateInterval *taskInterval;
@property (assign, readonly) NSUInteger redirectCount;

@end
#endif




@protocol NSURLSessionTaskDelegate <NSURLSessionDelegate>
@optional

- (void)
    URLSession:(NSURLSession *)session
    task:(NSURLSessionTask *)task
    willBeginDelayedRequest:(NSURLRequest *)request
    completionHandler:(void (^)(NSURLSessionDelayedRequestDisposition disposition, NSURLRequest * newRequest))completionHandler;
- (void)
    URLSession:(NSURLSession *)session
    taskIsWaitingForConnectivity:(NSURLSessionTask *)task;

- (void)
    URLSession:(NSURLSession *)session
    task:(NSURLSessionTask *)task
    willPerformHTTPRedirection:(NSHTTPURLResponse *)response
    newRequest:(NSURLRequest *)request
    completionHandler:(void (^)(NSURLRequest *))completionHandler;


- (void)
    URLSession:(NSURLSession *)session
    task:(NSURLSessionTask *)task
    didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
    completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * credential))completionHandler;

- (void)
    URLSession:(NSURLSession *)session
    task:(NSURLSessionTask *)task
    needNewBodyStream:(void (^)(NSInputStream * bodyStream))completionHandler;






- (void)
    URLSession:(NSURLSession *)session
    task:(NSURLSessionTask *)task
    didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
    totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend;





- (void)
    URLSession:(NSURLSession *)session
    task:(NSURLSessionTask *)task
    didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics;




- (void)
    URLSession:(NSURLSession *)session
    task:(NSURLSessionTask *)task
    didCompleteWithError:(NSError *)error;






@end





@protocol NSURLSessionDataDelegate <NSURLSessionTaskDelegate>
@optional

- (void)
    URLSession:(NSURLSession *)session
    dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveResponse:(NSURLResponse *)response
    completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler;

- (void)
    URLSession:(NSURLSession *)session
    dataTask:(NSURLSessionDataTask *)dataTask
    didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask;





- (void)
    URLSession:(NSURLSession *)session
    dataTask:(NSURLSessionDataTask *)dataTask
    didBecomeStreamTask:(NSURLSessionStreamTask *)streamTask;
- (void)
    URLSession:(NSURLSession *)session
    dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data;
- (void)
    URLSession:(NSURLSession *)session
    dataTask:(NSURLSessionDataTask *)dataTask
    willCacheResponse:(NSCachedURLResponse *)proposedResponse
    completionHandler:(void (^)(NSCachedURLResponse * cachedResponse))completionHandler;
@end


@protocol NSURLSessionDownloadDelegate <NSURLSessionTaskDelegate>
- (void)
    URLSession:(NSURLSession *)session
    downloadTask:(NSURLSessionDownloadTask *)downloadTask
    didFinishDownloadingToURL:(NSURL *)location;
@optional
- (void)
    URLSession:(NSURLSession *)session
    downloadTask:(NSURLSessionDownloadTask *)downloadTask
    didWriteData:(int64_t)bytesWritten
    totalBytesWritten:(int64_t)totalBytesWritten
    totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite;
- (void)
    URLSession:(NSURLSession *)session
    downloadTask:(NSURLSessionDownloadTask *)downloadTask
    didResumeAtOffset:(int64_t)fileOffset
    expectedTotalBytes:(int64_t)expectedTotalBytes;
@end

@protocol NSURLSessionStreamDelegate <NSURLSessionTaskDelegate>
@optional
- (void)
    URLSession:(NSURLSession *)session
    readClosedForStreamTask:(NSURLSessionStreamTask *)streamTask;
- (void)
    URLSession:(NSURLSession *)session
    writeClosedForStreamTask:(NSURLSessionStreamTask *)streamTask;
- (void)
    URLSession:(NSURLSession *)session
    betterRouteDiscoveredForStreamTask:(NSURLSessionStreamTask *)streamTask;
- (void)
    URLSession:(NSURLSession *)session
    streamTask:(NSURLSessionStreamTask *)streamTask
    didBecomeInputStream:(NSInputStream *)inputStream
    outputStream:(NSOutputStream *)outputStream;
@end


@protocol NSURLSessionWebSocketDelegate <NSURLSessionTaskDelegate>
@optional


- (void)
    URLSession:(NSURLSession *)session
    webSocketTask:(NSURLSessionWebSocketTask *)webSocketTask
    didOpenWithProtocol:(NSString *) protocol;

- (void)
    URLSession:(NSURLSession *)session
    webSocketTask:(NSURLSessionWebSocketTask *)webSocketTask
    didCloseWithCode:(NSURLSessionWebSocketCloseCode)closeCode
    reason:(NSData *)reason;

@end

#endif
#endif

