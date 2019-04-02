//
//  VoiceCurveView.h
//  KYVoiceCurve
//
//  Created by Kitten Yang on 4/6/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface VoiceCurveView : UIView


-(id)initWithFrame:(CGRect)frame superView:(UIView *)superView;
-(void)present;
-(void)dismiss;
@end
