#import <Foundation/Foundation.h>
#import "Testing.h"
#import "ObjectTesting.h"

int main()
{
  NSAutoreleasePool    *arp = [NSAutoreleasePool new];
  NSMutableURLRequest  *mutable;
  NSURLSession         *connection;
  NSURLSessionDataTask *dataTask;
  NSURLRequest         *request;
  NSURLResponse        *response;
  NSError              *error;
  NSData               *data;
  NSURL                *httpURL;
  NSString             *path;

  httpURL = [NSURL URLWithString: @"http://www.gnustep.org"];

  TEST_FOR_CLASS(@"NSURLSession", [NSURLSession alloc],
    "NSURLSession +alloc returns an NSURLSession");

  mutable = [NSMutableURLRequest requestWithURL: httpURL];

  // PASS([NSURLSession canHandleRequest: mutable],
  //   "NSURLSession can handle an valid HTTP request (GET)");
  // [mutable setHTTPMethod: @"WRONGMETHOD"];
  // PASS([NSURLSession canHandleRequest: mutable],
  //   "NSURLSession can handle an invalid HTTP request (WRONGMETHOD)");

  [mutable setHTTPMethod: @"GET"];

  __block BOOL didReturn = NO;

  dataTask = [[NSURLSession sharedSession]
	           dataTaskWithRequest: mutable
  		   completionHandler:(^(NSData *data, NSURLResponse *response, NSError *error){
			NSString *asString 
				= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
				   

			fprintf(stdout, "Data task as string: %s\n", [asString UTF8String]);
			fprintf(stdout, "Response: %s\n", [[response description] UTF8String]);
			fprintf(stdout, "Error %f\n", [[error description] UTF8String]);

			didReturn = YES;
		   })];

   [dataTask resume];


    NSTimeInterval timing;
    NSTimeInterval duration;

    duration = 0.0;
    timing = 0.1;

    while (!didReturn && duration < 3.0)
    {
      [[NSRunLoop currentRunLoop]
        runUntilDate: [NSDate dateWithTimeIntervalSinceNow: timing]];
      duration += timing;
    }


  PASS(didReturn, "data task with request did not return");

  // PASS(nil == error, "https://www.google.com/ does not return an error")
  // PASS(nil != data, "https://www.google.com/ returns data")

  [arp release]; arp = nil;
  return 0;
}
