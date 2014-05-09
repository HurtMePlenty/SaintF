//
//  Creep.h
//  SaintF
//
//  Created by Alexey Semenov on 02/05/14.
//  Copyright 2014 Eliphas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BGObjectInfo.h"

typedef enum {
    raven,
    paulin
} creepTypes;

@interface Creep : CCNode {
    
}

+(Creep*) spawnCreepWithType: (creepTypes) type spawnPos: (CGPoint)spawnPos;

@end
