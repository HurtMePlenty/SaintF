//
//  BackgroundLayer.h
//  SaintF
//
//  Created by Alexey Semenov on 29/04/14.
//  Copyright 2014 Eliphas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum {
    bush,
    klen,
    oak,
    platan,
    yasen
    
} BackgroundObjects;

@interface BackgroundLayer : CCLayerColor {
    
}

-(void) scrollBackgroundFor:(float)length;
+(BackgroundLayer*) sharedBGLayer;


@end
