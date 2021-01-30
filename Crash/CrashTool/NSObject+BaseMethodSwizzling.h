//
//  NSObject+BaseMethodSwizzling.h
//  Crash
//
//  Created by dzc on 2021/1/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (BaseMethodSwizzling)

/** 交换两个类方法的实现
 * @param originalSelector  原始方法的 SEL
 * @param swizzledSelector  交换方法的 SEL
 * @param targetClass  类
 */
+ (void)baseSwizzlingClassMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector withClass:(Class)targetClass;

/** 交换两个对象方法的实现
 * @param originalSelector  原始方法的 SEL
 * @param swizzledSelector 交换方法的 SEL
 * @param targetClass  类
 */
+ (void)baseSwizzlingInstanceMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector withClass:(Class)targetClass;


/// NSArray 等专用
/// @param originalSelector <#originalSelector description#>
/// @param swizzledSelector <#swizzledSelector description#>
+ (void)swizzleSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector;

@end

// 判断是否是系统类
static inline BOOL isSystemClass(Class cls) {
    BOOL isSystem = NO;
    NSString *className = NSStringFromClass(cls);
    if ([className hasPrefix:@"NS"] || [className hasPrefix:@"__NS"] || [className hasPrefix:@"OS_xpc"]) {
        isSystem = YES;
        return isSystem;
    }
    NSBundle *mainBundle = [NSBundle bundleForClass:cls];
    if (mainBundle == [NSBundle mainBundle]) {
        isSystem = NO;
    }else{
        isSystem = YES;
    }
    return isSystem;
}


NS_ASSUME_NONNULL_END
