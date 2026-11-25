# SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import os, ssl, smtplib, imaplib, email
from email.message import EmailMessage
from email import policy

def config():
    return (os.environ["PROTON_USER"], os.environ["PROTON_BRIDGE_PASS"],
            ssl.create_default_context(cafile=os.environ["PROTON_BRIDGE_CERT"]))

def unread_messages(limit=20):
    user, password, ctx = config()
    with imaplib.IMAP4("127.0.0.1", 1143, timeout=20) as mb:
        mb.starttls(ctx)
        mb.login(user, password)
        mb.select("INBOX", readonly=True)
        status, data = mb.uid("search", None, "UNSEEN")
        if status != "OK":
            raise RuntimeError("mail search failed")
        for uid in data[0].split()[-min(max(limit,1),100):]:
            status, parts = mb.uid("fetch", uid, "(BODY.PEEK[])")
            if status != "OK":
                continue
            for part in parts:
                if isinstance(part, tuple):
                    msg = email.message_from_bytes(part[1], policy=policy.default)
                    body = msg.get_body(preferencelist=("plain",))
                    yield {"uid":uid.decode(),"sender":str(msg["From"]),"subject":str(msg["Subject"]),"text":body.get_content()[:15000] if body else ""}
def send_message(recipient, subject, body, authorize):
    if authorize(recipient, subject, body) is not True:
        raise PermissionError("mail send not authorized")
    user, password, ctx = config()
    msg = EmailMessage()
    msg["From"], msg["To"], msg["Subject"] = user, recipient, subject
    msg.set_content(body)
    with smtplib.SMTP("127.0.0.1", 1025, timeout=20) as smtp:
        smtp.starttls(context=ctx)
        smtp.login(user, password)
        return smtp.send_message(msg)
