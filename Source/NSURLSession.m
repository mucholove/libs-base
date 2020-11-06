#import "Foundation/NSURLSession.h"
#import "Foundation/NSURLRequest.h"
#import "Foundation/NSURLAuthenticationChallenge.h"
#import "Foundation/NSURLProtectionSpace.h"
#import "Foundation/NSURLCredential.h"
#import "Foundation/NSURLCredentialStorage.h"
#import "Foundation/NSException.h"
#import "Foundation/NSURLProtocol.h"
#import "Foundation/NSValue.h"
#import "Foundation/NSDictionary.h"
#import "Foundation/NSData.h"
#import "Foundation/NSHTTPCookieStorage.h"
#import "Foundation/NSLock.h"


@interface NSURLSession (GNUStepPlusPlus)
-(void)resumeTask:(NSURLSessionTask*)theTask;
-(void)suspendTask:(NSURLSessionTask*)theTask;
-(void)cancelTask:(NSURLSessionTask*)theTask;
@end

@interface NSURLSessionTask (GNUstepPlusPlus)

-(NSURLSession*)session;
-(void)setSession:(NSURLSession*)theSession;

@end


@implementation NSURLCredential (GNUstepNetworkingAdditions)

 +(id)
    credentialForTrust:(id)serverTrust
{
    return ((void *)0);
}

@end

@implementation NSURLProtectionSpace (GNUstepNetworkingAdditions)



-(id)
    serverTrust
{
    return ((void *)0);
}

@end

@implementation NSURLSessionTaskMetrics
@end

@implementation NSURLSessionTask
{
    NSURLSession *_session;

    NSUInteger taskIdentifier;
    NSURLRequest* originalRequest;
    NSURLRequest* currentRequest;
    NSURLResponse* response;
    id progress;

    NSDate* earliestBeginDate;
    NSString* taskDescription;


    int64_t countOfBytesClientExpectsToSend;
    int64_t countOfBytesClientExpectsToReceive;

    int64_t countOfBytesReceived;
    int64_t countOfBytesSent;
    int64_t countOfBytesExpectedToSend;
    int64_t countOfBytesExpectedToReceive;

    float priority;
}

- (NSUInteger) taskIdentifier { return taskIdentifier; }
-(void) setTaskIdentifier:(NSUInteger)newVar { taskIdentifier = newVar; }


-(NSURLRequest*) originalRequest { return originalRequest; } -(void) setOriginalRequest:(NSURLRequest*)newVar { { id tempValue=(newVar); if ( tempValue!=originalRequest) { if ( tempValue!=(id)self ) { [tempValue retain]; } if ( originalRequest && originalRequest!=(id)self) { [originalRequest release]; } originalRequest = tempValue; } }; };
-(NSURLRequest*) currentRequest { return currentRequest; } -(void) setCurrentRequest:(NSURLRequest*)newVar { { id tempValue=(newVar); if ( tempValue!=currentRequest) { if ( tempValue!=(id)self ) { [tempValue retain]; } if ( currentRequest && currentRequest!=(id)self) { [currentRequest release]; } currentRequest = tempValue; } }; };
-(NSURLResponse*) response { return response; } -(void) setResponse:(NSURLResponse*)newVar { { id tempValue=(newVar); if ( tempValue!=response) { if ( tempValue!=(id)self ) { [tempValue retain]; } if ( response && response!=(id)self) { [response release]; } response = tempValue; } }; };
-(id) progress { return progress; } -(void) setProgress:(id)newVar { { id tempValue=(newVar); if ( tempValue!=progress) { if ( tempValue!=(id)self ) { [tempValue retain]; } if ( progress && progress!=(id)self) { [progress release]; } progress = tempValue; } }; };

-(NSDate*) earliestBeginDate { return earliestBeginDate; } -(void) setEarliestBeginDate:(NSDate*)newVar { { id tempValue=(newVar); if ( tempValue!=earliestBeginDate) { if ( tempValue!=(id)self ) { [tempValue retain]; } if ( earliestBeginDate && earliestBeginDate!=(id)self) { [earliestBeginDate release]; } earliestBeginDate = tempValue; } }; };
-(NSString*) taskDescription { return taskDescription; } -(void) setTaskDescription:(NSString*)newVar { { id tempValue=(newVar); if ( tempValue!=taskDescription) { if ( tempValue!=(id)self ) { [tempValue retain]; } if ( taskDescription && taskDescription!=(id)self) { [taskDescription release]; } taskDescription = tempValue; } }; };


-(void)countOfBytesClientExpectsToSend:(int64_t)newVar { countOfBytesClientExpectsToSend=newVar; } -(int64_t)countOfBytesClientExpectsToSend { return countOfBytesClientExpectsToSend; };
-(void)countOfBytesClientExpectsToReceive:(int64_t)newVar { countOfBytesClientExpectsToReceive=newVar; } -(int64_t)countOfBytesClientExpectsToReceive { return countOfBytesClientExpectsToReceive; };

-(void)setCountOfBytesReceieved:(int64_t)newVar { countOfBytesReceived=newVar; } -(int64_t)countOfBytesReceived { return countOfBytesReceived; };
-(void)setCountOfBytesSent:(int64_t)newVar { countOfBytesSent=newVar; } -(int64_t)countOfBytesSent { return countOfBytesSent; };
-(void)setCountOfBytesExpectedToSend:(int64_t)newVar { countOfBytesExpectedToSend=newVar; } -(int64_t)countOfBytesExpectedToSend { return countOfBytesExpectedToSend; };
-(void)setCountOfBytesExpectedToReceive:(int64_t)newVar { countOfBytesExpectedToReceive=newVar; } -(int64_t)countOfBytesExpectedToReceive { return countOfBytesExpectedToReceive; };

-(void)setPriority:(float)newVar { priority=newVar; } -(float)priority { return priority; };

-(NSURLSession*)
    session
{
    return _session;
}

-(void)
    setSession:(NSURLSession*)theSession
{
    _session = theSession;
}

-(void)
    resume
{
    NSLog(@"%@ will resume task on %@", self, _session);
    [_session resumeTask:self];
    NSLog(@"%@ did resume task on %@", self, _session);
}

-(void)
    cancel
{
    NSLog(@"%@ will cancel task on %@", self, _session);
    [_session cancelTask:self];
    NSLog(@"%@ did cancel task on %@", self, _session);
}

-(void)
    suspend
{
    NSLog(@"%@ will suspend task on %@", self, _session);
    [_session suspendTask:self];
    NSLog(@"%@ did suspend task on %@", self, _session);
}

@end


@implementation NSURLSessionDataTask
{
}


@end

@implementation NSURLSessionConfiguration
{
    NSString* identifier;
    NSDictionary* HTTPAdditionalHeaders;
    NSString* sharedContainerIdentifier;
    NSHTTPCookieStorage* HTTPCookieStorage;
    NSURLCredentialStorage* URLCredentialStorage;
    NSURLCache* URLCache;
    NSArray<Class>* protocolClasses;
    NSDictionary* connectionProxyDictionary;

    NSURLRequestCachePolicy requestCachePolicy;
    NSTimeInterval timeoutIntervalForRequest;
    NSTimeInterval timeoutIntervalForResource;
    NSURLRequestNetworkServiceType networkServiceType;
    BOOL allowsCellularAccess;
    BOOL allowsExpensiveNetworkAccess;
    BOOL allowsConstrainedNetworkAccess;
    BOOL waitsForConnectivity;
    BOOL discretionary;
    BOOL sessionSendsLaunchEvents;




    BOOL HTTPShouldUsePipelining;
    BOOL HTTPShouldSetCookies;
    NSHTTPCookieAcceptPolicy HTTPCookieAcceptPolicy;
    NSInteger HTTPMaximumConnectionsPerHost;
    BOOL shouldUseExtendedBackgroundIdleMode;
    NSURLSessionMultipathServiceType multipathServiceType;
}

+(id)
    ephemeralSessionConfiguration
{
    NSURLSessionConfiguration *config = ([([[self alloc] init]) autorelease]);

    return config;
}

+(id)
    defaultSessionConfiguration
{
    NSURLSessionConfiguration *config = ([([[self alloc] init]) autorelease]);

    return config;
}

+(id)
    backgroundSessionConfigurationWithIdentifier:(id)theIdentifier
{
    NSURLSessionConfiguration *config = ([([[self alloc] init]) autorelease]);

    [config setIdentifier:theIdentifier];

    return config;
}

-(NSString*) identifier { return identifier; } -(void) setIdentifier:(NSString*)newVar { { id tempValue=(newVar); if ( tempValue!=identifier) { if ( tempValue!=(id)self ) { [tempValue retain]; } if ( identifier && identifier!=(id)self) { [identifier release]; } identifier = tempValue; } }; };
-(NSDictionary*) HTTPAdditionalHeaders { return HTTPAdditionalHeaders; } -(void) setHTTPAdditionalHeaders:(NSDictionary*)newVar { { id tempValue=(newVar); if ( tempValue!=HTTPAdditionalHeaders) { if ( tempValue!=(id)self ) { [tempValue retain]; } if ( HTTPAdditionalHeaders && HTTPAdditionalHeaders!=(id)self) { [HTTPAdditionalHeaders release]; } HTTPAdditionalHeaders = tempValue; } }; };
-(NSString*) sharedContainerIdentifier { return sharedContainerIdentifier; } -(void) setAllows:(NSString*)newVar { { id tempValue=(newVar); if ( tempValue!=sharedContainerIdentifier) { if ( tempValue!=(id)self ) { [tempValue retain]; } if ( sharedContainerIdentifier && sharedContainerIdentifier!=(id)self) { [sharedContainerIdentifier release]; } sharedContainerIdentifier = tempValue; } }; };
-(NSHTTPCookieStorage*) HTTPCookieStorage { return HTTPCookieStorage; } -(void) setHTTPCookieStorage:(NSHTTPCookieStorage*)newVar { { id tempValue=(newVar); if ( tempValue!=HTTPCookieStorage) { if ( tempValue!=(id)self ) { [tempValue retain]; } if ( HTTPCookieStorage && HTTPCookieStorage!=(id)self) { [HTTPCookieStorage release]; } HTTPCookieStorage = tempValue; } }; };
-(NSURLCredentialStorage*) URLCredentialStorage { return URLCredentialStorage; } -(void) setURLCredentialStorage:(NSURLCredentialStorage*)newVar { { id tempValue=(newVar); if ( tempValue!=URLCredentialStorage) { if ( tempValue!=(id)self ) { [tempValue retain]; } if ( URLCredentialStorage && URLCredentialStorage!=(id)self) { [URLCredentialStorage release]; } URLCredentialStorage = tempValue; } }; };
-(NSURLCache*) URLCache { return URLCache; } -(void) setURLCache:(NSURLCache*)newVar { { id tempValue=(newVar); if ( tempValue!=URLCache) { if ( tempValue!=(id)self ) { [tempValue retain]; } if ( URLCache && URLCache!=(id)self) { [URLCache release]; } URLCache = tempValue; } }; };
-(NSArray<Class>*) protocolClasses { return protocolClasses; } -(void) setProtocolClasses:(NSArray<Class>*)newVar { { id tempValue=(newVar); if ( tempValue!=protocolClasses) { if ( tempValue!=(id)self ) { [tempValue retain]; } if ( protocolClasses && protocolClasses!=(id)self) { [protocolClasses release]; } protocolClasses = tempValue; } }; };
-(NSDictionary*) connectionProxyDictionary { return connectionProxyDictionary; } -(void) setConnectionProxyDictionary:(NSDictionary*)newVar { { id tempValue=(newVar); if ( tempValue!=connectionProxyDictionary) { if ( tempValue!=(id)self ) { [tempValue retain]; } if ( connectionProxyDictionary && connectionProxyDictionary!=(id)self) { [connectionProxyDictionary release]; } connectionProxyDictionary = tempValue; } }; };

-(void)setRequestCachePolicy:(NSURLRequestCachePolicy)newVar { requestCachePolicy=newVar; } -(NSURLRequestCachePolicy)requestCachePolicy { return requestCachePolicy; };
-(void)setTimeoutIntervalForRequest:(NSTimeInterval)newVar { timeoutIntervalForRequest=newVar; } -(NSTimeInterval)timeoutIntervalForRequest { return timeoutIntervalForRequest; };
-(void)setTimeoutIntervalForResource:(NSTimeInterval)newVar { timeoutIntervalForResource=newVar; } -(NSTimeInterval)timeoutIntervalForResource { return timeoutIntervalForResource; };
-(void)setNetworkServiceType:(NSURLRequestNetworkServiceType)newVar { networkServiceType=newVar; } -(NSURLRequestNetworkServiceType)networkServiceType { return networkServiceType; };
-(void)setAllowsCellularAccess:(BOOL)newVar { allowsCellularAccess=newVar; } -(BOOL)allowsCellularAccess { return allowsCellularAccess; };
-(void)setAllowsExpensiveNetworkAccess:(BOOL)newVar { allowsExpensiveNetworkAccess=newVar; } -(BOOL)allowsExpensiveNetworkAccess { return allowsExpensiveNetworkAccess; };;
-(void)setAllowsConstrainedNetworkAccess:(BOOL)newVar { allowsConstrainedNetworkAccess=newVar; } -(BOOL)allowsConstrainedNetworkAccess { return allowsConstrainedNetworkAccess; };;
-(void)setWaitsForConnectivity:(BOOL)newVar { waitsForConnectivity=newVar; } -(BOOL)waitsForConnectivity { return waitsForConnectivity; };
-(void)setDiscretionary:(BOOL)newVar { discretionary=newVar; } -(BOOL)discretionary { return discretionary; };
-(void)setSessionSendsLaunchEvents:(BOOL)newVar { sessionSendsLaunchEvents=newVar; } -(BOOL)sessionSendsLaunchEvents { return sessionSendsLaunchEvents; };;




-(void)setHTTPShouldUsePipelining:(BOOL)newVar { HTTPShouldUsePipelining=newVar; } -(BOOL)HTTPShouldUsePipelining { return HTTPShouldUsePipelining; };
-(void)setHTTPShouldSetCookies:(BOOL)newVar { HTTPShouldSetCookies=newVar; } -(BOOL)HTTPShouldSetCookies { return HTTPShouldSetCookies; };
-(void)setHTTPCookieAcceptPolicy:(NSHTTPCookieAcceptPolicy)newVar { HTTPCookieAcceptPolicy=newVar; } -(NSHTTPCookieAcceptPolicy)HTTPCookieAcceptPolicy { return HTTPCookieAcceptPolicy; };
-(void)setHTTPMaximumConnectionsPerHost:(NSInteger)newVar { HTTPMaximumConnectionsPerHost=newVar; } -(NSInteger)HTTPMaximumConnectionsPerHost { return HTTPMaximumConnectionsPerHost; };
-(void)setShouldUseExtendedBackgroundIdleMode:(BOOL)newVar { shouldUseExtendedBackgroundIdleMode=newVar; } -(BOOL)shouldUseExtendedBackgroundIdleMode { return shouldUseExtendedBackgroundIdleMode; };;
-(void)setMultipathServiceType:(NSURLSessionMultipathServiceType)newVar { multipathServiceType=newVar; } -(NSURLSessionMultipathServiceType)multipathServiceType { return multipathServiceType; };

@end

@implementation NSURLSession
{
  NSMutableDictionary *taskToProtocolDictionary;
  NSMutableDictionary *protocolToTaskDictionary;
  NSMutableDictionary *protocolToURLResponse;
  NSMutableDictionary *protocolToCompletionHandler;
  NSMutableDictionary *protocolToData;
  id delegate;
  NSOperationQueue *delegateQueue;
  NSURLSessionConfiguration *configuration;
  NSString *sessionDescription;
}


- (id) init
{
  self = [super init];

  taskToProtocolDictionary    = [[NSMutableDictionary alloc] init];
  protocolToTaskDictionary    = [[NSMutableDictionary alloc] init];
  protocolToURLResponse       = [[NSMutableDictionary alloc] init];
  protocolToCompletionHandler = [[NSMutableDictionary alloc] init];
  protocolToData              = [[NSMutableDictionary alloc] init];

  return self;
		

}

+ (NSURLSession *)
    sessionWithConfiguration:(NSURLSessionConfiguration *)configuration
{
    NSURLSession *session = ([([[self alloc] init]) autorelease]);

    [session setConfiguration:configuration];
    [session setDelegate:(id<NSURLSessionDelegate>)session];
    return session;
}

+ (NSURLSession *)
    sessionWithConfiguration:(NSURLSessionConfiguration *)configuration
    delegate:(id <NSURLSessionDelegate>)delegate
    delegateQueue:(NSOperationQueue *)queue
{
    NSURLSession *session = ([([[self alloc] init]) autorelease]);

    [session setConfiguration:configuration];
    [session setDelegate:delegate];
    [session setDelegateQueue:queue];

    return session;
}

static NSURLSession *sharedSession = ((void *)0);

+(NSURLSession*)
    sharedSession
{
    if (sharedSession == nil)
    {
      NS_DURING
	{
	  [gnustep_global_lock lock];
	  if (sharedSession == nil)
	    {
	      sharedSession = [[self alloc] init];
	      [sharedSession setDelegate:(id<NSURLSessionDelegate>)sharedSession];
	      [sharedSession setSessionDescription:@"SharedSession"];
	    }
	  [gnustep_global_lock unlock];
	}
      NS_HANDLER
	{
	  // unlock then re-raise the exception
	  [gnustep_global_lock unlock];
	  [localException raise];
	}
      NS_ENDHANDLER
    }
  return sharedSession;
}

-(NSOperationQueue*) delegateQueue { return delegateQueue; }
 -(void) setDelegateQueue:(NSOperationQueue*)newVar { { id tempValue=(newVar); if ( tempValue!=delegateQueue) { if ( tempValue!=(id)self ) { [tempValue retain]; }
 if ( delegateQueue && delegateQueue!=(id)self) { [delegateQueue release]; }
 delegateQueue = tempValue; }
 }
; }
;
-(id<NSURLSessionDelegate>) delegate { return delegate; }
 -(void) setDelegate:(id<NSURLSessionDelegate>)newVar { { id tempValue=(newVar); if ( tempValue!=delegate) { if ( tempValue!=(id)self ) { [tempValue retain]; }
 if ( delegate && delegate!=(id)self) { [delegate release]; }
 delegate = tempValue; }
 }
; }
;
-(NSURLSessionConfiguration*) configuration { return configuration; }
 -(void) setConfiguration:(NSURLSessionConfiguration*)newVar { { id tempValue=(newVar); if ( tempValue!=configuration) { if ( tempValue!=(id)self ) { [tempValue retain]; }
 if ( configuration && configuration!=(id)self) { [configuration release]; }
 configuration = tempValue; }
 }
; }
;

-(NSString*) sessionDescription { return sessionDescription; }

 -(void) setSessionDescription:(NSString*)newVar
{
	{
		id tempValue=(newVar);
		if ( tempValue!=sessionDescription)
	       	{
		       	if ( tempValue!=(id)self ) { [tempValue retain]; }
	        	if ( sessionDescription && sessionDescription!=(id)self) { [sessionDescription release]; }
		        sessionDescription = tempValue;
		}
 	}
}


- (NSURLSessionDataTask *)
    dataTaskWithRequest:(NSURLRequest *)request
    completionHandler:(void(^)(NSData*, NSURLResponse *, NSError *))completionHandler
{
    NSURLSessionDataTask *task
      = [[NSURLSessionDataTask alloc] init];

    NSURLProtocol *protocol
      = [[NSURLProtocol alloc]
            initWithRequest:request
            cachedResponse: ((void *)0)
            client:(id<NSURLProtocolClient>)self];

    [task setSession:self];

    NSValue *taskPointer = [NSValue valueWithPointer:(const void*)task];
    NSValue *protocolPointer = [NSValue valueWithPointer:(const void*)protocol];

    [taskToProtocolDictionary setObject:protocol forKey:taskPointer];
    [protocolToTaskDictionary setObject:task forKey:protocolPointer];

    if (completionHandler) {
        [protocolToCompletionHandler setObject:completionHandler forKey:protocolPointer];
        [protocolToData setObject:[NSMutableData data] forKey:protocolPointer];
    }

    return task;

}

- (NSURLSessionDataTask *)
  dataTaskWithRequest:(NSURLRequest *)request
{
    return [self dataTaskWithRequest:request completionHandler:((void *)0)];
}

-(void)
	resumeTask:(id)theTask
{
    NSLog(@"Will resume task: %@ on session: %@", theTask, self);
    NSLog(@"Will get task pointer.");

    NSValue *taskPointer
        = [NSValue valueWithPointer:(const void*)theTask];

    NSLog(@"Did get task pointer: %@", taskPointer);

    NSLog(@"Will get protocol from dict: %@.", taskToProtocolDictionary);
    NSURLProtocol *protocol
        = [taskToProtocolDictionary objectForKey:taskPointer];
    NSLog(@"Will get protocol: %@", protocol);

    NSLog(@"Will start loading protocol.");
    [protocol startLoading];
    NSLog(@"Did start loading protocol.");
}

- (void)
  URLProtocol: (NSURLProtocol *)protocol
  didReceiveAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge
{
    NSValue *protocolPointer = [NSValue valueWithPointer:(const void*)protocol];
    NSURLSessionDataTask *task = [protocolToTaskDictionary objectForKey:protocolPointer];

    NSData *taskData = [protocolToData objectForKey:protocolPointer];

    if (taskData) {
        return;
    }

    void (^theHandlerTheDelegateMustCall)(NSURLSessionAuthChallengeDisposition, NSURLCredential*)
      = ^(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential){
          NSLog(@"The delegate did call the handler.");
          NSLog(@"TO-DO: figure out how to go from here");
      };

      NSString *method = [[challenge protectionSpace] authenticationMethod];

      BOOL isSessionLevelMethod
        = [method isEqualToString:NSURLAuthenticationMethodNTLM]
            || [method isEqualToString:NSURLAuthenticationMethodNegotiate]
            || [method isEqualToString:NSURLAuthenticationMethodClientCertificate]
            || [method isEqualToString:NSURLAuthenticationMethodServerTrust];
    if (isSessionLevelMethod) {
      if ([delegate respondsToSelector:@selector(URLSession:didReceiveChallenge:completionHandler:)]) {
          [delegate URLSession:self didReceiveChallenge:challenge completionHandler:theHandlerTheDelegateMustCall];
      } else
      if ([delegate respondsToSelector:@selector(URLSession:task:didReceiveChallenge:completionHandler:)]) {
          [delegate URLSession:self task:task didReceiveChallenge:challenge completionHandler:theHandlerTheDelegateMustCall];
      }
    } else {
        if ([delegate respondsToSelector:@selector(URLSession:task:didReceiveChallenge:completionHandler:)]) {
            [delegate URLSession:self task:task didReceiveChallenge:challenge completionHandler:theHandlerTheDelegateMustCall];
        }
    }
}






- (void) URLProtocol: (NSURLProtocol *)protocol
  cachedResponseIsValid: (NSCachedURLResponse *)cachedResponse
{
  return;
}

- (void)
    URLProtocol: (NSURLProtocol *)protocol
    didFailWithError: (NSError *)error
{
    NSValue *protocolPointer
        = [NSValue valueWithPointer:(const void*)protocol];

    NSURLSessionDataTask *task
        = [protocolToTaskDictionary objectForKey:protocolPointer];

    NSData *taskData = [protocolToData objectForKey:protocolPointer];

    if (taskData) {
        NSURLSessionTaskCompletionHandler completionHandler = (NSURLSessionTaskCompletionHandler)[protocolToCompletionHandler objectForKey:protocolPointer];
        completionHandler(((void *)0), ((void *)0), error);
    } else {
        if ([delegate respondsToSelector:@selector(URLSession:task:didCompleteWithError:)]){
            [delegate URLSession:self task:task didCompleteWithError:error];
        }
    }
}

- (void)
    URLProtocol: (NSURLProtocol *)protocol
    didReceiveResponse: (NSURLResponse *)response
    cacheStoragePolicy: (NSURLCacheStoragePolicy)policy
{
    NSValue *protocolPointer
        = [NSValue valueWithPointer:(const void*)protocol];

    NSURLSessionDataTask *task
        = [protocolToTaskDictionary objectForKey:protocolPointer];

    NSData *taskData = [protocolToData objectForKey:protocolPointer];

    if (taskData) {
        [protocolToURLResponse setObject:response forKey:protocolPointer];
    } else {
        void (^theCompletionHandler)(NSURLSessionResponseDisposition)
            = ^(NSURLSessionResponseDisposition disposition){

            };

        if ([delegate respondsToSelector:@selector(URLSession:dataTask:didReceiveResponse:completionHandler:)]){
            [delegate URLSession:self dataTask:task didReceiveResponse:response completionHandler:theCompletionHandler];
        }
    }
}

- (void)
    URLProtocol: (NSURLProtocol *)protocol
    wasRedirectedToRequest: (NSURLRequest *)request
    redirectResponse: (NSURLResponse *)redirectResponse
{
    NSValue *protocolPointer
        = [NSValue valueWithPointer:(const void*)protocol];

    NSURLSessionDataTask *task
        = [protocolToTaskDictionary objectForKey:protocolPointer];

    void (^shouldContinueWithRequest)(NSURLRequest *) = ^(NSURLRequest *theRequest){

    };

    if ([delegate respondsToSelector:@selector(URLSession:task:willPerformHTTPRedirection:newRequest:completionHandler:)])
    {
        [delegate
            URLSession:self
            task:task
            willPerformHTTPRedirection:(NSHTTPURLResponse*)redirectResponse
            newRequest:request
            completionHandler:shouldContinueWithRequest];
    }
}

-(void)
    URLProtocol:(NSURLProtocol*)protocol
    didLoadData:(NSData*)theData
{
    NSValue *protocolPointer
        = [NSValue valueWithPointer:(const void*)protocol];

    NSURLSessionDataTask *task
        = [protocolToTaskDictionary objectForKey:protocolPointer];

    if ([delegate respondsToSelector:@selector(URLSession:dataTask:didReceiveData:)]) {
        [delegate URLSession:self dataTask:task didReceiveData:theData];
    }
}

- (void)
    URLProtocolDidFinishLoading: (NSURLProtocol *)protocol
{
    NSValue *protocolPointer
        = [NSValue valueWithPointer:(const void*)protocol];

    NSURLSessionDataTask *task
        = [protocolToTaskDictionary objectForKey:protocolPointer];

    NSData *taskData = [protocolToData objectForKey:protocolPointer];

    if (taskData) {
        NSURLResponse *response
            = [protocolToURLResponse objectForKey:protocolPointer];

        NSURLSessionTaskCompletionHandler completionHandler
            = [protocolToCompletionHandler objectForKey:protocolPointer];

        NSURLSessionTaskCompletionHandler freeAfterCompletionHandler = ^(NSData* data, NSURLResponse *repsonse, NSError *error) {
            completionHandler(data, response, ((void *)0));
            [self cleanUpObjectsRelatedToProtocolPointer:protocolPointer];
        };

        freeAfterCompletionHandler(taskData, response, ((void *)0));
    } else if ([delegate respondsToSelector:@selector(URLSession:task:didCompleteWithError:)]){
        [delegate URLSession:self task:task didCompleteWithError:((void *)0)];
        [self cleanUpObjectsRelatedToProtocolPointer:protocolPointer];
    }




}

-(void)
    cleanUpObjectsRelatedToProtocolPointer:(NSValue*)protocolPointer
{
    NSURLSessionDataTask *task
        = [protocolToTaskDictionary objectForKey:protocolPointer];

    NSValue *taskPointer = [NSValue valueWithPointer:(const void*)task];

    [taskToProtocolDictionary removeObjectForKey:taskPointer];
    [protocolToTaskDictionary removeObjectForKey:protocolPointer];

    NSData *taskData = [protocolToData objectForKey:protocolPointer];

    if (taskData) {
        [protocolToCompletionHandler removeObjectForKey:protocolPointer];
        [protocolToData removeObjectForKey:protocolPointer];
    }
}

- (void)
    URLProtocol: (NSURLProtocol *)protocol
    didCancelAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge
{
    /*
    NSValue *protocolPointer
        = [NSValue valueWithPointer:(const void*)protocol];

    NSURLSessionDataTask *task
        = [protocolToTaskDictionary objectForKey:protocolPointer];

   */
}

-(void)
    freeTaskPointer:(NSValue*)taskPointer
    andProtocolPointer:(NSValue*)protocolPointer
{
    [taskToProtocolDictionary removeObjectForKey:taskPointer];
    [protocolToTaskDictionary removeObjectForKey:protocolPointer];
}

-(void)
    freePairWithProtocolPointer:(NSValue*)protocolPointer
    andTask:(NSURLSessionTask*)task
{
    NSValue *taskPointer
        = [NSValue valueWithPointer:(const void*)task];

    [taskToProtocolDictionary removeObjectForKey:taskPointer];
    [protocolToTaskDictionary removeObjectForKey:protocolPointer];
}

-(void)finishTasksAndInvalidate
{
    // TO-DO;
}

-(void)invalidateAndCancel
{
    // TO-DO;
}

-(void)resetWithCompletionHandler:(void (^)(void))completionHandler
{
    // TO-DO;
}

-(void)flushWithCompletionHandler:(void (^)(void))completionHandler
{
    // TO-DO;
}

-(void)getTasksWithCompletionHandler:(void (^)(NSArray*dataTasks, NSArray*uploadTasks, NSArray*downloadTasks))completionHandler
{
    // TO-DO;
}
-(void)getAllTasksWithCompletionHandler:(void (^)(NSArray*tasks))completionHandler
{
    // TO-DO;
}

- (NSURLSessionDataTask *)
    dataTaskWithURL:(NSURL *)url
{
    return nil; // TO-DO
}


- (NSURLSessionUploadTask *)
    uploadTaskWithRequest:(NSURLRequest *)request
    fromFile:(NSURL *)fileURL
{
    return nil; // TO-DO
}


- (NSURLSessionUploadTask *)
    uploadTaskWithRequest:(NSURLRequest *)request
    fromData:(NSData *)bodyData
{
    return nil; // TO-DO
}


- (NSURLSessionUploadTask *)
    uploadTaskWithStreamedRequest:(NSURLRequest *)request
{
    return nil; // TO-DO
}


- (NSURLSessionDownloadTask *)
    downloadTaskWithRequest:(NSURLRequest *)request
{
    return nil; // TO-DO
}

- (NSURLSessionDownloadTask *)
   downloadTaskWithURL:(NSURL *)url
{
    return nil; // TO-DO
}

- (NSURLSessionDownloadTask *)
    downloadTaskWithResumeData:(NSData *)resumeData
{
    return nil; // TO-DO
}


- (NSURLSessionStreamTask *)
    streamTaskWithHostName:(NSString *)hostname
    port:(NSInteger)port
{
    return nil; // TO-DO
}


- (NSURLSessionStreamTask *)
    streamTaskWithNetService:(NSNetService *)service
{
    return nil; // TO-DO
}


- (NSURLSessionWebSocketTask *)
    webSocketTaskWithURL:(NSURL *)url
{
    return nil; // TO-DO
}


- (NSURLSessionWebSocketTask *)
    webSocketTaskWithURL:(NSURL *)url
    protocols:(NSArray*)protocols
{
    return nil; // TO-DO
}


- (NSURLSessionWebSocketTask *)
    webSocketTaskWithRequest:(NSURLRequest *)request
{
    return nil; // TO-DO
}



@end

