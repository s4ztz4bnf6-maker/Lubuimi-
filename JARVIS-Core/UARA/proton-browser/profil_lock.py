# SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import fcntl, os
PROFIL="/data/proton-profil"
_lock=None
def profil_sperren():
    global _lock
    _lock=open("/data/proton-profil.lock","a")
    fcntl.flock(_lock,fcntl.LOCK_EX|fcntl.LOCK_NB)
    for pid in os.listdir("/proc"):
        if not pid.isdigit():
            continue
        try:
            with open(f"/proc/{pid}/cmdline","rb") as f:
                args=f.read().split(b"\0")
        except FileNotFoundError:
            continue
        if ("--user-data-dir="+PROFIL).encode() in args:
            raise RuntimeError("Browser profile already in use")
    # Preserve Chromium locks across containers; local process visibility is not proof of global exclusivity.

    if os.environ.get("EXCLUSIVE_PROFILE_RECOVERY") == "1":
        for name in ("SingletonLock","SingletonCookie","SingletonSocket"):
            target=os.path.join(PROFIL,name)
            if os.path.islink(target):
                os.unlink(target)
            elif os.path.lexists(target):
                raise RuntimeError("Unexpected Chromium lock type; manual review required")
