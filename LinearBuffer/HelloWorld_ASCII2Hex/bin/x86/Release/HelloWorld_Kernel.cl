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
__kernel void helloworld(__global char* in, __global char* out)
{
	int num = get_global_id(0);

	char temp_ar[8] = "00000000";
	
	switch(in[num])
	{
       		case 48:
				break;
       		case 49: 
				temp_ar[7] = 49;
				break;
       		case 50: 
				temp_ar[6] = 49;
				break;
       		case 51: 
				temp_ar[7] = 49;
				temp_ar[6] = 49;
				break;
       		case 52: 
				temp_ar[5] = 49;
				break;
       		case 53: 
				temp_ar[5] = 49;
				temp_ar[7] = 49;
				break;
       		case 54: 
				temp_ar[6] = 49;
				temp_ar[7] = 49;
				break;
       		case 55: 
				temp_ar[5] = 49;
				temp_ar[6] = 49;
				temp_ar[7] = 49;
				break;
       		case 56: 
				temp_ar[4] = 49;
				break;
       		case 57: 
				temp_ar[4] = 49;
				temp_ar[7] = 49;
				break;
       		case 65:
			case 97: 
				temp_ar[4] = 49;
				temp_ar[6] = 49;
				break;
       		case 66:
			case 98: 
				temp_ar[4] = 49;
				temp_ar[6] = 49;
				temp_ar[7] = 49;
				break;
       		case 67:
			case 99:
				temp_ar[4] = 49;
				temp_ar[5] = 49;
				break;
       		case 68:
			case 100: 
				temp_ar[4] = 49;
				temp_ar[5] = 49;
				temp_ar[7] = 49;
				break;
       		case 69:
			case 101: 
				temp_ar[4] = 49;
				temp_ar[5] = 49;
				temp_ar[6] = 49;
				break;
        	case 70:
			case 102: 
				temp_ar[4] = 49;
				temp_ar[5] = 49;
				temp_ar[6] = 49;
				temp_ar[7] = 49;
				break;
			default:
				for (int a=0; a<8; a++){
					temp_ar[a] = 193;
				}
	}
	
	for (int j = 0; j <= 7; j++)
	{
		out[8*num + j] = temp_ar[j];
	}
}