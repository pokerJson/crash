//
//  NSDictionary+Swizzling.m
//  Crash
//
//  Created by dzc on 2021/1/30.
//

#import "NSDictionary+Swizzling.h"
#import "NSObject+BaseMethodSwizzling.h"
#import <objc/runtime.h>


@implementation NSDictionary (Swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [objc_getClass("__NSPlaceholderDictionary") swizzleSelector:@selector(initWithObjects:forKeys:count:)
                                                       withSelector:@selector(xxx_initWithObjects:forKeys:count:)];
    });
}

- (instancetype)xxx_initWithObjects:(const id _Nonnull [_Nullable])objects forKeys:(const id <NSCopying> _Nonnull [_Nullable])keys count:(NSUInteger)cnt {
    
    BOOL nilObject = NO;
    for (NSUInteger i = 0; i < cnt; i++) {
        
        if (objects[i] == nil) {
            nilObject = YES;
            NSLog(@"\n**************************************************\n*\n*\n*\t initWithObjects:forKeys:count:  Obj[@\"%@\"] Is Nil \n*\n*\n**************************************************",keys[i]);
        }
    }

    if (nilObject) {
        return nil;
    }
    return [self xxx_initWithObjects:objects forKeys:keys count:cnt];
}
@end
