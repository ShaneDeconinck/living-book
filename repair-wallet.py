#!/usr/bin/env python3
"""Repair sapere-aude TSP wallet: re-verify own DID after UnverifiedVid corruption."""
import json
import tsp_python as tsp

CONFIG = json.load(open('/opt/tsp-config.json'))
sa_cfg = CONFIG['agents']['sapere-aude']
sa_did = sa_cfg['did']
chop_did = CONFIG['agents']['chop-pop']['did']
wallet_path = sa_cfg['wallet']

print(f"Opening wallet: {wallet_path}")
store = tsp.SecureStore(wallet_url=f"sqlite://{wallet_path}")

# Test current state
print("Testing seal_message before repair...")
try:
    url, sealed = store.seal_message(sa_did, chop_did, b"test")
    print("OK - no repair needed")
except Exception as e:
    print(f"Failed: {e}")
    print("Attempting repair: verify_vid for own DID...")
    try:
        endpoint = store.verify_vid(sa_did)
        print(f"verify_vid succeeded: {endpoint}")
    except Exception as e2:
        print(f"verify_vid failed: {e2}")

    # Test again
    print("Testing seal_message after repair...")
    try:
        url, sealed = store.seal_message(sa_did, chop_did, b"test")
        print("OK - repair succeeded!")
    except Exception as e3:
        print(f"Still failing: {e3}")
        print("Repair unsuccessful. Manual wallet reconstruction may be needed.")
