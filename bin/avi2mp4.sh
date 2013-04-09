#!/bin/bash
ffmpeg -i $1 -y -an -pass 1 -vcodec libx264 -threads 4 -b 1024kbps -flags +loop -cmp +chroma -partitions +parti4x4+partp8x8+partb8x8 -me epzs -subq 1 -trellis 0 -refs 1 -bf 3 -b_strategy 1 -coder 1 -me_range 16 -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -rc_eq 'blurCplx^(1-qComp)' -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 $2

ffmpeg -i $1 -y -acodec libfaac -ab 128k -pass 2 -vcodec libx264 -threads 4 -b 1024kbps -flags +loop -cmp +chroma -partitions +parti4x4+partp8x8+partb8x8 -flags2 +mixed_refs -me umh -subq 5 -trellis 1 -refs 5 -bf 3 -b_strategy 1 -coder 1 -me_range 16 -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -rc_eq 'blurCplx^(1-qComp)' -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 $2

