#!/usr/bin/env python3

bm = objreg.get('bookmark-manager')
bm.marks.clear()
bm._lineparser._read()
for line in bm._lineparser:
    if not line.strip():
        continue
    bm._parse_line(line)

qm = objreg.get('quickmark-manager')
qm.marks.clear()
qm._lineparser._read()
for line in qm._lineparser:
    if not line.strip():
        continue
    qm._parse_line(line)
