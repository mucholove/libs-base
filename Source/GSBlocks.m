#import <Foundation/NSObject.h>

// Declare the block copy functions ourself so that we don't depend on a
// specific header location.
void *_Block_copy(void *);
void _Block_release(void *);

@interface GSBlock : NSObject
@end

@implementation GSBlock
+ (void)load
{
	unsigned int methodCount;
	Method *methods = 
		class_copyMethodList(self, &methodCount);
	id blockClass = objc_lookUpClass("_NSBlock");

	// If we don't have an _NSBlock class, we don't have blocks support in the
	// runtime, so give up.
	if (nil == blockClass) { return; }

	// Copy all of the methods in this class onto the block-runtime-provided
	// _NSBlock
	for (Method *m = methods ; NULL!=*m ; m++)
	{
		class_addMethod(blockClass, method_getName(*m),
			method_getImplementation(*m), method_getTypeEncoding(*m));
	}
}
- (id)copyWithZone: (NSZone*)aZone
{
	return Block_copy(self);
}
- (id)copy
{
	return Block_copy(self);
}
- (id)retain
{
	return Block_copy(self);
}
- (void)release
{
	Block_release(self);
}
@end
