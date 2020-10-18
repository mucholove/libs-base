#import <Foundation/NSURLSession.h>
#import <Foundation/NSURLRequest.h>
#import <Foundation/NSURLAuthenticationChallenge.h>
#import <Foundation/NSURLProtectionSpace.h>
#import <Foundation/NSURLCredential.h>
#import <Foundation/NSURLProtocol.h>
#import <Foundation/NSValue.h>
#import <Foundation/NSDictionary.h>

@interface NSURLSessionDataTask ()

-(NSURLSession*)session;
-(void)setSession:(NSURLSession*)theSession;

@end

@implementation NSURLSessionDataTask
{
    NSURLSession *_session;
}

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

@end

@implementation NSURLSession
{
  NSMutableDictionary *taskToProtocolDictionary;
  NSMutableDictionary *protocolToTaskDictionary;
  id delegate;
}

// NSValue *taskPointer     = [NSValue valueWithPointer:(const void*)task];
// NSValue *protocolPointer = [NSValue valueWithPointer:(const void*)protocol];

/*


Creates a task that retrieves the contents
of a URL based on the specified URL request object:
    
    - dataTaskWithRequest:

Creates a task that retrieves the contents of a URL based
on the specified URL request object,
and calls a handler upon completion:
  
    - dataTaskWithRequest:completionHandler:
*/

- (NSURLSessionDataTask *)
  dataTaskWithRequest:(NSURLRequest *)request
{
    NSURLSessionDataTask *task
      = [[NSURLSessionDataTask alloc] init];
    
    NSURLProtocol *protocol
      = [[NSURLProtocol alloc]
            initWithRequest:request
            cachedResponse: nil
            client:(id<NSURLProtocolClient>)self];

    [task setSession:self];
    
    NSValue *taskPointer     = [NSValue valueWithPointer:(const void*)task];
    NSValue *protocolPointer = [NSValue valueWithPointer:(const void*)protocol];

    [taskToProtocolDictionary setObject:protocol forKey:taskPointer];
    [protocolToTaskDictionary setObject:task     forKey:protocolPointer];
}

-(void)
  resumeTask:(id)theTask
{
    NSValue *taskPointer
        = [NSValue valueWithPointer:(const void*)theTask];
    
    NSURLProtocol *protocol
        = [taskToProtocolDictionary objectForKey:taskPointer];
    
    [protocol startLoading];
}


#pragma mark NSURLProtocol Delegate
/*
 * Session Level
 *
 */

- (void)
  URLProtocol: (NSURLProtocol *)protocol
  didReceiveAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge
{
    NSValue *protocolPointer = [NSValue valueWithPointer:(const void*)protocol];
    NSURLSessionDataTask *task  = [protocolToTaskDictionary objectForKey:protocolPointer];
    
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


/*  Task Level
 *
 */

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
  
    if ([delegate respondsToSelector:@selector(URLSession:task:didCompleteWithError:)]){
        [delegate URLSession:self task:task didCompleteWithError:error];
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
    
    void (^theCompletionHandler)(NSURLSessionResponseDisposition)
        = ^(NSURLSessionResponseDisposition disposition){

        };
        
    if ([delegate respondsToSelector:@selector(URLSession:dataTask:didReceiveResponse:completionHandler:)]){
        [delegate URLSession:self dataTask:task didReceiveResponse:response completionHandler:theCompletionHandler];
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
            willPerformHTTPRedirection:redirectResponse
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
        
    if ([delegate respondsToSelector:@selector(URLSession:task:didCompleteWithError:)]){
        [delegate URLSession:self task:task didCompleteWithError:nil];
    }
    
    NSValue *taskPointer
        = [NSValue valueWithPointer:(const void*)task];
    
    [taskToProtocolDictionary removeObjectForKey:taskPointer];
    [protocolToTaskDictionary removeObjectForKey:protocolPointer];
}

- (void)
    URLProtocol: (NSURLProtocol *)protocol
    didCancelAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge
{
    NSValue *protocolPointer
        = [NSValue valueWithPointer:(const void*)protocol];
    
    NSURLSessionDataTask *task
        = [protocolToTaskDictionary objectForKey:protocolPointer];

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

@end
