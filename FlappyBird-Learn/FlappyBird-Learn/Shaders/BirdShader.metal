//
//  BirdShader.metal
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 colorBird(float2 position, half4 color, half4 newColor) {
    return half4(newColor.rgb * color.a, color.a);
}
