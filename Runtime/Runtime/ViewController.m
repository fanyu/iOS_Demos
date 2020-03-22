//
//  ViewController.m
//  Runtime
//
//  Created by Yu Fan on 2019/5/21.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "ViewController.h"
#import "objc/message.h"
#import "NSObject+Model.h"


@interface PersonInfo : NSObject
@property (nonatomic, strong) NSString *gender;
@end

@implementation PersonInfo
@end

@protocol House;
@interface House : NSObject
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *city;
@end

@implementation House
@end


@interface Person : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) PersonInfo *info;
@property (nonatomic, strong) NSArray<House> *houses;
@end

@implementation Person

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"==== %@", NSStringFromClass([self class]));
        NSLog(@"==== %@", NSStringFromClass([super class]));
    }
    return self;
}

+ (NSDictionary *)keyMapper {
    return @{
             @"name" : @"original_name"
             };
}

@end



@interface TestObjcect : NSObject {
    CGFloat distance;
    BOOL flag;
}
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;
@end

@implementation TestObjcect
@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(100, 100, 100, 50);
    [btn setTitle:@"reload" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(testModel) forControlEvents:UIControlEventTouchUpInside];
    
    [self getIvar];
    [self getProperty];
    [self getMethodList];
    //[self testModel];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [pageControl setValue:[UIImage imageNamed:@"home_slipt_nor"] forKeyPath:@"_pageImage"];
    [pageControl setValue:[UIImage imageNamed:@"home_slipt_pre"] forKeyPath:@"_currentPageImage"];
}

- (void)getIvar {
    unsigned int outCount = 0;
    Ivar * ivars = class_copyIvarList([TestObjcect class], &outCount);
    for (unsigned int i = 0; i < outCount; i ++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        const char * type = ivar_getTypeEncoding(ivar);
        NSLog(@"Ivar类型为 %s 的 %s ",type, name);
    }
    free(ivars);
}

- (void)getProperty {
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList([TestObjcect class], &outCount);
    for (unsigned int i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        //属性名
        const char * name = property_getName(property);
        //属性描述
        const char * propertyAttr = property_getAttributes(property);
        NSLog(@"Property属性为 %s 的 %s ", propertyAttr, name);
        //属性的特性
        unsigned int attrCount = 0;
        objc_property_attribute_t * attrs = property_copyAttributeList(property, &attrCount);
        for (unsigned int j = 0; j < attrCount; j ++) {
            objc_property_attribute_t attr = attrs[j];
            const char * name = attr.name;
            const char * value = attr.value;
            NSLog(@"%s 值：%s", name, value);
        }
        free(attrs);
        NSLog(@"\n");
    }
    free(properties);
}

- (void)getMethodList {
    unsigned int count = 0;
    //获取方法列表
    Method *methodList = class_copyMethodList([TestObjcect class], &count);
    for (NSInteger i = 0; i < count; i++) {
        //
        Method method = methodList[i];
        SEL sel = method_getName(method);
        NSString *methodName = [NSString stringWithUTF8String:sel_getName(sel)];
        
        //返回值类型
        char *dst = method_copyReturnType(method);
        
        NSLog(@"methodName:%@- retunType:%@",methodName,[NSString stringWithUTF8String:dst]);
    }
}

- (void)getProtocolList {
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i = 0; i<count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
    }
}

- (void)testModel {
    NSDictionary *dict = @{
                           @"original_name" : @"jhon",
                           @"info" : @{
                                        @"gender" : @"male"
                                      },
                           @"titles" : @[@"apple", @"engineer"],
                           @"houses" : @[
                                        @{
                                            @"location" : @"ShenZhen",
                                            @"city" : @"Guang Zhou",
                                         },
                                        @{
                                            @"location" : @"TaiYuan",
                                            @"city" : @"Shan Xi",
                                          },
                                       ],
                           };
    
    Person *person = [Person modelWithDict:dict];
    NSLog(@"person %@", person);
}

@end




@interface Student: NSObject {
    // 成员变量 私有属性
    NSString *_name;
}
// 属性 = iavr(_age) + getter + setter
@property (nonatomic, strong) NSString *age;
@end

@implementation Student

- (void)test {
    // 属性 通过 self. 或者 _ 来调用
    self.age = @"11";
    _age = @"22";

    // 成员变量是私有的，不写 setter getter 方法，外界无法访问
    _name = @"edc";
}

#pragma mark - Setter
- (void)setAge:(NSString *)age {
    // 这一步实际上是给成员变量赋值
    _age = age;
}

@end

