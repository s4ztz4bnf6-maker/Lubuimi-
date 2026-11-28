# SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import pathlib, socket, sys, ipaddress
def validate(rows):
    seen=set()
    for address,port in rows:
        if port in (5900,6080):
            if not ipaddress.ip_address(address).is_loopback:
                raise ValueError("Non-loopback private listener")
            seen.add(port)
    if seen != {5900,6080}:
        raise ValueError("Missing private listener")
def read():
    for file,family in (("tcp",socket.AF_INET),("tcp6",socket.AF_INET6)):
        for line in pathlib.Path("/proc/net/"+file).read_text().splitlines()[1:]:
            fields=line.split()
            if fields[3]!="0A": continue
            addr,port=fields[1].split(":")
            raw=bytes.fromhex(addr)
            if sys.byteorder=="little":
                raw=b"".join(raw[i:i+4][::-1] for i in range(0,len(raw),4))
            yield socket.inet_ntop(family,raw),int(port,16)
if "--self-test" in sys.argv:
    validate([("127.0.0.1",5900),("127.0.0.1",6080)])
    for bad in ("0.0.0.0","::","192.0.2.1"):
        try: validate([(bad,5900),("127.0.0.1",6080)])
        except ValueError: continue
        raise AssertionError("Unsafe listener accepted")
else:
    validate(read())
