/**********************************************************************
Copyright ©2014 Advanced Micro Devices, Inc. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

•	Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
•	Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or
 other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
 OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
********************************************************************/

__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP_TO_EDGE; 
__kernel void sobel_filter(__read_only image2d_t inputImage, __write_only image2d_t outputImage)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int kernel_size = 5;
	float threshold = 90.;
	float3 weights = (float3)(0.2989, 0.5870, 0.1140);
	float4 pixel_value;
	float minval = 0.;
	float maxval = 255.;	

	float4 extreme_pixel_value = convert_float4(read_imageui(inputImage, imageSampler, (int2)(coord.x, coord.y)));
	
	extreme_pixel_value = dot(extreme_pixel_value.xyz, weights);
	extreme_pixel_value = 255 * step(threshold, extreme_pixel_value);

	for(int i = -kernel_size/2; i <= kernel_size/2; ++i)
	{
		for (int j = -kernel_size/2; j <= kernel_size/2; ++j)
		{
			// for circle with radius 5
			if ( (i != -2 && j != -2) || (i != -2 && j != -1) || (i != -2 && j != 1) || (i != -2 && j != 2) || (i != -1 && j != -2) || (i != -1 && j != 2) || (i != 1 && j != -2) || (i != 1 && j != 2) || (i != 2 && j != -2) || (i != 2 && j != -1) || (i != 2 && j != 1) || (i != 2 && j != 2))
			{
				pixel_value = convert_float4(read_imageui(inputImage, imageSampler, (int2)(coord.x + i, coord.y + j)));
				extreme_pixel_value = dot(extreme_pixel_value.xyz, weights);
				pixel_value = 255 * step(threshold, pixel_value);
				extreme_pixel_value = max(extreme_pixel_value, pixel_value.x);
			}
		
		}
	}
	write_imagef(outputImage, coord, (float4)(extreme_pixel_value));
}



