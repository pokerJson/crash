//
//  NSMutableArray+Swizzling.m
//  Crash
//
//  Created by dzc on 2021/1/30.
//

#import "NSMutableArray+Swizzling.h"
#import "NSObject+BaseMethodSwizzling.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
        [self swizzleSelector:@selector(removeObject:)
                 withSelector:@selector(xxxM_removeObject:)];
        
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(removeObjectAtIndex:)
                                        withSelector:@selector(xxxM_removeObjectAtIndex:)];
        
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(objectAtIndex:)
                                        withSelector:@selector(xxxM_objectAtIndex:)];
        
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(addObject:)
                                withSelector:@selector(xxxM_addObject:)];
        
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(insertObject:atIndex:)
                                withSelector:@selector(xxxM_insertObject:atIndex:)];
        
        [objc_getClass("__NSPlaceholderArray") swizzleSelector:@selector(initWithObjects:count:)
                                                  withSelector:@selector(xxxM_initWithObjects:count:)];
        
    });
}


- (instancetype)xxxM_initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
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
        return [self xxxM_initWithObjects:newObjects count:index];
    }
    return [self xxxM_initWithObjects:objects count:cnt];

}



- (void)xxxM_addObject:(id)obj {
    if (obj == nil) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -addObject:  Can't Add Nil \n*\n*\n**************************************************");
    } else {
        [self xxxM_addObject:obj];
    }
}



- (void)xxxM_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -insertObject:atIndex:  Can't Insert Nil \n*\n*\n**************************************************");
    } else if (index > self.count) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -insertObject:atIndex:  Index Is Invalid \n*\n*\n**************************************************");
    } else {
        [self xxxM_insertObject:anObject atIndex:index];
    }
}

- (id)xxxM_objectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -objectAtIndex:  Is Empty Array \n*\n*\n**************************************************");
        return nil;
    }
    
    if (index > self.count-1) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -objectAtIndex:  Index Out Bounds \n*\n*\n**************************************************");
        return nil;
    }
    
    return [self xxxM_objectAtIndex:index];
}

- (void)xxxM_removeObjectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -removeObjectAtIndex:  Is Empty Array \n*\n*\n**************************************************");
        return;
    }
    
    if (index > self.count-1) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -removeObjectAtIndex:  Index Out Bounds \n*\n*\n**************************************************");
        return;
    }
    
    [self xxxM_removeObjectAtIndex:index];
}

- (void)xxxM_removeObject:(id)obj {
    if (obj == nil) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -removeObject:  Obj Is Nil \n*\n*\n**************************************************");
        return;
    }
    [self xxxM_removeObject:obj];
}
@end
