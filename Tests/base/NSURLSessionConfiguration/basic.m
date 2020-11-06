#import <Foundation/Foundation.h>
#import "Testing.h"
#import "ObjectTesting.h"

int main()
{
  NSAutoreleasePool   *arp = [NSAutoreleasePool new];
  NSURLSessionConfiguration *configuration;

  TEST_FOR_CLASS(@"NSURLSessionConfiguration", [NSURLSessionConfiguration alloc],
    "NSURLSessionConfiguration +alloc returns an NSURLSessionConfiguration");

  [arp release]; arp = nil;
  return 0;
}
