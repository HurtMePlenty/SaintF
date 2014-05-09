//
//  Creep.m
//  SaintF
//
//  Created by Alexey Semenov on 02/05/14.
//  Copyright 2014 Eliphas. All rights reserved.
//

#import "Creep.h"

@interface Creep() {
    creepTypes creepType;
}

@end

@implementation Creep

-(id) initWithType: (creepTypes) type {
    if(self = [super init])
    {
        creepType = type;
    }
    return self;
}

-(void) spawnAtPosition: (CGPoint)spawnPos {
    
}

+(Creep*) spawnCreepWithType: (creepTypes)type spawnPos: (CGPoint)spawnPos {
    Creep* creep = [[Creep alloc] initWithType:type];
    return creep;
}

@end
