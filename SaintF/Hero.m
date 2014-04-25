//
//  Hero.m
//  SaintF
//
//  Created by Eliphas on 23.04.14.
//  Copyright (c) 2014 Eliphas. All rights reserved.
//

#import "Hero.h"

static Hero* _sharedHero;

@implementation Hero

-(id)init{
    if(self = [super init])
    {
        
    }
    return self;
}

-(void)loadContent {
    
}

+(Hero*) sharedHero {
    if(!_sharedHero)
    {
        _sharedHero = [[Hero alloc] init];
    }
    return _sharedHero;
}

@end
