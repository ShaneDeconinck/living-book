#\!/bin/bash
set -e
TSP=/opt/tsp/target/release/tsp
cd /opt/living-book

# Pull latest sources
cd /opt/blog-source && git pull --ff-only 2>/dev/null || true
cd /opt/trustedagentic && git pull --ff-only 2>/dev/null || true
cd /opt/living-book && git pull --ff-only 2>/dev/null || true

# Run Ghosty
SESSION=$(date -u +%Y%m%d-%H%M%S)
echo "$(date -u +%Y-%m-%dT%H:%M:%SZ): session $SESSION start" >> /opt/living-book/sessions.log

claude -p "Start a new session. Follow your CLAUDE.md instructions." \
  --allowedTools "Read,Write,Edit,Glob,Grep,Bash(git *),Bash(mdbook *),WebSearch,WebFetch" \
  --output-format json \
  2>&1 | tee /opt/living-book/session-${SESSION}.log >> /opt/living-book/sessions.log

echo "$(date -u +%Y-%m-%dT%H:%M:%SZ): session $SESSION end" >> /opt/living-book/sessions.log

# Extract reasoning from log and send via TSP
REASONING=$(cat /opt/living-book/src/log.md | tail -50)
if [ -n "$REASONING" ]; then
    echo "$REASONING" | $TSP send --sender-vid ghosty --receiver-vid server 2>/dev/null || true
fi
