//
//  ModelClassProperty.h
//  Runtime
//
//  Created by Yu Fan on 2019/5/21.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "objc/message.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, FYEncodingType) {
    FYEncodingTypeMask       = 0xFF, ///< mask of type value
    FYEncodingTypeUnknown    = 0,    ///< unknown
    FYEncodingTypeVoid       = 1,    ///< void
    FYEncodingTypeBool       = 2,    ///< bool
    FYEncodingTypeInt8       = 3,    ///< char / BOOL
    FYEncodingTypeUInt8      = 4,    ///< unsigned char
    FYEncodingTypeInt16      = 5,    ///< short
    FYEncodingTypeUInt16     = 6,    ///< unsigned short
    FYEncodingTypeInt32      = 7,    ///< int
    FYEncodingTypeUInt32     = 8,    ///< unsigned int
    FYEncodingTypeInt64      = 9,    ///< long long
    FYEncodingTypeUInt64     = 10,   ///< unsigned long long
    FYEncodingTypeFloat      = 11,   ///< float
    FYEncodingTypeDouble     = 12,   ///< double
    FYEncodingTypeLongDouble = 13,   ///< long double
    FYEncodingTypeObject     = 14,   ///< id
    FYEncodingTypeClass      = 15,   ///< Class
    FYEncodingTypeSEL        = 16,   ///< SEL
    FYEncodingTypeBlock      = 17,   ///< block
    FYEncodingTypePointer    = 18,   ///< void*
    FYEncodingTypeStruct     = 19,   ///< struct
    FYEncodingTypeUnion      = 20,   ///< union
    FYEncodingTypeCString    = 21,   ///< char*
    FYEncodingTypeCArray     = 22,   ///< char[10] (for example)
    
    FYEncodingTypeQualifierMask   = 0xFF00,     ///< mask of qualifier
    FYEncodingTypeQualifierConst  = 1 << 8,     ///< const
    FYEncodingTypeQualifierIn     = 1 << 9,     ///< in
    FYEncodingTypeQualifierInout  = 1 << 10,    ///< inout
    FYEncodingTypeQualifierOut    = 1 << 11,    ///< out
    FYEncodingTypeQualifierBycopy = 1 << 12,    ///< bycopy
    FYEncodingTypeQualifierByref  = 1 << 13,    ///< byref
    FYEncodingTypeQualifierOneway = 1 << 14,    ///< oneway
    
    FYEncodingTypePropertyMask         = 0xFF0000,  ///< mask of property
    FYEncodingTypePropertyReadonly     = 1 << 16,   ///< readonly
    FYEncodingTypePropertyCopy         = 1 << 17,   ///< copy
    FYEncodingTypePropertyRetain       = 1 << 18,   ///< retain
    FYEncodingTypePropertyNonatomic    = 1 << 19,   ///< nonatomic
    FYEncodingTypePropertyWeak         = 1 << 20,   ///< weak
    FYEncodingTypePropertyCustomGetter = 1 << 21,   ///< getter=
    FYEncodingTypePropertyCustomSetter = 1 << 22,   ///< setter=
    FYEncodingTypePropertyDynamic      = 1 << 23,   ///< @dynamic
};


/**
 Get the type from a Type-Encoding string.
 
 @discussion See also:
 https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
 https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html
 
 @param typeEncoding  A Type-Encoding string.
 @return The encoding type.
 */
FYEncodingType FYEncodingGetType(const char *typeEncoding);


#pragma mark - Property

@interface ModelClassProperty : NSObject
@property (nonatomic, assign, readonly) objc_objectptr_t property;
@property (nonatomic, strong, readonly) NSString *name;                             // 属性名字
@property (nonatomic, assign, readonly) FYEncodingType type;                        //
@property (nonatomic, strong, readonly) NSString *typeEncoding;                     // @"NSString"
@property (nonatomic, strong, readonly) NSString *ivarName;                         // ivar名字 _name
@property (nonatomic, assign, readonly, nullable) Class cls;
@property (nonatomic, strong, readonly, nullable) NSArray<NSString *> *protocols;
@property (nonatomic, assign, readonly) SEL getter;
@property (nonatomic, assign, readonly) SEL setter;

- (instancetype)initWithProperty:(objc_property_t)property;
@end


#pragma mark - Ivar

@interface ModelClassIvar : NSObject
@property (nonatomic, assign, readonly) Ivar ivar;              /// ivar opaque struct
@property (nonatomic, strong, readonly) NSString *name;         /// Ivar's name
@property (nonatomic, assign, readonly) ptrdiff_t offset;       /// Ivar's offset
@property (nonatomic, strong, readonly) NSString *typeEncoding; /// Ivar's type encoding
@property (nonatomic, assign, readonly) FYEncodingType type;    /// Ivar's type

- (instancetype)initWithIvar:(Ivar)ivar;
@end


#pragma mark - Method

@interface ModelClassMethod : NSObject
@property (nonatomic, assign, readonly) Method method;                  /// method opaque struct
@property (nonatomic, strong, readonly) NSString *name;                 /// method name
@property (nonatomic, assign, readonly) SEL sel;                        /// method's selector
@property (nonatomic, assign, readonly) IMP imp;                        /// method's implementation
@property (nonatomic, strong, readonly) NSString *typeEncoding;         /// method's parameter and return types
@property (nonatomic, strong, readonly) NSString *returnTypeEncoding;   /// return value's type
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *argumentTypeEncodings; /// array of arguments' type

- (instancetype)initWithMethod:(Method)method;
@end


#pragma mark - Class

@interface ModelClassInfo : NSObject
@property (nonatomic, assign, readonly) Class cls; /// class object
@property (nullable, nonatomic, assign, readonly) Class superCls; /// super class object
@property (nullable, nonatomic, assign, readonly) Class metaCls;  /// class's meta class object
@property (nonatomic, readonly) BOOL isMeta; /// whether this class is meta class
@property (nonatomic, strong, readonly) NSString *name; /// class name
@property (nullable, nonatomic, strong, readonly) ModelClassInfo *superClassInfo; /// super class's class info
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, ModelClassIvar *> *ivarInfos; /// ivars
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, ModelClassMethod *> *methodInfos; /// methods
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, ModelClassProperty *> *propertyInfos; /// properties

- (void)setNeedUpdate;
- (BOOL)needUpdate;
+ (nullable instancetype)classInfoWithClass:(Class)cls;
+ (nullable instancetype)classInfoWithClassName:(NSString *)className;

@end

NS_ASSUME_NONNULL_END
