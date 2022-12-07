//
//  main.m
//  ocProgram
//
//  Created by lymos on 2022/12/4.
//

#import <Foundation/Foundation.h>
#import "demo.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
    }
    NSString *str = @"9898";
    NSLog(@"this is a str %@", str);
    
    demo *de = [demo new];
    [de setName:str];
    NSLog(@"this is a new str: %@", de->_name);
    
    return 0;
}
