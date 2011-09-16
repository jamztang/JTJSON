//
//  JTJSONTests.m
//  JTJSONTests
//
//  Created by james on 9/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JTJSONTests.h"

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

- (void)testPrintJSONFromFile {
    NSError *error= nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sample.json" ofType:nil];
    
    NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    STAssertNotNil(string, nil, nil);
    NSString *dictString = nil;
    dictString = [string stringByReplacingOccurrencesOfString:@":" withString:@"="];
    dictString = [dictString stringByReplacingOccurrencesOfString:@"," withString:@";"];
    dictString = [dictString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    STAssertNotNil(dictString, nil, nil);
    NSLog(@"%@", dictString);
    NSData *data = [dictString dataUsingEncoding:NSUTF8StringEncoding];
    STAssertNotNil(data, nil, nil);
    
    NSDictionary *d = [NSPropertyListSerialization propertyListWithData:data 
                                                                options:NSPropertyListImmutable
                                                                 format:NULL
                                                                  error:NULL];
    STAssertEqualObjects(d, self.dict, nil, nil);
}

@end
