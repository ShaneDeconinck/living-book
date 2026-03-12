#\!/bin/bash
set -e

# Load API key
source /opt/living-book/.env

cd /opt/living-book

# Pull latest blog source for reference
cd /opt/blog-source && git pull && cd /opt/living-book

# Run Ghosty
echo "$(date): Ghosty session starting" >> /opt/living-book/sessions.log
claude -p "Read the current state of the book, assess what needs work, and improve it. Check /opt/blog-source for Shane's existing content. Search the web for recent developments. Log your reasoning in src/log.md before making changes." --allowedTools "Read,Write,Edit,Glob,Grep,Bash,WebSearch,WebFetch" 2>&1 | tee -a /opt/living-book/sessions.log
echo "$(date): Ghosty session complete" >> /opt/living-book/sessions.log
