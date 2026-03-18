#!/usr/bin/env python3
"""Decrypt a specific TSP message for ghosty."""
import json, base64, sys

def b64url_decode(s):
    s = s.replace('-', '+').replace('_', '/')
    s += '=' * (4 - len(s) % 4)
    return base64.b64decode(s)

def try_decrypt(tsp_file, sender_piv_file, receiver_piv_file):
    try:
        from nacl.public import PrivateKey, PublicKey, Box
        from nacl.signing import VerifyKey

        tsp = json.load(open(tsp_file))
        sender_piv = json.load(open(sender_piv_file))
        receiver_piv = json.load(open(receiver_piv_file))

        sender_pub_enc = b64url_decode(sender_piv['publicEnckey'])
        sender_pub_sig = b64url_decode(sender_piv['publicSigkey'])
        receiver_enc_key = b64url_decode(receiver_piv['enckey'])

        encrypted = base64.b64decode(tsp['encrypted'])
        signature = base64.b64decode(tsp['signature'])

        receiver_private = PrivateKey(receiver_enc_key)
        sender_public = PublicKey(sender_pub_enc)
        box = Box(receiver_private, sender_public)
        decrypted = box.decrypt(encrypted)

        verify_key = VerifyKey(sender_pub_sig)
        verify_key.verify(decrypted, signature)

        envelope = json.loads(decrypted.decode('utf-8'))
        try:
            payload = json.loads(envelope.get('payload', '{}'))
        except Exception:
            payload = {'message': envelope.get('payload', '')}
        return {'verified': True, 'payload': payload}
    except Exception as e:
        return {'verified': False, 'error': str(e)}

if len(sys.argv) < 4:
    print("Usage: decrypt_tsp.py <tsp_file> <sender_piv> <receiver_piv>")
    sys.exit(1)

result = try_decrypt(sys.argv[1], sys.argv[2], sys.argv[3])
print(json.dumps(result, indent=2))
