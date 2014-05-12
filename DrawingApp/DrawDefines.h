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
    DRAW_INSTRUMENT_TYPE_SELECTION,
    DRAW_INSTRUMENT_TYPE_DRAWING_OBJECT,
    DRAW_INSTRUMENT_TYPE_FILL,
};

NS_ENUM(NSInteger, DRAWING_OBJECT_TYPE)
{
    DRAWING_OBJECT_TYPE_FREE,
    DRAWING_OBJECT_TYPE_LINE,
    DRAWING_OBJECT_TYPE_RECTANGLE,
    DRAWING_OBJECT_TYPE_OVAL
};

#endif
