#!/bin/bash
while true; do
    # Check for pause file
    if [ -f /opt/living-book/PAUSED ]; then
        echo "$(date -u +%Y-%m-%dT%H:%M:%SZ): paused, waiting..."
        sleep 60
        continue
    fi

    cd /opt/blog-source && git pull --ff-only 2>/dev/null || true
    cd /opt/trustedagentic && git pull --ff-only 2>/dev/null || true
    cd /opt/living-book && git pull --ff-only 2>/dev/null || true

    SESSION=$(date -u +%Y%m%d-%H%M%S)
    echo "$(date -u +%Y-%m-%dT%H:%M:%SZ): session $SESSION start"

    claude -p "Start a new session. Read soul.md first, then follow your CLAUDE.md instructions."         --allowedTools "Read,Write,Edit,Glob,Grep,Bash(git *),Bash(mdbook *),WebSearch,WebFetch"         --output-format json         2>&1 | tee /opt/living-book/session-${SESSION}.log

    # Send reasoning via TSP
    REASONING=$(tail -50 /opt/living-book/src/log.md 2>/dev/null)
    if [ -n "$REASONING" ]; then
        echo "$REASONING" | /opt/tsp/target/release/tsp send --sender-vid ghosty --receiver-vid server 2>/dev/null || true
    fi

    echo "$(date -u +%Y-%m-%dT%H:%M:%SZ): session $SESSION end, sleeping 60s"
    sleep 60
done
