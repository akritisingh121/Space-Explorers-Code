//
//  RainbowStar.m
//  newestspacetraveler
//
//  Created by Akriti Singh on 9/2/14.
//
//

#import "RainbowStar.h"

CCDirector *director;


@implementation RainbowStar


-(id) init{
    director = [CCDirector sharedDirector];
    self.sprite = [CCSprite spriteWithFile:@"rainbowreal.png"];//load star from file
    
    self.sprite.position = CGPointMake(arc4random() % (int)director.screenSize.width,
                                       arc4random() % (int)director.screenSize.height*0.77 + (int)director.screenSize.height*0.1);
    self.sprite.scale = 0.21f;
    self.speed = -10;
    return self;
}

-(void) update{
    if (self.sprite.position.x < 0){
        [self reset];
    }
    if(CGRectIntersectsRect([self.sprite boundingBox], [self.ship boundingBox])){
        [self reset];
    }
    
    self.sprite.position = CGPointMake(self.sprite.position.x + self.speed,
                                       self.sprite.position.y);
}

-(void) reset{
    self.sprite.position = CGPointMake(director.screenSize.width,
                                       arc4random() % (int)director.screenSize.height*0.77 + (int)director.screenSize.height*0.1);
}

-(void) replay{
    self.speed = -4;
}

-(void) pause{
    self.speed = 0;
}

@end
