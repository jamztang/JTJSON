//
//  JTJSONTests.m
//  JTJSONTests
//
//  Created by james on 9/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JTJSONTests.h"
#import "JTJSON.h"

NSString *SemiColonAppends(NSString *JSONString);

@implementation JTJSONTests

@synthesize dict;

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sample.plist" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    self.dict = [NSPropertyListSerialization propertyListWithData:data 
                                                          options:NSPropertyListImmutable
                                                           format:NULL
                                                            error:NULL];
    STAssertNotNil(self.dict, nil, nil);
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
    self.dict = nil;
}

- (void)testStringsFileWithNSPropertyListSerialization {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sample.text" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    STAssertNotNil(data, nil, nil);
    
    NSDictionary *d = [NSPropertyListSerialization propertyListWithData:data 
                                                                options:NSPropertyListImmutable
                                                                 format:NULL
                                                                  error:NULL];
    STAssertEqualObjects(d, self.dict, nil, nil);
}

- (void)testStringsFileWithStringPropertyList {
    NSError *error= nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sample.text" ofType:nil];
    NSStringEncoding usedEncoding;
    NSString *string = [NSString stringWithContentsOfFile:path usedEncoding:&usedEncoding error:&error];
    
    STAssertNil(error, @"%@", error);
    STAssertNotNil(string, nil, nil);
    
    NSDictionary *d = [string propertyList];
    STAssertEqualObjects(d, self.dict, nil, nil);
}

//
//NSString *SemiColonAppends(NSString *JSONString) {
//    NSError *error = nil;
//    NSMutableString *original = [NSMutableString stringWithString:JSONString];
//    
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(.*\")([\n\t ]*)[}]" options:NSRegularExpressionCaseInsensitive error:&error];
//    
//    [regex replaceMatchesInString:original options:NSMatchingReportProgress range:NSMakeRange(0, [original length]) withTemplate:@"$1,$2}"];
//    
//    return original;
//}

- (void)testPrintJSONFromFile {
    NSError *error= nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sample.json" ofType:nil];
    
    NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    STAssertNotNil(string, nil, nil);
    NSString *dictString = nil;
//    STAssertNotNil(dictString, nil, nil);
//    dictString = SemiColonAppends(string);
//    NSLog(@"------- 1 %@", dictString);
    dictString = PListStringFromJSONString(string);
    NSLog(@"------- 2 %@", dictString);
    NSData *data = [dictString dataUsingEncoding:NSUTF8StringEncoding];
    STAssertNotNil(data, nil, nil);
    
    NSDictionary *d = [NSPropertyListSerialization propertyListWithData:data 
                                                                options:NSPropertyListImmutable
                                                                 format:NULL
                                                                  error:NULL];
    STAssertEqualObjects(d, self.dict, nil, nil);
}

- (void)testRegularExpression {
    NSString *original = @"{{}\n\t\t}";
    original = PListStringAppendMissingSemiColonFromJSONString(original);
    
    STAssertEqualObjects(original, @"{{};\n\t\t}", nil, nil);
    
    original = @"aa\"\n\t\t}";
    original = PListStringAppendMissingSemiColonFromJSONString(original);
    
    STAssertEqualObjects(original, @"aa\";\n\t\t}", nil, nil);

    original = @"1\n\t\t}";
    original = PListStringAppendMissingSemiColonFromJSONString(original);
    
    STAssertEqualObjects(original, @"1;\n\t\t}", nil, nil);

}

@end
