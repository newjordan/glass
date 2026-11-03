#!/usr/bin/env python3
"""Coverage only: reconstruct the unchanged tput Unicode payload, not a timer."""
from collections import Counter
import hashlib
import json
from pathlib import Path

source = Path('bench/tput.py').read_text()
start = source.index('rng = random.Random(7)')
end = source.index('def sgr_line():')
namespace = {'cols': 154, 'rows': 39}
exec('import random\n' + source[start:end], namespace)
payload = namespace['W']['unicode']
spans, length = [], 0
for byte in payload:
    if 0x20 <= byte <= 0x7e:
        length += 1
    else:
        if length:
            spans.append(length)
        length = 0
if length:
    spans.append(length)
result = {
    'payload_sha256': hashlib.sha256(payload).hexdigest(),
    'bytes': len(payload), 'scalars': len(payload.decode()),
    'ascii_bytes': sum(spans), 'ascii_span_count': len(spans),
    'ascii_span_histogram': dict(sorted(Counter(spans).items())),
    'eligible_ascii_bytes': {str(k): sum(n for n in spans if n >= k) for k in (2, 4, 8, 16)},
}
print(json.dumps(result, indent=2))
