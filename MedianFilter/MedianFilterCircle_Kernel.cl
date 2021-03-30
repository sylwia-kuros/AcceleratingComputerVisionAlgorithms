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

__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE; 

__kernel void sobel_filter(__read_only image2d_t inputImage, __write_only image2d_t outputImage)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	//int kernelSize = 2; // radius = 2
	//int kernelSize = 3; // radius = 3
	int kernelSize = 4; // radius = 4

	int k = 0;
	float r_2 = kernelSize * kernelSize;

	//int area = 13; // for kernelSize = 2
	//int area = 29; // for kernelSize = 3
	int area = 51; // for kernelSize = 4

	float3 weights = (float3)(0.2989, 0.5870, 0.1140);

	// float tab[13]; // for kernelSize = 2
	//float tab[29]; // for kernelSize = 3
	float tab[51]; // for kernelSize = 4

	float4 pixel;
	float px;

	int ii, jj;
	float temp;

	for(int i = 0; i <= kernelSize * 2; ++i){
		for (int j = 0; j <= kernelSize * 2; ++j){
			if((i-kernelSize-1)*(i-kernelSize-1)+(j-kernelSize-1)*(j-kernelSize-1)<=r_2)
			{
				pixel = convert_float4(read_imageui(inputImage, imageSampler, (int2)(coord.x + i, coord.y + j)));
				px = dot(pixel.xyz, weights);
				tab[k] = px;
				k++;
			}
		}
	}
	
	for (ii = 0; ii<area; ii++){
		for (jj=0; jj<area-1-ii; jj++){
			if (tab[jj] > tab[jj+1]){
				temp = tab[jj+1];
				tab[jj+1] = tab[jj];
				tab[jj] = temp;
			}
		}
        }

	float median_px = tab[(sizeof(tab)/sizeof(tab[0]))/2];

	write_imageui(outputImage, coord, (uint4)(median_px, median_px, median_px, 0.));
}



