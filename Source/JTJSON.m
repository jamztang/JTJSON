//
//  JTJSON.m
//  JTJSON
//
//  Created by James Tang on 19/09/2011.
//  Copyright 2011 CUHK. All rights reserved.
//

#import "JTJSON.h"

NSString *PListStringAppendMissingSemiColonFromJSONString(NSString *JSONString) {
    NSError *error = nil;
    NSMutableString *original = [NSMutableString stringWithString:JSONString];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([}0-9\"])([\n\t ]*)[}]" options:NSRegularExpressionCaseInsensitive error:&error];
    
    [regex replaceMatchesInString:original options:NSMatchingReportProgress range:NSMakeRange(0, [original length]) withTemplate:@"$1;$2}"];

    // Needed to replace the second time
    [regex replaceMatchesInString:original options:NSMatchingReportProgress range:NSMakeRange(0, [original length]) withTemplate:@"$1;$2}"];
    
    return original;
}

NSString *PListStringFromJSONString(NSString *JSONString) {
    NSString *resultString = nil;
    
    // PList requires semi colons after brace --- e.g.
    // {
    //   value1 = { subvalue1 = subvalue2 };
    // }
    resultString = PListStringAppendMissingSemiColonFromJSONString(JSONString);

    // PList used "=" instead of ":"
    resultString = [resultString stringByReplacingOccurrencesOfString:@":" withString:@"="];

    // PList used ";" instead of ","
    resultString = [resultString stringByReplacingOccurrencesOfString:@"," withString:@";"];

    // PList doesn't use " for string values, remove them
    resultString = [resultString stringByReplacingOccurrencesOfString:@"\"" withString:@""];

    return resultString;
}

@implementation JTJSON

@end
