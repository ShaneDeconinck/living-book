#\!/bin/bash
set -e
cd /opt/living-book

# Pull latest sources
cd /opt/blog-source && git pull --ff-only 2>/dev/null || true
cd /opt/trustedagentic && git pull --ff-only 2>/dev/null || true
cd /opt/living-book && git pull --ff-only 2>/dev/null || true

# Run Ghosty
echo "$(date -u +%Y-%m-%dT%H:%M:%SZ): session start" >> /opt/living-book/sessions.log
claude -p "Start a new session. Follow your CLAUDE.md instructions." \
  --max-turns 30 \
  --allowedTools "Read,Write,Edit,Glob,Grep,Bash(git *),Bash(mdbook *),WebSearch,WebFetch" \
  2>&1 | tee -a /opt/living-book/sessions.log
echo "$(date -u +%Y-%m-%dT%H:%M:%SZ): session end" >> /opt/living-book/sessions.log
