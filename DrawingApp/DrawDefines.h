//
//  DrawDefines.h
//  DrawingApp
//
//  Created by Maxim on 5/9/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#ifndef DrawingApp_DrawDefines_h
#define DrawingApp_DrawDefines_h

NS_ENUM(NSInteger, DRAW_INSTRUMENT_TYPE)
{
    DRAW_INSTRUMENT_TYPE_SELECTION = 1,
    DRAW_INSTRUMENT_TYPE_DRAWING_OBJECT = 2,
    DRAW_INSTRUMENT_TYPE_FILL=3,
};

NS_ENUM(NSInteger, DRAWING_OBJECT_TYPE)
{
    DRAWING_OBJECT_TYPE_FREE=1,
    DRAWING_OBJECT_TYPE_LINE=2,
    DRAWING_OBJECT_TYPE_RECTANGLE=3,
    DRAWING_OBJECT_TYPE_OVAL=4
};

#define MIN_LINE_WIDTH 1
#define MAX_LINE_WIDTH 100

#endif
