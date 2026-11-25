# SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import fcntl
PROFIL="/data/proton-profil"
_lock=None
def profil_sperren():
    global _lock
    _lock=open("/data/proton-profil.lock","a")
    fcntl.flock(_lock,fcntl.LOCK_EX|fcntl.LOCK_NB)
