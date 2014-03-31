#!/bin/bash


/Applications/ffmpegX_0.0.9y/bin/mencoder -nosound mf://*.jpg -mf w=800:h=371:type=jpg:fps=15 -ovc lavc -lavcopts vcodec=mpeg4:vbitrate=2160000:mbd=2:keyint=132:v4mv:vqmin=3:lumi_mask=0.07:dark_mask=0.2:mpeg_quant:scplx_mask=0.1:tcplx_mask=0.1:naq -o time_lapse-test.avi
