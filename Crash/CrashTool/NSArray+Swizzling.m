//
//  NSArray+Swizzling.m
//  Crash
//
//  Created by dzc on 2021/1/30.
//

#import "NSArray+Swizzling.h"
#import "NSObject+BaseMethodSwizzling.h"
#import <objc/runtime.h>

@implementation NSArray (Swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [objc_getClass("__NSArrayI") swizzleSelector:@selector(objectAtIndex:)
                                        withSelector:@selector(xxx_objectAtIndex:)];

        [objc_getClass("__NSFrozenArrayM") swizzleSelector:@selector(objectAtIndexedSubscript:)
                                              withSelector:@selector(xxx_objectAtIndexedSubscript:)];

        [objc_getClass("__NSPlaceholderArray") swizzleSelector:@selector(initWithObjects:count:) withSelector:@selector(xxx_initWithObjects:count:)];
    
    });
}

- (instancetype)xxx_initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    
    BOOL nilObject = NO;
    
    for (NSUInteger i = 0; i < cnt; i++) {
        if (objects[i] == nil) {
            nilObject = YES;
            NSLog(@"\n**************************************************\n*\n*\n*\t -initWithObjects:count:  Object[%lu] Is Nil \n*\n*\n**************************************************",(unsigned long)i);
        }
    }
    
    if (nilObject) {
        id newObjects[cnt];
        NSUInteger index = 0;
        for (NSUInteger i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[index++] = objects[i];
            }
        }
        return [self xxx_initWithObjects:newObjects count:index];
    }
    return [self xxx_initWithObjects:objects count:cnt];
}


- (id)xxx_objectAtIndexedSubscript:(NSUInteger)index {
    if (self.count == 0) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -objectAtIndexedSubscript:  Is Empty Array \n*\n*\n**************************************************");
        return nil;
    }
    
    if (index > self.count-1) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -objectAtIndexedSubscript:  Index Out Bounds \n*\n*\n**************************************************");
        return nil;
    }
    
    return [self xxx_objectAtIndexedSubscript:index];
}


- (id)xxx_objectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -objectAtIndex:  Is Empty Array \n*\n*\n**************************************************");
        return nil;
    }
    
    if (index > self.count-1) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -objectAtIndex:  Index Out Bounds \n*\n*\n**************************************************");
        return nil;
    }
    
    return [self xxx_objectAtIndex:index];
}

@end
